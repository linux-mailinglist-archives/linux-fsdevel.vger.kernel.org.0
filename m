Return-Path: <linux-fsdevel+bounces-54636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA23B01BF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 14:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5837E5A5814
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 12:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809EE2BE053;
	Fri, 11 Jul 2025 12:27:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9895D29B764
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752236824; cv=none; b=gzd6roJztggiaw7jagvdhfhbrEkzK+mxrR8V7PzaZYBj3EiIw0UQ3P2qvO/UYxdCxX8w62AQtQSxufsufmrevEOJCvaK3vfJqK1OLTd3nfvEd52zLGMcyXXOHZuDYtp6/erb+s7JHn253fEraPVOfub1PS0RL6bfe4DwPTWoW6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752236824; c=relaxed/simple;
	bh=5RThLuz3tFL7phwFf/QiuipK2M04eM3fXnIvO+PM6js=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UeH0dQ8TDTeKDv7m1AleoAn2H4v1nbl7LgaSefZxxFG901dAIWPYRHLGgwJqFVm8OZaLeHz4zC2oWxfqP+84jmLCrDvCznvClm2UDuPmC67X1fLx/FiiITX9ImwKe/q/pwNX5CiyOANqrdJAEra+IVeMVEF2ufTRRqNoeCgIxsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8760733a107so235057439f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 05:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752236822; x=1752841622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLiCgbUvpuHgSzedG/d0dkj2/LzDFoEPV2dlBZwd1TU=;
        b=RkM1sn8MLKQA8uauFEI6qtjxol8+xDwTOQKRQHtQObtzwREDF5gF7lvb+xXaFa5Nwa
         ujsYhN6eClfC2k82j45JBOX5vPpX92qiEe+NFepCoOmIYzhFSCqc74hijAZ0+vl5aRhy
         4XpbG6Zcad01i28UbWn7DGiYS/PV/RrjgJyKCviin7AaS/Dj/nGnxPZ1JNr3bQrtnOhA
         c6tJjoMMDXexriDmuKJugKy7gMNPDRKhwpYm7bj3lMqsdyBF4lYNHTY0PzxnMelo25AR
         M2BOBEDmqgXg0tvOoVbMmxYrExPtoOHGgX5AIa8nQKzmEJkCI+cRIxVG6PqfhzvUbe4z
         QXjw==
X-Forwarded-Encrypted: i=1; AJvYcCVm9RhQp5SW/MbptlzXrd2XLUyjTE8yDBbR9kQPAGphT2M1UgTr87yFkyTe096rCTylW3RK2mMC4JXHbyX4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Rk4fLHPprTnBidZn0NVqEmhcf6EA1lt6ZZ1yJWE+jd/jZU4X
	rsZKEzOxPS+TFlBK5H1nPk9Qc4qLnddOxSOOeQOa2RTZR2WHWJQynMcbHrZS/NRYx3vejHiinlW
	L2YEhxTIBGWzx7ipIcR15PiM7PS0kZXUc8eEf9slI3pgJcUHGyOGMRBA/6Ns=
X-Google-Smtp-Source: AGHT+IGRhMJOZvny5MX2PRrEbROR2nl61a5ERscS0MwH2MJL0/EaCuaUyH5lY/Hs0+U19HgsshuS2Lmy22Yo/U4JhtOYqknQ/OW7
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:b90:b0:86c:f2c1:70d1 with SMTP id
 ca18e2360f4ac-87977f521e7mr361411839f.1.1752236821815; Fri, 11 Jul 2025
 05:27:01 -0700 (PDT)
Date: Fri, 11 Jul 2025 05:27:01 -0700
In-Reply-To: <686a8143.a00a0220.c7b3.005b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68710315.a00a0220.26a83e.004a.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in bdev_getblk
From: syzbot <syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, anna.luese@v-bien.de, brauner@kernel.org, 
	jack@suse.cz, jfs-discussion@lists.sourceforge.net, libaokun1@huawei.com, 
	linkinjeon@kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	p.raghav@samsung.com, shaggy@kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 77eb64439ad52d8afb57bb4dae24a2743c68f50d
Author: Pankaj Raghav <p.raghav@samsung.com>
Date:   Thu Jun 26 11:32:23 2025 +0000

    fs/buffer: remove the min and max limit checks in __getblk_slow()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127d8d82580000
start commit:   835244aba90d Add linux-next specific files for 20250709
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=117d8d82580000
console output: https://syzkaller.appspot.com/x/log.txt?x=167d8d82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8396fd456733c122
dashboard link: https://syzkaller.appspot.com/bug?extid=01ef7a8da81a975e1ccd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115c40f0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11856a8c580000

Reported-by: syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com
Fixes: 77eb64439ad5 ("fs/buffer: remove the min and max limit checks in __getblk_slow()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

