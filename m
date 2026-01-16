Return-Path: <linux-fsdevel+bounces-74064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8606D2DBE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 09:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF84D301F250
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 08:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF202EF652;
	Fri, 16 Jan 2026 08:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLOqPG2H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257DD2ED17C
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551030; cv=none; b=Vdjc4sJfJkdIJzAh5HehA5h7i4pHtoqCOYWXvHYMpvZtaNSUd9cSv1HipAg2Thxt/7AISQpY3ZmgWBrjcysI4F9cFAXUb3jK85vXWDiWfgx/RD7cIGstmXkzXsdZ3Xm3CjPDLGUfTIpDk6uFMEY9+Vek5BZel/LFdxhGEuQsRfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551030; c=relaxed/simple;
	bh=aKo59QMRyeKnvw5SJlWLghbk93QCvRX3XGOKo40RbwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FV9lQWsvl7LRUSCBUSlcuB7IRuKpxiEPk5xOIxwjKUsYrNukJ8C0bbtNjhO7cUsKvonpbe0P2IwnXYdoHeLn574xPXPKLY4drBBwxKW/4Ufz7JYzy+QR6jI2+5loyf4b0ugDrJCLf9fzyqzXpMKKnJcodugbC5i9oBpfNa+3KLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLOqPG2H; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-81db1530173so852897b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 00:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768551027; x=1769155827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aVD2PA0VPzWk4AcSwA45PBowoJqPxcFytHFYDGuhnQU=;
        b=PLOqPG2HmeXht6d50VwgDMTWw7pHCOthLe3KOWWyQSo5SrD5rJqiZPSOXmF81xuvsk
         Ojf6UJc9RMbTRiB2mpEkRkoDBI8Ui40WSJ4r6NlCPKAO6IwPjsfc5bw0r8f/M6+dHmIB
         mFSkek2y+nQh7Mv65TnDIsRnnN3t/pPZY96z31tdKZp0srDsXBfa/jLpFbPHAI9z8A8O
         10T6YcvfMAWjxyJLXDU8FfFnXQVZwYbmMeVI3Sa76fEGoUUcL+08QprLAMn+n4nbn15v
         N+xSn3b4Qt8ZaGEbe3QBB4/conCCX76P3QfOeitsKMvsA3zpVGaR0QJ24xU3c1X0HUcX
         olvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768551027; x=1769155827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVD2PA0VPzWk4AcSwA45PBowoJqPxcFytHFYDGuhnQU=;
        b=hxTEd4BPwkNlZzKlBCVJhLbgC9WI61FK6/amr7fJmaJyjW+wlGM3zSAwLBktU6fBCT
         bdVYT9dBbphzzXk8HZjw9Nm8TnqkJp81He4T8ZjMv7EhSAMpnVzaPkxyhxk4NmCxQUvs
         os/1G7+4vv8WN/cHxsBh0rz6yfTdDdDIQVkc39v0ERjRqgPfn21qRynL8q3Q5zd1d5C+
         xxUfhdcKv32CklRneLxwQhiw7LXI8h+PQK5l+Ln1k6kGQFEJ9sWDUuFqGSJ0mgqOLNQs
         yezvLvy6aOqEEnbXwvP2EGk8MsPR/GrGSTZ6ZiJXlGTNcRytvo6VkoRfnfhZqTYQfYRL
         wJYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX79hYBL/Or5bBP67M5/NphvmdxyNHcztjY7mLpuv5C0PuDMGc1zunjfuLrXCJA8Zfyp6lbwQo5ANrtiAa9@vger.kernel.org
X-Gm-Message-State: AOJu0YzS6sA65Kf9fD/62PVbRWDPkcQLFBMerJnowfusMc8/rPFjXu56
	avEFYsrPM49dkl9wmkGu8f5/5Z9i4rNZAwo8VO5IcVZMco3xfk5SbXcgQdytCg==
X-Gm-Gg: AY/fxX5HvQWnRKdiCCalWowCBcqjr/sqmeqdyLWH0FaGZloVVbXNl3qlPfb3fDoaQCY
	JHMjCBvqJ9g+XehTV8HddOtyf4HrkbAsYGIVqd0Q1cWvpGJAqaXEg/0fS3+TrHBShl7SBvOvS3y
	vaQl+64xBolYNDRUoM7lR50qpTop7SNU/obL+fsE5q7pSJiaoVDlJGAkqNdvm7Sjpd708LFxCfM
	qmEz/Nd9XAzXmliMW8brjPc1MGa5a/Sj8bj3DUNojz4aSgAnEG8JjKMagmpSBq1GOjC9HtxpDxp
	AAgOKPRBWhxfZ4T5nNt4pwHt6+drvguZnqvKp5V81v15K+ybVuC9L5p0ECAOgTe+Tgu7PRnHXak
	VSfWlQ+2W6a35guzvvoykF/ng0N2guIefiXFVxdERiuWg0UGGR5pKYU2dr1kUUXl2htHXXoCY2M
	+o6Y6GW8fU0vccvwH85LEUmmNqFajPvtqnNV56
X-Received: by 2002:a05:6a00:600b:b0:81f:46ba:1806 with SMTP id d2e1a72fcca58-81fa0337ce3mr2245295b3a.59.1768551027254;
        Fri, 16 Jan 2026 00:10:27 -0800 (PST)
Received: from localhost ([45.142.165.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1094bfasm1384123b3a.1.2026.01.16.00.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 00:10:25 -0800 (PST)
Date: Fri, 16 Jan 2026 16:10:21 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"syzbot+1e3ff4b07c16ca0f6fe2@syzkaller.appspotmail.com" <syzbot+1e3ff4b07c16ca0f6fe2@syzkaller.appspotmail.com>
Subject: Re: [RFC PATCH] fs/hfs: fix ABBA deadlock in hfs_mdb_commit
Message-ID: <aWnybRfDcsUAtsol@ndev>
References: <68b0240f.a00a0220.1337b0.0006.GAE@google.com>
 <20260113081952.2431735-1-wangjinchao600@gmail.com>
 <a2b8144a25206fba69e59e805d93c05444080132.camel@ibm.com>
 <aWcHhTiUrDppotRg@ndev>
 <d382b5c97a71d769598fd32bc22cae9f960fea70.camel@ibm.com>
 <aWhgNujuXujxSg3E@ndev>
 <b718505beca70f2a3c1e0e20c74e43ae558b29d5.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b718505beca70f2a3c1e0e20c74e43ae558b29d5.camel@ibm.com>

On Thu, Jan 15, 2026 at 09:12:49PM +0000, Viacheslav Dubeyko wrote:
> On Thu, 2026-01-15 at 11:34 +0800, Jinchao Wang wrote:
> > On Wed, Jan 14, 2026 at 07:29:45PM +0000, Viacheslav Dubeyko wrote:
> > > On Wed, 2026-01-14 at 11:03 +0800, Jinchao Wang wrote:
> > > > On Tue, Jan 13, 2026 at 08:52:45PM +0000, Viacheslav Dubeyko wrote:
> > > > > On Tue, 2026-01-13 at 16:19 +0800, Jinchao Wang wrote:
> > > > > > syzbot reported a hung task in hfs_mdb_commit where a deadlock occurs
> > > > > > between the MDB buffer lock and the folio lock.
> > > > > > 
> > > > > > The deadlock happens because hfs_mdb_commit() holds the mdb_bh
> > > > > > lock while calling sb_bread(), which attempts to acquire the lock
> > > > > > on the same folio.
> > > > > 
> > > > > I don't quite to follow to your logic. We have only one sb_bread() [1] in
> > > > > hfs_mdb_commit(). This read is trying to extract the volume bitmap. How is it
> > > > > possible that superblock and volume bitmap is located at the same folio? Are you
> > > > > sure? Which size of the folio do you imply here?
> > > > > 
> > > > > Also, it your logic is correct, then we never could be able to mount/unmount or
> > > > > run any operations on HFS volumes because of likewise deadlock. However, I can
> > > > > run xfstests on HFS volume.
> > > > > 
> > > > > [1] https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/hfs/mdb.c#L324    
> > > > 
> > > > Hi Viacheslav,
> > > > 
> > > > After reviewing your feedback, I realized that my previous RFC was not in
> > > > the correct format. It was not intended to be a final, merge-ready patch,
> > > > but rather a record of the analysis and trial fixes conducted so far.
> > > > I apologize for the confusion caused by my previous email.
> > > > 
> > > > The details are reorganized as follows:
> > > > 
> > > > - Observation
> > > > - Analysis
> > > > - Verification
> > > > - Conclusion
> > > > 
> > > > Observation
> > > > ============
> > > > 
> > > > Syzbot report: https://syzkaller.appspot.com/bug?extid=1e3ff4b07c16ca0f6fe2    
> > > > 
> > > > For this version:
> > > > > time             |  kernel    | Commit       | Syzkaller |
> > > > > 2025/12/20 17:03 | linux-next | cc3aa43b44bd | d6526ea3  |
> > > > 
> > > > Crash log: https://syzkaller.appspot.com/text?tag=CrashLog&x=12909b1a580000    
> > > > 
> > > > The report indicates hung tasks within the hfs context.
> > > > 
> > > > Analysis
> > > > ========
> > > > In the crash log, the lockdep information requires adjustment based on the call stack.
> > > > After adjustment, a deadlock is identified:
> > > > 
> > > > task syz.1.1902:8009
> > > > - held &disk->open_mutex
> > > > - held foio lock
> > > > - wait lock_buffer(bh)
> > > > Partial call trace:
> > > > ->blkdev_writepages()
> > > >         ->writeback_iter()
> > > >                 ->writeback_get_folio()
> > > >                         ->folio_lock(folio)
> > > >         ->block_write_full_folio()
> > > >                 __block_write_full_folio()
> > > >                         ->lock_buffer(bh)
> > > > 
> > > > task syz.0.1904:8010
> > > > - held &type->s_umount_key#66 down_read
> > > > - held lock_buffer(HFS_SB(sb)->mdb_bh);
> > > > - wait folio
> > > > Partial call trace:
> > > > hfs_mdb_commit
> > > >         ->lock_buffer(HFS_SB(sb)->mdb_bh);
> > > >         ->bh = sb_bread(sb, block);
> > > >                 ...->folio_lock(folio)
> > > > 
> > > > 
> > > > Other hung tasks are secondary effects of this deadlock. The issue
> > > > is reproducible in my local environment usuing the syz-reproducer.
> > > > 
> > > > Verification
> > > > ==============
> > > > 
> > > > Two patches are verified against the syz-reproducer.
> > > > Neither reproduce the deadlock.
> > > > 
> > > > Option 1: Removing `un/lock_buffer(HFS_SB(sb)->mdb_bh)`
> > > > ------------------------------------------------------
> > > > 
> > > > diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> > > > index 53f3fae60217..c641adb94e6f 100644
> > > > --- a/fs/hfs/mdb.c
> > > > +++ b/fs/hfs/mdb.c
> > > > @@ -268,7 +268,6 @@ void hfs_mdb_commit(struct super_block *sb)
> > > >         if (sb_rdonly(sb))
> > > >                 return;
> > > > 
> > > > -       lock_buffer(HFS_SB(sb)->mdb_bh);
> > > >         if (test_and_clear_bit(HFS_FLG_MDB_DIRTY, &HFS_SB(sb)->flags)) {
> > > >                 /* These parameters may have been modified, so write them back */
> > > >                 mdb->drLsMod = hfs_mtime();
> > > > @@ -340,7 +339,6 @@ void hfs_mdb_commit(struct super_block *sb)
> > > >                         size -= len;
> > > >                 }
> > > >         }
> > > > -       unlock_buffer(HFS_SB(sb)->mdb_bh);
> > > >  }
> > > > 
> > > > 
> > > > Options 2: Moving `unlock_buffer(HFS_SB(sb)->mdb_bh)`
> > > > --------------------------------------------------------
> > > > 
> > > > diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> > > > index 53f3fae60217..ec534c630c7e 100644
> > > > --- a/fs/hfs/mdb.c
> > > > +++ b/fs/hfs/mdb.c
> > > > @@ -309,6 +309,7 @@ void hfs_mdb_commit(struct super_block *sb)
> > > >                 sync_dirty_buffer(HFS_SB(sb)->alt_mdb_bh);
> > > >         }
> > > >  
> > > > +       unlock_buffer(HFS_SB(sb)->mdb_bh);
> > > >         if (test_and_clear_bit(HFS_FLG_BITMAP_DIRTY, &HFS_SB(sb)->flags)) {
> > > >                 struct buffer_head *bh;
> > > >                 sector_t block;
> > > > @@ -340,7 +341,6 @@ void hfs_mdb_commit(struct super_block *sb)
> > > >                         size -= len;
> > > >                 }
> > > >         }
> > > > -       unlock_buffer(HFS_SB(sb)->mdb_bh);
> > > >  }
> > > > 
> > > > Conclusion
> > > > ==========
> > > > 
> > > > The analysis and verification confirms that the hung tasks are caused by
> > > > the deadlock between `lock_buffer(HFS_SB(sb)->mdb_bh)` and `sb_bread(sb, block)`.
> > > 
> > > First of all, we need to answer this question: How is it
> > > possible that superblock and volume bitmap is located at the same folio or
> > > logical block? In normal case, the superblock and volume bitmap should not be
> > > located in the same logical block. It sounds to me that you have corrupted
> > > volume and this is why this logic [1] finally overlap with superblock location:
> > > 
> > > block = be16_to_cpu(HFS_SB(sb)->mdb->drVBMSt) + HFS_SB(sb)->part_start;
> > > off = (block << HFS_SECTOR_SIZE_BITS) & (sb->s_blocksize - 1);
> > > block >>= sb->s_blocksize_bits - HFS_SECTOR_SIZE_BITS;
> > > 
> > > I assume that superblock is corrupted and the mdb->drVBMSt [2] has incorrect
> > > metadata. As a result, we have this deadlock situation. The fix should be not
> > > here but we need to add some sanity check of mdb->drVBMSt somewhere in
> > > hfs_fill_super() workflow.
> > > 
> > > Could you please check my vision?
> > > 
> > > Thanks,
> > > Slava.
> > > 
> > > [1] https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/hfs/mdb.c#L318  
> > > [2]
> > > https://elixir.bootlin.com/linux/v6.19-rc5/source/include/linux/hfs_common.h#L196  
> > 
> > Hi Slava,
> > 
> > I have traced the values during the hang. Here are the values observed:
> > 
> > - MDB: blocknr=2
> > - Volume Bitmap (drVBMSt): 3
> > - s_blocksize: 512 bytes
> > 
> > This confirms a circular dependency between the folio lock and
> > the buffer lock. The writeback thread holds the 4KB folio lock and 
> > waits for the MDB buffer lock (block 2). Simultaneously, the HFS sync 
> > thread holds the MDB buffer lock and waits for the same folio lock 
> > to read the bitmap (block 3).
> > 
> > 
> > Since block 2 and block 3 share the same folio, this locking 
> > inversion occurs. I would appreciate your thoughts on whether 
> > hfs_fill_super() should validate drVBMSt to ensure the bitmap 
> > does not reside in the same folio as the MDB.
> 
> 
> As far as I can see, I can run xfstest on HFS volume (for example, generic/001
> has been finished successfully):
> 
> sudo ./check -g auto -E ./my_exclude.txt 
> FSTYP         -- hfs
> PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.19.0-rc1+ #56 SMP
> PREEMPT_DYNAMIC Thu Jan 15 12:55:22 PST 2026
> MKFS_OPTIONS  -- /dev/loop51
> MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch
> 
> generic/001 36s ...  36s
> 
> 2026-01-15T13:00:07.589868-08:00 hfsplus-testing-0001 kernel: run fstests
> generic/001 at 2026-01-15 13:00:07
> 2026-01-15T13:00:07.661605-08:00 hfsplus-testing-0001 systemd[1]: Started
> fstests-generic-001.scope - /usr/bin/bash -c "test -w /proc/self/oom_score_adj
> && echo 250 > /proc/self/oom_score_adj; exec ./tests/generic/001".
> 2026-01-15T13:00:13.355795-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():296 HFS_SB(sb)->mdb_bh buffer has been locked
> 2026-01-15T13:00:13.355809-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():348 drVBMSt 3, part_start 0, off 0, block 3, size 8167
> 2026-01-15T13:00:13.355810-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.355810-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.355811-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.355812-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.355812-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.355812-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.355813-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.355813-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.355813-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.355814-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.355814-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.355815-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.355815-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.355815-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.355816-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.355816-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.355816-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.355816-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.355817-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.355818-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.355818-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.355818-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.355819-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.355819-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.355819-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.355819-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.355820-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.355820-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.355821-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.355821-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.355821-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.355822-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.355822-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():383 HFS_SB(sb)->mdb_bh buffer has been unlocked
> 2026-01-15T13:00:13.681527-08:00 hfsplus-testing-0001 systemd[1]: fstests-
> generic-001.scope: Deactivated successfully.
> 2026-01-15T13:00:13.681597-08:00 hfsplus-testing-0001 systemd[1]: fstests-
> generic-001.scope: Consumed 5.928s CPU time.
> 2026-01-15T13:00:13.714928-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():296 HFS_SB(sb)->mdb_bh buffer has been locked
> 2026-01-15T13:00:13.714942-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():348 drVBMSt 3, part_start 0, off 0, block 3, size 8167
> 2026-01-15T13:00:13.714943-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.714944-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.714944-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.714944-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.714945-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.714945-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.714946-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.714946-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.714947-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.714947-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.714947-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.714948-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.714948-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.714948-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.714949-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.714949-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.714950-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.714950-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.714950-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.714951-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.714951-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.714952-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.714952-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.714952-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.714953-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.714953-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.714953-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.714954-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.714954-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.714955-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.714955-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():356 start read volume bitmap block
> 2026-01-15T13:00:13.714955-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():370 volume bitmap block has been read and copied
> 2026-01-15T13:00:13.714956-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():383 HFS_SB(sb)->mdb_bh buffer has been unlocked
> 2026-01-15T13:00:13.716742-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():296 HFS_SB(sb)->mdb_bh buffer has been locked
> 2026-01-15T13:00:13.716754-08:00 hfsplus-testing-0001 kernel: hfs:
> hfs_mdb_commit():383 HFS_SB(sb)->mdb_bh buffer has been unlocked
> 2026-01-15T13:00:13.722184-08:00 hfsplus-testing-0001 systemd[1]: mnt-
> test.mount: Deactivated successfully.
> 
> And I don't see any issues with locking into the added debug output. I don't see
> the reproduction of reported deadlock. And the logic of hfs_mdb_commit() correct
> enough.
> 
> The main question is: how blkdev_writepages() can collide with hfs_mdb_commit()?
> I assume that blkdev_writepages() is trying to flush the user data. So, what is
> the problem here? Is it allocation issue? Does it mean that some file was not
> properly allocated? Or does it mean that superblock commit somehow collided with
> user data flush? But how does it possible? Which particular workload could have
> such issue?
> 
> Currently, your analysis doesn't show what problem is and how it is happened. 
> 
> Thanks,
> Slava.

Hi Slava,

Thank you very much for your feedback and for taking the time to 
review this. I apologize if my previous analysis was not clear 
enough. As I am relatively new to this area, I truly appreciate 
your patience.

After further tracing, I would like to share more details on how the 
collision between blkdev_writepages() and hfs_mdb_commit() occurs. 
It appears to be a timing-specific race condition.

1. Physical Overlap (The "How"):
In my environment, the HFS block size is 512B and the MDB is located 
at block 2 (offset 1024). Since 1024 < 4096, the MDB resides 
within the block device's first folio (index 0). 
Consequently, both the filesystem layer (via mdb_bh) and the block 
layer (via bdev mapping) operate on the exact same folio at index 0.

2. The Race Window (The "Why"):
The collision is triggered by the global nature of ksys_sync(). In 
a system with multiple mounted devices, there is a significant time 
gap between Stage 1 (iterate_supers) and Stage 2 (sync_bdevs). This 
window allows a concurrent task to dirty the MDB folio after one 
sync task has already passed its FS-sync stage.

3. Proposed Reproduction Timeline:
- Task A: Starts ksys_sync() and finishes iterate_supers() 
  for the HFS device. It then moves on to sync other devices.
- Task B: Creates a new file on HFS, then starts its 
  own ksys_sync().
- Task B: Enters hfs_mdb_commit(), calls lock_buffer(mdb_bh) and 
  mark_buffer_dirty(mdb_bh). This makes folio 0 dirty.
- Task A: Finally reaches sync_bdevs() for the HFS device. It sees 
  folio 0 is dirty, calls folio_lock(folio), and then attempts 
  to lock_buffer(mdb_bh) for I/O.
- Task A: Blocks waiting for mdb_bh lock (held by Task B).
- Task B: Continues hfs_mdb_commit() -> sb_bread(), which attempts 
  to lock folio 0 (held by Task A).

This results in an AB-BA deadlock between the Folio Lock and the 
Buffer Lock.

I hope this clarifies why the collision is possible even though 
hfs_mdb_commit() seems correct in isolation. It is the concurrent 
interleaving of FS-level and BDEV-level syncs that triggers the 
violation of the Folio -> Buffer locking order.

I would be very grateful for your thoughts on this updated analysis.

Best regards,
Jinchao

