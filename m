Return-Path: <linux-fsdevel+bounces-18805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0DA8BC66A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 06:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72C26B21079
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 04:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E7E446AC;
	Mon,  6 May 2024 04:16:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC95374DB
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 04:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714968965; cv=none; b=ia+hXNSN0Xz6WYfoYDkQKGZc3AmlSPl3aUzPg3gNTFKg5lU5oU1ETQItzsMEsG2gKQ3AwkWnEoW8O88XUL6V9tk2w2+CVLbksyUV1ifHySIN+2/UUdW+aroPsrNOf3gmKTo4+aLQq2sLTaURkyt+e16k/R9YqT8BYK79as0aenw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714968965; c=relaxed/simple;
	bh=e7d3eUevSjyBi1+UMir/tIUoeUJ0gThJDxFrmjgtjFM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cU6cG+BWo7cWI6ZsVE2jKwWFy02DquEnna6QT5vxCl6GimXLnqp8cFHPzkrlx2PH5kuQyJbC/S8/vHt0ERAbpdPHX96kPgW5/bxI9bkSPiKNX6sqlPBzSZXinTFTlUJjoV8j3y0HSrDKcTHUsTIHRe8stTN9o7pt/fbK6y71qhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7da41c44da7so212729039f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2024 21:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714968963; x=1715573763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6sYdOPnTbd11s8yXYICIhsmoL2HnQkl/tBOTzLZOD8=;
        b=U6oXRlsDLPF9i7PW0f1lQEV2fQiScWT0iNWRudxC/9ikbJ7KVLa4xusBbDi9hgoe9z
         ZMgivQBiSnFzZh0MLxKx4xKH2R2ZELOdsyKhWmQOg1tUIW+ocb0RBeZN19QEn0Ic1xbM
         JT9Bh1sB5MT/qtIZU0eHf1rymfeiQPDtarAVSo7lk78ItQGQsok9dEJ5Z+szvSx9rUgg
         T/3zFEUW1nZ9TS7DlF64YyvHB4cMLyOdwH1nhy8+b4I3CBwxe0hQLvPYu1ixpX1WrW+F
         eXLplxWCzhc5KgdthrhHyYm3GBHBRb2mg8zmC4WiGdvQSutvp/WZZ2QR1Uz6U/7MYyGX
         PXTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCeJl6+NhLt4J8Fwu0qTL4DKTWrH//3wUuAgkj6GNfO5sj7d9RlZwEdNRdnWWVu0PR93fyG+tEht2xc3LSGbjVHrOD07VcfcUOhWAgpw==
X-Gm-Message-State: AOJu0YwTlbDc/LHsywoYWRBvccccmvCu0rvGHM2Xa1Lbp+y/7FhO07P5
	w3MUbSvEvG0ye4C8wj+uXhLF4am0MPDtDIPqRAWVyp5VOkZc+ic0jGh2RG8tL1RKt8JVSgWnXlT
	qDo3w+dpxpx6lcY82RCJvk46Hu779FvbTcT2nM0WxPlGkIjgMb5gJ6og=
X-Google-Smtp-Source: AGHT+IGBk4Y+VQkB5ysWua6toZHslQvpRpftX5qlHvumtyLVnI52zH0H+bBch9oaAmKS7e+ZtCr14q2TWHBub43ps5U79ZwBI6at
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3e8e:b0:488:5ae4:735c with SMTP id
 ch14-20020a0566383e8e00b004885ae4735cmr440652jab.2.1714968963314; Sun, 05 May
 2024 21:16:03 -0700 (PDT)
Date: Sun, 05 May 2024 21:16:03 -0700
In-Reply-To: <000000000000918c290617b914ba@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc06ed0617c153e4@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Read in bch2_sb_clean_to_text
From: syzbot <syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Sep 23 22:41:51 2023 +0000

    bcachefs: Ignore unknown mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e58a70980000
start commit:   7367539ad4b0 Merge tag 'cxl-fixes-6.9-rc7' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17e58a70980000
console output: https://syzkaller.appspot.com/x/log.txt?x=13e58a70980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=c48865e11e7e893ec4ab
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1043897f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145c078b180000

Reported-by: syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com
Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

