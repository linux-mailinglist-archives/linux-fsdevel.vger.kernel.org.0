Return-Path: <linux-fsdevel+bounces-39445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38A5A14405
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 22:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE54B1641E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 21:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88F423F287;
	Thu, 16 Jan 2025 21:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WQkWuF3/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAFE241A03
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 21:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737062956; cv=none; b=FcZXofhxbsAVJqN3rv9z9DwbbJAl6yGIrqBjQh+p1DFWpbvd/+AarDDDLlohmBexUazQvVJ6tkrQ99goGY1Gpbe1fFCKacobteXDjtuPQ4wMdoGftXjygRfzzzo4HdpKnA2GgIatVGQAjThWbNxXPcYrN9iJa/iXsqmSF2ND/Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737062956; c=relaxed/simple;
	bh=30Y9t17B0OfTGF9k01UUUYKA70LCZEXNRIiXE76WX1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajbbimrF5xvFNIFEZisa0pI9R5JbGaIM3XY/jlOaMVo8NUe+OGZB5dWo6u6NwwH1gTHYsQhi0M3X6IWjVMQwTb1H5HFKyYVNrhM6zEK7rnOJR4VqZsBtxLEFcmu9NDqhHExbb7QKqKq3Jzi6sWld0H7fcsH1woSW10pnBnGXoqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WQkWuF3/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p1AQKi+K6Pd/TsOULuKJFFIe2LssdycakXhxxLPb5YY=; b=WQkWuF3/DICUQJJP2j9/0E37UW
	5aT1k/PfWPf6DPYx7l+mLRMynmysGfuZhKoWCMwDiEIWUX5sTSOGtn1g3wWIHj2MF0NOxHFY87SXm
	AWfRoFoFXfiiiSh+uvlfJ2iCE8d42mVLooSQesLFpS8dXgkud3YEltH7+yWKMtd4cDtter964t5AC
	HCfKw8MCEJJAwlB63GWZjs8+ysf2aoGirvw8W5+LzYGq7ai3faWCoCqK8Bm/oxwg5q1KQzYawFvcM
	XqlIvdsXG7vsNDOAm4YL2N7NULi8gx///twvQ0cgx0RLp336H5GOoynlAFKOMdm8CZvbzj99d9SO7
	o74Te9MQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYXQO-00000002etz-0bVH;
	Thu, 16 Jan 2025 21:29:12 +0000
Date: Thu, 16 Jan 2025 21:29:12 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christian Brauner <brauner@kernel.org>, Boris Burkov <boris@bur.io>,
	linux-fsdevel@vger.kernel.org, daan.j.demeyer@gmail.com
Subject: Re: Possible bug with open between unshare(CLONE_NEWNS) calls
Message-ID: <20250116212912.GN1977892@ZenIV>
References: <20250115185608.GA2223535@zen.localdomain>
 <20250116-audienz-wildfremd-04dc1c71a9c3@brauner>
 <98df4904-6b61-4ddb-8df2-706236afcd8e@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98df4904-6b61-4ddb-8df2-706236afcd8e@gmx.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jan 17, 2025 at 07:39:09AM +1030, Qu Wenruo wrote:

> The original problem is that we can get very weird device path, like
> '/proc/<pid>/<fd>' or any blockdev node created by the end user, as
> mount source, which can cause various problems in mount_info for end users.

You do realize that different namespaces may very well have the same
pathname resolve to different things, right?  So "userland can't open
a device pathname it sees in /proc/self/mountinfo" was not going to
be solved that way anyway...

While we are at it, it is entirely possible to have a trimmed-down
ramfs with the minimal set of static device nodes mounted on
/dev in user's namespace, with not a block device in sight - despite
having a bunch of local filesystems mounted.

