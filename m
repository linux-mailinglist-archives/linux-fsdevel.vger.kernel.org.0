Return-Path: <linux-fsdevel+bounces-41573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03872A32383
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 11:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9C73A315A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 10:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5F7208966;
	Wed, 12 Feb 2025 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1LECqaT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697E41F9A83;
	Wed, 12 Feb 2025 10:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356363; cv=none; b=MhBJnjz6kRo/HqSd9ibcbn213MalxJZ7B7oxqIdXFCo8FOiRwuMfyl6weXo5IzGIqVxgQnL6lpMgNsrzegnIr3UimoNeV0XtPCXZLyvuBeCnG6Dn4E6OTyBf7SWn3+1O9/kydZ9r/bAbeQJmyz5Aaozy3UBhjM5ugXZlyoZaVaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356363; c=relaxed/simple;
	bh=sedcMzGgzynwVSx2PMNV5XsP9/FbqRF4gvQt3ENTXFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOCauOBAP07PMpJKm1gvr/7fsDfdx+4gJapzC4rtd9Rd6xb/E2gj2iOKJy/q6+MrgTFSjNZIDGrohczwontR3x+ucw7FHu3Q5ThDQQu2u+szYWXA0UPxLaRqYqXY72uJ2D/U7/6Y60YQL4lS9UZmHPRZwcr1j7/HjRsMHvaqhwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1LECqaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1FBC4CEE7;
	Wed, 12 Feb 2025 10:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739356362;
	bh=sedcMzGgzynwVSx2PMNV5XsP9/FbqRF4gvQt3ENTXFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l1LECqaT0XrgFE/9ADMpysXjoQNy4yf3s8rfaVAsPxi5rkLSEog+21fU2BV2ts7FO
	 Md1N5KkbjGuphksamJVPmlFGpGXjlmr/sazwEM+L9sUbhInNr8Q7esex1ICl3l53No
	 1X8nFqEYX0BBwOwQV4Kaefx2kMPSbAwaXon+HbHiMz95BMidLFJZY3s1/tiYyaT0JA
	 JEaGdXGwkTJhb4L6my8Rl74SRHc/bcEXQcF7ffgr+pgeVCHNUfmEmCjVgjp+MUHRoP
	 E3UZ77odtmgcKJfkmBfvVvtiMl+hpBZDccmmC9TNP0dLBMfEQ6MzO2wUaSftts9oyv
	 +UWWuITkV/5AA==
Date: Wed, 12 Feb 2025 11:32:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Zicheng Qu <quzicheng@huawei.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, jlayton@kernel.org, axboe@kernel.dk, joel.granados@kernel.org, 
	tglx@linutronix.de, hch@lst.de, len.brown@intel.com, pavel@ucw.cz, 
	pengfei.xu@intel.com, rafael@kernel.org, tanghui20@huawei.com, zhangqiao22@huawei.com, 
	judy.chenhui@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, linux-pm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] acct: block access to kernel internal filesystems
Message-ID: <20250212-summen-vergibt-6c6562c0b0bd@brauner>
References: <20250211-work-acct-v1-0-1c16aecab8b3@kernel.org>
 <20250211-work-acct-v1-2-1c16aecab8b3@kernel.org>
 <20250211205418.GI1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250211205418.GI1977892@ZenIV>

On Tue, Feb 11, 2025 at 08:54:18PM +0000, Al Viro wrote:
> On Tue, Feb 11, 2025 at 06:16:00PM +0100, Christian Brauner wrote:
> > There's no point in allowing anything kernel internal nor procfs or
> > sysfs.
> 
> > +	/* Exclude kernel kernel internal filesystems. */
> > +	if (file_inode(file)->i_sb->s_flags & (SB_NOUSER | SB_KERNMOUNT)) {
> > +		kfree(acct);
> > +		filp_close(file, NULL);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Exclude procfs and sysfs. */
> > +	if (file_inode(file)->i_sb->s_iflags & SB_I_USERNS_VISIBLE) {
> > +		kfree(acct);
> > +		filp_close(file, NULL);
> > +		return -EINVAL;
> > +	}
> 
> That looks like a really weird way to test it, especially the second
> part...

SB_I_USERNS_VISIBLE has only ever applied to procfs and sysfs.

Granted, it's main purpose is to indicate that a caller in an
unprivileged userns might have a restricted view of sysfs/procfs already
so mounting it again must be prevented to not reveal any overmounted
entities (A Strong candidate for the price of least transparent cause of
EPERMs from the kernel imho.).

That flag could reasonably go and be replaced by explicit checks for
procfs and sysfs in general because we haven't ever grown any additional
candidates for that mess and it's unlikely that we ever will. But as
long as we have this I don't mind using it. If it's important to you
I'll happily change it. If you can live with the comment I added I'll
leave it.

To be perfectly blunt: Imho, this api isn't worth massaging a single
line of VFS code which is why this isn't going to win the price of
prettiest fix of a NULL-deref.

