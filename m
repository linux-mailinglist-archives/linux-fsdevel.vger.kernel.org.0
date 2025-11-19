Return-Path: <linux-fsdevel+bounces-69044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAC5C6CCCF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 06:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D205935DD62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 05:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BF230CD83;
	Wed, 19 Nov 2025 05:19:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89EF30C361
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 05:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763529549; cv=none; b=Ydai6iqkqiSSc3LVhH2ltRIVQ83cs6AQOF5Ih/fm0z/NI9iGZTGwfn5OSyRJUOyaOgLEYkLeMbEHdJFQ5X4kG3pYtimiEZ5OK7kk0LIDNGKIsx/R/6+Qlz7PIIUX2AfeUXdkLj4Aw3Kf/kP8h0GDXGomyR6UW2ZwRyvAIc+UU3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763529549; c=relaxed/simple;
	bh=66irg/y7C8vP/7qiKAPYRNi9VYkMnk9pFDFaG4owRng=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nHYrxi7NMot93innrB8XTb+42tuD6tGAILrLOiQpYLSqyhGyEENRs3J2cSe59zfvOYetgTwBuYhJnXmy+DZFRkWk6panL/kI+jVE5gY2qiPMkHZ3/rNxw4Eqmks/CU+I8KX73gpmld8RUZaIT1Q8hk8Ro9IiN7sk14mNxz/5C50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-43331ea8ed8so58782335ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 21:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763529543; x=1764134343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAccIO2NACimBngnRYo3AqFTiOzlZuN3wkqbb6Dx+WA=;
        b=fJd6xJZqvLpoyuTdyPFf9tfgH816gFAsN3VQOehWOzKWoQ1MVaBkEVKGOAwspY0KIX
         LI0ccenmZgFmJBoAEqyceEcRjWXoNhUMJspOgZ0BkLNqRpb3t7N/4U88WSRSQZj9XvvX
         uN85u8Mbi0geQFub94kZj58R1JYgOvkcrP+BAKZO6ql42/Nm76J3UeDQZYXj334Qkuxd
         JbLLZgnna66m18oIhdErJfeNsLT13CvKUGrTrNFRuCfJC+m7ltkMPwQYjXE+lG4sRwEZ
         88cqakYYQx+YTiFLLusbXxFVwXAl/i/cmZxM6V0r3loJYLuMwe4+GOWeFWSIG6sTcML0
         NhCg==
X-Forwarded-Encrypted: i=1; AJvYcCX/OTw8Jb2bAieOA9IZj0kfXhdFi++NvADx6d/8tXjkpuZyNebK851fnWVok07YQPZSIHyGWpj/HIXfI9d3@vger.kernel.org
X-Gm-Message-State: AOJu0Yytm+0KljszcCPt/qQnUP8IUypYQud4SS34ia+yzk4oVMb9DE2D
	xaF6OPTmlxA0SjWwIXcRaR8gIjDHhkoZ9UE75hR8dAOn0UXyLt2l3IzK5HCUoFJ7DGLTN12JNlR
	SFZZh2Zg+biuhLhW5rKsX7M+IYUegyyTFK7hADzU1jcUeZ3XJeN1Rt4HaCUg=
X-Google-Smtp-Source: AGHT+IHTMcSPBDdHwQPC4eX8dn9llg26ONAuOsZb+hKsWFYzFcz4E97PttHIcdqZO+qrrvpaI8sE1xmrYQbkvigWeIA3te9lnmKN
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cd:b0:433:2711:c5cc with SMTP id
 e9e14a558f8ab-4348c9491b2mr263067285ab.32.1763529542833; Tue, 18 Nov 2025
 21:19:02 -0800 (PST)
Date: Tue, 18 Nov 2025 21:19:02 -0800
In-Reply-To: <20251119053201.2949-1-mehdi.benhadjkhelifa@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691d5346.a70a0220.d98e3.0006.GAE@google.com>
Subject: Re: [syzbot] [hfs?] memory leak in hfs_init_fs_context
From: syzbot <syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mehdi.benhadjkhelifa@gmail.com, slava@dubeyko.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
Tested-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com

Tested on:

commit:         8b690556 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c40742580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f30cc590c4f6da44
dashboard link: https://syzkaller.appspot.com/bug?extid=ad45f827c88778ff7df6
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16949658580000

Note: testing is done by a robot and is best-effort only.

