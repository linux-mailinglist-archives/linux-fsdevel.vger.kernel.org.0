Return-Path: <linux-fsdevel+bounces-9060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B97183DA8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 14:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7932866EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 13:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32E81B80A;
	Fri, 26 Jan 2024 13:12:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA7B19470
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 13:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706274726; cv=none; b=HpzaA0q0cCmEITkcDMbd1lPMkWBloMitq4OiFl/pEe8bugvn5YfVwbhPL2RpH7d8JnccyFAYpwSGkb01UKrXqwk5anEBqKibsIInrat1hu8Ia1wfXerTIzWIOzwX7XfGNtiDlCvQyPm1QtvwpE6a8Mz5bAZfDPi6okRwIgsgI/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706274726; c=relaxed/simple;
	bh=NEzJ7pNKUuAaHWHT3ELgKK4hFQyY6cM6yjnMJL7fkNE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AsMaBB2NpJv57raAmY6LLmIhphA8gtK+LPui9EZkrCAqb6WTif4lAN1ruO7v8G92X0MZramMY31dj1Ye2Wa2cXyNNRbHYI1nmp4NiMquySP0h9soTaYxwItPxPzbp/HfHAFaNnC8fXJmgC4lhnwvn0fEa8YaWUcaxudaWwnuOXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b7f98e777cso18743739f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 05:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706274724; x=1706879524;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0x/ov2Zs03p8CkOaE9SqfLyn/5v8ep9jX8D61t7VpY=;
        b=F4OtctHEqG9LVNBqaDIkD70Mfdh3f2sstfVKmb0MS0G3TUVMfamVlZ/ycHvdi9tzDo
         sen1EctXTE1C+QCw5cghH+vod+sOeXxYyHlN/Ak8WY+IdwrHNAnwSA749Bkc/T8y2g2U
         9OzFuPk+bcf7BAK3WV/PMlR7u1PG/86810kGq6/DDgj2ExJ+Vr8rsZaUS2BQyM4jXek/
         xyAXdkcG3SbOOZZOL4zRSFZQ9IFpqvMzAk+9UnUAiUn4YSLdGkOqwcWlKQ5vZCeXqUZ6
         4x249u8LLABwauIuPuXZxyQ9f7b1Cw/ICO0rlDfMBB7c/XRtP18m7qRGGcC25PNA9VfZ
         Xi/g==
X-Gm-Message-State: AOJu0YzwAnfU0gr2Kf/eNwXlBlryko8k1ERDBK+pGRCCXrduYZFqp3Vl
	tozuFfrzbeAlyxiYVYHLmsAMIs7yOHomHNUHwXqw8Wu95zJ7dpI+tOcMCN0VPX5WZDZoc21o4EH
	quJhibHrRjCw4YeIZpwxp9CPlnMAsv1lOiEi/yr55Ato3iQ17GXHAZOY=
X-Google-Smtp-Source: AGHT+IHo7HCHW50KV8UXER7bHFe4guV2lkXOibpd+2Fe3a7VsPlzPa0SV3RLXftlVl7IBeDDB+jx/eCvFnMS3FQErE5eKkkrwzBd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1be5:b0:361:9a4c:8bf5 with SMTP id
 y5-20020a056e021be500b003619a4c8bf5mr173164ilv.6.1706274724126; Fri, 26 Jan
 2024 05:12:04 -0800 (PST)
Date: Fri, 26 Jan 2024 05:12:04 -0800
In-Reply-To: <000000000000f8389205e9f9ec5f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d227b6060fd90a48@google.com>
Subject: Re: [syzbot] [udf?] KASAN: use-after-free Read in crc_itu_t
From: syzbot <syzbot+d8fc21bfa138a5ae916d@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1204f1efe80000
start commit:   a4d7d7011219 Merge tag 'spi-fix-v6.4-rc5' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=d8fc21bfa138a5ae916d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1442e70b280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16db80dd280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

