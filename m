Return-Path: <linux-fsdevel+bounces-63035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6F0BA96EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 15:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278D2188D17E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 13:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312CD308F35;
	Mon, 29 Sep 2025 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="UVEYZsJ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FAB2AD24;
	Mon, 29 Sep 2025 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759153861; cv=none; b=IHGk8sVINSIeZFhHdLP8k5sYYT29IiwQyLjpKrXrPPONJSkMnLAld5c2C/oWm1aMWk4RDfLdVL1hEHnI4bpJhcrURkpjwbpJxvxXzaqNIJ0uAStnUeSVJJz8pTmI6q7dVbOj+/jYO6qDNreNaAGHgW1+OA3RnSuQrdZumsxmRDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759153861; c=relaxed/simple;
	bh=FCGLJ3gQ1x8pq+r+RPbGA0WUBLPRRV6F5YOHY/KaNQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=De+OkOnEiLK+K/92kwkkADoegOJg8s+ne3JtjrZkJH+Kd2Hz1W21E5Wc+XW0s51uUjUwqvFP97VN8jsTiyeFjVNjX8yyBi5gDg4wMGjn4/H9ba0yQwFenryqnVasss/1XgHBHfZK5xNKbWaDwvZgp699Dos1a9Y/Y5y4YVXR5/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=UVEYZsJ0; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=U6p5OzRV8NVMjy5kzKrrKHfil5LPBKG7T0tsPVsqnzI=; b=UVEYZsJ0K538ZWZ1EieZNxfF9H
	p+8GxHeSHMULkws3bfrOst6rZyz24n7Bsvxd1g0QjwcQK4d9pHRxi/DcwrPmmIuMfD2Zi0mDoerQl
	zH3AcfJbwSwiC1lTYEo5vwaPMduW1hwwPpeuzOlPxCdwYbtkUzOvlak6prs/hWO/UsBSToUyVX3hx
	qFLivs3RCU77K/x3J7wqJYAqAAJQmN9zuSVm7RvEdlbGF9ie3EF3S8/fKGUXJ3cVuXNM2OxuMMBX9
	bzLjSfeUKIhlGubBYvtJRf0x7t/k0IeQPJGWBtvrbb20jHJCLv9qaLVMNuT5gD/WFQbPeGGMvbYGL
	dz2q7R7oo2aDRtjWaG2NBpJMw6EwGlyLPcf9tcH25wRdmSgUkEZ8oGLko38a+cnP7QtaG9g2sbduA
	Wl/dMvFvfkmKk9lcMJrDdT7ZuTZTEt0z6g08CuAeO2iOXw2SKDhLNSImw/d2PmyXhULgmvn82BAF1
	OnqtL0B8MJ0JEorALvE3QasTNEdA+ScfVGEGt2xw4GuSN7UNUN70guHROG/dMfXbhGZ7I+SCSr9ai
	812H/aXsDoOQhXpOLVVKpKhqSs1IxYwXJwps85bQFCJ9AlUiGmUU2owkl8P2iB3zBfu8Om4bKmNt8
	ZoLVN8UxciL1w24c6DNUhQw20CnUvQg3toB4BlYB0=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
 Dominique Martinet <asmadeus@codewreck.org>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
 =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
 linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org,
 Tingmao Wang <m@maowtm.org>
Subject:
 Re: [PATCH v2 0/7] fs/9p: Reuse inode based on path (in addition to qid)
Date: Mon, 29 Sep 2025 15:06:59 +0200
Message-ID: <3061192.c3ltI2prpg@silver>
In-Reply-To: <f1228978-dac0-4d1a-a820-5ac9562675d0@maowtm.org>
References:
 <aMih5XYYrpP559de@codewreck.org> <20250917.Eip1ahj6neij@digikod.net>
 <f1228978-dac0-4d1a-a820-5ac9562675d0@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday, September 21, 2025 6:24:49 PM CEST Tingmao Wang wrote:
> On 9/17/25 16:00, Micka=EBl Sala=FCn wrote:
[...]

Hi Greg,

I'd appreciate comments from your side as well, as you are much on longer on
the QEMU 9p front than me.

I know you won't have the time to read up on the entire thread so I try to
summarize: basically this is yet another user-after-unlink issue, this time=
 on
directories instead of files.

> So I did some quick debugging and realized that I had a wrong
> understanding of how fids relates to opened files on the host, under QEMU.
> It turns out that in QEMU's 9p server implementation, a fid does not
> actually correspond to any opened file descriptors - it merely represents
> a (string-based) path that QEMU stores internally.  It only opens the
> actual file if the client actually does an T(l)open, which is in fact
> separate from acquiring the fid with T(l)walk.  The reason why renaming
> file/dirs from the client doesn't break those fids is because QEMU will
> actually fix those paths when a rename request is processed - c.f.
> v9fs_fix_fid_paths [1].

Correct, that's based on what the 9p protocols define: a FID does not exact=
ly
translate to what a file handle is on a local system. Even after acquiring a
new FID by sending a Twalk request, subsequently client would still need to
send a Topen for server to actually open that file/directory.

And yes, QEMU's 9p server "fixes" the path string of a FID if it was moved
upon client request. If the move happened on host side, outside of server's
knowledge, then this won't happen ATM and hence it would break your use
case.

> It turns out that even if a guest process opens the file with O_PATH, that
> file descriptor does not cause an actual Topen, and therefore QEMU does
> not open the file on the host, and later on reopening that fd with another
> mode (via e.g. open("/proc/self/fd/...", O_RDONLY)) will fail if the file
> has moved on the host without QEMU's knowledge.  Also, openat will fail if
> provided with a dir fd that "points" to a moved directory, regardless of
> whether the fd is opened with O_PATH or not, since path walk in QEMU is
> completely string-based and does not actually issue openat on the host fs
> [2].

I don't think the problem here is the string based walk per se, but rather
that the string based walk always starts from the export root:

https://github.com/qemu/qemu/blob/4975b64efb5aa4248cbc3760312bbe08d6e71638/=
hw/9pfs/9p-local.c#L64

I guess that's something that could be changed in QEMU such that the walk
starts from FID's fs point, as the code already uses openat() to walk relat=
ive
to a file descriptor (for security reasons actually), Greg?

That alone would still not fix your use case though: things being moved on
host side. For this to work, it would require to already have a fd open on
host for the FID. This could be done by server for each FID as you suggeste=
d,
or it could be done by client by opening the FID.

Also keep in mind: once the open file descriptor limit on host is exhausted,
QEMU is forced to close older open file desciptors to keep the QEMU process
alive. So this might still break what you are trying to achieve there.

Having said that, I wonder whether it'd be simpler for server to track for
file tree changes (inotify API) and fix the pathes accordingly for host
side changes as well?

/Christian



