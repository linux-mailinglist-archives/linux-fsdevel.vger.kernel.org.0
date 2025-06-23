Return-Path: <linux-fsdevel+bounces-52603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85897AE474F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68E703A2C4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5A2267F66;
	Mon, 23 Jun 2025 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ikd3nPje"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA6426772A
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750689921; cv=none; b=efZGMJmmKLLi+NE78MFFwW1veWFw/u+ZV2+p9DooG3MnB9JCeLKMUl/jI509P3MmVA3R44DNnVCNq3C8XX+nos2lFYxLE+/V5Ko89cWQtTJ+sKLrK1O5YByVgeYBuig32r9RmkZeTm+I5myHFeoIX8tCGo/wU7XAbLpK+SGZFu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750689921; c=relaxed/simple;
	bh=/ExXbG9aE0N0hF5gqVPUSfVZFXmpHc4FB9GxYUjmk74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4+pTL7ZHHUM9S9hyVg64F8HE2B27wqx+qZjJ6HkCQfeqksx3CsKJdizHycdUtol/PFPMg1V4aBOLioSfDEPW5FnMjJ6EilmQ0nF6KOBj+3fBH6yH2CXVNA6PVkTXy6WJLjruNltRRwaP15/UdvwIlMYnI7EMiG4/LrGRa0XJk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ikd3nPje; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=2IvLCpHXXheOeCjVvL++yTFINi93KRNQKXrT18+/OaI=; b=ikd3nPjet3xR2jf2aLk/wbAbzb
	362R1jVjxeFpBXnxs11CsQhWkTnTQiZOrq0Kont4nI+ekwDqRdzug0hb6ESg6MX0MBlgu4TxxVidp
	yyXzcJnMjlvPS/Dr1Q15kHYQvFVkGW70jSg2BkEGshEHOtYfKfDKcAHfb4bJBpNRwD0nFKvqOtt5H
	fG3IEC3DmEw6P013mRQ5IcfMVvHAqfWyKTbRYWbOlfkHOy9HO1+DFvUVoVcofMkeGXKGFBzyaahV8
	8W/Qpwci0NWRLGNv3ZZboBBK0N+0tSjzIM7jp+w+vjEqNp7DfzzckhPRFCXXjDMOqXoYSfDCpMhtL
	Q08zJrTw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTiQ7-0000000CuJt-36YE;
	Mon, 23 Jun 2025 14:45:15 +0000
Date: Mon, 23 Jun 2025 15:45:15 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Eric Biggers <ebiggers@google.com>, linux-fsdevel@vger.kernel.org,
	LTP List <ltp@lists.linux.it>, Petr Vorel <pvorel@suse.cz>
Subject: Re: interesting breakage in ltp fanotify10
Message-ID: <20250623144515.GB1880847@ZenIV>
References: <20250622215140.GX1880847@ZenIV>
 <CAOQ4uxioVpa3u3MKwFBibs2X0TWiqwY=uGTZnjDoPSB01kk=yQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxioVpa3u3MKwFBibs2X0TWiqwY=uGTZnjDoPSB01kk=yQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 23, 2025 at 09:24:22AM +0200, Amir Goldstein wrote:
> On Sun, Jun 22, 2025 at 11:51 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         LTP 6763a3650734 "syscalls/fanotify10: Add test cases for evictable
> > ignore mark" has an interesting effect on boxen where FANOTIFY is not
> > enabled.  The thing is, tst_brk() ends up calling ->cleanup().  See the
> > problem?
> >         SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "%d", old_cache_pressure);
> > is executed, even though
> >         SAFE_FILE_SCANF(CACHE_PRESSURE_FILE, "%d", &old_cache_pressure);
> >         /* Set high priority for evicting inodes */
> >         SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "500");
> > hadn't been.
> >
> >         Result: fanotify10 on such kernel configs ends up zeroing
> > /proc/sys/vm/vfs_cache_pressure.
> 
> oops.
> strange enough, I cannot reproduce it as something is preventing
> zeroing vfs_cache_pressure:
> 
> fanotify23.c:232: TCONF: fanotify not configured in kernel
> fanotify23.c:249: TWARN: Failed to close FILE
> '/proc/sys/vm/vfs_cache_pressure': EINVAL (22)

How old is your ltp tree?  Mine was from late May (81d460ba6737 "overcommit_memory:
Disable optimization for malloc to prevent false positives") and I'm definitely 
seeing that behaviour with fanotify23 as well.  No TWARN, though -
cmdline="fanotify23"
contacts=""
analysis=exit
<<<test_output>>>
tst_tmpdir.c:316: TINFO: Using /tmp/ltp-sIG1rbZMcQ/LTP_fan7Qw3GC as tmpdir (ext2/ext3/ext4 filesystem)
tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1216: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.47.2 (1-Jan-2025)
tst_test.c:1228: TINFO: Mounting /dev/loop0 to /tmp/ltp-sIG1rbZMcQ/LTP_fan7Qw3GC/fs_mnt fstyp=ext2 flags=0
tst_test.c:1952: TINFO: LTP version: 20250130-274-g81d460ba6
tst_test.c:1955: TINFO: Tested kernel: 6.16.0-rc3+ #32 SMP PREEMPT_DYNAMIC Sun Jun 22 19:06:57 EDT 2025 x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/boot/config-6.16.0-rc3+'
tst_test.c:1773: TINFO: Overall timeout per run is 0h 00m 30s
fanotify.h:175: TCONF: fanotify not configured in kernel

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=32 corefile=no
cutime=0 cstime=1
<<<test_end>>>

