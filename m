Return-Path: <linux-fsdevel+bounces-27334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D4D960575
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 11:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2AAF282363
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 09:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34247199EAC;
	Tue, 27 Aug 2024 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQg0s6q8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CC219D88C;
	Tue, 27 Aug 2024 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750542; cv=none; b=g9wi5TffzLPmPPPWqJAYpLoWMsFfLz8liRZXtIt5yXauYGPYggJL2C5Bkk3ipfj/mXC9vlUVG+hg2MC2zC85MBC0Q9KqiiApCQLRDclC48wWtDB9XTDc8Rsq2MeMGYLzGY1ZkBSWDV9MqpctuzXh/VKAhbu5ngonhf7zbfIrvik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750542; c=relaxed/simple;
	bh=0R4XbqHF/qK0cbkRUjsQVcb1iil5hOvrNzGLT1ymz9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1cvZ4pMhifs3LNlmh82+WcOktZM6RjUIW89TlCI+z/hCUrgPQdi4BtyNP0XUIHCOmHJ1g5PZVZ3ThtfKxvV3JAUj7/wD48xRtGd9oVGRZMF2d4xsQT7jZKkfo71PgnNS+dwiQmGlrtF1+zH/6kPq54GzWbXxOSu4aASADY4Fv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQg0s6q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAEEC8B7AB;
	Tue, 27 Aug 2024 09:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724750542;
	bh=0R4XbqHF/qK0cbkRUjsQVcb1iil5hOvrNzGLT1ymz9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tQg0s6q8JNXYV+gi3vQFMKaMWWxYgKh7mcqmGyv3oJE28XKPhg4/ELokWru63puW1
	 sda7hdpSomT67Knvxn+hkvd1mF4L8qoqbEg2f2MbtNjIePNqUZn/agUMO/v+f/P/LX
	 q89QUbttD5SIFbjyjnbNkHXlvep1QXzDBdK2uYoPE7DRVnGpqrrEv6/dVZXfZSb/X1
	 D4Xlo4olAqDhDJu1rcf2WDEbbXH9t0IIkj1O1YkdF9fAMSCG+Z+nlymfkTngC+I0ke
	 AN3X9JBhBbvTdXQuscOErQk9MoChz3wKHiQmr52LUXXvlKdPCEdAIdL/MaEw0aKt2y
	 Vh0DecGH7rAPw==
Date: Tue, 27 Aug 2024 11:22:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Hongbo Li <lihongbo22@huawei.com>, jack@suse.cz, 
	viro@zeniv.linux.org.uk, gnoack@google.com, mic@digikod.net, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: obtain the inode generation number from vfs
 directly
Message-ID: <20240827-abmelden-erbarmen-775c12ce2ae5@brauner>
References: <20240827014108.222719-1-lihongbo22@huawei.com>
 <20240827021300.GK6043@frogsfrogsfrogs>
 <1183f4ae-4157-4cda-9a56-141708c128fe@huawei.com>
 <20240827053712.GL6043@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827053712.GL6043@frogsfrogsfrogs>

On Mon, Aug 26, 2024 at 10:37:12PM GMT, Darrick J. Wong wrote:
> On Tue, Aug 27, 2024 at 10:32:38AM +0800, Hongbo Li wrote:
> > 
> > 
> > On 2024/8/27 10:13, Darrick J. Wong wrote:
> > > On Tue, Aug 27, 2024 at 01:41:08AM +0000, Hongbo Li wrote:
> > > > Many mainstream file systems already support the GETVERSION ioctl,
> > > > and their implementations are completely the same, essentially
> > > > just obtain the value of i_generation. We think this ioctl can be
> > > > implemented at the VFS layer, so the file systems do not need to
> > > > implement it individually.
> > > 
> > > What if a filesystem never touches i_generation?  Is it ok to advertise
> > > a generation number of zero when that's really meaningless?  Or should
> > > we gate the generic ioctl on (say) whether or not the fs implements file
> > > handles and/or supports nfs?
> > 
> > This ioctl mainly returns the i_generation, and whether it has meaning is up
> > to the specific file system. Some tools will invoke IOC_GETVERSION, such as
> > `lsattr -v`(but if it's lattr, it won't), but users may not necessarily
> > actually use this value.
> 
> That's not how that works.  If the kernel starts exporting a datum,
> people will start using it, and then the expectation that it will
> *continue* to work becomes ingrained in the userspace ABI forever.
> Be careful about establishing new behaviors for vfat.

Is the meaning even the same across all filesystems? And what is the
meaning of this anyway? Is this described/defined for userspace
anywhere?

