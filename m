Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290CE51E019
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 22:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442382AbiEFUZx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 16:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349908AbiEFUZv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 16:25:51 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB12864725
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 13:22:07 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so11774364pju.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 May 2022 13:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jRdein4+AD1woEggTWZHx+OFwk34QhmVWW99mDDBG0Q=;
        b=oY36OG0Ejq8nCwZfnzlV1tl++YHNkh99AGhD75P2tKC7eeDo/g78WdxokmTjXcKAYL
         IkmeMJRgR2EFr7odltHX6dB0K2nOoM4Za2xyft88UPbcEnEJMgTnJsYUZ+xRNwKzY/qd
         h96An4pMRs2wATjUzgTVMQgCHm+z9taWp/Ynw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jRdein4+AD1woEggTWZHx+OFwk34QhmVWW99mDDBG0Q=;
        b=kBBI2gFBTqwlXXRZiTtqHtjOLYwBV2PM2x0keiJq3q9GNzuN58RWDyskVxN+J4KSu1
         iVbbdCz8lFg0WK4pA0MFp/xSDmXLo+7rhMGv/6+As5UppnZAqWXznGKnL67IUMKiUHAg
         +ESqN2pRJQ1YNolcL3A04lMK/zZ7lSGHEsPpU1SwdVSbIXVdUA7zgH9APClCrIK0yXzh
         N2Opi6LPkpndynmnmsAAYqtE9FPUUH+G++T4Mlz18q87chdjoLv1FM/pDqPLhyahm/Vc
         MQ1mjUmtG9I1Z5OZN1qwDNQqC/XWEENuaZo/tGHRS7B0NZbb81x+eBoC0G42fgisjVcK
         JTQw==
X-Gm-Message-State: AOAM532iraDJBeQq1lwy4z0rDjehIRYELK7ncPOsram2OglkQz0Srq/4
        EAARdWwVOfcZpQYcn6+WwUsJydtlXjq9kw==
X-Google-Smtp-Source: ABdhPJzHOLjklBHBfeyiKxeh+VlkIzceLCD4kyMZsq6XnKqzMjaCI5tSql8wDNiGq2V39SWq5ddP5g==
X-Received: by 2002:a17:90b:1d90:b0:1dc:2e4b:37c3 with SMTP id pf16-20020a17090b1d9000b001dc2e4b37c3mr6121843pjb.117.1651868527275;
        Fri, 06 May 2022 13:22:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n10-20020a170903404a00b0015e8d4eb1fcsm2111622pla.70.2022.05.06.13.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 13:22:06 -0700 (PDT)
Date:   Fri, 6 May 2022 13:22:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 33/69] fs: Introduce aops->read_folio
Message-ID: <202205061303.23B1BC1@keescook>
References: <20220429172556.3011843-1-willy@infradead.org>
 <20220429172556.3011843-34-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429172556.3011843-34-willy@infradead.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 03, 2022 at 07:42:12AM -0700, Christoph Hellwig wrote:
> On Fri, Apr 29, 2022 at 06:25:20PM +0100, Matthew Wilcox (Oracle) wrote:
> > The ->readpage and ->read_folio operations are always called with the
> > same set of bits; it's only the type which differs.  Use a union to
> > help with the transition and convert all the callers to use ->read_folio.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  fs/buffer.c        |  2 +-
> >  include/linux/fs.h |  5 ++++-
> >  mm/filemap.c       |  6 +++---
> >  mm/readahead.c     | 10 +++++-----
> >  4 files changed, 13 insertions(+), 10 deletions(-)
> > 
> > diff --git a/fs/buffer.c b/fs/buffer.c
> > index 9737e0dbe3ec..5826ef29fe70 100644
> > --- a/fs/buffer.c
> > +++ b/fs/buffer.c
> > @@ -2824,7 +2824,7 @@ int nobh_truncate_page(struct address_space *mapping,
> >  
> >  	/* Ok, it's mapped. Make sure it's up-to-date */
> >  	if (!folio_test_uptodate(folio)) {
> > -		err = mapping->a_ops->readpage(NULL, &folio->page);
> > +		err = mapping->a_ops->read_folio(NULL, folio);
> >  		if (err) {
> >  			folio_put(folio);
> >  			goto out;
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 2be852661a29..5ecc4b74204d 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -335,7 +335,10 @@ static inline bool is_sync_kiocb(struct kiocb *kiocb)
> >  
> >  struct address_space_operations {
> >  	int (*writepage)(struct page *page, struct writeback_control *wbc);
> > -	int (*readpage)(struct file *, struct page *);
> > +	union {
> > +		int (*readpage)(struct file *, struct page *);
> > +		int (*read_folio)(struct file *, struct folio *);
> > +	};
> 
> I don't think this is going to make CFI very happy.

Good news is all the readpage instances are removed at the end of the
series. :)

But yes, bad news is that bisectability under CFI at this point in the
series CFI would trap every instance of ->read_folio, since the assigned
prototype:

 static int ext4_readpage(struct file *file, struct page *page)
 ...
 static const struct address_space_operations ext4_aops = {
	.readpage		= ext4_readpage,

doesn't match the call prototype:

 int (*read_folio)(struct file *, struct folio *);
 ...
 err = mapping->a_ops->read_folio(NULL, folio);

If you want to survive this, you'll need to avoid the union and add a
wrapper to be removed when you remove read_page:

 struct address_space_operations {
    int (*writepage)(struct page *page, struct writeback_control *wbc);
    int (*readpage)(struct file *, struct page *);
    int (*read_folio)(struct file *, struct folio *);

 #define READ_FOLIO(ops, p, folio_or_page)	({		\
	int __rf_err;						\
	if (ops->read_folio)					\
		__rf_err = ops->read_folio(p, folio_or_page);	\
	else							\
		__rf_err = ops->read_page(p, folio_or_page);	\
	__rf_err;						\
 })
 ...
 err = READ_FOLIO(mapping->a_ops, NULL, folio);

Then only those cases that have had an appropriately matching callback
assigned to read_folio will call it.

And then you can drop the macro in "mm,fs: Remove stray references to ->readpage"

-Kees

-- 
Kees Cook
