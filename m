Return-Path: <linux-fsdevel+bounces-29192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18554976F05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 18:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98092B22CED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 16:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E442D1BC9ED;
	Thu, 12 Sep 2024 16:45:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855B8155744;
	Thu, 12 Sep 2024 16:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726159550; cv=none; b=SOvCYxDtAOrp/+E70doIkeojiIMJmGB0m1opFFr8ctVxEA4D2Gp5vfhfuScRSCm/dIpRGJ4R4uqJw1omCxo+kvtySaAywz7Dknk8rikycsSJjfkLAP1+QP/VSlj9mM76jlpQPv0qSHXTh4N4Egbjt34NNIML1hNEAd01Pf+RuXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726159550; c=relaxed/simple;
	bh=CfCqMSV7h/34cJgmDJBye6xtcKf+RsO81pTk+MVolLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=da8REj3kTqGrn2T/4r+Sg3xswRpBYSCxVJ/+mrZCJIhxfbDdTmfvxjQmB4f5h6MBDEplwI4AGpBG+MEtKQvfS/Thbblhgen6/1cv7LoZ/F3Sc619t8ht52CCfQAzQ6zybTy4z1/xGntYHrART6KmHer8TBhD5IiqmGbit5g8uqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C998C4CEC3;
	Thu, 12 Sep 2024 16:45:47 +0000 (UTC)
Date: Thu, 12 Sep 2024 17:45:45 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] arm64: Add infrastructure for use of AT_HWCAP3
Message-ID: <ZuMauVtQz21aBiAX@arm.com>
References: <20240906-arm64-elf-hwcap3-v1-0-8df1a5e63508@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906-arm64-elf-hwcap3-v1-0-8df1a5e63508@kernel.org>

On Fri, Sep 06, 2024 at 12:05:23AM +0100, Mark Brown wrote:
> Since arm64 has now used all of AT_HWCAP2 it needs to either start using
> AT_HWCAP3 (which was recently added for PowerPC) or start allocating
> bits 32..61 of AT_HWCAP first.  Those are documented in elf_hwcaps.rst
> as unused and in uapi/asm/hwcap.h as unallocated for potential use by
> libc, glibc does currently use bits 62 and 63.  This series has the code
> for enabling AT_HWCAP3 as a reference.
> 
> We will at some point need to bite this bullet but we need to decide if
> it's now or later.  Given that we used the high bits of AT_HWCAP2 first
> and AT_HWCAP3 is already defined it feels like that might be people's
> preference, in order to minimise churn in serieses adding new HWCAPs
> it'd be good to get consensus if that's the case or not.

Since the arm64 ABI documents that only bits 62 and 63 from AT_HWCAP are
reserved for glibc, I think we should start using the remaining 30 bits
of AT_HWCAP first before going for AT_HWCAP3. I'm sure we'll go through
them quickly enough, so these two patches will have to be merged at some
point.

We'll need an Ack from the (arm64) glibc people on the GCS patch series
if we are going for bits 32+ in AT_HWCAP.

-- 
Catalin

