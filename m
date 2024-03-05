Return-Path: <linux-fsdevel+bounces-13657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B1F872878
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 21:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52936B25896
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 20:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CCE128817;
	Tue,  5 Mar 2024 20:21:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B0D127B70
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 20:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670065; cv=none; b=hdJzA495eoR23ZxNoI7GA5QFC+5RghwLIABRKxaiTOvld0FdGBs4Ndbv4feUFDBnYmUWlheI7Va79wKdS4oMMrjzfWUxoN7oeoeTisALT6fpuK7n7Wp56/B0eBT4trTp7ir6XgyVF2dHmOTulDT23LcmAGYNICMQ2xFNgZG10ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670065; c=relaxed/simple;
	bh=6/AYUfzDqzkrxKkZjplJh9OD3V2IdKBUYScD8zp5YJg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=V/iCzzHiUmzFlRlSHViWJOY73J0RnOheFfQ2yzHzbO4lXGyK23OJeTNJNHUfWb4cNCp9jvMqdeB2TpUGt3z3Pbpa7IpsenqGKD1ZtQ2o/BHA4arkPidbxmTJVNRjEOrEZChWa42j0Erz/sbeChwUwr0OcPj91pzaY6QiDq/s0/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36516d55c5fso70132675ab.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 12:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709670062; x=1710274862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUtUYHZsCEOa7X6Z+H+o0TaVUl7jsvxTuXTfFKtx4Og=;
        b=lkBtWmRcjJ+mv+g3PG9iaefrCMi7IbAplbDAjF9jgKRqTr91Ix/4I0GBBJithe1ets
         hdyb/WHAjxP4BKR/Z6r2t2r7QWy39fdrY7HouZkDSav2QNLmixVcTgpEPK8geo1KNBvc
         y4HAj4936cLubLy/1OvFa2i/5ACM+HykiUtmYnNsEFHCTai55Vs4+vPyJahtb46HLlaA
         js9sdeYLiM1WQu39aMr3AosBQzyxJJlxmr4E8mz0vSW5TW7pjPvAq+ENmaA00q3tTkMM
         OJ5+LkDts5rHmqhYtu+0KFbVMdryg8PeLPeiedH1ZDjPWIH5fJCpjkdsAJ69KwIOdQnV
         SRrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLdbqzAcKSY3HK6HvJDVktGsgJxj3mbb2RL42eieMRbqWdXHzk6jn7nh6H4n2gBMnuxHVr/bz7DIE7WH+aETzOCvuUnDYpojWZVPeNYw==
X-Gm-Message-State: AOJu0YzyKUlfG1bcz1EgAkgjiAeqSt9zjv3tZZWUa6ncjHP8ZXFY9ofQ
	Ve7rMavF9Q0Z09ZgubtK9CEJ7rbZQgjVzh+eD9/4O3zTBOsdrJT78CDrmDmOhPdIwJRcqdKcKPe
	BAEr/njKlKbAJrRGBDtoea/Sek3uklQLJoajAvx6BLwla4CCkg4eDRI0=
X-Google-Smtp-Source: AGHT+IG0HrTjf9tSzpW5mhEYahI6I+CdKvynp0WSCF6pQbzs6aTIrDo95uQZixM6D1ufLCf+gnTifAlBvx8apq0D07TCgFJ6wpLj
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:6f0b:0:b0:365:fe09:6450 with SMTP id
 k11-20020a926f0b000000b00365fe096450mr104480ilc.4.1709670062725; Tue, 05 Mar
 2024 12:21:02 -0800 (PST)
Date: Tue, 05 Mar 2024 12:21:02 -0800
In-Reply-To: <0000000000000424f205fcf9a132@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5b2ae0612ef94a9@google.com>
Subject: Re: [syzbot] [ntfs3?] UBSAN: shift-out-of-bounds in ntfs_iget
From: syzbot <syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, anton@tuxera.com, 
	axboe@kernel.dk, brauner@kernel.org, ghandatmanas@gmail.com, 
	gregkh@linuxfoundation.org, jack@suse.cz, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, 
	lkp@intel.com, llvm@lists.linux.dev, ntfs3@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12be09f2180000
start commit:   afead42fdfca Merge tag 'perf-tools-fixes-for-v6.4-2-2023-0..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=162cf2103e4a7453
dashboard link: https://syzkaller.appspot.com/bug?extid=4768a8f039aa677897d0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12da9bbd280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174e8115280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

