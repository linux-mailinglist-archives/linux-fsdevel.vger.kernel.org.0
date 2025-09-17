Return-Path: <linux-fsdevel+bounces-61964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4477B8100A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 18:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE86189705E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 16:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257992FA0DD;
	Wed, 17 Sep 2025 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDoYqwl3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0382FB080;
	Wed, 17 Sep 2025 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126620; cv=none; b=ugsudGPO4z+VukRTi2op6qeCYsFVRLsjSoU3i/zGwNthSwlEWhqgrMDYc0YpQq/hLslRKII9k4a8ySt+B6c1ZF2QcZH4KBDNPBrbvsJRnkEYVzVH93u9m8c99obgmy++BOxTMirRKALjmLeH+yOH7Y2fskLWmE8kPmjE5ADOo/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126620; c=relaxed/simple;
	bh=J2RbGNo8hmkWZJwKMy2/rPkrrfBz9U7a1d82RrVEhg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/F79RjQwXhro9ljz6qZwMSxa61S/MpWHVg8+znyQFe2R1RvsNKS8yVf/rlCius39JuqOQZkCEq9Tt6DwEIm5ABt0dxN/76q8x23Zd96NFdOBtZEl1WyACiREwE73q3fUm8eGWL+1DTtOcsl0AFVkIPcT+4GmoapbesHzhURZ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDoYqwl3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24881C4CEF7;
	Wed, 17 Sep 2025 16:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758126620;
	bh=J2RbGNo8hmkWZJwKMy2/rPkrrfBz9U7a1d82RrVEhg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tDoYqwl3r7Ntiu3ohC9tLwyUv/h/wXmF9lj3mg6+hy16qoUrAlFS50N032aLpDXUI
	 CZdpV1XOAax40M8lCY2f2odqT2PzfdUYQUM/G2PWYF5AuaFGF1jVh54cocFsfG7ky9
	 SAydRDVAEl/jhHYKWzdxE/lkMfOy4Oql/Er6iL7zWvjBzh2OeQTP8aiHr3cjq2yxVK
	 ZxzR1ZQDdf4BS/M5JTLofGNOhDcLob8Clvcef30kFMnxAxxulHfMFuyAl0LnRSZeXh
	 BMbjQSRP7hBaVyAOXzMg7yd/WpchYyGgrTN83dvSDrCmuW78gZIe82GLb26oDn/icg
	 SPevBCgWdJMqA==
Date: Wed, 17 Sep 2025 06:30:19 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 4/9] cgroup: split namespace into separate header
Message-ID: <aMriG6gHCQt2uf2w@slm.duckdns.org>
References: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
 <20250917-work-namespace-ns_common-v1-4-1b3bda8ef8f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-work-namespace-ns_common-v1-4-1b3bda8ef8f2@kernel.org>

On Wed, Sep 17, 2025 at 12:28:03PM +0200, Christian Brauner wrote:
> We have dedicated headers for all namespace types. Add one for the
> cgroup namespace as well. Now it's consistent for all namespace types
> and easy to figure out what to include.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Please feel free to route with other changes. If you want it to go through
the cgroup tree, please let me know.

Thanks.

-- 
tejun

