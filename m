Return-Path: <linux-fsdevel+bounces-10563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595A684C497
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 07:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1B91C24D60
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 06:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB2C1CD1F;
	Wed,  7 Feb 2024 06:02:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BAA1CD13
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 06:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707285727; cv=none; b=XhXOcz5AhMnzWK6HOsIsnl6PnegQ3Ul+e1DQeAw/zCSFzl1A7ExqPP6Qgc92tPkwaHuozOOTa5RVDIE0omsNTQTBxSYgm/05aEKhBTtjsYj/1TrcedqSyE28HX0YlSiMOS75LGZ5TM0Gj39cHxtP+CHNZpFNI8H+NHWMsUjJKYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707285727; c=relaxed/simple;
	bh=W19/zAXKBnDkLw1UIPDhY+WYdjbLhcPYZmVYQEr3zEU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H2Xfn9nXc4ENugTKGl/EuYa4gDzK/6x5lNXdi1VJhzWKUtVzRMsTMux5sb6ZcEajI2B8ww//OhAVD7dU5e3c1ZfW1VF8uqVa1qR6g9S8l3aivcKP6+Fs7EYLh0qk0WqAZYXkyRQzfwDdKM6/+j1XuvZUfOeTaqHmUxssY7j3r8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c018d53e7fso21671839f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 22:02:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707285725; x=1707890525;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZ1gCDcb+RtG3f11aogn1DQnpz/Zdh4uxrx+5jZ2eQg=;
        b=BpC91PP8qkY3IMRGrrFOTM+yGvVxYyw73FwlVndyXlXsuTUbbdSXQj/0MKi33bXgVQ
         T82P3b/x/qpaOusYibMZoHK0CjH+dpaBpqSAbpDhR+RkbaQyM1Ne3fdm+ed5UTnmls5s
         FK0IJK1zZHaU7HHUi8NKRNh7tyiU+OH7K3088v03vtbPdJtrOJXX+HPlm2CS7iHRtpiF
         9W0mabpoTEUoy39zvzHBs41043DrrZZF+XmjsV/VkZPtc3lYkFWpqRvZEy67yYJwRhD0
         zs+JQ89Qdk3mUXPKvRm6uV/DTTcdN/F6rkx9jlhu7iknUIemoJGVXPz95ewLo+kbyPtE
         qx1Q==
X-Gm-Message-State: AOJu0YxLh2rC3cZaOLEkqH4yw7MFqIp2Al/oAjqwLJk4k1Ku5zTLwhkd
	6V1IKQJF5dl7+igKmnoNDt13Jc8ecgCoPHs8W9+X9Vxt6QkU5JYd1Lz/u1rNl51KfYj7jCCt6Tv
	zfpnbEGIAflr48RfRYi1uQBlz+RoPsAGhSTt8GlP6xEh/hupAXisHLRE=
X-Google-Smtp-Source: AGHT+IGS3g4uJC9tM7VOBdG4+aYdZLltLW1qPFOR9ZIHza5GYhX73zd2xr+AUSSKHy0O0ytRUwYF3rbHoO1LHl1ONfWMu0QPh1GY
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1586:b0:7c2:cc50:c70b with SMTP id
 e6-20020a056602158600b007c2cc50c70bmr206826iow.1.1707285725505; Tue, 06 Feb
 2024 22:02:05 -0800 (PST)
Date: Tue, 06 Feb 2024 22:02:05 -0800
In-Reply-To: <0000000000001bebd305ee5cd30e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032f84a0610c46f89@google.com>
Subject: Re: [syzbot] [xfs?] WARNING in xfs_bmapi_convert_delalloc
From: syzbot <syzbot+53b443b5c64221ee8bad@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, chandan.babu@oracle.com, 
	dchinner@redhat.com, djwong@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b0ad7be80000
start commit:   e8c127b05766 Merge tag 'net-6.6-rc6' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=11e478e28144788c
dashboard link: https://syzkaller.appspot.com/bug?extid=53b443b5c64221ee8bad
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a6f291680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116bc355680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

