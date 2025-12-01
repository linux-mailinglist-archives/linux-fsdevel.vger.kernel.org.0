Return-Path: <linux-fsdevel+bounces-70296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5028AC960F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 08:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FBC13A23E2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 07:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7A22D77E6;
	Mon,  1 Dec 2025 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jFUYohsa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F30D2D47E3;
	Mon,  1 Dec 2025 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764575673; cv=none; b=XLeCdda+lSfNgROqp4jiwrGpu2UEKxst2QKHpwm2trexHGprEp+KD+4QC0ze0byJTRPNvu+FtpRnHRZOx9cv+ymUKhv+j1+tLd7meAxis6HOhX9dpBxHxqWk1XJZDywLFF/r2kzKo2xx7D+KJ2yTQ9l9nEeD4M/3ZGJ82SV/3ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764575673; c=relaxed/simple;
	bh=CUAC5oeEDjDfjvMyU44gdFseCPIBh8LT1gYe1+sSwkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmtguGsSQ9+ZPkYy9Wh8FuwysyWr93Ayeo+3TMyGHD8uxknJtED5JX5t3IZwy3oavpg6YW4buVoY7xAvQ0mozSaOLoyg7tgbDMakGl2sQshyNuG2ICIRa6cIgI+NKerlO/HC8VSG/PM8+GPnWM5Zu/XIK6OtKFEOd0wdvtiMeOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jFUYohsa; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R/6q8DeJJMUj7Gf3WzP5dzvEK3OAmbqfRK6RdwqA/2g=; b=jFUYohsaSLVc6OmctHvdGBVIQa
	2QtmA5Z4sXddF4e7iIW83mVnb3k2qrC97vhRoHZY/oTqEbmv5xArBpQHDOzMsQvWKO7pKF+1VK/s1
	gtreSv4x1cUy5OiqehKMLEZYWYPmn9RQMZVlqnLsV4OcyLja9Csvo0oczoZy2IlapJmcF6U84TWiI
	JbJ1dm4WqE/DKsOPxXVOcWDVzCkQy0DBF6NDZLyVUcwdJL5axfW4I2rGX3PzOlsrPlvqC1rlxcDIh
	m3feyEyJgds5OHFWe5TqZ4ToHRDwGRcYZ0sJ8yawS/xl8JYMdSoDsFam7BMoldaBIJ6CL0btzWxr7
	+f+IfAIQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vPyk4-0000000Av7D-2AkJ;
	Mon, 01 Dec 2025 07:54:40 +0000
Date: Mon, 1 Dec 2025 07:54:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: move getname and putname handlers into namei.h
Message-ID: <20251201075440.GZ3538@ZenIV>
References: <20251129155500.43116-1-mjguzik@gmail.com>
 <CAGudoHHnzB5-OWujgJsbyvCfo71QDkbgwsvWeqOady6BCi8Fcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHHnzB5-OWujgJsbyvCfo71QDkbgwsvWeqOady6BCi8Fcw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 01, 2025 at 07:27:05AM +0100, Mateusz Guzik wrote:
> self-NAK, i'm going to rebase on top of
> https://lore.kernel.org/linux-fsdevel/20251129170142.150639-1-viro@zeniv.linux.org.uk/
> when the time comes

	FWIW, I'm putting together struct filename-related
branches for the next cycle (trying to figure out what's the
best way to linearize the mess I've got).

	If you throw a patch on top of the series I've posted
on Friday (and it should shrink a whole lot - the damn thing
is static in fs/namei.c now, with cache initialization done
in the same place) I would be glad to apply it.

	Other series around struct filename for the next
cycle:

* DEFINE_CLASS(filename, struct filename *, putname(_T), getname(p), const char __user *p)
EXTEND_CLASS(filename, _kernel, getname_kernel(p), const char *p)
EXTEND_CLASS(filename, _flags, getname_flags(p, f), const char *p, unsigned int f)
EXTEND_CLASS(filename, _uflags, getname_uflags(p, f), const char *p, unsigned int f)
EXTEND_CLASS(filename, _maybe_null, getname_maybe_null(p, f), const char *p, unsigned int f)
EXTEND_CLASS(filename, _consume, no_free_ptr(p), struct filename *p)
and an bunch of conversions making use of that.  Generally I dislike RAII
patterns, but uses of struct filename make a reasonably good fit.

* change of calling conventions for do_filp_open() - let it DTRT when
it's given ERR_PTR() for name.  Surprising amount of error handling
in the callers (and callers of callers, etc.) folds into that.
One thing that is very tempting is s/do_filp_open/do_file_open/,
while we are at it...

* killing pointless checks for IS_ERR() before calling filename_lookup()
and vfs_path_parent_lookup() - those already treat ERR_PTR() for name
as "bail out immediately".

* [currently very tentative] dealing with __audit_inode().  It's
a surprisingly convoluted series, and it's not quite finished yet.
Not sure if that one won't end up slipping past 6.20...

Linearizing that stuff into something that would not be a hell wrt
merges is... interesting.

