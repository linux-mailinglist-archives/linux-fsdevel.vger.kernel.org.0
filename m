Return-Path: <linux-fsdevel+bounces-34800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E089C8D9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 16:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C1C1F24DC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 15:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC4F13B2A9;
	Thu, 14 Nov 2024 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGekQPjB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDEE288DA;
	Thu, 14 Nov 2024 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731596963; cv=none; b=gqijRd0S74IMPMkAp4kWzSAdiZegFuwgMU+jX8kM1Lubn1N0dhx+JgP6QSpyipq81fIcUL5O3/9PplNlv6wjTBYmfyur6KowOsG9Gzm4tKJqObYH6IrgspIAvo5TVEuzxpEhyRbl/rF2Yofy6CtTWOXaZj3EJ2WaVepsMF6uyZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731596963; c=relaxed/simple;
	bh=0NQgyLEatvr+MDl2cQ5d6X3A4fUJMj3M+eF9ZnLRWmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LI8JEmfMLN0+3VLOdfKyHTIf24EzVP4xP23Qo0+IaXjSQzeKc0mge149ehI7R8USsn7wFTb6F+IF1JBJlnBVruFyqKL1SkchhAGVXBVqObu6CBOpufGGU1Xje3vv3+iU91LDsGb7Mize1Ziu+O+wu6ZZsAT+mBWAzfj57ycQA2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGekQPjB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179F0C4CECD;
	Thu, 14 Nov 2024 15:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731596963;
	bh=0NQgyLEatvr+MDl2cQ5d6X3A4fUJMj3M+eF9ZnLRWmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IGekQPjBkE9L5SkMk57W6HLQydXLsEbHcp5+tbu6qDULIF2wF3Lazh64GlsngcJGe
	 JA7kUAgxP7VVJctVXmQfzFxM3/F75aIpz2v9sheR5cUdz7WpTpBLtlF9XeJS3JkKt6
	 Tbox5xXo7wSKCln+4bZsRktV5Kb7KM6TPwzSuuI5swv4ypEOxM7qpMf51Rmp1MIgFc
	 ss/1qw4AB0CgJRaK/hJa+7r0iZJpC1HvAMdejdOQMWdI1so1zgH+zACGlpgJ9rKoDc
	 Xj1jG/Ea6Fhi/biSiy+6TJUrJNVimWx8pz98sd/ozlWgefeFaqzPr8vfYLlzjjOc/C
	 sr7UrbYX/8WEw==
Date: Thu, 14 Nov 2024 16:09:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Karel Zak <kzak@redhat.com>, 
	Ian Kent <raven@themaw.net>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v4 0/3] fs: allow statmount to fetch the fs_subtype and
 sb_source
Message-ID: <20241114-hammer-reinigen-045808e64b99@brauner>
References: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
 <20241112-antiseptisch-kinowelt-6634948a413e@brauner>
 <hss5w5in3wj3af3o2x3v3zfaj47gx6w7faeeuvnxwx2uieu3xu@zqqllubl6m4i>
 <63f3aa4b3d69b33f1193f4740f655ce6dae06870.camel@kernel.org>
 <20241114-umzog-garage-b1c1bb8b80f2@brauner>
 <3e6454f8a6b9176e9e1f98523be35f8eb6457eba.camel@kernel.org>
 <CAJfpegtZ6hiars5+JHCr6TEj=TgFFpFbk_TVM_b=YNpbLG0=ig@mail.gmail.com>
 <20241114-oberteil-villen-419f96aad840@brauner>
 <d65340299e27ea3f187f05002c1d30d4c9fe8bf8.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d65340299e27ea3f187f05002c1d30d4c9fe8bf8.camel@kernel.org>

On Thu, Nov 14, 2024 at 09:51:42AM -0500, Jeff Layton wrote:
> On Thu, 2024-11-14 at 15:48 +0100, Christian Brauner wrote:
> > On Thu, Nov 14, 2024 at 02:16:05PM +0100, Miklos Szeredi wrote:
> > > On Thu, 14 Nov 2024 at 13:29, Jeff Layton <jlayton@kernel.org> wrote:
> > > 
> > > > Ordinarily, I might agree, but we're now growing a new mount option
> > > > field that has them separated by NULs. Will we need two extra fields
> > > > for this? One comma-separated, and one NUL separated?
> > > > 
> > > > /proc/#/mountinfo and mounts prepend these to the output of
> > > > ->show_options, so the simple solution would be to just prepend those
> > > > there instead of adding a new field. FWIW, only SELinux has any extra
> > > > mount options to show here.
> > > 
> > > Compromise: tack them onto the end of the comma separated list, but
> > > add a new field for the nul separated security options.
> > > 
> > > I think this would be logical, since the comma separated list is more
> > > useful for having a /proc/$$/mountinfo compatible string than for
> > > actually interpreting what's in there.
> > 
> > Fair. Here's an incremental for the array of security options.
> > 
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 4f39c4aba85d..a9065a9ab971 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -5072,13 +5072,30 @@ static int statmount_mnt_opts(struct kstatmount *s, struct seq_file *seq)
> >  	return 0;
> >  }
> >  
> > +static inline int statmount_opt_unescape(struct seq_file *seq, char *buf_start)
> > +{
> > +	char *buf_end, *opt_start, *opt_end;
> > +	int count = 0;
> > +
> > +	buf_end = seq->buf + seq->count;
> > +	*buf_end = '\0';
> > +	for (opt_start = buf_start + 1; opt_start < buf_end; opt_start = opt_end + 1) {
> > +		opt_end = strchrnul(opt_start, ',');
> > +		*opt_end = '\0';
> > +		buf_start += string_unescape(opt_start, buf_start, 0, UNESCAPE_OCTAL) + 1;
> > +		if (WARN_ON_ONCE(++count == INT_MAX))
> > +			return -EOVERFLOW;
> > +	}
> > +	seq->count = buf_start - 1 - seq->buf;
> > +	return count;
> > +}
> > +
> >  static int statmount_opt_array(struct kstatmount *s, struct seq_file *seq)
> >  {
> >  	struct vfsmount *mnt = s->mnt;
> >  	struct super_block *sb = mnt->mnt_sb;
> >  	size_t start = seq->count;
> > -	char *buf_start, *buf_end, *opt_start, *opt_end;
> > -	u32 count = 0;
> > +	char *buf_start;
> >  	int err;
> >  
> >  	if (!sb->s_op->show_options)
> > @@ -5095,17 +5112,39 @@ static int statmount_opt_array(struct kstatmount *s, struct seq_file *seq)
> >  	if (seq->count == start)
> >  		return 0;
> >  
> > -	buf_end = seq->buf + seq->count;
> > -	*buf_end = '\0';
> > -	for (opt_start = buf_start + 1; opt_start < buf_end; opt_start = opt_end + 1) {
> > -		opt_end = strchrnul(opt_start, ',');
> > -		*opt_end = '\0';
> > -		buf_start += string_unescape(opt_start, buf_start, 0, UNESCAPE_OCTAL) + 1;
> > -		if (WARN_ON_ONCE(++count == 0))
> > -			return -EOVERFLOW;
> > -	}
> > -	seq->count = buf_start - 1 - seq->buf;
> > -	s->sm.opt_num = count;
> > +	err = statmount_opt_unescape(seq, buf_start);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	s->sm.opt_num = err;
> > +	return 0;
> > +}
> > +
> > +static int statmount_opt_sec_array(struct kstatmount *s, struct seq_file *seq)
> > +{
> > +	struct vfsmount *mnt = s->mnt;
> > +	struct super_block *sb = mnt->mnt_sb;
> > +	size_t start = seq->count;
> > +	char *buf_start;
> > +	int err;
> > +
> > +	buf_start = seq->buf + start;
> > +
> > +	err = security_sb_show_options(seq, sb);
> > +	if (!err)
> > +		return err;
> > +
> > +	if (unlikely(seq_has_overflowed(seq)))
> > +		return -EAGAIN;
> > +
> > +	if (seq->count == start)
> > +		return 0;
> > +
> > +	err = statmount_opt_unescape(seq, buf_start);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	s->sm.opt_sec_num = err;
> >  	return 0;
> >  }
> >  
> > @@ -5138,6 +5177,10 @@ static int statmount_string(struct kstatmount *s, u64 flag)
> >  		sm->opt_array = start;
> >  		ret = statmount_opt_array(s, seq);
> >  		break;
> > +	case STATMOUNT_OPT_SEC_ARRAY:
> > +		sm->opt_sec_array = start;
> > +		ret = statmount_opt_sec_array(s, seq);
> > +		break;
> >  	case STATMOUNT_FS_SUBTYPE:
> >  		sm->fs_subtype = start;
> >  		statmount_fs_subtype(s, seq);
> > @@ -5294,6 +5337,9 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
> >  	if (!err && s->mask & STATMOUNT_OPT_ARRAY)
> >  		err = statmount_string(s, STATMOUNT_OPT_ARRAY);
> >  
> > +	if (!err && s->mask & STATMOUNT_OPT_SEC_ARRAY)
> > +		err = statmount_string(s, STATMOUNT_OPT_SEC_ARRAY);
> > +
> >  	if (!err && s->mask & STATMOUNT_FS_SUBTYPE)
> >  		err = statmount_string(s, STATMOUNT_FS_SUBTYPE);
> >  
> > @@ -5323,7 +5369,7 @@ static inline bool retry_statmount(const long ret, size_t *seq_size)
> >  #define STATMOUNT_STRING_REQ (STATMOUNT_MNT_ROOT | STATMOUNT_MNT_POINT | \
> >  			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS | \
> >  			      STATMOUNT_FS_SUBTYPE | STATMOUNT_SB_SOURCE | \
> > -			      STATMOUNT_OPT_ARRAY)
> > +			      STATMOUNT_OPT_ARRAY | STATMOUNT_OPT_SEC_ARRAY)
> >  
> >  static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
> >  			      struct statmount __user *buf, size_t bufsize,
> > diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> > index c0fda4604187..569d938a5757 100644
> > --- a/include/uapi/linux/mount.h
> > +++ b/include/uapi/linux/mount.h
> > @@ -177,7 +177,9 @@ struct statmount {
> >  	__u32 sb_source;	/* [str] Source string of the mount */
> >  	__u32 opt_num;		/* Number of fs options */
> >  	__u32 opt_array;	/* [str] Array of nul terminated fs options */
> > -	__u64 __spare2[47];
> > +	__u32 opt_sec_num;	/* Number of security options */
> > +	__u32 opt_sec_array;	/* [str] Array of nul terminated security options */
> > +	__u64 __spare2[45];
> 
> shouldn't that be 46 ?

Yes, apparently I can't count. Thanks for noticing!

> 
> >  	char str[];		/* Variable size part containing strings */
> >  };
> >  
> > @@ -214,6 +216,7 @@ struct mnt_id_req {
> >  #define STATMOUNT_FS_SUBTYPE		0x00000100U	/* Want/got fs_subtype */
> >  #define STATMOUNT_SB_SOURCE		0x00000200U	/* Want/got sb_source */
> >  #define STATMOUNT_OPT_ARRAY		0x00000400U	/* Want/got opt_... */
> > +#define STATMOUNT_OPT_SEC_ARRAY		0x00000800U	/* Want/got opt_sec... */
> >  
> >  /*
> >   * Special @mnt_id values that can be passed to listmount
> 
> The rest looks good to me though!
> -- 
> Jeff Layton <jlayton@kernel.org>

