Return-Path: <linux-fsdevel+bounces-46667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3F0A93627
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 12:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1AE4472F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 10:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAF72741D1;
	Fri, 18 Apr 2025 10:50:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731C72638B2
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744973405; cv=none; b=tj8xHdusR49RorQcJ8oYbOANP4erzwJetRDSVD/mqZNBK67wWgj9HICPmhwfNKTom7k7Vqvciz2CZMSW881jBzay0n6NbY52fBWEcbqIRjUQoWkqpCSKwsJtlH3qkJ3JSvHS9cxRm9dPUvBTSWrXPKYOLOEa1jx+lngJT0s5DMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744973405; c=relaxed/simple;
	bh=6IvHvO34svGf8pJpp1sKWE4gOCANDwDyt+nvbA08RYI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H98Kqw7eEEY514RUyYmvslRez+eku1gzLB955R0KKySp8Nnktsbck2qvbCuBR4v62RS58Ss1F7N8vjb/+yKdjZNl1I+Lr6AObJQZUcEyT9+ZWzsJrLb41cbq8DWkr/gUy1uo35hasCzj+yxmCfEcaSC3n8kRzXhsbHKkKiTyjTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85b5875e250so183221739f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 03:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744973402; x=1745578202;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CxbDJ7ueduouDWsaF8IaPTOCcmRp5qlfOMhOQfL6pDI=;
        b=HANRg3JT8P9pBzZ2VGOjdo60GM+6W6yAWNDzBAyvBiOj4huqNTLEPtByRURJLZT4+B
         uhCT+gKocAime9lqI0uI0GjWvzvJTQLUhGnbs91QJBuFfnpdUiurp6CP4I0YTQegkz+G
         wmAKtHKc8mdeyPy5PjgOPrf0tabW02NjYuZRQLUNCBxEb8lIwX9aFmr/fs+p4viYw7Bo
         dEORoLNdk0acjqTNhbZt7ah6SWFtQgIvANJtsEtZ/vEvk5jmmJnex594iALkCaFdOWmI
         7rUFUg43bgFrpPxAYkJGL6BqezFK9+5w6Jtdeha2mfLDsR4N1iVkx1ZqkOmi3FBJ3lGR
         TbaA==
X-Forwarded-Encrypted: i=1; AJvYcCWYW4L763Kgw3VB7KC3raJSrjJvuhJ936YiiFknWkuwmH0ktt5/YHnKU+5lBs/bNeW47tRdluHIja34o2G2@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl3WuQd1TSFJ+A+na6UWYHYjmbNi/5jCnVaHkgeZqid3mvZoZy
	kEY4DvtRb7Vw/4iQ3NTQGWgc88JZfFPMvoiqP7TiX4MRUmWtR6ilC6vN9JUszioYbd5W/Gc4wnN
	6kNZT3PXtsnl+OokqwRgP3Sg/zo9/gWzcIj7PBwamPdnLmlhj+kEFXQs=
X-Google-Smtp-Source: AGHT+IHxTtB3kuGO2TLldJDypIVRj5uWK6H+6lxmN4Kbou0amMtzP99dPIyzkW9pTjSEH4qMAJg91nOJK5ZXy7VJNlZ0rJJIVbqA
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216e:b0:3d4:36da:19a9 with SMTP id
 e9e14a558f8ab-3d88ee75e56mr21212675ab.15.1744973402618; Fri, 18 Apr 2025
 03:50:02 -0700 (PDT)
Date: Fri, 18 Apr 2025 03:50:02 -0700
In-Reply-To: <20250418100943.108533-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68022e5a.050a0220.5cdb3.0018.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_brec_keylen
From: syzbot <syzbot+5405d1265a66aa313343@syzkaller.appspotmail.com>
To: contact@arnaud-lcm.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5405d1265a66aa313343@syzkaller.appspotmail.com
Tested-by: syzbot+5405d1265a66aa313343@syzkaller.appspotmail.com

Tested on:

commit:         fc96b232 Merge tag 'pci-v6.15-fixes-2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=132614cc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a27b81e0cf56c60b
dashboard link: https://syzkaller.appspot.com/bug?extid=5405d1265a66aa313343
compiler:       Debian clang version 15.0.6, Debian LLD 15.0.6
patch:          https://syzkaller.appspot.com/x/patch.diff?x=112aa204580000

Note: testing is done by a robot and is best-effort only.

