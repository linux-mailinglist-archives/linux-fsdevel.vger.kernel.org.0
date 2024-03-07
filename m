Return-Path: <linux-fsdevel+bounces-13923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979AE8757F2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 21:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B021F24AAD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 20:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C23F13848C;
	Thu,  7 Mar 2024 20:09:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D131DA2F
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709842144; cv=none; b=JZMYXukGHclk7stqTPdLSCRLCeuiLRG18OBf++PQDNg0AKjSLbnQb/UeTsmtVEDpSbMMJk6BB/SCwpgTC53P+WqKr7xXyBaGxXlO8HUviiyZPsS3JTBr2Wd2+dFxn33gxC4NGpNrvAk84hP5t05vFTvmWr7mJhgTrXU/9rn0CIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709842144; c=relaxed/simple;
	bh=TSQ7AfrXLucKWQheLsgzlE+z8sjF6wEGYB6N+5YuKCA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QYgo8NTVHwHVamG0XSCHP9hlli3eHK5+rQ/sW2E3QAgvS/H4fdaDAV/3o/47UbBmlTP0GAixF2rLiO7d1tsR2KixGUMzLrCHjn9u215uwmnQ57KrcJ/jnIra6MQ5Gp0+IAkXwkW6qG8NpBaahOG+lLdXPCmIt7NHJJZXNtxLdOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c835b36ee2so12375639f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Mar 2024 12:09:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709842142; x=1710446942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPnadW8PWoeFYDGj+Rcds2yWxUTI+tugiFM477DcjnU=;
        b=o9mLKw4GA1SUkmNQK8FDppo8DcNb/un6YS5a8fjX7nphqLgABJ1t+z1ztfoN5pdwcN
         tXMINxYQRcfnrSExR4KxjNvmuRvoxyRESnMTB4j2LlWVsPmHWFKubKpZ+qipkUh5d+xU
         hAWAzfVelJ2Sgsr32z7uZfl7Wx1xW5gajfNZfYMMjY/9Mjq23+I7X6B69yjt/ucPlz8c
         z9SLFTVSe5ETDZiGgZPvI1IQm4YDgEbHYLOek6HRij7QUUOOY/DV4zRE5vZIehIjrvja
         AOY0aOIPNvzuA81EGHeDmXdnPd1IPEnRsNHYclhYrcdqxfetwzp7Oup0WHTRz1dTJbUi
         n+MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDrNwqRvrWtVr07biqE9YOHBSFphd8JdtLK7jYZDJ6DNAaPbUQLJbDC5vO8Kiq07FTHGaZb0XT33GaLOThkkm96sHzkrXNNkHyd58tHA==
X-Gm-Message-State: AOJu0Yy9IoopeNaEWPXjD5DYZilpBOJ9HnU891UBJAlg5JUznwfzIhRH
	l7wp0Wl3UlOt+J/1VNcz+WGbXIfHmA/ylVOWeMuCqOpHevgljqWLMm8MCj8Ui+zI0agwnvhRKer
	qvHLvfYyWlXscmDzKLHKN+XzK/uwWRaC2UWdLEIddChAkHdTvNUqCI8A=
X-Google-Smtp-Source: AGHT+IHf0A1bbJbf40iM9gk/Vn5lgktnauIGxNzkggiI77z84bps/c8Vlpz+R4jEIRrBIDzEioemWGSOafctG0M9EBFR/8AFCv2Q
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8e:0:b0:363:de50:f7b5 with SMTP id
 r14-20020a92cd8e000000b00363de50f7b5mr794885ilb.2.1709842141829; Thu, 07 Mar
 2024 12:09:01 -0800 (PST)
Date: Thu, 07 Mar 2024 12:09:01 -0800
In-Reply-To: <000000000000aa9b7405f261a574@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c7392061317a56f@google.com>
Subject: Re: [syzbot] [hfs?] INFO: task hung in hfs_mdb_commit
From: syzbot <syzbot+4fec87c399346da35903@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, kch@nvidia.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	martin.petersen@oracle.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=126c98ea180000
start commit:   7475e51b8796 Merge tag 'net-6.7-rc2' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d05dd66e2eb2c872
dashboard link: https://syzkaller.appspot.com/bug?extid=4fec87c399346da35903
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1286c3c0e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=121cc388e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

