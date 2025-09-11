Return-Path: <linux-fsdevel+bounces-60904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AD7B52C67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF845A28D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 09:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADB72E762E;
	Thu, 11 Sep 2025 08:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7X39oPG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16AC2E6CBB;
	Thu, 11 Sep 2025 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581198; cv=none; b=qsvfk3RMjsvbFVaQpfRsNNFyZ/NmXOnj9p0tx8qZhP+6slgmPPV02SFQ0/SrPdizI41xA6pZCZWhMO9+xeV4HmWVXyOFbRmoNq7iCKJmQmEEbl4aONyZn1iXcQ35AqBKfNJ3ZCaIo/UB80J1L9dQKLKN2k4ywfGJGLFQXlWU3RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581198; c=relaxed/simple;
	bh=di3tOqn8KDjRSNmUzjcZz5ibzOySkfRcW/PH6lItTeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmc7/+7WB5MB/9q/Sshafgbu6iUGcIg1YKyP0+RBF6Mb5qsqSRKbF9aIQbqb6bN5rbZuqwVC4v2nPLFnxc5Sxig47d8X5anFs/zmkCmnIfvlFrTM55dswBS4Xyp5SIHsrTEczpAmy8FeOyd0l2M/qElkJiSLz9fB6K9j5/zwpa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7X39oPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE82C4CEF0;
	Thu, 11 Sep 2025 08:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757581197;
	bh=di3tOqn8KDjRSNmUzjcZz5ibzOySkfRcW/PH6lItTeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d7X39oPGOFriWKB/puO3tXJcs5u3pQmXfNPNNI8u5ge2mMCrfGBsH2Rh7NKcXunnn
	 ObfoQli7du9d2GcWiz3ksJ57w7LGYFGJuZEsrqz1lxF9fFztZFpwweu8GBTjFMKdWd
	 zkPbcElNMpHhcq3l0yKWfScfPTbVH2XNqm8qoZmuCWitfZdeAa/oZeWsoXXdZlx9mu
	 S5M+MpRqQMTueSmR81hl4/YoijM9bnmlnmtRyzMgTXGtJCEvBAcQyUyWmzxy6VanGx
	 iQETccGAWvBynljLCuzzzQgxgMZHVVp4JjtBQabjYy+linbjJ4XAqaGypJIvHsXRJw
	 rzS47xbNu5qTQ==
Date: Thu, 11 Sep 2025 10:59:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 32/32] selftests/namespaces: add file handle selftests
Message-ID: <20250911-vorurteil-gemacht-c62d1349fc33@brauner>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-32-4dd56e7359d8@kernel.org>
 <f65cf3ae-069d-4ade-9fc9-03f01c7e1649@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f65cf3ae-069d-4ade-9fc9-03f01c7e1649@acm.org>

On Wed, Sep 10, 2025 at 02:46:21PM -0700, Bart Van Assche wrote:
> On 9/10/25 7:37 AM, Christian Brauner wrote:
> > +	snprintf(ns_path, sizeof(ns_path), "/proc/self/ns/net");
> > +	ns_fd = open(ns_path, O_RDONLY);
> 
> Here and also in TEST(nsfs_uts_handle), ns_path is not modified. Does
> this mean that "/proc/self/ns/net" can be stored in a static const char
> array and also that the snprintf() call can be left out? In case I would
> have missed the reason why the path is copied, how about using
> asprintf() or strdup() instead of snprintf()?

Yep, that can just be a static string. Thanks.

