Return-Path: <linux-fsdevel+bounces-31954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ED099E300
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 11:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D433E1F23047
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 09:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD131E3790;
	Tue, 15 Oct 2024 09:45:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB21C1E2009
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728985506; cv=none; b=hbl9s2ZWzkvZuEvuiE8376lx/iWuQ+HafPxjDAgsV5fWzU/UWqP9lAjJnF7cE+5b/A1B1QaQDXLFW/Mk/5eIoWzkHP86QX6/ZPaWB4wkwAu5ciCSdCP4lxsKPhBMqPBVX/Jjydv24BBbajWY/K9Uy5EtWN65m8tPLbtx1UI9va4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728985506; c=relaxed/simple;
	bh=s3RUsSYf6HEGJZkKbpAcZcDrWM8Q7dEpXU/OWdX0u40=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bkZSwUJXc0ocQPQaMa2tXffvGiq4XqUE/d6UHAM2EOYrpcK3sRdiiGUA1rqImotJeARgf0Xr5FqBQU7FtFUYUtGmf1DAHoM3LaLxbQJ/BUICJBKkFeoMzi4SzJJ4upztb4rCG1aFGbmc8x679btoEC6O1xryKSIVm+R0mgpp2Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b483e30bso46211605ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 02:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728985503; x=1729590303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xALKlN2ovO2mb0V6amAaOMXvrsoZMqemd7QT5SbNimY=;
        b=rN0SQRMVHU8XdFAja/Q4RUmjXdSKv7cVQEMKjryDZLoVqhin8C1q7EcmYDxsrls6+J
         Owml3zuWdr3XRMLKya8kdO9ndCVRruN7cbk/9Qi32fbF5N/Ylcj7dESEXLrqReCiBimP
         WoV40fX02aZRYUDGMluI/NYdrYaGxBMQU9d/n2xNuwccqmfXrpcvV1lyftZ7xj6XyGU3
         K/j7vTF1Dr39vBlUr/DqshooUZxHxRG/vPnHbfsPQjBix2HXTIT8BsEvD9Ll95xHr2RY
         u2oVCYxpDl/7DWskKUp/78cXb6z0lNCAGN+chh96pXDobLAoBUrUCrJxsUssJJGIJNOn
         4JYA==
X-Forwarded-Encrypted: i=1; AJvYcCXKHnO0ci/SWt1bda7WFvBWmjiAOMrz3ai+L60i7xgwwAAtHAATcNQedRdIyhaV0o2dXkastVUOePrNbqA7@vger.kernel.org
X-Gm-Message-State: AOJu0YwQsTlM4PKm5xAhtIX6ogIx/vjue2ZNI//Adp7cewzPIog78QfD
	2+aQeGyOC3t2W3AlfWXqkIm6kXLr9jjUSLNfebsHO8qEayWu59YIkUeO7HujtEz3dk5eJAq2stD
	sIQSIXsR7odnWfePore/vcwJ8R6JTM5ZnSu4GPim4gi9v8IfBmGVI9wE=
X-Google-Smtp-Source: AGHT+IEhKRVrCZkAhlCW00Rik13sgAiQvqwQSq4s1KNDJWGREPyu0ky6iqCVETttYYF6Aglj4mTYpFWWQDkjO1p1NO5LjUWf7NMW
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cf:b0:3a0:b471:9651 with SMTP id
 e9e14a558f8ab-3a3b60558cbmr110829015ab.24.1728985502985; Tue, 15 Oct 2024
 02:45:02 -0700 (PDT)
Date: Tue, 15 Oct 2024 02:45:02 -0700
In-Reply-To: <d38ebf68-46c7-443a-8771-3dbd835a17fd@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670e399e.050a0220.d9b66.014e.GAE@google.com>
Subject: Re: [syzbot] [iomap?] WARNING in iomap_iter (3)
From: syzbot <syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com
Tested-by: syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com

Tested on:

commit:         7f773fd6 Add linux-next specific files for 20241014
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git next-20241014
console output: https://syzkaller.appspot.com/x/log.txt?x=138ad727980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d6083ad781cbf8
dashboard link: https://syzkaller.appspot.com/bug?extid=74cc7d98ae5484c2744d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

