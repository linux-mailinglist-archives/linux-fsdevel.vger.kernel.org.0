Return-Path: <linux-fsdevel+bounces-18303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADC78B6B2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 09:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA681282BCC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 07:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22813AC2B;
	Tue, 30 Apr 2024 07:12:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A8A2C683
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 07:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714461150; cv=none; b=nfz1TR3tI8nSWkwfO6bOkvHTZiczKCelencWVZtErRK/63migY2OxaA2Qvyqw6K77uvvJ47HDTj0e5TZu8dVxdaQ11QpLuadTEqaExXmtB0Pc61/e/3hnfm2s2pB58kO45Z80BR5EKnFodrij3SDTMsZLDlJkOY4EpY1jz8sI+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714461150; c=relaxed/simple;
	bh=8kOIIkTnsdnSonUhLv9/UaA+zad7K0ZVq0aEzCL8TUQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=T26HjBqx/IOIOq5oBuqOGvBkgNB/6PYH68h2N/TNKPtwfDHtkAgPZ618miqHKphcbjprf3yHrEsO4riCvK7gI7LdptTdovJmtE5D0o3r4OmLYEvyE3CogTCChsvIYef/KTosp3GCEe5EH92DzI6ReTvYOpMnqWfjII8usMN1CCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d9913d3174so555272639f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 00:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714461148; x=1715065948;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4bIJ2+4VC6gGGh8bBw9yymu72oC7PpvLlQwyhTnjnXY=;
        b=Ncs/sBtcT9IvMs8n1KVu4j3lt2Zs6rlk4aNry+Dd365XMRzJeehIWDfucNOykUmZmp
         Jmos4Lw/Gc45lPdrsyoghm4VyXZP40oURdX2pFGtCkqMiEap/72pdyVq6URn9KvMynom
         uqLNDBC69APumHOatICNdnqAfvfmaozHsxvvtBVFBjmzjFC2udEKI746dxcmxYsoLX6T
         eaCnrXZPgMhcI3qyWjr7yRFfndzo4MNBkkHvyzYx241O4enpJadDo1FxApLpNlJFKsNr
         Hq/nad82lH1CH6kdH4bLIiqRYIPa4NWKeVdeg7zQMkfNP+woaLAHf6ZOt51RPKHMAOY9
         jsAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR+zkP0ISSWHRrwamjJu33EPy3b27PILBT6UK8s/nR0eIZiACZPyKBHztubm6KEVxNFKO0D9fgJBbHHj001a7y7fQepawAvKMosiFW+g==
X-Gm-Message-State: AOJu0Yz43l075wm0gx5CHEs+HBoZJXkvHkBQ/m8wCz2jNwfUQeruLUuA
	91NsJVEGvhrItywxnKt84KCJRgWviRMd4iDbn9UQVqYIH+lFB5Tqzkd5Y0IxXt+KAX2xuEdSFs2
	5jIxLjPWNtHSqHd8SsfgqC5CS4a6B9BX/KkVj9q50LB3EAdOo2e259bA=
X-Google-Smtp-Source: AGHT+IFC19oIKhGX1rlYJgjVBL1OU7Ig1NdVc43Vgmk4vIZTiGKO3wuegWsILLqMgXIqc+uAApbL2U1YHW0jZrTQd6w8v46UpXIY
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:450b:b0:487:4afc:b6b with SMTP id
 bs11-20020a056638450b00b004874afc0b6bmr647191jab.4.1714461148035; Tue, 30 Apr
 2024 00:12:28 -0700 (PDT)
Date: Tue, 30 Apr 2024 00:12:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5c82b06174b1793@google.com>
Subject: [syzbot] Monthly v9fs report (Apr 2024)
From: syzbot <syzbot+liste18b65911e42aaaf2e63@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello v9fs maintainers/developers,

This is a 31-day syzbot report for the v9fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/v9fs

During the period, 0 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 28 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2768    Yes   WARNING in v9fs_fid_get_acl
                  https://syzkaller.appspot.com/bug?extid=a83dc51a78f0f4cf20da
<2> 6       No    WARNING: refcount bug in p9_req_put (3)
                  https://syzkaller.appspot.com/bug?extid=d99d2414db66171fccbb
<3> 5       Yes   KMSAN: uninit-value in p9_client_rpc (2)
                  https://syzkaller.appspot.com/bug?extid=ff14db38f56329ef68df

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

