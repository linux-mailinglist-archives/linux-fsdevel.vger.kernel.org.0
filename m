Return-Path: <linux-fsdevel+bounces-46977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07470A96F26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2274189C323
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082C428CF5C;
	Tue, 22 Apr 2025 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DrBbjy/B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF972853FA
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745333011; cv=none; b=ZLOQkLw18ZXiKY+x6t8LLHKV0gdyNTqpsk/lgSkZf0croFNIR/Dpz2ayerg3XxnctYKjmvT5+ZaDlks4piNo2HwUtMUKTGtBa8e6O2IelIpBerL/9HAWCHCUfmmfxKYhxI+QPJoMbCsjbgkBh6Bid/A48mDWN6sT6Y8L7mP/1uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745333011; c=relaxed/simple;
	bh=LJ81ySCYhjh27+riOuL7JsTqHpiQvvFaxk4COY0scGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQG5JU95QbGStFhBqIibddRvLKlj5apHbG7NnGTT7pKUfrCQaNja2Dvpo0KcZGh3FmcYRv/BD0ZKo1lE8cCXY+uC68aLVx+lgAqfpG4ZZtgIxe4KTprN22CFv2jbW+2TtKtNGc+8iECs25i3ytxdjIq+5a4eQrPY7mWF4+cz12o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DrBbjy/B; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-227914acd20so48983375ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 07:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745333009; x=1745937809; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6eckKDMmSuKFTzro6yB1ZcThs4CchkkZ6Dh7/jmsEGc=;
        b=DrBbjy/BSPlJJr/GfhMad5hH/NT/Sg4n8KjmJSvlXTAZLEZ86Zfq1Va96OMyBRtmEf
         hbkUvfMhCj8Ufv1M87yZxLi8ABJVPusq6CmociDWV2Dkbe2LgFAGD5f+ix92hlCXpNRs
         FlzPLChHm7SFA9x+upgh1rdIrpnWs/06DHoROBFE8tqOX1edrU1p7Cb5YqheyCEXqsGE
         YtOTmhrnRP+pnHm0K5A9xL8hvlbM0GYfK3a+jcNleCvz09hMYVkcp76Z7ch2ux+ehymq
         8sF/AjxbefKyPt5s3nDiqLSMJ/TUPP7A+rb5KC2Wfq2W2cmpOv/SMXz9VmEjo4GEsfWb
         QAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745333009; x=1745937809;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6eckKDMmSuKFTzro6yB1ZcThs4CchkkZ6Dh7/jmsEGc=;
        b=p1qB0poPLQ5ihShjbvNiMipragk01AH3VaQFIvFQSMV8qLQz5eHaoYcOFacLcQV8rS
         9xJgtpbD5/FtMAuPAZKXZEpN5R3FPhI0wr34I5oIfzXjgmXAV74fwa27SFyOxjNqL8d2
         M2ZPpTGcPxG6Asw4EIU0qetl/mWJqhYLwxGIqcfjFX7h46caU4ZkhVvMDWK1nEhCxe83
         f3k1oPa15XHv+egnjS40VJhaNTiaKe+j7FtcjRFkwq+eya01+4kGsonyTHRiEE/FLShx
         QcdgQqkSPoVfa47Woao+MeNdvWXrlpWWpiW5tb2TSYEbV88D9X+/uJOZcuNC/KBeLUE7
         2Wtw==
X-Forwarded-Encrypted: i=1; AJvYcCWzaKq4FV3JwsaUmW5kuVGQ9p9zoi7G4Fn++fh5QU+MNR4Pu1iWTcN39D7DKNQ1nlJAyEsT5Y6ljg6iHoi1@vger.kernel.org
X-Gm-Message-State: AOJu0YywCPFcDdY3ZFecCWH4oW9ROwOHlZttxXHaDYi/Qq35Dl6luc8X
	5PnmEe7KKxhKDeamkoApOtnC0mDcgsmkz7UBH8saczHMnWwN3SaHQRS/8P5AUVo33kB1gYArutW
	oWjddMOmxoOAbVcpKzuY+7+NHeqZIZJIuNEUV
X-Gm-Gg: ASbGncvE/RrWGG3idKY/7mSHsCls9TIeiIETuLwkWON6bMFbB1RgMdh5iPMEkcwSCb+
	w4l2VA5mml4kPN8IOvgMns1N3IyCfPEvctXm23bqb3EoDrMYv8EJTf1IMx2xQRCNxCrKtl3rZmG
	aAAeA3SHuI032lbsaKtqHbhzfl16q2oX8XTnBQJNvHwKF/kOqdxdIQ583mj4z5Wxo=
X-Google-Smtp-Source: AGHT+IEMBJHGqdBdhaSKOmXeGG1tXBALAWr21yAGW4a9jZMoK/NIGLNrkodjNR5e/EOkzdm1rmdlcQ4lveOWH29CAO4=
X-Received: by 2002:a17:902:db02:b0:21f:58fd:d215 with SMTP id
 d9443c01a7336-22c50cfaa36mr210689785ad.11.1745333009069; Tue, 22 Apr 2025
 07:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6807876f.050a0220.8500a.000f.GAE@google.com> <20250422-flogen-firmieren-105a92fbd796@brauner>
In-Reply-To: <20250422-flogen-firmieren-105a92fbd796@brauner>
From: Marco Elver <elver@google.com>
Date: Tue, 22 Apr 2025 16:42:52 +0200
X-Gm-Features: ATxdqUFIFyu6PcnxydXd-sfMerWWJ7SU96EUcuRo5wELlKkcu-wX78VIJvj3cZU
Message-ID: <CANpmjNPbVDaw8hzYRRe2_uZ45Dkc-rwqg9oUhoiMo2zg6D0XKw@mail.gmail.com>
Subject: Re: [syzbot] [fs?] KCSAN: data-race in choose_mountpoint_rcu / umount_tree
To: Christian Brauner <brauner@kernel.org>
Cc: syzbot <syzbot+81fdaf0f522d5c5e41fb@syzkaller.appspotmail.com>, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Apr 2025 at 15:43, 'Christian Brauner' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Tue, Apr 22, 2025 at 05:11:27AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    a33b5a08cbbd Merge tag 'sched_ext-for-6.15-rc3-fixes' of g..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1058f26f980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=85dd0f8b81b9d41f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=81fdaf0f522d5c5e41fb
> > compiler:       Debian clang version 15.0.6, Debian LLD 15.0.6
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/718e6f7bde0a/disk-a33b5a08.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/20f5e402fb15/vmlinux-a33b5a08.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/2dd06e277fc7/bzImage-a33b5a08.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+81fdaf0f522d5c5e41fb@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KCSAN: data-race in choose_mountpoint_rcu / umount_tree
>
> Benign, as this would be detected by the changed sequence count of
> @mount_lock. I hope we won't end up with endless reports about:w
> anything that we protect with a seqlock. That'll be very annoying.

Seqlocks are generally supported, but have caused headaches in the
past, esp. if the reader-side seqlock critical section does not follow
the typical do-seqbegin-while-retry pattern, or the critical section
is too large. If I read this right, the

  struct dentry *mountpoint = m->mnt_mountpoint;

is before the seqlock-reader beginning with "*seqp =
read_seqcount_begin(&mountpoint->d_seq);" ?

In fact, a lot of the special seqlock rules for KCSAN were conceived
due to irregular seqlock patterns in fs/ - I wouldn't be surprised
there still is the odd false positive here or there. There have also
been recent improvements to KCSAN's seqlock handling, but 6.15-rc*
should have those fixes already.

