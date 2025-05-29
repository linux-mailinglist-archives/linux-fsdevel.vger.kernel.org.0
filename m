Return-Path: <linux-fsdevel+bounces-50045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB07AC7A73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 10:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF20E189F401
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 08:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA9421ADA7;
	Thu, 29 May 2025 08:54:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8EF218EBE
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748508848; cv=none; b=Po1tWQGC8uY7Ag4ZTVpjgD7kS8jfDDicCGD/ZUWkS/m6eu0qDYIcu+ISPylE9zqUi1dfWlMdF67WvxKRRSj/lKB6AtOAHMcWNrslPbKz2uA05egYPJkNbY7tH9Vxm+KreXyGtBwQUEl+U9DqU74GNqmF4WX0bzYlsTkztw7Pcos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748508848; c=relaxed/simple;
	bh=q91nuQGRRRhb1KNojdFH+w+wL21SpNT90+AHMNekIzU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mQGWzU5DRFvbmE1hKakZH56saiEfO6gYi9q01LGMUTc8rd/iCNgu9uT2AcSOqweRVUjXOQOPbbcZwZNL+1cq0CcLGzsKTvIez01GzSbAN5J4kyfoN0dyZ2ajUkHTV7uhJwIl72EYwEWmF3UsR6+tygUJKiCXFfep0d6kRdaWaZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3dca1268a57so8806765ab.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 01:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748508846; x=1749113646;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBlyRIybHBaIqmeBc0FbsfGe2HQBjnmO3lAWrSbPihA=;
        b=h5tYT0LX57hOh291zeAt/hPeUT7ei2gcTmVNtAgB9UDS1F4BIKip9ZfpJY+s8tuwab
         6wWCzFNEZ5iku3QerNvNAzKk+/fYPDf3KdYEeMWLAlpFcznBm02TjkHS72s2mUE+/NfX
         dXVCWtVmHB+7EnxWkFVAAtNVPTEeOM7t/fFiQDBBycecjepPoJ2Cw0QcvpP21saweEsW
         0DHxlq55wJqjCyxljh+VlyGY/z2OuFhjPujQiKeFOnATr6qxl27gO81DC9N4c216IPvh
         NO5lUj37G3SioiMIZb4mIrjjy3WOTeliHIEF+n3QshowggjGR7ra2jmxvcW1NUZ3Yl09
         veBg==
X-Forwarded-Encrypted: i=1; AJvYcCWopm2Gw9lUVNK2PzUdyWUBY7u+R7fC5wuLSvB26+sOkQm1YKozkj93OZog/0OLUXF5d2OhsfsTsV8BWUpa@vger.kernel.org
X-Gm-Message-State: AOJu0YxCqEccgYeUOElbGvCDwpUaxKA4GFYM24YFA22ohmZNU/M80knf
	4bLFHp28c+CMUIkYYMa8SMx2vNhhGhO/GnxNP78KZLp1xhRDjnoyPfiffWSXedV8XKFzAXLFDdn
	SkqaM9H0KLAQMEfRF30FdS1rkpDNgnky5aPRaHZl2y6NZgq2ZwJ+hWPPzmI8=
X-Google-Smtp-Source: AGHT+IGTRXy7d/IwzDy1o86z0H8LJAGn0XcP6VlbyJf2BmWogsfJeseORsf9jwaJIDjRT/Nj1zLMsKYeHBkliNHOwaksJ1d653QC
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1488:b0:3dc:89e3:b882 with SMTP id
 e9e14a558f8ab-3dc9b6d4de6mr200720745ab.8.1748508845817; Thu, 29 May 2025
 01:54:05 -0700 (PDT)
Date: Thu, 29 May 2025 01:54:05 -0700
In-Reply-To: <6746eaef.050a0220.21d33d.0020.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683820ad.a70a0220.1765ec.0184.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KASAN: slab-out-of-bounds Write in hfs_bnode_read
From: syzbot <syzbot+c6811fc2262cec1e6266@syzkaller.appspotmail.com>
To: brauner@kernel.org, cengiz.can@canonical.com, eadavis@qq.com, 
	kovalev@altlinux.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit bb5e07cb927724e0b47be371fa081141cfb14414
Author: Vasiliy Kovalev <kovalev@altlinux.org>
Date:   Sat Oct 19 19:13:03 2024 +0000

    hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12794970580000
start commit:   06afb0f36106 Merge tag 'trace-v6.13' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=461a3713d88227a7
dashboard link: https://syzkaller.appspot.com/bug?extid=c6811fc2262cec1e6266
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140e7b78580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129181c0580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

