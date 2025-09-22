Return-Path: <linux-fsdevel+bounces-62416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6691DB92097
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 17:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC863B25CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 15:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71792EC56C;
	Mon, 22 Sep 2025 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKSLLI0v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BE62EBBB5;
	Mon, 22 Sep 2025 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555844; cv=none; b=XrK3kAq+/FtRvXGCrvPky7pvhY7Y0x8yOp+XL93PKcnThR9r0xXoLlgYcGr/+iltnzvX2b2HGRn7QSgpXHPyYNspOfqV2KdW58fFa9of/kxA+NRx+1hAyXslB7dECDVDf8JcFA9L0MOg5V2x66e6lUc4bnQ2+YGe4jjeeT8aF/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555844; c=relaxed/simple;
	bh=YYy92DBFXAjPJjQxoG+rR9CxNqtyxPa7ykh5/jX/CHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8pn3lR15aU0nBsq+rob+XAPtfcROKjx9x/NgKWWnCzL0p9AfuCFIbhY1khjUSKOqsM7SmqJ9zc6OM8d+6A18JjbHL0+c7dNyXwlLX6vvyiuK4BAY0v0lAtj0zTVUckp17uoOhmYviNob73McYqyqN0yhSeMdqlfEAa7qK0HY/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKSLLI0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878F5C4CEF0;
	Mon, 22 Sep 2025 15:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758555843;
	bh=YYy92DBFXAjPJjQxoG+rR9CxNqtyxPa7ykh5/jX/CHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FKSLLI0vlOJKjixkDCq21K5VVPeIBQBQlufQDBpYBYt90nFBgp+KB2Sj4vqPidWfr
	 ZOVrk+NIhSunzJTd1orDqDMssbUvUE46P9Xb9CVi+621jr9e8K5Z2dKCxeG914i1Ck
	 FtY1+s5D77KoecELR0CEn92lezaWenMAVcdgkqvDPOuebk1y7LXelFQ3cBzMOth4dw
	 7kgrrJVRqZ3WoPGK4oj3eRzR1ixDlonJPHKT6jJPRotbynj4CoUIbIqd7UrZzMxF8K
	 8zOnYTPsADcAhb+4P4M/E8rESQJarMIQuQylCHO+gRaJXeD08OSLM/+0TYr0BrOMMm
	 kI8ZsB5abMF8A==
Date: Mon, 22 Sep 2025 05:44:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] cgroup: add missing ns_common include
Message-ID: <aNFuwtu7pclqF19E@slm.duckdns.org>
References: <20250922-work-namespace-ns_common-fixes-v1-0-3c26aeb30831@kernel.org>
 <20250922-work-namespace-ns_common-fixes-v1-1-3c26aeb30831@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922-work-namespace-ns_common-fixes-v1-1-3c26aeb30831@kernel.org>

On Mon, Sep 22, 2025 at 02:42:35PM +0200, Christian Brauner wrote:
> Add the missing include of the ns_common header.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Please let me know if you want this to go through the cgroup tree.

Thanks.

-- 
tejun

