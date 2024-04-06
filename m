Return-Path: <linux-fsdevel+bounces-16263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDB289A97B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 09:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41B3EB21A5A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 07:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7078522616;
	Sat,  6 Apr 2024 07:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Shi0azks"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0E91EEFC;
	Sat,  6 Apr 2024 07:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712387501; cv=none; b=Loea8vgMEme55srCWRp1AA+ozghxs1Y9qn8tzOm8gZpspeXuFpKVUBPNeyPEv5NtSpNL26CmEEFQA18EwUrBD9AkP4WuY6qK27IZEnHbRJIBFdejRS8c22TQQ1hiOz1Z5AVDreCV56pn0JI0rumM9OcdgtdQIQUhsLzRmHW2QGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712387501; c=relaxed/simple;
	bh=va5+nVrH2sTYitIpPwPYUS69H/ywqZioHyWNF/sVd3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNTm3NI/RNv8DgEr60UTcZDPwvnSR5mMnGJ/2fTQuarf1llf+/1TS1NjGsHzUF1R+XbI/fdMwTRoT48PJGsavobaeMK0RGa5EHqdDmHwy0yO7XSFc4dvkTs57a43kI92cVI1zmhvTLe/U157Du6Rk/O+OviCP9ySMQ1GxwiUeMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Shi0azks; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GNfNtOBQ9mUCSvC61XgRvWAWZ3dPPmGPMc1/GfjrGTo=; b=Shi0azks95Y038eI3QTH1bmTWb
	wfIcFskYYx/8HAj5FzEqjL2Jys5VQE4o2zM0NYYgm1aiSFbIlEVmE8e2IviqJvYGy3H5J0MPEAkD7
	CC1lF8eIfwScfjmAfv7BNoBTwXUfXXQMSYBiwwfvo1l67C1TbkfDzwfA1Phxr9WnrMypN9aYZ5+g1
	haTiSo3BYfaDAZOCnUBj2mrKIDLW173EnzhLBVvMZ0+Uns7uUFrC8M0Ges/7b5QWCSNaeQBL1lcxo
	+OG9Qx5PQ/RMaWOq3cR7CjtLg6wHH/TtLsVtSn9MU5vKW8los4Dau+/YHwbzhZFFnpkC6uDnfkol8
	fkJgdJwA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rt0D4-0070iB-3B;
	Sat, 06 Apr 2024 07:11:31 +0000
Date: Sat, 6 Apr 2024 08:11:30 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, brauner@kernel.org, gregkh@linuxfoundation.org,
	hch@lst.de, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, miklos@szeredi.hu,
	syzkaller-bugs@googlegroups.com, tj@kernel.org,
	valesini@yandex-team.ru
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
Message-ID: <20240406071130.GB538574@ZenIV>
References: <CAOQ4uxgJ5URyDG26Ny5Cmg7DceOeG-exNt9N346pq9U0TmcYtg@mail.gmail.com>
 <000000000000107743061568319c@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000107743061568319c@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Apr 06, 2024 at 12:05:04AM -0700, syzbot wrote:

> commit:         3398bf34 kernfs: annotate different lockdep class for ..
> git tree:       https://github.com/amir73il/linux/ vfs-fixes
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c5cda112a8438056
> dashboard link: https://syzkaller.appspot.com/bug?extid=9a5b0ced8b1bfb238b56
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Note: no patches were applied.

How about the same test on 6c6e47d69d821047097909288b6d7f1aafb3b9b1?

