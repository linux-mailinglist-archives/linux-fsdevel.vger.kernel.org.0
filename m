Return-Path: <linux-fsdevel+bounces-33895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EEE9C03D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 12:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0922E1F2317A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 11:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECD21F582D;
	Thu,  7 Nov 2024 11:24:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716671F4FA8
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 11:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978645; cv=none; b=hVauQKsU1nYSKqeWMAKBbSNSVEBdvpphMUL3r/q7F+3T3UUF+q2Y78FO5cnqCYG1WpkoeoW8Tt5Kixz5TGYS4ii1GH072qASi+edBXk+NMg9PXmrDa71aL/9olVITAgEDCQu1YDQfBNnKx0lxh5rLndjLzgHsFiy+FRZTgXbaA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978645; c=relaxed/simple;
	bh=SJ5DaTFfA9NE7JO1TVV/AkfS+1CT0OW/Iim1MWeWxL4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZXfmkv+hQTKKffhxw30ZXOLzVkXLMWwZkHc8zFnHGKecQ3+JFZpnwTj/HrbcvZy1zShpmjX7UxZBHuQPV9Fi2ZdY7WS4zUJcS0TJeAEye4alMlGNKrAgH4g6BibNVStHQnRBuvSSKyta6YdAQHSZz3LLZShksG2ptaHJL8st2Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6c01d8df2so8429225ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 03:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730978642; x=1731583442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/kuQX3VmdU3VvGHoe3B0rpGazcaxNvNoeaIsi40NWo=;
        b=nGWrvF3taGWSTUvj44yb1YWw/S4v77V5Q1q1zJLnnXaC/JgnbmFV9xpFTCZtre7Vqf
         NzarJIPxiCktvCtSJeYZquSdRvbZreheJmxzKYF/K5SZXDavhV3O8TkYB/SFUl2hWAlE
         zI/XhviKoC/5cHCuux/yIlGGAMM5gap1wNis6k/5oZZ2Mp3fvZ+9R2sfnbh+O+yvYdDx
         zU7Gg6VxS2TaA2GgW0QXT71NYAESStavkUptXqtGv9AJm0Ug0g+kTmYvibjZ9cDr0Tbp
         Sv8LBHGit1qNx9wxtMqrps+IfrezqGgQ9Nhz+YaoziH+cm/0Q8byahojKA4N23QA/nO6
         XI6g==
X-Forwarded-Encrypted: i=1; AJvYcCVClwx+8s2sonT9NmIIf0QcFflmKVSWDv+WtInAaCH5W3uQGNPCgcY++h9kSD0mAe7nNv4HfwrKrxTqqqFE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5bvW0VOZXgmLxuTss7GG5l1kVPCPvNJCaiKZTDdNbryhxvWIy
	aarLEnZT3N3KHCyS2B51inxoitdLonxeD8iYNxLOIjQszd0wGq7wUDBSvF0lDPpWaEwepq5C4+k
	MXwcCkCBTEXNvBBSGvWGRcere0GaCs8YHQrtYdXnF3CD4xlQrF23GiAg=
X-Google-Smtp-Source: AGHT+IEZMvGy+Rp/56yyZKCtVAevUqCgApOzY5XSVvj5+Y6pII/CzZ4rRBxjpyqjQ8+85SERwlGxg2v/nv9K9CyM5ptoFmqLg6gB
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194d:b0:3a6:abb0:59a0 with SMTP id
 e9e14a558f8ab-3a6edc0d719mr6699605ab.0.1730978642648; Thu, 07 Nov 2024
 03:24:02 -0800 (PST)
Date: Thu, 07 Nov 2024 03:24:02 -0800
In-Reply-To: <0000000000008886db06150bcc92@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672ca352.050a0220.2dcd8c.0028.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: trying to register non-static key in
 do_mpage_readpage (2)
From: syzbot <syzbot+6783b9aaa6a224fabde8@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 1fd21919de6de245b63066b8ee3cfba92e36f0e9
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Thu Aug 22 11:43:32 2024 +0000

    fs/ntfs3: Stale inode instead of bad

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16f3bd5f980000
start commit:   d5d547aa7b51 Merge tag 'random-6.11-rc6-for-linus' of git:..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d806687521800cad
dashboard link: https://syzkaller.appspot.com/bug?extid=6783b9aaa6a224fabde8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140ddf93980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c83909980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Stale inode instead of bad

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

