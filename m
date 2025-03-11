Return-Path: <linux-fsdevel+bounces-43713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C11A5C337
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 15:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1903AB42A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 14:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C4C25B69B;
	Tue, 11 Mar 2025 14:05:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D9E253F13
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701930; cv=none; b=TINZ93gIvTvZqZDWSigrK+CSIWep0dXkkN8RBdgGCnvCGjtD+tdJQINLARpHVpqUo+DCLxB5gP+/yUNUuQJcs5YTuGCHucMKqWvjDYbZNsmOAP7gD0CF6KwdzVo2kg9vyq+ziB7ZohR8HAiaiVd2/tg13gagEyqUiDq4X3ZMwuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701930; c=relaxed/simple;
	bh=J3dU4+pSvGnhcZnktKIwuBfpfDsywJqi8ZI3XVhfpM4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SmeYIFt6DZpONH/889QLmFkV2XPPYhm9AEMfzPKHobQeuto0LgqujDyCZ7DMsfCw3vNpqddBKGsXB1WEnn6Pc4Zab6Fd7gKwBi4Zml3j+yOL7u6DtkSbgW8XOHPmszT6/MTJ3G8KDTBrtb0qMQdYNq8LgmZzuCFz6zs6PjJkNoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85af8bd1010so480634639f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 07:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741701928; x=1742306728;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aCJL+tsWtR/2aLDIIPayU3/jY5LVGiEAzwSErKvzPQY=;
        b=KaqLbtBOZQPWaeWsiOR5W0di0SiESdnZg/WOvn29SmcbifDwYh3C08T1XDPXKcPpO5
         2HlFfVXwi/C4Ul/AnG2uDsh2AeTNZCtqf1/PoFDDOs109vdnV0/df9IYAowpY3+fbjzO
         YxUwUMx95a2qHIk/RcBt6012BxO6MH3B6G0pKpeeLoHli2vaPEUoOFRf/iHIewt3H1hI
         KREUAKWhxbaBtetABUILfDhG5n9f99ySZ70WQER8+PsNjE9cjs6eTpN6LnxyaHB0cGYa
         HEpqDSQKS8fB8pzoQItb9SpbBpttiqY/QX0Sld6tZxISQ1JWwpp0NWh5Ep7ehlfoXwum
         cW6g==
X-Forwarded-Encrypted: i=1; AJvYcCU0l8ugAFgK7fffGWuV+pN6iZJecggpEJqv7P3IhfviGcbRbSVBybedaoH9RsKs4duxWrNo4v1YgZFeLxb4@vger.kernel.org
X-Gm-Message-State: AOJu0YzPY4x4h3z/e2oVRrM8YY8uXt1NNZHLcbzLdMZ4Z8tdG9YmI9lt
	f9g/oxsFw/G+v4abYlj3W4eK826MCgAFvwbTGm0fnxlKjqt8fk79kfXks/7l/40XmQoa9Cu+bcD
	d1zRqqSRx3PNKuZRihWOvtYxWiAGyKLF8+Q1xOiLlhn/qRBYuWom/UVk=
X-Google-Smtp-Source: AGHT+IEAYhezGVOq/Lvj0W+L9exDil80kEgDIi1mq2q5XwzW0xRlrG0tx7LrHm3WiNgrUfqCfXy68Nf/24WR0biLw2mgPC5CyIdp
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a13:b0:3d3:de5f:af25 with SMTP id
 e9e14a558f8ab-3d4690a4dabmr45263025ab.0.1741701928144; Tue, 11 Mar 2025
 07:05:28 -0700 (PDT)
Date: Tue, 11 Mar 2025 07:05:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d04328.050a0220.14e108.0004.GAE@google.com>
Subject: [syzbot] Monthly exfat report (Mar 2025)
From: syzbot <syzbot+list005cd041278fc64ff364@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello exfat maintainers/developers,

This is a 31-day syzbot report for the exfat subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/exfat

During the period, 1 new issues were detected and 0 were fixed.
In total, 15 issues are still open and 21 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 92      Yes   KMSAN: uninit-value in iov_iter_alignment_iovec
                  https://syzkaller.appspot.com/bug?extid=f2a9c06bfaa027217ebb
<2> 13      Yes   INFO: task hung in vfs_rmdir (2)
                  https://syzkaller.appspot.com/bug?extid=42986aeeddfd7ed93c8b
<3> 11      Yes   INFO: task hung in chmod_common (5)
                  https://syzkaller.appspot.com/bug?extid=4426dfa686191fab8b50

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

