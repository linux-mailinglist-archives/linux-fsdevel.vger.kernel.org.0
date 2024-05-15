Return-Path: <linux-fsdevel+bounces-19553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379AD8C6C11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 20:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E3F284B3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 18:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D111A158DCF;
	Wed, 15 May 2024 18:19:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1B9158DB7
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 May 2024 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715797146; cv=none; b=qLAYYbsIOhgyIaabbbjeDdqiEnPSDmZU1KCL6MDjzJWFQItXJpt9EWdTPERIcEaf5LqDoPV/BV36TsFUg6lbBRsAdjcWDBCqPc1upQ3LijSgNbPBK8uv57c80oCTzy9LTb5VEX5ffAy77E/AArNMIKe4BWMLgmMdNKf7Ky+Vgq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715797146; c=relaxed/simple;
	bh=5eudQLXKDiRsYY49Oc+zW6UDq5YXoyySbCrA4nZlq9w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nZj/8bgpsSRbyWRL5bAmLxYRlm7g6WSMataNZNQhOqrQH9+1huCX7Zq2eoq3/CKvp2v8BHsRoFcExL7UrybQLsMWqGK4YpKKXZM8z++IuGz2GH3G+H7b+EfCqfGLfeADg9RoS8Qc6MmnCMFFzhJyXd5JTWR/f/CT4jJwH087r0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e1d1c7229aso517518039f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 May 2024 11:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715797144; x=1716401944;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+tpDgK2JCqXeT0yDQHOxK3Y5nf0WqVOLoMtiI3Y/bw=;
        b=HJbO8gEx+lgF875KKkH1EplQu7mBzAXoVrO9JgkF0e/fwitCB4tDyXSjBgIHuKbydj
         d7JI3ipoTrJzSzTbpIiwUli1ZtfL/AyvmekvRgLxxd75YIYTSrYo62mlhcFxV12OlYYb
         xlJYftKEX7H5YXCz9uTWknlAauybRzrHk6DD1UYrR/6zpe6vqrWY+ig7hyMh/NAD/R77
         R6vShSy3w6Riua9iRvLv13omPFzvS4yGRhggjQkmcEHbPTmOIrHj1fhv2sLKIYkeS9Hc
         Y0idRttZCIFBq08vZSrmf0KQ2Ol10vh7mcWE9Ax5D9H9pSSrlRT6NiyWk49fbIxMhXyv
         1vWw==
X-Forwarded-Encrypted: i=1; AJvYcCUDxrxoipXd15qD4u+cs3tGEEZUWZXFe95TzmBRVRpqvBcU9Mny2xF+6PPExTYKJUQueBckb5nU/8QFGQXbpkjM0x3c06UeRuJ8mYzNNg==
X-Gm-Message-State: AOJu0YyppVJjUu1jD7rpsGP74wv1tFc8SE3zs4vcQkNLmNrX7Pwqx911
	ZgcZ1uw4LeW7deySjg3VCBvCu+nljdX6M7VC6lRZ0hLSJO28KcZ/e4iGJ6Bee/I7MAszPAN1wEV
	yE4pprcSlZc54bCB20ggU8yP2rYo+KilxdXhfCc/YYxT9bSccE5KwnKY=
X-Google-Smtp-Source: AGHT+IEjNm55R8nOlSIvYdtT/+wPoKVbHS4MXBNSquAdO95DQ/qV9dYHkp5IQ0ROpBGxD/p/1FKq4FdnI5XNMO2HYBR0ez1OuwCN
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:861e:b0:488:59cc:eb4e with SMTP id
 8926c6da1cb9f-4895854473cmr1136597173.1.1715797144326; Wed, 15 May 2024
 11:19:04 -0700 (PDT)
Date: Wed, 15 May 2024 11:19:04 -0700
In-Reply-To: <000000000000c4b45a056a36872f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b67120618822707@google.com>
Subject: Re: [syzbot] [ntfs3?] kernel BUG at fs/ntfs/aops.c:LINE!
From: syzbot <syzbot+6a5a7672f663cce8b156@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, anton@tuxera.com, 
	axboe@kernel.dk, brauner@kernel.org, cgel.zte@gmail.com, 
	dai.shixin@zte.com.cn, ebiggers@kernel.org, gregkh@linuxfoundation.org, 
	jack@suse.cz, jiang.xuexin@zte.com.cn, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-ntfs-dev@lists.sourceforge.net, lu.zhongjun@zte.com.cn, 
	ntfs3@lists.linux.dev, ran.maosheng1@zte.com.cn, ran.xiaokai@zte.com.cn, 
	stable@vger.kernel.org, syzkaller-bugs@googlegroups.com, xu.xin16@zte.com.cn, 
	yang.tao172@zte.com.cn, yang.yang29@zte.com.cn, zealci@zte.com.cn, 
	zhang.songyi@zte.com.cn, zhang.wenya1@zte.com.cn, zhang.yanan14@zte.com.cn
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=134d0268980000
start commit:   ceb6a6f023fd Linux 6.7-rc6
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5751b3a2226135d
dashboard link: https://syzkaller.appspot.com/bug?extid=6a5a7672f663cce8b156
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172458d6e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120d8026e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

