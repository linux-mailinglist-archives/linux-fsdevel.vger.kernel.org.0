Return-Path: <linux-fsdevel+bounces-36301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 886029E119A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 04:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 083EAB222B5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 03:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DFC1547F0;
	Tue,  3 Dec 2024 03:10:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C2C1FC3
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 03:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733195404; cv=none; b=ejgPNBhMdrQWb1Xz5ik5AjlR/QW/+SZRrg49fWylAhgQAGVlVrYU7USFme8Sg2BV4oprICh1HPb5mDb5rGSdB3kV2LO1mIacMcDpm8OZViRc7/OUqDaCpdiW1jAPblpTtt8b5TTBwnqcwqMvQSinTGeZwPZgk+xH67UsgWABx38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733195404; c=relaxed/simple;
	bh=dUJO12D9XJ50QVcP4tnHZQjEgG7fwLFweIIApvfiUiQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DmBIiJAFWU/D56wXo7HSuer2ER/H5l3AJ9gPvI1aqL/BuI9sz2rxkRrgWgfV/47frfGCiCgQXlqgvkedNVvBS+rOYV/ojSZee89FHFz7yrrEpXWH5Co8QeqUICf6RJqXHm15Bs5q5761c7pgVejiz/iiCQmYhgsTSbFEWekGcNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a77fad574cso44744385ab.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2024 19:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733195402; x=1733800202;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dsqlgTS+ltLHskkFc17ghIGhtDEg6fOZTOy6NapKTYA=;
        b=mPxcoqxdT04zf/NoffW7fdFcnUVbptk+1h2OWS8p/R4lnAAaeENMGKOARXQkBOwgQa
         tmkfY+e9WykOcDR93EvygWhhqHpQWTdw1mVb8YClLxxE/Gg7S2EetPh4EIqoB1MGGNSz
         sU509SoN1xKJvNbhk6GwJTmIj+z/tQKCqO+bfkGeESwsLu0Y6+RitKpD7B4aBNyGfWlI
         xlw9/yn8RcL5rX/44aWePXXDcYrfv9PJb09tfCrPjcKEMEhvhbsmQKfwx7pPWgXQu17M
         mOEQ4WxlJWwi8G7ST4FCDAW6c7TVCjHz1ddndyygvbqBgSBIxm6W/YSc8z046tovcRlb
         Gr0A==
X-Forwarded-Encrypted: i=1; AJvYcCVnF+BwWr9xDrDSHcq+p3E8H1LrLfO6TfF3M+IDJF70za7VR/QdP9IsJDjY6TPuGJmMbQ/j2wyf91TuquI3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0lEzACMXczomIyL3tRpFFvKwpjBVBgVZHnjDBBrnWGRnwzepU
	GNrub9oe8Zcs2q6GPcwEcQNrx4DhX+/btllh+6RRIDrTtjtViPehTaDd4DzFzm68RJjhSdXiNOM
	DxLcbO0R+AxJw9ZJCkH1bPT1ZBUecI3cpbv6RhFQPsKPFDI/3DhiTt0Y=
X-Google-Smtp-Source: AGHT+IEmvwdk/IWR1IE9jKRTNexDguMVmLfjZ3Mzl//VCSLA5eIjz6/kjzGkRs4NOg0HaUH9YEKoELKu26Ww5mB8VnmBoXt3h7Pk
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2164:b0:3a7:7ded:5219 with SMTP id
 e9e14a558f8ab-3a7f9aa3b72mr13967695ab.21.1733195402426; Mon, 02 Dec 2024
 19:10:02 -0800 (PST)
Date: Mon, 02 Dec 2024 19:10:02 -0800
In-Reply-To: <PUZPR04MB63168009E64846094D5BE10B81362@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674e768a.050a0220.48a03.002b.GAE@google.com>
Subject: Re: [syzbot] [exfat?] general protection fault in exfat_init_ext_entry
From: syzbot <syzbot+6f6c9397e0078ef60bce@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6f6c9397e0078ef60bce@syzkaller.appspotmail.com
Tested-by: syzbot+6f6c9397e0078ef60bce@syzkaller.appspotmail.com

Tested on:

commit:         f486c8aa Add linux-next specific files for 20241128
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14eab0df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e348a4873516af92
dashboard link: https://syzkaller.appspot.com/bug?extid=6f6c9397e0078ef60bce
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17e30330580000

Note: testing is done by a robot and is best-effort only.

