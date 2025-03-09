Return-Path: <linux-fsdevel+bounces-43535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E90A58004
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 01:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0642A3AD9FA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 00:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F49BA45;
	Sun,  9 Mar 2025 00:32:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB862914
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Mar 2025 00:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741480324; cv=none; b=dvVoS7aqIIJ8+f1I53mtIdMvK9p6EphlWqTJZyQI3kRIlx5tKvIAXfsRkm/ldGjDjWuO+9/dZ35pMdgWdf92xrw1GH5GqoX6aK8dd1D9rfUvnjGD4Jb2TtUC/y0UkBn3Z6uyWMkVQUAtmE8DSgQCDWOV10ckLx5UXFmh/wZceFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741480324; c=relaxed/simple;
	bh=5+w+DpFN07cFMMxG3KtxyUJcBT+QtYSPglebHcuHpoM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UiavjuCgCQfhJLZRw3M6Cajy6Ncaz+OVvrRHE3NF6vRlaxWR7qc54Ek8KoHGCrVqOWU3zD5cmn0P2Qq4CPqV+hR4nJJFp9/x9sNO/1+9G9gcEqFUjXzVYkWUkCr3YrN1cGhHuKF6/I5WCkLeCl0nRyKRkWlTFNjS803r+IPHeqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so69288485ab.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Mar 2025 16:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741480322; x=1742085122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lfB4DWMuL2dRUjaSj/0Ry9KkaKQ0CpScfoI5b0dPR4o=;
        b=tUdRmFGQISRr7W9FMyYVqzj57G0UNQN0Etuqu1gWw3pS/APc8q09tbiy4MPSAZI7SW
         8mCiToPPQWKq9qWB+f+JvNkEqdT60t663NxoNk6KFG8eYbF/PhXduSHVtogOR7hD3eNh
         UTl29ge/GRPZ+pihxE2C1Jj99TL8VuMh1V4oMaarfwUG7d8aArDCoPnH054q3hMDH35E
         oNl+QILXa5RGg5B2YIIflNy4fiQuwooju06WMEFw1OMfwvnIRZJSIbJxMXvrXpPLfT1g
         s4bdQXZdCRInl54vPWnaj35txvUxVG043sXtUXxGwOsVWpEaZMeWE2dmqyv9/08UcjX9
         sCDg==
X-Forwarded-Encrypted: i=1; AJvYcCWD0XvO7Yy/joXBtPK0lBjcVpk1DTgBk+iPQckaOPD4jqbG59Ak+VmGVE+ODF/RSsviHu503jQzr7xhnz0x@vger.kernel.org
X-Gm-Message-State: AOJu0Yyho9pQv1VEYJGbpaANEYDD2r4aCstQLjGSjgE29R2ZaJOG1pOZ
	P+1KlMWgnK+5hu7VHPRvOGcLWMuK0UzvVcH4nINBdaath4v/fwXlC+X1xzQtMRlCU4R82GE/7GX
	0ScTnOD7TPrX2pe/DGOo41udeDpVC3pXpsPmTtUPExujYzo2DWs0LuAo=
X-Google-Smtp-Source: AGHT+IEO95u4KON9M9kPvSb6+jLVgItwLeyQ52gl27OoeaC/4UUw3Y5B6gO2wA0A8Jz4fVX+dbXDf3ZqYw7CX3nM+UyIWTj3lbjf
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e9:b0:3d4:337f:121b with SMTP id
 e9e14a558f8ab-3d44196060fmr96149465ab.8.1741480322622; Sat, 08 Mar 2025
 16:32:02 -0800 (PST)
Date: Sat, 08 Mar 2025 16:32:02 -0800
In-Reply-To: <67a2b735.050a0220.50516.0004.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cce182.050a0220.24a339.009e.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] BUG: corrupted list in new_inode
From: syzbot <syzbot+2dabb3dce04e28763712@syzkaller.appspotmail.com>
To: brauner@kernel.org, dakr@kernel.org, gregkh@linuxfoundation.org, 
	jack@suse.cz, kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 14152654805256d760315ec24e414363bfa19a06
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Mon Nov 25 05:21:27 2024 +0000

    bcachefs: Bad btree roots are now autofix

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16f254b7980000
start commit:   4dc1d1bec898 Merge tag 'mfd-fixes-6.14' of git://git.kerne..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15f254b7980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11f254b7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c516b1c112a81e77
dashboard link: https://syzkaller.appspot.com/bug?extid=2dabb3dce04e28763712
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c34aa4580000

Reported-by: syzbot+2dabb3dce04e28763712@syzkaller.appspotmail.com
Fixes: 141526548052 ("bcachefs: Bad btree roots are now autofix")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

