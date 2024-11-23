Return-Path: <linux-fsdevel+bounces-35654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F609D6B1E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 20:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1222A2815CB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 19:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C7216F0CF;
	Sat, 23 Nov 2024 19:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nK9xsMxq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5908517C2;
	Sat, 23 Nov 2024 19:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732390361; cv=none; b=Pc824K87tUL3Rlu8h7mz2+Ca29Tdet5VbLMM848qEQCSsXTWjQ5OMFtfO8y72UoxC3moj3OLMEb66m8j/SE4MjMX+wh7qErIjPNo6FjpTQ6FUgFZtNr/apHMyQRziPTTV2AKcVm3IzFnJkm9bTe3Q5cfjMXQH5za0pKtFqd1NZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732390361; c=relaxed/simple;
	bh=Lg0IpgJwn0Vpnp+T4kN2U32G9tbnE1xy4ffKFaSQm9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kco/HlwGTU3aiyHCJuqq6x673WHVQ8zuPWWVPdpeXZasX/1iC1lHLy7ErmwPZgMZmbVSwRKlTHORTs0jJ6+o8cAZpqfeCCH13h9cIBUPvIKyf0JyhHE59xCKCGe0ti4VLG2pLRPRg7tQjgCQM6T7L+PuPQxLuHxgA77+Gx+2BPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nK9xsMxq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hi9fkCcEPnas0Xk/la00X0VgCLXoLj06CxTUedkDE18=; b=nK9xsMxqNNK4rc6fbGmO7yJVXr
	EC2Af+K/uZxrbbN3O7rnpLhY5aIlLzBtDImXM1hWCqQ33h/drqS6OkN9Wf32xnNRRYhFw/UOnoEa8
	jB8ckkJv0yqMVHtHuy2Tx58fKRzgTye2pu65K4ux4vNxqmUY3vlZKzTrZnSC0g476n8ZYgb1yc1VS
	/iu8trZ6TCnb8fr+WAk2VCOP8WZCTN/FsafDKbXnwaFQfsLYhq3xDyXwAx2VqFmSeIu/bzLDDvsBK
	VUYOkuZtqntfKi2AW3T8POCn0yaAK12dg73eAu/2Y+R+Mi1DTHeRGcPZML/0HhpEZLRZSARqDb2h4
	0sewY56w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEvro-00000000uH5-07h5;
	Sat, 23 Nov 2024 19:32:28 +0000
Date: Sat, 23 Nov 2024 19:32:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jinliang Zheng <alexjlzheng@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, mcgrof@kernel.org, kees@kernel.org,
	joel.granados@kernel.org, adobriyan@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	flyingpeng@tencent.com, Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH 0/6] Maintain the relative size of fs.file-max and
 fs.nr_open
Message-ID: <20241123193227.GT3387508@ZenIV>
References: <20241123180901.181825-1-alexjlzheng@tencent.com>
 <20241123182730.GS3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123182730.GS3387508@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Nov 23, 2024 at 06:27:30PM +0000, Al Viro wrote:
> On Sun, Nov 24, 2024 at 02:08:55AM +0800, Jinliang Zheng wrote:
> > According to Documentation/admin-guide/sysctl/fs.rst, fs.nr_open and
> > fs.file-max represent the number of file-handles that can be opened
> > by each process and the entire system, respectively.
> > 
> > Therefore, it's necessary to maintain a relative size between them,
> > meaning we should ensure that files_stat.max_files is not less than
> > sysctl_nr_open.
> 
> NAK.
> 
> You are confusing descriptors (nr_open) and open IO channels (max_files).
> 
> We very well _CAN_ have more of the former.  For further details,
> RTFM dup(2) or any introductory Unix textbook.

Short version: there are 3 different notions -
	1) file as a collection of data kept by filesystem. Such things as
contents, ownership, permissions, timestamps belong there.
	2) IO channel used to access one of (1).  open(2) creates such;
things like current position in file, whether it's read-only or read-write
open, etc. belong there.  It does not belong to a process - after fork(),
child has access to all open channels parent had when it had spawned
a child.  If you open a file in parent, read 10 bytes from it, then spawn
a child that reads 10 more bytes and exits, then have parent read another
5 bytes, the first read by parent will have read bytes 0 to 9, read by
child - bytes 10 to 19 and the second read by parent - bytes 20 to 24.
Position is a property of IO channel; it belongs neither to underlying
file (otherwise another process opening the file and reading from it
would play havoc on your process) nor to process (otherwise reads done
by child would not have affected the parent and the second read from
parent would have gotten bytes 10 to 14).  Same goes for access mode -
it belongs to IO channel.
	3) file descriptor - a number that has a meaning only in context
of a process and refers to IO channel.	That's what system calls use
to identify the IO channel to operate upon; open() picks a descriptor
unused by the calling process, associates the new channel with it and
returns that descriptor (a number) to caller.  Multiple descriptors can
refer to the same IO channel; e.g. dup(fd) grabs a new descriptor and
associates it with the same IO channel fd currently refers to.

	IO channels are not directly exposed to userland, but they are
very much present in Unix-style IO API.  Note that results of e.g.
	int fd1 = open("/etc/issue", 0);
	int fd2 = open("/etc/issue", 0);
and
	int fd1 = open("/etc/issue", 0);
	int fd2 = dup(fd1);
are not identical, even though in both cases fd1 and fd2 are opened
descriptors and reading from them will access the contents of the
/etc/issue; in the former case the positions being accessed by read from
fd1 and fd2 will be independent, in the latter they will be shared.

	It's really quite basic - Unix Programming 101 stuff.  It's not
just that POSIX requires that and that any Unix behaves that way,
anything even remotely Unix-like will be like that.

	You won't find the words 'IO channel' in POSIX, but I refuse
to use the term they have chosen instead - 'file description'.	Yes,
alongside with 'file descriptor', in the contexts where the distinction
between these notions is quite important.  I would rather not say what
I really think of those unsung geniuses, lest CoC gets overexcited...

	Anyway, in casual conversations the expression 'opened file'
usually refers to that thing.  Which is somewhat clumsy (sounds like
'file on filesystem that happens to be opened'), but usually it's
good enough.  If you need to be pedantic (e.g. when explaining that
material in aforementioned Unix Programming 101 class), 'IO channel'
works well enough, IME.

