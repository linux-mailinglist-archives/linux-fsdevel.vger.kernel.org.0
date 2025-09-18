Return-Path: <linux-fsdevel+bounces-62108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC24AB84103
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 12:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13015445D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 10:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B004330216B;
	Thu, 18 Sep 2025 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JlbqH5kP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB49301704;
	Thu, 18 Sep 2025 10:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190918; cv=none; b=AvhWU7odjD5uECngmlw+I24M3BIfkphm0mnDCMQxNUVdIefXtMkctiNlw/NLAV4L1D49YWqhV3vuFnbop89qejWlHzaILPEeB1pxeyWzd+W+zKkllccoTD7suH1FTTNJzqB7zBklyOuO2Pv8aKSRGC7vzbnUT7rtNvWsf5cdvlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190918; c=relaxed/simple;
	bh=JVxHPcfJfVl6A1+dmVC9RPmT2FTxshJoQpsITEGE8fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkIFNGP8Z/uvHKpd/Qdy468U6cg6DJ6RNiwhLWodsPZEKHuFpJLYT9U/Lz5zGls2v1Mh1I9g1Naukwdp/aK/+MNC3oBF0G7E1EOTM4RxujC5n7GKQcradYpHu6tYyhNM5ifsevOEhREHu96PFOdCN+6qmQtZUdijAvfi62Fqlj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JlbqH5kP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aZv6FIi9eSL3qL8XnJAHoRLOgxGsENUIhrCigdKOHjg=; b=JlbqH5kPKBogwyqvqm+gOFw9bJ
	JEiP18zKRxPI8FNwu2/nyDL+/WYfntAJ84yKQHfd91iHJTQo5x9J+QOENNmHf93S2VzFH0yWREr6H
	6St3yGbjH8XpKzkbPPHo0wz/89CL9fBbLVSNBlrHmRiiUOtIzpRidFYkNzAvm28KA2UazEMfTIK+C
	SSnYgbeUpM1EBl4oKPJrdyjnf6qsZXOYmTLrenmX6rpfBeou1SdzwVbusIolkvWtX4wR6UX1v9xuF
	rEdR54rjDASIhOxHbYE+bzViwIoZhLb5YGYEZcJk4tfP7nlcIt5k1Q5GUX5SvY6wV52A56+kSoaJd
	KjdbOnxg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzBlt-00000000gJc-2j8J;
	Thu, 18 Sep 2025 10:21:49 +0000
Date: Thu, 18 Sep 2025 11:21:49 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>, Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 18/33] mnt: support ns lookup
Message-ID: <20250918102149.GH39973@ZenIV>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-18-1a247645cef5@kernel.org>
 <20250916035633.GM39973@ZenIV>
 <20250916035949.GO39973@ZenIV>
 <20250916044648.GP39973@ZenIV>
 <20250917-garten-nirgendwo-f65f951a9268@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-garten-nirgendwo-f65f951a9268@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 17, 2025 at 11:50:29AM +0200, Christian Brauner wrote:

> Perfect, thank you!

All right, #work.mount contains this now:

commit 1b966c4471e6c3862a14f80aeb316ef636d40f84
Merge: 57a7b5b0b6d9 38f4885088fc
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Wed Sep 17 15:58:06 2025 -0400
 
    Merge branch 'no-rebase-mnt_ns_tree_remove' into work.mount

and vfs/vfs.git #no-rebase-mnt_ns_tree_remove is 38f4885088fc

IOW, merge it into your branch and do your regular changes on top of that -
should be no conflicts in mnt_ns_tree_remove() after that (diff between
no-rebase-mnt_ns_tree_remove and work.mount has nothing in that function)

