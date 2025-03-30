Return-Path: <linux-fsdevel+bounces-45290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F11A758E7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 10:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FCD1672D0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 08:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E849017C210;
	Sun, 30 Mar 2025 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVUvAuEt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DCF6DCE1;
	Sun, 30 Mar 2025 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743323640; cv=none; b=hvlJrOHvZowTbfwRByTnJbJBKyZO0ZLvw8zVkguZPPXGbbDrgTi3Gj6vnF8xsWhISNZKH80DoYTcRJuYEfj0UcZNvvnOug0fWIwJlu/5CBvCYP5OT67UkqkDPuOn8UONx4/ftE2RD98j6FfGX++QjXaBy0DQ2AlB/+C4uMh/EZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743323640; c=relaxed/simple;
	bh=v/AkdNjDg8/pFM52YxmtXHA4bqiwCOloHOV+ED+lidE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uqlm7yCUXLoUUUUPxblH+FSZOD5fqEibSbHVNsud6kIkIAhnOAlJkvratWtsv7WgBgyJklmolBK49j+YLRoghIgtHgORCYsz+bx2zZwa/DG1BU2mIsLW/3RFbz/ZYJ9YpZVLt4gdacOWd8wQpmjfFMXmUvofluKjyTc+oFP9p20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVUvAuEt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B51C4CEDD;
	Sun, 30 Mar 2025 08:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743323639;
	bh=v/AkdNjDg8/pFM52YxmtXHA4bqiwCOloHOV+ED+lidE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SVUvAuEt4Xnauc3Gcjd/qhE314/MpfmZATEXSN3y1IcleCQiehAxKLio5mWWAZ5de
	 Uk/5b3+xhpmqUmEIh00orZN6UfkttxEt/bQqm3EV1ZRttG6W1JxhmHEC2Fjy2w0NQD
	 eWgh87cbDR4X2RhFWOPAUYk0jKdI3/MY3gU6b2dHZ9NsizeB70Um9VDUL17rH6v256
	 AeQ5Rang+cD5W/BUO3OooKk/EUz8KVrf5TyIxZA3Q8XuWYdb3sW3R4vJEpZ9TgphzQ
	 Jkw0c+sizJIvU88cJxJ8S60CnLtRSnKDa0vgWFOpgfwqVZpiXSqcA+3dXC9gEAnDQd
	 CDZw9o1v0Xwfw==
Date: Sun, 30 Mar 2025 10:33:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, rafael@kernel.org, 
	djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH v2 0/6] Extend freeze support to suspend and hibernate
Message-ID: <20250330-heimweg-packen-b73908210f79@brauner>
References: <20250328-work-freeze-v1-0-a2c3a6b0e7a6@kernel.org>
 <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org>
 <12ce8c18f4e16b1de591cbdfb8f6e7844e42807b.camel@HansenPartnership.com>
 <9c0a24cd8b03539fd6b8ecd5a186a5cf98b5d526.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c0a24cd8b03539fd6b8ecd5a186a5cf98b5d526.camel@HansenPartnership.com>

On Sat, Mar 29, 2025 at 01:02:32PM -0400, James Bottomley wrote:
> On Sat, 2025-03-29 at 10:04 -0400, James Bottomley wrote:
> > On Sat, 2025-03-29 at 09:42 +0100, Christian Brauner wrote:
> > > Add the necessary infrastructure changes to support freezing for
> > > suspend and hibernate.
> > > 
> > > Just got back from LSFMM. So still jetlagged and likelihood of bugs
> > > increased. This should all that's needed to wire up power.
> > > 
> > > This will be in vfs-6.16.super shortly.
> > > 
> > > ---
> > > Changes in v2:
> > > - Don't grab reference in the iterator make that a requirement for
> > > the callers that need custom behavior.
> > > - Link to v1:
> > > https://lore.kernel.org/r/20250328-work-freeze-v1-0-a2c3a6b0e7a6@kernel.org
> > 
> > Given I've been a bit quiet on this, I thought I'd better explain
> > what's going on: I do have these built, but I made the mistake of
> > doing a dist-upgrade on my testing VM master image and it pulled in a
> > version of systemd (257.4-3) that has a broken hibernate.  Since I
> > upgraded in place I don't have the old image so I'm spending my time
> > currently debugging systemd ... normal service will hopefully resume
> > shortly.
> 
> I found the systemd bug
> 
> https://github.com/systemd/systemd/issues/36888

I don't think that's a systemd bug.

> And hacked around it, so I can confirm a simple hibernate/resume works
> provided the sd_start_write() patches are applied (and the hooks are
> plumbed in to pm).
> 
> There is an oddity: the systemd-journald process that would usually
> hang hibernate in D wait goes into R but seems to be hung and can't be
> killed by the watchdog even with a -9.  It's stack trace says it's
> still stuck in sb_start_write:
> 
> [<0>] percpu_rwsem_wait.constprop.10+0xd1/0x140
> [<0>] ext4_page_mkwrite+0x3c1/0x560 [ext4]
> [<0>] do_page_mkwrite+0x38/0xa0
> [<0>] do_wp_page+0xd5/0xba0
> [<0>] __handle_mm_fault+0xa29/0xca0
> [<0>] handle_mm_fault+0x16a/0x2d0
> [<0>] do_user_addr_fault+0x3ab/0x810
> [<0>] exc_page_fault+0x68/0x150
> [<0>] asm_exc_page_fault+0x22/0x30
> 
> So I think there's something funny going on in thaw.

My uneducated guess is that it's probably an issue with ext4 freezing
and unfreezing. xfs stops workqueues after all writes and pagefault
writers have stopped. This is done in ->sync_fs() when it's called from
freeze_super(). They are restarted when ->unfreeze_fs is called.

But for ext4 in ->sync_fs() the rsv_conversion_wq is flushed. I think
that should be safe to do but I'm not sure if there can't be other work
coming in on it before the actual freeze call. Jan will be able to
explain this a lot better. I don't have time today to figure out what
this does.

