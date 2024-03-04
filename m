Return-Path: <linux-fsdevel+bounces-13556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 464B8870C9D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 22:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0222628613D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 21:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FCF7BAE2;
	Mon,  4 Mar 2024 21:27:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316DB7B3F9
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587624; cv=none; b=lAOq2nMcHVWFff+vY2sCXzbtlQPv2Mjd2MpWD+0SmlV/Gr9vmR3ROz+TpWh8ur/5jGJFEa6KwsdwAYo+Xapu/0SESmlfh3h5zeKJqIx3eOCnJhqj0npW1C4y4636/Sy8X+V0zadz1ch2Jcb9CTwigouWkuV5C/y/JYdsW/u2fkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587624; c=relaxed/simple;
	bh=7OIRGJZUwt4n9PdtYeKoGZSG9ijxy+x04qpKy/W6QxI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sSInRZtmMZHgPaGes0BxHdF/YYoICcJfpFBOHqJsFztd1FXcKE5nRiR/6VdI9Vpx6T8of3auL1YXyfnIuPBGdUAFA7YBjcZaFbETYskBJkPipwj2pVJdx18TFpWuCW7oKtBk6vV6RN/qlJH2ATt50QfCBL38TTICA/83YFSnPGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c7857e6cb8so678120639f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 13:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709587622; x=1710192422;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ieJ7vArxQ23QAB9KZQ2E29yL0CVdR5bt1wIM+GBalqk=;
        b=XfxZgCp2WvCKgi+aPq0R1kbiXwMziO74tZmwO7lM1DIs82aE9LRzyEBcdhYUUVg3Is
         83vR1Gr+oC4krG7rDfLq510JNqgar6HztRRqwrXin5MxsBAcMfw1dMqfR1DBztgLO4rH
         tyzlwxTAOsgISeVFWooEDp6StWESkpyK52qrt3GbD5r3mOTpFQcql91i6GhjGcsNeCbo
         xC9Ve7I4hEboRIQ0Qh14n8atPmitHabOmqgWICEB12Tv8WAMBmP0Wcs/i8pSA+c+xAwe
         fw3ZWIfv68e6sNE9bc/FspLabITCZpZwQtGX2Au1vYmifhzB90L6FzfQSNfomfxGJ8pz
         /beA==
X-Forwarded-Encrypted: i=1; AJvYcCVO1dKxzFnNOPvL12RPYbBzdRkWyTm1IGH9ltNkargtnwtyqLJavlrQZ0S7v/RK2PbyhdM4mbbVrNtN4TsrwFqVzmxxyZwJsZAphpWoVA==
X-Gm-Message-State: AOJu0YwZ3jNoOdDYW+pWZk5HKa6L1AoO7uEQrPiWVBiVQj1Umi0ZlJci
	h8q4Dhs6ysTh39LYiZ7d+N04I9D5Xa3FHaCrgv3WaDA2VEn76c10uN6OYlBiz2DLNqwrLY1dr7s
	CcZ6RXFeY9FMhfe5o5lr5ZvI4GwC3yRPGZ8ctIg6d9WNuGvlWnuFz3PA=
X-Google-Smtp-Source: AGHT+IGAT78R2FREye2VSHhSfsYgwamzc4aqFcA1RseDZztivUY+ue7QdldxXl8TLQ4eDahQCC0D/+koCyYRLRemElzpP/fMAgiT
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4114:b0:474:f9e1:6d6f with SMTP id
 ay20-20020a056638411400b00474f9e16d6fmr145821jab.1.1709587622420; Mon, 04 Mar
 2024 13:27:02 -0800 (PST)
Date: Mon, 04 Mar 2024 13:27:02 -0800
In-Reply-To: <00000000000084090905fe7d22bb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f279ea0612dc62cd@google.com>
Subject: Re: [syzbot] [udf?] KASAN: use-after-free Read in udf_finalize_lvid
From: syzbot <syzbot+46073c22edd7f242c028@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1495d341180000
start commit:   861deac3b092 Linux 6.7-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e118a9228c45d7
dashboard link: https://syzkaller.appspot.com/bug?extid=46073c22edd7f242c028
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a44d79e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130b99e9e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

