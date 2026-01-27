Return-Path: <linux-fsdevel+bounces-75666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIz/EJhKeWmXwQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 00:30:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC219B672
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 00:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E72CD300DE25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 23:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56341245031;
	Tue, 27 Jan 2026 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KE8A0BsW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACB718FC86
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 23:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769556627; cv=none; b=koFm9LlzgmT6M0LReFYPTjcVLaAPhEvjd92KB7P69mXXk057Iwx9RpSyePVIs02dbfgyABDnixJ38ebnCgk0KJt3DmB1pG93/MD1B/yzDr8BHa1P6fSstVRMAKLMwbVuP+fxR5pfWo27U5pNMjKMjwZTwA4I0wQ8rCF3BV3uMEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769556627; c=relaxed/simple;
	bh=YRqEwMEdkLaxC9S1OI825gIwjnYSKlKGr4MlbB7GmNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zrcvy6sfbggBwFunktJmbta7DPR1ztMniTn0veQ3Ig2VF133KIjO+4rJvsuLrZ++OeBVC9zc0DloHpZEB7JGOWMJIjm//V3OUcyI+b9uZAW8lhbMi9XecLVOSUZ8Mm63RwHlp83aVnflWnyJWAu4VQu212ZUqrS1F3BQ4ruxY34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KE8A0BsW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1E3C116C6;
	Tue, 27 Jan 2026 23:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769556627;
	bh=YRqEwMEdkLaxC9S1OI825gIwjnYSKlKGr4MlbB7GmNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KE8A0BsWbtKMoaCLN3X/RVEDUMT1ik8EZjNbquk+AerdDEvR3mG2zwAU1BUu5I0+Z
	 jdhjIONXyKMCUBeHi+917I0/kIneXLQDdlQDl35+SV3/4fD+v/oNj94C+lEfSaDjRz
	 EDD5ILJnJ1QoiG5Ckh6iWYssUiSJUViFrgucPJLPdUV5QLwOUpdly9DJhY5+p1Gf79
	 Z9ffaiT2B8sQR22fUIOycLwwUVpAhpfp0GF29fxys3uOYmGZHcCCbV7/V959wjaaoP
	 nmIKbuxJWxnSlX9utpA2L48gK9aywS6L776vLVnwI472cg9s6t/9x1gVyOZPZckX74
	 tUQmrKJiTYPsA==
Date: Tue, 27 Jan 2026 15:30:27 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Sergio Lopez Pascual <slp@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fuse: mark DAX inode releases as blocking
Message-ID: <20260127233027.GB5966@frogsfrogsfrogs>
References: <20260118232411.536710-1-slp@redhat.com>
 <20260126184015.GC5900@frogsfrogsfrogs>
 <CAAiTLFU3Shv-YvizuvFj-4i0LArDmcO=KYxLwUrCT7GJLbZw1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAiTLFU3Shv-YvizuvFj-4i0LArDmcO=KYxLwUrCT7GJLbZw1A@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75666-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AC219B672
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 05:12:35AM -0600, Sergio Lopez Pascual wrote:
> "Darrick J. Wong" <djwong@kernel.org> writes:
> 
> > On Mon, Jan 19, 2026 at 12:24:11AM +0100, Sergio Lopez wrote:
> >> Commit 26e5c67deb2e ("fuse: fix livelock in synchronous file put from
> >> fuseblk workers") made fputs on closing files always asynchronous.
> >>
> >> As cleaning up DAX inodes may require issuing a number of synchronous
> >> request for releasing the mappings, completing the release request from
> >> the worker thread may lead to it hanging like this:
> >>
> >> [   21.386751] Workqueue: events virtio_fs_requests_done_work
> >> [   21.386769] Call trace:
> >> [   21.386770]  __switch_to+0xe4/0x140
> >> [   21.386780]  __schedule+0x294/0x72c
> >> [   21.386787]  schedule+0x24/0x90
> >> [   21.386794]  request_wait_answer+0x184/0x298
> >> [   21.386799]  __fuse_simple_request+0x1f4/0x320
> >> [   21.386805]  fuse_send_removemapping+0x80/0xa0
> >> [   21.386810]  dmap_removemapping_list+0xac/0xfc
> >> [   21.386814]  inode_reclaim_dmap_range.constprop.0+0xd0/0x204
> >> [   21.386820]  fuse_dax_inode_cleanup+0x28/0x5c
> >> [   21.386825]  fuse_evict_inode+0x120/0x190
> >> [   21.386834]  evict+0x188/0x320
> >> [   21.386847]  iput_final+0xb0/0x20c
> >> [   21.386854]  iput+0xa0/0xbc
> >> [   21.386862]  fuse_release_end+0x18/0x2c
> >> [   21.386868]  fuse_request_end+0x9c/0x2c0
> >
> > Ok, so this is the reply from the async FUSE_RELEASE command.  But then
> > we iput the inode, which results in fuse issuing a new synchronous
> > command from within the completion for the first command.
> >
> > Ouch.
> >
> >> [   21.386872]  virtio_fs_request_complete+0x150/0x384
> >> [   21.386879]  virtio_fs_requests_done_work+0x18c/0x37c
> >> [   21.386885]  process_one_work+0x15c/0x2e8
> >> [   21.386891]  worker_thread+0x278/0x480
> >> [   21.386898]  kthread+0xd0/0xdc
> >> [   21.386902]  ret_from_fork+0x10/0x20
> >>
> >> Here, the virtio-fs worker_thread is waiting on request_wait_answer()
> >> for a reply from the virtio-fs server that is already in the virtqueue
> >> but will never be processed since it's that same worker thread the one
> >> in charge of consuming the elements from the virtqueue.
> >
> > Yes.  Ow.
> >
> >> To address this issue, when relesing a DAX inode mark the operation as
> >> potentially blocking. Doing this will ensure these release requests are
> >> processed on a different worker thread.
> >
> > I wonder if you've solved this problem report?
> > https://github.com/Nevuly/WSL2-Rolling-Kernel-Issue/issues/38
> >
> > Naturally they reverted the patch, emailed me, and refused to talk about
> > this on the public list, which is why nobody's heard of this until now.
> 
> If they're using DAX, that's very likely. I've discovered it while
> testing a new kernel with libkrun/muvm, which does use multiple
> virtio-fs devices, one of them as root and another one with DAX, which
> turns to be a pretty good testbed for virtio-fs (nothing better than
> running Steam, and bunch of games under FEX+Proton for stress-testing
> multiple subsystems with a real-world workload ;-).

Hehe. :)

> >> Signed-off-by: Sergio Lopez <slp@redhat.com>
> >> ---
> >>  fs/fuse/file.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> >> index 3b2a171e652f..a65c5d32a34b 100644
> >> --- a/fs/fuse/file.c
> >> +++ b/fs/fuse/file.c
> >> @@ -117,6 +117,12 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
> >>  			fuse_simple_request(ff->fm, args);
> >>  			fuse_release_end(ff->fm, args, 0);
> >>  		} else {
> >> +			/*
> >> +			 * DAX inodes may need to issue a number of synchronous
> >> +			 * request for clearing the mappings.
> >> +			 */
> >> +			if (ra && ra->inode && FUSE_IS_DAX(ra->inode))
> >> +				args->may_block = true;
> >
> > There's no documentation for what may_block does, but there are so few
> > uses of it that I can tell that this is kicking the FUSE_RELEASE
> > completion to a workqueue instead of processing it directly, which
> > eliminates the livelock.
> >
> > I wonder if fuse ought to grow the ability to whine when something is
> > trying to issue a synchronous fuse command while running in a command
> > queue completion context (aka the worker threads) but I don't know how
> > difficult that would *really* be.
> 
> Perhaps we could check for PF_WQ_WORKER and, at the very least, emit a
> warning.

I don't think that will work:

PF_WQ_WORKER only tells us if the current process is a kernel workqueue.
Replies to fuse command are written to the fuse device, which means that
we're running in the process context of the fuse server when we get to
fuse_dev_do_write -> fuse_request_end -> req->args->end ->
fuse_release_end.

--D

> Thanks,
> Sergio.
> 

