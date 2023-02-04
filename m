Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F27368A98F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Feb 2023 11:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjBDK6S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Feb 2023 05:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjBDK6R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Feb 2023 05:58:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABBC18B17;
        Sat,  4 Feb 2023 02:58:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8082660BC3;
        Sat,  4 Feb 2023 10:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF40EC433EF;
        Sat,  4 Feb 2023 10:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675508289;
        bh=MBA/uE0noC0OSgi+5LE4NzFxRFwlRfjkGbar2IzdKLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cBFE3ZfJ1rTSIWNz9irNPpB1Dn6e8P7XLUtsxxRcVA5RI1ENSziIoWAHbxAuFWaPh
         rh/jLddvo0UnSGUUgTcST8Tm2kfZJh0Y84bikm/8EhFOIcvKStG9yMGaAL4dw2hzGM
         C6QaZNZW7pctdBZ1ZDHa5YqACIFP/QVrbK4xQPIPrfm297CtAZ6wKeMRMtjsRMgZTq
         5236GsIS05RLiF4DgH60p44DhXE6lvyVkEuo2nly8dlgVkSVZo5mTvBrBkanfe5uAE
         YTkQ4alsWj847YwTTf3fIwJjU+bMJQg1NDvt3MSpghjobHy1a9VlWLXvfArY7jEr/h
         6BM0HWgkXuiQw==
Received: by pali.im (Postfix)
        id 34CC4976; Sat,  4 Feb 2023 11:58:07 +0100 (CET)
Date:   Sat, 4 Feb 2023 11:58:07 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH 3/3] nls: Replace default nls table by correct
 iso8859-1 table
Message-ID: <20230204105807.jdd2rrrzf37hns6h@pali>
References: <20221226144301.16382-1-pali@kernel.org>
 <20221226144301.16382-4-pali@kernel.org>
 <87v8leu4iy.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v8leu4iy.fsf@mail.parknet.co.jp>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tuesday 10 January 2023 18:23:33 OGAWA Hirofumi wrote:
> Pali Rohár <pali@kernel.org> writes:
> 
> [...]
> 
> > -static struct nls_table default_table = {
> > -	.charset	= "default",
> > +static struct nls_table iso8859_1_table = {
> > +	.charset	= "iso8859-1",
> >  	.uni2char	= uni2char,
> >  	.char2uni	= char2uni,
> >  	.charset2lower	= charset2lower,
> >  	.charset2upper	= charset2upper,
> >  };
> 
> iocharset=default was gone with this (user visible) change? (nobody
> notice it though)
> 
> > -/* Returns a simple default translation table */
> > +/* Returns a default translation table */
> >  struct nls_table *load_nls_default(void)
> >  {
> >  	struct nls_table *default_nls;
> > @@ -537,9 +419,22 @@ struct nls_table *load_nls_default(void)
> >  	if (default_nls != NULL)
> >  		return default_nls;
> >  	else
> > -		return &default_table;
> > +		return &iso8859_1_table;
> > +}
> > +
> > +static int __init init_nls(void)
> > +{
> > +	return register_nls(&iso8859_1_table);
> >  }
> >  
> > +static void __exit exit_nls(void)
> > +{
> > +	unregister_nls(&iso8859_1_table);
> > +}
> > +
> > +module_init(init_nls)
> > +module_exit(exit_nls)
> 
> [...]
> 
> Do we need to merge nls_iso8859-1.c to nls_base.c?
> 
> 	obj-$(CONFIG_NLS)		+= nls_iso8859-1.o nls_base.o
> 
> Something like this (untested), maybe cleaner.
> 
> Thanks.
> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

I will look at it.
