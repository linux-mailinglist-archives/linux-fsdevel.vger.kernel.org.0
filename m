Return-Path: <linux-fsdevel+bounces-49294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39708ABA376
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 21:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6741B647A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 19:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61EE27FB22;
	Fri, 16 May 2025 19:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PsgnQFrZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C3B1D5CED;
	Fri, 16 May 2025 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747422819; cv=none; b=XBsgcmN5YYEGo/bzILxF5xFBxyqEgy9OB5JRKN9axDzaHExjxkCWfIo1JASQY4i+sC8HkvBSa6lKdzqUjXgYhRnC0hen9p3R0KDB4BvsCmhGXhcBuF5zMPLzQ2b7fO9/63Rl7ZjyoDJgcJXPp9dtGVwFmQiI/67c6kAeY+u/Pwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747422819; c=relaxed/simple;
	bh=877sdy4L1XQE0LNseMg4OF4dsHi4Api4JGGyam5M6s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksHHfTFt/8KYXChFG+DVsOpLtaDdeB09ifxVEwBhNU3yoNQzIq/UdBob/r8RetNyFCfY/1WA5Clu6PDFZPFuAK0OgEXRkXHgqXYMxHUE0L65lw6eonsnnGgWzSLHiMCkvGg1TZJ4v8dl5aor9+KmIv1/aoNePYN6hijw5lFhr/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=PsgnQFrZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3r5Ervae9OKRmSMAEu7DU30JOLXYxeoeS3A7diPROKM=; b=PsgnQFrZQwb7PxMPb7jA7yX95K
	0haY9VqZVqnSIuVQzCMbnl/jEyAJlrxk7pmQIViBeXOaZg6C41USeEkrIitIXuA/nPJv2dCc6MfI/
	7GlgB8sqSwd0xh8vCBAcZlgvc1c0IBFaiB4W3Gn9s4vffw6gTJ2fDE8ogXjBRSng0MDImIoB7LUox
	ZKvxnaB6SlRPQjVAggwh6I4NZ63DAjkOYF5R8zi9mOjLOMcaY3O5wEpVQeyAVHWCPN8SiObXtmuIP
	JAscm0LzrjjT/n6LG0XHwUfrxWhz5wKisx7A2ZEEmy7kSJqLgcXMZHHW2xRBqL7YqGMG5WxdnnpEV
	2ESxTp+A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uG0Uw-00000002PwV-0Zwr;
	Fri, 16 May 2025 19:13:34 +0000
Date: Fri, 16 May 2025 20:13:34 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: Alejandro Colomar <alx@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org
Subject: Re: close(2) with EINTR has been changed by POSIX.1-2024
Message-ID: <20250516191334.GR2023217@ZenIV>
References: <fskxqmcszalz6dmoak6de4c7bxt4juvc5zrpboae4dqw4y6aih@lskezjrbnsws>
 <ddqmhjc2rpzk2jjvunbt3l3eukcn4xzkocqzdg3j4msihdhzko@fizekvxndg2d>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddqmhjc2rpzk2jjvunbt3l3eukcn4xzkocqzdg3j4msihdhzko@fizekvxndg2d>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 16, 2025 at 12:48:56PM +0200, Jan Kara wrote:

> I'm not aware of any discussions but indeed we are returning EINTR while
> closing the fd. Frankly, changing the error code we return in that case is
> really asking for userspace regressions so I'm of the opinion we just
> ignore the standard as in my opinion it goes against a long established
> reality.

AFAICS what happens is that relevance of Austin Group has dropped so low
that they stopped caring about any BS filters they used to have.  What
we are seeing now is assorted pet idiocies that used to sit in their
system, periodically getting shot down while there had been anyone who
cared to do that.

Sad, of course, but what can we do, other than politely ignoring the... output?

