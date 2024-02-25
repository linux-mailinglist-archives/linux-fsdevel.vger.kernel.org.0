Return-Path: <linux-fsdevel+bounces-12692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165468628CA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 03:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B652E2821D0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 02:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5BD6110;
	Sun, 25 Feb 2024 02:28:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B320E46AB
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 02:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708828084; cv=none; b=WakBJFUTv4yxs2nxnBNVLd4X8JEAJWCwfKmod6m6wq64TaGhk1TPXfS/8KY+sJ2K7TmauBPgUIChL+JDog8W7YZyzoaGWuI6mM/hjpzSIdPcCx6WXmPkyjhnoONR6TqzPVA04TgbuwcOtqasFaR5XkjRCImm/0mtc9C74BZWiIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708828084; c=relaxed/simple;
	bh=3aKaHbYMteihl+U5QPccjJuoz28iAXGcuSjcPWIAdYM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Nj+Bh764GbmDobW4sWLVIyuKyGT52qPNmasywGqWqbY47m2M/99GyPkRJ4JjoCHjtv+sJHhonRrwYO6+msDGV+/Zrl/7xSmIAgnkrRj2jnNmkYuqpIIdAZF3r4dq0AzgXXMNWioU6daEPi5ISUWeUz75f2fX8Ljzq3IF2QatPYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c7a2788749so115169839f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 18:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708828082; x=1709432882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=69jxe5/lbItSx/8NI9A2BEbecQ+1y4zcJUS034QABIU=;
        b=V2hnr1ZfPuEuzvWboxw0eGvzafC3rN5B2OqNSI+HKWdSnNtGGieMjO+mUW5bGVHPrG
         9NzSBtap6J8+xxuWDQ93793LeRjpV012qToTYqUsUrc9emGpQ9vO7C8IX9mRuw/0kwVX
         Mw0N7bjuK0ioulFwxdisZ6588RLHO3WDwgAqnK0wlMzeHbuqtSmV3RgP/y7j5Sh7APV9
         sieyuXm+vAljvelQIM3Qhfjn32vBDV6i2rrlwRXhZjQOtCseAwyK+2OghXnyOmLS00G+
         GM026ix0BSyQPGAGmAjd8jDlMCin13fHomLlotDNH2RwAgue9hwl1ZPChDekP+Bv0Xl2
         e5hA==
X-Forwarded-Encrypted: i=1; AJvYcCWjCraeOsUDyDMRO5WnamIbXmGsyyAaIGOi7j+lEJP8afE9qnzzuK1SlESEGdweJHY65IlWDIo/jXfMYsOO2qYffrFfAMbRB2BTjUiFxw==
X-Gm-Message-State: AOJu0YxQCFQKUKo8HeMrBrpGr7+F5hcM4/oQqn5YpGrpKIqRp37bU8AU
	SfmMcKISvXKhOqrSt+24uxSRlpCNHjkf3oNaAahqUyTm5OfVSqtA6PKAGBjNwgtb8e+DsWmRas9
	Ue3PIGhfFhbhJzeOS8ztG3WAp2/tcVRJKUuynHQOf1MqtlmHmM34mhaQ=
X-Google-Smtp-Source: AGHT+IEG8FPgH/7NK/GAXHzyqfV7repgm9p6T8Oh150j3NsDupdAxMqK6KEkh/wv/1TTMVWJk7WkKE5lfntNKFj4Rm9OXT9ei4b9
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160d:b0:365:df1:840d with SMTP id
 t13-20020a056e02160d00b003650df1840dmr239448ilu.4.1708828081920; Sat, 24 Feb
 2024 18:28:01 -0800 (PST)
Date: Sat, 24 Feb 2024 18:28:01 -0800
In-Reply-To: <00000000000071ce7305ee97ad81@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce24de06122b8a39@google.com>
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid context
 in __bread_gfp
From: syzbot <syzbot+5869fb71f59eac925756@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, hch@infradead.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=164a0a54180000
start commit:   a92b7d26c743 Merge tag 'drm-fixes-2023-06-23' of git://ano..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
dashboard link: https://syzkaller.appspot.com/bug?extid=5869fb71f59eac925756
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17fa78c7280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e73723280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

