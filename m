Return-Path: <linux-fsdevel+bounces-63289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E0CBB42D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 16:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35861189C6E7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 14:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC00312803;
	Thu,  2 Oct 2025 14:36:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893E73115AB
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759415766; cv=none; b=OQzULPT56oeEOVGqzQgQUqUaSCHFE0He84sGhyDagJ2OZY1QQCHsTqtdU8IVnIQZ1eBP9EyBYFUzDPwdPgOL+W/DqYIzd5A7sx43Nfy5YPLDa3H82DCD/zngKOeGhkdgAHyNyGtUToCCmkiraGclLkcfTVV9yjUWl5ZPRzUhp+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759415766; c=relaxed/simple;
	bh=8liGFBphLsGR/Ovvzu/WzdltXAKa3S0oH7Lj+OOJeIA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ICaOXTTS3CmhM3EwP8D+VTzZ/WkWajvwj98GNvaNNKJ7klEbrdwEv2XPm2yHbzS0/Hp/S38ZfAr7/5Dq47gqmQgF99hZNqlzfnKfFBnpLuIXbO7aDsmPQVx5pjfIjXEC12s63QYEe19gH1cDR7xdz/g8WuBqBvCNC9tJyy4YRTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8875a8663d0so116986939f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 07:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759415763; x=1760020563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jk/4xwGcZFhgMycSW8GRKnHdm9qwb9tDahIkrgnD+yY=;
        b=OCE3mLI/4h7RmFiUqPFRYu90tmvrOplporjhl0QzAu/qEaQoLb7NqTu4I9QI2f5rny
         PuUMsn2Y8wXQSsS1/xnNeGcKaqegcU5hIsw42OkKIcEkd8QBAe+akqIWlqwlf3PhE+G7
         2GttUTF+ql3/aSXPTYNf9QM4bdWKj3FtvXfzBz+37DlA5otYsfFAUeI6IUKSt0uHKEqU
         S+fZNAJeVRRhD7BgzWvLp1C2/ry4/1UcXOgIU45slRy7BCShM2opC9qPC/gOa2VyMOBq
         APbdZXm4OOQDnqEUFnuOtVtcem37MN6HlnK/fJNDQTeIB7TPr8nT5OBiMFs5jcNo0e4R
         uHQA==
X-Forwarded-Encrypted: i=1; AJvYcCXoKJGYcSIPkf61KZt1O7z/Ni4mg23EdwZWXMjEUFdEg1p9eX2ezCRiC6CxKLsci1e7sLfLRdflNcK6pWrG@vger.kernel.org
X-Gm-Message-State: AOJu0YzdQqojl5Jkifgpvv243TTEEpoe35c/AsA6W2+L/Yrz46FWDv8A
	QmWk+MWB8LpH6cMeVCRISj1mNoh2PUaWMTT3/KOVZlbAahMdffy32gba1F1yC7bDnjcQp8ZmMPf
	RmnsuuIRBTcQWZO3Jpzl3UC4rHDFIL/NKehPIprMyUEFZ/XKq+XLdGARKF6Q=
X-Google-Smtp-Source: AGHT+IEFCDUy+L2HapUMoQIqVeNFf1+i8LU/i67UR6vqPzmRvVBOVGQdoDjMHnGwpE8/z19KuYRoEdSiXryjuqvRF5DnWBXy3WRH
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c14:b0:90c:99f6:4cec with SMTP id
 ca18e2360f4ac-937a70f0f73mr1022782839f.3.1759415763631; Thu, 02 Oct 2025
 07:36:03 -0700 (PDT)
Date: Thu, 02 Oct 2025 07:36:03 -0700
In-Reply-To: <n45v4ckrwdb6z2zhqo554lt7qvgzmpbpd3z4uluun6vyotacmk@coodvjeanw3d>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68de8dd3.050a0220.25d7ab.07b2.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in copy_mnt_ns
From: syzbot <syzbot+e0f8855a87443d6a2413@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e0f8855a87443d6a2413@syzkaller.appspotmail.com
Tested-by: syzbot+e0f8855a87443d6a2413@syzkaller.appspotmail.com

Tested on:

commit:         7f707257 Merge tag 'kbuild-6.18-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1190c92f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9d13d0fd373120a
dashboard link: https://syzkaller.appspot.com/bug?extid=e0f8855a87443d6a2413
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1137e092580000

Note: testing is done by a robot and is best-effort only.

