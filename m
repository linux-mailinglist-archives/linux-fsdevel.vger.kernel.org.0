Return-Path: <linux-fsdevel+bounces-12594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3516861850
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 17:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88FCA1F24765
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 16:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CCB128833;
	Fri, 23 Feb 2024 16:46:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD0B82D74
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706765; cv=none; b=CCvcA2rqL28HGe/3jKOTTyEqo7HREKYFUD+eGXHfFQbnPWrsKMuiiOndhXH8S/zuYgWZlYy+nZvPjUxo11IxYn+WwzW9do0Igye3Gknjr0XERkC+fToDSxTaVfEVUrRiOr2QVs6o2EfrH8pBFKtcFn0B1JFGdeRJZ6DI7NKrVJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706765; c=relaxed/simple;
	bh=qQXXCJnEn0gEmCgei4EJtGTcYDFQeydarbbINEJ98wc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VcQyul4GmBkaUECVXBcwWMgMJmhkI+gfiEEVmR84y3jfjM2u4u9zlAdebrIsgJLWInNCe8DVwJBM7OxV1eBtq6N2HBv2lUm13X5EkIEKwLEg5Hnguk+KCJ2VUBLhd2kK7jdXi1o9DfdKObeu0tKubV+efkQg+BpTvCzXW+4U6Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c75dee76c0so95080239f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 08:46:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708706763; x=1709311563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ceXc2lDEn8+HQNQqoepYTtPf4nu6XaifYXdeQUwtmA=;
        b=KiNhFSH3N9Y4OrDcJjplkmNa9sClYlBAE9AJ64ny3IX6TDO8AMJVnY6kcK6XaJmtI8
         zcFbBjG13bZW5iWHdo4N8RPyIdpVeMSh9+f7mhQf7TAIJiNmxeF+V+mvnVLzjitmBs20
         XOEdO5/YJROmsFYHZLVbd5xRnhm3tAO8yGGFkDrXCAwixvoJZ538QqnE97IcNWy4IbKV
         YKCID/YHalcBc9Ifmfw7+tI66QNwCy8GKfhzxGzDZM3A0L/de7+pRmLxlO9/0UuHjiyd
         xbN2/S6PN68k+RIpk/wSXhU2VACYAMu7iaCHHm0GbejSzd9LxaCYhrq6vKRjzzOER56a
         t7bw==
X-Forwarded-Encrypted: i=1; AJvYcCXuAyokNdFdf+jmWw5LUye2byaqSgr2LDOI9ldL6eWqwNfj5FTQ9baduIA6j17qsC/6d7n9fVDAxP9zVh/oW4/Mo1fHWNM0OohHeZ5eYA==
X-Gm-Message-State: AOJu0YxsOqa4ZQebUyS9KOvFD0BmJmlpG1ur9rMi+HcsDauiz+s7jOev
	KlKYlqYSITQQzD7lttlcegRPybWCxOFqbn8v961Wvp/QTsv1oCjZSFLlJdAaOTfes26pJ4wD35J
	Ny++oGL7psNVfhLA/osfxnAdNO2WBKbfMvy+r8PdR/mEqFkAlNBYCM/E=
X-Google-Smtp-Source: AGHT+IFJyp0MBrj4S7LpAYTmGxLLAIs0GF3qNZ35WmD+27zb/IWGxxjM2bKRA6m25SWK8yidx1cSH3ToQ5m5W8fEDdkEIjf8h1Qz
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:898f:0:b0:7c7:96ac:9408 with SMTP id
 m15-20020a5d898f000000b007c796ac9408mr4609iol.0.1708706763728; Fri, 23 Feb
 2024 08:46:03 -0800 (PST)
Date: Fri, 23 Feb 2024 08:46:03 -0800
In-Reply-To: <0000000000007fcc9c05f909f7f3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad6da206120f4b2c@google.com>
Subject: Re: [syzbot] [reiserfs?] KASAN: null-ptr-deref Read in fix_nodes
From: syzbot <syzbot+5184326923f180b9d11a@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, rkovhaev@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14c5b3f0180000
start commit:   a4aebe936554 posix-timers: Get rid of [COMPAT_]SYS_NI() uses
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=671af399e2dac0e3
dashboard link: https://syzkaller.appspot.com/bug?extid=5184326923f180b9d11a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a4c8cee80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a59e11e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

