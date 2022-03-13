Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F784D71A8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Mar 2022 01:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbiCMACo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Mar 2022 19:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbiCMACn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Mar 2022 19:02:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38D51F1257;
        Sat, 12 Mar 2022 16:01:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5032E600BE;
        Sun, 13 Mar 2022 00:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BFEC340FC;
        Sun, 13 Mar 2022 00:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647129694;
        bh=wU4frsRVEuFSeRUP7TISF5wop6auqn20os6c7ICwuO0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=dRwtH8pVp8zVQw2pY410SW4b9pQLf4i29kfvIzJd2wAhYckY9W2GS/WbjXB2FDIem
         kaq2rKWMCOczpYJTSp2A8b3IfrFbugJi8w3+6n9juwyYhIgblNCfjZsmka53RpD4d1
         9nC0J/UUeb88fSnZ920RSyj+HH/A/Q3G0MEQwk+II2lGFSn3rkMuNsjKk8pr5wLe10
         TA5lQD7wQ+N3vPbizoeRb0zIzp7IeewhzSSbmmKcLCbTQ4761WWyMvmSuOMtlVjas0
         v2OHWO9e+R+SJLqASpckvOyPyohapOe3Xx1aY/UnMtr5CcwtLHoBrzYhji5IsCCeQa
         i+40eJ+qiKx8w==
Received: by mail-wr1-f47.google.com with SMTP id j26so18486399wrb.1;
        Sat, 12 Mar 2022 16:01:34 -0800 (PST)
X-Gm-Message-State: AOAM530lzg0Dtg71gfIOIQ4rzOnB8Fe9i6Tde7ePHUJavnvkw7jRNLmZ
        t5Xmp687eCU3QXuD4WltwXWQgBwYVdNQwZTypxI=
X-Google-Smtp-Source: ABdhPJxU9N3Ockc17WgE+bc27jrg86lDbJPR02nyefyBMJLv/qKVFJVyvS7OSy04L/9Ks2MnA/vtXp7p/RKf3kPmUEY=
X-Received: by 2002:a5d:4387:0:b0:1ed:a13a:ef0c with SMTP id
 i7-20020a5d4387000000b001eda13aef0cmr11850456wrq.62.1647129692921; Sat, 12
 Mar 2022 16:01:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6000:1d93:0:0:0:0 with HTTP; Sat, 12 Mar 2022 16:01:32
 -0800 (PST)
In-Reply-To: <20220311114746.7643-2-vkarasulli@suse.de>
References: <20220311114746.7643-1-vkarasulli@suse.de> <20220311114746.7643-2-vkarasulli@suse.de>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sun, 13 Mar 2022 09:01:32 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9kdYi4rXmyfAO3ZbmKLu3i35QzsL_oOorROYieQnWGRg@mail.gmail.com>
Message-ID: <CAKYAXd9kdYi4rXmyfAO3ZbmKLu3i35QzsL_oOorROYieQnWGRg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] exfat: add keep_last_dots mount option
To:     Vasant Karasulli <vkarasulli@suse.de>
Cc:     Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ddiss@suse.de, Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-03-11 20:47 GMT+09:00, Vasant Karasulli <vkarasulli@suse.de>:
> The "keep_last_dots" mount option will, in a
> subsequent commit, control whether or not trailing periods '.' are stripped
> from path components during file lookup or file creation.
I don't know why the 1/2 patch should be split from the 2/2 patch.
Wouldn't it be better to combine them? Otherwise it looks good to me.
>
> Suggested-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
> Co-developed-by: David Disseldorp <ddiss@suse.de>
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  fs/exfat/exfat_fs.h | 3 ++-
>  fs/exfat/super.c    | 7 +++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> index 619e5b4bed10..c6800b880920 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -203,7 +203,8 @@ struct exfat_mount_options {
>  	/* on error: continue, panic, remount-ro */
>  	enum exfat_error_mode errors;
>  	unsigned utf8:1, /* Use of UTF-8 character set */
> -		 discard:1; /* Issue discard requests on deletions */
> +		 discard:1, /* Issue discard requests on deletions */
> +		 keep_last_dots:1; /* Keep trailing periods in paths */
>  	int time_offset; /* Offset of timestamps from UTC (in minutes) */
>  };
>
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> index 8c9fb7dcec16..4c3f80ed17b1 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -174,6 +174,8 @@ static int exfat_show_options(struct seq_file *m, struct
> dentry *root)
>  		seq_puts(m, ",errors=remount-ro");
>  	if (opts->discard)
>  		seq_puts(m, ",discard");
> +	if (opts->keep_last_dots)
> +		seq_puts(m, ",keep_last_dots");
>  	if (opts->time_offset)
>  		seq_printf(m, ",time_offset=%d", opts->time_offset);
>  	return 0;
> @@ -217,6 +219,7 @@ enum {
>  	Opt_charset,
>  	Opt_errors,
>  	Opt_discard,
> +	Opt_keep_last_dots,
>  	Opt_time_offset,
>
>  	/* Deprecated options */
> @@ -243,6 +246,7 @@ static const struct fs_parameter_spec exfat_parameters[]
> = {
>  	fsparam_string("iocharset",		Opt_charset),
>  	fsparam_enum("errors",			Opt_errors, exfat_param_enums),
>  	fsparam_flag("discard",			Opt_discard),
> +	fsparam_flag("keep_last_dots",		Opt_keep_last_dots),
>  	fsparam_s32("time_offset",		Opt_time_offset),
>  	__fsparam(NULL, "utf8",			Opt_utf8, fs_param_deprecated,
>  		  NULL),
> @@ -297,6 +301,9 @@ static int exfat_parse_param(struct fs_context *fc,
> struct fs_parameter *param)
>  	case Opt_discard:
>  		opts->discard = 1;
>  		break;
> +	case Opt_keep_last_dots:
> +		opts->keep_last_dots = 1;
> +		break;
>  	case Opt_time_offset:
>  		/*
>  		 * Make the limit 24 just in case someone invents something
> --
> 2.32.0
>
>
