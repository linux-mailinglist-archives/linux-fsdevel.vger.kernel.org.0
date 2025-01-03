Return-Path: <linux-fsdevel+bounces-38373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7CDA010E5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 00:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBBB0160EBA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 23:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8511C07F8;
	Fri,  3 Jan 2025 23:20:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1905C1B0F15
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jan 2025 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735946437; cv=none; b=Sn/UOk8bNV5p37VFiQQOyd3xTDS8IIljPVbwNU5bPjCE2tBIdQZMiBvAeAZGWjK9WYcFbEZtDn92VHdjCoA/9K9NOeTwmRV/JeuCbzWkh8lhL9D4JsSBWGVjVrgNPr14HGUETmM7wp6+peZxnYaefOmicLCOhg8JllhnLxjpMxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735946437; c=relaxed/simple;
	bh=3W4IvzMIr0xQBWC38MKeqTujA6CjHjjvg/i9qTVqI7E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=A4K2qgFMXoKqdCFSFxcN4lLRoZexsfK1hpEkb4y/PfY+UIx4uW+xSQDxZexzdBO5V4WC+jDgdRk6gosNv7Kezdce1b9BEjfUNSitAzH56xWKJj0gdUpkQtXuFwJOZk0dqgvmIiOmNr8gaDjbggegA3TrzZxOOevryS9BVggMrxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a9d303a5ccso254129085ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jan 2025 15:20:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735946435; x=1736551235;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3W4IvzMIr0xQBWC38MKeqTujA6CjHjjvg/i9qTVqI7E=;
        b=Ll4AHIXGYdtaJTEO8l+qCtLKHqhxAOoMfjJ8+5lLbee75tnRHhxP547BCE8XjtQDAj
         Nq368v2EzlwCGWXU9aI/r1kGaWh/B8mMYnHyHCE8h1ZZhdSjgSgi0frO6zNwAtuIdlEW
         7QZjKmJJTTKarsMQgo4oR15adwGAGyTf8RVs2jsHmCnepSGZugdkT37g/zAJ4Wsr/6YA
         9Qp4j9bkbQv1H0hmehZlcLp7o2qG/aFcwnzdFEJ2c797z9s/sC4y0rOa8N4n+k6NieUD
         5jtv3Gye9oSsBbwbkzhmYZX++Oftj/K9w0h92rikqbuc8Sz56Udr2500/2grAtN1igFM
         GS2A==
X-Forwarded-Encrypted: i=1; AJvYcCVzisM+HT9eB8kI1qtRig4Mi5ZrOZG4QKeztNAYZT6Tl3lDX1/U4yjyEO1IC471qmCDGtuwmVBE7hzppxa2@vger.kernel.org
X-Gm-Message-State: AOJu0YyPwUxSocA1IqpDZyOFqyu4OFhT0oLiRt2EhjlYycQdRJDfHXf1
	SOghP58S5RmkHZPu2b825HuNJFXqQflckJNAibXOWp6FTTBKwndVFVZBG1wUTjJbcNqB3MgoTtu
	9GA4lM3inAhRnhrdJAT/uOjxB6H6B5vbRMFi137f8tyFI1xEsdr4ohe8=
X-Google-Smtp-Source: AGHT+IEvWnW6oRM+vgCHfNwa24VSQVfBs3jfJK1qg6plgc5PIBRpIhZkcYU/J/vcoboVr9JogOoa1tw5Leo0QrhbzdZ7P2dDUsS+
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2481:b0:3a7:2204:c83e with SMTP id
 e9e14a558f8ab-3c2d2782867mr531960805ab.10.1735946435406; Fri, 03 Jan 2025
 15:20:35 -0800 (PST)
Date: Fri, 03 Jan 2025 15:20:35 -0800
In-Reply-To: <CAJnrk1bRY+KHdJ+yjOrb4ATHF2Xec=tUmPrn+nEPjRzNbUY7mQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677870c3.050a0220.2a3c1.001d.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_revert
From: syzbot <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com>
To: joannelkoong@gmail.com
Cc: dhowells@redhat.com, jlayton@kernel.org, joannelkoong@gmail.com, 
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, mszeredi@redhat.com, 
	netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Fri, Jan 3, 2025 at 3:11=E2=80=AFPM syzbot <
> syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com> wrote:
>>
>> > On Thu, Jan 2, 2025 at 12:19=E2=80=AFPM syzbot
>> > <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com> wrote:
>> >>
>> >> > #syz test git://
> git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
>> >>
>> >> want either no args or 2 args (repo, branch), got 1
>> >>
>> >> > 7a4f5418
>> >
>> > Sorry for the late reply on this Miklos, didn't realize this was
>> > related to my "convert direct io to use folios" change.
>> >
>> > I think Bernd's fix in 78f2560fc ("fuse: Set *nbytesp=3D0 in
>> > fuse_get_user_pages on allocation failure") should have fixed this?
>> >
>> > #syz test git://
> git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
>>
>> want either no args or 2 args (repo, branch), got 1
>>
>> > for-next
>
> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git

want either no args or 2 args (repo, branch), got 1

> for-next

