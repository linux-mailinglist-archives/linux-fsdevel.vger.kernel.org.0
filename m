Return-Path: <linux-fsdevel+bounces-8696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91D383A782
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBD0CB2284A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 11:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E711AAD7;
	Wed, 24 Jan 2024 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="FZOP5ifo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505351A702
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706094517; cv=none; b=bwLCBzAjxrr5jiBvjXxARJ+tpBlpcezAZ+h//4gAGw8GJYKM6eHNhIdPa6OygFdJ1Qfr1KSavaWoyGGRC9Pjgl0o6X4OrOi4cw0z/pMZDPu3ifFZ7TmOPcYx6/3atwsP6Lp1BR8yiH56Q4QLGGLROcKm3PNncKf3Y5naidwM+Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706094517; c=relaxed/simple;
	bh=vGrX/rFRy2nIfvHaeaOI0cJDKuGKhHtLFsgdEgBb4Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMGUMvJaRLeR104aoEfzjycHfeg0QiGlzH/sL6iOaNNeIvsCZ6av7Ir4aK80zuOCVYMlMWfap8qDyJGOXF4drpVG34Qpxh4sK3s3tTpPc+HSaFk81ARprHT1d3fO++8gMNqVHi03+3ouIQsdaUBUQTu8JS6am7++xQlEdVreluE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=FZOP5ifo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d74678df08so18940675ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 03:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1706094513; x=1706699313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Rk8fcu6A6NHTsGijWS+PcKuTxBzRD/BNnHc/f3Adl0=;
        b=FZOP5ifoGe4paLeHI9+JJ02Ce4I6I+r0dGdRTa7N0cqje2CUNM/a6K+mbPMVI/DHnV
         uX4Au/hk3SePOnhUh4KVTQb6kvWE+zC3A0nDxH5pF/KPh6XY2HnwiazRr4fsTtPet96u
         hmEz7ROGMgZhwjCbCbnUChgyOflILl8sPKvi8r854Wf85bwm0cvmHZkTgFzPMR2RbKeY
         ixTbO0/uZWUS3sqYcO04DPcCrdBzoq/ZcdVpJL2XbIoSBM6Ch8GGQ4j80B73H1tAqcpg
         209dDXDpLYlV2iXzApDhFFgwOOgWueNWqC0qS3ERQRWJR+xZR+neeWp9i6YoaJeMSQcV
         PZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706094513; x=1706699313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Rk8fcu6A6NHTsGijWS+PcKuTxBzRD/BNnHc/f3Adl0=;
        b=M1Bg6O9kfjfmWBzp72+OuDPaS/kGeJh5H6lBgyOgVvr3hfvd+QcZy1jYyvljcrL5rL
         lSK3iia3e9Dhq5fB1v0cJhTAgT0GqodXYL5eRhRoOQnQPGSSH1jTu2/+rH2lmMS+UhEr
         hh8hqcDBbHqgBVvBEuea92TtUT8sq/Gukzt21F2I+DlnQRUXBKISdanICA73ztrxdLhP
         9LmSTZf28vntY3ck8C/1gUkkXkcx2uifYkFjtZmAPAmZCjFRmKp8S1LITxHevCkUNVhF
         Gy6FPm2pOxQA+K+CPgoRrXP+ybtEHuBcwsdNA3vwCrU7FJ716qqVHXsoOZ7rSzaXdGua
         Rd7A==
X-Gm-Message-State: AOJu0Yx8Ouz9n29NlhQxXGJnZ5/fxzuqnQ8yjRAgOYmNNmQ7cJ9Q+eTu
	JJOTeParHFV9xkJWsPHG8odw0hAroiHH8SJwFzHve+epQcn8/YVFj5FyYql//Xg=
X-Google-Smtp-Source: AGHT+IEl+c3kyXnbW9duvQUC0q/nmMh2wLOUu9SraYa+z6FazMmQA1r4yPdQ6y4yjrmk4rQYMTc0aA==
X-Received: by 2002:a17:902:b409:b0:1d6:f1d5:e7ba with SMTP id x9-20020a170902b40900b001d6f1d5e7bamr499836plr.120.1706094513506;
        Wed, 24 Jan 2024 03:08:33 -0800 (PST)
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902b20400b001d6eed31a1bsm8021118plr.245.2024.01.24.03.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 03:08:32 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rSb7N-00Ed7G-1y;
	Wed, 24 Jan 2024 22:08:29 +1100
Date: Wed, 24 Jan 2024 22:08:29 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: syzbot <syzbot+87466712bb342796810a@syzkaller.appspotmail.com>,
	axboe@kernel.dk, brauner@kernel.org, chandan.babu@oracle.com,
	dchinner@redhat.com, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] KASAN: null-ptr-deref Write in
 xfs_filestream_select_ag
Message-ID: <ZbDvrQj6KLNSSy9/@dread.disaster.area>
References: <000000000000d207ef05f7790759@google.com>
 <00000000000084a9da060fad26bf@google.com>
 <20240124100120.x3mwjbj7epfw3ffo@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124100120.x3mwjbj7epfw3ffo@quack3>

On Wed, Jan 24, 2024 at 11:01:20AM +0100, Jan Kara wrote:
> On Wed 24-01-24 00:50:10, syzbot wrote:
> > syzbot suspects this issue was fixed by commit:
> > 
> > commit 6f861765464f43a71462d52026fbddfc858239a5
> > Author: Jan Kara <jack@suse.cz>
> > Date:   Wed Nov 1 17:43:10 2023 +0000
> > 
> >     fs: Block writes to mounted block devices
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=119af36be80000
> > start commit:   17214b70a159 Merge tag 'fsverity-for-linus' of git://git.k..
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d40f6d44826f6cf7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=87466712bb342796810a
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1492946ac80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e45ad6c80000
> 
> So this surprises me a bit because XFS isn't using block device buffer
> cache and thus syzbot has no way of corrupting cached metadata even before
> these changes. The reproducer tries to mount the loop device again after
> mounting the XFS image so I can imagine something bad happens but it isn't
> all that clear what. So I'll defer to XFS maintainers whether they want to
> mark this bug as fixed or investigate further.

I've consistently ignored this bug because it is doing stuff with
corrupted V4 XFS filesystems.

The key part of the strace is as follows. /dev/loop0 has been set up
to point to a memfd that maps the reproducer's internal memory. Then
we see:

....
[   50.859261][ T5070] XFS (loop0): Deprecated V4 format (crc=0) will not be supported after September 2030.
[   50.869976][ T5070] XFS (loop0): Mounting V4 Filesystem 5e6273b8-2167-42bb-911b-418aa14a1261
[pid  5070] mount("/dev/loop0", "./file0", "xfs", 0, "filestreams,swidth=0x0000000000000000,nodiscard,logbufs=00000000000000000006,attr2,,nouuid") = 0
[pid  5070] openat(AT_FDCWD, "./file0", O_RDONLY|O_DIRECTORY) = 3
[pid  5070] chdir("./file0")            = 0
[pid  5070] ioctl(4, LOOP_CLR_FD)       = 0
[pid  5070] close(4)                    = 0
[pid  5070] open("./bus", O_RDWR|O_CREAT|O_TRUNC|O_NONBLOCK|O_SYNC|O_DIRECT|O_LARGEFILE|O_NOATIME, 000) = 4
[pid  5070] mount("/dev/loop0", "./bus", NULL, MS_BIND, NULL) = 0
[pid  5070] open("./bus", O_RDWR|O_NOCTTY|O_SYNC|O_NOATIME|0x3c) = 5
[pid  5070] openat(AT_FDCWD, "memory.current", O_RDWR|O_CREAT|O_NOCTTY|O_TRUNC|O_APPEND|FASYNC|0x18, 000) = 6

And then there's a corruption report and then the KASAN error.

AFAICT, what the reproducer is doing is setting internal memory as
backing device for /dev/loop0, then mounting it, then creating a
file in that XFS filesystem, then doing a bind mount of /dev/loop0
to that file, then opening that file again (which now points to
/dev/loop0) and overwriting it.

As XFS writes back the data to the file, it's actually overwriting
the loop device backing file. i.e. scribbling over the internal
memory of the syzkaller program. The filesystem then goes to read
metadata from the filesystem, and gets back metadata containing:

[   52.672334][ T4733] 00000000: 66 69 6c 65 73 74 72 65 61 6d 73 2c 73 77 69 64  filestreams,swid
[   52.681652][ T4733] 00000010: 74 68 3d 30 78 30 30 30 30 30 30 30 30 30 30 30  th=0x00000000000
[   52.690810][ T4733] 00000020: 30 30 30 30 30 2c 6e 6f 64 69 73 63 61 72 64 2c  00000,nodiscard,
[   52.700296][ T4733] 00000030: 6c 6f 67 62 75 66 73 3d 30 30 30 30 30 30 30 30  logbufs=00000000
[   52.709453][ T4733] 00000040: 30 30 30 30 30 30 30 30 30 30 30 36 2c 61 74 74  000000000006,att
[   52.718572][ T4733] 00000050: 72 32 2c 00 47 ba 76 39 f2 50 ff 99 2f fb b8 b1  r2,.G.v9.P../...
[   52.728140][ T4733] 00000060: 4c 3a 9b c2 e1 81 d0 9c 24 97 6b 33 7f 55 f4 90  L:......$.k3.U..
[   52.737174][ T4733] 00000070: 15 4c b3 65 d3 52 86 f0 51 c3 11 75 df a1 cc f1  .L.e.R..Q..u....

The mount options used to mount the filesystem in the first place.

I'd suggest that ithe commit the bisect landed on is blocking the
second open of "./bus" after it was bind mounted to /dev/loop0 and
so the write that corrupts the filesystem image never occurs, and so
the XFS filesystem never trips over that error and hence never
triggers the KASAN warning.

So, yeah, I can see why syzbot might think that commit fixed the
problem. But it didn't - it just broke the reproducer so the
corruption that triggered the problem never manifested...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

