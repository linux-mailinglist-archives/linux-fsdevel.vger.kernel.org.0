Return-Path: <linux-fsdevel+bounces-8386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ECD835A09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 05:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1598EB21FDA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 04:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4B44C65;
	Mon, 22 Jan 2024 04:21:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11D61FA1
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 04:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705897267; cv=none; b=dBW0R9Z9rzEo/ULW0V5NdnRmyBUjLWjNyhR70VKtu7zCV393BdhSp7gJKX4t39LvNQ0WZBwMG0yIQwtYeJixEdxMaGRQxz/5wu0lwrXpiLRLKMkrU9fVv2Xo+M9AbJxiddm+VQESHuj9TI/Akht0cmeaVXA2kKoGwslPg6YCr6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705897267; c=relaxed/simple;
	bh=yBknp7rDoro6OnNzFvJHw0ELV6UD/IVEgSajNLaz2Aw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q0Oxxp1UaeBpw+eFqpPBMGU0XTh1Q59dEk1ediBy/iyFDmCYmXWAObKEusut/Dqw9Tah5ZtKp0Cpc0jziynsYfPHxBzSiAqF7/KxOhYSYpjXvXUHm1VHDc8TNo4SYmgfotbrnPBNUW+SjKa0/r1RsW5HBBkitD9nuI2AeEX/FLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-361a5c2e84eso30299215ab.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 20:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705897265; x=1706502065;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eXPpclGAIFhBERZDMtHr6l2YeB7w8V9HRVruQN/Qu+8=;
        b=dJG3fuj29k+XTLuy0d8u1MCus3UVum6VYkvjehi/aAt/UGW2GiUmKpcvmXKYfZ5OSS
         AZvn1BiL3h5slnBxxplZPg2g0q1s1VrNNxKsoe2/E+JGOaL6rAlVSah4gXPzDW84djgh
         N44UvEWmHza49WXxnTMdJNEYA+0oHP4FWbjX8BSmNfcoEn9j0ydLp0I4Nz+jdweXzWCe
         FLYIazhci8SuZjELlifpVnlaEq5nJSvKvhE/WpjEy0BwmpWUqM2OCk8l1K6p5t3HsoCk
         MwZ/Vjx1aHUDu6MvgW14j7X4V55dih9u/54phoTeUh7sbfB9Gqzs1BAnddPZrFakSaUS
         yr8g==
X-Gm-Message-State: AOJu0Yx7UPMeVk2bsoGYma9hg8was5UzTCcDCj9Uqq8uxPhzSCfIOXh5
	HWQUBCwwkNqlSASGhafKKlpNxdwre+HxCmN2Kec47c3wfHL5h9cXuAxS/amGwgpOKJyd7BbM2wB
	jbsirRcuoanODAjFk4NEUTA77befXY3Yz+mD93EUGb6leA6ENBEM482E=
X-Google-Smtp-Source: AGHT+IFSsIjvr32mvZRZi+H1GDgew9dkknvF5/aCpqQSyYakV+KxA95Xjx9FhG/BiAb9fGF/jstKcbpoyx9sMfrq2hYyC1dUnDzi
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0c:b0:361:955b:17e3 with SMTP id
 i12-20020a056e021b0c00b00361955b17e3mr458490ilv.5.1705897265051; Sun, 21 Jan
 2024 20:21:05 -0800 (PST)
Date: Sun, 21 Jan 2024 20:21:05 -0800
In-Reply-To: <000000000000d482ba05ee97d4e3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081bcbd060f8128e2@google.com>
Subject: Re: [syzbot] [gfs2?] INFO: task hung in gfs2_gl_hash_clear (3)
From: syzbot <syzbot+ed7d0f71a89e28557a77@syzkaller.appspotmail.com>
To: agruenba@redhat.com, axboe@kernel.dk, bobo.shaobowang@huawei.com, 
	brauner@kernel.org, broonie@kernel.org, catalin.marinas@arm.com, 
	cluster-devel@redhat.com, dominic.coppola@gatoradeadvert.com, 
	dvyukov@google.com, gfs2@lists.linux.dev, jack@suse.cz, liaoyu15@huawei.com, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, liwei391@huawei.com, 
	madvenka@linux.microsoft.com, rpeterso@redhat.com, 
	scott@os.amperecomputing.com, syzkaller-bugs@googlegroups.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=137b2d43e80000
start commit:   3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=29fd3392a08741ef
dashboard link: https://syzkaller.appspot.com/bug?extid=ed7d0f71a89e28557a77
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b6f3f8a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1688b6d4a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

