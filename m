Return-Path: <linux-fsdevel+bounces-29816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 826E097E4EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 05:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48104281617
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 03:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C32748F;
	Mon, 23 Sep 2024 03:12:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB4A139D
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 03:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727061126; cv=none; b=j4DG0yi8HRJg2NnBAFzJvvSc5wO5muUmYIM6nDdmUvQoIOMbg1jiR04FX9Fn8Yezo5uQp/N/N2Z6hP9x5UH9iCNwpVS/uQG4Nyr7w+79GvazfkadT+Ic6aS3bZPQzLjY9iXAvXUw9cO3ywxNswtXw55D+PqWhGY5LFcil0eb5w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727061126; c=relaxed/simple;
	bh=UiDk7CchyH/rlVjD+AjlwAsTaELukHkNHA5+eG3bIno=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Fo5jj/f6An1mqvWLBx2EChHCAD/uLFhiQoEJE+ug/tNHY5w8nft9uKtWIMhUF0SWrigKceFTSZ96c00dk+J334EoIM75385FmdwKkZm0eEHavsEvHxgiRAzaX7PFVTKuPtYa27cpeRwUb1eo38JoEwNs1CD5rcxYxEd/6r5uHnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82cf30e0092so397475039f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Sep 2024 20:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727061124; x=1727665924;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMUXi0RdmLy+WqjnhOSGYPK9NupKpP4dbWbiPd/HDSk=;
        b=TEjhCYNhqwqjrX5uvNu1lQWIw3nsnHobYCUE4ir56Yt4DnMzIVC1IMvruC85v5LT15
         NHJUwytrRWOjk1O8LpMQwQgkIAwpnI4t7h60bKVOw/fR0fg8n2pZtNMjNyvOPXGBfGY6
         bv1AKQhMB05Ppt8sG40WEyA9ziF34rHkteYS2Jvt+qaGYsTLQxl1DrHIS9HtPTBDyaTW
         VAmYsabA+iGEn9V88LtEqPlZgYKiU1d9DlG1rjICFeLNhvI+/7SSiUygeWPilEdzU9eV
         EjQoYFF0nbklz9T4qynTG921V4WxfhdW1FgfW+eyQFtMtdxY8JMRlRXKI22LBIkgSVTd
         X8yA==
X-Forwarded-Encrypted: i=1; AJvYcCVhFAnzJBnGNYcp4GB9t7H7TN5/U4aQGsa7MtKqz8KMFPquYixRBcDNC2whqvFkI+8QbOqWs8qaMvuCdqet@vger.kernel.org
X-Gm-Message-State: AOJu0YyUTUidF+zVjMQgAmU1plh7K7kZ/SRb0DWiTO+YzrBzxGqne2PL
	8Wc6nMuYPxB3xsafr8oI3Eey9VQz9ixDH+RgrkIVVlkgkpCMvFOl5XAH60vTQkQIM/UsJU6QEII
	MJWawxikZJlVFQsMiuhwMQXbdir+v7mjB+1EUBRl3TLF2L3p7PULb3Ws=
X-Google-Smtp-Source: AGHT+IGCL90H8XWrGrH2f1VGNR+/I4WV1yMWg2qhTE0U7ngSgbruvUiSmYZXtRtPwjjvZOlVJFrdbfipwTUnz0HjBlVbJKlMCe2/
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c261:0:b0:3a0:4d72:7f5e with SMTP id
 e9e14a558f8ab-3a0c8ca4694mr87850785ab.7.1727061124141; Sun, 22 Sep 2024
 20:12:04 -0700 (PDT)
Date: Sun, 22 Sep 2024 20:12:04 -0700
In-Reply-To: <000000000000a41b82060e875721@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f0dc84.050a0220.3eed3.0001.GAE@google.com>
Subject: Re: [syzbot] [kernel?] WARNING in signal_wake_up_state
From: syzbot <syzbot+c6d438f2d77f96cae7c2@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, brauner@kernel.org, ebiederm@xmission.com, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luto@kernel.org, mhocko@suse.com, michael.christie@oracle.com, mst@redhat.com, 
	oleg@redhat.com, pasha.tatashin@soleen.com, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tandersen@netflix.com, tglx@linutronix.de, 
	torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 240a1853b4d2bce51e5cac9ba65cd646152ab6d6
Author: Mike Christie <michael.christie@oracle.com>
Date:   Sat Mar 16 00:47:07 2024 +0000

    kernel: Remove signal hacks for vhost_tasks

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13212480580000
start commit:   e88c4cfcb7b8 Merge tag 'for-6.9-rc5-tag' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d5a8e00ed1044a
dashboard link: https://syzkaller.appspot.com/bug?extid=c6d438f2d77f96cae7c2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152442ef180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=138c3d30980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: kernel: Remove signal hacks for vhost_tasks

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

