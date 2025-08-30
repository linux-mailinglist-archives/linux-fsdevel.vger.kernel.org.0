Return-Path: <linux-fsdevel+bounces-59703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFCFB3C870
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 08:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814491BA73D3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 06:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA8825485A;
	Sat, 30 Aug 2025 06:15:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B323224AF0
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 Aug 2025 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756534504; cv=none; b=Fe+zSnsBO5vHkBFWOb9MRw9F/MwX3kGJD9LnYHMHivirg/jXPhYiWVnAJKPA+0YQKdnf1JUbtx4LWkR+Y4SQtgrdz9zjF3ARnBNztXx1rw+2b97jjy8iqH8bQGUBna/eCUCBCfkkEX7sAdmAXioDDCJ6gslDDZMRD8w6OeKTY7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756534504; c=relaxed/simple;
	bh=tmZB1nVSSRipWiyAB7XZA7O5R7fEqGHvKca03KMejas=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tWSZl7JaiuIbSDTV/wYCJ7wt3zlhvPABRRt9tnUq43sqKXkseZt/KjQlJnP0M7LY+3VAbgBRyG8vKW4EQfuxHneARKPu23ooguIKUVETj9jivcbGMv26p0f4+H3yK7hz1BfGPLIfvxT9seYtjrdGyeWMedLKNfimXmhfaQ8EqLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3f2b8187ec9so26918685ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 23:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756534502; x=1757139302;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzdRXtUwN7b49DUAa+oICb3Bg2JQNLD+we98k3VPOZo=;
        b=Z6KRUAZceXQWQjgQIrl2ywaM3xzWVDT+x2qhJ2NcdigLvAMFsp8sCuLI7wzicw55zB
         ZnTtdhxw0BLsUTz/XaK087TA0P+WYspvwzj+UM6PPZ+5pZGekWbcJ/7hVZC/+DnEONU0
         /df7f0PUpxRNCGHQ+vt/X9RZwIw1DP++RB3+FEkrqxiLYP9dj27QJP6xRvFv3f6brdPI
         qoYTjRHyOCt4YKmW/3Y4q7Uf9g7IoTPqNqyDnpp7PvMo0yOXH3RUlc3K49SSOdn8ralf
         fYg4e4sB11wttNa7P4kkeLBDCUQbzZk0NBZg8RskCtys/T6OIfEK55UaTle1AKbaVa56
         xBiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnepaRENQq8cWzTYRSseZSRhNpfOZ/hoz2hDzS0E1w+VmCkRrZxIS88k/cLA/eZyDzHUnLpxUI2zEWPA4Q@vger.kernel.org
X-Gm-Message-State: AOJu0YytC8dTyK/sIriTuAAFACQge7n7//YqZzTyEJQv8MEiQHFxv0Va
	w/3Pm76mICPLtJ9r4S+EzjlTbgtZAjXf0gjU1QLL+4dSqqFbrXSMKpyYs05tG8W+eBn6vlAUn6X
	R/LZO1tJyxan3Qayp3eSRFus+4rwVsNF+eAPkhf2UKQoE56H3Qcl4l737hNM=
X-Google-Smtp-Source: AGHT+IE2kGR5jTsLkA0yjVS6YxrvvYv1X8Pd93StA/xrtFjuEmH/Z/GTeFE5d/PGZmpYDSB9+gRGQk2zvsfHf81H9yxubL+YF5De
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188b:b0:3f0:abe5:54eb with SMTP id
 e9e14a558f8ab-3f3fd18b519mr24741415ab.0.1756534502590; Fri, 29 Aug 2025
 23:15:02 -0700 (PDT)
Date: Fri, 29 Aug 2025 23:15:02 -0700
In-Reply-To: <CAKYAXd8xoejuSenjr5o7SG5o-DsYpfZdQt8QE-JRN2=u2PRMyA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b296e6.050a0220.3db4df.01a4.GAE@google.com>
Subject: Re: [syzbot] [exfat?] [ext4?] WARNING in __rt_mutex_slowlock_locked
From: syzbot <syzbot+a725ab460fc1def9896f@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, brauner@kernel.org, jack@suse.cz, 
	linkinjeon@kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a725ab460fc1def9896f@syzkaller.appspotmail.com
Tested-by: syzbot+a725ab460fc1def9896f@syzkaller.appspotmail.com

Tested on:

commit:         11e7861d Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13755262580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd9738e00c1bbfb4
dashboard link: https://syzkaller.appspot.com/bug?extid=a725ab460fc1def9896f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17b6d634580000

Note: testing is done by a robot and is best-effort only.

