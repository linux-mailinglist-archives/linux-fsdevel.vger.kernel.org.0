Return-Path: <linux-fsdevel+bounces-37275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7059F0644
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 09:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B921687D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 08:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016471AB6CB;
	Fri, 13 Dec 2024 08:23:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAC31A8F99
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734078189; cv=none; b=c+mco08lXcn5cR7RzMJszMNzD+FusUZ6bCkq380os/TDD9TM1H8RLNmOV035yq6KbsrOkilwQonARH2tj4+30xK8oHU6PaYCjSx62fHbW+3OlfM8OghHJW1Q8krJl0OucNOCOKgEMt+gD75euCn76gvPXqBKMDJf3mtDw1Embcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734078189; c=relaxed/simple;
	bh=jSNbz4w1RnsH9lZjWCrMKo/BVlUNHfe20Q27JoZwBQM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fwc/qP3PXojr0XRb/7BpgUcqgb16Jcs6WoqZ7fhkHz7sJgW9fA38KPfqJX4ZDWJpZ9mPHt0ATkddHWWZ78pC8dPCoIHQi4GCwe19/6twUcIsPiN64ApGwBkpZcs9oPCJPdMyOdvmuOYzRrSu3C7QIh2UmQLfEbEBDPtgeSbRRGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a81684bac0so29869605ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 00:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734078185; x=1734682985;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NmT0etUyYtnF74EwDW8OfaDP2mJIR/g0z7goUVA0tFE=;
        b=eS3VvKEhcR9hi2wGAWa9JAcA4igtI8rhVBaPDmzoNr7sp9l0VFAKXjnj9xEl3P1Cwf
         jPezp8RTVqKD/EW7u3DSRtQwP8R8CnpA+FkBvAlROb0+WAanL6+pgZwsCgjWKejCDOUs
         eDN2ofyKRdxm1gLl6rj5mTGJhozIc2XxvmoMtGfhOZcBXgOhBkwjpvEp17raiZyH4ZIv
         BXj5sbEnz/FaF/E/fD+kIGnMIy5gW5BqSK/re41z/aIGy8/goH+DpnR6follqbZk2lh+
         Y+X1OYUmFv3S1WX3HjVuFNArU0/niqfmMbhAfyxGKC7BV6YmcRwg8pX+g3dfNSFjeUHS
         rIkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3f5CmeMvO5uYuCbsjPkufIHsCAFZl1ihW28nyHWn7GLeFTnUwiRbjsO4RHyA+Cv1X6ZOzNj38i+/NTMGs@vger.kernel.org
X-Gm-Message-State: AOJu0YzuAJskBdv8Ja0kIaTSPbGFty8GZ1y9AlVlCqWeJhOz07mW9UnR
	MJsNcIrxJkDmXXTFlqY/OTip2Cf5moN+6aZCDFraNgTUaAQkj5i4bglUcvCmAzKQTdfjWi26SQD
	J83EjcGDhtZj983CeCnvoN0xHXi09db8eHFBN/8cKnUuYKVTcslfUbCU=
X-Google-Smtp-Source: AGHT+IFDwGMIWC1iR1sN8gL9Qtg88GQWTe0UGzFyZY6cOGt1QZYevlntalMOaO9d7PMXhbqJ1e65GQo4UWMrzlvOPmvIPrH7ZZZf
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3886:b0:3a7:2204:c83e with SMTP id
 e9e14a558f8ab-3aff50b5931mr21720655ab.10.1734078185380; Fri, 13 Dec 2024
 00:23:05 -0800 (PST)
Date: Fri, 13 Dec 2024 00:23:05 -0800
In-Reply-To: <PUZPR04MB631683FE95D7335DAC257CCB81382@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675beee9.050a0220.cd16f.0043.GAE@google.com>
Subject: Re: [syzbot] [exfat?] INFO: task hung in exfat_sync_fs
From: syzbot <syzbot+205c2644abdff9d3f9fc@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+205c2644abdff9d3f9fc@syzkaller.appspotmail.com
Tested-by: syzbot+205c2644abdff9d3f9fc@syzkaller.appspotmail.com

Tested on:

commit:         f932fb9b Merge tag 'v6.13-rc2-ksmbd-server-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13af6a0f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7c9f223bfe8924e
dashboard link: https://syzkaller.appspot.com/bug?extid=205c2644abdff9d3f9fc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16738730580000

Note: testing is done by a robot and is best-effort only.

