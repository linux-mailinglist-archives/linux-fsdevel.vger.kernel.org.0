Return-Path: <linux-fsdevel+bounces-9495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5845F841BE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 07:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E93F1F26122
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 06:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F1038399;
	Tue, 30 Jan 2024 06:22:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6C238388
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 06:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706595726; cv=none; b=GRUHmZxzDPqqopt6e0kVZ7xMhvcIEyMtBexAvoI2twW/KwQuP7ZfHfZrE8GOASUyRgq1bKJ2DGoBVlyLT9nPAv/twyyUTCF9ey8sGDohDHxa50LLNZmRy4Oq8g0WokUUobwkO/6CHNJsv+ItMg7V/rqgP1XXpcnY2NQa6eswn/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706595726; c=relaxed/simple;
	bh=r5Ux2iyL+AtcuOKpR9DhMnN0TKsSJlW0pyPduii04zE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oE5nSLLrZevWF2Hal1J+9V4HyTIvK8XkXlX33DhOPzZurCbg/1wURfMUKmtuUddCKkHAxDsPkDyDoDFVtTeayvD3pnfqNX346ml/dsdfkrDA8r9rFOHHSdrQI+6w4zXhMn8nSMTqc6Gizv6XUQxpUKpXcRtriw+42LmX+kgQdMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3638e475deaso1980685ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 22:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706595724; x=1707200524;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QA6ideeye3nTcQmEXGXWv37hgB8xmaoLG/vHEi175ho=;
        b=VBpISR6yjijMUpsbR74cgWn3HcZxddm9N7H6lfvjU33orhK3iaKGlnkfiwysYfxuiY
         DF1a6J0/lt1pUAbxgMJJR9proJSqbAsvaB+AuQ7AENkoFC4RqwIV0iFKn2j+93yuRXBH
         FKw7nlSapI7OmTrv1uVBd7mW8guC2hfqCKzSBaZbbu7r2MrRycqKUeZkbHlUdWWu0zQK
         w+V8tInc4eKKHInyqbena9sk88wcASUYANgG50HxEJCYpBzk1jGi/Gi6Ml8rvesy1IAs
         zuHgRcXgao9mlChOfuOkAS8s07tg0kcNJAVl90O47orVkdQpFDm7XEn1X7JM7cPc9Av6
         dgcA==
X-Gm-Message-State: AOJu0Yw5a3uBfH4675XPoaGByRs3MUNJUPYkBZD58VaThkprhKLCFwv2
	oWgzju3VPwejm/ji+RxMPsX/yl+L51fOVsho5U0+nhgnQHvNxs7g6aHM+8Ec+uod5MhSRYyruZE
	bVVK/YQp7XXzzGr+nbdON35bQOWF44qITntVwMOrSsM95XhzjfOfFV4Y=
X-Google-Smtp-Source: AGHT+IHvi14tnxAPWo4QWV/I/g+7W4U0Ez/MIMUfbRrlXheZgCmN45tlrld5ljTOiRk3OOrsPbvbcRirPawZgmaQpAMC+RUcCaIn
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c02:b0:363:91a3:4b60 with SMTP id
 l2-20020a056e021c0200b0036391a34b60mr5312ilh.4.1706595724354; Mon, 29 Jan
 2024 22:22:04 -0800 (PST)
Date: Mon, 29 Jan 2024 22:22:04 -0800
In-Reply-To: <00000000000044b47605ee8544b2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ecec7e061023c790@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in __ext4_journal_stop
From: syzbot <syzbot+bdab24d5bf96d57c50b0@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org, 
	jack@suse.cz, joneslee@google.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nogikh@google.com, syzkaller-android-bugs@googlegroups.com, 
	syzkaller-bugs@googlegroups.com, tudor.ambarus@linaro.org, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d23c97e80000
start commit:   eeac8ede1755 Linux 6.3-rc2
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=dbab9019ad6fc418
dashboard link: https://syzkaller.appspot.com/bug?extid=bdab24d5bf96d57c50b0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e5a788c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141e64e2c80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

