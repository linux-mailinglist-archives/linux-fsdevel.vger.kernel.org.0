Return-Path: <linux-fsdevel+bounces-18990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887898BF562
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 06:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF3428121D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 04:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CD8175AD;
	Wed,  8 May 2024 04:59:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB474A3E
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 04:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715144349; cv=none; b=QcCTbbNeUE2VXB32g7AYxnKf95fFaYvUSl01Qp9MjF1w0gtImnQJv/Ssrcf7VqV2rWWXaXTTRJLdW2+qIy5aSW3OfGLO2EszNetA2ixU/oe8O0is9vAt8hyoIIDqteSPuxrclidpfTGtZcnX8Zv+NbkarSy5Ko/Tp1siTYEvXRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715144349; c=relaxed/simple;
	bh=grguybPX+h2UCon/cjSOa+mzA0KlDjT4Z0Lej2+UKKs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RUSGI9oud/ZUHcO3F0g2kx6fMk6BOFJIS61C/axBu+1cxRCSKDShQoA/Eq5f0SHVbPD2rzfykon23bXEUYKTta7Xz7fBtFbLNooRn4Ngxmzugg6eatKDMybHGDD2+/F4gg1d5FX6+VnUVOZbMQSE7Uj62I3jWoah4N2M9lRFEGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7da4360bbacso495298339f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2024 21:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715144344; x=1715749144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+fjCTSoU5FfUWAA20oSxRWPOgaxuApk8TbKtRkB800=;
        b=VuRnrIy5APA9FSbbReJefEOwUvSydox4vyo+8MoSqFDztRDiAB/2jpdUQ9NZVUDybk
         ZS3yDyVhfJnceAI1dCkUhyYbKR+eND3iqvvzfXkhGAQAfQY4CxKm7wShQXMNgFHhYD1h
         fvL7gos5J8+E31qlvQBQRzTrdglY422viGjuIrPqSb8E5TjbBzIIcWm8iQJ31Hser9wz
         PF4QG+Rcb2C2eQSQLbOsNx66j9lF0z9z50O9jYzG2PmuHpF/TVY0GRaWQWhPAFT6h09o
         sNVysDOflTz8GWpUHnvMnjvq/1cFR8km5DalFJ+LMNLtRVRO5fI5C8+bVzU9gv1ThKYM
         86rg==
X-Forwarded-Encrypted: i=1; AJvYcCWwUmIdr7hhyTASHQSqPKfNnZ4GX1v4aAZB4K95txSMqV7LeS5+svQ8CPrl0oYwkb3XNf7aCz+dudmCnhwUQWnBkNiExOiRuNQafqNogA==
X-Gm-Message-State: AOJu0YyXLvW25HL2Ab+9QVO+9XjZP507LdseyALCf0zzceD/Od59bQp4
	UJDirlS6Dq6b1LFpEmev4wQalrF5Y+PGE+/VtVIhRaKqRk4BnXORfSBQPBT0Rl6cK4DXfXglJ41
	EdcEHdfEMl5rVMUYvirnrRULXwVczqVWajUWMGfVGmJophAmfDZC24SQ=
X-Google-Smtp-Source: AGHT+IEvpfUKYLFR6Yt0QR5x4KvFKT/3f/v/oGP7ub1t1z3lYGWgIabF/NIxLsvTG2D6jXzDlmXD9R+tRGTWmddwCniMs6ACFlAW
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2194:b0:36b:3b10:7425 with SMTP id
 e9e14a558f8ab-36caedba2cbmr263145ab.6.1715144344615; Tue, 07 May 2024
 21:59:04 -0700 (PDT)
Date: Tue, 07 May 2024 21:59:04 -0700
In-Reply-To: <0000000000008160ad06179354a2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006650ea0617ea29e9@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_fs_recovery
From: syzbot <syzbot+05c1843ef85da9e52042@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Sep 23 22:41:51 2023 +0000

    bcachefs: Ignore unknown mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14fdf9a8980000
start commit:   ddb4c3f25b7b Merge tag 'for-linus-6.9a-rc7-tag' of git://g..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16fdf9a8980000
console output: https://syzkaller.appspot.com/x/log.txt?x=12fdf9a8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=05c1843ef85da9e52042
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1464ea2f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130db31f180000

Reported-by: syzbot+05c1843ef85da9e52042@syzkaller.appspotmail.com
Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

