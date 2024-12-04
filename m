Return-Path: <linux-fsdevel+bounces-36499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC0C9E461A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 21:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB6B5B2D8C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 20:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264011F1316;
	Wed,  4 Dec 2024 20:18:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5976C1F03D1
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343485; cv=none; b=BLk+hENuciVuR03+sjDxjZ3aeoylApKuiLkPdu01HoDZCLf3TrborGFdd4k9krbb8l3vrA5reucL5fyPEuIkyIZRwtOYZrSs2Kk1ltsDf8uq6HlSaHHHyZCVrEOHjT10ReZZIALa4JrvRCw/Ge50uY3rqMqb3/yPRWEagUbd1s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343485; c=relaxed/simple;
	bh=NNeyfjKy8ZGP7PYgviKBfqCS/QI22FJoxQGC4XnQdu0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=m9D9rCzQ1NH3Q4uuYGK6PlujMoI8arXbznqp2W2aXdzSKgnso6XuG2Lou0CtZLYdrmLWqiu/V2RH7GKASpuK9zQvK75Db+QWeXkUA1CvG+Xs8KzJlWb9gCqFssUynDwabAo5Ja9FJ9Iz/TKt94bGdcBzUWEvGVgH0y4Xv9HuLHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a77a808c27so973275ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 12:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343483; x=1733948283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvYz/F16WGhbDx4cNvT6lI6TdEMFQnM9OQcYijyTMAI=;
        b=vF0/0eHzVrgSgrFe2Hgs5HaxpF/pIIZ8H3Cdi1okslpKbNKQf4uhg3/thEsBU2xoZR
         DvKghcm/6wTN7kYaqYTGqByycfI3bNj8rmhGL2SWP07XWntlJI+sqvgn6mf9jRvbYXlX
         nb53gzSteniIDyVBDrmxvSEu3FRXLwM1ITlL7QbsjMrQSg8/2xi8mNeZZHJz7lBZioWa
         ZsoBI3VMTPzI6BEidKLLNRQ0++dt+qz+C2gks5OcKGbyfIzinX6+YgnPeXifnN4g/jo4
         vq+4bP6xNGeSPT1U2Iy6ELADnXMck1ZsDc3AR4MmZXbCvbGAxQ1MsQu03dERdlf9gn25
         Pr4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhKFUBkxhkcin+xW93LVI49NUVXqzcw+DJjBfQ4HeXXd0o6NjcYLdBiJ1JTPY0Q3Ptdb0j2WBbKQD5p21b@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx8FeHRg+faJxSByj8X6M6kpmp5vbTgiO4IlxcvLCNB28pMCXg
	o9hyySyLe54Muj8CFKxpReDvY1YhrYKEXGUTCejylW3Sx47gIlMpUorvi/0m6nzCsFPyo9MURL3
	V/FJxVGlJ7ULzN/LYWEoxv7VwoflgNcdpISohVotREMYqIe4ZXTYGqPs=
X-Google-Smtp-Source: AGHT+IEhH0cr5PTn2QWjKnJaTq5+Nve/ysWwfEdZrM2AyUkDS34xX+n3rmiLxI7NpJNwWzFqTBe2/YDMHcnDgWJGHKQ6KXm6TTL+
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2d:b0:3a7:c5cb:8bf3 with SMTP id
 e9e14a558f8ab-3a7f9a3ba65mr102881145ab.9.1733343483592; Wed, 04 Dec 2024
 12:18:03 -0800 (PST)
Date: Wed, 04 Dec 2024 12:18:03 -0800
In-Reply-To: <67505f88.050a0220.17bd51.0069.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6750b8fb.050a0220.17bd51.0074.GAE@google.com>
Subject: Re: [syzbot] [mm] KASAN: null-ptr-deref Write in sys_io_uring_register
From: syzbot <syzbot+092bbab7da235a02a03a@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, asml.silence@gmail.com, axboe@kernel.dk, 
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, tamird@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d2e88c71bdb07f1e5ccffbcc80d747ccd6144b75
Author: Tamir Duberstein <tamird@gmail.com>
Date:   Tue Nov 12 19:25:37 2024 +0000

    xarray: extract helper from __xa_{insert,cmpxchg}

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17435fc0580000
start commit:   c245a7a79602 Add linux-next specific files for 20241203
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14c35fc0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10c35fc0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af3fe1d01b9e7b7
dashboard link: https://syzkaller.appspot.com/bug?extid=092bbab7da235a02a03a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a448df980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15cca330580000

Reported-by: syzbot+092bbab7da235a02a03a@syzkaller.appspotmail.com
Fixes: d2e88c71bdb0 ("xarray: extract helper from __xa_{insert,cmpxchg}")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

