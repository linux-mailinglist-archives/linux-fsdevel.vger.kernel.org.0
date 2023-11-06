Return-Path: <linux-fsdevel+bounces-2048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B307E1C5D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 09:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E07A2813A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 08:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6F4320E;
	Mon,  6 Nov 2023 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A178128E6
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 08:34:10 +0000 (UTC)
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524A613E
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 00:34:08 -0800 (PST)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b5019515c4so6172528b6e.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 00:34:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699259647; x=1699864447;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R//xFC6MCX07YnTjEGgkyVytVcMHK0VcX9I6eFXmSn0=;
        b=j7jPSRsUO1Cj1xO7cjl1ketSql3Eaz5K0JF+UU8uoXDAXfwOBFh56qcFF07Qy3totw
         SuYu3M/VMmjO2f5L17YYFCiZ7ihCeVpYd6MikOkhPA05DovjAIvVyjky2VpqfUzbFclp
         AaoFXL/lSoLvo7nMRiiXsxf0TYnm8WN6RT0Ta2OXQwrjRAM2OY9GevQ3V8Q9Y8A6OOPL
         JoYBuYztqCldbh2oGkBgGBn2raPxWQDUxBRyjnh8hy3030CfGZ4BEHbZKN+8EP9wgLdb
         QWopeTHe6h0Zq4zdZ8GGkZBKaaErvw3DAHxaM7T2thJxcVHAX68dgxMj62iGNWfouuh9
         ALqg==
X-Gm-Message-State: AOJu0YzT3j7grI2usjZJzmRB8uDgH3rR3xg3X5PTe4q5PSqCNCNluz+6
	4uuMQP8Y3Z5P/ckNM+kd/CKGc4G2MtstdTXDAjpt05fzFhfr
X-Google-Smtp-Source: AGHT+IGPvdUMp7cFbFWrKJV9OVBnXNdZFxJ2Ar/n96qlK/oegdaqwZk7Cnt4qpgL2n4nuLJ0ela54eQb73j/dM3UYdnpHggAwsHn
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:aca:1113:0:b0:3a3:c492:9be6 with SMTP id
 19-20020aca1113000000b003a3c4929be6mr3745348oir.2.1699259647315; Mon, 06 Nov
 2023 00:34:07 -0800 (PST)
Date: Mon, 06 Nov 2023 00:34:07 -0800
In-Reply-To: <000000000000cfe6f305ee84ff1f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8d8e7060977b741@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in reiserfs_dirty_inode
From: syzbot <syzbot+c319bb5b1014113a92cf@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul@paul-moore.com, 
	reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com, 
	syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d82dcd9e21b77d338dc4875f3d4111f0db314a7c
Author: Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri Mar 31 12:32:18 2023 +0000

    reiserfs: Add security prefix to xattr name in reiserfs_security_write()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14d0b787680000
start commit:   90b0c2b2edd1 Merge tag 'pinctrl-v6.7-1' of git://git.kerne..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16d0b787680000
console output: https://syzkaller.appspot.com/x/log.txt?x=12d0b787680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=93ac5233c138249e
dashboard link: https://syzkaller.appspot.com/bug?extid=c319bb5b1014113a92cf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113f3717680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154985ef680000

Reported-by: syzbot+c319bb5b1014113a92cf@syzkaller.appspotmail.com
Fixes: d82dcd9e21b7 ("reiserfs: Add security prefix to xattr name in reiserfs_security_write()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

