Return-Path: <linux-fsdevel+bounces-8686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DAE83A48C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 09:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3020A284AD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 08:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FDD179BC;
	Wed, 24 Jan 2024 08:50:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC52179A6
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086212; cv=none; b=gI0iTYEp/s4+B60JFiF+eYjbXknAcQwQGoKM+2K+3ZW7n0dXoiy8VCMDPeyLwQCNCMEbv38KGTPhDLFnYKh/QanT1aM5T7bJPQdj+3qqxGJjT5JkKxfH/+DdGlkFNKO35R8TuPbdzXV9E6Hr80uI9sqAs/nhepN9zC5dDTojCHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086212; c=relaxed/simple;
	bh=5SRGXfUtzcx4CHNTX1CcNoOlAEBV5500++BZdb1Q86k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YUMjg9U9HVFZwpF6T1aAit+JCv8TYcQIm9npxri9AdpX9n88f1TUF0TLKu/2N773jB04404bJmtolCYSdp5lyp0Cn1JomGeDIyW+RTjUw7YKBv26X7hkJr1y/LroTtWKq43EaRb8EJBeOj8uOYxXE2m0yOgGZLb2TBwENsqeuZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-361a800f629so42995585ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 00:50:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706086210; x=1706691010;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRSbUiiNcXaQ+lmznn7ZLwAAFNsMsOx+iXxoA2C4u2k=;
        b=dzSWID9yL6ik3Q7LlAPsgE8tyPtXgH55HielEUJJc/3iF2onmWgQPVp5UQKSxIEPQy
         wD8xZvINBM48+VmMIl2v/uYLervdThQQIBeag6ulaTKJYAP/4SvBnAYNJz9ZFslm6KC9
         4SuvYtuAXoYhSGSIc0XeAjkiiJ+LKKSZrx/jqSqiv6W9qJ/j04e0Ar2n5LQ4CiqD2MxO
         odl2t4fs3mqJ7yFd5840eb7Vm88+yMmivZnxKPHJd/tmMXVocu4Ow/dNE4aV6B1gg6l+
         agleEqh9BCV1OWMYaMy29+by3feQY2lr/qgPXiRg12dcG9M0EU7ec2VuTAvCbcBmzVKy
         i5jQ==
X-Gm-Message-State: AOJu0Yw7U9zbMZ7NxV2svt3dVtl6sS9zbIOB9xbgDq5JRiO05VfI4ofp
	t3pbNOm0Y8MkyL61KhcvsbRCOdFsMcM96R+32vV4eiAVyk2BtdT/Eo8kYOsl4XXFnb3ndg1mAq1
	907rzPHPPhVrYxyUUVR34n+iqQyIn/F5WRnV+SJmhP+AobIGGv30a01o=
X-Google-Smtp-Source: AGHT+IGmS5JwVqumT9uCpn/1NCTHaiv9XrPDAljw1ESdj/EbdOddxKHG86bIuSNbGY3kyp3Yv089DYfxmtQvC/kJ6C1mPCi85Rjz
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3202:b0:360:96fd:f542 with SMTP id
 cd2-20020a056e02320200b0036096fdf542mr150429ilb.1.1706086210249; Wed, 24 Jan
 2024 00:50:10 -0800 (PST)
Date: Wed, 24 Jan 2024 00:50:10 -0800
In-Reply-To: <000000000000d207ef05f7790759@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084a9da060fad26bf@google.com>
Subject: Re: [syzbot] [xfs?] KASAN: null-ptr-deref Write in xfs_filestream_select_ag
From: syzbot <syzbot+87466712bb342796810a@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, chandan.babu@oracle.com, 
	dchinner@redhat.com, djwong@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=119af36be80000
start commit:   17214b70a159 Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d40f6d44826f6cf7
dashboard link: https://syzkaller.appspot.com/bug?extid=87466712bb342796810a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1492946ac80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e45ad6c80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

