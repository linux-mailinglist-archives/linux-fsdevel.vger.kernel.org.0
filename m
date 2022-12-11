Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B8A64973E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 00:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiLKX4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 18:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKX4R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 18:56:17 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD43CBF64;
        Sun, 11 Dec 2022 15:56:13 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so3855424wmh.0;
        Sun, 11 Dec 2022 15:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vygAuf7AwXJYsfDW0hXyAUjykBCmNaNkMCNxlpUfxbk=;
        b=bj9PhQGuMqRiNXSSbU31EGyIWtiimrvGvPa/6yhxwEvSQsAAH1nRpVo1I0yW+Mg21Z
         lWgw+a7YqjCTOj7cyCnaz/nCbX0cE9lnYImnOlY0cr94NoKMjI+1FtRqOeHilAPJI2d2
         sU0SlG4jlczdpwOlVmtjNmsF1H7JI7D/b/a/Bo+PPTO/PcF+HjZeCCUJUf0tFjMJFmfK
         paemNxrijeAJfMKmW7SwHRYbe2vhCA/Mk/LMcVxZPuqGJcbcxO6xDsF0CT+eOHVEtgNY
         x5aAjoaKH6RsD+Bc3uQb5T9Jd6sR6k/vu0NXujiRkBGPB0jMATN0sf+SRuIsiFuQ/VMq
         y0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vygAuf7AwXJYsfDW0hXyAUjykBCmNaNkMCNxlpUfxbk=;
        b=d0l9tcHg1Oy3l+2l7RGOz3yIsnx0oGQVMMEQvr4QQmdOo5/ZYERTpLsxqm5AJTCSj0
         RJzkb/V9z/ybXIPLckCY/7ZURxhQv8lg0MzVWCPlEiPScV+UQYz9ApvXod1wB5rW+wyS
         NzmJ1jIFnfZK//Mpin0URubf2n1HQU5l7qQjVeR2B2EDGF7wvxbqYjYN4g1fZND42/15
         Nj1V/EPMs70F2O9GRe0mTbHq58VlBu/VSHZuMywRwjdKBhMUkXjOgMOOdENzUo6Uyc5a
         WyJf60kTkckTp07sZ/MxXeyhsB/wWI1S1qQvKbzN+M9Wy+Nwp3040GBtQrwBx/KJy7kX
         meNQ==
X-Gm-Message-State: ANoB5pl+UN+9NpYeD9zqPIcZPwUPUc/Eq411qr2r1BKceQBuDrvYkGQV
        Nxr9qEWd7qulvqYJGjqUvYc=
X-Google-Smtp-Source: AA0mqf5NCJIGiqe70JK1gk8LPNdAPiVZldPd9qB/UlVKOD/eiPOFbTGr+OMLtuM/7ANkqxKUBwQ1Ug==
X-Received: by 2002:a7b:ca49:0:b0:3cf:8b22:76bc with SMTP id m9-20020a7bca49000000b003cf8b2276bcmr11113607wml.28.1670802972144;
        Sun, 11 Dec 2022 15:56:12 -0800 (PST)
Received: from suse.localnet (host-95-247-100-134.retail.telecomitalia.it. [95.247.100.134])
        by smtp.gmail.com with ESMTPSA id bg16-20020a05600c3c9000b003c7087f6c9asm7882837wmb.32.2022.12.11.15.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 15:56:11 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Evgeniy Dushistov <dushistov@mail.ru>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] fs/ufs: Change the signature of ufs_get_page()
Date:   Mon, 12 Dec 2022 00:56:10 +0100
Message-ID: <2397878.jE0xQCEvom@suse>
In-Reply-To: <Y5ZZy23FFAnQDR3C@ZenIV>
References: <20221211213111.30085-1-fmdefrancesco@gmail.com>
 <20221211213111.30085-3-fmdefrancesco@gmail.com> <Y5ZZy23FFAnQDR3C@ZenIV>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On domenica 11 dicembre 2022 23:29:31 CET Al Viro wrote:
> On Sun, Dec 11, 2022 at 10:31:10PM +0100, Fabio M. De Francesco wrote:
> > -static struct page *ufs_get_page(struct inode *dir, unsigned long n)
> > +static void *ufs_get_page(struct inode *dir, unsigned long n, struct page
> > **page)> 
> >  {
> >  
> >  	struct address_space *mapping = dir->i_mapping;
> > 
> > -	struct page *page = read_mapping_page(mapping, n, NULL);
> > -	if (!IS_ERR(page)) {
> > -		kmap(page);
> > -		if (unlikely(!PageChecked(page))) {
> > -			if (!ufs_check_page(page))
> > +	*page = read_mapping_page(mapping, n, NULL);
> > +	if (!IS_ERR(*page)) {
> > +		kmap(*page);
> > +		if (unlikely(!PageChecked(*page))) {
> > +			if (!ufs_check_page(*page))
> > 
> >  				goto fail;
> >  		
> >  		}
> >  	
> >  	}
> >  	return page;
> 
> 	return page_address(page), surely?
> 
Yes, I'm sorry for these kinds of silly mistakes because while I was expecting 
to err on much more difficult topics I overlooked what I know pretty well  :-(

Shouldn't it be "return page_address(*page)" because of "page" being a pointer 
to pointer to "struct page"? Am I overlooking something?

However, the greater mistake was about doing the decomposition into three 
patches starting from the old single thing. I think that I had to start from 
scratch. I made the process the other way round. 
>
> >  fail:
> > -	ufs_put_page(page);
> > +	ufs_put_page(*page);
> > 
> >  	return ERR_PTR(-EIO);
> >  
> >  }
> > 
> > @@ -227,15 +227,12 @@ ufs_next_entry(struct super_block *sb, struct
> > ufs_dir_entry *p)> 
> >  struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
> >  {
> > 
> > -	struct page *page = ufs_get_page(dir, 0);
> > -	struct ufs_dir_entry *de = NULL;
> > +	struct ufs_dir_entry *de = ufs_get_page(dir, 0, p);
> 
> ... considering e.g. this.  The caller expects the pointer to beginning of
> page, not pointer to struct page itself.  Other callers are also like 
that...
>
I'll send next version within tomorrow (before or after work time) because 
here it is 00.40 CET.

Thank you very much for your immediate reply.

Fabio



