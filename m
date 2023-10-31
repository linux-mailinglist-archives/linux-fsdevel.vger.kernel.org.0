Return-Path: <linux-fsdevel+bounces-1665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FE77DD702
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 21:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024F01C20C7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 20:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88F7225AB;
	Tue, 31 Oct 2023 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70790224E2
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 20:22:05 +0000 (UTC)
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC70F5
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 13:22:04 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6ce28132979so203015a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 13:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698783723; x=1699388523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ABxS/Y/dEawUUeKH6gAmQ1oQDLcOIlAS+uqExwFT3Yw=;
        b=uorQcqvObXJ+NlZksWkwKByrCEJPBF6Jw0CWdNCg+4b970vclzrXWhwmsaaITIR5uj
         kTQy/1+0uGflmHTw6m3PUHiX3gz+JP81ogq6POmJNXqn1NkT8reOr8w3NbSGVHkAp7Xk
         kzh+WSPRrg28ThH/bQNChTpNeXtb73z3id33b9WK+drEXn5FEDWd6tJsrgTY76qw9VXN
         rhdlxjGhIbqOx47hnMGq9pjbaOxtTv7tpOjOMvepjy2AWQ6pX/krXq3rZJbpkUxQYRtH
         U0fWMjCBVoZKc9CZLYikB7zKbZxMgiWJt/7srEjVARA0ysuQN5vi4NVq8mGLDyfEurTQ
         xq8Q==
X-Gm-Message-State: AOJu0YyaWfRBgDz2UiP4jQLBxQKekt7zQEZUq2qMuewtB2b7t4NPRSWX
	BW6AF+y3P5Ifz2EQ7Frq0fYaC4/Gz5i5TWiGfC2X4ChxoLIO
X-Google-Smtp-Source: AGHT+IGb7b5+s5UWXuPaOfwbI5gjTxsrXeswNqM5+abNosVgXBYVP27oyqTOzSqlnYSpScnMXbpfJavMqzWhIqrVn1kjNJ71QDEp
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:150e:b0:3b2:e7b3:5fc5 with SMTP id
 u14-20020a056808150e00b003b2e7b35fc5mr1621301oiw.3.1698783723868; Tue, 31 Oct
 2023 13:22:03 -0700 (PDT)
Date: Tue, 31 Oct 2023 13:22:03 -0700
In-Reply-To: <00000000000019db4e05e9712237@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000695613060908e8ed@google.com>
Subject: Re: [syzbot] [ntfs3] kernel panic: stack is corrupted in lock_acquire (2)
From: syzbot <syzbot+db99576f362a5c1e9f7a@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 4ad5c924df6cd6d85708fa23f9d9a2b78a2e428e
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Sep 22 10:07:59 2023 +0000

    fs/ntfs3: Allow repeated call to ntfs3_put_sbi

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=125d173b680000
start commit:   45a3e24f65e9 Linux 6.4-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e74b395fe4978721
dashboard link: https://syzkaller.appspot.com/bug?extid=db99576f362a5c1e9f7a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1734eb5b280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ddb22f280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Allow repeated call to ntfs3_put_sbi

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

