Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F6F4CAC3B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 18:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243861AbiCBRh1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 12:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240217AbiCBRh0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:37:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8755C27142
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 09:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Kit1bXsK2uqBEtXBPOa4tKo9ObQrYb4J8U9IRzpYPKI=; b=uDWNRK2+3TFKB/dOq+EENA9aYL
        uTYAjgtTysbYkYt2mCpAj+1oJhW+oSYwSpeo1vRoSv8MswBmY2/3fODqTza9raBJLWwD4OvOj/uCi
        cTDoD/jMIeGBxC183FDrl7obP1Eme9jj5XOD/+idwtuhjckA67wq/xmw15GGbyuy+KcWLs4C/k7tj
        lCYNnU+aF3PsX0It01NgEJAkVxFOa2umRQ7dgP4NCwbbhDQnXm+IKV2VvjWHmQI35ezK4oqt0Eazj
        t7dSLEn3CadWOw+gDycR0Rh57fwidSMOOH8pC5g2mTDSQSBCBZxnJLZLZHNJEuLe+inRM4wyJVCiB
        Vznop3vQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPSu0-00ApQe-Pr; Wed, 02 Mar 2022 17:36:40 +0000
Date:   Wed, 2 Mar 2022 17:36:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/22] fs: Pass an iocb to generic_perform_write()
Message-ID: <Yh+rKDnsuE6ltQgM@casper.infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
 <20220222194820.737755-2-willy@infradead.org>
 <YhXZe+4Z2AfEaJ+v@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhXZe+4Z2AfEaJ+v@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 22, 2022 at 10:51:39PM -0800, Christoph Hellwig wrote:
> > -extern ssize_t generic_perform_write(struct file *, struct iov_iter *, loff_t);
> > +extern ssize_t generic_perform_write(struct kiocb *, struct iov_iter *);
> 
> Please drop the extern and spell out the parameter names while you're at
> it.

I don't mind dropping the 'extern', but I don't see the value in
naming the parameters.  For something like 'int' or 'void *', you need
to know what kind of thing you're dealing with, but if you're passing
one kiocb, calling it 'iocb' gives no extra information.  If you're
passing two, then knowing which is 'src' and which is 'dest' is useful.

> Otherwise looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
