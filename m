Return-Path: <linux-fsdevel+bounces-33109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A4A9B45BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 10:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7DEB1C22097
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 09:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C802022D7;
	Tue, 29 Oct 2024 09:28:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FC81E0B7D
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730194086; cv=none; b=HHs5lUscC/UHq9jlfySdkAoP0XVaP+AQ+Es6cdg77hnzCO1EsKtAHmVyoWGZrChQM1C4K2ySHfgVTwf611B7TYfobTgPJ382+r5qRPZaxMzhCRjbWmD6PAHuhye2zJDG76P4T0oIhuBM/l0gjnp9U1FaDKgAy0VPbZoJt7PUnHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730194086; c=relaxed/simple;
	bh=F1Jm6Rb5Y120pS5QEJb8H1HXzC7Pzy6vWf58Yv105sE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Pm1BgQT48SzhGfBah46kUMLtO5gWpxjMuMSk6+yHD9M7opEW8+ceEYaHmD4+fFcomahL9LDHw603iQmrxepoLP14KOih+l0Tr5JkRu2MXEAMQVEQI73uBuQ5UUrhDBsf1QaHYA5dVqZaIMNw2BEUa0wIn1j/u8m/W/TaVfuu8f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4e5c68f6bso43873065ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 02:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730194084; x=1730798884;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oNuT3oGDTf/McUeJVj06UU4pcEX8BAXgi4YYe2ZPzj8=;
        b=E4gZpXPGnIyOvXPPUHv/WG939bjRW/LXYlZaUcZD2BlPeH9ieY4jO5sF0wy9ZffIeN
         zDwgh4EBTHVjUmHl08tKRhGOfeuspHSx/fvdE8Ywsd8EFv5vZE2tzhwlrqJdsihUz2PH
         wdexVkBOobSmQPy5hukp5k8RTuMgV1rJ+UNbK0UhfJKnu7cTcAodX9CA18ljfjtDHIDH
         8wikAK/eA5Uo7jYu7GXa97/9b6sljVGIXplDvlbSUJZeYnVINGB2fQAGdX+Vx/Y6ios3
         hfHb3vXdmXQKmbLPIg0MHB6FO9PGKt6MOYTNR6sqCuoUWLzrHVnFxS/ERo0QFpHAeU0C
         e+pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWibGwDWVu1LM5Zt52rvAl0qqPU3KMRLPURvLOPxp4UxcrIvcQYC4yANuTzb13AUSk/jeQOMTErLaVEJvVH@vger.kernel.org
X-Gm-Message-State: AOJu0YxmVsnCCOspdm2q6j4XQnbpYDCE2rBnPW9sVISpD089WNUevtt8
	vqLt2mFvi3j7LXUimNp4t2+dEoTEYUDg04YQqQZd1iiRFwozzGkwgs0EyHFZ+ULUVAZZGMkZJ5g
	BPopkryivcT+Beg7FwXk5AYc0gAcqoLSQUY/ZMbuYnE61HsOSTzHoTmc=
X-Google-Smtp-Source: AGHT+IFqGlT6pG/aKhmo89qj+OXwcUNrQQmCY8suynnxw4ILuhJDcGJmFIGbJke6s9Q8RwWqh2Usx0akOWIxzD+nUSFgGS/y0KWX
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188a:b0:3a1:a20f:c09c with SMTP id
 e9e14a558f8ab-3a4ed34b940mr122690435ab.22.1730194084074; Tue, 29 Oct 2024
 02:28:04 -0700 (PDT)
Date: Tue, 29 Oct 2024 02:28:04 -0700
In-Reply-To: <CAKYAXd-v5nQVkE58bvuk0V-kGTN+Q7vbsf678A7v3zb-Z2d8Kg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6720aaa4.050a0220.11b624.04be.GAE@google.com>
Subject: Re: [syzbot] [exfat?] KMSAN: uninit-value in __exfat_get_dentry_set
From: syzbot <syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com
Tested-by: syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com

Tested on:

commit:         e42b1a9a Merge tag 'spi-fix-v6.12-rc5' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=142ec687980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c11ea7cf15419ce
dashboard link: https://syzkaller.appspot.com/bug?extid=01218003be74b5e1213a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16bbef57980000

Note: testing is done by a robot and is best-effort only.

