Return-Path: <linux-fsdevel+bounces-12510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3B7860181
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 19:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86F41C24358
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 18:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E4E548F1;
	Thu, 22 Feb 2024 18:22:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C88F548E9
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 18:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626125; cv=none; b=DOUR6ghbgCvv+EK+/G43ARyxRWcmvJzTaii5tmN+CnqZBQb2tIMaBYWSxz7R9M5c79UwzDakNvX/tX8tlP5DLe/pdzuIpcXsz3r7svqKL1x+QC13nS8c2hzGiw833rSu/a1PsUw5Tc1pTH3zjKAkFZ2OqejuwnFJj3/h8Er+smA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626125; c=relaxed/simple;
	bh=97Tg+DwGMA04csHe9nB+KIigBSYghq8PAkVFMvrJ57Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QaqBq3BZjLFZScHx42HdRajSFsxf1XXKpGiYzRzmqlVs8SGam8GClvekPoWjdcnD1Ce39az/v7MqN5vBdbDvurxFi34I6upwAME5sHIYphleDDe4Zzde/4RzbzL+ec7bnK8jms+4/NSS18QZaxaPUTc+neexwMikq2WvlYpl2sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3655fa1722bso10156495ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 10:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708626123; x=1709230923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtNEI/4Zr5JmjLe0NXFrbfZxQOyOn8Q5SFKbwujF9s8=;
        b=fOq91J/kiiJDGkXTlYaKB1gtQKCt5/3Ol469gvY1kiUDY8JJ728k7zBmKiV+pfrgN+
         WQ/qife+Tcjl9NUitfwt8dtIhGgQbU3N0XKbwgitMUU7p1JWTkQS4Gf1yzhkCKW+Eqcq
         WBYc50pytpwoYwr5GA1txYvrFLtfLxwTR8dxlHEm4vc4UW0uS9a1vK16PstgCG8NGA5b
         ZBbZrmXtN+wYb60TdsjSwLdS7/0z59ciZtRwKP6XBLlZBCsD/kPhJzrQVhiLS3ip7YxW
         g4ts1Bp836EduBVG1U4nyw4COZB3sstLG9KYFE4gCRd8TzQ9QShWYiTuAJBIvD0Q5PCf
         mKQg==
X-Forwarded-Encrypted: i=1; AJvYcCW28Ln0ZbZyxwXwr0dVNSoM7KLz5YdkLffL/Zb0U6DIg4/lizN9wuCHjjkVDSqIA4RfnaMUXyOJAeKH2IyuOPiK7ZSgMFqXIwf6ujAuTw==
X-Gm-Message-State: AOJu0YyZW7HYnch91QZxooS6BDBSrLDVhabcBl7q7Ya+z/qIORq6ZRDx
	TQI/XZqPhQq77cA1KU3WXSspgGWHx4oD5R5+7MIFSlcDDRuwIidnBhBoX7jBzuepKrYb7OalYK4
	V1ZblKMa7cJXFKATtVV+/q6XXj0LU3QuJGlvKI5dikC4C7ynaecBDnjo=
X-Google-Smtp-Source: AGHT+IEpFT1CSBFiFs4xWJdv7kZs+tazOCwxhjUWG9LceWLo6+LE/qsPZ5lQjxIH/lO5QVtrkHfhN19TP5j+QgQ2OCYE9xNt/3y9
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1745:b0:363:cf28:f1cc with SMTP id
 y5-20020a056e02174500b00363cf28f1ccmr191061ill.3.1708626123755; Thu, 22 Feb
 2024 10:22:03 -0800 (PST)
Date: Thu, 22 Feb 2024 10:22:03 -0800
In-Reply-To: <0000000000008a0fa9060e1d198e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029237c0611fc8535@google.com>
Subject: Re: [syzbot] [mm?] [reiserfs?] general protection fault in
 free_swap_cache (4)
From: syzbot <syzbot+fd93e36ced1a43a58f75@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	bristot@redhat.com, bsegall@google.com, chouhan.shreyansh630@gmail.com, 
	dietmar.eggemann@arm.com, jack@suse.cz, jeffm@suse.com, juri.lelli@redhat.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mgorman@suse.de, mingo@redhat.com, peterz@infradead.org, 
	reiserfs-devel@vger.kernel.org, rkovhaev@gmail.com, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com, vincent.guittot@linaro.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=170ec4b4180000
start commit:   610a9b8f49fb Linux 6.7-rc8
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=48ca880a5d56f9b1
dashboard link: https://syzkaller.appspot.com/bug?extid=fd93e36ced1a43a58f75
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f4cc41e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d526ade80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

