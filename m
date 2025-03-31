Return-Path: <linux-fsdevel+bounces-45394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDBCA77164
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 01:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 124B37A427B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 23:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D2021B9D1;
	Mon, 31 Mar 2025 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNiVSNsE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CEA3232;
	Mon, 31 Mar 2025 23:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743464030; cv=none; b=S6YavzYDyTQAeI8xgM8igwI9tEV/ARtZtirjUq892kqCe+q5itCGOVP/mpkuOItbsMmEv9DZLslR+iRtq3iiYTZkcc3SNXye1HQKrmJ0m0twffkUJKIHkKXjU6SkiaspWdRyHmS3UBcT1QPO5HTyJj+tKzw37RpjicPWFd2mb0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743464030; c=relaxed/simple;
	bh=uvtQcZDjw4xi9dpvQhQJwW1SNMgASlnGK44io0YWTxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sN/vLVqxJ4CGSv/lpOuCkDU/IjVZ+cz9h7mMs9FF9G0uQVH2knNOYpIZrJ/u2oejUrfr8mPYspwEIvEKDO5AvxjHrVSGcL4gpfAZJLYaQaTKcgAVo52JWOjfu0gqLPTGb3W125NpDns0VrkmTFBn8koGVFMlkiveix9vu8QAeRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNiVSNsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6364C4CEE3;
	Mon, 31 Mar 2025 23:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743464029;
	bh=uvtQcZDjw4xi9dpvQhQJwW1SNMgASlnGK44io0YWTxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vNiVSNsEDjWZQRVt+Z5RYriV9CBG4FRqNSrsOyO4MWHybTUvWqCc0lrZoA3Eq5zVi
	 IKwGaFxIwDnaoym0KV5x8dgmxhJ5uojr7TD9zJBrUqTGMPw9ZXgknjPDYb0KTnhubi
	 1BLvD4BoFnS+uKGI1TwruDlMpgSM8X9b1yV2d9Hl3zqkn6euHFoMp+kMKNnmv54kJP
	 2QIhqmf0JnYbIGMxVoQ74ap1D2GMFH6R94rW6kXHJsT8wSWuf6Pl93AgsiiL5ARFfk
	 7CEeAUNF+bQKCk/iEmKkhF1peeI5cE8gLINITsFsD0mhuTCTRrvkpHl9xlMxlmeFz+
	 3lTxzV26F5cig==
Date: Tue, 1 Apr 2025 01:33:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, 
	hch@infradead.org, david@fromorbit.com, rafael@kernel.org, djwong@kernel.org, 
	pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org, 
	boqun.feng@gmail.com
Subject: Re: [PATCH v2 0/6] Extend freeze support to suspend and hibernate
Message-ID: <20250401-vorstadt-natur-38eb98783008@brauner>
References: <20250328-work-freeze-v1-0-a2c3a6b0e7a6@kernel.org>
 <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org>
 <12ce8c18f4e16b1de591cbdfb8f6e7844e42807b.camel@HansenPartnership.com>
 <9c0a24cd8b03539fd6b8ecd5a186a5cf98b5d526.camel@HansenPartnership.com>
 <7clcr53mw5bdd6lfocn6gw7nykqnqxknlaxaagwrb6hmxpyvmo@dxfk3jachnas>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7clcr53mw5bdd6lfocn6gw7nykqnqxknlaxaagwrb6hmxpyvmo@dxfk3jachnas>

On Mon, Mar 31, 2025 at 12:36:27PM +0200, Jan Kara wrote:
> On Sat 29-03-25 13:02:32, James Bottomley wrote:
> > On Sat, 2025-03-29 at 10:04 -0400, James Bottomley wrote:
> > > On Sat, 2025-03-29 at 09:42 +0100, Christian Brauner wrote:
> > > > Add the necessary infrastructure changes to support freezing for
> > > > suspend and hibernate.
> > > > 
> > > > Just got back from LSFMM. So still jetlagged and likelihood of bugs
> > > > increased. This should all that's needed to wire up power.
> > > > 
> > > > This will be in vfs-6.16.super shortly.
> > > > 
> > > > ---
> > > > Changes in v2:
> > > > - Don't grab reference in the iterator make that a requirement for
> > > > the callers that need custom behavior.
> > > > - Link to v1:
> > > > https://lore.kernel.org/r/20250328-work-freeze-v1-0-a2c3a6b0e7a6@kernel.org
> > > 
> > > Given I've been a bit quiet on this, I thought I'd better explain
> > > what's going on: I do have these built, but I made the mistake of
> > > doing a dist-upgrade on my testing VM master image and it pulled in a
> > > version of systemd (257.4-3) that has a broken hibernate.  Since I
> > > upgraded in place I don't have the old image so I'm spending my time
> > > currently debugging systemd ... normal service will hopefully resume
> > > shortly.
> > 
> > I found the systemd bug
> > 
> > https://github.com/systemd/systemd/issues/36888
> > 
> > And hacked around it, so I can confirm a simple hibernate/resume works
> > provided the sd_start_write() patches are applied (and the hooks are
> > plumbed in to pm).
> > 
> > There is an oddity: the systemd-journald process that would usually
> > hang hibernate in D wait goes into R but seems to be hung and can't be
> > killed by the watchdog even with a -9.  It's stack trace says it's
> > still stuck in sb_start_write:
> > 
> > [<0>] percpu_rwsem_wait.constprop.10+0xd1/0x140
> > [<0>] ext4_page_mkwrite+0x3c1/0x560 [ext4]
> > [<0>] do_page_mkwrite+0x38/0xa0
> > [<0>] do_wp_page+0xd5/0xba0
> > [<0>] __handle_mm_fault+0xa29/0xca0
> > [<0>] handle_mm_fault+0x16a/0x2d0
> > [<0>] do_user_addr_fault+0x3ab/0x810
> > [<0>] exc_page_fault+0x68/0x150
> > [<0>] asm_exc_page_fault+0x22/0x30
> > 
> > So I think there's something funny going on in thaw.
> 
> As Christian wrote, it seems systemd-journald does a memory store to
> mmapped file and gets blocked on sb_start_write() while doing the page
> fault. What's strange is that R state. Is the task really executing on some
> CPU or it only has 'R' state (i.e., got woken but never scheduled)?

I think the issue is that we need to also make pagefault based writers
such as systemd-journald freezable:

I don't think that's it. I think you're missing making pagefault writers
such
as systemd-journald freezable:

I don't think that's it. I think you're missing making pagefault writers such
as systemd-journald freezable:

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b379a46b5576..528e73f192ac 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1782,7 +1782,8 @@ static inline void __sb_end_write(struct super_block *sb, int level)
 static inline void __sb_start_write(struct super_block *sb, int level)
 {
        percpu_down_read_freezable(sb->s_writers.rw_sem + level - 1,
-                                  level == SB_FREEZE_WRITE);
+                                  (level == SB_FREEZE_WRITE ||
+                                   level == SB_FREEZE_PAGEFAULT));
 }

