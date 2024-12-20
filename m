Return-Path: <linux-fsdevel+bounces-37939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F039F9502
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F78A7A2988
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7E7210182;
	Fri, 20 Dec 2024 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IQWAn3T+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89216C139
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734706897; cv=none; b=L/NfcBrV9tecQDr8C4bVqutwDvZX7nBjU443NFA9CAVaFxsLhJtpH1c/AD779ylqhdBBbhJ7XuIXbW7JhhkWy4469fetxrmhwIdhXEsinIh09EarcX94tydYhWMPk4L/8V0JuIunJ0giWRF4IKzxAt4i1lX3sHHsAubson/RE5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734706897; c=relaxed/simple;
	bh=YICxQZi4cg6eZTeagz9OE+0WDrIIqLAP3jm5f03O+IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohnIuiKrY88qooxMKWrQ/luEORW9u+Wdq6Y0ugf9gpDH8ZQiEVdbjtSmIbtymXMkF5dLRh471sE8WIdJh0QtxKOi9ANRwt8PPhrN1iptXhoBLso5VBmI+U24QNqBoqyKaqSWIQwa2JrVqO2fGCpybxyUZSmA9/jJMDgfo2t4KoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IQWAn3T+; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 20 Dec 2024 10:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734706892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tBvtHZrsG8pIWGr7RL5243AeoJrwfvchc6/qui55As8=;
	b=IQWAn3T+resGcUIbPhveOT6kZBeO2DK89jr2AHL5YPcTknB20R2tLLS20bl6t7cFHCC+sH
	RL0/Q04FBA9dGu9eMdCgZar8xVyLsBGWBUmbs0AXlXvndQTfuyY4D6430qBJ+8NBcsxUVa
	BC3WKto6LbYTspVfkUSruYp5RkDaxjk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Haichi Wang <wanghaichi@tju.edu.cn>, dave.hansen@linux.intel.com, 
	brauner@kernel.org, hpa@zytor.com, viro@zeniv.linux.org.uk, 
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luto@kernel.org, x86@kernel.org, mingo@redhat.com, jack@suse.cz, 
	syzkaller@googlegroups.com
Subject: Re: Kernel bug: "general protection fault in
 bch2_btree_path_traverse_one"
Message-ID: <3gs6aqeby2ymbuhdw3lytsdcl5qigg6ekzox6uejosfodr4xau@dtks66rjrnxa>
References: <AOAA*AACIqMsH7SiGMkHgaoE.1.1734695024950.Hmail.3014218099@tju.edu.cn>
 <Z2V21UH_3FuNDoa1@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2V21UH_3FuNDoa1@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Dec 20, 2024 at 01:53:25PM +0000, Matthew Wilcox wrote:
> On Fri, Dec 20, 2024 at 07:43:44PM +0800, Haichi Wang wrote:
> > Dear Linux maintainers and reviewers:
> > We are reporting a Linux kernel bug titled **general protection fault in bch2_btree_path_traverse_one**, discovered using a modified version of Syzkaller.
> 
> No, you aren't.  This is a terrible bug report, and you seem to have
> sent several with the same defects.  First, read:
> 
> https://blog.regehr.org/archives/2037
> 
> Then, specifically to reporting a kernel bug *LOOK AT HOW OTHER PEOPLE
> DO IT*.  Your email includes lots of stuff that is of no help and
> doesn't include the most important thing -- the kernel logs from around
> the time of the failure.
> 
> > ### Affected Files
> > The affected files, as obtained from the VM log, are listed below. The corresponding maintainers were identified using `./scripts/get_maintainer.pl`:
> > fs/bcachefs/btree_update_interior.c
> > fs/bcachefs/alloc_foreground.c
> > fs/bcachefs/btree_iter.c
> > fs/bcachefs/btree_trans_commit.c
> > fs/namespace.c
> > arch/x86/entry/common.c
> > fs/bcachefs/recovery.c
> > fs/bcachefs/recovery_passes.c
> > fs/bcachefs/super.c
> > fs/bcachefs/fs.c
> > fs/super.c
> 
> This is useless.
> 
> > ### Kernel Versions
> > - **Kernel Version Tested:** v6.12-rc6:59b723cd2adbac2a34fc8e12c74ae26ae45bf230
> > - **Latest Kernel Version Reproduced On:** f44d154d6e3d633d4c49a5d6a8aed0e4684ae25e
> 
> Useful
> 
> > ### Environment Details
> > - **QEMU Version:** QEMU emulator version 4.2.1 (Debian 1:4.2-3ubuntu6.29)  
> > - **GCC Version:** gcc (Ubuntu 11.4.0-2ubuntu1~20.04) 11.4.0  
> > - **Syzkaller Version:** 2b3ef1577cde5da4fd1f7ece079731e140351177
> 
> Useful
> 
> > ### Attached Files
> > We have attached the following files to assist in reproducing and diagnosing the bug:
> > - **Bug Title:** `bugtitle`  
> > - **Bug Report:** `report`  
> > - **Machine Information:** `machineInfo`  
> > - **Kernel Config:** `config`  
> > - **Compiled Kernel Image:** `vmlinux`  
> 
> You didn't attach these things, but please don't.
> 
> We want the stacktrace.  Preferably passed through
> scripts/decode_stacktrace.sh so we get nice symbols.

I'm not at all clear on why we need a syzbot copycat project - why not
just work with those guys and contribute whatever improvements you have
there?

I've been doing some work with the syzbot folks on ktest integration so
I can reproduce syzbot bugs in a single command - I'm not going to redo
that work for a second backend.

