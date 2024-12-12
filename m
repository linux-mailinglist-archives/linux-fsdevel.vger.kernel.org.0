Return-Path: <linux-fsdevel+bounces-37211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC16F9EF98F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 18:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3721758F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 17:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A928922A801;
	Thu, 12 Dec 2024 17:45:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6EE22A7ED
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025508; cv=none; b=tw0MXf0OgRD9BI+JBErw6vfH9e1e8oFp+Ley/mljIIDNhr88PYKliVYx3aXCFv0gPH4aUZbQrUTJ33DHB+g6bslwwjSc3BfO14wgdHNYg0dWQILh27QP5zz3ofKmKbBbD/O1K+Vd5zeG55cxejxe3DdbAFgZ6PxwWvVTCOra8R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025508; c=relaxed/simple;
	bh=x1ebds0A4ITC/sm+Dhq6yB36jb9JvMNqJd8QRz/f0UA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AqOu1nxOOCeqdln5swQQggkatZs/TkLCBoKq9bD0iI1R+pAhHZud9Tle/ElKZR4hhWZ6DqbNyFU9eBHEcrYEwwkHBcME6GE1MlI4CYAc6slCVzSV5WfVFCNiNA6m71QJLCeeoaDnV78+zQ6lYzdDHqtseAMSwWPzVtdLaj8aTgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a817be161bso8031465ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 09:45:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734025506; x=1734630306;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9t3S6ZRkXGObRSWAZmUeXYAxsnGMHk+WsD4ydDf2ek=;
        b=G2ktzL+FoTituRqva101i5HUQyxBtGmaYyMnARN1v+1mFNEmfMaXS+NwVjqDAkWaRL
         Ne+5MGAP2nYt/6yxaJ5WHSfVLXCRtaEVRFAtNbj2cVhijizhrthGoXmVY3W9s68vVqrz
         JMGtfPFVMKE6tO20MH+JNwup/CjEavge5xO8PiOLCnAe6UgxNnuRolYXlaq5/cykkTKf
         zmbwMS/lSvPpRJs2aJAsbaWOoVscOA+6d2yWEQSs23xMVZum6o7VqzCyrCEAaDHozoSE
         /5e9U8fsQ4qcVmoZoLqmwaaYzt4YUuY0E1lKlikd3QYUepdQ90UaF5smMNU496Umeb2P
         H4Qg==
X-Forwarded-Encrypted: i=1; AJvYcCV//PJ0P8OBGq2vVtz3SWVOoLQF55b5AejBNJVRSCHhqi03OM7OjCWaKChKrs/MXUQGXrwoZT/cZJLyc2iM@vger.kernel.org
X-Gm-Message-State: AOJu0YyxIn8Pg+bBucQxF6HKVHK8FRmehvjLBPJK0otd0BKGoDYb1h5I
	YC7IJ9mSZESKimo9bUfn6l6+tHugJeOPBa6UoOLYuRGXIJGf0J4RUfk6auRTpO2XiiMtmNM1yJL
	PbhtfglZnIK8Dpq3qnybdrW48WdxsRIZ6eJQpJtDz4usjsOj993oCKWw=
X-Google-Smtp-Source: AGHT+IFyhqpCEOPaBtPLeyRhCBLjPnw/q0ZWAxsE8A0uMBNj8BNOxBHZWHwKTp3EUDpHiFfCRczfjGZ7TqiHyu2YzErDFUsi3/e3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152c:b0:3a7:e786:afb4 with SMTP id
 e9e14a558f8ab-3ae6f50f3eamr11184075ab.2.1734025505568; Thu, 12 Dec 2024
 09:45:05 -0800 (PST)
Date: Thu, 12 Dec 2024 09:45:05 -0800
In-Reply-To: <674f4e43.050a0220.17bd51.004e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675b2121.050a0220.599f4.00b6.GAE@google.com>
Subject: Re: [syzbot] [exfat?] general protection fault in exfat_get_dentry_cached
From: syzbot <syzbot+8f8fe64a30c50b289a18@syzkaller.appspotmail.com>
To: Yuezhang.Mo@sony.com, daniel.palmer@sony.com, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	wataru.aoyama@sony.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 8a3f5711ad74db9881b289a6e34d7f3b700df720
Author: Yuezhang Mo <Yuezhang.Mo@sony.com>
Date:   Thu Sep 12 08:57:06 2024 +0000

    exfat: reduce FAT chain traversal

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17851be8580000
start commit:   f92f4749861b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14451be8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10451be8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df9504e360281ee5
dashboard link: https://syzkaller.appspot.com/bug?extid=8f8fe64a30c50b289a18
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bfbb30580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124e7544580000

Reported-by: syzbot+8f8fe64a30c50b289a18@syzkaller.appspotmail.com
Fixes: 8a3f5711ad74 ("exfat: reduce FAT chain traversal")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

