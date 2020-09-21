Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D5F2731F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 20:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgIUS3u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 14:29:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbgIUS3u (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 14:29:50 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC2A220758;
        Mon, 21 Sep 2020 18:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600712990;
        bh=xfKd1sWDGNhVdepPEKC1RdDT0tu6IQ/iGDe1bIAhKWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eeL3T5WAha4l7IADwnyUubjJZSCetFw5JMJ+kxtH/TvUthibhmb+DvBnGmWcChcbt
         iE30z75SNSivfly/Ae3pYKjc5xglPEaExNgz/vjPN/BEKGQ2BYDU8wDgNsNkKBn1Cm
         QSWUJ0N/kinYBsYwIrCEsanyApVuhkGpI+Dtzz9Y=
Date:   Mon, 21 Sep 2020 11:29:48 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v12 4/4] ext4: Use generic casefolding support
Message-ID: <20200921182948.GA885472@gmail.com>
References: <20200708091237.3922153-1-drosen@google.com>
 <20200708091237.3922153-5-drosen@google.com>
 <87lfh4djdq.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfh4djdq.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 20, 2020 at 09:10:57PM -0400, Gabriel Krisman Bertazi wrote:
> Daniel Rosenberg <drosen@google.com> writes:
> 
> > This switches ext4 over to the generic support provided in
> > the previous patch.
> >
> > Since casefolded dentries behave the same in ext4 and f2fs, we decrease
> > the maintenance burden by unifying them, and any optimizations will
> > immediately apply to both.
> >
> > Signed-off-by: Daniel Rosenberg <drosen@google.com>
> > Reviewed-by: Eric Biggers <ebiggers@google.com>
> >  
> >  #ifdef CONFIG_UNICODE
> > -	if (EXT4_SB(parent->i_sb)->s_encoding && IS_CASEFOLDED(parent)) {
> > +	if (parent->i_sb->s_encoding && IS_CASEFOLDED(parent)) {
> >  		if (fname->cf_name.name) {
> >  			struct qstr cf = {.name = fname->cf_name.name,
> >  					  .len = fname->cf_name.len};
> > @@ -2171,9 +2171,6 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
> >  	struct buffer_head *bh = NULL;
> >  	struct ext4_dir_entry_2 *de;
> >  	struct super_block *sb;
> > -#ifdef CONFIG_UNICODE
> > -	struct ext4_sb_info *sbi;
> > -#endif
> >  	struct ext4_filename fname;
> >  	int	retval;
> >  	int	dx_fallback=0;
> > @@ -2190,9 +2187,8 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
> >  		return -EINVAL;
> >  
> >  #ifdef CONFIG_UNICODE
> > -	sbi = EXT4_SB(sb);
> > -	if (ext4_has_strict_mode(sbi) && IS_CASEFOLDED(dir) &&
> > -	    sbi->s_encoding && utf8_validate(sbi->s_encoding, &dentry->d_name))
> > +	if (sb_has_strict_encoding(sb) && IS_CASEFOLDED(dir) &&
> > +	    sb->s_encoding && utf8_validate(sb->s_encoding, &dentry->d_name))
> >  		return -EINVAL;
> 
> hm, just noticed the sb->s_encoding check here is superfluous, since the
> has_strict_mode() cannot be true if !s_encoding.  Not related to this
> patch though.
> 
> Daniel, are you still working on getting this upstream?  The fscrypt
> support would be very useful for us. :)
> 
> In the hope this will get upstream, as its been flying for a while and
> looks correct.
> 
> Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>

We couldn't get a response from Ted, so instead Jaegeuk has applied patches 1-3
to f2fs/dev for 5.10.  Hopefully Ted will take the ext4 patch for 5.11.

I believe that Daniel is planning to resend the actual encryption+casefolding
support soon, but initially only for f2fs since that will be ready first.

- Eric
