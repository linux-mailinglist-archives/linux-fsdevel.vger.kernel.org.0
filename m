Return-Path: <linux-fsdevel+bounces-47512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD9DA9F186
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 14:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FE677A4D41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 12:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5FF26A0A6;
	Mon, 28 Apr 2025 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GAOioG2y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809DB2222A0
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844917; cv=none; b=LHxpfnp/PZ5ApT0omsfYTkkoqoNWYGEX4YgZ6fIPorMNYft2BRmz0vj4dQ1vUX9WA3nU8Iboiv5V/DJgOe9n4BpK6rDv/erVIMfA3vJJkL/iiAZTRFHZVwC8JRJ0kaMdJ8KFdzMplxHBhuO+D4kU86rNsMNRr1NbwuHK7bVp8ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844917; c=relaxed/simple;
	bh=7MkKiehNSk/BAJR/XixvM0DE2XZF21px9Q6AFgRjfwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxOQnqcgr0HLMgsXnjEf26nee7WsQXpH9jQ8TihmSxLAIYBHmwfMwF/4QeL6tEJv9XPIy07d6LjBAsB8VVSBD7+m4+E1ot3xvaCD2GVpzjxrrXshTQD04eLBmSyzhtbG/c14tfYNqxlUcSw3LPZ2Kdszxm5thG0wNMe7degSnOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GAOioG2y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=SyoSqsvOz3T/GFWM1/h4gYpluj5UzP6jSH1W0qXWyn4=; b=GAOioG2y1S6Vc+r0Uf7Qx1eDz6
	0IYt5jnWwBnf2Jcbax5YGzyz52ea92wcLKeG+IRdlrGs43qM2I4Kh64aiJD7ODhkUDUd4hLQkbo3U
	49a/ZC001LwQlBQ7QAk4QSr2OdHrUUs3tjE3mYM7M3FzwAu1KYvb4eTa7QCeGCLKOG9Roq1MkbOJE
	59LRt9LgpCgqKbL2SFHokH7rtdzJW7HLyx4DcOjTex8GzdlAGk0YcZkX/u4bANwZenng/FHVAV/jZ
	1VRl5Uv3UT4Bz43+jPtqeXoWWQu5qg7Lo3KMax/qMo1mlfG9DAMV6v/4bgtjGjNOzxd3os6ELCKIe
	6kjbDVGg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9O0k-0000000HG8P-2AbH;
	Mon, 28 Apr 2025 12:55:02 +0000
Date: Mon, 28 Apr 2025 13:55:02 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Liebes Wang <wanghaichi0403@gmail.com>, ojaswin@linux.ibm.com,
	Theodore Ts'o <tytso@mit.edu>, yi.zhang@huawei.com,
	linux-fsdevel@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: kernel BUG in zero_user_segments
Message-ID: <aA96phKBQvJFby_S@casper.infradead.org>
References: <CADCV8spm=TtW_Lu6p-5q-jdHv1ryLcx45mNBEcYdELbHv_4TnQ@mail.gmail.com>
 <uxweupjmz7pzbj77cciiuxduxnbuk33mx75bimynzcjmq664zo@xqrdf6ouf5v6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <uxweupjmz7pzbj77cciiuxduxnbuk33mx75bimynzcjmq664zo@xqrdf6ouf5v6>

On Mon, Apr 28, 2025 at 10:14:10AM +0200, Jan Kara wrote:
> So there's something suspicious about this report. The stacktrace shows
> we've crashed in punch hole code (call from ioctl_preallocate()) but the
> reproducer actually never calls this. Anyway, the reported stack trace en=
ds
> with truncate_inode_partial_folio() -> folio_zero_range() ->
> zero_user_segments(). The assertion that's failing is:
>=20
> BUG_ON(end1 > page_size(page) || end2 > page_size(page));
>=20
> Now it seems that this assertion can indeed easily trigger when we have
> a large folio because truncate_inode_partial_folio() is called to zero out
> tail of the whole folio which can certainly be more than a page. Matthew,
> am I missing something (I guess I am because otherwise I'd expect we'd be
> crashing left and right) or is the folio conversion on this path indeed
> broken?

page_size(page) is not PAGE_SIZE (necessarily).  It's from the bad
old days (ie 2019) when we didn't have folios yet.  We haven't yet
got round to removing zero_user_segments() and related functions, so
folio_zero_range() is still implemented in terms of it.

Anyway, ext4 doesn't have large folio support, so all this is really
telling you is that the truncation path called folio_zero_range() with
bad arguments.

But I'm not sure I see how.  truncate_inode_pages_range() takes (mapping,
start, end) and looks up the folios and calculates everything there.
You'd think if there were a bug in the calculations we'd see it by now,
and in any case it wouldn't be bisectable to an ext4 commit.

It does look like there's a deliberately-corrupt ext4 image involved
here, but I'm not sure how that could upset the page cache like this.

> 								Honza
>=20
> >=20
> > The test case, kernel config and full bisection log are attached.
> >=20
> > The report is (The full report is attached):
> > EXT4-fs (loop7): mounted filesystem 00000000-0000-0000-0000-000000000000
> > r/w without journal. Quota mode: writeback.
> > EXT4-fs warning (device loop7): ext4_block_to_path:105: block 214748364=
8 >
> > max in inode 15
> > ------------[ cut here ]------------
> > kernel BUG at ./include/linux/highmem.h:275!
> > Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> > CPU: 0 UID: 0 PID: 6795 Comm: syz.7.479 Not tainted
> > 6.15.0-rc3-g9d7a0577c9db #1 PREEMPT(voluntary)
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > 1.13.0-1ubuntu1.1 04/01/2014
> > RIP: 0010:zero_user_segments.constprop.0+0x10c/0x290
> > include/linux/highmem.h:275
> > Code: 0f b6 4b 40 ba 00 10 00 00 48 d3 e2 49 89 d7 e8 ba d5 e2 ff 4c 89=
 fe
> > 4c 89 ef e8 3f d0 e2 ff 4d 39 fd 76 08 e8 a5 d5 e2 ff 90 <0f> 0b e8 9d =
d5
> > e2 ff be 08 00 00 00 48 89 df e8 a0 9c 1d 00 48 89
> > RSP: 0018:ffff8881235ff678 EFLAGS: 00010216
> > RAX: 000000000000025d RBX: ffffea00056071c0 RCX: ffffc90002e0b000
> > RDX: 0000000000080000 RSI: ffffffff818f7b0b RDI: 0000000000000006
> > RBP: 000000000040b000 R08: 0000000000000000 R09: fffff94000ac0e38
> > R10: 0000000000001000 R11: 0000000000000000 R12: 0000000000000005
> > R13: 000000000040b000 R14: 0000000000000000 R15: 0000000000001000
> > FS:  00007fecef19d700(0000) GS:ffff888543948000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f5e38b40008 CR3: 000000013ebaa001 CR4: 0000000000770ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
> > PKRU: 80000000
> > Call Trace:
> >  <TASK>
> >  folio_zero_range include/linux/highmem.h:647 [inline]
> >  truncate_inode_partial_folio+0x6da/0xbd0 mm/truncate.c:219
> >  truncate_inode_pages_range+0x3fc/0xcc0 mm/truncate.c:387
> >  ext4_truncate_page_cache_block_range+0xb3/0x5c0 fs/ext4/inode.c:3974
> >  ext4_punch_hole+0x2cd/0xec0 fs/ext4/inode.c:4049
> >  ext4_fallocate+0x128d/0x32c0 fs/ext4/extents.c:4766
> >  vfs_fallocate+0x3ed/0xd70 fs/open.c:338
> >  ioctl_preallocate+0x190/0x200 fs/ioctl.c:290
> >  file_ioctl fs/ioctl.c:333 [inline]
> >  do_vfs_ioctl+0x149c/0x1850 fs/ioctl.c:885
> >  __do_sys_ioctl fs/ioctl.c:904 [inline]
> >  __se_sys_ioctl fs/ioctl.c:892 [inline]
> >  __x64_sys_ioctl+0x11f/0x200 fs/ioctl.c:892
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xc1/0x1d0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> > syz_mount_image$ext4(&(0x7f0000000400)=3D'ext4\x00', &(0x7f00000001c0)=
=3D'./file0\x00', 0x0, &(0x7f0000000280)=3D{[{@journal_ioprio}, {@mb_optimi=
ze_scan}, {@data_err_ignore}, {@grpquota}, {@barrier}]}, 0x1, 0x3cb, &(0x7f=
00000026c0)=3D"$eJzs3M9rHFUcAPDvTH61aXUjeBC9LAgaELPZpFoFRQUFD55sLx48LLtpLW4=
aabZgSw4VPHnVf0AE79V/QBDFmzdvgmBFKRRJe/K0Mrsz6ZrsxsTduEn6+cBj35uZzXvfndnhO5=
OdF8ADqxwRr0bEREQsRUQpX57mJW50S7bdvc2NelaSaLfP/ZlEEhF3Nzfqxd9K8tdTeWM+jUg/j=
njixs5+169df7/WbK5cyduV1uoHlfVr15+9tFq7uHJx5XL1hRefX1o+Wz1zdmSx3vz53PKv377+=
w1e/PfXTj+2Xv8jGezpf1xvHqJSjvPWZbPfcqDsbs+lxDwAAgD1J89x/spP/l2KiU+sqRWVjrIM=
DAAAARqL9Sv4KAAAAHGOJa38AAAA45orfAdzd3KgXZYw/R/jf3XktIua68RfPN3fXTMaJfJupA3=
y+tRwRJ95uvJOVOKDnkAEAen2T5T+L/fK/NB7r2W4my1Mi4uSI+y9va+/Mf9LbI+7yH7L876Weu=
W3u9cSfm5vIWw91UsWp5MKl5spiRDwcEfMxNZO1q7v0cWvmk5lB63rzv6xk/Re5YD6O25Pb3t2o=
tWrDxNzrzkcRj0/2iz/Zyn+TiJgdoo8v/7p5ddC6f4//YLU/j3i67/6/P3NPsvv8RJXO8VApjoq=
dbq3+8u6g/scdf7b/Z3ePfy7pna9pff99/L54frVT6XPy+K/H/3RyvlMvrss+rLVaV6oR08lbO5=
cv3X9v0S62z+Kff7L/9784/yX5nFan83PAfn339XufDlp3GPZ/Y1/7f/+VN978fojvf7b/z3Rq8=
/mSvZz/9jrAYT47AAAAOCrSzn2NJF3YqqfpwkL3fsejMZs219Zbz1xYu3q50b3/MRdTaXGnq9Rz=
P7Ta/Tf6VntpW3s5Ih6JiM9KJzvthfpaszHu4AEAAOABcWrA9X/mj9K4RwcAAACMzNy4BwAAAAA=
cONf/AAAAcKwNM6+fymGv1ONQDEPlCFbGfWYCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAA42v4OAAD///tZxK0=3D")
> > quotactl_fd$Q_SETINFO(0xffffffffffffffff, 0x2, 0x0, &(0x7f0000000080)=
=3D{0x80000000000002, 0x80000000005, 0x1, 0x6})
> > r0 =3D openat(0xffffffffffffff9c, &(0x7f0000000040)=3D'./file1\x00', 0x=
42, 0x1ff)
> > ioctl$EXT4_IOC_CHECKPOINT(r0, 0x40305829, &(0x7f0000000080)=3D0x5)
> > r1 =3D openat(0xffffffffffffff9c, &(0x7f0000000040)=3D'./file1\x00', 0x=
42, 0x1ff)
> > ioctl$EXT4_IOC_CHECKPOINT(r1, 0x40305829, &(0x7f0000000080)=3D0x5)
>=20
>=20
>=20
>=20
>=20
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

