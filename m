Return-Path: <linux-fsdevel+bounces-26329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841A2957B29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 03:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70CD1C2320D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 01:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F291C6B2;
	Tue, 20 Aug 2024 01:51:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B66F17740
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118664; cv=none; b=skgnLOj7IqB3wCkU6OeXPdEt/aUGkCcp0gXbleWg8py0xhMID6dFtHR9KmleDLQky6KxMv9+tOsgyZJ0YnuwaxsF3yUVeMUJl7IIofLfVCybbLap2cKQv5MTeu9O3bATusFdhQ6thXKMbciKmkn9xh82AWS2f2srGJNKE/o7CzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118664; c=relaxed/simple;
	bh=gxwgkC4k7LhKrDiQCelOrocqVsr3XdMiu9issbRRE7U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RcJeuhYkCod+G/Z28duujW5brdOz7TNjoXcVHuolzuRdSz5z+lsewXQIF9/e1Rd4bUYkI/X76eMhFMk2K3/QAqkglcGZxAEoS3Z5Y81LzdJ5q6lfrzp1RNjzCUMJeTUMGPCAm4ksILJSdLogY5vD01ZF8pQWBJO/ePv0YKb1A30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d52097234so15042805ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 18:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724118662; x=1724723462;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lfXe1U4CqkltrMEzBmw/eZV29NzSNayMVkqz3VwUfPE=;
        b=rCw9YUQGQp2yTE6TXRjVp3HeVjdH/R7d07ml7YSjj+aA8s+fhcyc9qqyZ9gK/N/PyH
         6h0PjD2QP/NWqx4rO09UyHi0qD1+FYwZc22guTFCXSyY6EQ0/e1UjSm+/KB32xV/xVRv
         khPw96zUTbfW7J53BfT2FScfFudA9KRv/gQq8xmFxJ4u9wqZoLJi/p72BtiJyDcRBZ8m
         ZmjnygR4KdOydVeYQr55P9yxUh37ovxUAg3yKVDElTkI6r4cA9FE8G8gI0o852soboNj
         lbEODRrbN/qSbzoL7mZg3C3/YReWZE/8+pPNhWLgnWPY5INwtSUzWRyYgl2YnuW3u7iE
         HGcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKCRcFMMS1yRCqLJJxP4q1OomOxWwk0SGGauthaxTvt4FxBnNGw5QCrEcNrn7tCA4zcckjBZjkJCmHwIFKcCpNBHAQUdABOh/TahXmAA==
X-Gm-Message-State: AOJu0YwHZUM+OS0EszyYwyN1lU/Sxj/5Ydw8J5UvcUk2rO7GDlhXZ4jJ
	YZXdXrLNT8DmvRLzrJ/e8Y5oDRzs1kzOeCQ4g1u+ChFDypzR56i5FWFEVK9C3QjViX655evoIWK
	UzbJpX/pIG9xFsAg9RXb1pa9NXryeONhVTcf1pNjSylj9hnN3hTRP3/U=
X-Google-Smtp-Source: AGHT+IHhvwkvDZCaadZdhsiSqjoOtcaRdE1CJ0o5t5ee6FqeceFHMiwVUdrM48dac9WFU/VpvbQqRQ1fJHNq+mYrNYueGDnokCDu
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c26:b0:39d:20a4:f42 with SMTP id
 e9e14a558f8ab-39d26ce4072mr5909245ab.2.1724118662649; Mon, 19 Aug 2024
 18:51:02 -0700 (PDT)
Date: Mon, 19 Aug 2024 18:51:02 -0700
In-Reply-To: <0000000000005b04fa05dd71e0e0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000703731062013a8cc@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: out-of-bounds Write in end_buffer_read_sync
From: syzbot <syzbot+3f7f291a3d327486073c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, almaz.alexandrovich@paragon-software.com, 
	axboe@kernel.dk, brauner@kernel.org, cmllamas@google.com, elver@google.com, 
	gautammenghani201@gmail.com, glider@google.com, guohui.study@gmail.com, 
	jack@suse.cz, konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mark.rutland@arm.com, mingo@kernel.org, 
	nogikh@google.com, ntfs3@lists.linux.dev, p.raghav@samsung.com, 
	paulmck@kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com, 
	ubizjak@gmail.com, viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 6e5be40d32fb1907285277c02e74493ed43d77fe
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Aug 13 14:21:30 2021 +0000

    fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11eaec05980000
start commit:   cc8ed4d0a848 Merge tag 'drm-fixes-2024-06-01' of https://g..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13eaec05980000
console output: https://syzkaller.appspot.com/x/log.txt?x=15eaec05980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9016f104992d69c
dashboard link: https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14146f2c980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12400be6980000

Reported-by: syzbot+3f7f291a3d327486073c@syzkaller.appspotmail.com
Fixes: 6e5be40d32fb ("fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

