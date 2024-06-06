Return-Path: <linux-fsdevel+bounces-21110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1426E8FF07B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 17:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB621C2480C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 15:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCBC947A;
	Thu,  6 Jun 2024 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drTqTwnY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E02196431
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2024 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687060; cv=none; b=ivAln8/fPNJMlEj7U3Owb9U+lkYpPEN9WNXW0pcQ4jkkzKSzdnxm0KMB9kKM21qTdfd1DXk5YZlkneu1oRUBMUV9kvXEtJfwh9eZqIFDSoB4jpMzexfCy8SYpoerFNFaF5qk6TaihYHkmJO4Q9Sc5wVD8QHD4BxVmwSNHDy3EAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687060; c=relaxed/simple;
	bh=wp+hZUvPTqFaugVUWHxeQpczAg0lhjntqW9q/6hWeWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKe3cLMK7RayLZ2Nyo81pZHZGstWHF4IlUIMfJGEx5TlwG2KDWXnpIgoq9ljhQrha5+cAwPhe4gr07BJoiMsrOCB9NHaqW/NOqfRMK9CShfQyn5c0dg1garIWVjt7qzkyQCO591CC0CSfkwQ1WWRzeiv9idpp5aC7aDPgiTuXrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drTqTwnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAB9C2BD10;
	Thu,  6 Jun 2024 15:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717687059;
	bh=wp+hZUvPTqFaugVUWHxeQpczAg0lhjntqW9q/6hWeWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=drTqTwnYnIay9WPzyTbD49ij5LQAkyIFDWdctpKFDGdFsUjN9Gn6/79Iy5b+pXvOa
	 iz/uxHzwp15G0v0YBhqc3SBUeYcQKLkZrIPQhmHn0bP55NuZ+0dajGhvnPjtBu8Xtj
	 Ku38bNjpQw4arqWAYoecsERL4rFC++AgfmUu5LT0PEmius1NAyvkk2zAcb43OwhQOj
	 +aklFFEiHoL1U1TElO6wrRC7xZ5FMoZxMcSqmEvYNa/UB6W7Ngz/p7PxFNorKWuwwG
	 lGmg1vBzw3OmXnpSMGC1CHRmdNaXAbr9x4aDHRNseQqZTC5QEZwjsPPIGdjbaJ+Ko4
	 SnCMWkaXF0r7g==
Date: Thu, 6 Jun 2024 08:17:38 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: JunChao Sun <sunjunchao2870@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: Is is reasonable to support quota in fuse?
Message-ID: <20240606151738.GB52973@frogsfrogsfrogs>
References: <CAHB1NaicRULmaq8ks4JCtc3ay3AQ9mG77jc5t_bNdn3wMwMrMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHB1NaicRULmaq8ks4JCtc3ay3AQ9mG77jc5t_bNdn3wMwMrMg@mail.gmail.com>

On Mon, Jun 03, 2024 at 07:36:42PM +0800, JunChao Sun wrote:
> Currently, FUSE in the kernel part does not support quotas. If users
> want to implement quota functionality with FUSE, they can only achieve
> this at the user level using the underlying file system features.
> However, if the underlying file system, such as btrfs, does not
> support UID/GID level quotas and only support subvolume level quota,
> users will need to find alternative methods to implement quota
> functionality.

How would your quota shim find out about things like the increase in
block usage of the underlying fs?  Let's say the underlying fs is like
vfat, which fakes sparse hole support by allocating and zeroing (as
needed) all the space before the start of the write.

So the kernel tells fuse to write a byte at 1MB.  Most unixy filesystems
will allocate a single block, write a byte (and the necessary zeroes)
and bump quota by 1.

fat instead will allocate 1028K of space, zero all of it, and write the
byte.  How does /that/ get communicated back to fuse?  Some sort of
protocol extension that says "Hey I wrote the data you asked, and btw
block usage increased by XXXX bytes"?  If that increase takes you over
an enforced quota limit, the correct response would have been to return
EDQUOT having not made any changes to the file.

--D

> And consider another scenario: implementing a FUSE file system on top
> of an ext4 file system, but all writes to ext4 are done as a single
> user (e.g., root). In this case, ext4's UID and GID quotas are not
> applicable, and users need to find other ways to implement quotas for
> users or groups.
> 
> Given these challenges, I would like to inquire about the community's
> perspective on implementing quota functionality at the FUSE kernel
> part. Is it feasible to implement quota functionality in the FUSE
> kernel module, allowing users to set quotas for FUSE just as they
> would for ext4 (e.g., using commands like quotaon /mnt/fusefs or
> quotaset /mnt/fusefs)?  Would the community consider accepting patches
> for this feature?
> 
> I look forward to your insights on this matter.
> 
> Thank you for your time and consideration.
> 
> Best regards.
> 

