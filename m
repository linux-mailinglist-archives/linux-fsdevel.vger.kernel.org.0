Return-Path: <linux-fsdevel+bounces-51659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2BDAD9A58
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 08:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34FF717D3B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 06:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967131DED60;
	Sat, 14 Jun 2025 06:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="sv2H5qJl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD0F23DE;
	Sat, 14 Jun 2025 06:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749882055; cv=none; b=kSJ6dt54J8rPhJ9fw2G04w0ZLcRiJx7eGxoC1fZ3skKzsvTEo5yNtelSNGFcBjuPYf2WCVKbN/FwqJKIHGRHimKiM+gebbVmjaM5QXKE+MT3PQ8d0DSNWjQlQE1/oVHzvFzVfeoyzBz6hdLAC4q/a7FMvw/5+NF8Wqg10QZlj+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749882055; c=relaxed/simple;
	bh=Y4VZ0mIVGO43zUhEHGQbLBdI73QT+rbvtERI624NnCE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MkF5xhNpBlBuiTYnHXYWSFbYih8beQePTOz86MdlI43WQ8vlf7OZOw8AW1SbfZnF2VKMVAObufh85dCh0mszRI/tsOrVsWqG4Z0Q1ErJmrD5Ex0n/0skt9v9w7j/WSnlvNSsFM69o0WGDfCyoK6zGgyc6KlR3Srl7uj0PlVvZvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=sv2H5qJl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=QPHguXyshzZzTGRSmBks3eALH+eO8BLLetl0Op2INqg=; b=sv2H5qJlSCoVCsa44VsW9MxYJI
	bmshRvdcGlnm3+dFdo32GglBTwv37Wo8omMFU88WoT1pB2Fso3mYB24F5DkMRo9yGYjiprWN4XEBv
	Ec7AWxqWc0CyotlCkq7/ZsIgCtMG1bLTVl8O7gWh2B9cQcn4MbeLU47XeBm6LkrT7VCeyihsLGGhT
	GAL1yJICPolBpsOKvzw5MMvbvTVVaScD9j18XFoDagce1SSk9pEA009p9mSgR+MZngRRXC466lvXB
	tqIQvndBYvbcWsH0oNSga4pEjyhfOGsKjIWr4780hOAT9oy9jOEAU2osTZbbBnv3eBwATOcK5tBEH
	Pd8ZlIXg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQKG3-00000002DtV-3L3c;
	Sat, 14 Jun 2025 06:20:51 +0000
Date: Sat, 14 Jun 2025 07:20:51 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, ceph-devel@vger.kernel.org
Subject: [PATCHES] ceph d_name race fixes
Message-ID: <20250614062051.GC1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Series of race fixes for d_name handling in ceph had been posted
back in February, but apparently had fallen through the cracks - I expected
ceph folks to pull (or cherry-pick) it, they apparently thought I'd send
it to Linus and nobody checked what actually went down...

	I've rebased it to 6.16-rc1, with a couple of cosmetical changes
suggested back then.  Currently it's in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.ceph-d_name-fixes
Individual patches in followups.

	Folks, could you test and review it?  I really don't care which
tree would it go through, just let's make sure that everyone agrees who
pushes it out...

Shortlog:
Al Viro (3):
      [ceph] parse_longname(): strrchr() expects NUL-terminated string
      prep for ceph_encode_encrypted_fname() fixes
      ceph: fix a race with rename() in ceph_mdsc_build_path()

Diffstat:
 fs/ceph/caps.c       | 18 +++++-------
 fs/ceph/crypto.c     | 82 +++++++++++++++++-----------------------------------
 fs/ceph/crypto.h     | 18 +++---------
 fs/ceph/dir.c        |  7 ++---
 fs/ceph/mds_client.c |  4 +--
 5 files changed, 43 insertions(+), 86 deletions(-)

