Return-Path: <linux-fsdevel+bounces-8130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF9E82FDE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 01:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 218CBB2403E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 00:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B763C816;
	Wed, 17 Jan 2024 00:07:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189FB18D
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 00:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705450025; cv=none; b=WWH3VttyvIpB+zQTMWfB27g0d4ySbHQ3TVMvLY+bAvfrJ+rmpNtT1CvNAJfaRn3OoMOS3xztgQlu0uOS4dM6HfhKhV7XCW0QIMQNKncuC8hOjBNJ5wF2sU05ChIVDGUIUhzL8FPBL3rtkiaP46hifm6vw1VRkH2mZeK1VugNeuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705450025; c=relaxed/simple;
	bh=/tcqdO53EdXfqW0OELgFT/QmOAc6RYeo7trY0MclCwM=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=DC69YkmOTsN4X+o2KVD7W8shbCaUpbhllVTZLjpSl0YUJsDJnGwvkVMia9lMsoEZsaJS8zSbvAvGSt9HLidEkUMxvWxuDqxBfODvv6z6km9z8iedDOjw0tNbR+DTsWanbOVYgGrxMjK3lUMxbozS9F8M+SUhkhqT2mG3Xd0AZSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bf356bdc2fso278984439f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 16:07:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705450023; x=1706054823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlavUvMAdUpiOr4arKZ0pSY//J4vx90QCJcxBwABNio=;
        b=r/nkZGq8+rhN5p2HuogJpuyXho2l/uWu92RfCwiJnyw8NxltaWG6YW0xB8Ka4+oein
         Ybg6mKGYadmJRwXyZGm2GFONvBVG2zfQnSESJcZC+Rh0S6faYbK80EcS1LvBUMedJq1+
         q/zqzwLn0b/P8YEzneVZ/AMVTlhdDm2wNqSY2WVFRgqwI2Ynp3tdvkht5zfyOttMRho/
         smC0zDqKIArykXrvSlTXlHs63l9TTxVoc8uDdWVmSNoHetvZ26s40irBlNWlJpNB9z42
         BSyoHTDqEnNnRTfYX0rYOKMYRUDATUsLJIdLgqs3sJhbuDf6tKHu6uNvEJxzvONNwaut
         9TWA==
X-Gm-Message-State: AOJu0Yw3h3gC3uI3pF3/YgxQC6Ii1c9Fle7/3xuuWxbVjzaPGABAY5jt
	bSV0iASklV18XCiNbIBIHrmcmTWgP32xR0v3ixwWH3FkxVzz
X-Google-Smtp-Source: AGHT+IEkpFYmbytpIqhwd1doRIHX/Gj50g1X8BedK7iVLQEUMWfCZTSu2xEHtDALyvBTcEkp9QZtU3Hr8jFD2nxE7jiMWlQ/UDXJ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1baf:b0:361:94d2:6ecb with SMTP id
 n15-20020a056e021baf00b0036194d26ecbmr54961ili.5.1705450023356; Tue, 16 Jan
 2024 16:07:03 -0800 (PST)
Date: Tue, 16 Jan 2024 16:07:03 -0800
In-Reply-To: <000000000000af650105f0e7a9e5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d31227060f190634@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: trying to register non-static key in do_mpage_readpage
From: syzbot <syzbot+0ede990fe8e46cb5711d@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, axboe@kernel.dk, 
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=102de4dde80000
start commit:   090472ed9c92 Merge tag 'usb-6.7-rc3' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=52c9552def2a0fdd
dashboard link: https://syzkaller.appspot.com/bug?extid=0ede990fe8e46cb5711d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d4a3cce80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160ec6e8e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

