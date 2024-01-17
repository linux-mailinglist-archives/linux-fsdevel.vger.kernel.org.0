Return-Path: <linux-fsdevel+bounces-8131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597C782FE16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 01:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E753D28AE80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 00:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A27C4696;
	Wed, 17 Jan 2024 00:48:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D4A210A
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 00:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705452486; cv=none; b=PIKmCyalF7HjCJ5+feYeO3oQCHLHn66mSXMdQyIINEDB5IwfnGR9ZcSSTg8MVpjq+0jPL4TAvHyenqdw5QVtvR4dpngnmBCInOcsBvUFmyAFIwrn9uX4OlYu6VXvx23GfM4KOXPDfBihRyO9EKj2cM+glsc1Det8fhSQKfWzEfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705452486; c=relaxed/simple;
	bh=AAf/I4I42rLMBWEVS3mffH9UrtbgCWfulkA5r6p8F0g=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=U54UqjzBX/0O/apINEVFEcsYCiOM7gFrOlwTcEgO5lksU5BfnXmWi5QUq/ugI8ZuBNfCTmXBPjU2uZqeaGIJ0XVHIY2lX2qm+ju9LXYGyZRy0VjVcg0ODPYI9WIqK6nPt+AVmHtI/UcD0NDFkkeRTNxr08mjGWza6cFwigDSghg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-361917dccfbso7006775ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 16:48:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705452484; x=1706057284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TzIe28wbwr/i91YfIe1SnCMYHz0m9HJdrPMgOmh1W7s=;
        b=OIl8F1WMLlFt7twgfbQcI2DZFjqO9zgTsQVVgP/2YE12IHXVJwraGLMbHEVfmy5DhJ
         7XzdkSB03K933pHeDssOq6rdz2G4vs4CqRlCSd3TIJVxqK6vFmJ0k/RVuZmrx8Mz9AGE
         o7Qj6bonl3M3apq+7I3XXSQ5OdFnq8Rm/7otfYleIb0Yi1NPuV63n1jqsnBX5xAr1o3I
         AqAumNgq/P02YH9LJUpn7vDQUj6FolMk68sn0DLzJ+kz4ExlnqOmAnlq+wNgMpIeoyGc
         rlPcFmd2ro40nyHJnSJdMOxshxwDh3afuHDSjEu4OPMvSsv0VpBQoifAZ1k64yQyZa9P
         9Csw==
X-Gm-Message-State: AOJu0YxOZNWL8bgv0/zKjMRjznuxIP+ImyXwq0ktXFp8Fbiq23uV8B0T
	enPYbZJZjkfjWbHcctYE+jQ+BJ9N4Dd8K1jsHK6WRj+AV74t
X-Google-Smtp-Source: AGHT+IHZVgMumbYxDDuWNDkufYNSG2RSuuRZw5AZC5yXzVcZyTrEb3BR3h9XXdNCm2Cw3PsN4qPkDImjOvsVezYDvFpng64qP0vK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a07:b0:35f:db4b:69dd with SMTP id
 s7-20020a056e021a0700b0035fdb4b69ddmr837348ild.0.1705452484751; Tue, 16 Jan
 2024 16:48:04 -0800 (PST)
Date: Tue, 16 Jan 2024 16:48:04 -0800
In-Reply-To: <0000000000007caa3f06014cad2e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000088f73f060f1999fa@google.com>
Subject: Re: [syzbot] [gfs2?] BUG: sleeping function called from invalid
 context in gfs2_make_fs_ro
From: syzbot <syzbot+60369f4775c014dd1804@syzkaller.appspotmail.com>
To: agruenba@redhat.com, axboe@kernel.dk, brauner@kernel.org, 
	cluster-devel@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=126262dbe80000
start commit:   46670259519f Merge tag 'for-6.5-rc2-tag' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4507c291b5ab5d4
dashboard link: https://syzkaller.appspot.com/bug?extid=60369f4775c014dd1804
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1602904ea80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d67e9ea80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

