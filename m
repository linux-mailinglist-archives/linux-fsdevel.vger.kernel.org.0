Return-Path: <linux-fsdevel+bounces-14034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C39876E16
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 01:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807FC283FA3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 00:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3980D15AF;
	Sat,  9 Mar 2024 00:24:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA0437B
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Mar 2024 00:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709943843; cv=none; b=rg5CYoCM7ceBQw88gI6M/SW+A3jEuBesL4mVCfKmzfnrNNZYXeaLt8z1tV5omOrAeZyIIopfIsy9GFWaAXi9murNfgwQtITecUPLnZ4C262+lmEbb2eegqzFsnEfYwVtN8mLFUGaW4XscHyjJZxrcCAQSgfG2lAsa3R2rEe406o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709943843; c=relaxed/simple;
	bh=m48oX7+m5s24ipjjo9BK6u8a/BIBnZVyTJXi0+/oIwA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Lr/6PGyNa40SpbhhAi4tgwCf3anVjbVykr/JYvQm4zzMUxmEEPYZChNWOjF3XB5wvw3IsSyJO8Ld4FhcnB1Hjh7Sdd7KXvirFRrdA84j9wXXjcpW37Aomz+D5na92Ob6CXfa6M95vPSlKXmWXsIzamyRdqPJGzuLxAYMSGBT+zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c495649efdso306075639f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Mar 2024 16:24:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709943841; x=1710548641;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFNzruI9+38j8zOzO++Z/K6VHh74kFYEU9XlGrBzFlM=;
        b=PL7Te30zFVS/ys5/1xqWWFjA+NBYyL478KOHhkaJhCVyGZF5XjYI3gBC+enDdTUjzL
         GXWgBAWB2UCszNX1zipbeYcMFQm+Kh9vHRKy9ORu/UmasXFq2N5Z477Zt2dOI4vl5Ke1
         sGzXxX3A71aXmBK8097hNZhz9GhVGpjPTzrVK24xeIl6PjZrKZecRFCzazQTasQ2L2lb
         hvDXQHKKlEYPgPBGUbH+CKQ6yWhl5HNoSfQVJxmVvoQLaiBus9FJh+SLatXdaciSSR6P
         Z37qDbizb/FnIhmnVOCFnV0BM+E4Zzf5//vE3pjVA/pGbi473B3HKhxv9KQelUnMR7ve
         gNbw==
X-Forwarded-Encrypted: i=1; AJvYcCVaZq3qPOO4yAQQD4dx5v/kPNAsSBEzLE6k80fX7APMiAvcQ4CcP1jBTWKixt4ELZZ0REo/LWneisTsV7g31NEs7pmZnxPg/YzDyr1l9Q==
X-Gm-Message-State: AOJu0YyQkBiwhGCF5q9XAORLrXHP52HPIbmbuwSxcObVui6737sWDi6z
	cN8UJMxpRCPnBJxszgh3lnAq+q4hL1Rgn4tbq1RgAqyCW3N5N9tpyZzIRZ8HSX9ZYnCFtnCQzuo
	EsyWFilQAmcI20X9hSK8knmDU3okzR8ySRyUXdnm0CapVjDnfSL+BN/M=
X-Google-Smtp-Source: AGHT+IGQ2kpooODmF4kkxScY8szh+qR+NzKFr2lUr1iJjnYIaUmmEvvNNVihFwPmIP47F6j1+hUi+3mhJP0tYWh3pwyBUtOD1ivH
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24d0:b0:474:e855:df7a with SMTP id
 y16-20020a05663824d000b00474e855df7amr27018jat.5.1709943841659; Fri, 08 Mar
 2024 16:24:01 -0800 (PST)
Date: Fri, 08 Mar 2024 16:24:01 -0800
In-Reply-To: <00000000000032654605ef9c1846@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044ad2b06132f53c2@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in do_page_mkwrite
From: syzbot <syzbot+ff866d16791d4984b3c7@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, hdanton@sina.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11595c8e180000
start commit:   33cc938e65a9 Linux 6.7-rc4
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b45dfd882e46ec91
dashboard link: https://syzkaller.appspot.com/bug?extid=ff866d16791d4984b3c7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1048c7c2e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161fa8ace80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

