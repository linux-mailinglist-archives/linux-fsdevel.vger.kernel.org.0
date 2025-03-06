Return-Path: <linux-fsdevel+bounces-43324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEDDA545CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 10:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87E41888FCC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 09:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B9C2080EB;
	Thu,  6 Mar 2025 09:04:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB93319D071
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251846; cv=none; b=bb2GWJvwtb3l4Zey3AtNjcx5H8hxEMS4khEog2newBiv3YQvQ3ObodTZVKN9mkTJQpBCbwPY04729Bcs63XCo02qVSRzgRTpQ0J5oF2t44KRt0QAI+mkF8csWtmNPShCA2VwD7nv61uoZi4KcpdVVBAWlervxgj3gCyqjQuS6oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251846; c=relaxed/simple;
	bh=ruAfKKuJv4D//haITjZ4loefKlVdbyEM29MI7QA1oWg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oViZGK1HNcOx33YVyw/bZKWBoBopg92SGXVIDWZPo+sQUdAu8fZDBLgmoxZ5rM6KoLKQA970nZ9mDvBoC3ZbXCUOFgIHGRgSf+9t+FULDN/BiIzMflpWsRJ0GkdpG70ydA2HDIc9uJQZzQDdpnWKr3eqGj3h8XOuL2eVl3ybrKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d054d79dacso8483205ab.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Mar 2025 01:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741251844; x=1741856644;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6PlUf2EDtc8+GWdOxIDmfUU+aGd5sbW4hhN7UakkYqw=;
        b=kYk48PuNxWqOn+hSsyxNrYhC9jFCY6PpHWcpNhhAkRMpwBw4cShFqhCJVYtL10BEYI
         IJN8RONtV9OmufnLuuZrEhVdZx/Kfn0VodeIbgA/TIyrEOIcvitPC0N7TZ8pL05DT7Dn
         NgtXoYgleGGi1l19dEACtMwiaqOEHA6tqH1G/ihKzae4GxVjKC5hXDuY/d1C/bGeOtIr
         qWsNh0H1kMSMZEEvsvu4f9K/MUzV91rihDNpm/PCaZiK6y9Ku9XBrHPmbCSt6Q8NIhVE
         u6bH0dM9Psp7aIDuAq+4tMkFwciq2lYsWPhr5Bodjlld9GTz5YQGAz1WioiLnjFAVZz1
         XRiw==
X-Forwarded-Encrypted: i=1; AJvYcCWP+GeqGVeybCFWOpzX8Fn8vWaHKJwTZtTYEvmmMbISepZ3z8s5YA4foWKx1kD7uA6+mZehqBVg03evYEKc@vger.kernel.org
X-Gm-Message-State: AOJu0YyXb2DTasqxWiMT6htolXTbsq6KYAKbzRJ4qel5jUeHt37//O9S
	TkO4+NU1KNIqTCzyZuLvTdrTrWPp4X8cxd7SCj90FHufUvtFvUMWAp6Ks/A5SsZ6zlEyN4jYuka
	SDsi1GuLZL5vb9e4Z58ku49lXmJ0GdaStjjBNv3cKZ6dxD4kMwr9cfko=
X-Google-Smtp-Source: AGHT+IGTBLARltXQf7oengpyI6p3Xjnj/feG2ACDCutrMgIXebFL36ZwMXTWYi4jeppRR1zG6cu4U/sqPkb1QpRrtRzIkxgmvrIo
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190e:b0:3d3:e09d:2a9f with SMTP id
 e9e14a558f8ab-3d42b891005mr83529435ab.8.1741251843985; Thu, 06 Mar 2025
 01:04:03 -0800 (PST)
Date: Thu, 06 Mar 2025 01:04:03 -0800
In-Reply-To: <67a11d8a.050a0220.163cdc.0051.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c96503.050a0220.15b4b9.0030.GAE@google.com>
Subject: Re: [syzbot] [udf?] general protection fault in d_splice_alias
From: syzbot <syzbot+a9c0867e4d1dd0c7ab19@syzkaller.appspotmail.com>
To: amir73il@gmail.com, asmadeus@codewreck.org, brauner@kernel.org, 
	corbet@lwn.net, eadavis@qq.com, ericvh@kernel.org, jack@suse.com, 
	jack@suse.cz, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	mjguzik@gmail.com, syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 902e09c8acde117b00369521f54df817a983d4ab
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon Feb 3 21:16:09 2025 +0000

    fix braino in "9p: fix ->rename_sem exclusion"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11d77078580000
start commit:   69e858e0b8b2 Merge tag 'uml-for-linus-6.14-rc1' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1a6d4df5fcc342f
dashboard link: https://syzkaller.appspot.com/bug?extid=a9c0867e4d1dd0c7ab19
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125d0eb0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a595f8580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fix braino in "9p: fix ->rename_sem exclusion"

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

