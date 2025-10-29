Return-Path: <linux-fsdevel+bounces-66207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83507C1980B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 10:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F96D3BD74D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 09:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDD02DE1E0;
	Wed, 29 Oct 2025 09:50:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455D02E22BE
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731426; cv=none; b=f2QjdccmFkO6rqh3p87jh262E+bk1L0Xtth025FkZCFaUDd4we8ZQ/UdzBTpcv+EEhtOPx4JWsYulcZCLiT3MvdjeKOdJP0mZxCDOITbVbJ2KsFf0BcHt6xVd3AzDWR3WsThSEpJFX2XGDIzBiNCKqLQaGf74Xulc1KnyiJp9kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731426; c=relaxed/simple;
	bh=i2274T3EiOfn6UpUQwtwrYisfXS3VSVxRaByoKyNgIs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YzigVIhqKQGXu6dkvqf0O7FSmoUKewb04+OXxGMt9J3L0QsjdRfInw3pdZkjCJHGU2w5UOk3AtieoAkZySDmLixeyNwI6msIOEA1M6HlRUVA9QY8BAsfiCmA+cseMlXOgHGcL+LQh16oR7uQH6jLRBQuB91EJ+SEPx8t8ZLroQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9374627bb7eso92321439f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 02:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761731424; x=1762336224;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jwoSeUsY61j27pfA6Y+vP/gnRCBaC7z+pC1Hkeo8ai8=;
        b=uL2mOq56J3wpuRIV4nfWwcNQDGxp/Vr7hyUbcKlPt1+07ipzifbHPg2rXx6HY1uPZV
         TEeYLEtAfh134jljs5J42OPgR08ON064nkWecsdgW591NL36+GsTEnoHHy9o2l9qEnUa
         k+Wurv3LCRG4VDptv68yh2ITVv+qX3LnrHcRRzHBrIc6lfwc3BEavXLA4COs4qCutVYn
         rG6ABDDB6/L4G3f1x8fxp0f8AxG926efeQUWtudDRSxKpPhvmnZ2H/bqtBKHO9QmibN2
         2+Bnn+QlWI2Hk4XEXBLCFYj2rBiN8Ee2deUyoMuWOOPCXbRCnp9iKZG6DTsk2MScLq45
         qnSw==
X-Gm-Message-State: AOJu0YyPVPzQKEDjyr1H9no371wY1vx/khpVxY1aE/0PclNmgsyS2tdD
	YSXrk8JxrvJ04mWlCas+/B1Wvb6eSxpNsRosRlFjgkVVhPzDmMkAyIZvkrQK85ae0KAJBXFAzar
	5Lsqsscpu1yOI7ZFQuqG/A/eLnzi9Cu73tzTXXdzofQUn1bWkANZlvMLZf+8=
X-Google-Smtp-Source: AGHT+IHJEEjGrzy7XELdwqGJKXko10bukKrbj4WBmWxVYWNBo9BpdJfqRZwCRKvltDZssxx6wGHty7y/021k4/UQzoib3H51RPcA
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:9:b0:430:cafc:df6a with SMTP id
 e9e14a558f8ab-43210445659mr75948155ab.15.1761731424228; Wed, 29 Oct 2025
 02:50:24 -0700 (PDT)
Date: Wed, 29 Oct 2025 02:50:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901e360.050a0220.32483.0207.GAE@google.com>
Subject: [syzbot] Monthly fuse report (Oct 2025)
From: syzbot <syzbot+listcb1b5ea4746c3aafb761@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fuse maintainers/developers,

This is a 31-day syzbot report for the fuse subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fuse

During the period, 1 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 45 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2470    Yes   possible deadlock in __folio_end_writeback
                  https://syzkaller.appspot.com/bug?extid=27727256237e6bdd3649
<2> 488     Yes   INFO: task hung in __fuse_simple_request
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

