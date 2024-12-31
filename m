Return-Path: <linux-fsdevel+bounces-38300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7645D9FEFD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 14:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D420B3A1C70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 13:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C281A0BD6;
	Tue, 31 Dec 2024 13:41:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8606019A2A2
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735652467; cv=none; b=qQezXQQEO7VxSKM95P3ZBGWzvHFgM0/pDXBX12OXTKioiWQYJgWVuOcXWbeHsIawV0/SG0uIzjjieCtio7edp6vBc+I/scV/KDgMDkUmjZU/o5okV6hdeKvUua1NZwjScEN1wa2YfWhcyKczr2p0LV9F21nyB0f1evQuUUbpX5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735652467; c=relaxed/simple;
	bh=gpytiD42NnvbEtXzLzgZi6mddslhHVH3k1ktExUFAfQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j/6XBexWn//IiaiDJGVLO4nZSmcTv/weurIp+LvlXepTVKUxjB5/6GltZRKX23bOJx5oZ704PN2ODpjE/2Vs5NBaEE6E9BqH5ScFELiwhQ+CYUUDNsM2SS0FOdYgXCoUjACH0PNQ4AhQVYowni92qFdeKNuSoPtwo/LcNdzqFhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a9cbe8fea1so104470465ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 05:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735652463; x=1736257263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2feX83H9uga5KA1CJ4hGNUgTfzahPnnN1QDJLNkqayY=;
        b=BLRwCdaSqxYbDAv/RW3SAGe9+YbwxoueExDo3aZ/5F1AkxY3JkKOmZfgGbXhp3EWLy
         dEmGwsUu+i0plRG9cok4stltDXj70MyYteEpyGrj17VQM7LK6nBwwpT047tF5yfjiy/2
         7J8go0loPwRhcznR4ja8HMzLe5LOWWdIS0NIqpYUChBbA/j0mh2/7JcZIKC3+lLi9r52
         IAoN+vqjeISeeGcmXAR70CeqTFepztWwB3YT7BmQKufLCR+n4bxXQ6FPFUZ0Yo8EdIND
         47l5SBRPz6yBhyBcZojfQfsJeq8qvLH1FKHojUoDDsdK7QOgZmV4q2A5KtIGWS+CLhZw
         zV9A==
X-Forwarded-Encrypted: i=1; AJvYcCXapJUoCXlFSfYqc5oYHgvPOclNBFGz+MOzTmsQYpa1DKT1vsBs9xISDG2+tsDHWEW6/ALn8XWgbGQlLgs1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5WxvwXyjLtaRe1syNe/vUNK9pfqYt//vw55AmOZ9/WyZgiTd7
	oAkKcSkyV2Ux6xR3GZul8ixNPEl+0f60ugAqihmDTdgmPYF4ADiLjY1du2K0oqqJhXQqtCTLNKX
	QmgRC2rJ4LTA3cs8iv70jNgBGP6m/1QTamh8h1ZEjHxKoYqBhd8GJjWY=
X-Google-Smtp-Source: AGHT+IHck0cSKOl4TBxrBqCbQozTDnVFJYGc8OOqgdIsZFeY83XGx10ph1v4W9XYE3lhndq81MWXRM/PPDsWJbIqr+iB36QZ2+xP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:349c:b0:3a7:fe8c:b015 with SMTP id
 e9e14a558f8ab-3c2d581a343mr253968425ab.24.1735652463705; Tue, 31 Dec 2024
 05:41:03 -0800 (PST)
Date: Tue, 31 Dec 2024 05:41:03 -0800
In-Reply-To: <783e93af-42ce-480c-bc8f-834a787bc0b3@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6773f46f.050a0220.2f3838.04e3.GAE@google.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-out-of-bounds Write in __put_unused_fd
From: syzbot <syzbot+6a3aa63412255587b21b@syzkaller.appspotmail.com>
To: amir73il@gmail.com, eric.dumazet@gmail.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	repnop@google.com, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/notify/fanotify/fanotify_user.c
Hunk #1 FAILED at 1624.
1 out of 1 hunk FAILED



Tested on:

commit:         8155b4ef Add linux-next specific files for 20241220
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c90bb7161a56c88
dashboard link: https://syzkaller.appspot.com/bug?extid=6a3aa63412255587b21b
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10931af8580000


