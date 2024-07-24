Return-Path: <linux-fsdevel+bounces-24205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F0A93B492
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 18:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22081F21547
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 16:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B941B15CD41;
	Wed, 24 Jul 2024 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MKR7cml8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iNJIrxYF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jITWO29T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WtAjCJbf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E24C15B97D
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2024 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837424; cv=none; b=YMp7fWLQdymNHzwe6bBjWtxAmUzxw82yqx4WEpG6uYj9TOWH7TGJCqGBIE/pHIee9R3kB2lpkYkaq5nlkXUg/HVvEsKcjee73jt18awqTbffm3Db5JSk87MPJLjiylEIBQjf1C2q96Cg11dGIW8FPICjAoDr8MYGTPsS70ACfKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837424; c=relaxed/simple;
	bh=NNCiI/5HdKGHSfyUTZtiW9RxZonVq0PHc5ePwS7JIcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o65715dOpWmAwsOWygGob1EFkfAURQDGkE6MBAFldwXMI0eP672Dwor1CHzkPFKDW9eTtiAISNJTwFaNCnM/Z7/NBbH1zRFGEgOFInK+t6EgRdc+3keV5fYgUC0uIvs/VcDYTt67/jQmJK04zIwnSytpRIJrvq3WRfnKFBfgAgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MKR7cml8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iNJIrxYF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jITWO29T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WtAjCJbf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 21B311F7B4;
	Wed, 24 Jul 2024 16:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721837419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LNed7SSdeCFdLQ5iwV6s9oRQnUKEhI8aS6jzbg67lqk=;
	b=MKR7cml8LFNQnVp31vLK8jsSY4jMz56w9048sADZQ3Wql2qTLsduwI7scby0h1BxqZFIpV
	XvY/9HM/QKp5bfA/exy1PVIqpqT4qJvyxe0T2ilSWQThK3i2heuXVZ/4D++ogou4DNaGuC
	iyp9s7R6Aqdl3Fvxt/x5g9oLUJtVhvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721837419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LNed7SSdeCFdLQ5iwV6s9oRQnUKEhI8aS6jzbg67lqk=;
	b=iNJIrxYFZUaOWv15zVRf5tyKaGwzk+CG2J4Kq6pqwDpSx/P2ym8GlWJ4obNmJIOco9fZDA
	mx6vBeMePO0KTmAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721837418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LNed7SSdeCFdLQ5iwV6s9oRQnUKEhI8aS6jzbg67lqk=;
	b=jITWO29T6B1IH9GYx6ZLWzGkiTFxGkJhRx6jfiXFl7AtWla+qge0KJ3I3vATHiB+Fl28XP
	0QZbtUxKgbCF/Nnfn/lh+p4MI1jI85c/WYzN7h2sKMRIjXoxYFbh0TN+d4L7j+EAMSzFIF
	tNNHZ1v3MuUx1SVQMJ00I5ZahxCCSa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721837418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LNed7SSdeCFdLQ5iwV6s9oRQnUKEhI8aS6jzbg67lqk=;
	b=WtAjCJbfEdH/p/mkOoEJnfSBwvEjZBns8uTwBWb0GG9LDTtOhBICAG7gsDqfEXtEGkB0dF
	2ABI/SCp2WdQMEAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1615113411;
	Wed, 24 Jul 2024 16:10:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6PRgBWonoWZARwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Jul 2024 16:10:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C5AF9A08F2; Wed, 24 Jul 2024 18:10:02 +0200 (CEST)
Date: Wed, 24 Jul 2024 18:10:02 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Jann Horn <jannh@google.com>, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.com>, Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: Re: [PATCH RFC 1/2] fcntl: add F_CREATED
Message-ID: <20240724161002.txlikhsg7yrxojjp@quack3>
References: <20240724-work-fcntl-v1-0-e8153a2f1991@kernel.org>
 <20240724-work-fcntl-v1-1-e8153a2f1991@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724-work-fcntl-v1-1-e8153a2f1991@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.10 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,toxicpanda.com,google.com,kernel.org,suse.com,gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.10

On Wed 24-07-24 15:15:35, Christian Brauner wrote:
> Systemd has a helper called openat_report_new() that returns whether a
> file was created anew or it already existed before for cases where
> O_CREAT has to be used without O_EXCL (cf. [1]). That apparently isn't
> something that's specific to systemd but it's where I noticed it.
> 
> The current logic is that it first attempts to open the file without
> O_CREAT | O_EXCL and if it gets ENOENT the helper tries again with both
> flags. If that succeeds all is well. If it now reports EEXIST it
> retries.
> 
> That works fairly well but some corner cases make this more involved. If
> this operates on a dangling symlink the first openat() without O_CREAT |
> O_EXCL will return ENOENT but the second openat() with O_CREAT | O_EXCL
> will fail with EEXIST. The reason is that openat() without O_CREAT |
> O_EXCL follows the symlink while O_CREAT | O_EXCL doesn't for security
> reasons. So it's not something we can really change unless we add an
> explicit opt-in via O_FOLLOW which seems really ugly.
> 
> The caller could try and use fanotify() to register to listen for
> creation events in the directory before calling openat(). The caller
> could then compare the returned tid to its own tid to ensure that even
> in threaded environments it actually created the file. That might work
> but is a lot of work for something that should be fairly simple and I'm
> uncertain about it's reliability.
> 
> The caller could use a bpf lsm hook to hook into security_file_open() to
> figure out whether they created the file. That also seems a bit wild.
> 
> So let's add F_CREATED which allows the caller to check whether they
> actually did create the file. That has caveats of course but I don't
> think they are problematic:
> 
> * In multi-threaded environments a thread can only be sure that it did
>   create the file if it calls openat() with O_CREAT. In other words,
>   it's obviously not enough to just go through it's fdtable and check
>   these fds because another thread could've created the file.
> 
> * If there's any codepaths where an openat() with O_CREAT would yield
>   the same struct file as that of another thread it would obviously
>   cause wrong results. I'm not aware of any such codepaths from openat()
>   itself. Imho, that would be a bug.
> 
> * Related to the previous point, calling the new fcntl() on files created
>   and opened via special-purpose system calls or ioctl()s would cause
>   wrong results only if the affected subsystem a) raises FMODE_CREATED
>   and b) may return the same struct file for two different calls. I'm
>   not seeing anything outside of regular VFS code that raises
>   FMODE_CREATED.
> 
>   There is code for b) in e.g., the drm layer where the same struct file
>   is resurfaced but again FMODE_CREATED isn't used and it would be very
>   misleading if it did.
> 
> Link: https://github.com/systemd/systemd/blob/11d5e2b5fbf9f6bfa5763fd45b56829ad4f0777f/src/basic/fs-util.c#L1078 [1]
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks like a sensible functionality. I agree with Jeff that the behavior
wrt dup(2) / fork(2) needs to be clearly stated but is hardly surprising
given how everything else with file descriptors and descriptions works.
So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fcntl.c                 | 10 ++++++++++
>  include/uapi/linux/fcntl.h |  3 +++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 300e5d9ad913..55a66ad9b432 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -343,6 +343,12 @@ static long f_dupfd_query(int fd, struct file *filp)
>  	return f.file == filp;
>  }
>  
> +/* Let the caller figure out whether a given file was just created. */
> +static long f_created(const struct file *filp)
> +{
> +	return !!(filp->f_mode & FMODE_CREATED);
> +}
> +
>  static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
>  		struct file *filp)
>  {
> @@ -352,6 +358,9 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
>  	long err = -EINVAL;
>  
>  	switch (cmd) {
> +	case F_CREATED:
> +		err = f_created(filp);
> +		break;
>  	case F_DUPFD:
>  		err = f_dupfd(argi, filp, 0);
>  		break;
> @@ -463,6 +472,7 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
>  static int check_fcntl_cmd(unsigned cmd)
>  {
>  	switch (cmd) {
> +	case F_CREATED:
>  	case F_DUPFD:
>  	case F_DUPFD_CLOEXEC:
>  	case F_DUPFD_QUERY:
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index c0bcc185fa48..d78a6c237688 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -16,6 +16,9 @@
>  
>  #define F_DUPFD_QUERY	(F_LINUX_SPECIFIC_BASE + 3)
>  
> +/* Was the file just created? */
> +#define F_CREATED	(F_LINUX_SPECIFIC_BASE + 4)
> +
>  /*
>   * Cancel a blocking posix lock; internal use only until we expose an
>   * asynchronous lock api to userspace:
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

