Return-Path: <linux-fsdevel+bounces-53720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2789AF62A6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 21:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D3D16B5D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 19:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C9B2D0C9D;
	Wed,  2 Jul 2025 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="utsPt8qL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DB02F7CE1
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 19:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751484549; cv=none; b=mxogBp06JjCee5Pm/qAFLT+iZbwe/1kdVLak55Qha5NDGJSqOPa299Rwfw5609xaz69Fj7/2sgiP/tT1fNufmzengwt6nKPRossh+NR9uIVT0mwLsCHUEW8LAk6RqCoYmtLVtNKzgJ1NbEVMMwvbZjgXJyT4I81HbrcrRD0xmMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751484549; c=relaxed/simple;
	bh=9bCkmPODbjjbew4bDBSC/UGuv+Xu4KHByPoYvqDm7LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGaJhkjRWyJtUCFQUKdWT+UrgfP1DHo1/edtbMf2v/vVp7Sqw5H2o+b0w6atHQNy7Bgh1xt9TcAFKejhew68EyEo0F/YlhpOtEY3e3PMKgijNXXq7M4yZWj9QmU22Pqqy2Qr6eiIOqq23UnKkU6cG0dPQuSQqI08ar4RQBzvAA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=utsPt8qL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lgI0Pcd7OsjzpxPVKtVcwCMI1Ngf5UJbANJhII+UJhU=; b=utsPt8qLYdgpIGZHg3l3VIPK3s
	kUHyvDuXsyKSGk2Nrw7RE5oQ2Kcodp5DIExWEXDAItDF9rLXXIjezt3mvfpGUNK4OlLa7Hm3kiMzI
	e/VAVpYduPHHuM3CjFUUeEuQ582X4UqCbQOzMObd3Z4i64oAvfgWofB0QCRF/wKd474YEGGx5cL9b
	NmieuBea+LY7clxQaN/Ss3OZVRPgFdqFAqe0nuf9hgi0GJHQm/appNtG0+dWJVq0xFhbcTo24lbnv
	IpQ6IwAGxS/RxNPBzGygEO24dwv/fOBnmt2u5eX0vkOrl0Saj3XkDosxNf/7c4CobF2eOCppdN+Fz
	H1ENaMWA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX38h-0000000DdX7-2xRk;
	Wed, 02 Jul 2025 19:29:03 +0000
Date: Wed, 2 Jul 2025 20:29:03 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCHES v3][RFC][CFR] mount-related stuff
Message-ID: <20250702192903.GA3248425@ZenIV>
References: <20250610081758.GE299672@ZenIV>
 <20250623044912.GA1248894@ZenIV>
 <20250630025148.GA1383774@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630025148.GA1383774@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 30, 2025 at 03:51:48AM +0100, Al Viro wrote:
> Updated variant (-rc4-based) force-pushed to
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.mount
> individual patches in followups.  It seems to survive testing here, but
> more testing and review would be very welcome.  Again, that is not all -
> there's more stuff coming...
> 
> Folks, please review - if nobody objects, it goes into #for-next in
> a day or two.

... and there it goes.

