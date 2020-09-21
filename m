Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F81D2718EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 03:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgIUBLD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Sep 2020 21:11:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59420 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgIUBLD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Sep 2020 21:11:03 -0400
X-Greylist: delayed 4909 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Sep 2020 21:11:02 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id CA5D628BA5A
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com, Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v12 4/4] ext4: Use generic casefolding support
Organization: Collabora
References: <20200708091237.3922153-1-drosen@google.com>
        <20200708091237.3922153-5-drosen@google.com>
Date:   Sun, 20 Sep 2020 21:10:57 -0400
In-Reply-To: <20200708091237.3922153-5-drosen@google.com> (Daniel Rosenberg's
        message of "Wed, 8 Jul 2020 02:12:37 -0700")
Message-ID: <87lfh4djdq.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Daniel Rosenberg <drosen@google.com> writes:

> This switches ext4 over to the generic support provided in
> the previous patch.
>
> Since casefolded dentries behave the same in ext4 and f2fs, we decrease
> the maintenance burden by unifying them, and any optimizations will
> immediately apply to both.
>
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> Reviewed-by: Eric Biggers <ebiggers@google.com>
>  
>  #ifdef CONFIG_UNICODE
> -	if (EXT4_SB(parent->i_sb)->s_encoding && IS_CASEFOLDED(parent)) {
> +	if (parent->i_sb->s_encoding && IS_CASEFOLDED(parent)) {
>  		if (fname->cf_name.name) {
>  			struct qstr cf = {.name = fname->cf_name.name,
>  					  .len = fname->cf_name.len};
> @@ -2171,9 +2171,6 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
>  	struct buffer_head *bh = NULL;
>  	struct ext4_dir_entry_2 *de;
>  	struct super_block *sb;
> -#ifdef CONFIG_UNICODE
> -	struct ext4_sb_info *sbi;
> -#endif
>  	struct ext4_filename fname;
>  	int	retval;
>  	int	dx_fallback=0;
> @@ -2190,9 +2187,8 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
>  		return -EINVAL;
>  
>  #ifdef CONFIG_UNICODE
> -	sbi = EXT4_SB(sb);
> -	if (ext4_has_strict_mode(sbi) && IS_CASEFOLDED(dir) &&
> -	    sbi->s_encoding && utf8_validate(sbi->s_encoding, &dentry->d_name))
> +	if (sb_has_strict_encoding(sb) && IS_CASEFOLDED(dir) &&
> +	    sb->s_encoding && utf8_validate(sb->s_encoding, &dentry->d_name))
>  		return -EINVAL;

hm, just noticed the sb->s_encoding check here is superfluous, since the
has_strict_mode() cannot be true if !s_encoding.  Not related to this
patch though.

Daniel, are you still working on getting this upstream?  The fscrypt
support would be very useful for us. :)

In the hope this will get upstream, as its been flying for a while and
looks correct.

Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>

-- 
Gabriel Krisman Bertazi
