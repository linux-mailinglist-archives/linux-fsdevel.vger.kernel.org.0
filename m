Return-Path: <linux-fsdevel+bounces-51301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 676BBAD5387
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AC7A1BC42C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF9B2E6118;
	Wed, 11 Jun 2025 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P08kcdVZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E1F2E6107
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640282; cv=none; b=ciAgfwnfw1HMmdagKb8TO/MKQchTQXs/HB0WHsy7iCt/6zemtPnXqgEKFNf63P5kP/y7hljiHHVMLGNfB8+wo2FDSVh0xIFP9PHg+6s3CvTxE+dYCjEbyNu5VlmViPir2LE0cP9COhumtc3qjKbV1CFpiBanZ3198I88G5R3tog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640282; c=relaxed/simple;
	bh=C9FPBAtxXf8Lc06xrrrA4UbiGnZalpwubLLSDaB1vqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtCgAbPLOoX1Qc7t75QcwbqtHRO/LJTr74aPDQjP2ehDLyvW0QLXiuFmeVU4KaXUo6FEWXEthTvW3Ktbbxn1ChRgBxmOAcGyqZEQXcw1SwFSYKU0PvgR6Kci5HyZ7qn++IECpBtU2l/kIdBIJ2S5jUA+mBU21NxVpWRLddzedQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P08kcdVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5158C4CEEE;
	Wed, 11 Jun 2025 11:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749640282;
	bh=C9FPBAtxXf8Lc06xrrrA4UbiGnZalpwubLLSDaB1vqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P08kcdVZ9e7q/XXdKYkYFSgx4HCS0McsQoPBHfRy4wdXQwGOj09Pb3LVIfpLPVIKN
	 PJ/N1gpxjsNh32rsl/j8xy7telEA1CloYWlDOGBdFgtbTDP0verNIBh5JJmzrimowJ
	 5RAN98eXQ0uVnb5hDnfvgjY06N+GotBvcZyy92GhfHsZsv0B6PcJBaqsmYGy8qJtPm
	 mxKVaK8FIdOqA4FWVNoEJvgBNwcCunMPFnmM9YGqhR62q6nZuQUBU64Fc02DYuGlZ1
	 6D/MlwFV1reW1uXtgjNLrQlqCuuSHwzz6gVdkntX3DW0ggTBjc0UDKMWnKmPBWeEIr
	 pTa90JGvxElRA==
Date: Wed, 11 Jun 2025 13:11:18 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 22/26] take ->mnt_expire handling under mount_lock
 [read_seqlock_excl]
Message-ID: <20250611-neuverfilmung-lachhaft-208eba31f7f8@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-22-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610082148.1127550-22-viro@zeniv.linux.org.uk>

On Tue, Jun 10, 2025 at 09:21:44AM +0100, Al Viro wrote:
> Doesn't take much massage, and we no longer need to make sure that
> by the time of final mntput() the victim has been removed from the
> list.  Makes life safer for ->d_automount() instances...
> 
> Rules:
> 	* all ->mnt_expire accesses are under mount_lock.
> 	* insertion into the list is done by mnt_set_expiry(), and
> caller (->d_automount() instance) must hold a reference to mount
> in question.  It shouldn't be done more than once for a mount.
> 	* if a mount on an expiry list is not yet mounted, it will
> be ignored by anything that walks that list.
> 	* if the final mntput() finds its victim still on an expiry
> list (in which case it must've never been mounted - umount_tree()
> would've taken it out), it will remove the victim from the list.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

