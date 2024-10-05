Return-Path: <linux-fsdevel+bounces-31055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5731D991636
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 12:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0719D1F2306B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 10:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E1E142E6F;
	Sat,  5 Oct 2024 10:51:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818211E492
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728125463; cv=none; b=EYe/nJ+aSLMSYUU/BWAsFmWw9RXJ1hNCrrNNFxH1zZTnOs7JhSVidMEmp+9bF4XwNm2fdeOe6IDMP1BzF4WrB0IYvm7ppHN5Xum9RcQsTJydsltwI3UNf22mrr6AIo0LlhgrwUBWU+kgRPq8KumIap44rIJHmxz41IAXttJLQhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728125463; c=relaxed/simple;
	bh=NxyU9nUCsSgkON5O2lxEwFubpms7qTUo9JLUnCO7ii8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CRTQ2Q3TWPmqCkHk/IV8kxai5fmCXkPiGefoO+WGLShpt3CPvdltBM65HEpqTBllUhPUvq2R4crNXJfpjBVtq1veLS22OQP0LxFt0l1ryJAcc0s3uzM5/iFjRTjTei+yFQuJAxEUPxnIZhxZ4Fba9A2ko7j4B9p7tVeFBrzjsGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-832160abde4so327812939f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Oct 2024 03:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728125461; x=1728730261;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anhF7OilqNw/V1vwJD6fWlrrfYeQAh4r7ZAbYmfGYJc=;
        b=uG/yYVeW15yxdjj+rZo7NckmtPaL30OnNHJd53lmkgvVIHaL+aX1e5lu5eWJLkBYqO
         TbNwb1ZnMW+FLNPS2E5cFsqYum1fj5GeUdeTIpVYOA44aqLVIISZZjsIDUTJJ19SoS2S
         VeXFF+uJ5X3rywOmxcXU4LUX+vB3/dJJib/oJeTIO2KTxiMGwLDMRzZ3mtxGvLl+QaIs
         8ub/hhnlMCaS3c1rUgZzOaE2wO/Tta2hWmGUVh4VnUx195eNxr58ideTQiBYbZjzz55y
         jcrQv7ih/RGCib7LkiAsFNcHUw+sOBx07nnADHojnoeJK5lIdbof2SCvsLsw9CUGyAkk
         7nig==
X-Forwarded-Encrypted: i=1; AJvYcCXrHJiQwuNwZkzd/GpCjEcAxc87tCdN3/6VbAUj3o23WJ0BWWXaoanBC8r5XAbtPHgvMO8Kx0bVxWhq4NMe@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxz5DgJ6SvC5rx69EVlgqRC7LMHeT03owyPI8sj1adTbNE56Eu
	UHaagbUOr7ChIoA1IINUXWRc05vhxIwi06Mvz5ynCHwfWgzlxDz5QTmEZSk6WT/vDs9CI8Cq7CG
	loIQySV5Yvwva3e2x6lSTuR26Kr3QQQmswCS4IgFREXekBXYUwq6ahRc=
X-Google-Smtp-Source: AGHT+IEvijPTYF13ZC+76LQBGvEA4RUUT6MHwfmVXAKfc9yueA8V0SRkS1R1pPXSwhWZkKMfvDI9Dpz7hoeUCmXDZd8Of01pwfEX
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219d:b0:3a2:762b:faf0 with SMTP id
 e9e14a558f8ab-3a375ce0f15mr41351735ab.11.1728125461684; Sat, 05 Oct 2024
 03:51:01 -0700 (PDT)
Date: Sat, 05 Oct 2024 03:51:01 -0700
In-Reply-To: <6700d799.050a0220.49194.04b3.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67011a15.050a0220.49194.04bc.GAE@google.com>
Subject: Re: [syzbot] [hfs?] general protection fault in hfs_mdb_commit
From: syzbot <syzbot+5cfa9ffce7cc5744fe24@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sandeen@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit c87d1f1aa91c2e54234672c728e0e117d2bff756
Author: Eric Sandeen <sandeen@redhat.com>
Date:   Mon Sep 16 17:26:21 2024 +0000

    hfs: convert hfs to use the new mount api

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17b2bbd0580000
start commit:   c02d24a5af66 Add linux-next specific files for 20241003
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1472bbd0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1072bbd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94f9caf16c0af42d
dashboard link: https://syzkaller.appspot.com/bug?extid=5cfa9ffce7cc5744fe24
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114be307980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16bef527980000

Reported-by: syzbot+5cfa9ffce7cc5744fe24@syzkaller.appspotmail.com
Fixes: c87d1f1aa91c ("hfs: convert hfs to use the new mount api")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

