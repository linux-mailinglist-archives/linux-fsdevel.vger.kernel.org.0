Return-Path: <linux-fsdevel+bounces-70341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB14EC97B5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 14:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B9103456A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 13:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFD03168E7;
	Mon,  1 Dec 2025 13:45:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E5029D28A
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764596706; cv=none; b=rEjn9r0+9dvkbhYEFcfVM28ddHaOiKJaito1hBWEBmFkebDSkYqEzvmIIbP0xX/Tr2epYC8Tkhla4B9beJQqjPj6RIOYpMB5vg0yD6W3/m+8Ok8JcWsuqi5PFeynT+k/ntZ0gRyZsxDn+NGpR2vFzaleFgDMI7DfNunDtFSnmYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764596706; c=relaxed/simple;
	bh=Nt23rI5fmfvxToaV8m/oMMeaHQikzSpB9dYay/gK3DI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uS/0IGMwJZdA4TtVrwzqNYAeOrJsHAtHFtRt8AurWXjueqo0U34O2MJst29b3J8PqyKU36VugP8stP9tYrcuPxSI1GziU0gbU4FtUZc8jckIDKTWCezlF8HyF39j77xyCUchvuUwMFw8QuVDcPt/rezeSB719am+hcYX4JVjJmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-9490387e016so274915939f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 05:45:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764596703; x=1765201503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OxiiEtFZ/g70+3KZI6piv+rsDAV8iBwcXRtt6dwkVzE=;
        b=Irdwzr/9Q7eYXaQF0Uz9+oC/MnVd6uxwNoKmYU8ws20t/BERKkvIi2u2FqiAw6/Vx/
         ZLGOlK0dDkPsfoxvBHnBE4qEhMj5guzfuPGVM9wXTtkopHrtj83ya6NMLoDbxiJHml+6
         agTti4my8SwRZ22YOPIVtc1uN38HHcd9HOitXHEo5mXmi9Jz/jDObuvj3pBBFOtLb/r/
         J6EhYuQjiEwPHjkKgRRSR0fxWpQxMJiNimSvMYF9M7vyAoKY2IpAQTrZlP5Bc6OjrAfA
         /kDlsXmM6eUmtH/Rwv7hIN6K7tS41wjwirn36EHwieBt4z1jMzq1O8nTCbOeBl+QotOX
         2Oug==
X-Forwarded-Encrypted: i=1; AJvYcCWuPxefC7rsYeNpFtvO57O4P2qFMq0FQajWODV+cBdRdLy2syn76ccPeZgDVr0O4NOK3nxBpPqm9Ep7zzff@vger.kernel.org
X-Gm-Message-State: AOJu0YytC6DQb3wrSe5luCXV2Z/SkUfqJQv9NwBzZifx84BzC1hTy3z2
	Rh/nUPcglR/WhHQeBLZJzMT14hko+C72nmECBnXKaophC/dXMWkwnZdzQ3W5+2pjIlzROAbJTrq
	/88FcnNbnDUfNQljaOgN+BqJ5JEdfQ6AwMoSVdealDavNaQcIcgL39NG8n1Q=
X-Google-Smtp-Source: AGHT+IHyLioV+qdNip3N9qRtKFDUSC9Op1otpY33L4pS+kiyZpNS99eqMLSG9SnvqpXXOpMABrQ38PnnAEh/PwnxTxlELnxDzEm7
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c05:b0:949:305:fbb8 with SMTP id
 ca18e2360f4ac-949776beb36mr2117635739f.0.1764596703039; Mon, 01 Dec 2025
 05:45:03 -0800 (PST)
Date: Mon, 01 Dec 2025 05:45:03 -0800
In-Reply-To: <cenhvze4xmjyddtovfr36c767ttt2dgbprtr4zef6n7wrkgrze@mnzax7kfeegk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692d9bdf.a70a0220.d98e3.018a.GAE@google.com>
Subject: Re: [syzbot] [fs?] kernel BUG in sctp_getsockopt_peeloff_common
From: syzbot <syzbot+984a5c208d87765b2ee7@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjguzik@gmail.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+984a5c208d87765b2ee7@syzkaller.appspotmail.com
Tested-by: syzbot+984a5c208d87765b2ee7@syzkaller.appspotmail.com

Tested on:

commit:         95cb2fd6 Add linux-next specific files for 20251201
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=142b58c2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caadf525b0ab8d17
dashboard link: https://syzkaller.appspot.com/bug?extid=984a5c208d87765b2ee7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a62512580000

Note: testing is done by a robot and is best-effort only.

