Return-Path: <linux-fsdevel+bounces-26593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E28D95A8D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 02:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C141C21D9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 00:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF0B4C8D;
	Thu, 22 Aug 2024 00:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gpCJK+AM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB023B641
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 00:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286567; cv=none; b=NKK6wmh5GAl4Be1eZhAvlrtqUCVWNlfQ47NpNMxsLHK8qqt5cZUaPcasids7e+My93HEG5NqnceGSdj6rXZcCHIgOBCWtDiQ9Ra+ZGsqJK9mFWSC9/JGk9rhXxx0KlJqKYbMNAtKiWFPeGt9qoIHc5USokVesKsBSR13UNVPgcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286567; c=relaxed/simple;
	bh=lsS+yiae1WAzXexJhFdK5TT4GNCVjbQXppY8+BbworM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHc6GgnKHOL+D361LvjbX21F9y6icQMG5Pxf+GPGbzEV1O/jTcPzqVRizn73yWsgWIbCtPJRy2+SR7wGP/m15bIjPcaaEvOIThNfiRZpb8/wqgMTlmfvJ7m9nl4Lhn/afBx7W6wz3SjPEY2bD/2zEXGrApQfC3+qJnaOzowvOrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gpCJK+AM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kGDQYbC8qypiT4m0fJt+09ZAK1zE2sNw7WPJdY9LOOA=; b=gpCJK+AMtryzj3NxN0zDt9z63c
	Jn/c7h+tY4ffYsJNq+RYN7GxikQDh3WAQpBsK9VGrJ/xL7zeyyvXFFCgC53X1oOJKE3/XyWIvGemS
	Fec0urCA0gyZhIbyk9l8Opnvf6q/Itp/9i3dfgsNM+GQc+zBri1N5eNA3QfMIh7inLYD77e7rwZ+O
	Z0jjX4o0LCGqOaoTfmrk8BbeH+Q99VC9rLDU40bj6xg76gemtSi043pNnfKm1iMTNv7uoz/0EUqv6
	RPB3USODanpez1kz5cB22epSaDJLrWnmiJ82C8QJex/Pk0uruHv8qTYA7nhOvhonqNg+d8ABs8ZMG
	zvz+OdtQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sgvhZ-00000003wEk-3Fkj;
	Thu, 22 Aug 2024 00:29:21 +0000
Date: Thu, 22 Aug 2024 01:29:21 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/4] amdgpu: fix a race in kfd_mem_export_dmabuf()
Message-ID: <20240822002921.GN504335@ZenIV>
References: <20240812065656.GI13701@ZenIV>
 <20240812065906.241398-1-viro@zeniv.linux.org.uk>
 <20240812065906.241398-2-viro@zeniv.linux.org.uk>
 <09a1d083-0960-4de7-ab66-527099076ee4@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09a1d083-0960-4de7-ab66-527099076ee4@amd.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 14, 2024 at 06:15:46PM -0400, Felix Kuehling wrote:
> 
> On 2024-08-12 02:59, Al Viro wrote:
> > Using drm_gem_prime_handle_to_fd() to set dmabuf up and insert it into
> > descriptor table, only to have it looked up by file descriptor and
> > remove it from descriptor table is not just too convoluted - it's
> > racy; another thread might have modified the descriptor table while
> > we'd been going through that song and dance.
> > 
> > Switch kfd_mem_export_dmabuf() to using drm_gem_prime_handle_to_dmabuf()
> > and leave the descriptor table alone...
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> This patch is
> 
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

Umm...  So which tree should that series go through?

I can put it through vfs.git, or send a pull request to drm folks, or...

Preferences?

