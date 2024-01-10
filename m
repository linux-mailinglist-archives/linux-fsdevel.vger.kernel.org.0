Return-Path: <linux-fsdevel+bounces-7678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC6382931B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 05:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6F8289269
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 04:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A76D512;
	Wed, 10 Jan 2024 04:52:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AACC6FB1
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 04:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bef6895f94so9100539f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jan 2024 20:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704862324; x=1705467124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x936MVynPSqzvoZrst1AzDJ72ez9E+22/8OyqN1nYYA=;
        b=Ul+MNti2O540D5evro3Qv4VLu2ZDSPtZGvGDeluFZ/uCOhBDi1oiE/aFhIt54u3MbE
         +QCZfyzowTyjH+YCAnUeDIDK4hlZZrguoy+h90ImbjzpI6B1xlw/i/a6OwunierJuw9V
         GWQfRwDJcdZsZBI98dwRZGYQFNTb0Y2RC8csyYDmSB3wTMIAOglXeUMusyKPVUwS2di7
         Na2tPOQ0Rc378dNCI3nen6GmyfaPu9KQyVyy1c1NojnS10G8n+9bZPs8IX98ZCY/PGkk
         c+MCfAWDr66k2NyCyfRR7O2u8IRMX92hpdw19yGAXAt9PLfDV4aL5VcGRFxfZFG+m2DP
         4OWw==
X-Gm-Message-State: AOJu0YzOWiW9s/PZOVI0nEzOYb6wb4+ZyWXWkSn/hM5imWAkn/ECrQF0
	UVdhcH18uayqVTkanCYHWKlkmLu2QLg8Aka948Y6SQ/xAQ0I
X-Google-Smtp-Source: AGHT+IHYbFb/OECz75DeG4E5fovu1SDI9wSD2or30Ds/3l2B+ns/ARh+06LhIoCTpkxZIZK4NuTofbUw5IWphq42AEDONOTC8Pbm
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1926:b0:46e:4815:3ed3 with SMTP id
 p38-20020a056638192600b0046e48153ed3mr3888jal.2.1704862323550; Tue, 09 Jan
 2024 20:52:03 -0800 (PST)
Date: Tue, 09 Jan 2024 20:52:03 -0800
In-Reply-To: <0000000000008023b805ff38a0af@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002fb443060e903163@google.com>
Subject: Re: [syzbot] [reiserfs?] general protection fault in
 __hrtimer_run_queues (3)
From: syzbot <syzbot+f13a9546e229c1a6e378@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1730f285e80000
start commit:   e8f75c0270d9 Merge tag 'x86_sgx_for_v6.5' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a98ec7f738e43bd4
dashboard link: https://syzkaller.appspot.com/bug?extid=f13a9546e229c1a6e378
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1227af7b280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13803daf280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

