Return-Path: <linux-fsdevel+bounces-53996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEAFAF9CD8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 02:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684B71C47730
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 00:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD60C27713;
	Sat,  5 Jul 2025 00:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="joGZohuY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F66800
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Jul 2025 00:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751673679; cv=none; b=MqQNk5JSkJn9x7hJlFFAJv9KUqwBMcdeJOnO1EYPUX9vCT3Wg5ULdbW1uA5AbxyAiM/z4fmTAauflBxbVtOxx8dRd8UN9VnBJNh7BmwYcyh8tck4aLOLNinj0JDpHWrDv8ACvxiSqi6tOz801EWtulbTM1GZdbD1h2L2wfLxuu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751673679; c=relaxed/simple;
	bh=yYe4g2ljXCB2coVAvmeE8131zHsqym6PdqUW+tlP7JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ib+RvYWEd6QnjlB19UCuBwyRXPb6GSBRcpoz0snHwcfvfZBS9XknmawKDTdoWCfDT7OznBAwHcpYnd7l5WhwzV25cnfdS1KXXD6NwE37zItnu98Gs2nsw94151tv5/Jm1dnSckJ32WE1wCEpYrIKWk1MGE1CgEgVI2hcFMt+1f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=joGZohuY; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9Sh2zTkC4SEZwwIPq+KuwqG9MiNpX1i9csTProGX60c=; b=joGZohuYqPyrR7Hv2Awk952Iqr
	AVlMDLMKZtJB9Hh0GTlqFBlVX5iw0rQtCu4+IcKQLxNPUdggvgKt9o2pir33nDLFdP8QDJOmdQ0Yh
	VkHJ5OjD4RN4HLGqPTw0DjAPdhpdmATaLvfmyA7vtzLZ4uIELaLMcsWMkFhuS/IgXHu1HG2+IVffb
	xPybK/nRx6RaajCPc4cltX450VbcFBKixolpYMhMwHzf0Az3LGmilEuvoRzDT167pX9TzoAXgCeZz
	h/Sr6x8UPlv+1ZGksxBv9MkdPmCrY+Cg4zPP39pBcBCDD4Qcte3ip2/CXnX+XuqcFau2I6kjuQgu0
	NANRQDKA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXqLC-0000000G24z-38CE;
	Sat, 05 Jul 2025 00:01:14 +0000
Date: Sat, 5 Jul 2025 01:01:14 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC] MNT_WRITE_HOLD mess
Message-ID: <20250705000114.GU1880847@ZenIV>
References: <20250704194414.GR1880847@ZenIV>
 <CAHk-=wgurLEukSdbUPk28rW=hsVGMxE4zDOCZ3xxY3ee3oGyoQ@mail.gmail.com>
 <20250704202337.GT1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704202337.GT1880847@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jul 04, 2025 at 09:23:37PM +0100, Al Viro wrote:
> On Fri, Jul 04, 2025 at 12:57:39PM -0700, Linus Torvalds wrote:
> 
> > Ugh. I don't hate the concept, but if we do this, I think it needs to
> > be better abstracted out.
> > 
> > And you may be right that things like list_for_each_entry() won't
> > care, but I would not be surprised there is list debugging code that
> > could care deeply. Or if anybody uses things like "list_is_first()",
> > it will work 99+_% of the time, but then break horribly if the low bit
> > of the prev pointer is set.
> > 
> > So we obviously use the low bits of pointers in many other situations,
> > but I do think that it needs to have some kind of clear abstraction
> > and type safety to make sure that people don't use the "normal" list
> > handling helpers silently by mistake when they won't actually work.
> 
> Point, but in this case I'd be tempted to turn the damn thing into
> pointer + unsigned long right in the struct mount, and deal with it
> explicitly.  And put a big note on it, along the lines of "we might want
> to abstract that someday".
> 
> Backporting would be easier that way, if nothing else...

FWIW, several observations around that thing:
	* mnt_get_write_access(), vfs_create_mount() and clone_mnt()
definitely do not need to touch the seqcount component of mount_lock.
read_seqlock_excl() is enough there.
	* AFAICS, the same goes for sb_prepare_remount_readonly(),
do_remount() and do_reconfigure_mnt() - no point bumping the seqcount
side of mount_lock there; only spinlock is needed.
	* failure exit in mount_setattr_prepare() needs only clearing the
bit; smp_wmb() is pointless there (especially done for each mount involved).
	* both vfs_create_mount() and clone_mnt() add mount to the tail
of ->s_mounts.  Is there any reason why that would be better than adding
to head?  I don't remember if that had been covered back in 2010/2011
discussion of per-mount r/o patchset; quick search on lore hasn't turned
up anything...  Miklos?

