Return-Path: <linux-fsdevel+bounces-43845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C154A5E6B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 22:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6027217689F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 21:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086091EEA59;
	Wed, 12 Mar 2025 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lyIhEG7r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A2E800;
	Wed, 12 Mar 2025 21:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741815444; cv=none; b=Jg0Kj4svFT2gX97zAg5BqizI1azRrask684UMdkmZIeN0od0aUCJlm32qkpdcR/umMTCZMLWIE5wd4oxfj3/V/mUrYIqtyrtzk38P9/EtNx9rfVh28wXaB7YdX0Bu97FLegpUFoqaZEB1Zx7SmZDwNbAcMqSry2W9laz9+ueH4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741815444; c=relaxed/simple;
	bh=YEOsTv/3Rk5HL7f05j3mnNxYWt1EcBEuyP5yA7kNio4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+zNAzWDb+pVK3btqIMlRoKdelplDI1pCqcaKYzjoDSkFToMqCCzXHcmi+ffZBmBr60D3o1vGrdgmxeUW2jMfMiib9CASmiMAH22sG0Zs+79btY4YQIntI1da/4XWGLhxFy8v6GbzxzhG9sZYPXHMl/ZPVwgY421DUtK0dJikkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lyIhEG7r; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+hrzzcbZtwBejj7oHmGYCjEV3UN63affo+vq1YAU5sI=; b=lyIhEG7rqLgc4X5puzZi6b/PK1
	wI1ncM8GJ91GTjYbW2MRP+5GE6eoRyGgX1i3RN/Etwl8l+n9kk5Nd164Nz/5iY51i/ceoHl1iDd0Y
	CqHErZb41hTuw92FB2cTBak5dQlRyaSg1lKAkluQLy+MzvNX1gajWKxJ+l2mLoW8SI7vsK546BGLI
	7t5GSCRZFlOMiLjmTE/FZ/qtjo+lGdv3wkKYfvxnAEgsxCyMFsfc1bJ7+cwXpsjRFCTtSPd38Uc2b
	GA4HNyvIo8+ky4IlVtZR4DtPvTdvlEYBQ9HJxOF+NbOQahBoNzs/8JxtYBMR9u0Au0/JhVIcJvZ8X
	nsx3NS5Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tsTlK-0000000859M-3E32;
	Wed, 12 Mar 2025 21:37:14 +0000
Date: Wed, 12 Mar 2025 21:37:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ryan Lee <ryan.lee@canonical.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [RFC PATCH 1/6] fs: invoke LSM file_open hook in do_dentry_open
 for O_PATH fds as well
Message-ID: <20250312213714.GT2023217@ZenIV>
References: <20250312212148.274205-1-ryan.lee@canonical.com>
 <20250312212148.274205-2-ryan.lee@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312212148.274205-2-ryan.lee@canonical.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Mar 12, 2025 at 02:21:41PM -0700, Ryan Lee wrote:
> Currently, opening O_PATH file descriptors completely bypasses the LSM
> infrastructure. Invoking the LSM file_open hook for O_PATH fds will
> be necessary for e.g. mediating the fsmount() syscall.
> 
> Signed-off-by: Ryan Lee <ryan.lee@canonical.com>
> ---
>  fs/open.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 30bfcddd505d..0f8542bf6cd4 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -921,8 +921,13 @@ static int do_dentry_open(struct file *f,
>  	if (unlikely(f->f_flags & O_PATH)) {
>  		f->f_mode = FMODE_PATH | FMODE_OPENED;
>  		file_set_fsnotify_mode(f, FMODE_NONOTIFY);
>  		f->f_op = &empty_fops;
> -		return 0;
> +		/*
> +		 * do_o_path in fs/namei.c unconditionally invokes path_put
> +		 * after this function returns, so don't path_put the path
> +		 * upon LSM rejection of O_PATH opening
> +		 */
> +		return security_file_open(f);

Unconditional path_put() in do_o_path() has nothing to do with that -
what gets dropped there is the reference acquired there; the reference
acquired (and not dropped) here is the one that went into ->f_path.
Since you are leaving FMODE_OPENED set, you will have __fput() drop
that reference.

Basically, you are simulating behaviour on the O_DIRECT open of
something that does not support O_DIRECT - return an error, with
->f_path and FMODE_OPENED left in place.

Said that, what I do not understand is the point of that exercise -
why does LSM need to veto anything for those and why is security_file_open()
the right place for such checks?

The second part is particularly interesting...

