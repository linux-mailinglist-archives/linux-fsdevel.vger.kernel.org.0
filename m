Return-Path: <linux-fsdevel+bounces-42180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FD0A3E075
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 17:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B366189F1DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 16:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B1020C034;
	Thu, 20 Feb 2025 16:20:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A281FF7C3
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068404; cv=none; b=OyV1k2GeY2xsLDwM2L0ijaGrpjsRAjbhy5WzDhHPCdlGiu62RG7acx8wCFvMjWUFOldWuUR1AuQcJ9E05SodxtSB+yEAKkUjteN46xLej0H09waYsosk9jDLMahPppWJtg4bHJ8fstYqpx21PdQzJiTMyBCT5v4D1waNY/+HzmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068404; c=relaxed/simple;
	bh=APzJKwyhb3OuH1pPBqJmkSn0GS/wNMS+wru7Yxj4RO8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ffj92GxdfFvbyDVW6JJYidJqjxWrJwCIhhOJ40WCMbtd3OuGduPNSy5YAS0rHCiTnowXtmo9dOCC+BHpZGYKooewvuBGtC2odTHeFijS8WXNXtXEdTACCKHW2x+qK+g+wIgVc5uIy8mqBykhER/snf7hMJEsf088MuD++mYJnlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d2b1e1e89fso7609875ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 08:20:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068402; x=1740673202;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7pYURb2UEyQVm3UDJSJZBqVAJmGORVXuCUKt2v1imU=;
        b=QsksF7uMJbIYI9dagzBpfnhlkANC7kJHVjNJCX2sX6+olLz+iZBxkhs/9zFuLhMYhi
         7g6iH3yN5NTSCN/mavgKxEOOcbrJnFskGMEvBT/DxqsTYT0BMO7HlRRW9w4eKHRP8nzT
         vN90VSrFn6V9uN5NT5xrnK4+Ukpamt4AwkUs21bmk3LiKhTiY/PzhEMd9ZoJGdgOb+RB
         BbUEAD4xyxSwowImMivwI2eZ7Em9VmYFia6+CZq7r/U9Bd6pAqGyjhDNkXEPC/Y+Q/tP
         bhE/AJ2lVafOZjXHeOWpmAIlYrONtUDdpapsAg4ExbZ0IpU0TjwVN4YXGTV7ZUtRwKuM
         PnjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8ivqXJirffQH1MwSg40q0SUOOEQ0AkzZ7pyx3IGFcas5YWK3XnhmDn84OJ1hT9HrWmXPfRNrzeexNanyc@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4euF64NOsQBqfGvruojsFVud64iMkaZz8kmdl+f1QLakfa86v
	SNGMNsMJEQSM1ceNnpzQBuK00W6b1K+VY/R5JcQTMR/Hb2WHzTEv2i/gFlNWjyFPioh0otWfS69
	Sqd0C4MqbD3/nonzJzWS5eeShqGbXPzYjvQMFzjFXtyc67QAUKOD7b0U=
X-Google-Smtp-Source: AGHT+IGuEGXZgTpLDMgM/7S6GNTYnUn0UKrpL/T5rB0YUuM5iNtKYmjKbdIOL1xmpNOVQAHIaCIJ4uHlLv+tqDA4IfFw1W0JU8s5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24d:0:b0:3d1:966c:fc8c with SMTP id
 e9e14a558f8ab-3d2809066demr217751225ab.17.1740068402061; Thu, 20 Feb 2025
 08:20:02 -0800 (PST)
Date: Thu, 20 Feb 2025 08:20:02 -0800
In-Reply-To: <000000000000d0021505f0522813@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b75632.050a0220.14d86d.02e4.GAE@google.com>
Subject: Re: [syzbot] [mm] [fs] possible deadlock in page_cache_ra_unbounded
From: syzbot <syzbot+47c7e14e1bd09234d0ad@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, reiserfs-devel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e867f8580000
start commit:   861deac3b092 Linux 6.7-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e118a9228c45d7
dashboard link: https://syzkaller.appspot.com/bug?extid=47c7e14e1bd09234d0ad
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=100b9595e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1415ff9ee80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

