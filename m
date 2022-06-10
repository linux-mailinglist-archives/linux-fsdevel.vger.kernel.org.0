Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF3E54596B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 03:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242631AbiFJBEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 21:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238751AbiFJBEV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 21:04:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6B162A09;
        Thu,  9 Jun 2022 18:04:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFC47B80AE9;
        Fri, 10 Jun 2022 01:04:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A944DC34115;
        Fri, 10 Jun 2022 01:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654823057;
        bh=K8C+z1NqPryvLx1nUhl6GqD+lIyAyqOk+GeG936m8Y0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=l7BRkehnuQyY0J0wz7UkdbCjCATMODOMQC3QEMy8bt/5iOKRgW2bjW09rnMN3NCpz
         Ydq5DOOa1NcVvh1XL7fRUPmIGYZUoEx28n/096h6GfXMyNnY/59jutuR0H/m3NnFIp
         Sm42byXllF+QuSFgbnWDhuoI96hqvPA2oM4Q0NcrMtuBZTrPgG9DwoMOYddAmu4Zar
         GM5cJ5FuKfvhbNMLzm1e9t+uS9acd9cyFh0LwUHywTeDiWpQ8ZYq1qH5VjL5C+eSEi
         c3aTol4bULXO79LaNvgUzg5mbwxaCSFWDwSYKCJpyIvC04zIUHgY2k1tJuVUex29oX
         KvqNH/ohnQ6rQ==
Received: by mail-wm1-f48.google.com with SMTP id o37-20020a05600c512500b0039c4ba4c64dso391099wms.2;
        Thu, 09 Jun 2022 18:04:17 -0700 (PDT)
X-Gm-Message-State: AOAM533r/ZOpa6gDIvnVQc3gLUby/2A2kuYYH20m1ql4fjwfu9Poj+5u
        RsvMUyLT0AtnYLumLL8yH9dBPXxjUIBQvf5lWCM=
X-Google-Smtp-Source: ABdhPJzkrJAvKw2gfrAMWmKuz3Jw8SFHgWphE0qe1ty+w7RiDpYU4lnuX8Z4NeIkl3zoc5Hm5kRw3NzHwHwFl0MaXB4=
X-Received: by 2002:a05:600c:19c7:b0:39c:30b0:2b05 with SMTP id
 u7-20020a05600c19c700b0039c30b02b05mr5877640wmq.170.1654823055856; Thu, 09
 Jun 2022 18:04:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4c4a:0:0:0:0:0 with HTTP; Thu, 9 Jun 2022 18:04:14 -0700 (PDT)
In-Reply-To: <20220607024942.811-1-frank.li@vivo.com>
References: <20220607024942.811-1-frank.li@vivo.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 10 Jun 2022 10:04:14 +0900
X-Gmail-Original-Message-ID: <CAKYAXd99NAbQP6m93P3bcjvWTN-T8Qy59DHJyfyTHqdH-7aWBQ@mail.gmail.com>
Message-ID: <CAKYAXd99NAbQP6m93P3bcjvWTN-T8Qy59DHJyfyTHqdH-7aWBQ@mail.gmail.com>
Subject: Re: [PATCH] exfat: intorduce skip_stream_check mount opt
To:     Yangtao Li <frank.li@vivo.com>
Cc:     sj1557.seo@samsung.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-06-07 11:49 GMT+09:00, Yangtao Li <frank.li@vivo.com>:
> There are some files in my USB flash drive that can be recognized by
> the Windows computer, but on Linux, only the existence of the file name
> can be seen.
>
> When executing ls command to view the file attributes or access, the file
> does not exist. Therefore, when the current windows and linux drivers
> access a file, there is a difference in the checking of the file metadata,
> which leads to this situation.
> (There is also a difference between traversing all children of the parent
> directory and finding a child in the parent directory on linux.)
Still having problem on linux-exfat after recovering it using windows chkdsk?

Thanks.
>
> So, we introduce a new mount option that skips the check of the file stream
> entry in exfat_find_dir_entry().
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/exfat/dir.c      | 6 ++++--
>  fs/exfat/exfat_fs.h | 3 ++-
>  fs/exfat/super.c    | 7 +++++++
>  3 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
> index cb1c0d8c1714..4ea0077f2955 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -1013,6 +1013,7 @@ int exfat_find_dir_entry(struct super_block *sb,
> struct exfat_inode_info *ei,
>  			}
>
>  			if (entry_type == TYPE_STREAM) {
> +				struct exfat_mount_options *opts = &sbi->options;
>  				u16 name_hash;
>
>  				if (step != DIRENT_STEP_STRM) {
> @@ -1023,9 +1024,10 @@ int exfat_find_dir_entry(struct super_block *sb,
> struct exfat_inode_info *ei,
>  				step = DIRENT_STEP_FILE;
>  				name_hash = le16_to_cpu(
>  						ep->dentry.stream.name_hash);
> -				if (p_uniname->name_hash == name_hash &&
> +				if ((p_uniname->name_hash == name_hash &&
>  				    p_uniname->name_len ==
> -						ep->dentry.stream.name_len) {
> +						ep->dentry.stream.name_len) ||
> +					opts->skip_stream_check == 1) {
>  					step = DIRENT_STEP_NAME;
>  					order = 1;
>  					name_len = 0;
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> index 1d6da61157c9..5cd00ac112d9 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -204,7 +204,8 @@ struct exfat_mount_options {
>  	/* on error: continue, panic, remount-ro */
>  	enum exfat_error_mode errors;
>  	unsigned utf8:1, /* Use of UTF-8 character set */
> -		 discard:1; /* Issue discard requests on deletions */
> +		 discard:1, /* Issue discard requests on deletions */
> +		 skip_stream_check:1; /* Skip stream entry check in
> exfat_find_dir_entry() */
>  	int time_offset; /* Offset of timestamps from UTC (in minutes) */
>  };
>
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> index 5539ffc20d16..e9c7df25f2b5 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -173,6 +173,8 @@ static int exfat_show_options(struct seq_file *m, struct
> dentry *root)
>  		seq_puts(m, ",errors=remount-ro");
>  	if (opts->discard)
>  		seq_puts(m, ",discard");
> +	if (opts->skip_stream_check)
> +		seq_puts(m, ",skip_stream_check");
>  	if (opts->time_offset)
>  		seq_printf(m, ",time_offset=%d", opts->time_offset);
>  	return 0;
> @@ -216,6 +218,7 @@ enum {
>  	Opt_charset,
>  	Opt_errors,
>  	Opt_discard,
> +	Opt_skip_stream_check,
>  	Opt_time_offset,
>
>  	/* Deprecated options */
> @@ -242,6 +245,7 @@ static const struct fs_parameter_spec exfat_parameters[]
> = {
>  	fsparam_string("iocharset",		Opt_charset),
>  	fsparam_enum("errors",			Opt_errors, exfat_param_enums),
>  	fsparam_flag("discard",			Opt_discard),
> +	fsparam_flag("skip_stream_check",	Opt_skip_stream_check),
>  	fsparam_s32("time_offset",		Opt_time_offset),
>  	__fsparam(NULL, "utf8",			Opt_utf8, fs_param_deprecated,
>  		  NULL),
> @@ -296,6 +300,9 @@ static int exfat_parse_param(struct fs_context *fc,
> struct fs_parameter *param)
>  	case Opt_discard:
>  		opts->discard = 1;
>  		break;
> +	case Opt_skip_stream_check:
> +		opts->skip_stream_check = 1;
> +		break;
>  	case Opt_time_offset:
>  		/*
>  		 * Make the limit 24 just in case someone invents something
> --
> 2.35.1
>
>
