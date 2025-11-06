Return-Path: <linux-fsdevel+bounces-67284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20228C3A77D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 12:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65E73B5370
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 11:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C2E2ED844;
	Thu,  6 Nov 2025 11:06:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4BA280035
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 11:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427165; cv=none; b=DRmhonG+QOtI1SOvbfV9GwEM0P4GXsKi/0yTxqkSLwpFg5xpi5iImbsb5EaeW2BWum+Ek5w8Pc03iWSCCYn7FmmTTWxBPG4FrvEo1oVstgP7HXXHw8rJ76PonRACmenfuMyVXA2D1HCdAkwkSaVIHH31PnlhQuUGjm4B2etruRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427165; c=relaxed/simple;
	bh=MDxxMhIORU1N6H7vl53fjvMx/eCJgCUEAWu06Xd4fyo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TXEm61Xrq1Vbgk52dj2zS3tmb+4l/VLi9AQC/GQrWIby0qfUinTqPOTiyNI7OL0Yrs14iaqmZQoNX01HGDDIAeAq3t9bU4gx/E5dI4AmaqDFgKZhF+fyCahUs47h1tLSAb3N+XBZc7Xpmh1rgyZRs7l8fmNsvMEGcmy6gy9FjuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9487904aeccso13842139f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 03:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427163; x=1763031963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YLmpBcJQQJc3uvBPyux9aBsbuqfkQpqtFUsIwakHSk=;
        b=NR6w/M2R1MRxOjGrxmgtHaQ4nC/WnyKzG5otjAixmvwFMVxY4tXvPxzh/CPrKnDskV
         sJs1OxocROSt20HkWOSdadvJ870Eb+GNTTRsQU97tRiYseDmHpRtg7Bo3s20xj8gCXr1
         3wKLCDphNvdPylVgdtOi66FJxxZJwg3XJsgDoq5ry4HINXu5ErzFfIlcOdxh1F76U44x
         L4+i9IErzpIp+9krMnmHtVEEro5fq3ugK8O434FnsYutoI7ka5FWkyY37n9SjMlP3axP
         rXUbrQhCXjYXItY5xNBZD+xiGI+E3e93n3fbtl01aCdiUZ+H13m0fIIj5K+2BDb3Dl7R
         GaRg==
X-Forwarded-Encrypted: i=1; AJvYcCUNhd10T4DpIULDG5GPzGdrV0WcqW+rRxC00I34Mt+9Gj1rEuD/qKbjaPlNn4iSlLzT567SD4wP3fL0BfDz@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ0nKEegBe9CcRU/CtKFWfBHTza8q+2eKDPQqKQXS/TR3sdmRg
	c0aaFnGcOLOtmJMxFW8UHN8BhtmAAtxqfmiTRJ01ZRadm2fwmB7aSzK5RahomnrCl54jXpwkeUo
	QB+5VhFVH8UwBD4p9Y4ckGyzJmImGWMni7l1n5MX8LYfoWZoe7sl3NNCkq40=
X-Google-Smtp-Source: AGHT+IE/u/KUDmfVhtAT+bF/JPkOxMXgQqhGjaEF35rveLN7I4NxGZIDTM47S3PtW6CsTFA7cmt9IEyen43RF5wsFZCo3/mO09du
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1567:b0:433:2400:2eef with SMTP id
 e9e14a558f8ab-4334ee78384mr39296765ab.13.1762427163097; Thu, 06 Nov 2025
 03:06:03 -0800 (PST)
Date: Thu, 06 Nov 2025 03:06:03 -0800
In-Reply-To: <6774bf44.050a0220.25abdd.098a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690c811b.050a0220.3d0d33.014d.GAE@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in filemap_map_pages
From: syzbot <syzbot+14d047423f40dc1dac89@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, chandan.babu@oracle.com, david@redhat.com, 
	hdanton@sina.com, jgg@ziepe.ca, jhubbard@nvidia.com, kas@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, peterx@redhat.com, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 357b92761d942432c90aeeb965f9eb0c94466921
Author: Kiryl Shutsemau <kas@kernel.org>
Date:   Tue Sep 23 11:07:10 2025 +0000

    mm/filemap: map entire large folio faultaround

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12658532580000
start commit:   b19a97d57c15 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=292f3bc9f654adeb
dashboard link: https://syzkaller.appspot.com/bug?extid=14d047423f40dc1dac89
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12399442580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm/filemap: map entire large folio faultaround

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

