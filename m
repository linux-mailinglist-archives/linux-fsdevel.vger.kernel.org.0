Return-Path: <linux-fsdevel+bounces-13344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A5786EDF9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 02:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD07E2851BC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 01:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925B77483;
	Sat,  2 Mar 2024 01:51:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06816D39
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Mar 2024 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709344265; cv=none; b=mLkUVDvqu+rlkQvRD2QjLbgTSgnXIjUvdW4OGZjkXcMzf+XLZkCkp5ivvUyb+1AGWh1P+66RGynXCImYoPP59TjN0H19czA28LVTeHxyeqy5g7EhT6C1nqszcIX0n/EG8DuFpU7lE9RGJocQ7D79u3X22yXGX2xgvlLkuHk3PfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709344265; c=relaxed/simple;
	bh=j/JB2jyENDKPMzsPZBblzk98S3i8gV/N1pLSReCqPhY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y09nSqkQs3fzMXdljVLIdVsfbvPsYB2SSFmRqQoZKN+HrRD2eibphMvn2LPO9Zw6uwXkWMBEXDxKwO6mcruHGiygWdeBUeU5HlkVnbn29+L26A9r+NacibErS0Jwxszf+GkI6WxuXMKATwZL6PyZ6suZgcg9a1sfKD2BAXIXN6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c495649efdso360981239f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Mar 2024 17:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709344263; x=1709949063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LvJsx84GDRR3sGeQWUlw8maTlVsrsS8sB6uzDnbyywA=;
        b=CIG2a+onXe4ncv+hMBus2v/ZM7icKzKd/lX9Q3NTfHxfMo3EqD2KEmdsdrTmPY2ezs
         XCGLMBfbm4igCAzDdYoSmPi6H3zQyQCXkUx29pvqcLioYw1PoT6PXOiJv53egefe01iU
         Co/QM8KFqS+k5DKESC2X8c10ONedJXEwotF5usNIQ77Zm6IicrI6rtBurmqpEp93ISY/
         A87oaEzm27DckXRXXM6Gyhd4FcFFVgGJpk+RRaMGWbXicTjvH5+U4O8SsoPsmlRs5AiN
         pA2ohPSD96ocTIg/k9vHSO/qshuTYisWL0H/qzDlVgSLxkmlLK/Yd+P6MQGkd34IlnQv
         lvaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxrHI/mEp1pu5URJ3065lu4akgRrgr9KgDYxmqi2/DvZYqADqSua24F+WDQp1U2OasFGWCmNX6SkiUr55aDqPkC2SWm63Yxovp+yLy5w==
X-Gm-Message-State: AOJu0Yy7AB83CY2+4YZSnfYcZaMc25vfuK87tlGLIQlPfXHzH/Fc2Gr4
	+veNplUvrAXJ0Zs6Jk5ZRtynEGROQEr0xwRxcvo1EetrwxdOL6lrnr3TCfXzIGUMNVyHKOH0ZpB
	lar0k/nRUPeIVlJLamKCefqMospeATZ7CmCKMWj692oBtZqBHdDk6dKo=
X-Google-Smtp-Source: AGHT+IHuZLEai30Vbe4B0f25cUi3TWUjAJVlZiXgrG7JjlW0Eoir/37IyGI70zz2FHDwFteKbxHcLXnIYeVoRrWtAVl2bbv76tjQ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:629a:b0:474:8177:31c9 with SMTP id
 fh26-20020a056638629a00b00474817731c9mr111536jab.5.1709344263133; Fri, 01 Mar
 2024 17:51:03 -0800 (PST)
Date: Fri, 01 Mar 2024 17:51:03 -0800
In-Reply-To: <00000000000094d9bd05eb190572@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009a64380612a3b99e@google.com>
Subject: Re: [syzbot] [reiserfs?] kernel BUG in reiserfs_in_journal
From: syzbot <syzbot+79bf80830388272ba2f9@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	bvanassche@acm.org, jack@suse.cz, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, neilb@suse.de, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	willy@infradead.org, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e80bba180000
start commit:   611da07b89fd Merge tag 'acpi-6.6-rc8' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=174a257c5ae6b4fd
dashboard link: https://syzkaller.appspot.com/bug?extid=79bf80830388272ba2f9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ca8c63680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16dae351680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

