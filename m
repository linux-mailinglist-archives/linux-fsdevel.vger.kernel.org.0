Return-Path: <linux-fsdevel+bounces-4703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EAD80213A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Dec 2023 07:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8303B20A7A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Dec 2023 06:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A978F77
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Dec 2023 06:30:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784CEFA
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Dec 2023 21:25:05 -0800 (PST)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b8b5221627so1008944b6e.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Dec 2023 21:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701581104; x=1702185904;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gh8kA0wvcEudJg4sTCzviSk9gPRZ58CLaMI+8dOTqeg=;
        b=K7uNObVXuNKFHxWTD4kHQWi4gHeludiBWnkfrX99vIiI5dtSQ8hw875Qrw87ZkC1c8
         uDX31DkfmF57Ap7sIItOGItJF4Nbm7wfecPABetCe+o1JMgR24DHeYIlcAxcZaINI7Ux
         j4mGpwIxmpi4RYuvj1IwNmr0Fb7LK+06SItBkRqxtmhHdGFqS96HetqVfQCi9I7rFwvh
         YCLQHUXlZVAfvTvuFhl/TrP4AunvetS+dCCbu86wipiunE412H8H9cUuVVgzvbLD6BdB
         tW4TRLVm0ECfh22nu5upiKjGOV3g76oyV0ivlU2+f6383Z0bi4RNtTWbsaOks0IZ/T+5
         lIbg==
X-Gm-Message-State: AOJu0YzK4mQS4OEdoMSeokfMwbC5/UtsqkLRlg5kd8eL8UYlZMbdiJcl
	1GD7WPq3C8kOJwgSLYE2mrKcjrL58APFgwIZXZVNeMHsBBYV
X-Google-Smtp-Source: AGHT+IEDkTe1NFy8Y5QzTTM+crOH53QnZSWciCcsTjwYdrTuB7mIO4LDXoZqEvhZEj1GGk+/ZWWcmX0wDRoOmUA5vaOGR++lr6JE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:344:b0:3ae:61f:335e with SMTP id
 j4-20020a056808034400b003ae061f335emr1111285oie.5.1701581104799; Sat, 02 Dec
 2023 21:25:04 -0800 (PST)
Date: Sat, 02 Dec 2023 21:25:04 -0800
In-Reply-To: <000000000000f841fb05eb364ce6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ee8c3060b943920@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in txCommit
From: syzbot <syzbot+0558d19c373e44da3c18@syzkaller.appspotmail.com>
To: brauner@kernel.org, dave.kleikamp@oracle.com, ghandatmanas@gmail.com, 
	jack@suse.cz, jfs-discussion@lists.sourceforge.net, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	linux-kernel@vger.kernel.org, liushixin2@huawei.com, mirimmad17@gmail.com, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a779ed754e52d582b8c0e17959df063108bd0656
Author: Dave Kleikamp <dave.kleikamp@oracle.com>
Date:   Thu Oct 5 14:16:14 2023 +0000

    jfs: define xtree root and page independently

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14f67ce2e80000
start commit:   d88520ad73b7 Merge tag 'pull-nfsd-fix' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ee601744db6e780
dashboard link: https://syzkaller.appspot.com/bug?extid=0558d19c373e44da3c18
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e974ed680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b2588b680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: jfs: define xtree root and page independently

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

