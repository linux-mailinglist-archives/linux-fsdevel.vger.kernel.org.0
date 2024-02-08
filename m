Return-Path: <linux-fsdevel+bounces-10733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDD184D946
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 04:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C806A2845D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 03:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9892E85A;
	Thu,  8 Feb 2024 03:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VT9LjBoR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E992D044;
	Thu,  8 Feb 2024 03:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364530; cv=none; b=LrDPa9o8rSQLxf/AZ8xoWbIhVyN02OPl5ButmBMWi4dPWjl2oMNE10XcU+kuVkGgvNZzT8blwrDqigqTFXggWGx9unXcUyGhWohs6R8Bje0jLdSwtpz41VjS+97tIkiC2NYz9NYk9Ulrq0CKZTOYmjdMLvCgbOULplYaqUXkGQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364530; c=relaxed/simple;
	bh=O0Onsj1Nvy7tmPso6s/pGpLSoDca5eyq1mY93iRcjhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgU8UJWmsy+u07wuBNJFk2QiSC8O33hUPJ+9F3VNMSeACvRgwtT6JtdoPfw757dgkvjSQVhWyhRWh7oRZEXShB0AIVPwDoVGgSUTn9OEe8nliEEctcID6XcvgHoFg5RDF/UokIHrpNhMzpDskxp16jtut9b5sjJ0UwQb/xrASzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VT9LjBoR; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5114b2b3b73so1732716e87.0;
        Wed, 07 Feb 2024 19:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707364526; x=1707969326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXErrAfTv+p6kb7R4C6uEJnvctDLGBoxQSLw/PRqP0g=;
        b=VT9LjBoRzmJFNexObHjqPIDroWd4Cs+u+bZ7Qx1fpL3IIeHIST/UbBhATI1N1XWoxQ
         6Og/FrLV5YZ81Z8avbPomWnde7C/d+H+0+Y2J1T/CY++g/srQ8c3LjCyBlIJjXGYQ2mO
         286fDB097Rp1Sw/QMfJiEA0v4b4lK6aCm23Z0n0lyq2LjpFmr4I7ZDDYrToHrrMgK1Am
         ClMYrTvFiDUwFgyKedZiXHKCzU2OngWaBZ3Tb+J+kfNvGVp4yXDdYTDDp0lDdwC7ZPRO
         ILvOH09EkWi/yg8yw3ZKtFY8vTzVcnvhGhsyfIFMtcWx2dKadSMAzFrLdtFt4NQO9UAH
         VDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707364526; x=1707969326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXErrAfTv+p6kb7R4C6uEJnvctDLGBoxQSLw/PRqP0g=;
        b=Zgsvh80r8AYhmBcRUpOqYwcH7AoLzhRVy1oK446oO/elwT8MRiX1nQMO54I7+y5wF3
         JdorEZMPGSCYxPzsreIqPnAomyypgab7Ar08NPvT2/4vyxwr4IOyv/kn8R65X4p3vLG3
         Ia7TNZttkM+9iqoDZ4MBilM58RGKoZ+3s4+fUUtggOJL33sr4OC4JDH+tqWGWsXzuv8D
         V5iGby95EQlwver6BC5DGaEwQmh2gU4py586ha0ZlvLDRX1Fvv75OL1LQfk+h392hsPC
         Sbuip+c9+BVvq00BVxOTSZ4l4CTR836os2NGRDzr5/4RXgE6459NJDv+HtrbDF6s0ZXN
         vGRw==
X-Gm-Message-State: AOJu0YzB+5PwbPqEeVVHVOXawTwytQk8HAcTbq2UlEtBMgrBWyamFa/x
	twLjqyfflaLrMAS1WmeyxqwfzxhBHmcLZrFX3CROUuPnnq6dkMi/ddAid4o5rd4I/5UdEmRoYwm
	OzlZ1KkR3EY5Jl7g3luOB2E9q2PE=
X-Google-Smtp-Source: AGHT+IHMpehn1qdvHBgKMn5tBamIL609b3PihsXeEEtCvsSXBv5c/L/yQRTDOTGp0meJ/ZLFf/6GsJcmNL4o1rl28qg=
X-Received: by 2002:a05:6512:313c:b0:511:4465:3e21 with SMTP id
 p28-20020a056512313c00b0051144653e21mr6557636lfd.25.1707364525877; Wed, 07
 Feb 2024 19:55:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205225726.3104808-1-dhowells@redhat.com>
In-Reply-To: <20240205225726.3104808-1-dhowells@redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Wed, 7 Feb 2024 21:55:13 -0600
Message-ID: <CAH2r5mu0Dw7jVHFaz4cYCNjWj9RFa76pRTyQOEenDACHDgNfyg@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] netfs, cifs: Delegate high-level I/O to netfslib
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Paulo Alcantara <pc@manguebit.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Christian Brauner <christian@brauner.io>, netfs@lists.linux.dev, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This looks promising but I do hit an oops fairly early in xfstest runs
with the 12 patches in your series (on 6.8-rc3)

[  228.136056] run fstests generic/306 at 2024-02-07 21:32:16

[  228.573734] ------------[ cut here ]------------
[  228.573737] kernel BUG at lib/iov_iter.c:582!
[  228.573744] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[  228.573748] CPU: 2 PID: 4033 Comm: cifsd Tainted: G            E
  6.8.0-rc3+ #2
[  228.573751] Hardware name: Microsoft Corporation Virtual
Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 11/28/2023
[  228.573752] RIP: 0010:iov_iter_revert+0x114/0x120
[  228.573758] Code: 48 89 78 08 31 c0 31 d2 31 c9 31 f6 31 ff 45 31
c0 c3 cc cc cc cc 0f 0b 31 c0 31 d2 31 c9 31 f6 31 ff 45 31 c0 c3 cc
cc cc cc <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
90 90
[  228.573760] RSP: 0018:ffffb8d005c27d68 EFLAGS: 00010246
[  228.573763] RAX: ffffb8d005c27d98 RBX: ffff99934d039b00 RCX: 00000000000=
00000
[  228.573764] RDX: 0000000000000000 RSI: 0000000000000200 RDI: 00000000000=
00004
[  228.573766] RBP: ffffb8d005c27e00 R08: 0000000000000000 R09: 00000000000=
00000
[  228.573767] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9993427=
36900
[  228.573769] R13: ffff9993a7fd4800 R14: ffff9993a7fd2000 R15: 00000000000=
00001
[  228.573770] FS:  0000000000000000(0000) GS:ffff9994f2b00000(0000)
knlGS:0000000000000000
[  228.573772] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  228.573774] CR2: 00007fe530dffe38 CR3: 0000000103fc8001 CR4: 00000000003=
706f0
[  228.573777] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  228.573778] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  228.573779] Call Trace:
[  228.573781]  <TASK>
[  228.573783]  ? show_regs+0x6d/0x80
[  228.573787]  ? die+0x37/0xa0
[  228.573789]  ? do_trap+0xd4/0xf0
[  228.573793]  ? do_error_trap+0x71/0xb0
[  228.573795]  ? iov_iter_revert+0x114/0x120
[  228.573798]  ? exc_invalid_op+0x52/0x80
[  228.573801]  ? iov_iter_revert+0x114/0x120
[  228.573803]  ? asm_exc_invalid_op+0x1b/0x20
[  228.573808]  ? iov_iter_revert+0x114/0x120
[  228.573813]  ? smb2_readv_callback+0x50f/0x5b0 [cifs]
[  228.573874]  cifs_demultiplex_thread+0x46e/0xe40 [cifs]
[  228.573920]  ? __pfx_cifs_demultiplex_thread+0x10/0x10 [cifs]
[  228.573962]  kthread+0xef/0x120
[  228.573966]  ? __pfx_kthread+0x10/0x10
[  228.573969]  ret_from_fork+0x44/0x70
[  228.573972]  ? __pfx_kthread+0x10/0x10
[  228.573975]  ret_from_fork_asm+0x1b/0x30
[  228.573979]  </TASK>
[  228.573980] Modules linked in: cmac(E) nls_utf8(E) cifs(E)
cifs_arc4(E) nls_ucs2_utils(E) cifs_md4(E) netfs(E) snd_seq_dummy(E)
snd_hrtimer(E) snd_seq_midi(E) snd_seq_midi_event(E) snd_rawmidi(E)
snd_seq(E) snd_seq_device(E) snd_timer(E) snd(E) soundcore(E)
sunrpc(E) binfmt_misc(E) intel_rapl_msr(E) intel_rapl_common(E)
intel_uncore_frequency_common(E) intel_pmc_core(E) intel_vsec(E)
pmt_telemetry(E) pmt_class(E) crct10dif_pclmul(E) polyval_clmulni(E)
polyval_generic(E) ghash_clmulni_intel(E) sha512_ssse3(E)
sha256_ssse3(E) sha1_ssse3(E) aesni_intel(E) crypto_simd(E) cryptd(E)
rapl(E) hyperv_drm(E) drm_shmem_helper(E) drm_kms_helper(E)
hv_balloon(E) hyperv_fb(E) vmgenid(E) joydev(E) mac_hid(E)
serio_raw(E) msr(E) parport_pc(E) ppdev(E) lp(E) drm(E) parport(E)
efi_pstore(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E)
btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E)
hid_generic(E) hid_hyperv(E) hv_storvsc(E) hv_netvsc(E) hid(E)
hyperv_keyboard(E) scsi_transport_fc(E) hv_utils(E) crc32_pclmul(E)
[  228.574031]  hv_vmbus(E)
[  228.574035] ---[ end trace 0000000000000000 ]---
[  228.636462] RIP: 0010:iov_iter_revert+0x114/0x120
[  228.636471] Code: 48 89 78 08 31 c0 31 d2 31 c9 31 f6 31 ff 45 31
c0 c3 cc cc cc cc 0f 0b 31 c0 31 d2 31 c9 31 f6 31 ff 45 31 c0 c3 cc
cc cc cc <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
90 90
[  228.636474] RSP: 0018:ffffb8d005c27d68 EFLAGS: 00010246
[  228.636477] RAX: ffffb8d005c27d98 RBX: ffff99934d039b00 RCX: 00000000000=
00000
[  228.636479] RDX: 0000000000000000 RSI: 0000000000000200 RDI: 00000000000=
00004
[  228.636481] RBP: ffffb8d005c27e00 R08: 0000000000000000 R09: 00000000000=
00000
[  228.636482] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9993427=
36900
[  228.636484] R13: ffff9993a7fd4800 R14: ffff9993a7fd2000 R15: 00000000000=
00001
[  228.636485] FS:  0000000000000000(0000) GS:ffff9994f2b00000(0000)
knlGS:0000000000000000
[  228.636487] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  228.636489] CR2: 00007fe530dffe38 CR3: 0000000103fc8001 CR4: 00000000003=
706f0
[  228.636492] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  228.636494] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400


On Mon, Feb 5, 2024 at 4:57=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
>
> Hi Steve,
>
> Here are patches to convert cifs to use the netfslib library.  With this =
I
> can run a certain amount of xfstests on CIFS, though not all the tests wo=
rk
> correctly because of fallocate issues.
>
> The patches remove around 2000 lines from CIFS
>
> To do:
>
>  (*) Implement write-retry.  Currently, netfslib errors out on a failed D=
IO
>      write and relies on the VM to drive writepages again on a failed
>      buffered write.  This needs some retry logic adding into
>      fs/netfs/output.c.
>
>      I'm not sure what the best way to handle this is.  One way is to
>      resend each failing subreq as it fails, offloading this to a kernel
>      thread that re-splits the subreq, calling out to a rreq->op to do th=
e
>      splitting, thereby allowing cifs to renegotiate credits.  If a subre=
q
>      is split, the two parts need to be adjacent in the rreq->subrequests
>      list.
>
>      An alternative way might be to try and combine failing tests and the=
n
>      split them.
>
>      Yet a third way might be to try each failing subreq a smaller bit at=
 a
>      time and keep track of what has been sent in
>      wdata->subreq.transferred.
>
>      Whichever way is chosen, NETFS_SREQ_RETRYING should be set in
>      wdata->subreq.flags instead of setting wdata->replay.
>
> Notes:
>
>  (1) CIFS is made to use unbuffered I/O for unbuffered caching modes and
>      write-through caching for cache=3Dstrict.
>
>  (2) Various cifs fallocate() function implementations have issues that
>      aren't easily fixed without enhanced protocol support.
>
>  (3) It should be possible to turn on multipage folio support in CIFS now=
.
>
>  (4) The then-unused CIFS code is removed in three patches, not one, to
>      avoid the git patch generator from producing confusing patches in
>      which it thinks code is being moved around rather than just being
>      removed.
>
> The patches can be found here also:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git/log/?h=3Dcifs-netfs
>
> Changes
> =3D=3D=3D=3D=3D=3D=3D
> ver #5)
>  - Rebased to -rc3 plus SteveF's for-next branch as netfslib is now
>    upstream, as are a couple of patches from this series.
>  - Replace the ->replay bool Shyam added with a flag on the netfs
>    subrequest.  This is tested by the code, but not currently set (see
>    above).
>
> ver #4)
>  - Slimmed down the branch:
>    - Split the cifs-related patches off to a separate branch (cifs-netfs)
>    - Deferred the content-encryption to the in-progress ceph changes.
>    - Deferred the use-PG_writeback rather than PG_fscache patch
>  - Rebased on a later linux-next with afs-rotation patches.
>
> ver #3)
>  - Moved the fscache module into netfslib to avoid export cycles.
>  - Fixed a bunch of bugs.
>  - Got CIFS to pass as much of xfstests as possible.
>  - Added a patch to make 9P use all the helpers.
>  - Added a patch to stop using PG_fscache, but rather dirty pages on
>    reading and have writepages write to the cache.
>
> ver #2)
>  - Folded the addition of NETFS_RREQ_NONBLOCK/BLOCKED into first patch th=
at
>    uses them.
>  - Folded addition of rsize member into first user.
>  - Don't set rsize in ceph (yet) and set it in kafs to 256KiB.  cifs sets
>    it dynamically.
>  - Moved direct_bv next to direct_bv_count in struct netfs_io_request and
>    labelled it with a __counted_by().
>  - Passed flags into netfs_xa_store_and_mark() rather than two bools.
>  - Removed netfs_set_up_buffer() as it wasn't used.
>
> David
>
> Link: https://lore.kernel.org/r/20231213152350.431591-1-dhowells@redhat.c=
om/ [1]
> Link: https://lore.kernel.org/r/20231013160423.2218093-1-dhowells@redhat.=
com/ # v1
> Link: https://lore.kernel.org/r/20231117211544.1740466-1-dhowells@redhat.=
com/ # v2
> Link: https://lore.kernel.org/r/20231207212206.1379128-1-dhowells@redhat.=
com/ # v3
> Link: https://lore.kernel.org/r/20231213154139.432922-1-dhowells@redhat.c=
om/ # v4
>
> David Howells (12):
>   cifs: Replace cifs_readdata with a wrapper around netfs_io_subrequest
>   cifs: Set zero_point in the copy_file_range() and remap_file_range()
>   cifs: Replace cifs_writedata with a wrapper around netfs_io_subrequest
>   cifs: Use more fields from netfs_io_subrequest
>   cifs: Make wait_mtu_credits take size_t args
>   cifs: Implement netfslib hooks
>   cifs: Replace the writedata replay bool with a netfs sreq flag
>   cifs: Move cifs_loose_read_iter() and cifs_file_write_iter() to file.c
>   cifs: Cut over to using netfslib
>   cifs: Remove some code that's no longer used, part 1
>   cifs: Remove some code that's no longer used, part 2
>   cifs: Remove some code that's no longer used, part 3
>
>  fs/netfs/buffered_write.c    |    3 +
>  fs/netfs/io.c                |    7 +-
>  fs/smb/client/Kconfig        |    1 +
>  fs/smb/client/cifsfs.c       |   69 +-
>  fs/smb/client/cifsfs.h       |   10 +-
>  fs/smb/client/cifsglob.h     |   59 +-
>  fs/smb/client/cifsproto.h    |   14 +-
>  fs/smb/client/cifssmb.c      |  111 +-
>  fs/smb/client/file.c         | 2911 ++++++----------------------------
>  fs/smb/client/fscache.c      |  109 --
>  fs/smb/client/fscache.h      |   54 -
>  fs/smb/client/inode.c        |   19 +-
>  fs/smb/client/smb2ops.c      |   10 +-
>  fs/smb/client/smb2pdu.c      |  169 +-
>  fs/smb/client/smb2proto.h    |    5 +-
>  fs/smb/client/trace.h        |  144 +-
>  fs/smb/client/transport.c    |   17 +-
>  include/linux/netfs.h        |    2 +
>  include/trace/events/netfs.h |    1 +
>  19 files changed, 852 insertions(+), 2863 deletions(-)
>
>


--
Thanks,

Steve

