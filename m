Return-Path: <linux-fsdevel+bounces-69668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EB8C80916
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 13:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 218F5344040
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 12:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B1E301707;
	Mon, 24 Nov 2025 12:49:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A75E30148A
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 12:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763988545; cv=none; b=bV4xI9j9jIREtcyAZjMro3OUGZl1A7eOKYtFC+/xBetbmYEjlHg4QIXQ3yk67FXoTJ++QgywsuoAgLr7SBt3FPyf/ZHcJ2S1x8UhFWMeXDkvOJqcy14oUXSWwC4uIdYge81kB0eEPH1hRQ2doNHTLjxNAO7wXulC3OfRr8W0upk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763988545; c=relaxed/simple;
	bh=aTBk5wv19Muo+2YnrH6f1y6i8RWb75+ynZVuEOxj3xQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VT5DbomtSGFdQ7H3IVWjuWOXx797AnFQB3YSzFGF2XGjLq/q7ZCvGTGKx8mKjZ8mjxD0Xq5dJzvhkNrG0DmjLUcRcCvu60XC/zIsI2tOTloLpvVunb30zBXpnGvDQbfSQNerl+siZruF/2MocJWNILL+mgJWOh9DwbwZV3RBaQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-435a4ea3e62so52484195ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 04:49:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763988543; x=1764593343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSZ0UBzx7Do0RZn2Lqa+4OV3iFUI/WAfqveTON61e6U=;
        b=KY5e2yDE2ARYJ8MeByOxztuNim0IT8vCKqsRZshkqRJhn51+UJcR/p/BQQe7LCBRny
         qDwc7oh8m+8BiK57eFz+1IguEOUa2/ve25xHPxDuAZUwal5xyd66c10zcYEcHU6Voi1X
         ylfGodxQQDeFoRfWGaguDxszO3/bEH+gHxz6HKQ5sY0MZLt0+ilaCtVDFDJw02CLNGsx
         yyx3MR/BkMzuzqQx/tIqB/PkjLllVquZUk9hxOg/yWkr/8KI+mMEToml++3lTnxU/A48
         xAujfP6b+CcFqNhVTClCNmsfNhEShNkQViel5D5nDnRxf8mTLxxp29g8xE9QpFsckqfq
         JBWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6vibT2PbA9YmQoR0yuVCw5a/ssAvwodjlStTrQ/0ZDsn+5MmjrERmxdArj3WDgaI5faGFPq6ij5Bn8V3F@vger.kernel.org
X-Gm-Message-State: AOJu0YwUD9UaBmezLva0Hy6wwWM4drWFuwaElq85AaewzV3E1zLmaHQX
	W/PJNuirJde4GDuqI+Bwa0dfci2K/feJ/Jptgq+QojFjdEenQxT6SejmaloxSgv20OdU8OFB02y
	jCttuqnBOVgNeqbMH5fYgmRC9yTuhLqXI1D4s163rVhS4CcA+15twJkBSdic=
X-Google-Smtp-Source: AGHT+IGBBr3IIE4ZeKrQ7xmh7rz8JmRd+QYgzIma29JVdy9OqyF8T6hDHLeH7MsHmtpCXlQrb+hhY3J3LUjqLMe422QXceU8K2Pj
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cb:b0:433:79e4:7adb with SMTP id
 e9e14a558f8ab-435b8c09e62mr94945835ab.11.1763988542832; Mon, 24 Nov 2025
 04:49:02 -0800 (PST)
Date: Mon, 24 Nov 2025 04:49:02 -0800
In-Reply-To: <aSQlrJxWxNyCVt3z@infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6924543e.a70a0220.d98e3.008c.GAE@google.com>
Subject: Re: [syzbot] [iomap?] general protection fault in iomap_dio_bio_end_io
From: syzbot <syzbot+a2b9a4ed0d61b1efb3f5@syzkaller.appspotmail.com>
To: brauner@kernel.org, djwong@kernel.org, hch@infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a2b9a4ed0d61b1efb3f5@syzkaller.appspotmail.com
Tested-by: syzbot+a2b9a4ed0d61b1efb3f5@syzkaller.appspotmail.com

Tested on:

commit:         660f4047 iomap: allocate s_dio_done_wq for async reads..
git tree:       git://git.infradead.org/users/hch/misc.git iomap-dio-read-fix
console output: https://syzkaller.appspot.com/x/log.txt?x=15c4c612580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68d11c703cf8e4a0
dashboard link: https://syzkaller.appspot.com/bug?extid=a2b9a4ed0d61b1efb3f5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

