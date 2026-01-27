Return-Path: <linux-fsdevel+bounces-75592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOpDHMadeGm/rQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 12:13:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA07E93715
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 12:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 009B330120D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 11:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DCA345740;
	Tue, 27 Jan 2026 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2JkDwzX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1Z1vfrc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A08F30B509
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769512361; cv=pass; b=oFIzmnuwT/PFm62KnBQammotbwsk5nPgo1gWxbBhLf7VmuCTAc4CCPIehSQ6Ckp3Z0rxcWhipcakBAmF+y5ekOgIHze//bgh8Rlxn0PayEolF7xvNE1K6+A5dr5MTEFXgukbKlbyUD6SiqgiXKFN4XFGoAGDYrwRFJ5Q4hNdiMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769512361; c=relaxed/simple;
	bh=aTx8fEOX4Lf84/BRQapfApE2ezuKhmPL7UuX0PXalsk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAlzGAcNOXrbz5E08lMNkR4fj80OFiTdlkqbkZyR7zwzxi2Tgw17i1NtkVTVyued359ib64mA1t7djYhoG6+YU+x4Ry57CAoKlz+CQGhgZHmo7JzF9jDSOOkEbfdMwt+s6OEHmtx8M902nSm6c6mbynWAjSMG1f8/sHdeKIK24Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2JkDwzX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=T1Z1vfrc; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769512359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kPIJoS6KzjEY68oAeGyS3lrCg14yEsMjEMAfD0ADaTc=;
	b=R2JkDwzXJz2YcHnop+3Lug+kjmkF3Wk0ZfoTQWUEoaKI8/jUW1jmjs8GdlJofBoi5i3jrK
	Eldpj4GuGBwbS2ux+rR9LnoiZ35qjgHb1Qr4Q8yLsRtbTSeRfCRujdfiRShzYthiQDUmM5
	EwasQI0zgxdJB+2Lq/1SgjoXPHbDVPs=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-ciQlP960OtaRIFt_msvILA-1; Tue, 27 Jan 2026 06:12:38 -0500
X-MC-Unique: ciQlP960OtaRIFt_msvILA-1
X-Mimecast-MFC-AGG-ID: ciQlP960OtaRIFt_msvILA_1769512357
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-644548b1d9aso7226993d50.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 03:12:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769512357; cv=none;
        d=google.com; s=arc-20240605;
        b=cpxND+ewsHKlfXMXPhMIm49Mu0SIYMbxjwAz6AL6QBaFWaIMHegL2LR6CnPq6gsDBA
         m3iwSCmOedbSqrxcCD5jBHdP9ivMt+1GM3hxw+kdUWy7UidVU/i2LXykP/DHy/RtUC43
         82Y62rK3Hnt2yhSExkuf0ZL/iGzVbTuM5grlJKWUtUivL74gymaaFS9+pdlQ6ViEKDoJ
         wKiuiVWqWT2h8ixeWxX5DrUcgNmphEmPtsEsfgaLkr6QibtJ4vpGngDx8T27hz3f2g5V
         EDzTFy723IJKvZznrC87pxYVkxXgvu+PUzomrbh12+S6ixS6lpPiDBNkNQvw7puVQhEU
         Gw8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=kPIJoS6KzjEY68oAeGyS3lrCg14yEsMjEMAfD0ADaTc=;
        fh=0ciYY1wtHrTxVrbyv+3z1IEndRg70bmbJbZ6sWXi8wA=;
        b=gG8daCIQUPe55aPqWqTWm9YymowiH4MSq3bTujnxxQXkTZ6qPECIe1S7bpNRvCL9wo
         3z/rK7uVNuudgMdBl7yVzC0fldDysw7ivEN4K4GobBLgyRUolxSjFs1PgCtVOfriluGk
         qkhE3kvtbfIoh/C2sPPM1OkTQZkUeXfKyT0p5SNeuKQtfoZG/0HKPmbeT3iwNV21ofuB
         pR8TvimBT50z6Ab5Cj5F30nKMszWt9dNeclJoVkoNO23ozLKV5xnsrAfLEU21rgD4h1B
         vLrA6QYzeglML7Omu2C8RvLqWQloevSyM0mjTZniQH+Ws6st12JmN3cVXxFK/z2hq42z
         6J7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769512357; x=1770117157; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kPIJoS6KzjEY68oAeGyS3lrCg14yEsMjEMAfD0ADaTc=;
        b=T1Z1vfrcqVA/xrkwN7UY3g6aAuCbF/zQNLiyl++GvbU6oQa+AqeMIUj3FXCueuL5SK
         3OQJW43vOPPVJO7UtSt4jlzkgv3HqNX2HXtDbjJLmbcp7HvoT80Bmswx3jgiutqKY0SZ
         qklkMsMEWfjBG9dqDXczAZt3Ky/vwpy+N9+eAgR42jD9BeRpyPmG4c6Y68Iv8e3sg/7B
         zQehFKynTDrTKbqOVNTgLg+in3a1WYCQyvADkESElYcaou04vknVLc8S89QyvNW4KEtN
         tK29dMyExqEYWyAj2jBzdBUNEsKtsRHPOi9NUaIH+SKiMxQWkWw0LuJQD+p53iQ0+FJV
         gpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769512357; x=1770117157;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPIJoS6KzjEY68oAeGyS3lrCg14yEsMjEMAfD0ADaTc=;
        b=Bg7v3JdAkw9UTjkEh1w+QoXvH3E8eaSmTTL+F7s13bw4QvX0rpvFhM9vfqNGQBJkDf
         qVK2WJQVkuW9xnZr8Ri0dplNrAu2IORNzAmBKJHGfrGV0xlWjfrUsGp+VRkILonWaGN6
         /bMouTo9YxpUDRmeFXdTRuDIc1i72pylIaII0x1JAnruCMtCzrpYCybAxCP7CuJjLzjp
         CzBs6LNQulGSOXnIcfuICU2e+1PGoctpyv2/7lK9MJG+qY7Mv/RK5szRlajrWuggymw3
         uef4Uy/2TpDj89IrfN3on7KVyYabFK2YDNRu/9RYgKOVsDpRCYqFy2/8Ytp1WwDvUe9A
         DEJg==
X-Forwarded-Encrypted: i=1; AJvYcCUMJ/YrXail/i6Nb/aBmX85TABXukXAsplLotwiBFS0ddd9iI0kg6Tr83hdD6SgzFliHJPE1H3Aejr/6Lyw@vger.kernel.org
X-Gm-Message-State: AOJu0YwfxBK/B5VD/eikH8ft3HIJJOYu49W4oUIpqfrLR2ykH4r3rOkG
	sWsuGk1vsDIkPg77Vdvuy+VNnXFCbvWjGyIv79Qh5gbQSXOiEt0HpleyNaw8h4uw7hrqfe0rZyA
	fKAYnVSejdi+/nU8pnLX2I8pwYHrl72wjXF7c4XC/IbWpdl+x2ut2Am2nPJfV7rclh+pObgYN2R
	Wp4vgBS/oA+z3XnM9OnbLWNm8kMJC8nrXCJrFI3TYbofK1AWOEog==
X-Gm-Gg: AZuq6aIvjv/EjZS7Uti44QAzOozeeDqoZT0+IA5vSY73phvOgYUFwe24FND1ZfQoIBt
	hbJuM6Eyr4/n44BUzebkEiknxrANq4qxh5zBZtr2exLH9oMjUF31Nj96fq1j19jhYSY6BcXwjts
	FoTIrjNJaRs6qyaNdQQwU7gK3YuDmouIvrrDfexOBIH7ANuk93W/Vajiq0IvxWcsej
X-Received: by 2002:a05:690c:6610:b0:786:5926:ed9e with SMTP id 00721157ae682-7947ab3d550mr22336697b3.25.1769512356544;
        Tue, 27 Jan 2026 03:12:36 -0800 (PST)
X-Received: by 2002:a05:690c:6610:b0:786:5926:ed9e with SMTP id
 00721157ae682-7947ab3d550mr22336287b3.25.1769512356161; Tue, 27 Jan 2026
 03:12:36 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Jan 2026 05:12:35 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Jan 2026 05:12:35 -0600
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <20260126184015.GC5900@frogsfrogsfrogs>
References: <20260118232411.536710-1-slp@redhat.com> <20260126184015.GC5900@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 27 Jan 2026 05:12:35 -0600
X-Gm-Features: AZwV_QhaXJ-oSKaaDmnRhvCqTwIUbzQHTDTbCd36LtqJ6jUl-Z9zBQp5ygeRr14
Message-ID: <CAAiTLFU3Shv-YvizuvFj-4i0LArDmcO=KYxLwUrCT7GJLbZw1A@mail.gmail.com>
Subject: Re: [PATCH] fuse: mark DAX inode releases as blocking
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-75592-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slp@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EA07E93715
X-Rspamd-Action: no action

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Mon, Jan 19, 2026 at 12:24:11AM +0100, Sergio Lopez wrote:
>> Commit 26e5c67deb2e ("fuse: fix livelock in synchronous file put from
>> fuseblk workers") made fputs on closing files always asynchronous.
>>
>> As cleaning up DAX inodes may require issuing a number of synchronous
>> request for releasing the mappings, completing the release request from
>> the worker thread may lead to it hanging like this:
>>
>> [   21.386751] Workqueue: events virtio_fs_requests_done_work
>> [   21.386769] Call trace:
>> [   21.386770]  __switch_to+0xe4/0x140
>> [   21.386780]  __schedule+0x294/0x72c
>> [   21.386787]  schedule+0x24/0x90
>> [   21.386794]  request_wait_answer+0x184/0x298
>> [   21.386799]  __fuse_simple_request+0x1f4/0x320
>> [   21.386805]  fuse_send_removemapping+0x80/0xa0
>> [   21.386810]  dmap_removemapping_list+0xac/0xfc
>> [   21.386814]  inode_reclaim_dmap_range.constprop.0+0xd0/0x204
>> [   21.386820]  fuse_dax_inode_cleanup+0x28/0x5c
>> [   21.386825]  fuse_evict_inode+0x120/0x190
>> [   21.386834]  evict+0x188/0x320
>> [   21.386847]  iput_final+0xb0/0x20c
>> [   21.386854]  iput+0xa0/0xbc
>> [   21.386862]  fuse_release_end+0x18/0x2c
>> [   21.386868]  fuse_request_end+0x9c/0x2c0
>
> Ok, so this is the reply from the async FUSE_RELEASE command.  But then
> we iput the inode, which results in fuse issuing a new synchronous
> command from within the completion for the first command.
>
> Ouch.
>
>> [   21.386872]  virtio_fs_request_complete+0x150/0x384
>> [   21.386879]  virtio_fs_requests_done_work+0x18c/0x37c
>> [   21.386885]  process_one_work+0x15c/0x2e8
>> [   21.386891]  worker_thread+0x278/0x480
>> [   21.386898]  kthread+0xd0/0xdc
>> [   21.386902]  ret_from_fork+0x10/0x20
>>
>> Here, the virtio-fs worker_thread is waiting on request_wait_answer()
>> for a reply from the virtio-fs server that is already in the virtqueue
>> but will never be processed since it's that same worker thread the one
>> in charge of consuming the elements from the virtqueue.
>
> Yes.  Ow.
>
>> To address this issue, when relesing a DAX inode mark the operation as
>> potentially blocking. Doing this will ensure these release requests are
>> processed on a different worker thread.
>
> I wonder if you've solved this problem report?
> https://github.com/Nevuly/WSL2-Rolling-Kernel-Issue/issues/38
>
> Naturally they reverted the patch, emailed me, and refused to talk about
> this on the public list, which is why nobody's heard of this until now.

If they're using DAX, that's very likely. I've discovered it while
testing a new kernel with libkrun/muvm, which does use multiple
virtio-fs devices, one of them as root and another one with DAX, which
turns to be a pretty good testbed for virtio-fs (nothing better than
running Steam, and bunch of games under FEX+Proton for stress-testing
multiple subsystems with a real-world workload ;-).

>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>>  fs/fuse/file.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index 3b2a171e652f..a65c5d32a34b 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -117,6 +117,12 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
>>  			fuse_simple_request(ff->fm, args);
>>  			fuse_release_end(ff->fm, args, 0);
>>  		} else {
>> +			/*
>> +			 * DAX inodes may need to issue a number of synchronous
>> +			 * request for clearing the mappings.
>> +			 */
>> +			if (ra && ra->inode && FUSE_IS_DAX(ra->inode))
>> +				args->may_block = true;
>
> There's no documentation for what may_block does, but there are so few
> uses of it that I can tell that this is kicking the FUSE_RELEASE
> completion to a workqueue instead of processing it directly, which
> eliminates the livelock.
>
> I wonder if fuse ought to grow the ability to whine when something is
> trying to issue a synchronous fuse command while running in a command
> queue completion context (aka the worker threads) but I don't know how
> difficult that would *really* be.

Perhaps we could check for PF_WQ_WORKER and, at the very least, emit a
warning.

Thanks,
Sergio.


