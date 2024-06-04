Return-Path: <linux-fsdevel+bounces-20961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C29368FB6A5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 17:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC5E1F216D8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 15:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E6F143C6B;
	Tue,  4 Jun 2024 15:10:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDC613D50E
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513804; cv=none; b=FFH0FzMNx/K+lE0uq7iMCAx9L56qeUD8cx5EOkWARfWJYc90Hov2zYE0b3jmZrZFhdqB5hZiSb3UDMST7GiAVzaqdQdYg0nfEgFKsDuMVv13MIompsWuYIn0nXwcuAPLkNiFvi8uwbWiPg/hqgKPdUGWn2ge5tPex5qQHwG7eYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513804; c=relaxed/simple;
	bh=4TVIQNR/6Z1YPfoSmoDWBbA3PwRL01qZEuT1YwNgKmA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kRD/T5mXpeY34ey/330AVjt/F7eRcO11fLmwMya2RtEE+LzWFFWi9L/PqVNCynRZVaMztGHwCKklUUKd0dTi3vJFK5qJCYiubF4Z+5z5xP0cTIwACLUt7XE29+M5O1npWfrtWVamOeJSjnGWtUPjNFmeUfZysUHu/xOU7yrh27E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-374968174f8so30226695ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2024 08:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717513802; x=1718118602;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kkSWCLUC3Z5zZI+v8VL/vR1g1iAlgwx4yL/ydA03F9s=;
        b=YMKcS3iSYN+h534jMfgEOfwZ1qQ587jmMuUaHmWzCHcua0fyL/zAhEqUdiGSxlv1dW
         u7AvvJVHuycmWV/10+JrrBaakpWnI+yyFZyzURRvihmbDedK4WCakFNuQnVpFwuyF80N
         TL31se0pLdlfwjYBKXqOnuXakeFDycu65jOXiQZgCUk/VyRG2XvTylF67bggh4LjgfuZ
         7RAStu1lOahZ31lV2RI0kp0ntDkoTJySRl1fRLKwTVrGRatkoLf5NWe30/UfVOg23TFz
         ajQH83DiM83lQlhYIjROEFwhkcfJed80YrGg0M+/Y1U6bYYJ9/Hmh6PNnHPxUowA+t1B
         Ic3g==
X-Forwarded-Encrypted: i=1; AJvYcCW2JomIQ/uWOFDsJ7dCpKw/2ac1F/G4Pt582fJKFPlSwYJDii8yPtY9ay0q6wyv9fYDs6vvq5cvua4DrjGq+O9wK4cRZwxHM89vEfFmzA==
X-Gm-Message-State: AOJu0Ywz1cpIAOr/TI5pTZbtEY0hpMRcUuPXGlEw+lfCYcjfMGP0jwX3
	5nepuOW2hFGHmngz7PuOUTuUcIuiQqYRaZ+0vY4FYWF3S1uGoMEYP+Xe9tAQtezSuuQLOiNUr1I
	sRzaHsg64W1um7dEFWLSaITTu+NOpx7HCnJLGdJfJ4TVYeXvAPM1BBoY=
X-Google-Smtp-Source: AGHT+IE76CJ+LLRsvygb6B1IMZFAirzuRPp9Osu7vnH6Gg/0Ka8ZM9cU532pf4uWHpLGjHKlut+XzzpYCOiZVmQk5K76Vnz92ZG5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b27:b0:36d:d06c:5c10 with SMTP id
 e9e14a558f8ab-3748b9e5b86mr9243325ab.4.1717513802615; Tue, 04 Jun 2024
 08:10:02 -0700 (PDT)
Date: Tue, 04 Jun 2024 08:10:02 -0700
In-Reply-To: <a67e82fc-4658-4784-8d5b-e8a048e749e2@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a2419061a11d885@google.com>
Subject: Re: [syzbot] [f2fs?] kernel BUG in f2fs_evict_inode (2)
From: syzbot <syzbot+31e4659a3fe953aec2f4@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+31e4659a3fe953aec2f4@syzkaller.appspotmail.com

Tested on:

commit:         4d419837 f2fs: fix to don't dirty inode for readonly f..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git wip
console output: https://syzkaller.appspot.com/x/log.txt?x=17a597d6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eab577c7808ea52b
dashboard link: https://syzkaller.appspot.com/bug?extid=31e4659a3fe953aec2f4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

