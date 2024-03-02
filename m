Return-Path: <linux-fsdevel+bounces-13348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F01886EE7B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 05:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84E2DB24608
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 04:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7A610A3A;
	Sat,  2 Mar 2024 04:13:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD58410A0A
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Mar 2024 04:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709352786; cv=none; b=fsUe02+ORMgP2F23khMzsyJWbET55xeT3kklHYmw/d7HbfmInX5Ukyt4Goq9YDzurwW32E4WsMaueRHddkOuduWG13UMqrthj6nOGCUx++mCCWZG8SXzWu4wT3svsy3FYviGbMjw3LcxIYKfcvTLyvyyTFOmmkU32k9c2XfH6kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709352786; c=relaxed/simple;
	bh=xXL3eGNtx4fKbLGwUddCJ6Z89zxBZxOIhwZ1upx7U7o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZMhwv6iHl1v9ictgA9QSxDsZ/ppaR3sWb85m8q5T9C3MwnxTz15sxiHDrHywz0WnTYazL8VscpEaM8+xAcVQj/RgwDCpeW3hvd5wwkSYwag5pQ+BtYpWYgCrCUA11sOWGi+IetEf31WlkPNq5/fwh6nu8PQbpTB/glRaVsKvuMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c7e888dbf2so293854939f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Mar 2024 20:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709352784; x=1709957584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IdmhwINwWJtxlnecMtQfHBtNVjXurznaLwVzNHPbLS8=;
        b=wbgc9fp1sbfagwX5UBp5hoM1LtvViepqBR2j2WsuG/HPzAdYkgiN4F4KhwOztZBSyg
         esW1Z8oa9iBJ+Pmw5zm6QQMe6JM33eG5BEkX5LqSOLt02M2+aRCVwi/BhugWaJmggebT
         p3ZtSFgZ7ICt+cbUJTVCYKWlL4CqZilzm1rSXQFgnfkiBSbPx226eODq5Fn3o77pFiqT
         t/j9ELdaa4WMVJlk12cNfbaKvG7sGy8/8Tires7YAMY1RC2j8cm1SbcH5bL753Hsew12
         VlJVZ/RpoAKcfLMe9Ok7M7C6kZ7+7E62plEnu9kMsBGdmmTIx6V6zEAdxkiR7/YosB4a
         TzWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyZfRO+qZ5dRHICBHBIujcFcnCwqGHgxBuJuL7oXs+J2JwRTZ7gt1LPv/Ww6vtJRbVCNXm9/PqgcY+NyVgT6seUoxoV/cGBeTAjJPsSw==
X-Gm-Message-State: AOJu0YyL3r/2e/AiI1MS2TurwCr5m9FvSkXOXOoIuR+hdC0ol2UsIDJV
	chilgSVn0+IUwpbLEBmDpyhbuM4bLFwzsGGin/mWX+IEkYwtkZri4OAsm9pXnY3WiX4fFQuF/bq
	6z0FiIR7UwoXEJGls/XMh+my3zqrUmkrZ7Fg284mEoRwTwWbCZJ5VCTw=
X-Google-Smtp-Source: AGHT+IFeNymewDoQQ2b72fsvKz5+EwmHM6NPkihOCvhrd4QX5nncJm2ScXvMMyOAUFsw2cegVJkFRege49tbor9AsksLq7WQhdRg
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:411c:b0:474:d1b9:10d9 with SMTP id
 ay28-20020a056638411c00b00474d1b910d9mr140269jab.2.1709352784115; Fri, 01 Mar
 2024 20:13:04 -0800 (PST)
Date: Fri, 01 Mar 2024 20:13:04 -0800
In-Reply-To: <0000000000009a7f2105ff02d381@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e3d4a0612a5b5a7@google.com>
Subject: Re: [syzbot] [reiserfs?] [mm?] general protection fault in
 unlink_file_vma (2)
From: syzbot <syzbot+7fbdbd17a5bd6d01bc65@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	jack@suse.cz, linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	reiserfs-devel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d80bba180000
start commit:   547cc9be86f4 Merge tag 'perf_urgent_for_v6.4' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
dashboard link: https://syzkaller.appspot.com/bug?extid=7fbdbd17a5bd6d01bc65
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a58757280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134a0f1f280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

