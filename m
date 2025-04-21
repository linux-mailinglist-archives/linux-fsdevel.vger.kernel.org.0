Return-Path: <linux-fsdevel+bounces-46808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BED5A953C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 17:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584701890188
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 15:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D071DF26B;
	Mon, 21 Apr 2025 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i3Gidkq3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D007D3F4
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745250957; cv=none; b=mqf4y7NK59qA7VpnEK4IRJtpQoLgizOGoFQloBjG91tbOmSwa/IXSocZLqxQDJGQ1PnKktPHf+VETntZkFzdFcpSqF85XaXbQTL+oDOhzSmg/CIBLCW10PmYx9B+c5q4SHHG2c4JnjV61l0nMBd7mw1E7cjitZ50BSdZrl/LIZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745250957; c=relaxed/simple;
	bh=SB7tPH38oQbn3xC2xqYqN44OAIcLL/WQ30Whw04JByE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEq8cbEOxKDdEoZ3t4x2/YB3ZuP7LDN8ejZC/TeW9C7ARUXxZNbJm6fkk2n04DGMuKt9L5KjDaI1/GLkjxygcK/uZkIa/iLd6ssH7KnxloUAPJKYUOEnkxVGRaRBTLLCobUnjUkKIw28ho4kr+ULHCHsyTS7+s9rnfNcFMzxd2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i3Gidkq3; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 21 Apr 2025 11:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745250951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UoSZJKDzfaKsirHVQWZr7LOj5trZ+TFj4jwsaD9UBbk=;
	b=i3Gidkq3wzL0nc3C6ICt+faxIb/HU+7DNm0WnMTfZn7OjRRhyqOSuQBm5G+YmdAt6MzKFP
	kRtT6IzVMA9OmEVrfP1GX6M4Sa2EXWf1b6vKWnKB9vMFdHcl5++aziYGxtxRCc7r+Q8oH2
	02lUGZlxpz/VVLs6sqDal/cI+ePoJhw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Raghavendra K T <raghavendra.kt@amd.com>
Cc: linux-mm@kvack.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, wqu@suse.com
Subject: Re: scheduling while atomic on rc3 - migration + buffer heads
Message-ID: <uy55hkjdrlnotqzb6rdjktgwv4abp2qxhspi3o63lnj2qjoreu@aegvqlbnfe2p>
References: <hdqfrw2zii53qgyqnq33o4takgmvtgihpdeppkcsayn5wrmpyu@o77ad4o5gjlh>
 <7b395468-d72d-42c1-b891-75f127a1c534@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b395468-d72d-42c1-b891-75f127a1c534@amd.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 21, 2025 at 09:17:18PM +0530, Raghavendra K T wrote:
> On 4/21/2025 8:44 PM, Kent Overstreet wrote:
> 
> +Qu as I see similar report from him
> 
> > This just popped up in one of my test runs.
> > 
> > Given that it's buffer heads, it has to be the ext4 root filesystem, not
> > bcachefs.
> > 
> > 00465 ========= TEST   lz4_buffered
> > 00465
> > 00465 WATCHDOG 360
> > 00466 bcachefs (vdb): starting version 1.25: extent_flags opts=errors=panic,compression=lz4
> > 00466 bcachefs (vdb): initializing new filesystem
> > 00466 bcachefs (vdb): going read-write
> > 00466 bcachefs (vdb): marking superblocks
> > 00466 bcachefs (vdb): initializing freespace
> > 00466 bcachefs (vdb): done initializing freespace
> > 00466 bcachefs (vdb): reading snapshots table
> > 00466 bcachefs (vdb): reading snapshots done
> > 00466 bcachefs (vdb): done starting filesystem
> > 00466 starting copy
> > 00515 BUG: sleeping function called from invalid context at mm/util.c:743
> > 00515 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 120, name: kcompactd0
> > 00515 preempt_count: 1, expected: 0
> > 00515 RCU nest depth: 0, expected: 0
> > 00515 1 lock held by kcompactd0/120:
> > 00515  #0: ffffff80c0c558f0 (&mapping->i_private_lock){+.+.}-{3:3}, at: __buffer_migrate_folio+0x114/0x298
> > 00515 Preemption disabled at:
> > 00515 [<ffffffc08025fa84>] __buffer_migrate_folio+0x114/0x298
> > 00515 CPU: 11 UID: 0 PID: 120 Comm: kcompactd0 Not tainted 6.15.0-rc3-ktest-gb2a78fdf7d2f #20530 PREEMPT
> > 00515 Hardware name: linux,dummy-virt (DT)
> > 00515 Call trace:
> > 00515  show_stack+0x1c/0x30 (C)
> > 00515  dump_stack_lvl+0xb0/0xc0
> > 00515  dump_stack+0x14/0x20
> > 00515  __might_resched+0x180/0x288
> > 00515  folio_mc_copy+0x54/0x98
> > 00515  __migrate_folio.isra.0+0x68/0x168
> > 00515  __buffer_migrate_folio+0x280/0x298
> > 00515  buffer_migrate_folio_norefs+0x18/0x28
> > 00515  migrate_pages_batch+0x94c/0xeb8
> > 00515  migrate_pages_sync+0x84/0x240
> > 00515  migrate_pages+0x284/0x698
> > 00515  compact_zone+0xa40/0x10f8
> > 00515  kcompactd_do_work+0x204/0x498
> > 00515  kcompactd+0x3c4/0x400
> > 00515  kthread+0x13c/0x208
> > 00515  ret_from_fork+0x10/0x20
> > 00518 starting sync
> > 00519 starting rm
> > 00520 ========= FAILED TIMEOUT lz4_buffered in 360s
> > 
> 
> I have also seen similar stack with folio_mc_copy() while testing
> PTE A bit patches.
> 
> IIUC, it has something to do with cond_resched() called from
> folio_mc_copy().
> 
> (Thomas (tglx) mentioned long back that cond_resched() does not have the
> scope awareness), not sure where should the fix be done in these
> cases..

That's true, calling cond_resched() while a spinlock held is a bug.

> (I mean caller of the migrate_folio should call with no spinlock held
> but with mutex? )

Yes. migrate_folio() does large data copies, so we don't want all that
running in atomic context.

