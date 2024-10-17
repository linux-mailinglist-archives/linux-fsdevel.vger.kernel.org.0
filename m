Return-Path: <linux-fsdevel+bounces-32164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 228F79A18E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 04:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A4F1F2310D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 02:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4D7137932;
	Thu, 17 Oct 2024 02:57:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68D864A8F
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 02:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729133828; cv=none; b=nLt4Y1aElAvtAYflKC2PosFBBoBg72IWfy11d8E/ezckDBE86S5qZTJkFKAadCd1vNYSQ0mGFM59qDXHR70pdRlKCxtYzhhrPrv1tY4EZN9cb6N8XEX7+IGBJSXO9G8ZPra5cK6EIBfzhZLthFTHKoDQgBE/VvwlBV3CRNo89WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729133828; c=relaxed/simple;
	bh=Nd67Jp00RXLPiVdexnjEKooKYzGEtzYZb/4vilnk2BU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SZqykJC5F4FLxa2mni2nmCqbLdWej4RbyWO/2HWY6YKQjTLZNHbUnSETlzTOS5LsH4qEgAPLLFLxi3+i7afrx/8Q3jDnWdreaEVcPl2LA+Yr2PZzRHEkAmwlyjZQPUBcu8HJtZNSV5wXItqFmbGE/f8kqUJrIEbfzEcb9IwAHEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c72d4ac4so5440035ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 19:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729133824; x=1729738624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XxWeyhD4DCS8Tj5utd6tQ7ogo4K7gLVG21FBXYaqDKM=;
        b=vl0fuFw2r2jkVonwT8gtAHrPuYtBFiBMQPo2u8XxVfI3PiRsTc+szxWclzMNaYGNGN
         D4g4cNCeh/hOzJtDZgIKXQ+/DV68lEZhsiOTcg8Nt9eZnZiRoihY8RPKry88rWYmVc18
         EF/f8YgJ++L6cxuX3C5S5HFkYkbGTEA3wO0XrepiZqtNGfuhzc02oJ6jjNkyVd7aRaLI
         62MfjhRCYiWfiobs61K5l2CxRYHMYk6ZPpjvXryNPiOht1bY/jPpSQ7TU4FLcRFoQJ+f
         gBHKJmBo+hvOVN3CQyKYgk5E1zP7fv+ka1o1edkaGH3CtvEWkJJevSXUIuFUzovowGRz
         lNUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5VVzeYSDJcBTVlExLr7mt0gGiNfUf/erOJIom8v1gRsve+IqQkkX9/wxEC4SbZOV1bUZoz2qoHS6oh3gd@vger.kernel.org
X-Gm-Message-State: AOJu0YyzkpyDXsa8FKJQho8jvavHqt8h8xalPJ1feIjPrpHb9HThaaZv
	WH91y4KSZrfyZhnPjeMiqG1wG32MRGvNuRwlFWFsKR+8OPekcgQ09gmSpvHNjL0D8Bc/qeMv6V5
	IDbQtRoB9TohYkb4UW9tE4GAnzcnn9pD64+Koo6r4r4ZB/O58SfKsPnk=
X-Google-Smtp-Source: AGHT+IFMb6oj4p4WyOWBYvx2fxkNdWCnvHQYiKx/4cURjtylfxV05F5ONegNfJQPldnmZEcJqAcWZJ90nGID9vMq0uRO0p5rk/5z
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188e:b0:3a3:9461:66a4 with SMTP id
 e9e14a558f8ab-3a3b5f596ccmr191029495ab.10.1729133823937; Wed, 16 Oct 2024
 19:57:03 -0700 (PDT)
Date: Wed, 16 Oct 2024 19:57:03 -0700
In-Reply-To: <PUZPR04MB631653574B414EF831C1FEDC81472@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67107cff.050a0220.d5849.001d.GAE@google.com>
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

commit:         c964ced7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c43030580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5242e0e980477c72
dashboard link: https://syzkaller.appspot.com/bug?extid=01218003be74b5e1213a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1738345f980000

Note: testing is done by a robot and is best-effort only.

