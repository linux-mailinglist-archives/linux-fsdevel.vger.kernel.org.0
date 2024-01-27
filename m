Return-Path: <linux-fsdevel+bounces-9222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF01D83EFEB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 21:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C318283571
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 20:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A9F2E645;
	Sat, 27 Jan 2024 20:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="csPcqdET";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="pgH5Glzb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548612E62D
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 20:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706386031; cv=none; b=ClVSvwute+Dc9WgtmfSdVZ4B12N0Izy4iLZnmasnjlbdPsuLbSnU7i3Vid+tLoXH3OmqgypUv7YZkUGDtMVo9OUYIfKh7/DbIQ1WI0MXBceIU7AV+qI8IYJRMOPaH+8KtBlCoszRL0C1OqjCidtkQrLd9PEmQKw5CPJRYHnLBGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706386031; c=relaxed/simple;
	bh=nWmbug6lSErFTJ7AT+oEslazCkp38lsHnZ5pb7RAh9s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DLIT+6wlWNbcUFSpg2QtZjMP97VQNlnUu23iwEZ7AHlxE1Y78qQ5YKQNucuzBZ8aBq7efFTGhuqtaJ2W2Lt1a1DVTfuYnvajHksNR1bi5xpJXCE2Y9ppAs5E+X+Kl4S+rRuEoA1Cu2J3mQMTX3xsZA3YriQA9BXtc/kwlthfKBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=csPcqdET; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=pgH5Glzb; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706386028;
	bh=nWmbug6lSErFTJ7AT+oEslazCkp38lsHnZ5pb7RAh9s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=csPcqdETWTAR4/yYxDoyWeaRke5oc7tLIHcTH0jfw3yD+P8Ll9Oj/Ld1EU7ZSx3hy
	 OKWjJkFSrSLFaj7USme4BYIvFtqXhohg92k9ujpgNU2i+fn8+RsdFnREj3UsnPzxZb
	 6Y1fSizTCeDPQQKKfftL1eCSBaGbtP196dWq0VKk=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 37EA91285EC7;
	Sat, 27 Jan 2024 15:07:08 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id dLdvEkcnvpTt; Sat, 27 Jan 2024 15:07:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706386027;
	bh=nWmbug6lSErFTJ7AT+oEslazCkp38lsHnZ5pb7RAh9s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=pgH5Glzb5fZ5o5QvmI/qk0ivVneBnmU0FnjCFIsvyJbxqn//tchnkwDYKE3uUlliv
	 iNIshzOULslzUi0xwtYgahD/Vs243nJAttx0JN/7s/hZCKucKjTaADhdkepDb5eb/F
	 5d8qSr9RzgVo+PcDfFZ/FVyhhhZxIDGNF9EoUsHY=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5A0EE1281BDA;
	Sat, 27 Jan 2024 15:07:06 -0500 (EST)
Message-ID: <07dd0096952e97cfd0d5fda5ef335c534616af2b.camel@HansenPartnership.com>
Subject: Re: [LSF/MM TOPIC] Making pseudo file systems inodes/dentries more
 like normal file systems
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, Christian Brauner <brauner@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 27 Jan 2024 15:07:04 -0500
In-Reply-To: <ZbVGLXu4DuomEvJH@casper.infradead.org>
References: <2024012522-shorten-deviator-9f45@gregkh>
	 <20240125205055.2752ac1c@rorschach.local.home>
	 <2024012528-caviar-gumming-a14b@gregkh>
	 <20240125214007.67d45fcf@rorschach.local.home>
	 <2024012634-rotten-conjoined-0a98@gregkh>
	 <20240126101553.7c22b054@gandalf.local.home>
	 <2024012600-dose-happiest-f57d@gregkh>
	 <20240126114451.17be7e15@gandalf.local.home>
	 <CAOQ4uxjRxp4eGJtuvV90J4CWdEftusiQDPb5rFoBC-Ri7Nr8BA@mail.gmail.com>
	 <d661e4a68a799d8ae85f0eab67b1074bfde6a87b.camel@HansenPartnership.com>
	 <ZbVGLXu4DuomEvJH@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 2024-01-27 at 18:06 +0000, Matthew Wilcox wrote:
> On Sat, Jan 27, 2024 at 09:59:10AM -0500, James Bottomley wrote:
> > On Sat, 2024-01-27 at 12:15 +0200, Amir Goldstein wrote:
> > > I would like to attend the talk about what happened since we
> > > suggested that you use kernfs in LSFMM 2022 and what has happened
> > > since. I am being serious, I am not being sarcastic and I am not
> > > claiming that you did anything wrong :)
> > 
> > Actually, could we do the reverse and use this session to
> > investigate what's wrong with the VFS for new coders?  I had a
> > somewhat similar experience when I did shiftfs way back in 2017. 
> > There's a huge amount of VFS knowledge you simply can't pick up
> > reading the VFS API.  The way I did it was to look at existing
> > filesystems (for me overlayfs was the closes to my use case) as
> > well (and of course configfs which proved to be too narrow for the
> > use case).  I'd say it took a good six months before I understood
> > the subtleties enough to propose a new filesystem and be capable of
> > answering technical questions about it.  And remember, like Steve,
> > I'm a fairly competent kernel programmer.  Six months plus of code
> > reading is an enormous barrier to place in front of anyone wanting
> > to do a simple filesystem, and it would be way bigger if that
> > person were new(ish) to Linux.
> 
> I'd suggest that eventfs and shiftfs are not "simple filesystems".
> They're synthetic filesystems that want to do very different things
> from block filesystems and network filesystems.  We have a lot of
> infrastructure in place to help authors of, say, bcachefs, but not a
> lot of infrastructure for synthetic filesystems (procfs, overlayfs,
> sysfs, debugfs, etc).

I'm not going to disagree with this at all, but I also don't think it
makes the question any less valid when exposing features through the
filesystem is one of our default things to do.  If anything it makes it
more urgent because some enterprising young thing is going create their
own fantastic synthetic filesystem for something and run headlong into
this.

> I don't feel like I have a lot to offer in this area; it's not a
> part of the VFS I'm comfortable with.  I don't really understand the
> dentry/vfsmount/... interactions.  I'm more focused on the
> fs/mm/block interactions.  I would probably also struggle to write a
> synthetic filesystem, while I could knock up something that's a clone
> of ext2 in a matter of weeks.

OK, I have to confess the relationship of superblocks, struct vfsmount
and struct mnt (as it then was, it's struct mnt_idmap now) to the fs
tree was a huge part of that learning (as was the vagaries of the
dentry cache).

I'm not saying this is easy or something that interests everyone, but I
think receont history demonstrates it's something we should discuss and
try to do better at.

James


