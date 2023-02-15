Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996A5697D71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 14:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBONcC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 08:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjBONcA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:32:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1849EE1;
        Wed, 15 Feb 2023 05:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nWN+pWjg21NtvqIjjXdnfBG7yvMKXq1hd7rXo25Mezw=; b=WSTT7Zk7DtI5HmAmY2ClGKFkum
        289gcUFDcrMYFg/6ZSakpHN8ui4QXXiXYF6p6fs6gTU5fJMpfk4MXIOeB6jGWhZpwFZ8Hhsw6SDy0
        NNctondaIOeZ7LejljxkN1P6i4U6YOFYF+j9n4gUN9RkoCW1Fh5jfJox643Mr6wrhfRi85upk+HEQ
        agSP66/7D9dJYMbenyhM4ngcZdLthSaLroAcidPLQ3jnLT3bwaT3nLa43vmijRIsuzf+2kJOD2Lsn
        7VFGthyw9r1IOcz2c/M3LZk2ClmUOibZ5kCuECjXmuUDwDCY8mDFDOqPav36hIKGYfpi2BpDqbfVK
        WSWHXsJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSHsp-007USf-9y; Wed, 15 Feb 2023 13:31:39 +0000
Date:   Wed, 15 Feb 2023 13:31:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     void0red <void0red@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xa_load() needs a NULL check before locking check
Message-ID: <Y+zeu658Vi7boyxZ@casper.infradead.org>
References: <20230215131417.150170-1-void0red@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215131417.150170-1-void0red@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 15, 2023 at 09:14:17PM +0800, void0red wrote:
>  	folio = xa_load(&ractl->mapping->i_pages, ractl->_index);
> +	if (!folio) {
> +		VM_BUG_ON(!folio);
> +		return NULL;
> +	}
>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);

Why does this need to happen?  The caller has inserted all these folios
into the xarray.  They're locked, so they can't be removed.  If they're
not there, something has gone horribly wrong and crashing is a good
response.

>  	ractl->_batch_count = folio_nr_pages(folio);
>  
> -- 
> 2.34.1
> 
