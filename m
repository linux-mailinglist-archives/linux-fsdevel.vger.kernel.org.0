Return-Path: <linux-fsdevel+bounces-45187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD3EA7430E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 05:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E4517938C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 04:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EAE21129C;
	Fri, 28 Mar 2025 04:43:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C86BE573
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Mar 2025 04:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743136987; cv=none; b=F9OvvILFDeC9BGdyJvccT5tLde2XdE3WLRAKIlcHQaKFjYhz8H7NxN5egWlfMW+zhvhow4GtQ77WnkfIlsw7YjzFGVe7TFJg13FlxqunKIQ6NAY+oyjU9/GGspqbe6mZZNc4CQ/M80Jg4jguqf1mmhRUXeSXtr+Bs3Yn6D8GSSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743136987; c=relaxed/simple;
	bh=js7lVUj/SeoCBiYflPxyZS1OX5HQtjm0DSuCarpQVOk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AWIJ0BEKMqDLnix+lrIxI/DUVBokmbGnK/w65owg4Zr020keJC7y8Gl2pruoUg2bEc2ZQQMPOA9M+8bUgsbvWogWJCk+QQSRse+TzReanExL6MQ4/hWW9euMToG3MiZSsGblu08ZvYtqlq0DGpb1lysW62OCdX9tJg4n8TPmmDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85dac327403so334196439f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Mar 2025 21:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743136984; x=1743741784;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5uDB2tY1hUjqwKYCX0GkGa9GQ8Dhnk/SPYhijdcB1Zw=;
        b=DO9HkImobc7vt0FZZ/gaNnwAyqPRVbQprwTsOwTrCidElCMUxo22/LDM0bGhxDzA/x
         VDwpAaJRIKVtZHfR4nRCcrdyIyxAsBbLkV1z1kTshKM3ey9JHXyXHHloZRHwk5lHd4FA
         4KdZaSFmfl/b9HYgW7mVu23nxHiMWH9Q0SEyc/LdEL7xWHFLMvsFIOVsfLs7pLKX6vOD
         +u8bqXif1QD3dkivVjvf80bkxuWeyxDQKaX/mLQcSQ+ABNWPo4SSZwErbaIE/c6K3d72
         Dczi6pVL5p1wqfxFKw40HcLMOGP4wJn8cTy7sT8sY3kyXFrkrXGrKKu034jwYJDAD8qO
         DhSA==
X-Forwarded-Encrypted: i=1; AJvYcCW6gX50bPOsohlb6ZAZzFDD4kuHnps4yMF1ds49eRQZ6Im7qtAscUHtBqe3XttmOFe02Y8NrHan3b3eeORz@vger.kernel.org
X-Gm-Message-State: AOJu0YwOG5saBF9t3ySxK3iEg7783AckPbpOg02p87ax4vkHDGHDWBpu
	VLgVBnb3N87K9SOl00LnXayAYe7asOilTJZfF2qhfP2lgOmFEtPV3ZyzmyCY9OZMM/Z3S+UkFof
	L0xi/kSDdANgSMLwpr/WUOonqNjy4/Pp9S/ng1OWAkzjCsH1DGAXMvwM=
X-Google-Smtp-Source: AGHT+IGWgZFryTvbQEfzj3JsavMzFoFExpg1aIjajV07MaP4R+0EXVOn6LPyfYjxRCyNxZA4kryrJUyJ/SpS825l7GjAM0x5LOEH
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174e:b0:3d3:f040:5878 with SMTP id
 e9e14a558f8ab-3d5cce2c7c9mr76000105ab.21.1743136984504; Thu, 27 Mar 2025
 21:43:04 -0700 (PDT)
Date: Thu, 27 Mar 2025 21:43:04 -0700
In-Reply-To: <49c26b3c-cab9-4ee6-919d-c734f4de6028@amd.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e628d8.050a0220.2f068f.0057.GAE@google.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
From: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, brauner@kernel.org, dhowells@redhat.com, 
	ericvh@kernel.org, jack@suse.cz, jlayton@kernel.org, kprateek.nayak@amd.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, mjguzik@gmail.com, 
	netfs@lists.linux.dev, oleg@redhat.com, swapnil.sapkal@amd.com, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com
Tested-by: syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com

Tested on:

commit:         aaec5a95 pipe_read: don't wake up the writer if the pi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1285fa4c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d5a2956e94d7972
dashboard link: https://syzkaller.appspot.com/bug?extid=62262fdc0e01d99573fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=121eede4580000

Note: testing is done by a robot and is best-effort only.

