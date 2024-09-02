Return-Path: <linux-fsdevel+bounces-28267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E646968B05
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 17:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4880F1F22BA6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 15:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14511AB6F2;
	Mon,  2 Sep 2024 15:28:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F051AB6D8
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Sep 2024 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725290884; cv=none; b=AxQeYunShs1rxyMarWmlAT7SqBmsc2Rq37VbKgkM+MR+VxlJVI28/Xt3di6aZdPF1noysuTbV8mlN9LTdQcZGE2HH5DCqv4zuJG9JDRb2M3SDpTQS8RVQriqI6NLye34dfV6whO93SH4iwIarikQXB8ngqvNI+xrcrCNpkFGg+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725290884; c=relaxed/simple;
	bh=fcsvwgJHszrqFYBuVGMJyWBjEoNkn9u8s/Qvo7dREkE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OOQxW2JB1WuGe6yJw+rYIKmGN2x2mpkaFiiY77bqSaOfKw3F+JiMv1eYTnCYMKkwDnleFwNCOmcaG2z1PizuciHtecdPy3t5MkHfEH/AscBQZF1J6Q6UvxpA/2X3myn4s2W3JlukyodQmV4/AfcLfxB8aFDF+wOiabZJphdbbaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a3fa4ecd3so229320739f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Sep 2024 08:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725290882; x=1725895682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DPWC6U8f2qBdEbiB/1tHLk14BDYkG8mFDHPKIKYsGpk=;
        b=nbp0BC42s4Wi6WTFE2WJ9Jhi1wiJ6YT/sKAGeWr1rUUVndHq42wXpO4Kgj4XMc5AbS
         WDTVgIebOoPO8aXOFtTNETTfUX3eZnIB/PXDbc/GJaCUxo5nuIMC/+ah+yt4CQqdc7W6
         ricRNqlHXqaB5doI7ki3S0zPxN1a6XEoQfKzUahG5ckOOa/0GC/HAqVUWkGCW83IC109
         dQKSPlDx2w67uZVfV0igK89UV09KE8Ffud9XWy9egsMaE76585tOduGeyPMbqChEFEkB
         1GSqdNJCKHN80O/ra/Z+OcbWQmCM/JF9JvLIRVjDjlxO6OD2JWwY8SYpHOsx/73vNLAn
         cidw==
X-Forwarded-Encrypted: i=1; AJvYcCU6wKe6/FQ5dzqlIwhMvk3XeJngKoRHwpqPPDibIDKmXs4562kN2tgTXUOWhE79QZjG8mpwC9un/aG5sN6J@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/FUshqXoLB4Q4At+2L38RyEkAGx2Nqc+ThuyyOxFZD5mxSCSZ
	OT/lvbl1BkOkJwEulTVVbSnLtKxcQ3sDJu1qpXebNbd2Dsfc17ForLgLOzXPK420OgtipydI8CN
	2+dg2n7vTMXbQV8LQWsoDBX4D4/JeCEUnUZf6AAwGrgR0YLSfPCvaGCk=
X-Google-Smtp-Source: AGHT+IGYE7aRkq1QdG5CqeZumrhss9UwB66VHx1USISJdAEcgiBS8pGvcFiBithIiWwzkPxwiT2pBaJMBi9K1YaRPMlswNp5FSto
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8704:b0:4b9:e5b4:67fd with SMTP id
 8926c6da1cb9f-4d017d77c32mr899228173.1.1725290881918; Mon, 02 Sep 2024
 08:28:01 -0700 (PDT)
Date: Mon, 02 Sep 2024 08:28:01 -0700
In-Reply-To: <00000000000087bd88062117d676@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026b5250621249667@google.com>
Subject: Re: [syzbot] [fs?] [mm?] INFO: task hung in page_cache_ra_unbounded (2)
From: syzbot <syzbot+265e1cae90f8fa08f14d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, davem@davemloft.net, johan.hedberg@gmail.com, 
	kuba@kernel.org, linma@zju.edu.cn, linux-bluetooth@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit e305509e678b3a4af2b3cfd410f409f7cdaabb52
Author: Lin Ma <linma@zju.edu.cn>
Date:   Sun May 30 13:37:43 2021 +0000

    Bluetooth: use correct lock to prevent UAF of hdev object

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16a579eb980000
start commit:   431c1646e1f8 Linux 6.11-rc6
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15a579eb980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11a579eb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=265e1cae90f8fa08f14d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f8f0fb980000

Reported-by: syzbot+265e1cae90f8fa08f14d@syzkaller.appspotmail.com
Fixes: e305509e678b ("Bluetooth: use correct lock to prevent UAF of hdev object")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

