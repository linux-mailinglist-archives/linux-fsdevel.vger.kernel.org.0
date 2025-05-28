Return-Path: <linux-fsdevel+bounces-50014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91229AC7421
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 00:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E05A3B4272
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 22:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73738221F0F;
	Wed, 28 May 2025 22:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Oc1KfxHL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A813A55;
	Wed, 28 May 2025 22:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748471861; cv=none; b=DOkTC4/h2VRppetvypvXbboBjLFg3KxecuXHh82kleKcUZvHJCdvPzUGs8jP0s8H9gRz1iWJoH8NDxiPaqClG4HB0rDM1wyHLBQx1OiGJHyHlL8CFLedYiqGu3qYIY3OcB0GW6PfFPYCma7S3aVGfnMteZqvaCbLNT+Q6E7UXFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748471861; c=relaxed/simple;
	bh=xmQYotvaywYw/vHqjd6pEK8c6S0COqcKSf9drJjX+fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oa4Sf8kRgEzPggbpm7MkzRbI0o68aebeg0eej/svEHsIDgHKWBS9O6d4UNDq+Rprc6md0JnPwRaPnmIR6bx8yAvdSyKqF4qS2O3SVFEfoy97xe/grB5IgpuChx2nhGipbuMwvgkmG8pIp00Pvm8PFABmQFojgD5zEraslWk+/NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Oc1KfxHL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=edzQ9Ntr0wuVhkuHEzdr0zVPfW1RopJDB/sRSx9qXAM=; b=Oc1KfxHLpJW18hybyOdvys7lIy
	PU3NAaBnJHp5q9PyKXkKq/Atvrsz0Nktq911yn3TkNtW+xcCIHleANherqdXBd071IM+KOXBlFeEo
	Z+AJQFiSn3zKCvHth80+46fyZcgBdhuZIEGiSS1bSZ2bjreUTiGLyovVoIK/UV30kv6myOYUuFyTF
	KpL4+VHL8rWFPHn3krf1gRILl/KOHKEglH9kIg9xgMFpvMIR43h3iFgvkCDUhXceWDbqXfsDhyDHF
	H5LRD+RZXi9lVVoLYCHtvHdVxLCgLbxKiNrwoXitahBzoyt7BCi3/pdNBHNQYIr5bUGhb2NgN4Hpp
	2HiOdTkg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKPOn-0000000AGTU-00QN;
	Wed, 28 May 2025 22:37:25 +0000
Date: Wed, 28 May 2025 23:37:24 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org,
	mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com,
	jlayton@kernel.org, josef@toxicpanda.com, mic@digikod.net,
	gnoack@google.com
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
Message-ID: <20250528223724.GE2023217@ZenIV>
References: <20250528222623.1373000-1-song@kernel.org>
 <20250528222623.1373000-4-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528222623.1373000-4-song@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, May 28, 2025 at 03:26:22PM -0700, Song Liu wrote:
> Introduce a path iterator, which reliably walk a struct path.

No, it does not.  If you have no external warranty that mount
*and* dentry trees are stable, it's not reliable at all.

And I'm extremely suspicious regarding the validity of anything
that pokes around in mount trees.  There is a very good reason
struct mount is *not* visible in include/linux/*.h

