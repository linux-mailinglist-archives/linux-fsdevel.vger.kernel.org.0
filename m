Return-Path: <linux-fsdevel+bounces-61694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A5BB58DA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 06:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C4F1BC4D81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 04:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD412494ED;
	Tue, 16 Sep 2025 04:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vJo1rW7o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78131C75E2;
	Tue, 16 Sep 2025 04:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998523; cv=none; b=X8y08rTIdxw2MbsmPWVU1xf3X1UfXGyjBVbIzxI7tMh0gWbyUGZBCXzAb5dWWNAlrO6cCB5UqSFcGQ+AXeuVAAWlKFYdW6TXfinbvZrclzCUEv0mxLI1g6pBZghXmFLmPjo7YtZw1XsJ2pL/rDjT7vDsY2AHZ9a3prZfEVaeKZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998523; c=relaxed/simple;
	bh=StiPQtnvbkOQeER7YWId2jlb+ZLI0M7NP2wd91RD+B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmlAd0M0joeHKoZmWRoFuDkoUwT2NbOX1MrWFkG/js8AbW9E/gKkBG6tdHVPtUbYG/SpRYXnjuIytJilHvrQG+MLSOwVK/XGC0PGuzuWiip4HN+iHY/CuW/rrwub1NO4fZ0qnyspdfrmbazirNBSfJ56QsS46mfdbNv9l1iHzrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vJo1rW7o; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=StiPQtnvbkOQeER7YWId2jlb+ZLI0M7NP2wd91RD+B4=; b=vJo1rW7olNwfuNc5FR0pjMX6/9
	qC+ZZ61UqHO7M9LtWzS3LWXKjnfcvuwaOa5Qc8Y6b7q3DhI5HpAV7gvAUIzHnHeCynmW4WfTIOl0g
	nINC1N8m7RIt6nq8NnqUfHa4tvWhP6vp1LnBAJ93G8FU5DvWFNZvi0SprrHKQxpeBEERwzleTPUWL
	Ff3hVuMyE/7X5j7QIxvW4Ju5dBbQFuk9B0Je8gRsA6dmzOreHhHY0uzFKMfrRoemNejTtQiFwfDy9
	N/3en7D+hJGJhpeBshYW5pbFaIHSjQieAExsjN1iYKs3c4idvVqx5lcJZHm0UFFCOVnmrpLzjnCty
	p7K951cg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyNio-00000006Zf2-2k8M;
	Tue, 16 Sep 2025 04:55:18 +0000
Date: Tue, 16 Sep 2025 05:55:18 +0100
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
	netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 00/33] ns: support file handles
Message-ID: <20250916045518.GQ39973@ZenIV>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Sep 12, 2025 at 01:52:23PM +0200, Christian Brauner wrote:

A nit on whatever script you are using:

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585

is less convenient than

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585 (v6.17-rc1)

