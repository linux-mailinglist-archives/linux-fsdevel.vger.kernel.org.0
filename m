Return-Path: <linux-fsdevel+bounces-41783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F61A3723E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 07:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D092116ED90
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 06:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DB0151990;
	Sun, 16 Feb 2025 06:11:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BBD13D897
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Feb 2025 06:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739686265; cv=none; b=dyxhBSESAwJNG09bko3V5ZGxJdIL2/Ql1jyt1mm2IMCrnMzdTrYDAvrgB+XzPCejzqBGNdEqN61r2YNnHdXka3BPCsisl/K8XIxtqMfmKKDEM2UJAukLYi8MRyrWAqWatL62ykp89nR3TjPTmtXNs2W9AM7drpMcuZoaIOZp+2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739686265; c=relaxed/simple;
	bh=iLGpnbolH5+5uFQ9AF3pSfaKiI29JPa9lxa27DLdwew=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=L1QlvLIkXeKfmwGYROVlvkmONBqoB7IzmgKBkvdLSTQD2u0fI+cytyVOBZk9x1qS7OAYyaJB8d15wnPPMMKmyvFrshnTPkPOUK0pmsi6qbLQWLZQufmt84FE7fWLI23XwmDpwC18whlf5/FxELfkmv2gYpcvLQbZNKl8zMYd3lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3cfba354f79so68602985ab.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Feb 2025 22:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739686263; x=1740291063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5RQXIcx2qp8FY1Ol3TmBIxlirBrfFgu9UMo2NNP7n58=;
        b=rO+Wv9OWVuGr3BXy3Pxso5omTZ+UtJnnz5letsrTDbixDU47j6iH0+dLxuhbHI7PUx
         9j3pFGizVWJbvVsk5nA3NhAjZbeDIiHeOuvt3a6DNdQk5WnnuAGeC/ecSkZWRNTWmEMX
         q6ehr/85Vqcz5sWF9WuHkysGnz0ADSrNrTm6hz5BDlezhFzSWxoL1YjsI3WJKDi4Tb72
         Jl6dMMiCitmh/WqFMoWqXy5Zxu71aRexn06ihadH0+3PalQ4Y9jhZCU2vz1S/xTabK3o
         n5fDvb25KWAU08BjxxPTmNWtlfB0T4Wg//AH+h4MYfxNzbkc+A3LthbOCqQwMX9ultcp
         gfmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgLkeF8smah0/N/gXrZky8ysxdZ0UqLmximo87pVkW/4KO8uviLg3Oekl8k72tYSJiAz3q8RWfX+KdO9tk@vger.kernel.org
X-Gm-Message-State: AOJu0YwFn2ZuBFt+8tT2pdgqEa9XAnDyhErh2gfsWqYXxzdUMl8yYb0G
	fkx0rhcrrMWHxqVPAxohBI8juGus7zE/z5Keu7LNF3kUS0DO9aSrjioNJXrn0ApIS8ZLDvCAWb3
	rIYquzCWejRi6avzHH71OXgGRap6smhNUuKleAfzfV5se827uZMblzKo=
X-Google-Smtp-Source: AGHT+IFB/Ait/METgdup/3vtWK3IG2/7Ust3BFMvWHwfNDuW/8r68ccLZFFqLsZFhGhclMLp3AxNKcTpyfwd2FyPZUhXRdCfPo7w
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3109:b0:3d0:2548:83c1 with SMTP id
 e9e14a558f8ab-3d2807b0f9amr43173555ab.6.1739686263229; Sat, 15 Feb 2025
 22:11:03 -0800 (PST)
Date: Sat, 15 Feb 2025 22:11:03 -0800
In-Reply-To: <6741d52e.050a0220.1cc393.0010.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b18177.050a0220.54b41.0004.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] [ext4?] WARNING in __find_get_block (2)
From: syzbot <syzbot+3c9f079f8fb1d7d331be@syzkaller.appspotmail.com>
To: Yuezhang.Mo@sony.com, brauner@kernel.org, daniel.palmer@sony.com, 
	hirofumi@mail.parknet.co.jp, jack@suse.com, jack@suse.cz, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linkinjeon@kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	viro@zeniv.linux.org.uk, wataru.aoyama@sony.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 70465acbb0ce1bb69447acf32f136c8153cda0de
Author: Yuezhang Mo <Yuezhang.Mo@sony.com>
Date:   Mon Dec 2 01:53:17 2024 +0000

    exfat: fix exfat_find_empty_entry() not returning error on failure

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15d62bf8580000
start commit:   f44d154d6e3d Merge tag 'soc-fixes-6.13' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1234f097ee657d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=3c9f079f8fb1d7d331be
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e302df980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1265b4f8580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: exfat: fix exfat_find_empty_entry() not returning error on failure

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

