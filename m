Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615EC740291
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 19:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjF0Rs2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 13:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjF0Rs1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:48:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB472D45;
        Tue, 27 Jun 2023 10:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FkjBSg6uoUaP1660acxrdbQw+ZjRrdzj3qfDG7Xdht8=; b=jJAvpHIdX1oIKrhsbdgIcxAnGx
        64Bxk1WkH7XsMFWOI50daUyx6jeuxLAJ+dEF8WUlPWWfOijShufVqVEvUOgkxt5T+eZQB84x1JW8i
        oHqDgxJVQlfAnRulXAd6GfjutKthoIyX5S7RfUkyl/ve2ocPcJ0r1jwEZ0IIUicgIvxJB1RLWg2rD
        QcYAZV/BOLqmVicpBlizKiBLHwZFctUEPwWnHFFPVRhGHF3fo8Hy36b6ptVAOelzHc2vut6j3ncXI
        vjXHUMBwsvqT7i2zdzzXtC9myd6v+baY4KLA3DlTHj9VLoAeJUYXvekbsvHXnekwhjePvdd6Iu23M
        K1H0r/jA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qECnc-002whb-47; Tue, 27 Jun 2023 17:48:20 +0000
Date:   Tue, 27 Jun 2023 18:48:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sumitra Sharma <sumitraartsy@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Fabio <fmdefrancesco@gmail.com>, Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] fs/vboxsf: Replace kmap() with kmap_local_{page, folio}()
Message-ID: <ZJsg5GL79MIOzbRf@casper.infradead.org>
References: <20230627135115.GA452832@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627135115.GA452832@sumitra.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 06:51:15AM -0700, Sumitra Sharma wrote:
> +++ b/fs/vboxsf/file.c
> @@ -234,7 +234,7 @@ static int vboxsf_read_folio(struct file *file, struct folio *folio)
>  	u8 *buf;
>  	int err;
>  
> -	buf = kmap(page);
> +	buf = kmap_local_folio(folio, off);

Did you test this?  'off' is the offset in the _file_.  Whereas
kmap_local_folio() takes the offset within the _folio_.  They have
different types (loff_t vs size_t) to warn you that they're different
things.

