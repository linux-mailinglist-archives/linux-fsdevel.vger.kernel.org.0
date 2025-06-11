Return-Path: <linux-fsdevel+bounces-51348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33157AD5D95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 19:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF641E184A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 17:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF8F2441A7;
	Wed, 11 Jun 2025 17:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TXGTI1P2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC39223DD7
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749664652; cv=none; b=UsTvSWfJJRXl17gjaLdyniNkjy04GdKupVa4JNg8jGCoEdJ5UAVz5/0dt8BsqIgw6ZayPfSg0KKfvmJiWdc21yX/ateyOUdbLMZ3ELEY09lpFeV+ckgkKg0kdBk84drvPf+poQoXi4JDe06MTqGj5gyWIe5HFU6W1bAMyz2qGr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749664652; c=relaxed/simple;
	bh=F/RDgOHV9fzcFqlwVrF+GGxSTjeuW6Ag5fN7XydLbYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qP8hmYOFKO/qZM8O061SqLywdZGe1MKAqiuldz8Dn/S3WLhixn9d1+5XZdCElCtaJF+JfhrTX04dRxaONZG/DTiQ8sYZDbXoMZ90mAi6HoArEmhlR0744ZoCaSgByFusv1LqFIKwJef6K+EfZ/2NJO9XIsPAkMmfRHTBzXftfwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TXGTI1P2; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jIKdQlO2F7DCWT8qdPNayufw2DZqbn/kEg5Q+SMxHLc=; b=TXGTI1P297eabpjOZ2TZ+5is+f
	MlVWmxsfuG9YJYdRaPK6Owgl3+Pos8g+SUFVLlFyYe0MSQTG/oz/dLfCyr5AW64MU563UUSdpVc7c
	mVHWOgvSiSHLioG6CORlmMy8aEQNXR0t9EoHN3MZjLXcOwNBFfUqKnfOaq46IlzR9ERd5STqh4ktR
	aAp3jxAg2HldkplDOxtMSLcsBPJCEIsnE1e0dj2IthSdwkBSpx/ILuiv9ibyKww9C/8QRFZnmE7Lp
	264BZvcpt9twz/zdjJNUgwEsijfaASxI7GjS2NqaKf42JdpG57Yq/qqYHsKynbQ6/z5KrD52trZ1H
	V9wmBI9A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPPhY-00000004orz-1TWZ;
	Wed, 11 Jun 2025 17:57:28 +0000
Date: Wed, 11 Jun 2025 18:57:28 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 06/26] new predicate: anon_ns_root(mount)
Message-ID: <20250611175728.GN299672@ZenIV>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-6-viro@zeniv.linux.org.uk>
 <20250611-fehlverhalten-offen-0113576bf502@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-fehlverhalten-offen-0113576bf502@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jun 11, 2025 at 12:39:28PM +0200, Christian Brauner wrote:
> On Tue, Jun 10, 2025 at 09:21:28AM +0100, Al Viro wrote:
> > checks if mount is the root of an anonymouns namespace.
> > Switch open-coded equivalents to using it.
> > 
> > For mounts that belong to anon namespace !mnt_has_parent(mount)
> > is the same as mount == ns->root, and intent is more obvious in
> > the latter form.
> > 
> > NB: comment in do_mount_setattr() appears to be very confused...
> 
> The comment just mentions a single case where we did regress userspace
> some time ago because we didn't allowing changing mount properties on
> the real rootfs (And we have this discussion on another thread.).
> 
> But I'm not sure why this belongs in the commit message in the first
> place. Just remove the comment.

Done

