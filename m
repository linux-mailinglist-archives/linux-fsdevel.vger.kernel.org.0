Return-Path: <linux-fsdevel+bounces-70384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFD7C99564
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 23:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0BCC3A4FA7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 22:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBFA286409;
	Mon,  1 Dec 2025 22:09:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398BD28642B
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 22:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764626944; cv=none; b=Xq5jCP306DoWVknYzqU+C64MWdKvQmnMjHh9MhHM0pr9OClLD0F0ZlkGJ3xoF89xOhIugYYcMMEWw4ilCpjJpFXzR4UcyVfc3DaE5NsXuB2NlF+1SzwTDRmGURQC85ZvhWxzL+AVsap1TNLbWqhAWUoGd/5pBwZpj8ihnanPcKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764626944; c=relaxed/simple;
	bh=Uw9kUV9EdAkxOYByN1jtz7gLbs5Uy6OVyl/gd7NOE5s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q0ecVGbZeVqbCpc0go+BZVUnxgwYXWyQRn734bu5q+kr5JiBM0axjSDNCbbX/3VFa+928BJR5epokvf9fvmC3cDsBagikqjm4rPpkrC48cvGPxAIrjHMHaKB+lNuhlBZprXqE4Y5+tmdV+AKQfOw/3RwWg2f4tY5TjfitjTDsvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4501f50b40cso3540843b6e.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 14:09:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764626942; x=1765231742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vkKw1aMFMsjt7cPjue/zTtcAVsiSrnVVB8Q6f0BvOw=;
        b=F2tzhvChQ1Df7kXJ9/u8qk1mwsDZvsIdjYwgYr6yoY+uWuLBQ6A8drmqsOjiPXZ3EQ
         nY1qv6H7dyFCf2izGQfXvR7rMcw87WLM0raOs/8gLfvPTkxlfmi57RGRjj7jHhENZKhN
         W3qWuLruK/cVTvrMQYdNXptV6TleayZ6Naot4+wRPJDJ9t16yOkTy3GZw4pKT9CRmM9+
         /LtdufwmVQLdWvj/EPQVFOJuluQtYMhVXH8GnZ4yExNcyCOx2t/Vq7A0KI3S6zGWVAL3
         2lvnq6TqQfXDWpngZyflczPEwGSrrNeOR+zrUoI1+kXSOXKQRsuHE8un5Ri+7ikCce3P
         TC9w==
X-Forwarded-Encrypted: i=1; AJvYcCVW8kzzR0MafSArvYbwUEaYiMRSWUW/SM6aE+SpNAo+8GN2zNFwXs4zfFR53Z6flL82rCMW6d6H/ZjXIngK@vger.kernel.org
X-Gm-Message-State: AOJu0YxCHHDNsYZ1kKSbOR00nZVV5JK3rzhwya4OdAV0FsAZLh0aVN50
	4zUdGKlyiCH5K6yfMk8Ix8MCJsRHDrGFFW6+q1/CZ/LH4BiKTJzKmmFIzW8kT/7fCbZRtbnRpKl
	lWYucP1dABf283vQrwodG9P8vg1quRfr4Lr7ptamhF8l+Z082hThzm2WgmLs=
X-Google-Smtp-Source: AGHT+IFCVn9SmBjyBhDsZVB9FNp97B50jkWsVXck4orrLX/hYWor8khmXtZ+VRasjlQ64ebDCoYjuVDiltI/XEWnqYdManqfsXti
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:210c:b0:450:a9d0:b799 with SMTP id
 5614622812f47-45115a10e29mr18815486b6e.17.1764626942248; Mon, 01 Dec 2025
 14:09:02 -0800 (PST)
Date: Mon, 01 Dec 2025 14:09:02 -0800
In-Reply-To: <692d66d3.a70a0220.2ea503.00b2.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692e11fe.a70a0220.d98e3.018e.GAE@google.com>
Subject: Re: [syzbot] [fs?] kernel BUG in sctp_getsockopt_peeloff_common
From: syzbot <syzbot+984a5c208d87765b2ee7@syzkaller.appspotmail.com>
To: brauner@kernel.org, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jack@suse.cz, kuba@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, lucien.xin@gmail.com, marcelo.leitner@gmail.com, 
	mjguzik@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 457528eb27c3a3053181939ca65998477cc39c49
Author: Christian Brauner <brauner@kernel.org>
Date:   Sun Nov 23 16:33:47 2025 +0000

    net/sctp: convert sctp_getsockopt_peeloff_common() to FD_PREPARE()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1136a512580000
start commit:   7d31f578f323 Add linux-next specific files for 20251128
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1336a512580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1536a512580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6336d8e94a7c517d
dashboard link: https://syzkaller.appspot.com/bug?extid=984a5c208d87765b2ee7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a2322c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a3c512580000

Reported-by: syzbot+984a5c208d87765b2ee7@syzkaller.appspotmail.com
Fixes: 457528eb27c3 ("net/sctp: convert sctp_getsockopt_peeloff_common() to FD_PREPARE()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

