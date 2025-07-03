Return-Path: <linux-fsdevel+bounces-53775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F99AF6C6A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 10:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1EE1641E8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 08:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81012C08B3;
	Thu,  3 Jul 2025 08:07:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADC8293C6D
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751530024; cv=none; b=UtAK+GCHQFXGIdACsQkSCxFR2z0lkSx+yQzIPAmz2xLFI8x6oWR6GU3TZslGuVpl2mh+QXkAGNGlGAiExlXh3mMQFq5UFMeNjJyNJ7VJaO/4cycyQDk4Cl1jytSQlsGL951ITTBTlINqAkJkaRyyR5jVwX7qWjxFX0Cr4TBuavg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751530024; c=relaxed/simple;
	bh=6SLDQrtFq2uE49WVnxjLVqjIr3a0GuM7Y4d8VzWInIU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YWOHz1feiFUfbHPMoK0YdKlDmsi5bG7SVeVhwpUbshoFQJs+OPY4IPEDXsjWF3YE/F98G0rFpR5aJ9qB6pfEO1O9o6wguCSziKT9sRtrFBwWlv3uQJqQ0D+nJVs+hDmdfolmgEXUwACrNo3K3wpxvSAryLMwuPwQWO5DEii1BKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-87632a0275dso614720339f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jul 2025 01:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751530022; x=1752134822;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3hKl5Ia/jKC0Yd7lUOzXfYy0UlX85jIR9h7CqoUJHPk=;
        b=EZ5Y+vIqRP60ja9klDINl3RAejp49DiDhGFVIcxGZcdygVxqT9gdaHNGHuQKt3EoLJ
         EYePw8s2vAHFG0h+j5myoNUvYO0Y+pr7ajjzEOJXx8Jka5r/raW6s1JyshAOTTHH3Y6l
         IhL1UMSZskNhR3+/l3Axm/oRdCLf1GNg9lt236jPuEDHK6NivyLtrW+ShWV8D4GJQUdD
         qE+DNXXxASH+xgsvxvxdaXvYpgXf5h+0B/GvBzcCH0H1L93Ugj3Wehqmk6GS1rCQBSsQ
         CyYcPL8qbq8HZoGFnF8zivPoshYXHVT9lXpZsZlByta0LOamQmmoRG1/MY9QV4tHoPCJ
         OTHA==
X-Forwarded-Encrypted: i=1; AJvYcCXUcNGKjS+FoLo1waNo0gQHJWCBKG4/Xb5VfvA9WWuOQ+usls/Sx2os5Q9v6/2O8swaaJSGpMfMjUoZF7/z@vger.kernel.org
X-Gm-Message-State: AOJu0YxYPGE6yhMS8b1nB0uTkH2wG9II6h4BOBWlgBXoxbbCfdx6RVXQ
	1wgCgH6nMNFtZyhHVsbeVtO+cq+70YJ9MG6fUqrOXlR4O9u70/3xWYxJZIg+C2izg9rmPf7lVvV
	pTinNBfx4oOSEDqi2MsrBoUT+m0JK2Zw8C5r8fB5L9Tt/v/OysC1EppepAE4=
X-Google-Smtp-Source: AGHT+IFHEHLjcWpu9j2fzi8xyd5CDP/yiePQGBUZyFCCw6WjHXkwTCzEx5NWZDpvvSAkDH1/M0eUL8oNkp1nB8pYZMSHHsHHN/Lf
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1584:b0:876:c5ff:24d4 with SMTP id
 ca18e2360f4ac-876c6a09d1bmr967003139f.4.1751530022059; Thu, 03 Jul 2025
 01:07:02 -0700 (PDT)
Date: Thu, 03 Jul 2025 01:07:02 -0700
In-Reply-To: <6865e87a.a70a0220.2b31f5.000a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68663a26.a70a0220.5d25f.0856.GAE@google.com>
Subject: Re: [syzbot] [exfat?] kernel BUG in folio_set_bh
From: syzbot <syzbot+f4f84b57a01d6b8364ad@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, hare@suse.de, 
	hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mcgrof@kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 47dd67532303803a87f43195e088b3b4bcf0454d
Author: Luis Chamberlain <mcgrof@kernel.org>
Date:   Fri Feb 21 22:38:22 2025 +0000

    block/bdev: lift block size restrictions to 64k

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15ec33d4580000
start commit:   50c8770a42fa Add linux-next specific files for 20250702
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17ec33d4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=13ec33d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d831c9dfe03f77ec
dashboard link: https://syzkaller.appspot.com/bug?extid=f4f84b57a01d6b8364ad
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c93770580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1001aebc580000

Reported-by: syzbot+f4f84b57a01d6b8364ad@syzkaller.appspotmail.com
Fixes: 47dd67532303 ("block/bdev: lift block size restrictions to 64k")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

