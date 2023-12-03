Return-Path: <linux-fsdevel+bounces-4704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5670B8023BB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Dec 2023 13:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7A61C20473
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Dec 2023 12:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE27ADDAA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Dec 2023 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQqcn3p2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80918DA
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Dec 2023 03:20:48 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-67a894ccb4eso22362936d6.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Dec 2023 03:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701602447; x=1702207247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HxAM/GM3BlLVWE+Pz+YjvVNyd0GQBykdwC0XiGM4bM=;
        b=iQqcn3p2dqqELvteQVhodX1eeyw4aZNbPQV9KKp45R00zRH+RLq1Jpe0joqlgn34CI
         J3/rz6VwRFooZ69fut1I7mJm5jGAPu8eF/e9XaFS+bKjuMyDMX+Gn6cJWzrpe1Jhmjwg
         8x8aDMG+1ntYntnlkrmfyroo51SxMNjwkYfnu09d3U3kdNyo9aPPLBD5wNXYlInrF9o0
         Uj2yD8VSYZWiixTQxpnemf5UKcrooxP7BQH3UIVZCGrXNmlSQ3X0w0NMKKOIuxbWyzNM
         uU6l+RmcXR2rmajZqDjpM3b8SoKCG44d7g6rzDo73jdwWtcq/Sp/bTCXB0E/bxPKiLGp
         ntww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701602447; x=1702207247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HxAM/GM3BlLVWE+Pz+YjvVNyd0GQBykdwC0XiGM4bM=;
        b=dTSGFfplzdoOViJkUjX0GuC9vhJRZ8SFJgA+bulrBl9fmytEM3VmX+e0F+BqZSDa4t
         VZ0RrTq8Hqm6jmnCgoevbz4O9hNFMBOzIUGOIifcqYhUkDe3RM0rI32aEdAiGmFiWbFj
         F+u5niea8K0jyUbBE/yi4VRCuwpbEoaAnhygADKWKPnDiF44PwXKShb8TT3hV7LA48GZ
         e5HyxMi/NkMwEG+nEzMu95VonwqDU3V8vo3KH9VMdeTc6022b3993IGiBXoNo4SLO75M
         k+/K/x9x4pIk/xrneXQBnPV7I4NUhoZMG3T3YA7eJibeGMtrRcfrHiXkylKKOAJc/RBb
         Nd9g==
X-Gm-Message-State: AOJu0YzoN9IKy4lDVjiG2GxPH1H0VAdxsuIcS4XL5U6A+VYYKpCKWcW4
	/D7Bk8EccnnYi2KoXCsJAerDGSbOrLHhGHWFVjo=
X-Google-Smtp-Source: AGHT+IEneY8q9nnRtUJddDMEVXIjg0NwqEfluylILbRA7h8y1eLknBSLKj7tZPq6Iu0sl85OjSQgE6OsiVhj4/Q4tDw=
X-Received: by 2002:a0c:fd62:0:b0:67a:45cd:9ea0 with SMTP id
 k2-20020a0cfd62000000b0067a45cd9ea0mr3019765qvs.43.1701602447516; Sun, 03 Dec
 2023 03:20:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920024001.493477-1-tfanelli@redhat.com> <CAJfpegtVbmFnjN_eg9U=C1GBB0U5TAAqag3wY_mi7v8rDSGzgg@mail.gmail.com>
 <32469b14-8c7a-4763-95d6-85fd93d0e1b5@fastmail.fm> <CAOQ4uxgW58Umf_ENqpsGrndUB=+8tuUsjT+uCUp16YRSuvG2wQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgW58Umf_ENqpsGrndUB=+8tuUsjT+uCUp16YRSuvG2wQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 3 Dec 2023 13:20:36 +0200
Message-ID: <CAOQ4uxh6RpoyZ051fQLKNHnXfypoGsPO9szU0cR6Va+NR_JELw@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
To: Bernd Schubert <bernd.schubert@fastmail.fm>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Tyler Fanelli <tfanelli@redhat.com>, linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, 
	gmaglione@redhat.com, hreitz@redhat.com, Hao Xu <howeyxu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 2, 2023 at 5:06=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Mon, Nov 6, 2023 at 4:08=E2=80=AFPM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
> >
> > Hi Miklos,
> >
> > On 9/20/23 10:15, Miklos Szeredi wrote:
> > > On Wed, 20 Sept 2023 at 04:41, Tyler Fanelli <tfanelli@redhat.com> wr=
ote:
> > >>
> > >> At the moment, FUSE_INIT's DIRECT_IO_RELAX flag only serves the purp=
ose
> > >> of allowing shared mmap of files opened/created with DIRECT_IO enabl=
ed.
> > >> However, it leaves open the possibility of further relaxing the
> > >> DIRECT_IO restrictions (and in-effect, the cache coherency guarantee=
s of
> > >> DIRECT_IO) in the future.
> > >>
> > >> The DIRECT_IO_ALLOW_MMAP flag leaves no ambiguity of its purpose. It
> > >> only serves to allow shared mmap of DIRECT_IO files, while still
> > >> bypassing the cache on regular reads and writes. The shared mmap is =
the
> > >> only loosening of the cache policy that can take place with the flag=
.
> > >> This removes some ambiguity and introduces a more stable flag to be =
used
> > >> in FUSE_INIT. Furthermore, we can document that to allow shared mmap=
'ing
> > >> of DIRECT_IO files, a user must enable DIRECT_IO_ALLOW_MMAP.
> > >>
> > >> Tyler Fanelli (2):
> > >>    fs/fuse: Rename DIRECT_IO_RELAX to DIRECT_IO_ALLOW_MMAP
> > >>    docs/fuse-io: Document the usage of DIRECT_IO_ALLOW_MMAP
> > >
> > > Looks good.
> > >
> > > Applied, thanks.  Will send the PR during this merge window, since th=
e
> > > rename could break stuff if already released.
> >
> > I'm just porting back this feature to our internal fuse module and it
> > looks these rename patches have been forgotten?
> >
> >
>
> Hi Miklos, Bernd,
>
> I was looking at the DIRECT_IO_ALLOW_MMAP code and specifically at
> commit b5a2a3a0b776 ("fuse: write back dirty pages before direct write in
> direct_io_relax mode") and I was wondering - isn't dirty pages writeback
> needed *before* invalidate_inode_pages2() in fuse_file_mmap() for
> direct_io_allow_mmap case?
>
> For FUSE_PASSTHROUGH, I am going to need to call fuse_vma_close()
> for munmap of files also in direct-io mode [1], so I was considering inst=
alling
> fuse_file_vm_ops for the FOPEN_DIRECT_IO case, same as caching case,
> and regardless of direct_io_allow_mmap.
>
> I was asking myself if there was a good reason why fuse_page_mkwrite()/
> fuse_wait_on_page_writeback()/fuse_vma_close()/write_inode_now()
> should NOT be called for the FOPEN_DIRECT_IO case regardless of
> direct_io_allow_mmap?
>

Before trying to make changes to fuse_file_mmap() I tried to test
DIRECT_IO_RELAX - I enabled it in libfuse and ran fstest with
passthrough_hp --direct-io.

The test generic/095 - "Concurrent mixed I/O (buffer I/O, aiodio, mmap, spl=
ice)
on the same files" blew up hitting BUG_ON(fi->writectr < 0) in
fuse_set_nowrite()

I am wondering how this code was tested?

I could not figure out the problem and how to fix it.
Please suggest a fix and let me know which adjustments are needed
if I want to use fuse_file_vm_ops for all mmap modes.

Thanks,
Amir.

generic/095 5s ...  [10:53:05][   61.185656] kernel BUG at fs/fuse/dir.c:17=
56!
[   61.186653] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[   61.187447] CPU: 2 PID: 3599 Comm: fio Not tainted 6.6.0-xfstests #2025
[   61.188461] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.15.0-1 04/01/2014
[   61.189529] RIP: 0010:fuse_set_nowrite+0x47/0xdd
[   61.190117] Code: 48 8b 87 e8 00 00 00 48 85 c0 75 02 0f 0b 48 8d
af 38 06 00 00 48 89 fb 48 89 ef e8 e8 2b 8f 00 8b 83 28 05 00 00 85
c0 79 02 <0f> 0b 05 00 00 00 80 48 89 ef 89 83 28 05 00 00 e8 86 30 8f
00 be
[   61.192497] RSP: 0018:ffffc9000313fc98 EFLAGS: 00010282
[   61.193109] RAX: 0000000080000001 RBX: ffff88800cfb21c0 RCX: ffffc900031=
3fc3c
[   61.193937] RDX: 0000000000000003 RSI: ffffffff827ce6be RDI: ffffffff828=
a86cd
[   61.194736] RBP: ffff88800cfb27f8 R08: 0000000e3ef2354a R09: 00000000000=
00000
[   61.195509] R10: ffffffff82b74f20 R11: 0000000000000002 R12: ffff888009b=
f1f00
[   61.196291] R13: ffffc9000313fe70 R14: 0000000000000002 R15: ffff88800cf=
b23f0
[   61.197069] FS:  00007fa089f64740(0000) GS:ffff88807da00000(0000)
knlGS:0000000000000000
[   61.198024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   61.198701] CR2: 00007fa089f17fe0 CR3: 0000000009202001 CR4: 00000000003=
70ee0
[   61.199817] Call Trace:
[   61.200198]  <TASK>
[   61.200486]  ? __die_body+0x1b/0x59
[   61.200975]  ? die+0x35/0x4f
[   61.201379]  ? do_trap+0x7c/0xff
[   61.201828]  ? fuse_set_nowrite+0x47/0xdd
[   61.202303]  ? do_error_trap+0xbe/0xeb
[   61.202733]  ? fuse_set_nowrite+0x47/0xdd
[   61.203196]  ? fuse_set_nowrite+0x47/0xdd
[   61.203723]  ? exc_invalid_op+0x52/0x69
[   61.204202]  ? fuse_set_nowrite+0x47/0xdd
[   61.204720]  ? asm_exc_invalid_op+0x1a/0x20
[   61.205204]  ? fuse_set_nowrite+0x47/0xdd
[   61.205628]  ? fuse_set_nowrite+0x3d/0xdd
[   61.206061]  ? do_raw_spin_unlock+0x88/0x8f
[   61.206498]  ? _raw_spin_unlock+0x2d/0x43
[   61.206915]  ? fuse_range_is_writeback+0x71/0x84
[   61.207383]  fuse_sync_writes+0xf/0x19
[   61.207857]  fuse_direct_io+0x167/0x5bd
[   61.208375]  fuse_direct_write_iter+0xf0/0x146
[   61.208990]  vfs_write+0x11d/0x1c4
[   61.209458]  ksys_pwrite64+0x68/0x87
[   61.209959]  do_syscall_64+0x6e/0x88

