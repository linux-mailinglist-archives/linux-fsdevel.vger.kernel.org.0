Return-Path: <linux-fsdevel+bounces-43471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057FAA56F7A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 18:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA2D57AAAB6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 17:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8003F241663;
	Fri,  7 Mar 2025 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/ciEqze"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE282101F2;
	Fri,  7 Mar 2025 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369529; cv=none; b=FoMRheM2tvVtLBlFVnwZJKHHzjWn1SyMKDsgpoN1TCMnMr4eZlBQF0Fe74ka9NbjavipPApYTA+QEaav0fdFtQ73U2aSg3W4uVSAPM1OHdvY61kqRD2uDD7ozhFHMNdW0UVaGtwB2hiZQ75IMBmo8BpDu5YHSrDE39Ff/ViPEC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369529; c=relaxed/simple;
	bh=fTgYjtBd1Y5aX/PHcHjCJgi2ne1A4KC5VYoU0LfES3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRpCKMA8AI7dH0+mvPOfAjd/UstWqm3oQYcRDE4TllGvBJkwHpqHC2a1Qxx7NklyVd9v9h9GFTD1qY3b22rSWEvvUv5T/DfMft6SqCsGoRt0qti+XMOsQZ1INSZf0YwPctYPPpxnCVB6z53IYviSg7M0KOif0Jd7QBY3z4Dq6J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/ciEqze; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so1183518a12.1;
        Fri, 07 Mar 2025 09:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741369526; x=1741974326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2bV+93GEFpn3KE1wY4bHFWSGsAPF8+R+4qoLLnnUFE=;
        b=j/ciEqzesTAllvPkQJYG0dUyEXTwUzi8L0lkH46u10uTHPv0erRLLrKAW4AVInLHxC
         +WD8iWyeroI7G6GkPLiSgaBOzT4WQ0rypLr0ToSrZggiJn606b0pasNP6nxz4i7KUFfp
         f6XaNtlKNK4kA81r0b4bFiemUS/NPQpKoLeLroQlZ6opFLp+CCOS3R86o7qAVXFcs6tu
         opL4NiKQyXJkebJzQEm3yWewdQG2Lrvjcz41pRxbVTZhFl0rT+eDSQf7HH70ZOQuOx05
         WKe3IY7n6StZMantPkjqWhKl7K8r6t1w8reQrgvmfh3zfDc2PKlPabjTgAFA/3nzu9MK
         dIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741369526; x=1741974326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2bV+93GEFpn3KE1wY4bHFWSGsAPF8+R+4qoLLnnUFE=;
        b=JjtRLUUYHVC/LN0Z+WwZN55vCGlaDN4gS5j9ybHaVBW6EXwH5h8b6ibw7Dkgn99js7
         FrysWg4Kcfo+GMAKBgSMb1AFqdL7MTKol6w26c+svFG2P7bKBnYxJqZp2T5Zhe7xx020
         d+ilqS9/AWhpPsupKR5/X3powUby2+qPJ0UoEB54FUlbY1qTVoDLOzAC3gw902CRwI3C
         N57Mx/NllvoMLvsS6DnddHKW7DdfqT10jNvLWs/+fJDbR4u6Ezigl+ZewhL/Y05BRJK4
         rg9w7u/aerExnvKhRCbkj41AciQCNDwFeGwc4f2W/XDzWRG0yTvrV0V366M6jq93uUFm
         XIDA==
X-Forwarded-Encrypted: i=1; AJvYcCUWtugyK3D8NyK7Bij59kA+SPmYUnXvQLSH0jYQIKvKgMpuFtsbb7ovdQP1aqkzeoRZYTcMDe2S+ySSXQNJ@vger.kernel.org, AJvYcCXBU30IDDAvEM2UTpHS92oBHuVMsv4KRIIucTCmzCbWjCN+cV3Sm01YN6MkZMttCRnSroMn1QVnzIhgGPkp@vger.kernel.org, AJvYcCXi3emxudBIcvwmOuyFQr1NQS8GTDG937X0qfYsIGoRj/VRtWmuciW3sXAky5XMY1onFCeWKsgqLnyP@vger.kernel.org
X-Gm-Message-State: AOJu0YwtZaF/EELshPkM0LYfTmFDS4skyINnhCTsOq8ux3wQLCyyMTRe
	ZZ+0i6iiS1M8wnupVb1UWUkYzHD1JoLJy0cIOj10kEGAu37kOthjMj6MXZgZMfD6ejmW8fTOY4b
	eMNURAaKmqM/tzjCE7ZA1maVR4i0=
X-Gm-Gg: ASbGncusUpWQVWFbr6pZIXZRYrYesSVtZZV7lf4c4dly0ZkWx3H41JmxfQ3U0LVaEXJ
	c5LAAX1gDuvHPCvYxrUkT0E9kmTrYo2dbnR4tyMD8+jEsuqpTYcVSunVb7ezUWrNxLUnUin8s7q
	WG4lar82QjvCcgwPoFaX22hGUdpA==
X-Google-Smtp-Source: AGHT+IEmBRmko4QLwkLRaQOt5FhmEtxUggnufhBEEq70Dk25RmdOR/ZshO5S87xM2JoNs1YaRyM17eG15eURqooW9k8=
X-Received: by 2002:a05:6402:2683:b0:5e5:c847:1a56 with SMTP id
 4fb4d7f45d1cf-5e5e22bd1b6mr10312024a12.10.1741369525381; Fri, 07 Mar 2025
 09:45:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67a487f7.050a0220.19061f.05fc.GAE@google.com> <67c4881e.050a0220.1dee4d.0054.GAE@google.com>
 <7ehxrhbvehlrjwvrduoxsao5k3x4aw275patsb3krkwuq573yv@o2hskrfawbnc>
 <CAOQ4uxjf5H_vj-swF7wEvUkPobEuxs2q6jfO9jFsx4pqxtJMMg@mail.gmail.com>
 <20250304161509.GA4047943@perftesting> <CAOQ4uxj0cN-sUN=EE0+9tRhMFFrWLQ0T_i0fprwNRr92Hire6Q@mail.gmail.com>
 <20250304203657.GA4063187@perftesting> <CAOQ4uxihyR8u5c0T8q85ySNgp4U1T0MMSR=+vv3HWNFcvezRPQ@mail.gmail.com>
 <20250307154614.GA59451@perftesting> <CAOQ4uxizF1qGpC3+m47Y5C_NSMa84vbBRj6xg7_uS-BTJF0Ycw@mail.gmail.com>
In-Reply-To: <CAOQ4uxizF1qGpC3+m47Y5C_NSMa84vbBRj6xg7_uS-BTJF0Ycw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 7 Mar 2025 18:45:13 +0100
X-Gm-Features: AQ5f1JofUmv1iYpL1FGdwCjrdhgnQ4Cw6QHEOjLqZc--7F_SrO3COjsDQQLVPw8
Message-ID: <CAOQ4uxht4zLKegu==cg4rs-GmL3p-bfYZt_sXNu+yxwTccSM4g@mail.gmail.com>
Subject: Re: [syzbot] [xfs?] WARNING in fsnotify_file_area_perm
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jan Kara <jack@suse.cz>, 
	syzbot <syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	cem@kernel.org, chandan.babu@oracle.com, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 5:07=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Fri, Mar 7, 2025 at 4:46=E2=80=AFPM Josef Bacik <josef@toxicpanda.com>=
 wrote:
> >
> > On Tue, Mar 04, 2025 at 10:13:39PM +0100, Amir Goldstein wrote:
> > > On Tue, Mar 4, 2025 at 9:37=E2=80=AFPM Josef Bacik <josef@toxicpanda.=
com> wrote:
> > > >
> > > > On Tue, Mar 04, 2025 at 09:27:20PM +0100, Amir Goldstein wrote:
> > > > > On Tue, Mar 4, 2025 at 5:15=E2=80=AFPM Josef Bacik <josef@toxicpa=
nda.com> wrote:
> > > > > >
> > > > > > On Tue, Mar 04, 2025 at 04:09:16PM +0100, Amir Goldstein wrote:
> > > > > > > On Tue, Mar 4, 2025 at 12:06=E2=80=AFPM Jan Kara <jack@suse.c=
z> wrote:
> > > > > > > >
> > > > > > > > Josef, Amir,
> > > > > > > >
> > > > > > > > this is indeed an interesting case:
> > > > > > > >
> > > > > > > > On Sun 02-03-25 08:32:30, syzbot wrote:
> > > > > > > > > syzbot has found a reproducer for the following issue on:
> > > > > > > > ...
> > > > > > > > > ------------[ cut here ]------------
> > > > > > > > > WARNING: CPU: 1 PID: 6440 at ./include/linux/fsnotify.h:1=
45 fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify.h:145
> > > > > > > > > Modules linked in:
> > > > > > > > > CPU: 1 UID: 0 PID: 6440 Comm: syz-executor370 Not tainted=
 6.14.0-rc4-syzkaller-ge056da87c780 #0
> > > > > > > > > Hardware name: Google Google Compute Engine/Google Comput=
e Engine, BIOS Google 12/27/2024
> > > > > > > > > pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTY=
PE=3D--)
> > > > > > > > > pc : fsnotify_file_area_perm+0x20c/0x25c include/linux/fs=
notify.h:145
> > > > > > > > > lr : fsnotify_file_area_perm+0x20c/0x25c include/linux/fs=
notify.h:145
> > > > > > > > > sp : ffff8000a42569d0
> > > > > > > > > x29: ffff8000a42569d0 x28: ffff0000dcec1b48 x27: ffff0000=
d68a1708
> > > > > > > > > x26: ffff0000d68a16c0 x25: dfff800000000000 x24: 00000000=
00008000
> > > > > > > > > x23: 0000000000000001 x22: ffff8000a4256b00 x21: 00000000=
00001000
> > > > > > > > > x20: 0000000000000010 x19: ffff0000d68a16c0 x18: ffff8000=
a42566e0
> > > > > > > > > x17: 000000000000e388 x16: ffff800080466c24 x15: 00000000=
00000001
> > > > > > > > > x14: 1fffe0001b31513c x13: 0000000000000000 x12: 00000000=
00000000
> > > > > > > > > x11: 0000000000000001 x10: 0000000000ff0100 x9 : 00000000=
00000000
> > > > > > > > > x8 : ffff0000c6d98000 x7 : 0000000000000000 x6 : 00000000=
00000000
> > > > > > > > > x5 : 0000000000000020 x4 : 0000000000000000 x3 : 00000000=
00001000
> > > > > > > > > x2 : ffff8000a4256b00 x1 : 0000000000000001 x0 : 00000000=
00000000
> > > > > > > > > Call trace:
> > > > > > > > >  fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnoti=
fy.h:145 (P)
> > > > > > > > >  filemap_fault+0x12b0/0x1518 mm/filemap.c:3509
> > > > > > > > >  xfs_filemap_fault+0xc4/0x194 fs/xfs/xfs_file.c:1543
> > > > > > > > >  __do_fault+0xf8/0x498 mm/memory.c:4988
> > > > > > > > >  do_read_fault mm/memory.c:5403 [inline]
> > > > > > > > >  do_fault mm/memory.c:5537 [inline]
> > > > > > > > >  do_pte_missing mm/memory.c:4058 [inline]
> > > > > > > > >  handle_pte_fault+0x3504/0x57b0 mm/memory.c:5900
> > > > > > > > >  __handle_mm_fault mm/memory.c:6043 [inline]
> > > > > > > > >  handle_mm_fault+0xfa8/0x188c mm/memory.c:6212
> > > > > > > > >  do_page_fault+0x570/0x10a8 arch/arm64/mm/fault.c:690
> > > > > > > > >  do_translation_fault+0xc4/0x114 arch/arm64/mm/fault.c:78=
3
> > > > > > > > >  do_mem_abort+0x74/0x200 arch/arm64/mm/fault.c:919
> > > > > > > > >  el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:432
> > > > > > > > >  el1h_64_sync_handler+0x60/0xcc arch/arm64/kernel/entry-c=
ommon.c:510
> > > > > > > > >  el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:595
> > > > > > > > >  __uaccess_mask_ptr arch/arm64/include/asm/uaccess.h:169 =
[inline] (P)
> > > > > > > > >  fault_in_readable+0x168/0x310 mm/gup.c:2234 (P)
> > > > > > > > >  fault_in_iov_iter_readable+0x1dc/0x22c lib/iov_iter.c:94
> > > > > > > > >  iomap_write_iter fs/iomap/buffered-io.c:950 [inline]
> > > > > > > > >  iomap_file_buffered_write+0x490/0xd54 fs/iomap/buffered-=
io.c:1039
> > > > > > > > >  xfs_file_buffered_write+0x2dc/0xac8 fs/xfs/xfs_file.c:79=
2
> > > > > > > > >  xfs_file_write_iter+0x2c4/0x6ac fs/xfs/xfs_file.c:881
> > > > > > > > >  new_sync_write fs/read_write.c:586 [inline]
> > > > > > > > >  vfs_write+0x704/0xa9c fs/read_write.c:679
> > > > > > > >
> > > > > > > > The backtrace actually explains it all. We had a buffered w=
rite whose
> > > > > > > > buffer was mmapped file on a filesystem with an HSM mark. N=
ow the prefaulting
> > > > > > > > of the buffer happens already (quite deep) under the filesy=
stem freeze
> > > > > > > > protection (obtained in vfs_write()) which breaks assumptio=
ns of HSM code
> > > > > > > > and introduces potential deadlock of HSM handler in userspa=
ce with filesystem
> > > > > > > > freezing. So we need to think how to deal with this case...
> > > > > > >
> > > > > > > Ouch. It's like the splice mess all over again.
> > > > > > > Except we do not really care to make this use case work with =
HSM
> > > > > > > in the sense that we do not care to have to fill in the mmape=
d file content
> > > > > > > in this corner case - we just need to let HSM fail the access=
 if content is
> > > > > > > not available.
> > > > > > >
> > > > > > > If you remember, in one of my very early version of pre-conte=
nt events,
> > > > > > > the pre-content event (or maybe it was FAN_ACCESS_PERM itself=
)
> > > > > > > carried a flag (I think it was called FAN_PRE_VFS) to communi=
cate to
> > > > > > > HSM service if it was safe to write to fs in the context of e=
vent handling.
> > > > > > >
> > > > > > > At the moment, I cannot think of any elegant way out of this =
use case
> > > > > > > except annotating the event from fault_in_readable() as "unsa=
fe-for-write".
> > > > > > > This will relax the debugging code assertion and notify the H=
SM service
> > > > > > > (via an event flag) that it can ALLOW/DENY, but it cannot fil=
l the file.
> > > > > > > Maybe we can reuse the FAN_ACCESS_PERM event to communicate
> > > > > > > this case to HSM service.
> > > > > > >
> > > > > > > WDYT?
> > > > > >
> > > > > > I think that mmap was a mistake.
> > > > >
> > > > > What do you mean?
> > > > > Isn't the fault hook required for your large executables use case=
?
> > > >
> > > > I mean the mmap syscall was a mistake ;).
> > > >
> > >
> > > ah :)
> > >
> > > > >
> > > > > >
> > > > > > Is there a way to tell if we're currently in a path that is und=
er fsfreeze
> > > > > > protection?
> > > > >
> > > > > Not at the moment.
> > > > > At the moment, file_write_not_started() is not a reliable check
> > > > > (has false positives) without CONFIG_LOCKDEP.
> > > > >
> > >
> > > One very ugly solution is to require CONFIG_LOCKDEP for
> > > pre-content events.
> > >
> > > > > > Just denying this case would be a simpler short term solution w=
hile
> > > > > > we come up with a long term solution. I think your solution is =
fine, but I'd be
> > > > > > just as happy with a simpler "this isn't allowed" solution. Tha=
nks,
> > > > >
> > > > > Yeh, I don't mind that, but it's a bit of an overkill considering=
 that
> > > > > file with no content may in fact be rare.
> > > >
> > > > Agreed, I'm fine with your solution.
> > >
> > > Well, my "solution" was quite hand-wavy - it did not really say how t=
o
> > > propagate the fact that faults initiated from fault_in_readable().
> > > Do you guys have any ideas for a simple solution?
> >
> > Sorry I've been elbow deep in helping getting our machine replacements =
working
> > faster.
> >
> > I've been thnking about this, it's not like we can carry context from t=
he reason
> > we are faulting in, at least not simply, so I think the best thing to d=
o is
> > either
> >
> > 1) Emit a precontent event at mmap() time for the whole file, since rea=
lly all I
> > care about is faulting at exec time, and then we can just skip the prec=
ontent
> > event if we're not exec.
>
> Sorry, not that familiar with exec code. Do you mean to issue pre-content
> for page fault only if memory is mapped executable or is there another wa=
y
> of knowing that we are in exec context?
>
> If the former, then syzbot will catch up with us and write a buffer which=
 is
> mapped readable and exec.
>
> >
> > 2) Revert the page fault stuff, put back your thing to fault the whole =
file, and
> > wait until we think of a better way to deal with this.
> >
> > Obviously I'd prefer not #2, but I'd really, really rather not chuck al=
l of HSM
> > because my page fault thing is silly.  I'll carry what I need internall=
y while
> > we figure out what to do upstream.  #1 doesn't seem bad, but I haven't =
thought
> > about it that hard.  Thanks,
> >
>
> So I started to test this patch, but I may be doing something very
> terribly wrong
> with this. Q: What is this something that is terribly wrong?
>
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 2788df98080f8..a8822b44d4967 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3033,13 +3033,27 @@ static inline void file_start_write(struct file *=
file)
>         if (!S_ISREG(file_inode(file)->i_mode))
>                 return;
>         sb_start_write(file_inode(file)->i_sb);
> +       /*
> +        * Prevent fault-in user pages that may call HSM hooks with
> +        * sb_writers held.
> +        */
> +       if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode)))
> +               pagefault_disable();
>  }
>
>  static inline bool file_start_write_trylock(struct file *file)
>  {
>         if (!S_ISREG(file_inode(file)->i_mode))
>                 return true;
> -       return sb_start_write_trylock(file_inode(file)->i_sb);
> +       if (!sb_start_write_trylock(file_inode(file)->i_sb))
> +               return false;
> +       /*
> +        * Prevent fault-in user pages that may call HSM hooks with
> +        * sb_writers held.
> +        */
> +       if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode)))
> +               pagefault_disable();
> +       return true;
>  }
>
>  /**
> @@ -3053,6 +3067,8 @@ static inline void file_end_write(struct file *file=
)
>         if (!S_ISREG(file_inode(file)->i_mode))
>                 return;
>         sb_end_write(file_inode(file)->i_sb);
> +       if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode)))
> +               pagefault_enable();
>  }

One thing that is wrong is that this is checking if the written file
is marked for
pre-content events, not the input buffer mmaped file.

What we would have needed here is a check of
  unlikely(fsnotify_sb_has_priority_watchers(sb,
                                                FSNOTIFY_PRIO_PRE_CONTENT))=
)

But Linus will not like that...

Do we even care about optimizing the pre-content hooks of sporadic files
that are not marked for pre-content events when there are pre-content
watches on the filesystem?

I think all of our use cases mark the sb for pre-content events anyway
and do not care about a bit of overhead for non-marked files.
If that is the case we can do away with the extra optimization
and then the changes above will really solve the issue.

I've squashed the followup change to the fsnotify-fixes branch.

One thing that this patch does not address is aio and io_uring,
but the comment above fault_in_iov_iter_readable() says:
   " ...For async buffered writes the assumption is that the user
   " page has already been faulted in.

IDK. Let me know what you think.

Thanks,
Amir.

--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -652,7 +652,6 @@ void file_set_fsnotify_mode_from_watchers(struct file *=
file)
 {
        struct dentry *dentry =3D file->f_path.dentry, *parent;
        struct super_block *sb =3D dentry->d_sb;
-       __u32 mnt_mask, p_mask;

        /* Is it a file opened by fanotify? */
        if (FMODE_FSNOTIFY_NONE(file->f_mode))
@@ -681,30 +680,10 @@ void file_set_fsnotify_mode_from_watchers(struct
file *file)
        }

        /*
-        * OK, there are some pre-content watchers. Check if anybody is
-        * watching for pre-content events on *this* file.
+        * OK, there are some pre-content watchers on this fs, so
+        * Enable pre-content events.
         */
-       mnt_mask =3D READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify_m=
ask);
-       if (unlikely(fsnotify_object_watched(d_inode(dentry), mnt_mask,
-                                    FSNOTIFY_PRE_CONTENT_EVENTS))) {
-               /* Enable pre-content events */
-               file_set_fsnotify_mode(file, 0);
-               return;
-       }
-
-       /* Is parent watching for pre-content events on this file? */
-       if (dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) {
-               parent =3D dget_parent(dentry);
-               p_mask =3D fsnotify_inode_watches_children(d_inode(parent))=
;
-               dput(parent);
-               if (p_mask & FSNOTIFY_PRE_CONTENT_EVENTS) {
-                       /* Enable pre-content events */
-                       file_set_fsnotify_mode(file, 0);
-                       return;
-               }
-       }
-       /* Nobody watching for pre-content events from this file */
-       file_set_fsnotify_mode(file, FMODE_NONOTIFY | FMODE_NONOTIFY_PERM);
+       file_set_fsnotify_mode(file, 0);
 }
 #endif

