Return-Path: <linux-fsdevel+bounces-70189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0945FC93311
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 22:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC21034DE4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 21:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEB32DCC06;
	Fri, 28 Nov 2025 21:22:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993F029E0E6
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764364951; cv=none; b=etPwVgG5mZ/TUzWilhS4psPKn7+Y4SoGrOWkQxWA2ggDIiMhMjtJXU2/1/RJSOe74UKtpiDRu8Iv/cUCKG56yGwEUga9Xobq7pKFox537GkUdP/BXBCc9reMWt+9rmN2BoT+F4upzMB4v76Wx0qep2cRld/jTXWL+LIsZ0snFXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764364951; c=relaxed/simple;
	bh=wDLI1FJqt618g4CS+c3Nuqe9hgl3XWLSi4bzViM+PBc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iLqVKPe3K5kjg/JJ2fn5Puhh6Uxa5s2MV4Sz4GxBrk+CvUbfg9SC4vPFSoC+ZmgM1e/9afzEGMOuq7KgJhfkb36mvmgJ4ZXIzxiIQMwEFffm0HYG9mOQYb3qiuwCQrnpg14gK/gLayNRnUX/O7cxoMUymDEIoxIZG1cYmblGu64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43373c85296so14565605ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 13:22:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764364949; x=1764969749;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kIm/6sPIth/mW4pwi+Z791sncu3E50XEM4sNcVTlSXw=;
        b=ktzB+3SlG2HA6Zn3bHIy8ndpoAnmu6KkvuIHRjHAuZ+FxKZ6QJ1V+1zvC6q/2yxZln
         HiyZOIL97y4eUW0IB1kY9vNJ5biIEJr8xYZvPD+jD98y1GX7x+JeqbGKlZH7c5TfQ+sH
         1WYv8EFQocF0mfIjEvrFCGQYwvsg68cg6kjibi3CWigszT6Vzh0DsS2lF//mw3+/ipJL
         HTwes/RCTCElUTPwsJCEPkbuwp7lLuhT005Ye+zGqSHbM8WASZw60pWgyyFgjY7K4efQ
         UGzFB4UKHRXC2hO2ruB0zrnfU+/z/4vJRk+6qp7cCGCSrMG9VoBgCfg+aiHXYMPcLoIt
         IUZA==
X-Gm-Message-State: AOJu0YwOl8KVGnP2av0VoOtiNSkv99flqz/y5rxVw++xWcbLnrhd+Tpc
	eAXa6WhglSCZj4WHghKc+6JUzw7a9IX/0GaM0iiNLI6xt+DhIgyE4PrrVfwZrK9Yy3tI7GxWGUJ
	8NjY5p6LLlhs88L1ixwQldYvbzUr4sY/VCk/4U3wQ9meHc4t0qoIkuS2gWvg=
X-Google-Smtp-Source: AGHT+IEmMYoccYCs+JCwu1yQUvLWrA3m+BPaV/+d9irOe9Pj+6qBvDkLrU14TdKupqW7OsAfeagXR0+RdLjSoC4DkV2WU7xh79Z+
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148f:b0:435:b35b:4b4a with SMTP id
 e9e14a558f8ab-435dcf6c552mr119497045ab.0.1764364948842; Fri, 28 Nov 2025
 13:22:28 -0800 (PST)
Date: Fri, 28 Nov 2025 13:22:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692a1294.a70a0220.d98e3.014f.GAE@google.com>
Subject: [syzbot] Monthly fuse report (Nov 2025)
From: syzbot <syzbot+listdd82aed148b62a5fd3cc@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fuse maintainers/developers,

This is a 31-day syzbot report for the fuse subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fuse

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 45 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 5967    Yes   possible deadlock in __folio_end_writeback
                  https://syzkaller.appspot.com/bug?extid=27727256237e6bdd3649
<2> 510     Yes   INFO: task hung in __fuse_simple_request
                  https://syzkaller.appspot.com/bug?extid=0dbb0d6fda088e78a4d8
<3> 47      Yes   INFO: task hung in fuse_lookup (3)
                  https://syzkaller.appspot.com/bug?extid=b64df836ad08c8e31a47

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

