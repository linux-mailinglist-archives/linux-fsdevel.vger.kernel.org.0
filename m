Return-Path: <linux-fsdevel+bounces-43454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F908A56D2B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 17:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330913A7FBF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 16:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4919A224B1F;
	Fri,  7 Mar 2025 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpiDAtW1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F12B224AF1;
	Fri,  7 Mar 2025 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363656; cv=none; b=HbjMMKg4vd4BV0haZFkNqW9WeADB8m1sdaoJtCYpC9tuijW7wiBg/W0CHIjWcpcHvVDE7NZ/aCCLQ3ktaJhGKUy/N+3fbzTx2BEbQscsyWm+TLUspnl4G3jMGIMKLop7pP9nGQMZ/uexxfQsTtQzAVLzak9S0izPmq1VYtKecIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363656; c=relaxed/simple;
	bh=5T86q/kgh6mSlxjuRzax8Z4gDZzoCuAiQPEYVgFA7aM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHRD6Kmepa33rM+JybS6k46zgyG8RwKQDcPR2F9Roqne6h8Dz1u7DAGUomnQerUL0Cibd+58OJdzUkieLbslre1yRalm2oiGQyNOoe8HGB80pU8z2y1sb1Ki+yEeHjjCCPtAx8Gh/BuK8FBnKo8jl8NzsHiohRhCWFhEyOMKvlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpiDAtW1; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso306345266b.1;
        Fri, 07 Mar 2025 08:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741363653; x=1741968453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcRVI7e0DsHUk3FJE3VtyyH2vYlzTlEuGkFocdfHzMo=;
        b=PpiDAtW1xnTDCe9mcWgv92O2ZI7DQWF8cQLouOwpdSyinkW0YwAZnlHUgJwIGgZuuW
         VeXZh6mw8C/UGFBLeYAbio/12sDbxmg3TeHmKLzZKdbpx8oKzFSmNquAMMf0dxs6qtFC
         zYA7NfN2te/NmQKpkWPr0lJcqlBH4WREeoc2oTfFMac9YYU/0PA+DZPmjikryDW0HIFo
         FJ6RJNlJaf+4wnlUzli+5y/E8JRoFEoL4D8qGu4edCDv7nQFMoy4LpbfIJqy2Tzuzkc2
         axCZ8O+1x6vn3HRgrOPj843ikdGdhBWWuQEQ1MqzMvRxguGKVldEetEs0bCV8QOdowDP
         mNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741363653; x=1741968453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcRVI7e0DsHUk3FJE3VtyyH2vYlzTlEuGkFocdfHzMo=;
        b=jkIWtH7rZ61l+6s8bIhY9neaSEIlG5cPxYvpZ+S0rbY7Atp6Qi3pNS/qHHWssbEqdE
         Nzd5GlmH0FgncdyG/BeiilsqKAocVUsirVVcRmw74CYkDoVpYBxwLWqySTUz7B0tqdoK
         ld0BNVjNgxbhxhWqqMQPx4r1IJAJGT/nF1BMRHaJ0J9MkWDIoc5NHf8qBiBE3aRS/ejr
         B4GjPoEFttxMooEK0oRXBDIwDpG0i8XERa4BNqqOp0D0GkqWH1mWddyRk4ka6d7b3n3N
         NFo9Fij2zzb640j1EHZozS6BfrW5UKXQNOJHCMDOYVATfrmEv2YDRx5RVayBIqflwwCq
         bL8g==
X-Forwarded-Encrypted: i=1; AJvYcCV1Phi2kZsl6Ie+BRKfY8xCv7OYiaNSK5qKeEdKFXpyUwuJxKN+ZBMLfgl4d9Fvn7IosUIzJb0zAgGXlYr+@vger.kernel.org, AJvYcCVL9TG3e4EICY/JaqYO0qC4cR/7zfwfDVwsI/FfCguiGSR6twDbYNcZyNQRzCP++pJj8T+KwBsdanA0/DiK@vger.kernel.org, AJvYcCViYs/Q773wHbR0KxjL6P6EMaQan+DZ7NoyYq7PD2d95vij+afMsqTv0QaK5wEY7xGDehfW+he+nGe2@vger.kernel.org
X-Gm-Message-State: AOJu0YxALUk8jUoCufLMscDIGzafEAxTXaZAoaCvIenPiJlAwrqKXAST
	7B0ouNOCPx+un/tgxY/fGxOtPBQBYNNs0I6FS6sHczhzwT2+4t4qhg+ogcWqyC5NCPksKflimPa
	shWBayZE8pa8ChVNi4FFudDfNZ58=
X-Gm-Gg: ASbGncuyA1MeB8EXWt23CDqYovheg/mZyff3FdtiG1TGKg0KTQuEtH0DbCfpiaTXRp6
	aoTfeuZaZ8tM/uzKBcv13CLhgeRuUUcHWc5uyRmBEkvTDgpq7byXeUIuGnKG9zErCMmqkXCzYVd
	PUW3GYAKukvHw45jY3TumGJfKTaw==
X-Google-Smtp-Source: AGHT+IFLLSgCLyKxpAZ92GZrXIahBQ6WnG4lhUhGiSoYcrtahVPiew7GJDIcZlQMi+s7UwVQ1oICaMl0Yx1DU3NGJts=
X-Received: by 2002:a17:907:94d0:b0:ac2:1936:6f37 with SMTP id
 a640c23a62f3a-ac252b5742cmr463139466b.28.1741363652274; Fri, 07 Mar 2025
 08:07:32 -0800 (PST)
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
 <20250307154614.GA59451@perftesting>
In-Reply-To: <20250307154614.GA59451@perftesting>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 7 Mar 2025 17:07:20 +0100
X-Gm-Features: AQ5f1JosS0A-XlrWSJp17CPWYsuMc5A0FIXwxDRPC1YHVvfkUSdokDLUzW_h2FM
Message-ID: <CAOQ4uxizF1qGpC3+m47Y5C_NSMa84vbBRj6xg7_uS-BTJF0Ycw@mail.gmail.com>
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

On Fri, Mar 7, 2025 at 4:46=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> w=
rote:
>
> On Tue, Mar 04, 2025 at 10:13:39PM +0100, Amir Goldstein wrote:
> > On Tue, Mar 4, 2025 at 9:37=E2=80=AFPM Josef Bacik <josef@toxicpanda.co=
m> wrote:
> > >
> > > On Tue, Mar 04, 2025 at 09:27:20PM +0100, Amir Goldstein wrote:
> > > > On Tue, Mar 4, 2025 at 5:15=E2=80=AFPM Josef Bacik <josef@toxicpand=
a.com> wrote:
> > > > >
> > > > > On Tue, Mar 04, 2025 at 04:09:16PM +0100, Amir Goldstein wrote:
> > > > > > On Tue, Mar 4, 2025 at 12:06=E2=80=AFPM Jan Kara <jack@suse.cz>=
 wrote:
> > > > > > >
> > > > > > > Josef, Amir,
> > > > > > >
> > > > > > > this is indeed an interesting case:
> > > > > > >
> > > > > > > On Sun 02-03-25 08:32:30, syzbot wrote:
> > > > > > > > syzbot has found a reproducer for the following issue on:
> > > > > > > ...
> > > > > > > > ------------[ cut here ]------------
> > > > > > > > WARNING: CPU: 1 PID: 6440 at ./include/linux/fsnotify.h:145=
 fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify.h:145
> > > > > > > > Modules linked in:
> > > > > > > > CPU: 1 UID: 0 PID: 6440 Comm: syz-executor370 Not tainted 6=
.14.0-rc4-syzkaller-ge056da87c780 #0
> > > > > > > > Hardware name: Google Google Compute Engine/Google Compute =
Engine, BIOS Google 12/27/2024
> > > > > > > > pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
> > > > > > > > pc : fsnotify_file_area_perm+0x20c/0x25c include/linux/fsno=
tify.h:145
> > > > > > > > lr : fsnotify_file_area_perm+0x20c/0x25c include/linux/fsno=
tify.h:145
> > > > > > > > sp : ffff8000a42569d0
> > > > > > > > x29: ffff8000a42569d0 x28: ffff0000dcec1b48 x27: ffff0000d6=
8a1708
> > > > > > > > x26: ffff0000d68a16c0 x25: dfff800000000000 x24: 0000000000=
008000
> > > > > > > > x23: 0000000000000001 x22: ffff8000a4256b00 x21: 0000000000=
001000
> > > > > > > > x20: 0000000000000010 x19: ffff0000d68a16c0 x18: ffff8000a4=
2566e0
> > > > > > > > x17: 000000000000e388 x16: ffff800080466c24 x15: 0000000000=
000001
> > > > > > > > x14: 1fffe0001b31513c x13: 0000000000000000 x12: 0000000000=
000000
> > > > > > > > x11: 0000000000000001 x10: 0000000000ff0100 x9 : 0000000000=
000000
> > > > > > > > x8 : ffff0000c6d98000 x7 : 0000000000000000 x6 : 0000000000=
000000
> > > > > > > > x5 : 0000000000000020 x4 : 0000000000000000 x3 : 0000000000=
001000
> > > > > > > > x2 : ffff8000a4256b00 x1 : 0000000000000001 x0 : 0000000000=
000000
> > > > > > > > Call trace:
> > > > > > > >  fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify=
.h:145 (P)
> > > > > > > >  filemap_fault+0x12b0/0x1518 mm/filemap.c:3509
> > > > > > > >  xfs_filemap_fault+0xc4/0x194 fs/xfs/xfs_file.c:1543
> > > > > > > >  __do_fault+0xf8/0x498 mm/memory.c:4988
> > > > > > > >  do_read_fault mm/memory.c:5403 [inline]
> > > > > > > >  do_fault mm/memory.c:5537 [inline]
> > > > > > > >  do_pte_missing mm/memory.c:4058 [inline]
> > > > > > > >  handle_pte_fault+0x3504/0x57b0 mm/memory.c:5900
> > > > > > > >  __handle_mm_fault mm/memory.c:6043 [inline]
> > > > > > > >  handle_mm_fault+0xfa8/0x188c mm/memory.c:6212
> > > > > > > >  do_page_fault+0x570/0x10a8 arch/arm64/mm/fault.c:690
> > > > > > > >  do_translation_fault+0xc4/0x114 arch/arm64/mm/fault.c:783
> > > > > > > >  do_mem_abort+0x74/0x200 arch/arm64/mm/fault.c:919
> > > > > > > >  el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:432
> > > > > > > >  el1h_64_sync_handler+0x60/0xcc arch/arm64/kernel/entry-com=
mon.c:510
> > > > > > > >  el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:595
> > > > > > > >  __uaccess_mask_ptr arch/arm64/include/asm/uaccess.h:169 [i=
nline] (P)
> > > > > > > >  fault_in_readable+0x168/0x310 mm/gup.c:2234 (P)
> > > > > > > >  fault_in_iov_iter_readable+0x1dc/0x22c lib/iov_iter.c:94
> > > > > > > >  iomap_write_iter fs/iomap/buffered-io.c:950 [inline]
> > > > > > > >  iomap_file_buffered_write+0x490/0xd54 fs/iomap/buffered-io=
.c:1039
> > > > > > > >  xfs_file_buffered_write+0x2dc/0xac8 fs/xfs/xfs_file.c:792
> > > > > > > >  xfs_file_write_iter+0x2c4/0x6ac fs/xfs/xfs_file.c:881
> > > > > > > >  new_sync_write fs/read_write.c:586 [inline]
> > > > > > > >  vfs_write+0x704/0xa9c fs/read_write.c:679
> > > > > > >
> > > > > > > The backtrace actually explains it all. We had a buffered wri=
te whose
> > > > > > > buffer was mmapped file on a filesystem with an HSM mark. Now=
 the prefaulting
> > > > > > > of the buffer happens already (quite deep) under the filesyst=
em freeze
> > > > > > > protection (obtained in vfs_write()) which breaks assumptions=
 of HSM code
> > > > > > > and introduces potential deadlock of HSM handler in userspace=
 with filesystem
> > > > > > > freezing. So we need to think how to deal with this case...
> > > > > >
> > > > > > Ouch. It's like the splice mess all over again.
> > > > > > Except we do not really care to make this use case work with HS=
M
> > > > > > in the sense that we do not care to have to fill in the mmaped =
file content
> > > > > > in this corner case - we just need to let HSM fail the access i=
f content is
> > > > > > not available.
> > > > > >
> > > > > > If you remember, in one of my very early version of pre-content=
 events,
> > > > > > the pre-content event (or maybe it was FAN_ACCESS_PERM itself)
> > > > > > carried a flag (I think it was called FAN_PRE_VFS) to communica=
te to
> > > > > > HSM service if it was safe to write to fs in the context of eve=
nt handling.
> > > > > >
> > > > > > At the moment, I cannot think of any elegant way out of this us=
e case
> > > > > > except annotating the event from fault_in_readable() as "unsafe=
-for-write".
> > > > > > This will relax the debugging code assertion and notify the HSM=
 service
> > > > > > (via an event flag) that it can ALLOW/DENY, but it cannot fill =
the file.
> > > > > > Maybe we can reuse the FAN_ACCESS_PERM event to communicate
> > > > > > this case to HSM service.
> > > > > >
> > > > > > WDYT?
> > > > >
> > > > > I think that mmap was a mistake.
> > > >
> > > > What do you mean?
> > > > Isn't the fault hook required for your large executables use case?
> > >
> > > I mean the mmap syscall was a mistake ;).
> > >
> >
> > ah :)
> >
> > > >
> > > > >
> > > > > Is there a way to tell if we're currently in a path that is under=
 fsfreeze
> > > > > protection?
> > > >
> > > > Not at the moment.
> > > > At the moment, file_write_not_started() is not a reliable check
> > > > (has false positives) without CONFIG_LOCKDEP.
> > > >
> >
> > One very ugly solution is to require CONFIG_LOCKDEP for
> > pre-content events.
> >
> > > > > Just denying this case would be a simpler short term solution whi=
le
> > > > > we come up with a long term solution. I think your solution is fi=
ne, but I'd be
> > > > > just as happy with a simpler "this isn't allowed" solution. Thank=
s,
> > > >
> > > > Yeh, I don't mind that, but it's a bit of an overkill considering t=
hat
> > > > file with no content may in fact be rare.
> > >
> > > Agreed, I'm fine with your solution.
> >
> > Well, my "solution" was quite hand-wavy - it did not really say how to
> > propagate the fact that faults initiated from fault_in_readable().
> > Do you guys have any ideas for a simple solution?
>
> Sorry I've been elbow deep in helping getting our machine replacements wo=
rking
> faster.
>
> I've been thnking about this, it's not like we can carry context from the=
 reason
> we are faulting in, at least not simply, so I think the best thing to do =
is
> either
>
> 1) Emit a precontent event at mmap() time for the whole file, since reall=
y all I
> care about is faulting at exec time, and then we can just skip the precon=
tent
> event if we're not exec.

Sorry, not that familiar with exec code. Do you mean to issue pre-content
for page fault only if memory is mapped executable or is there another way
of knowing that we are in exec context?

If the former, then syzbot will catch up with us and write a buffer which i=
s
mapped readable and exec.

>
> 2) Revert the page fault stuff, put back your thing to fault the whole fi=
le, and
> wait until we think of a better way to deal with this.
>
> Obviously I'd prefer not #2, but I'd really, really rather not chuck all =
of HSM
> because my page fault thing is silly.  I'll carry what I need internally =
while
> we figure out what to do upstream.  #1 doesn't seem bad, but I haven't th=
ought
> about it that hard.  Thanks,
>

So I started to test this patch, but I may be doing something very
terribly wrong
with this. Q: What is this something that is terribly wrong?

So far it did not explode, so let's at least see if that fixed the
reported issue:

#syz test: https://github.com/amir73il/linux fsnotify-fixes

Thanks,
Amir.

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2788df98080f8..a8822b44d4967 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3033,13 +3033,27 @@ static inline void file_start_write(struct file *fi=
le)
        if (!S_ISREG(file_inode(file)->i_mode))
                return;
        sb_start_write(file_inode(file)->i_sb);
+       /*
+        * Prevent fault-in user pages that may call HSM hooks with
+        * sb_writers held.
+        */
+       if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode)))
+               pagefault_disable();
 }

 static inline bool file_start_write_trylock(struct file *file)
 {
        if (!S_ISREG(file_inode(file)->i_mode))
                return true;
-       return sb_start_write_trylock(file_inode(file)->i_sb);
+       if (!sb_start_write_trylock(file_inode(file)->i_sb))
+               return false;
+       /*
+        * Prevent fault-in user pages that may call HSM hooks with
+        * sb_writers held.
+        */
+       if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode)))
+               pagefault_disable();
+       return true;
 }

 /**
@@ -3053,6 +3067,8 @@ static inline void file_end_write(struct file *file)
        if (!S_ISREG(file_inode(file)->i_mode))
                return;
        sb_end_write(file_inode(file)->i_sb);
+       if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode)))
+               pagefault_enable();
 }

