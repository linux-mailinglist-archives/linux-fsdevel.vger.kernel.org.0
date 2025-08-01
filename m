Return-Path: <linux-fsdevel+bounces-56537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82197B18912
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Aug 2025 00:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69DC14E02F4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 22:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDE82264A1;
	Fri,  1 Aug 2025 22:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="r1BlZvi8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B182E630;
	Fri,  1 Aug 2025 22:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754085741; cv=none; b=qcr6ajJY/E7VhscXIt//djLN4vBm+82Gd4UXVh8oxWBMyN4LhFOQWDDxA8JjBBfRXWX3UkjivaV+CD9TQb1WiN7sfSHRaS4zHozDcPIbi8Zj6JYOPg7Qjs/eLjrYcU1ri2xK63MqMsXsZHhMAFXTs11wxKmXwjLHUzNDqPj46hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754085741; c=relaxed/simple;
	bh=O6TIqBiOGFX2hC9KjwxsvIHMeLSf2YQDy1J/KHF416Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUtnYNO1ZPlOT7StpRzJSXoz7xWUc8HqU0b9VVhgbpBkMgN2o9oBdqjB7pgJuv0rrP0olq7o+cq7HPP3g3DPiTqWY5n4GToy+bMYvIbwevhVwFye08p5cwABrdSZFwMExrmV4TS+HKHV7H2JNUfGy0nWPKwmBxcA6dZdlXy7sFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=r1BlZvi8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=owta+X3NcgkTdhOwj+zQx9oNDSxqNnmvxaNHTrw4HBw=; b=r1BlZvi8H3AwcZHx0HHEiBaPYV
	1CAaZbw/VY7BhoTJtwhtzXfamQrq/XLGJ7i8mZtSu+K4NMqEBy5R2/AiISJDfvj7McO7BF98RLh16
	9RRrYfytXV5qSO5IQCnrERy7E7wdHLTeHAZ6atR/mO3Ej+jLo2CPWwNhiTDZEg5Xpb4uBCZCDjkqB
	EQ6JvYuVSWQdlw0gq+rtR+aVIkDibAZBs5Wy8RkJZQ+OeOeeFcH1nHbXIgKdMQuf2E4NZmshjFsFj
	VQAVoB/CD1xHjFQHxmC+RrkAfLPO62WpOPXicb2Cc4H6+DxcXCqu7vnSk757QEXwq+CbDPAPFPu/s
	YMN8nRvw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhxpP-00000002VMa-46DH;
	Fri, 01 Aug 2025 22:02:16 +0000
Date: Fri, 1 Aug 2025 23:02:15 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Christian Brauner <brauner@kernel.org>,
	Sargun Dhillon <sargun@sargun.me>, Kees Cook <kees@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] fs: correctly check for errors from replace_fd() in
 receive_fd_replace()
Message-ID: <20250801220215.GS222315@ZenIV>
References: <20250801-fix-receive_fd_replace-v1-1-d46d600c74d6@linutronix.de>
 <fq2s55tc5hhvh4dfjdzek4neozffmn36rwdlsrsxxjqzts2f4c@j67nruhocdiz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fq2s55tc5hhvh4dfjdzek4neozffmn36rwdlsrsxxjqzts2f4c@j67nruhocdiz>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Aug 01, 2025 at 12:48:09PM +0200, Jan Kara wrote:
> On Fri 01-08-25 09:38:38, Thomas Weiﬂschuh wrote:
> > replace_fd() returns either a negative error number or the number of the
> > new file descriptor. The current code misinterprets any positive file
> > descriptor number as an error.
> > 
> > Only check for negative error numbers, so that __receive_sock() is called
> > correctly for valid file descriptors.
> > 
> > Fixes: 173817151b15 ("fs: Expand __receive_fd() to accept existing fd")
> > Fixes: 42eb0d54c08a ("fs: split receive_fd_replace from __receive_fd")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> Indeed. I'm wondering how come nobody noticed...

One word: seccomp.  Considering the background amount of bogus userland
behaviour coming with it, I wouldn't expect a... vigorous test coverage
for that one ;-/

It's definitely a bug that needs fixing, but I'm not sure this is the right
way to fix it.

Look: replace_fd(fd, file, flags) returns fd on success and -E... on failure.
Not a single user cares which non-negative value had been returned.  What's
more, "returns fd on success" is a side effect of using do_dup2() and
being lazy about it.

And the entire thing is not on any hot paths.  So I suspect that a better fix
would be

	err = do_dup2(files, file, fd, flags);
	if (err < 0)
		return err;
	return 0;

in replace_fd() in place of
	return do_dup2(files, file, fd, flags);

so we don't invite more surprises like that.

