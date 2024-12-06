Return-Path: <linux-fsdevel+bounces-36636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BE69E6FE9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 15:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C8C169DCE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CE32066DD;
	Fri,  6 Dec 2024 14:16:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C868D21A0B
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733494566; cv=none; b=OKGlEv9xov/tW68NM5T4URKbtveNQJK2t7FBMz01PmNw1KN6hHCVQu9CBluXlq6NewhfBRkLrRL/mtOQzESxIodQJ40WgW9NEFqVNYN1Kx9MfvSGkRRq8O/wYIH9tiJnWzh6JK2wnkpJ639Ye36BWPlkcI1AGuTl+mpsFhN8+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733494566; c=relaxed/simple;
	bh=Tkf99ZxUJD7B06TNovFBj5zWUG28OStkofgTtCr+JAw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BQri9mfj+MlYZPhBdBOIgzvZgJ9u26lhiwy6WoOmI8u/EPSwzNx0bFkJXcYbs8WdikJt/d2CP6zJlT9IgAGVzBSO3ddY/sPJzWLYbqCTuzektEpRCGzQf5UZ+hPvYeeZ0QjqqMdZq83EFX0jQAu3AEN1v+i3vWfh43EmA8s8/TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-843e5314c99so389969039f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2024 06:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733494564; x=1734099364;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gE1TesF6ZaizCblXTChTskphRlSEFQAeYDCiQuPDQKM=;
        b=YQA1pXAX+UceeLq7ujFy06HGCYev/p+G5mLAbhaMN2s8eSE41lC0k+WlpsuYzx/wmc
         TUl2u+FdyxopH0xQg0OQB/9Rh6+KftDN5LRyge9znkXMx9LP1ny+oklFNDrWgNo5SzmS
         ubfkUIvuE0O9HQgwX4CGpDOvYkQhE+xNvuj1vh0NuoxA+XRKygMDBt4G/WfxebWmNWq9
         ro0i0Zo4kE1XGvRRYoYTTQI/HkOi9mgKtYe1VaZTxCPk+IedpKpEQkzGc6y8VX3+6zPS
         um9HrVKQCNMgdRmbc1sZR4rR2pMEcR9GJuoPdfoPT1XkDeUPejSuqN70J8QsXj34mrNQ
         TNaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqSj8wc/xuEEwiYjNhfNZWoqpYTsG0aLZ70A8RFXi9GaJKpskr848Wx0DDdr8TkDjGKJ4qRsWOtGhGusCm@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyh51wBwiBZt8+rllHSsNdDAcop+MNThUVIxUIy8GEBJyzc+21
	WtEx6/8PPRDYobnz3OImc7JfuhIpeGWKFGZXXqtwk8YJqwymOXrPL4Td0fDmCeCY/+ZUuo1rUWT
	TEfZN7QaRUJqCbcmq+ekrq6Ysfm4APyUfbDHJAsqWqZlD7SEzdmMs9Dk=
X-Google-Smtp-Source: AGHT+IFzPbqEOcrzl8qSgUO2fmGl5eDL+S3HaNIpt0JniopXGYcsXblVZr7ulGopiPZeoQ6SPpbeXxzInr2ShiHplzVMtFSR7yWO
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1448:b0:3a7:c5c8:aa53 with SMTP id
 e9e14a558f8ab-3a811d939a3mr36568285ab.13.1733494563834; Fri, 06 Dec 2024
 06:16:03 -0800 (PST)
Date: Fri, 06 Dec 2024 06:16:03 -0800
In-Reply-To: <000000000000d69fc4060c7d50a2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67530723.050a0220.a30f1.013f.GAE@google.com>
Subject: Re: [syzbot] [hfs?] [mm?] KASAN: slab-out-of-bounds Write in shmem_file_read_iter
From: syzbot <syzbot+3e719fc23ab95580e4c2@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, brauner@kernel.org, bvanassche@acm.org, 
	cascardo@igalia.com, chao@kernel.org, hughd@google.com, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rdunlap@infradead.org, sandeen@redhat.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 1c82587cb57687de3f18ab4b98a8850c789bedcf
Author: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date:   Thu Nov 7 11:41:09 2024 +0000

    hfsplus: don't query the device logical block size multiple times

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=174098df980000
start commit:   fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=3e719fc23ab95580e4c2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14903769180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f25d81180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: hfsplus: don't query the device logical block size multiple times

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

