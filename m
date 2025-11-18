Return-Path: <linux-fsdevel+bounces-68822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA85C6715C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 04:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F78035C4DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 03:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCCA3195F4;
	Tue, 18 Nov 2025 03:03:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B452EC081
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 03:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763434986; cv=none; b=kJxeLC7xzQvwzLg4dcp5rsym4DOPi+F2OR9kbGqIDJ2+aE1n/F0DAOiGipIt37jt9AGh7YNtR5UFCm6rM58rKO5pg43hr3q5u7QqHLf/Uurbu3GQdarf1H07jxlA+bK37b9ZUSrYYEBNv/VzEcRVcaNpK9zzfQOE2ZHUgSV7bWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763434986; c=relaxed/simple;
	bh=2Cb6nyuCU84hwMH3woh9BQ/HanwBqbsFrhaC68L7BJc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eI8TVKBvwUGaw9YK3TslnveeuEYde48gOokbXs42ouUftY88lFUmS4CDTbhmcfmsgo9mDwKsWSZn3wwsTxzvNxNRLJrZrZnonSTBdtmCZ7woRqgv9ULrW2blDK+bJxbgWSD/0OrLrxpQVom5u6Bax85y19DhUo9D9jEXjYDnXlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43329b607e0so57391195ab.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 19:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763434984; x=1764039784;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jwUXJQvDPxKgUhbRNl7QLSBBPCG1b/BMbMJ8Tq/IhSo=;
        b=ihAvMrzBCl05exUuuUTfXc1iUHHAkT9mF/DH8OeQfWaFqQzyF8FzUOG7E0DQW2peVu
         k/aMZNHFZUOUrDsjXvpNLMSx1Pjjavvh8Gu5sy3WXByjjKWnxWEC0bjUQ5jW54CCymnE
         0p0vu5L9D8uYZJQtxzi/d0hfH0VjiDqfrbe8i58x7p7gRPmJB7aBxz87XEUsZF39BWTC
         14FKnN1zUpHpk7zWGTYJsZzYfBHhZTDR4U5edBTOCr7aE6NUwHQESCrdRO7yUSL/+Ehf
         KorFgrjKMfEZbiQpu5ppvmmk7TPCfcZv0Noma62ZBPuqmwR3wgsrykRAn4VLeHmDBstn
         uWdA==
X-Forwarded-Encrypted: i=1; AJvYcCVICMAcC0p00gocjatoljGqqA4ueq+R4zh0xHn/8zEkaoanHHPbl0UL7QLH4uJ55jwnI4XqukAw2uqOL78w@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2vVlGgBaG57HifPgOd60+0OVWLaJzAJ8eDsaBGF34otPCDsbF
	L3N8dtlPNru38QpvlJ8uH+BZ4w9PdOkannw6URVpFRfcLHKaEnEx8XylTTkiREBJ3ro8lryHmMa
	a6FtAlhxZpfNppg1DBy1ys9JHiI7chaXCdylXsdSfcWQHztM+AttTDB52hzw=
X-Google-Smtp-Source: AGHT+IGWQ6WJpxRVbSfPJex/xQncmPfLJ9KXRGuf2RAfLdJPjQC9WHBPDaZQTxkpK3S25vI3HYwzhOKHJzrGQkstqf7aREcKrZPC
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2789:b0:434:96ea:ff62 with SMTP id
 e9e14a558f8ab-43496eb0173mr144411975ab.35.1763434984030; Mon, 17 Nov 2025
 19:03:04 -0800 (PST)
Date: Mon, 17 Nov 2025 19:03:04 -0800
In-Reply-To: <20251118002044.9391-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691be1e8.a70a0220.f6df1.004c.GAE@google.com>
Subject: Re: [syzbot] [kernel?] general protection fault in put_ipc_ns
From: syzbot <syzbot+b4c65e7d749285a82467@syzkaller.appspotmail.com>
To: brauner@kernel.org, hdanton@sina.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b4c65e7d749285a82467@syzkaller.appspotmail.com
Tested-by: syzbot+b4c65e7d749285a82467@syzkaller.appspotmail.com

Tested on:

commit:         cc7d6c65 nstree: fix kernel-doc comments for internal ..
git tree:       https://github.com/brauner/linux.git namespace-6.19
console output: https://syzkaller.appspot.com/x/log.txt?x=10d8e212580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e17ff55912ea78d
dashboard link: https://syzkaller.appspot.com/bug?extid=b4c65e7d749285a82467
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

