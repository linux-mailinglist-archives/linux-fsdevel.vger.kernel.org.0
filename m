Return-Path: <linux-fsdevel+bounces-17701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9CB8B18E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 04:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB85E2869F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 02:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8E71400A;
	Thu, 25 Apr 2024 02:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MSUEozUS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1736917F0;
	Thu, 25 Apr 2024 02:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714012295; cv=none; b=EJ37bnKMynDiK0Dgqp5ET/yNfNCDc73F8cpeTpkauko78oztZKguoJ6QcGMAk5nZSrt2l++A2XIW+SWfZCThfIpL+8PgpevAFJUXoYOQGLI+NE31aOzqhiacJUA9eh6izqBBqevyEmuHrVfVo4dkdZWm7GGN9sO6WkbK7sg6NmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714012295; c=relaxed/simple;
	bh=ARzfkq7YcdKT4xz/cUqUlVMU5c8TPIVAaHLUeTeELbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEAnf9gtf0XfziczJiys0s8zCFcreubE/Zgbbe44HZjrMHyF8fBSxClZQ/dP6xMi0taK1M8fFe6LalJ67UASNMNgzMZamZrNZqRA5iXeXRGD8EV6I9PeDW0LuXyGGxscPqBudAozdqem4es6QBw1dWt0LeD12JzYDza4yZE3b1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MSUEozUS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f3k/PjvK9lAek9tiVMgNp+BViodAxP3rcx424XtNi30=; b=MSUEozUSQoux6VChf23xTp6fPw
	5xDGvJRnC73gTe4qn2HhX9dZCAq6ZBbXat5JZ7/PlyhMV6Wwc0CkTPM0fkqj08Nqwj4VwjNmZJ09j
	rg3j4WHeozmt/suOty9EpbRiaqfrq7YtMStvQBnrBXM/khtw4H89QPLpbt0pEFQJMSVkSujSXPKQz
	EO5kQSdVCnnMpmyEAT5sk1m2vkmfJQmOMEWQuX7GFjxelhc24+DbOza80/SdUlN9xfwlujVnhL38t
	beId3xP/kgnEGJ0eNztSoueXClpHi02fn2Oy6dYlw6KtzuMnth7VtbSWEBcsBxcQrNAxdNHin60ZY
	zD4aIFcQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rzotT-003JDu-2Q;
	Thu, 25 Apr 2024 02:31:27 +0000
Date: Thu, 25 Apr 2024 03:31:27 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Stas Sergeev <stsp2@yandex.ru>
Cc: linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Andy Lutomirski <luto@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH 2/2] openat2: add OA2_INHERIT_CRED flag
Message-ID: <20240425023127.GH2118490@ZenIV>
References: <20240424105248.189032-1-stsp2@yandex.ru>
 <20240424105248.189032-3-stsp2@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424105248.189032-3-stsp2@yandex.ru>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Apr 24, 2024 at 01:52:48PM +0300, Stas Sergeev wrote:
> @@ -3793,8 +3828,23 @@ static struct file *path_openat(struct nameidata *nd,
>  			error = do_o_path(nd, flags, file);
>  	} else {
>  		const char *s = path_init(nd, flags);
> -		file = alloc_empty_file(open_flags, current_cred());
> -		error = PTR_ERR_OR_ZERO(file);
> +		const struct cred *old_cred = NULL;
> +
> +		error = 0;
> +		if (open_flags & OA2_INHERIT_CRED) {
> +			/* Only work with O_CLOEXEC dirs. */
> +			if (!get_close_on_exec(nd->dfd))
> +				error = -EPERM;
> +
> +			if (!error)
> +				old_cred = openat2_override_creds(nd);
> +		}
> +		if (!error) {
> +			file = alloc_empty_file(open_flags, current_cred());

Consider the following, currently absolutely harmless situation:
	* process is owned by luser:students.
	* descriptor 69 refers to root-opened root directory (O_RDONLY)
What's the expected result of
	fcntl(69, F_SEFTD, O_CLOEXEC);
	opening "etc/shadow" with dirfd equal to 69 and your flag given
	subsequent read() from the resulting descriptor?

At which point will the kernel say "go fuck yourself, I'm not letting you
read that file", provided that attacker passes that new flag of yours?

As a bonus question, how about opening it for _write_, seeing that this
is an obvious instant roothole?

Again, currently the setup that has a root-opened directory in descriptor
table of a non-root process is safe.

Incidentally, suppose you have the same process run with stdin opened
(r/o) by root.  F_SETFD it to O_CLOEXEC, then use your open with
dirfd being 0, pathname - "" and flags - O_RDWR.

AFAICS, without an explicit opt-in by the original opener it's
a non-starter, and TBH I doubt that even with such opt-in (FMODE_CRED,
whatever) it would be a good idea - it gives too much.

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>

