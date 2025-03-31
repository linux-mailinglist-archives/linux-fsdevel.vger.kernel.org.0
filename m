Return-Path: <linux-fsdevel+bounces-45393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25723A77163
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 01:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62B2E7A4004
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 23:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AE321B9D1;
	Mon, 31 Mar 2025 23:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L52f7qtH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918563232;
	Mon, 31 Mar 2025 23:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743463949; cv=none; b=LDJg0D3gaGQvhgbsS5tffGhdbmv0ZUkVOClRwV6qHQfhh8Mybk+hfyXOiq9JvLuiAY+ekPio0Z2+WDMLgpoNN01bH55w1fVd4cbv3W2OmWtgOnUV7R41KacqEtoYyPrNfw7yJDgHgqCylzsFoO/0qjpyqQ5BdythvUbpUQN1n9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743463949; c=relaxed/simple;
	bh=KfDyGYJmMdcOm8P3TtQaQ9b1R2kZOBEQknkokLd5IlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukgMTOy9LDMH+rijws55qyOxbcch8QfIiW6y7ZUP70tyaMvf09ZB6uoyDd+M+CpUDXK9MZFp1sEnkOMAz+MckgeAd/Iadk7nrFIkEt/z1MatDnX07cnSI+3Hlu8NJwJg8ctpg0eZiLGARlMUnjfCBvUrcbhXmiLMsOFbBuT3S/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L52f7qtH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B187FC4CEE3;
	Mon, 31 Mar 2025 23:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743463949;
	bh=KfDyGYJmMdcOm8P3TtQaQ9b1R2kZOBEQknkokLd5IlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L52f7qtH0YYMlGGKyjWqsHVYFq5sWNItmvLXGj7f4y13EVkA6RJwGuBbHm6vBBZFp
	 x5XMWn+V4Kyp7s2mDSzoh9LTTf7suoFcp9AsTCP4GjjfFekr0InBXBBuuULxVVKG87
	 DzOWablGmSNxRmEuRN1JuaNU9j/SP11VfCQpLG5wJBPfa5tHx1U69r0d7ETIBro9tc
	 4MVRhG/0OSzLHIw7pPnLG4GFGtIJflGHqUOgigf93iZYcK+a6zXaU/g3vIM7FHQNU3
	 S0JX1/s7Yotfuap35W9HY0odc0hwsBOauunOxX6eaIRf/Jcb15y22/A/j+5W63Yi+Y
	 h/JHmZ+OVK4fQ==
Date: Tue, 1 Apr 2025 01:32:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, rafael@kernel.org, 
	djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, boqun.feng@gmail.com
Subject: Re: [RFC PATCH 1/4] locking/percpu-rwsem: add freezable alternative
 to down_read
Message-ID: <20250401-anwalt-dazugeben-18d8c3efd1fd@brauner>
References: <20250327140613.25178-1-James.Bottomley@HansenPartnership.com>
 <20250327140613.25178-2-James.Bottomley@HansenPartnership.com>
 <77774eb380e343976de3de681204e2c7f3ab1926.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77774eb380e343976de3de681204e2c7f3ab1926.camel@HansenPartnership.com>

On Mon, Mar 31, 2025 at 03:51:43PM -0400, James Bottomley wrote:
> On Thu, 2025-03-27 at 10:06 -0400, James Bottomley wrote:
> [...]
> > -static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem, bool
> > reader)
> > +static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem, bool
> > reader,
> > +			      bool freeze)
> >  {
> >  	DEFINE_WAIT_FUNC(wq_entry, percpu_rwsem_wake_function);
> >  	bool wait;
> > @@ -156,7 +157,8 @@ static void percpu_rwsem_wait(struct
> > percpu_rw_semaphore *sem, bool reader)
> >  	spin_unlock_irq(&sem->waiters.lock);
> >  
> >  	while (wait) {
> > -		set_current_state(TASK_UNINTERRUPTIBLE);
> > +		set_current_state(TASK_UNINTERRUPTIBLE |
> > +				  freeze ? TASK_FREEZABLE : 0);
> 
> This is a bit embarrassing, the bug I've been chasing is here: the ?
> operator is lower in precedence than | meaning this expression always
> evaluates to TASK_FREEZABLE and nothing else (which is why the process
> goes into R state and never wakes up).
> 
> Let me fix that and redo all the testing.

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

 static inline bool __sb_start_write_trylock(struct super_block *sb, int level)

