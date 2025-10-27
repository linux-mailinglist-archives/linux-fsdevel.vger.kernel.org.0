Return-Path: <linux-fsdevel+bounces-65703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE428C0D762
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 13:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3377B3ACA03
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 12:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF841301472;
	Mon, 27 Oct 2025 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpUAvZe6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B9A2FFFB6
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567137; cv=none; b=Mw7u/NolWZikxDhh29Kdr4yGPRWhwjhQD2E20qxGpkVKDYWtqJk+q22S9goE4U5ojLOQbvn/aHVUuWto9HY89uUC/RPsxDfRzHk4qeU3KfOH0rOsI4ogDkZTYF3MfBgzDGAM9HwV5eA3F8gh/OkLtAk8LpOG+0bqEwN6uzVc4mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567137; c=relaxed/simple;
	bh=Abr5mbwnWBxHCsJT0JX28zRVj7tmgWW1C8etKDryohM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTNjNrN1/ISQXrilLiWraPyxrqTL+Ia0Lg/aD+F8HXlrn8qr6zhliDH5qi7AAUn/YfRVGCBz+8+A9QR8hzTR7i+hDK7U1F2bqXOIAG3eHj5ksSxAWSYf6o4ozUy1efEz2wim3i4DkaOXFTAJvSkz1VOa1XBYAXVLfQWfifEQdoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UpUAvZe6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761567133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8QmYcf2qcgHxyLSSNmPzf2VO7g9R1+3AwVMwAbR4/s=;
	b=UpUAvZe6uK10LI1iZhcTmote/rKR2VL6JEkVbxbinI6FGXxHGltMQApTkyPRs0CsRi9E41
	gLjUCrll3wBI2YHUYbdIi58f4OPHO91AgYH+4XO3HpHkP52/3V1L1EtLpRhSRi1WgqGXP6
	/FFHe3mb2Z7P3MNwcBIlJIBg4dz6CA8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-gTH_jFoHP2-lTU4NonmGOw-1; Mon,
 27 Oct 2025 08:12:09 -0400
X-MC-Unique: gTH_jFoHP2-lTU4NonmGOw-1
X-Mimecast-MFC-AGG-ID: gTH_jFoHP2-lTU4NonmGOw_1761567127
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 420A81956095;
	Mon, 27 Oct 2025 12:12:07 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.105])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE0241955F1B;
	Mon, 27 Oct 2025 12:12:03 +0000 (UTC)
Date: Mon, 27 Oct 2025 08:16:22 -0400
From: Brian Foster <bfoster@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org,
	hch@infradead.org, hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 07/14] iomap: track pending read bytes more optimally
Message-ID: <aP9illNXOVJ8SF6m@bfoster>
References: <20250926002609.1302233-1-joannelkoong@gmail.com>
 <20250926002609.1302233-8-joannelkoong@gmail.com>
 <aPqDPjnIaR3EF5Lt@bfoster>
 <CAJnrk1aNrARYRS+_b0v8yckR5bO4vyJkGKZHB2788vLKOY7xPw@mail.gmail.com>
 <CAJnrk1b3bHYhbW9q0r4A0NjnMNEbtCFExosAL_rUoBupr1mO3Q@mail.gmail.com>
 <aPuz4Uop66-jRpN-@bfoster>
 <CAJnrk1bqjykKtpAdsHLPuuvHTzOHW0tExRZ8KKmKYyfDpuAsTQ@mail.gmail.com>
 <CAJnrk1ZOcnOT77c2fCiqzV=ZiiNnxOcB7wXn4=V+VFijS+-2Rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZOcnOT77c2fCiqzV=ZiiNnxOcB7wXn4=V+VFijS+-2Rw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Oct 24, 2025 at 02:55:20PM -0700, Joanne Koong wrote:
> On Fri, Oct 24, 2025 at 12:48 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > On Fri, Oct 24, 2025 at 10:10 AM Brian Foster <bfoster@redhat.com> wrote:
> > >
> > > On Fri, Oct 24, 2025 at 09:25:13AM -0700, Joanne Koong wrote:
> > > > On Thu, Oct 23, 2025 at 5:01 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> > > > >
> > > > > On Thu, Oct 23, 2025 at 12:30 PM Brian Foster <bfoster@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Sep 25, 2025 at 05:26:02PM -0700, Joanne Koong wrote:
> > > > > > > Instead of incrementing read_bytes_pending for every folio range read in
> > > > > > > (which requires acquiring the spinlock to do so), set read_bytes_pending
> > > > > > > to the folio size when the first range is asynchronously read in, keep
> > > > > > > track of how many bytes total are asynchronously read in, and adjust
> > > > > > > read_bytes_pending accordingly after issuing requests to read in all the
> > > > > > > necessary ranges.
> > > > > > >
> > > > > > > iomap_read_folio_ctx->cur_folio_in_bio can be removed since a non-zero
> > > > > > > value for pending bytes necessarily indicates the folio is in the bio.
> > > > > > >
> > > > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > > > Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
> > > > > > > ---
> > > > > >
> > > > > > Hi Joanne,
> > > > > >
> > > > > > I was throwing some extra testing at the vfs-6.19.iomap branch since the
> > > > > > little merge conflict thing with iomap_iter_advance(). I end up hitting
> > > > > > what appears to be a lockup on XFS with 1k FSB (-bsize=1k) running
> > > > > > generic/051. It reproduces fairly reliably within a few iterations or so
> > > > > > and seems to always stall during a read for a dedupe operation:
> > > > > >
> > > > > > task:fsstress        state:D stack:0     pid:12094 tgid:12094 ppid:12091  task_flags:0x400140 flags:0x00080003
> > > > > > Call Trace:
> > > > > >  <TASK>
> > > > > >  __schedule+0x2fc/0x7a0
> > > > > >  schedule+0x27/0x80
> > > > > >  io_schedule+0x46/0x70
> > > > > >  folio_wait_bit_common+0x12b/0x310
> > > > > >  ? __pfx_wake_page_function+0x10/0x10
> > > > > >  ? __pfx_xfs_vm_read_folio+0x10/0x10 [xfs]
> > > > > >  filemap_read_folio+0x85/0xd0
> > > > > >  ? __pfx_xfs_vm_read_folio+0x10/0x10 [xfs]
> > > > > >  do_read_cache_folio+0x7c/0x1b0
> > > > > >  vfs_dedupe_file_range_compare.constprop.0+0xaf/0x2d0
> > > > > >  __generic_remap_file_range_prep+0x276/0x2a0
> > > > > >  generic_remap_file_range_prep+0x10/0x20
> > > > > >  xfs_reflink_remap_prep+0x22c/0x300 [xfs]
> > > > > >  xfs_file_remap_range+0x84/0x360 [xfs]
> > > > > >  vfs_dedupe_file_range_one+0x1b2/0x1d0
> > > > > >  ? remap_verify_area+0x46/0x140
> > > > > >  vfs_dedupe_file_range+0x162/0x220
> > > > > >  do_vfs_ioctl+0x4d1/0x940
> > > > > >  __x64_sys_ioctl+0x75/0xe0
> > > > > >  do_syscall_64+0x84/0x800
> > > > > >  ? do_syscall_64+0xbb/0x800
> > > > > >  ? avc_has_perm_noaudit+0x6b/0xf0
> > > > > >  ? _copy_to_user+0x31/0x40
> > > > > >  ? cp_new_stat+0x130/0x170
> > > > > >  ? __do_sys_newfstat+0x44/0x70
> > > > > >  ? do_syscall_64+0xbb/0x800
> > > > > >  ? do_syscall_64+0xbb/0x800
> > > > > >  ? clear_bhb_loop+0x30/0x80
> > > > > >  ? clear_bhb_loop+0x30/0x80
> > > > > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > > > RIP: 0033:0x7fe6bbd9a14d
> > > > > > RSP: 002b:00007ffde72cd4e0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > > > > > RAX: ffffffffffffffda RBX: 0000000000000068 RCX: 00007fe6bbd9a14d
> > > > > > RDX: 000000000a1394b0 RSI: 00000000c0189436 RDI: 0000000000000004
> > > > > > RBP: 00007ffde72cd530 R08: 0000000000001000 R09: 000000000a11a3fc
> > > > > > R10: 000000000001d6c0 R11: 0000000000000246 R12: 000000000a12cfb0
> > > > > > R13: 000000000a12ba10 R14: 000000000a14e610 R15: 0000000000019000
> > > > > >  </TASK>
> > > > > >
> > > > > > It wasn't immediately clear to me what the issue was so I bisected and
> > > > > > it landed on this patch. It kind of looks like we're failing to unlock a
> > > > > > folio at some point and then tripping over it later..? I can kill the
> > > > > > fsstress process but then the umount ultimately gets stuck tossing
> > > > > > pagecache [1], so the mount still ends up stuck indefinitely. Anyways,
> > > > > > I'll poke at it some more but I figure you might be able to make sense
> > > > > > of this faster than I can.
> > > > > >
> > > > > > Brian
> > > > >
> > > > > Hi Brian,
> > > > >
> > > > > Thanks for your report and the repro instructions. I will look into
> > > > > this and report back what I find.
> > > >
> > > > This is the fix:
> > > >
> > > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > > index 4e6258fdb915..aa46fec8362d 100644
> > > > --- a/fs/iomap/buffered-io.c
> > > > +++ b/fs/iomap/buffered-io.c
> > > > @@ -445,6 +445,9 @@ static void iomap_read_end(struct folio *folio,
> > > > size_t bytes_pending)
> > > >                 bool end_read, uptodate;
> > > >                 size_t bytes_accounted = folio_size(folio) - bytes_pending;
> > > >
> > > > +               if (!bytes_accounted)
> > > > +                       return;
> > > > +
> > > >                 spin_lock_irq(&ifs->state_lock);
> > > >
> > > >
> > > > What I missed was that if all the bytes in the folio are non-uptodate
> > > > and need to read in by the filesystem, then there's a bug where the
> > > > read will be ended on the folio twice (in iomap_read_end() and when
> > > > the filesystem calls iomap_finish_folio_write(), when only the
> > > > filesystem should end the read), which does 2 folio unlocks which ends
> > > > up locking the folio. Looking at the writeback patch that does a
> > > > similar optimization [1], I miss the same thing there.
> > > >
> > >
> > > Makes sense.. though a short comment wouldn't hurt in there. ;) I found
> > > myself a little confused by the accounted vs. pending naming when
> > > reading through that code. If I follow correctly, the intent is to refer
> > > to the additional bytes accounted to read_bytes_pending via the init
> > > (where it just accounts the whole folio up front) and pending refers to
> > > submitted I/O.
> > >
> > > Presumably that extra accounting doubly serves as the typical "don't
> > > complete the op before the submitter is done processing" extra
> > > reference, except in this full submit case of course. If so, that's
> > > subtle enough in my mind that a sentence or two on it wouldn't hurt..
> >
> > I will add some a comment about this :) That's a good point about the
> > naming, maybe "bytes_submitted" and "bytes_unsubmitted" is a lot less
> > confusing than "bytes_pending" and "bytes_accounted".
> 
> Thinking about this some more, bytes_unsubmitted sounds even more
> confusing, so maybe bytes_nonsubmitted or bytes_not_submitted. I'll
> think about this some more but kept it as pending/accounted for now.
> 

bytes_submitted sounds better than pending to me, not sure about
unsubmitted or whatever. As long as there's a sentence or two that
explains what accounted means in the end helper, though, that seems
reasonable enough to me.

Brian

> The fix for this bug is here [1].
> 
> Thanks,
> Joanne
> 
> [1] https://lore.kernel.org/linux-fsdevel/20251024215008.3844068-1-joannelkoong@gmail.com/
> 
> >
> > Thanks,
> > Joanne
> >
> > >
> > > > I'll fix up both. Thanks for catching this and bisecting it down to
> > > > this patch. Sorry for the trouble.
> > > >
> > >
> > > No prob. Thanks for the fix!
> > >
> > > Brian
> > >
> > > > Thanks,
> > > > Joanne
> > > >
> > > > [1] https://lore.kernel.org/linux-fsdevel/20251009225611.3744728-4-joannelkoong@gmail.com/
> > > > >
> > > > > Thanks,
> > > > > Joanne
> > > > > >
> > > >
> > >
> 


