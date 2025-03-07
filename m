Return-Path: <linux-fsdevel+bounces-43453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34866A56C78
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 16:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B21188A2B2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 15:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768DA634EC;
	Fri,  7 Mar 2025 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Rrhx66eD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B33DDD2
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362378; cv=none; b=IQTfQk2ZMZSIsBmQar/M40WW+/S1xlK7SDYgNLYIrQJUXkazRa6RoDaPHT0G41xcPY4wR6+HtnPhaFhlV6cUGJJ/q1NvNSlWN48YljQVUUhbAa8oGx62nTZpUpbhWvpU5w1FAsub77ITC9k3EbZKikWLl7sm7aux34fiqLrfnUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362378; c=relaxed/simple;
	bh=z7gs7BlfOC/UBYmevmQVkCHwb3yUJYsPO1D5N15aWig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZbFp8bPGVk1YF8zMY7NMUsp32HtqwblCtAaJo7oxKUzZxvgRHgTo/uY04WxY136pO82EoPOfaPDJaS+2G7d+u1+HFtWSvgi5vFG719jkPtI+CVttrQPOemaJSq5a8Ds/teO99eGyd6RgNJ0osXP9OMAwkReED3atVfCo0MZjrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Rrhx66eD; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6fd9d9ae47cso19629017b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Mar 2025 07:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1741362376; x=1741967176; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=24J3CynJ4fNToC40YYg0INXois46zfdfDDswNEU4WCw=;
        b=Rrhx66eDhzAlGmIJ4yyWZduZGji29jN0g+ooBuiLcBEPepOAZpG28baKczOkkPZG02
         Kj7rQClfecgJbS1L1vb/nI6v+bK7FA/+B5I2hvFlcpbZOj/GoVO+3Y9FDCjiL+qCOg4U
         KTWXUf3s7R/fKYhWVINW7yM2jBj4opefgeDph89h0TDH9PSgMx0HcfiAvY5btA1zCqG8
         am3R73qwsw2JXaHzeQvrJ+dWNvJOafvfS3ABcD20+GSV1V1twzTTQA5rbQaFCmeokae2
         GU0Dlk7sJbK/lE2nB7T1vRDTwqCt4VIb5HGBlRvuPXLd5unVvq6Etw75w1VcfgtQH4rs
         Odxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741362376; x=1741967176;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24J3CynJ4fNToC40YYg0INXois46zfdfDDswNEU4WCw=;
        b=KJ4TfvMz3jrg3B2O6TNzH3Krab+PYkQSbqu5QHyFH6cKv5ZXfZn8I81S2L4+oOd47K
         byLIdExo7EKi5KjJsCOJpxzk1qLje5RK9pwYniEd89RVgZGnCAqJM+RsFxw9c5OmbSny
         lS7WRrr4iLXJ4/k4GohQ8CDAC60WouigDB3QAyaKhcTQTTBFfyusR0WN62yqN5WY90Y4
         fkNWUt7uqG51sqeBsCGyfJbFfsqBpJ0UVGsswxhXHB4EKWBDmyDmNcifFGMFUnxqQGua
         xF3Jz83F7W2eRGwTWLPf36gmUbgHKehg5/+XJe5syRhl9kFetzyFG8VLpyhcgkhVCC3s
         Cqgw==
X-Forwarded-Encrypted: i=1; AJvYcCUsgyVpSOn1qy6cI86qInk4jK88Kq+8VccGMTFn1BF3UcdZKnIdMFkbivTteqEk+EpGmEh3OMqp+mI94prg@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2wTPIQGdBk3akLgWXMpvpuLtvVVV09i7dZsnTyofgJ/oJOibu
	YeGrsZz+AnNu/IWj+UtczYZJsj0j57MBZ9kwGxRoyZLcB/Bt4C+pIKgs0vnZPH8=
X-Gm-Gg: ASbGncu9A+tMVzZmmVoBSzMzsErB2GRPlf32BToVfASY5utOXXFaCiOcs2Qw0nKmS8E
	/k+OtX//chw3l/o3AKTmkPXqz/Kq+fmkzgGURgA+QC+s5iisYcwXQ5Ojz8QCBxHGngCPBJJ/63b
	7NLKdqMrliNvnzX88KEXwkWevqOsDSZQ3vdCYM6s71c88BdtDOBms+FDM9KBWs+SkAgPWUHAXEi
	skY+Y4AaQWTLAnoxKTULIUwT+3MhgDIFHezWEsvqYyUoZhuwVLTgN+/uU4mW/y03l4Mq9ZuGfMW
	Syg/K+vF2AhLfc42ANPavruW10EU9K3FIfbi1Qmh6cPXetCrcDGed2nmRLwQZDUFHZmcv9lFYJx
	Ym+ENBg==
X-Google-Smtp-Source: AGHT+IFbO7B7I5QW8p7YyFhEoZvye5dOa0V+vkMhRA5dzshNa6dL/BbXoDUHXepaAKDlZqjdHG+27w==
X-Received: by 2002:a05:690c:3386:b0:6fb:9474:7b5f with SMTP id 00721157ae682-6febf2eb32dmr60526787b3.14.1741362375930;
        Fri, 07 Mar 2025 07:46:15 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2c4676fsm7827907b3.103.2025.03.07.07.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:46:14 -0800 (PST)
Date: Fri, 7 Mar 2025 10:46:14 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>,
	syzbot <syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org,
	cem@kernel.org, chandan.babu@oracle.com, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] WARNING in fsnotify_file_area_perm
Message-ID: <20250307154614.GA59451@perftesting>
References: <67a487f7.050a0220.19061f.05fc.GAE@google.com>
 <67c4881e.050a0220.1dee4d.0054.GAE@google.com>
 <7ehxrhbvehlrjwvrduoxsao5k3x4aw275patsb3krkwuq573yv@o2hskrfawbnc>
 <CAOQ4uxjf5H_vj-swF7wEvUkPobEuxs2q6jfO9jFsx4pqxtJMMg@mail.gmail.com>
 <20250304161509.GA4047943@perftesting>
 <CAOQ4uxj0cN-sUN=EE0+9tRhMFFrWLQ0T_i0fprwNRr92Hire6Q@mail.gmail.com>
 <20250304203657.GA4063187@perftesting>
 <CAOQ4uxihyR8u5c0T8q85ySNgp4U1T0MMSR=+vv3HWNFcvezRPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxihyR8u5c0T8q85ySNgp4U1T0MMSR=+vv3HWNFcvezRPQ@mail.gmail.com>

On Tue, Mar 04, 2025 at 10:13:39PM +0100, Amir Goldstein wrote:
> On Tue, Mar 4, 2025 at 9:37 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Tue, Mar 04, 2025 at 09:27:20PM +0100, Amir Goldstein wrote:
> > > On Tue, Mar 4, 2025 at 5:15 PM Josef Bacik <josef@toxicpanda.com> wrote:
> > > >
> > > > On Tue, Mar 04, 2025 at 04:09:16PM +0100, Amir Goldstein wrote:
> > > > > On Tue, Mar 4, 2025 at 12:06 PM Jan Kara <jack@suse.cz> wrote:
> > > > > >
> > > > > > Josef, Amir,
> > > > > >
> > > > > > this is indeed an interesting case:
> > > > > >
> > > > > > On Sun 02-03-25 08:32:30, syzbot wrote:
> > > > > > > syzbot has found a reproducer for the following issue on:
> > > > > > ...
> > > > > > > ------------[ cut here ]------------
> > > > > > > WARNING: CPU: 1 PID: 6440 at ./include/linux/fsnotify.h:145 fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify.h:145
> > > > > > > Modules linked in:
> > > > > > > CPU: 1 UID: 0 PID: 6440 Comm: syz-executor370 Not tainted 6.14.0-rc4-syzkaller-ge056da87c780 #0
> > > > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
> > > > > > > pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > > > > > pc : fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify.h:145
> > > > > > > lr : fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify.h:145
> > > > > > > sp : ffff8000a42569d0
> > > > > > > x29: ffff8000a42569d0 x28: ffff0000dcec1b48 x27: ffff0000d68a1708
> > > > > > > x26: ffff0000d68a16c0 x25: dfff800000000000 x24: 0000000000008000
> > > > > > > x23: 0000000000000001 x22: ffff8000a4256b00 x21: 0000000000001000
> > > > > > > x20: 0000000000000010 x19: ffff0000d68a16c0 x18: ffff8000a42566e0
> > > > > > > x17: 000000000000e388 x16: ffff800080466c24 x15: 0000000000000001
> > > > > > > x14: 1fffe0001b31513c x13: 0000000000000000 x12: 0000000000000000
> > > > > > > x11: 0000000000000001 x10: 0000000000ff0100 x9 : 0000000000000000
> > > > > > > x8 : ffff0000c6d98000 x7 : 0000000000000000 x6 : 0000000000000000
> > > > > > > x5 : 0000000000000020 x4 : 0000000000000000 x3 : 0000000000001000
> > > > > > > x2 : ffff8000a4256b00 x1 : 0000000000000001 x0 : 0000000000000000
> > > > > > > Call trace:
> > > > > > >  fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify.h:145 (P)
> > > > > > >  filemap_fault+0x12b0/0x1518 mm/filemap.c:3509
> > > > > > >  xfs_filemap_fault+0xc4/0x194 fs/xfs/xfs_file.c:1543
> > > > > > >  __do_fault+0xf8/0x498 mm/memory.c:4988
> > > > > > >  do_read_fault mm/memory.c:5403 [inline]
> > > > > > >  do_fault mm/memory.c:5537 [inline]
> > > > > > >  do_pte_missing mm/memory.c:4058 [inline]
> > > > > > >  handle_pte_fault+0x3504/0x57b0 mm/memory.c:5900
> > > > > > >  __handle_mm_fault mm/memory.c:6043 [inline]
> > > > > > >  handle_mm_fault+0xfa8/0x188c mm/memory.c:6212
> > > > > > >  do_page_fault+0x570/0x10a8 arch/arm64/mm/fault.c:690
> > > > > > >  do_translation_fault+0xc4/0x114 arch/arm64/mm/fault.c:783
> > > > > > >  do_mem_abort+0x74/0x200 arch/arm64/mm/fault.c:919
> > > > > > >  el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:432
> > > > > > >  el1h_64_sync_handler+0x60/0xcc arch/arm64/kernel/entry-common.c:510
> > > > > > >  el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:595
> > > > > > >  __uaccess_mask_ptr arch/arm64/include/asm/uaccess.h:169 [inline] (P)
> > > > > > >  fault_in_readable+0x168/0x310 mm/gup.c:2234 (P)
> > > > > > >  fault_in_iov_iter_readable+0x1dc/0x22c lib/iov_iter.c:94
> > > > > > >  iomap_write_iter fs/iomap/buffered-io.c:950 [inline]
> > > > > > >  iomap_file_buffered_write+0x490/0xd54 fs/iomap/buffered-io.c:1039
> > > > > > >  xfs_file_buffered_write+0x2dc/0xac8 fs/xfs/xfs_file.c:792
> > > > > > >  xfs_file_write_iter+0x2c4/0x6ac fs/xfs/xfs_file.c:881
> > > > > > >  new_sync_write fs/read_write.c:586 [inline]
> > > > > > >  vfs_write+0x704/0xa9c fs/read_write.c:679
> > > > > >
> > > > > > The backtrace actually explains it all. We had a buffered write whose
> > > > > > buffer was mmapped file on a filesystem with an HSM mark. Now the prefaulting
> > > > > > of the buffer happens already (quite deep) under the filesystem freeze
> > > > > > protection (obtained in vfs_write()) which breaks assumptions of HSM code
> > > > > > and introduces potential deadlock of HSM handler in userspace with filesystem
> > > > > > freezing. So we need to think how to deal with this case...
> > > > >
> > > > > Ouch. It's like the splice mess all over again.
> > > > > Except we do not really care to make this use case work with HSM
> > > > > in the sense that we do not care to have to fill in the mmaped file content
> > > > > in this corner case - we just need to let HSM fail the access if content is
> > > > > not available.
> > > > >
> > > > > If you remember, in one of my very early version of pre-content events,
> > > > > the pre-content event (or maybe it was FAN_ACCESS_PERM itself)
> > > > > carried a flag (I think it was called FAN_PRE_VFS) to communicate to
> > > > > HSM service if it was safe to write to fs in the context of event handling.
> > > > >
> > > > > At the moment, I cannot think of any elegant way out of this use case
> > > > > except annotating the event from fault_in_readable() as "unsafe-for-write".
> > > > > This will relax the debugging code assertion and notify the HSM service
> > > > > (via an event flag) that it can ALLOW/DENY, but it cannot fill the file.
> > > > > Maybe we can reuse the FAN_ACCESS_PERM event to communicate
> > > > > this case to HSM service.
> > > > >
> > > > > WDYT?
> > > >
> > > > I think that mmap was a mistake.
> > >
> > > What do you mean?
> > > Isn't the fault hook required for your large executables use case?
> >
> > I mean the mmap syscall was a mistake ;).
> >
> 
> ah :)
> 
> > >
> > > >
> > > > Is there a way to tell if we're currently in a path that is under fsfreeze
> > > > protection?
> > >
> > > Not at the moment.
> > > At the moment, file_write_not_started() is not a reliable check
> > > (has false positives) without CONFIG_LOCKDEP.
> > >
> 
> One very ugly solution is to require CONFIG_LOCKDEP for
> pre-content events.
> 
> > > > Just denying this case would be a simpler short term solution while
> > > > we come up with a long term solution. I think your solution is fine, but I'd be
> > > > just as happy with a simpler "this isn't allowed" solution. Thanks,
> > >
> > > Yeh, I don't mind that, but it's a bit of an overkill considering that
> > > file with no content may in fact be rare.
> >
> > Agreed, I'm fine with your solution.
> 
> Well, my "solution" was quite hand-wavy - it did not really say how to
> propagate the fact that faults initiated from fault_in_readable().
> Do you guys have any ideas for a simple solution?

Sorry I've been elbow deep in helping getting our machine replacements working
faster.

I've been thnking about this, it's not like we can carry context from the reason
we are faulting in, at least not simply, so I think the best thing to do is
either 

1) Emit a precontent event at mmap() time for the whole file, since really all I
care about is faulting at exec time, and then we can just skip the precontent
event if we're not exec.

2) Revert the page fault stuff, put back your thing to fault the whole file, and
wait until we think of a better way to deal with this.

Obviously I'd prefer not #2, but I'd really, really rather not chuck all of HSM
because my page fault thing is silly.  I'll carry what I need internally while
we figure out what to do upstream.  #1 doesn't seem bad, but I haven't thought
about it that hard.  Thanks,

Josef

