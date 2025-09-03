Return-Path: <linux-fsdevel+bounces-60150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45306B42006
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 14:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6D41BA78DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 12:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427FB3019D3;
	Wed,  3 Sep 2025 12:50:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6443009F0
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903806; cv=none; b=DCC8PwIG+gv3lcbBVcQ0R0Xf7Tg7svvJDW0+UO9ihI8yVP8RV1FYGp03Ee0v77DJlbPo7F1RPAvqwJAd+9vuB7DbvS+zK80TX8yTjEOwz8qCwsAv5SgEDtJ3i3QflPPoGinv4EFTdr0w4EaR+CQgLIDrV50Zq1mVDzAmLENZK7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903806; c=relaxed/simple;
	bh=NfVY0uOJ6FEvq7e+k5wZc9jqlPu1CfthQXKZe6VNgpo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=i7WwAVVGF12duUb6NroODsSZ44j/GMtm28kjSezGP6/MRylBgkXOgw9gYnUyOW3tSq7lTGNNgRnNBSVNETw9bhfjLh6tjV792wKRUgBmxF+tobmn0T4Hvw8Bo+YNPCY+9PKjSi6zcAe0yjpXM7dtZdcUt8EjpyfgGWAajGU2e/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3eefbb2da62so166092795ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 05:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756903804; x=1757508604;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OMejl/iQ+Tg2KDNjGuB3kqcQAoPPMTyVmkgNVu9W0w=;
        b=CCWFGQW1i6BulWnEZA6LbMVEtXgmjsEnmOacTEF+DIft0fstwJicEc80KvkVJVw5ns
         Uv/KLuHOJANMcvJcoR9giybFyr2BzWh0OdAgMHgmzkE3mn0NoGI2hNEKaucmvqUDxH+n
         n4cU4KzpgGckkT3W7UeTaNz17E5+FgcDBvXUWWi4Uvtn62M1A7PEziivfmBjOmuT2viW
         oBFX0hULWct/Z+ENzLrsAcUIcO0UiFLd834MIN6lrD4TvxIL53KUPwQOqbnQ2SF13c0O
         z+ja6e2Xxrr0qxu2t7aPTRscN1DvUWozbaHp9fEiY2jF2XKTUVDPS/q1EkOQJTSOvyDF
         qmTA==
X-Forwarded-Encrypted: i=1; AJvYcCVEhtH28SouaXGMfwBTi5qWHY2eJwl8YdDwBYQzKoWTDRRYKhKVS22qmB0IwCxupzz0jTdQaOssr1DgCte0@vger.kernel.org
X-Gm-Message-State: AOJu0YzmO8xe65sXEdVxLpXnK5gUyuhXOg+ecWp024uhJf5QYvyu4QLF
	5uTXStXpK3ehP+Bex0IUpSZtLP1ck3+5aJS/QgUAxhZnsHbWR+R/Sg1J7+viMxvOJgD3j9fdvQK
	Q61MuirkDPdsHSRnVC51GAoLLd/a1EsCAwtiikyj7WPzUs0x2QKDXUS2MJiU=
X-Google-Smtp-Source: AGHT+IHW+MQ+QmO3Wx+01fYvf/inCr+6x1CkylQIhXButK9at9rxl8FYGObhhj+RRZG4JC9Ep7A4/v7XHZK7WNVrCTnGaekBZmv1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2194:b0:3ee:a3ff:96c7 with SMTP id
 e9e14a558f8ab-3f401beb3a4mr256042315ab.17.1756903804188; Wed, 03 Sep 2025
 05:50:04 -0700 (PDT)
Date: Wed, 03 Sep 2025 05:50:04 -0700
In-Reply-To: <682ff0bf.a70a0220.1765ec.0148.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b8397c.050a0220.3db4df.01f1.GAE@google.com>
Subject: Re: [syzbot] [exfat?] INFO: task hung in lock_two_directories (4)
From: syzbot <syzbot+1bfacdf603474cfa86bd@syzkaller.appspotmail.com>
To: Yuezhang.Mo@sony.com, adilger.kernel@dilger.ca, bp@alien8.de, 
	brauner@kernel.org, casey@schaufler-ca.com, dave.hansen@linux.intel.com, 
	hpa@zytor.com, jack@suse.cz, linkinjeon@kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, roberto.sassu@huawei.com, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	tytso@mit.edu, viro@zeniv.linux.org.uk, x86@kernel.org, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 99f9a97dce39ad413c39b92c90393bbd6778f3fd
Author: Yuezhang Mo <Yuezhang.Mo@sony.com>
Date:   Tue Mar 18 09:00:49 2025 +0000

    exfat: add cluster chain loop check for dir

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13445e62580000
start commit:   3f31a806a62e Merge tag 'mm-hotfixes-stable-2025-07-11-16-1..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd2783a0a99d4ed0
dashboard link: https://syzkaller.appspot.com/bug?extid=1bfacdf603474cfa86bd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134b50f0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d7018c580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: exfat: add cluster chain loop check for dir

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

