Return-Path: <linux-fsdevel+bounces-15303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B08188BF27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 11:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2A41C3C71E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 10:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E6A6774E;
	Tue, 26 Mar 2024 10:19:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D084658139
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Mar 2024 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448369; cv=none; b=Varcnq0IcM5No3qXaX4yjPL8/sejqAyGtCgmauWjdmiYpgAlFF9uDInhmlsXpitryPWunJ2vM9Mem2lvInh6NS9abnJZYtDRYaB/Mm+wzRg+ntloKPU63LgjFhhOj2AcNULJRLxp8F95hBDw5H+GZlLto9mYRlDwBpREwFc3GUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448369; c=relaxed/simple;
	bh=JktfbOUl+kheRtzZv7WDpCfsD/vsnN+YGRCfK+4fz/k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GYbuCFZ6Gq3LKwo6yF5B8ru2lThtMeeNG4/oE1VDHOhlg3jT9NC4U04Lznr3WPlT/3jthnNnGN0UPjvSD1xz+JWxkENAjRLuunr5h0DoTAensmhtR6lIdTi7teuP3GyyRDXp0uafiVUzgdFpirUhB8AbQ9S3IlMyRA+6H0Ywc8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cbf1ea053cso607499239f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Mar 2024 03:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711448367; x=1712053167;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kYw4ctmGeQJ0pMROz3CBzYIrU/HbsnolOpz1gv0N+Ac=;
        b=qDZocWKEcRFveUk0EJ8RbSjz7PtCP/06CMkYprFOw/NfQ/W6L24BK+8zYuanUALlZa
         ddwC8Bgc9h1YZDXeON1mBzQC5jy7xmTOovwJ/HVMafDPs4W1ou4lkX+VgeJdZAQImx4k
         c0ahLlyWORQIoNBIv43DiJLfgGXFi4ugjpQ1ewf7PlKgkj+RYtZN1Zk8i8447Cxuct1S
         YvybSykEK23fmexw1Nks4mMdyyTMnEbrJevZIWhrkkQ+1kDReYykksu7n9K9Hmlit4sz
         DUQsov9FAhiTl76POIHGcdaCY7suOhOZhZ6maI9OI5GyDpRCVoIMNJL8JUQbCdnoZgJR
         EyNA==
X-Forwarded-Encrypted: i=1; AJvYcCU0smu/PUeo0L9i1lclYBnWuhsKvuoevijmyfyaZTHD/daYo20P0A9YvgTaE5tP5LbMCU1J9c0QbEo/vSQYB6qJq7H6PkXYc9TN8YG9Cg==
X-Gm-Message-State: AOJu0YzfMcC/Nuu/IHcAFJv583T5IPtv6zUUPZzrVSzcFbGAQ+Ebr0AS
	+FtFeUv2uThrtRX7R8/hCcx04aNNkPPSUX8WcxatFCUqwxvxZwMnvf9UPYLEFTUqGmx/3D4K18n
	hlC/7ISAPavnmsbItL5DBFrPaGiXLE+DUiRuL8l45enkMtqnKFux52a0=
X-Google-Smtp-Source: AGHT+IFoUxsRc4aBQC7u3IilKqLn+U4wOXg7jIkK8Q3DGbnEHReAV2sq3tur827cPtI7zhKrBZLEVgM4g1qBberEDOss8OvkYZPA
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1654:b0:7cc:3370:b84f with SMTP id
 y20-20020a056602165400b007cc3370b84fmr288027iow.4.1711448367178; Tue, 26 Mar
 2024 03:19:27 -0700 (PDT)
Date: Tue, 26 Mar 2024 03:19:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa39bd06148d9fa3@google.com>
Subject: [syzbot] Monthly gfs2 report (Mar 2024)
From: syzbot <syzbot+list7455fa46f189bed1f655@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 1 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 31 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 5747    Yes   WARNING in __folio_mark_dirty (2)
                  https://syzkaller.appspot.com/bug?extid=e14d6cd6ec241f507ba7
<2> 700     Yes   kernel BUG in gfs2_glock_nq (2)
                  https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<3> 6       Yes   WARNING in gfs2_check_blk_type (2)
                  https://syzkaller.appspot.com/bug?extid=26e96d7e92eed8a21405

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

