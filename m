Return-Path: <linux-fsdevel+bounces-38372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695DDA010C7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 00:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2FF81625D6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 23:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9B81C3F3B;
	Fri,  3 Jan 2025 23:11:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A8A1BEF7F
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jan 2025 23:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735945899; cv=none; b=E0RJQ+6Y6xg+sz230a39tQeQxVzem8QGTFvhFS2WhDlxaMHddBolXUu8rGsTI4eJ3PGIlozrXRxIT7a3Jzmu1UXbEb9226yoCrHuoK7PMZfPHnvQeeZTh1EyR1WBQeiHe5HqcugOgnFLa6lFVr6Y4FQ7EQOwTabdi7NftJni+pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735945899; c=relaxed/simple;
	bh=jCqN1Wkyb/pLojOb6/3V8BZ+ft0za0KaNr4VwZwlbdY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ZR2jLseFoXfEZgcvfNFbk5q5KmsNOYL2LxnZJGxk7HjfeBSzqbTVRogs2q6xIzfKPT04Kvi36Xi5nmHMUsBlHkBOL0smshgf76CwtwKxgaFOv9vidCRydyk8xmYeNlwqnriCG9W7GH3iMG5SY+5K2PEHUi4OBMdegpqtx+FiF0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a9d57cff85so256358705ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jan 2025 15:11:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735945897; x=1736550697;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCqN1Wkyb/pLojOb6/3V8BZ+ft0za0KaNr4VwZwlbdY=;
        b=mRu2UHTNawIB48MOg+IdwbTXsaLZVq8Mvj4teXKty8YH+D20NLhFqwINb5ep41gUKw
         IKuusTjCwb1oDvq5RkYEE9FZ3bZnLwhfIEv74LuZRWvHRwED5DNbbxiwwXpQIx6STFuK
         UejhK6BmIpE0CkrLBG9TPZMTAZK4GWfo2DY0YUzug1Ybfs37uRz9BgAPql4DAtH9yUzY
         vGb5o2K2npATXh6qZU8u12jTq14x7axwulkSs0HtQgqoXin9IzYZQ6lG/ve5bmNBiAE4
         DAyv5oy4cMXTjzl3VOYBuqD/8qkMe/ArfyJKDUxI8kOEhGXMmafuMXNdmtFs9gQX/6XI
         z4tA==
X-Forwarded-Encrypted: i=1; AJvYcCU0X6TypQXmT2D6sKM/UfZX2ucoIEiLggaJjoT7B4hXmBFGtX8LDyY8u2PyP0BHmY2ESXEYZ4ZPwue44oVb@vger.kernel.org
X-Gm-Message-State: AOJu0YxWRUrz2QkF1sGD0VCZ92mSu8pCcKy0o5H5gOYy1b2Zf7J+gTQy
	PalkkcUxZVu2cjv7gMROhCa+y1PTo4CYd97TtgpyCFc91dAcQuY7IKJX8ckScnen6fvkC0ej+o3
	mlW9WOL4/U/ScFee+JR2JAoT5silRFHW1A9MvlKu13WEn4ExTC/SL65w=
X-Google-Smtp-Source: AGHT+IFOpzzcVtSGjl2YcYkUd+APZpWzYsM88yHA6me+VNzS69z0kbOmvzrDiPTyKkPMUAIru9KbbPA1Q8fXui3RpcE/mAiABlvs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54b:0:b0:3a9:e2f3:8dc4 with SMTP id
 e9e14a558f8ab-3c2d5928edcmr450473375ab.20.1735945897220; Fri, 03 Jan 2025
 15:11:37 -0800 (PST)
Date: Fri, 03 Jan 2025 15:11:37 -0800
In-Reply-To: <CAJnrk1aumuyz9J1ZWReB+diDXffRQFr1Et1UMoyyuBRf+s272g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67786ea9.050a0220.7f35c.0000.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_revert
From: syzbot <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com>
To: joannelkoong@gmail.com
Cc: dhowells@redhat.com, jlayton@kernel.org, joannelkoong@gmail.com, 
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, mszeredi@redhat.com, 
	netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Thu, Jan 2, 2025 at 12:19=E2=80=AFPM syzbot
> <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com> wrote:
>>
>> > #syz test git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.=
git
>>
>> want either no args or 2 args (repo, branch), got 1
>>
>> > 7a4f5418
>
> Sorry for the late reply on this Miklos, didn't realize this was
> related to my "convert direct io to use folios" change.
>
> I think Bernd's fix in 78f2560fc ("fuse: Set *nbytesp=3D0 in
> fuse_get_user_pages on allocation failure") should have fixed this?
>
> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git

want either no args or 2 args (repo, branch), got 1

> for-next

