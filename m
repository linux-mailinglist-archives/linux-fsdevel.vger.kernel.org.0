Return-Path: <linux-fsdevel+bounces-9195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CC283EBAE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 08:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4646FB223B9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 07:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F55E1D6B8;
	Sat, 27 Jan 2024 07:24:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C171D52B
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 07:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706340245; cv=none; b=L6zTzvu/3dHk4XLaWBgDIn5w2upIgFneIeKVMZMv0FGZ2zNOLpAVHaNsub6wsh6UGMDS/lWLQfq0UZE9VXT/jOUBK4Gvfv+GT5efHZW/yMo5RIzoBsXtlTxAgqF3w1Nl20+XImiR26j6NT6eWSz73s6BAyPoNR8m6dhsjmU3V0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706340245; c=relaxed/simple;
	bh=wSovenIOuHJFeKlZKpJSON7t0narEbg+6n/LNZ0WJ4w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AlYszL5fT0I7h+tj2BQh9aeIf6Oy1vWukBZseJkDYQITeZTQKXkhrMNQR3FZEe09XHRbqeGPiwKMM7LPKwlcABS+20CWTEWBNqSv6r3iCjR/el+nKgSzjooZpkUvGpM9GpEvNkCSZD95Ej1LjCzrTZE98hBdBheBs9io9Q1HT6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36287843c97so4651565ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 23:24:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706340243; x=1706945043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x33CAnHqweFUaC7rHW65DLAzcWfk1+dYs3PSYPATT48=;
        b=J6K7nTLBI/U6Q310rHYh+0yJlz6IYX0Bj63vFBLzju8w7v0DFt5ApBFpFwfSvpUYEB
         SxHh1p+wdBRqXt2gMfTsR4I06icFwBbo1JlWmUvgVz7/0bk66hOnWg26okplcGXSZ+rU
         DyZjh5zW8/vj29SEHR6yyVx1WseqphF9pe1nmYKGjUi5zUhFOi9t+Q30kaseTtTgrJcm
         tY0waKkSmjV+kC2c9L/EHEWGz1T7EycIpM8FtMCXR7IlPgOTDvN1MfPEF1uCSVoAdful
         gZkUnXd7+Rf94WPeIknmkcBIn9nomgHcSNQAFEki3uoy6uwcVlWqkQJQnb+60aabLuEE
         Nftw==
X-Gm-Message-State: AOJu0YwfqO5F4ZzhSc+kusHx3MzJV0Zq4g2lPvLflMQw0kvmpga3OO6K
	po2t3HaMAtkML3bMMF0UjTZFKhQAcAnoCQTG5kqIFG8U7ViXFMIEUBpoDxYgTwAY+4JQXEDVO+A
	QPzt46lnFEn4VdUDIfMGu1CTAIf5Q5nPZPY1G/cWRMpshktEuJVp0jjw=
X-Google-Smtp-Source: AGHT+IGoKsDNdMIuhe1DePTqDspd2yp6SqiXSG3moU7v72Ag3F794YWqo1gzd6ryjRiHDz/xIKd+/BhUygRtnSN59fWVVpdlpf51
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d95:b0:35f:535a:9c64 with SMTP id
 h21-20020a056e021d9500b0035f535a9c64mr122548ila.3.1706340243546; Fri, 26 Jan
 2024 23:24:03 -0800 (PST)
Date: Fri, 26 Jan 2024 23:24:03 -0800
In-Reply-To: <0000000000009947800605891611@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000152c13060fe84ca5@google.com>
Subject: Re: [syzbot] [hfs?] INFO: task hung in hfsplus_find_init
From: syzbot <syzbot+a0767f147b6b55daede8@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11dd6ea0180000
start commit:   a747acc0b752 Merge tag 'linux-kselftest-next-6.6-rc2' of g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=df91a3034fe3f122
dashboard link: https://syzkaller.appspot.com/bug?extid=a0767f147b6b55daede8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fb6508680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16473130680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

