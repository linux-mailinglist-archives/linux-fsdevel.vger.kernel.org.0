Return-Path: <linux-fsdevel+bounces-53030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F8BAE92AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619ED166DFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22552FE328;
	Wed, 25 Jun 2025 23:23:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79B02FA621
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893784; cv=none; b=uZDSeIQzbCuxR5GsBAUVncUcWijXV2p+IfyD2BZbhw0z+O5GVphhSjHyf6iWnKZSazhRHnRSp/fbf3f6fi5T5DHKS5vMbpgiiro2Ql0FL0s0N7TN29NHiiB+T8kIkHTpymm5+zPi1SuggBeo4HTlwJY+QnWRaonG58SgDeKAVog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893784; c=relaxed/simple;
	bh=AwSXZSs3OTn4VtXJxJMFI56c6JYnA3ogAPeB7PgCICc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PvoA/aDJ0wg0plPyRiij+ILv8fnnn5FUHexEoJR4Bcx1e6DhY93hd5yqigzMdjFH5ib334gB6RfUREaLw6XDG9rxYLG7dM5FBWkXo/MpYbimdnMFinzUvKUO34y8f0p2TYpq9ubvaRWDBkTW7ZunwAJxy40ydGKOxxlm0ipj9Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3df33827a8cso7395655ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893782; x=1751498582;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNt304X6mHuKIoSlL5NWbJdzWVgNAFv9scHJfNI0F4o=;
        b=bphUiu2Nz9s+Ue4g5JqhpJeu+D+nKqlnj7oxX0GPSJOmdNZkArhPfRscuiLffN9KRr
         VYeSBiE3A77WD+IN7lOKFtdLEvzbdVlI+FBSe+eEGteStn6khrLh3roh776iKlLYnObA
         1cGZ9BwLT++PcF1pERNGk8CcRgf6BJ0IbiDqciIdaEwhm5P/fmrlQ51YP/uDl+9EtNJa
         Ib37Nd2kcPZfY/blLoaT4U2Dn6f1F7uQpClBa8LxYp+eVmTvR9C5kOJeHaMyNBV2pSQ0
         V6OQFVgFBuDz3Li0JV7F8cjD0LvzSRTqD7JvJZwEimOYXEgsT+6o/qSOjwGXcRX/lnSk
         FzRg==
X-Forwarded-Encrypted: i=1; AJvYcCUKhmHKbv7LLh2Jyw0HCHpI9x69+IPiKk/ae9VbtcKsMehjz4p/DFLpY0K2yqZvCFdcNAynzVOE2Paw5IW5@vger.kernel.org
X-Gm-Message-State: AOJu0YyvoyUORvFUoWTg31A/FiyiUXmgaF6HmYqM2FZzBb5jK/YUeNEG
	eFVkMe5xfhBaSEejyBuXdmL2ZBtOAoqvcSl9aw/hi9geTaM0GaFIOxXLMfsBNwevlpd/h/vWRmk
	H1dgwXonuG5vLfdMYkXnBNlal1f2mnInNUddlNc4u1vGxIDqQ94Cgyuw1iy4=
X-Google-Smtp-Source: AGHT+IG/FDfu+tGy6Kqy/u19VrFF0UTelg6OsuSSpjgYDtNvDx/8bwx/GlwpT1MqUfMa7jLpR5+Hj3NSem3j5jnP5I78sw0FJnIk
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2f:b0:3de:2924:e244 with SMTP id
 e9e14a558f8ab-3df329e2ce8mr61963575ab.16.1750893781834; Wed, 25 Jun 2025
 16:23:01 -0700 (PDT)
Date: Wed, 25 Jun 2025 16:23:01 -0700
In-Reply-To: <0000000000001bc4a00612d9a7f4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685c84d5.a00a0220.2e5631.01a8.GAE@google.com>
Subject: Re: [syzbot] [fs?] KASAN: null-ptr-deref Write in do_pagemap_cmd
From: syzbot <syzbot+02e64be5307d72e9c309@syzkaller.appspotmail.com>
To: adrian.ratiu@collabora.com, akpm@linux-foundation.org, andrii@kernel.org, 
	brauner@kernel.org, david@redhat.com, eadavis@qq.com, 
	felix.moessbauer@siemens.com, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, mjguzik@gmail.com, superman.xpt@gmail.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, viro@zeniv.linux.org.uk, 
	xu.xin16@zte.com.cn
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 65c66047259fad1b868d4454bc5af95b46a5f954
Author: Penglei Jiang <superman.xpt@gmail.com>
Date:   Fri Apr 4 06:33:57 2025 +0000

    proc: fix the issue of proc_mem_open returning NULL

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1604cf0c580000
start commit:   80e54e84911a Linux 6.14-rc6
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=77b023e9ae0dbb6a
dashboard link: https://syzkaller.appspot.com/bug?extid=02e64be5307d72e9c309
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101e3b8c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ec67a8580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: proc: fix the issue of proc_mem_open returning NULL

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

