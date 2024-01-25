Return-Path: <linux-fsdevel+bounces-8917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D03F83C17D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 12:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A214B1F261DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D8345C1C;
	Thu, 25 Jan 2024 11:59:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112D332182
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706183946; cv=none; b=rcz0w21dx0UbbUlq/40kKXbJ8uhJDKm/58kI7gJKH3PMfwdSAnFX5NnOz3MMmlpB0pdVZUGlZFPCjiE2IFG/fF8t426m354Om3oJJVzjFoyKUzLpFneDUgqcoJ6YRDzeiXew5TzXDOOn3jBwxVGc8yJ+EVRYpEwZcRxr9/oARME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706183946; c=relaxed/simple;
	bh=5IeaVdhF5LtzIsAPk6LztQlW/FDS4ghLmFVK+1cJZBA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DfRK8cT4MfomjnVO9UeblNOM2lyI34QWYt0iyDozriAiAMn3eY9uNFakfkJ2Czh7r8+Fc2i1kIpOnnNr+Ubxe8pHfiCa9ICethYYTiH9LVNx9HH2FhLj9RUoICroep9G+BQrXNCipCzHUpRcpyO5ggE+bqx90U/tFhuMAc/0s3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7b7f98e777cso632886639f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 03:59:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706183944; x=1706788744;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/iub3MHAFwcdo/Gqv4i8H6fRbSsG4isv2FzsUCWJ2Q=;
        b=DIdDasBpT+N5FS4BWyZoD5fqSOUuj3o5+A+A2nsYvRIypCgqdo14j44rQqoRZxVHAs
         QbevleWO4fLZmGLmaqy4HHLh+axQbc31C2sIFJ6jgKcIu4QD5UCA5jGrGoGQDOq9ATQA
         7MpJRmEB8j5fgkIWwQnbfGG7ObRbkmNJO4NaADxbjNZtAlHgHmhOd7iFTQSuOxTHGXzi
         r7O6KhYRW7Kellr/pSbPcbv50r0RejYrgpJ0AKn65nVjjZKUqYZ8yFEop3ppcvVlsdyx
         Nj72uyq26T9I2itSmczksZ9ieqJ+Wyn+bceQXqamcRsv1Ug0BWHmDwHEnZ+4c4wXmtQs
         GmxQ==
X-Gm-Message-State: AOJu0Yx2cgNV/vORZT/hQ8M3is5zwtQCztw57WbmF7FA3IPlOhrb7GeW
	TrYzBlEuOwKlvpaGmOWaLgr6pax8xPeQ+u9ehIz90CeUAXmwhD8kJ4F7mVmrzaN4PPKBLi/yPyn
	ron4BlLDY36bTZGf2PCNF2IJEjqR64/n/iK1fbm8TFoYL9d7ZfGYn/zc=
X-Google-Smtp-Source: AGHT+IHyn2Qwd5HMJ7IxpvO0WYV/RjdhuSh6ltkRkTWpD1C389xewU6uddZnAn6Y8UCvfgydKDiM2O+RIWXKLEy9yto1g0WIYVHI
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1921:b0:46e:d83d:472f with SMTP id
 p33-20020a056638192100b0046ed83d472fmr57559jal.0.1706183943905; Thu, 25 Jan
 2024 03:59:03 -0800 (PST)
Date: Thu, 25 Jan 2024 03:59:03 -0800
In-Reply-To: <00000000000083513f060340d472@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e5e71a060fc3e747@google.com>
Subject: Re: [syzbot] [jfs?] INFO: task hung in path_mount (2)
From: syzbot <syzbot+fb337a5ea8454f5f1e3f@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, hdanton@sina.com, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13175a53e80000
start commit:   2ccdd1b13c59 Linux 6.5-rc6
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c37cc0e4fcc5f8d
dashboard link: https://syzkaller.appspot.com/bug?extid=fb337a5ea8454f5f1e3f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ba5d53a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14265373a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

