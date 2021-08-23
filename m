Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C1C3F4CFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 17:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhHWPDm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 11:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbhHWPDl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 11:03:41 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C66C061757;
        Mon, 23 Aug 2021 08:02:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 4DC591F42D87
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 05/11] unicode: pass a UNICODE_AGE() tripple to utf8_load
Organization: Collabora
References: <20210818140651.17181-1-hch@lst.de>
        <20210818140651.17181-6-hch@lst.de>
Date:   Mon, 23 Aug 2021 11:02:52 -0400
In-Reply-To: <20210818140651.17181-6-hch@lst.de> (Christoph Hellwig's message
        of "Wed, 18 Aug 2021 16:06:45 +0200")
Message-ID: <87tujg19wj.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> Don't bother with pointless string parsing when the caller can just pass
> the version in the format that the core expects.  Also remove the
> fallback to the latest version that none of the callers actually uses.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/ext4/super.c            | 10 ++++----
>  fs/f2fs/super.c            | 10 ++++----
>  fs/unicode/utf8-core.c     | 50 ++++----------------------------------
>  fs/unicode/utf8-norm.c     | 11 ++-------
>  fs/unicode/utf8-selftest.c | 15 ++++++------
>  fs/unicode/utf8n.h         | 14 ++---------
>  include/linux/unicode.h    | 11 ++++++++-
>  7 files changed, 37 insertions(+), 84 deletions(-)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index a68be582bba5..be418a30b52e 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2016,9 +2016,9 @@ static const struct mount_opts {
>  static const struct ext4_sb_encodings {
>  	__u16 magic;
>  	char *name;
> -	char *version;
> +	unsigned int version;
>  } ext4_sb_encoding_map[] = {
> -	{EXT4_ENC_UTF8_12_1, "utf8", "12.1.0"},
> +	{EXT4_ENC_UTF8_12_1, "utf8", UNICODE_AGE(12, 1, 0)},
>  };
>  
>  static const struct ext4_sb_encodings *
> @@ -4308,15 +4308,15 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  		encoding = utf8_load(encoding_info->version);
>  		if (IS_ERR(encoding)) {
>  			ext4_msg(sb, KERN_ERR,
> -				 "can't mount with superblock charset: %s-%s "
> +				 "can't mount with superblock charset: %s-0x%x "
>  				 "not supported by the kernel. flags: 0x%x.",
>  				 encoding_info->name, encoding_info->version,
>  				 encoding_flags);
>  			goto failed_mount;
>  		}
>  		ext4_msg(sb, KERN_INFO,"Using encoding defined by superblock: "
> -			 "%s-%s with flags 0x%hx", encoding_info->name,
> -			 encoding_info->version?:"\b", encoding_flags);
> +			 "%s-0x%x with flags 0x%hx", encoding_info->name,
> +			 encoding_info->version, encoding_flags);
>  
>  		sb->s_encoding = encoding;
>  		sb->s_encoding_flags = encoding_flags;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index af63ae009582..d107480f88a3 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -255,9 +255,9 @@ void f2fs_printk(struct f2fs_sb_info *sbi, const char *fmt, ...)
>  static const struct f2fs_sb_encodings {
>  	__u16 magic;
>  	char *name;
> -	char *version;
> +	unsigned int version;
>  } f2fs_sb_encoding_map[] = {
> -	{F2FS_ENC_UTF8_12_1, "utf8", "12.1.0"},
> +	{F2FS_ENC_UTF8_12_1, "utf8", UNICODE_AGE(12, 1, 0)},
>  };
>  
>  static const struct f2fs_sb_encodings *
> @@ -3734,15 +3734,15 @@ static int f2fs_setup_casefold(struct f2fs_sb_info *sbi)
>  		encoding = utf8_load(encoding_info->version);
>  		if (IS_ERR(encoding)) {
>  			f2fs_err(sbi,
> -				 "can't mount with superblock charset: %s-%s "
> +				 "can't mount with superblock charset: %s-0x%x "
>  				 "not supported by the kernel. flags: 0x%x.",
>  				 encoding_info->name, encoding_info->version,
>  				 encoding_flags);
>  			return PTR_ERR(encoding);
>  		}
>  		f2fs_info(sbi, "Using encoding defined by superblock: "
> -			 "%s-%s with flags 0x%hx", encoding_info->name,
> -			 encoding_info->version?:"\b", encoding_flags);
> +			 "%s-0x%x with flags 0x%hx", encoding_info->name,
> +			 encoding_info->version, encoding_flags);
>  
>  		sbi->sb->s_encoding = encoding;
>  		sbi->sb->s_encoding_flags = encoding_flags;
> diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
> index 86f42a078d99..dca2865c3bee 100644
> --- a/fs/unicode/utf8-core.c
> +++ b/fs/unicode/utf8-core.c
> @@ -167,59 +167,19 @@ int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
>  	}
>  	return -EINVAL;
>  }
> -
>  EXPORT_SYMBOL(utf8_normalize);
>  
> -static int utf8_parse_version(const char *version, unsigned int *maj,
> -			      unsigned int *min, unsigned int *rev)
> +struct unicode_map *utf8_load(unsigned int version)
>  {
> -	substring_t args[3];
> -	char version_string[12];
> -	static const struct match_token token[] = {
> -		{1, "%d.%d.%d"},
> -		{0, NULL}
> -	};
> -
> -	strncpy(version_string, version, sizeof(version_string));
> -
> -	if (match_token(version_string, token, args) != 1)
> -		return -EINVAL;
> -
> -	if (match_int(&args[0], maj) || match_int(&args[1], min) ||
> -	    match_int(&args[2], rev))
> -		return -EINVAL;
> +	struct unicode_map *um;
>  
> -	return 0;
> -}
> -
> -struct unicode_map *utf8_load(const char *version)
> -{
> -	struct unicode_map *um = NULL;
> -	int unicode_version;
> -
> -	if (version) {
> -		unsigned int maj, min, rev;
> -
> -		if (utf8_parse_version(version, &maj, &min, &rev) < 0)
> -			return ERR_PTR(-EINVAL);
> -
> -		if (!utf8version_is_supported(maj, min, rev))
> -			return ERR_PTR(-EINVAL);
> -
> -		unicode_version = UNICODE_AGE(maj, min, rev);
> -	} else {
> -		unicode_version = utf8version_latest();
> -		printk(KERN_WARNING"UTF-8 version not specified. "
> -		       "Assuming latest supported version (%d.%d.%d).",
> -		       (unicode_version >> 16) & 0xff,
> -		       (unicode_version >> 8) & 0xff,
> -		       (unicode_version & 0xff));

I remember this fallback was specifically requested during a review or
in a discussion, but I honestly cannot remember the reason.

One advantage I can think is if we have a filesystem that requires a
newer unicode version than the current kernel has, and strict mode flag
is set, we can fallback to the latest version and still mount the fs
read/write.

That is not implemented though, so I'm fine with this removal.

Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>

-- 
Gabriel Krisman Bertazi
