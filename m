Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EDE663CD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 10:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjAJJ2F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 04:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbjAJJ1X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:27:23 -0500
X-Greylist: delayed 590 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Jan 2023 01:27:01 PST
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E67B813D17;
        Tue, 10 Jan 2023 01:27:01 -0800 (PST)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id DBC882055F9C;
        Tue, 10 Jan 2023 18:17:09 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.17.1.9/8.17.1.9/Debian-1) with ESMTPS id 30A9H8X3104114
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 18:17:09 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.17.1.9/8.17.1.9/Debian-1) with ESMTPS id 30A9H8gj370581
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 18:17:08 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.17.1.9/8.17.1.9/Submit) id 30A9H6Hl370575;
        Tue, 10 Jan 2023 18:17:06 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, "Theodore Y . Ts'o" <tytso@mit.edu>,
        Anton Altaparmakov <anton@tuxera.com>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, Dave Kleikamp <shaggy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Kari Argillander <kari.argillander@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: Re: [RFC PATCH v2 01/18] fat: Fix iocharset=utf8 mount option
In-Reply-To: <20221226142150.13324-2-pali@kernel.org> ("Pali
 =?iso-8859-1?Q?Roh=E1r=22's?= message
        of "Mon, 26 Dec 2022 15:21:33 +0100")
References: <20221226142150.13324-1-pali@kernel.org>
        <20221226142150.13324-2-pali@kernel.org>
Date:   Tue, 10 Jan 2023 18:17:05 +0900
Message-ID: <874jsyvje6.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pali Rohár <pali@kernel.org> writes:

> Currently iocharset=utf8 mount option is broken and error is printed to
> dmesg when it is used. To use UTF-8 as iocharset, it is required to use
> utf8=1 mount option.
>
> Fix iocharset=utf8 mount option to use be equivalent to the utf8=1 mount
> option and remove printing error from dmesg.

[...]

> -
> -	There is also an option of doing UTF-8 translations
> -	with the utf8 option.
> -
> -.. note:: ``iocharset=utf8`` is not recommended. If unsure, you should consider
> -	  the utf8 option instead.
> +	**utf8** is supported too and recommended to use.
>  
>  **utf8=<bool>**
> -	UTF-8 is the filesystem safe version of Unicode that
> -	is used by the console. It can be enabled or disabled
> -	for the filesystem with this option.
> -	If 'uni_xlate' gets set, UTF-8 gets disabled.
> -	By default, FAT_DEFAULT_UTF8 setting is used.
> +	Alias for ``iocharset=utf8`` mount option.
>  
>  **uni_xlate=<bool>**
>  	Translate unhandled Unicode characters to special
> diff --git a/fs/fat/Kconfig b/fs/fat/Kconfig
> index 238cc55f84c4..e98aaa3bb55b 100644
> --- a/fs/fat/Kconfig
> +++ b/fs/fat/Kconfig
> @@ -93,29 +93,12 @@ config FAT_DEFAULT_IOCHARSET
>  	  like FAT to use. It should probably match the character set
>  	  that most of your FAT filesystems use, and can be overridden
>  	  with the "iocharset" mount option for FAT filesystems.
> -	  Note that "utf8" is not recommended for FAT filesystems.
> -	  If unsure, you shouldn't set "utf8" here - select the next option
> -	  instead if you would like to use UTF-8 encoded file names by default.
> +	  "utf8" is supported too and recommended to use.

This patch fixes the issue of utf-8 partially only. I think we can't
still recommend only partially working one.

[...]

> -	opts->utf8 = IS_ENABLED(CONFIG_FAT_DEFAULT_UTF8) && is_vfat;
> -
>  	if (!options)
>  		goto out;
>  
> @@ -1318,10 +1316,14 @@ static int parse_options(struct super_block *sb, char *options, int is_vfat,
>  					| VFAT_SFN_CREATE_WIN95;
>  			break;
>  		case Opt_utf8_no:		/* 0 or no or false */
> -			opts->utf8 = 0;
> +			fat_reset_iocharset(opts);

This changes the behavior of "iocharset=iso8859-1,utf8=no" for
example. Do we need this user visible change here?

>  			break;
>  		case Opt_utf8_yes:		/* empty or 1 or yes or true */
> -			opts->utf8 = 1;
> +			fat_reset_iocharset(opts);
> +			iocharset = kstrdup("utf8", GFP_KERNEL);
> +			if (!iocharset)
> +				return -ENOMEM;
> +			opts->iocharset = iocharset;
>  			break;
>  		case Opt_uni_xl_no:		/* 0 or no or false */
>  			opts->unicode_xlate = 0;
> @@ -1359,18 +1361,11 @@ static int parse_options(struct super_block *sb, char *options, int is_vfat,
>  	}
>  
>  out:
> -	/* UTF-8 doesn't provide FAT semantics */
> -	if (!strcmp(opts->iocharset, "utf8")) {
> -		fat_msg(sb, KERN_WARNING, "utf8 is not a recommended IO charset"
> -		       " for FAT filesystems, filesystem will be "
> -		       "case sensitive!");
> -	}
> +	opts->utf8 = !strcmp(opts->iocharset, "utf8") && is_vfat;

Still broken, so I think we still need the warning here (would be
tweaked warning).

>  	/* If user doesn't specify allow_utime, it's initialized from dmask. */
>  	if (opts->allow_utime == (unsigned short)-1)
>  		opts->allow_utime = ~opts->fs_dmask & (S_IWGRP | S_IWOTH);
> -	if (opts->unicode_xlate)
> -		opts->utf8 = 0;

unicode_xlate option is exclusive with utf8, need to adjust
somewhere. (with this patch, unicode_xlate and utf8 will shows by
show_options())

> +	else if (utf8)
> +		return fat_utf8_strnicmp(name->name, str, alen);
> +	else
> +		return nls_strnicmp(t, name->name, str, alen);
>  }

Not strong opinion though, maybe we better to consolidate this to a
(inline) function? (FWIW, it may be better to refactor to provide some
filename functions to hide the detail of handling nls/utf8)

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
