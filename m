Return-Path: <linux-fsdevel+bounces-39924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73C9A19DD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 06:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3EF16B370
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 05:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603FC1BEF7C;
	Thu, 23 Jan 2025 05:06:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768FF157A67
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 05:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737608764; cv=none; b=UVDz4SgRM7ymxClF6f84z7L1W8sHgHlsADS3iot07yiGC6PHwC2RuYFOu74bKLvjFPaq7Ri4k1PavkSORD+01MyLTQW5+YzveGX/hS5HOLxMylBvaiKW5KksH1Z5EkUgWSOYuvmFq1QSrUV5FGpnFMu/Un6HSLtQXwm37VsanQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737608764; c=relaxed/simple;
	bh=9lat9TYPsdJJ9HzvHSrW5C1qF2mUhBzr4l2eyxOFupw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=W+HO3p64RPWz/sL3cCJJ7P5Dv81HRedzNplc+yw5sd/cnv07MDHJ4M3cCubNQeCD18CTHapnyuTHjZ1FbB3E3NQnNmsrqtJcaNt/HvAEga2cEkII0WDofOJqQNGwPooAv3AXwEepQ6s7d/3Uq+2VmtmGY9+EH7mS5Qj/OA/eeJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a814bfb77bso12135285ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 21:06:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737608761; x=1738213561;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMokocpQordxOMBpFMkHNLKOmcns6LVUEf4+Cy6nqGA=;
        b=rgKxs9eGbpr3854wfnbGGbFE4AEz8d5Pr8tDTPIgb9FjtdblzVy9FTrDxHXfVSJ8UE
         Y28HXDIsv+oIhOejjFNMW8KVYg6bVcxgxCkD1xOfWnaK5YInZOd0bGA83V3K+VRjPRsn
         lNaXgi3WISuDM3caPnjPaQGwTiQ9Z1ZXJZav7h9wtS8mkEL/8b5ZVIQZ+/8R/7YzNYeW
         8xDAwTR6teIm2+sHJhO4M0533cG2222IKoFKYZKsklCTBwCMjAObEwPRRa887vlOGbpJ
         uXhRQ1l7Dh37UuZGIlQr1dnzOtBqEjKEa7qqaGj9FKoPTxz6j58VXPTQwInSK/WTAHj/
         VS2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJE3VRkW1s/52SkZ2PcieSUuxtvzHtKq6aUWIM/H/b076THdV99F0ccrbGiiCgEPPpbIa1LdI+lW721FUF@vger.kernel.org
X-Gm-Message-State: AOJu0YyDz8hn+dWdtbx2s7hbN4i/OB25H/0dyQxmx/EizjRi/xg5UYeV
	Ib+DN2eLMSQ9EFS1by6GKuSN/1VP/a3k5M8Y1QGo+O2Jdxx5JIn6Wx7efXKRDhgD0aUOr3bU+bt
	KUWsz4zWX3hMN2gtA3kWjjrVpjqThgq5LWJrObobWdPN7kgHySH2j848=
X-Google-Smtp-Source: AGHT+IEtvNF5HgFqgR+tiC85tI4HMtMzC2e8hiosT6luwUOG8n/UR0GYVTcsXDmJq3dsnmv5bov8RMKr8uil7cpQqYlR+Lv19Sky
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:450b:b0:3a7:e1c3:11f5 with SMTP id
 e9e14a558f8ab-3cfbc16e8d6mr17441575ab.6.1737608761558; Wed, 22 Jan 2025
 21:06:01 -0800 (PST)
Date: Wed, 22 Jan 2025 21:06:01 -0800
In-Reply-To: <67432dee.050a0220.1cc393.0041.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6791ce39.050a0220.194594.0020.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in __folio_start_writeback
From: syzbot <syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com, 
	fdmanana@kernel.org, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nogikh@google.com, peterz@infradead.org, 
	quwenruo.btrfs@gmx.com, syzkaller-bugs@googlegroups.com, willy@infradead.org, 
	wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 66951e4860d3c688bfa550ea4a19635b57e00eca
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon Jan 13 12:50:11 2025 +0000

    sched/fair: Fix update_cfs_group() vs DELAY_DEQUEUE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11c129f8580000
start commit:   228a1157fb9f Merge tag '6.13-rc-part1-SMB3-client-fixes' o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=402159daa216c89d
dashboard link: https://syzkaller.appspot.com/bug?extid=aac7bff85be224de5156
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13840778580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17840778580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: sched/fair: Fix update_cfs_group() vs DELAY_DEQUEUE

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

