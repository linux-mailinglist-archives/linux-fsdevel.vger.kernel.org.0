Return-Path: <linux-fsdevel+bounces-14205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC90687945D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 13:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838941F21710
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 12:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685EA7A70A;
	Tue, 12 Mar 2024 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAXGBpl7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1A67A129;
	Tue, 12 Mar 2024 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710247451; cv=none; b=l3gIgOxqTWnFUQgFbAiVWS4LbMiyML6cj+CVmYmkx8Hw0vd8GRYtFv8d6t4OT4g4SHMGQXX4nyavQE7Gk/We/+osgo3jiWGHucEYwNRVjPWrro3M3WU/McpYP2hH83faMeRrrxDrbWQeGV7x9MekGAtQYonymO4FFE2JpLT2ruo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710247451; c=relaxed/simple;
	bh=MH+RmzJqqEIBVXo90i5vM3YiEiBivhNjk5yTuw80LFM=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhenkFMf4W/DE4Zb7gnSt/vD5zTaSw7Pms/O8Zg8100BbaHCbEsY6uKzZ7djsdMQom1Qhfb3pEbLIl/kasYpxItZpeEINKJ3P7y9m/4Flp83GaU1c6++CRvrUgU0q3w5KpRXBmxjoI8TFmmmDrKPEO1g84dfJ7iTz/ehfPuROe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAXGBpl7; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56878bb1abdso581282a12.1;
        Tue, 12 Mar 2024 05:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710247448; x=1710852248; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qGx1SAuuMtMPbkqKhMFRhqHlJUlfDVpupNqFcCtt0Xg=;
        b=PAXGBpl76vljvMi2/KF0IHpEP3ILdweubEVcnRoOKKHh4+jCN9m9ZGlWGiEQv1XmYj
         lGh3qpyqiH4L96OxPaJk8inQrFDD6WpKL+m1wcQNqKR/JCU9OwPimccBqddoAr7aCAaJ
         xAyUZv4VXDFiY1iftZeTiaZD0YV4d/2jqF1Jpykf0JvpGFIGdo8LdRiqyOtguqryuN5s
         hnWoLB7hiI0wzNnxOrMU1RQ7fiOBZfms44dshR5xeWQ0vLXNjkUM0LiC2VtBeN1WxtGm
         8wpT9zgbXKyHr8uhA1FZGa/SqVeL0zlOEvSde2b0TDLwPA5/v9UyXp3i1BTTLf7xXuw+
         U9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710247448; x=1710852248;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGx1SAuuMtMPbkqKhMFRhqHlJUlfDVpupNqFcCtt0Xg=;
        b=TQxsO8iDadYovIH5B68mH3ekEcGljU/GEfnh6Azd3g6zCIg/8Eoy5q5dOTqXDJ8CNX
         vjM5jS+F3l4VxkTvOrAEsiEEUHL6t+VlUD9ZKugeI06kiNGoLCsSGy6rl3DU6O0S905p
         jJ0JRdTQTw6zY3DNJqU882k95n0+yvDyvP8+7GPKCxjFhw6YiMPGm5kc3uklhMBAt1ZS
         9j9t79+B2bSsFoM6plEvsujkYKwnphUasEFFz12gjdMMQmAu/g8ehwvHcwiNMOr/eA9c
         i/5gDVE2nr83jicFajaSTdsdwPc6av5DznBpSDz/gG53f45W6dzW1ABpA+6oh42/wunl
         FjkA==
X-Forwarded-Encrypted: i=1; AJvYcCVYQwV6EP2H6iaM3jJ+FzwiElzVw8JUYyIWfUNyoqtqLpn8TpE1+HUPq/1NZFvsmi938CM+40BzWMzH5ZJDLyuUjFpzn0LUdwfxT0hrA5lTDzKXhk3MPA7jb/nhlVS1h6mo9qqDfUsV2G2Gow==
X-Gm-Message-State: AOJu0Yz3xlOsE91/iDcj2q16MgKoB8bMYmAMYIOS3EA5CPQV/C5qD2Bd
	cnUI8RpdFzzz9CdoIGe1glysIGq3nHfU74nk2BquwwUauHvKIQDJw+68R7W+LYQuAT82bVJURcH
	rivTlup7ZayRQ+RbCgg2TF6pl818=
X-Google-Smtp-Source: AGHT+IHf5Mmnm9eokPIC+RAuWPaLLdKydE4R+EnGXpUBogywCJzE1P3gWMX/3a9TW1dhq8iJu2ZHc9ZPPPwwSNBRvz4=
X-Received: by 2002:a50:d71b:0:b0:567:504e:e779 with SMTP id
 t27-20020a50d71b000000b00567504ee779mr1210099edi.25.1710247448377; Tue, 12
 Mar 2024 05:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a05:6f02:8506:b0:65:b649:35ec with HTTP; Tue, 12 Mar 2024
 05:44:07 -0700 (PDT)
In-Reply-To: <20240312120658.os72hvnk5jedwbaw@quack3>
References: <000000000000c74d44060334d476@google.com> <000000000000f67b790613665d7a@google.com>
 <20240311184800.d7nuzahhz36rlxpg@quack3> <CAGudoHGAzNkbgUsJwvTnmO2X5crtLfO47aaVmEMwZ=G2wWTQqA@mail.gmail.com>
 <20240312120658.os72hvnk5jedwbaw@quack3>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 12 Mar 2024 13:44:07 +0100
Message-ID: <CAGudoHGLLbXxxEyeOQxecL5Cj21rFgMo1QFGYntF+aNEKyJ=rQ@mail.gmail.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in do_open_execat
To: Jan Kara <jack@suse.cz>
Cc: syzbot <syzbot+6ec38f7a8db3b3fb1002@syzkaller.appspotmail.com>, 
	almaz.alexandrovich@paragon-software.com, anton@tuxera.com, axboe@kernel.dk, 
	brauner@kernel.org, ebiederm@xmission.com, keescook@chromium.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-ntfs-dev@lists.sourceforge.net, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On 3/12/24, Jan Kara <jack@suse.cz> wrote:
> On Mon 11-03-24 20:01:14, Mateusz Guzik wrote:
>> On 3/11/24, Jan Kara <jack@suse.cz> wrote:
>> > On Mon 11-03-24 11:04:04, syzbot wrote:
>> >> syzbot suspects this issue was fixed by commit:
>> >>
>> >> commit 6f861765464f43a71462d52026fbddfc858239a5
>> >> Author: Jan Kara <jack@suse.cz>
>> >> Date:   Wed Nov 1 17:43:10 2023 +0000
>> >>
>> >>     fs: Block writes to mounted block devices
>> >>
>> >> bisection log:
>> >> https://syzkaller.appspot.com/x/bisect.txt?x=17e3f58e180000
>> >> start commit:   eb3479bc23fa Merge tag 'kbuild-fixes-v6.7' of
>> >> git://git.ke..
>> >> git tree:       upstream
>> >> kernel config:
>> >> https://syzkaller.appspot.com/x/.config?x=bdf178b2f20f99b0
>> >> dashboard link:
>> >> https://syzkaller.appspot.com/bug?extid=6ec38f7a8db3b3fb1002
>> >> syz repro:
>> >> https://syzkaller.appspot.com/x/repro.syz?x=15073fd4e80000
>> >> C reproducer:
>> >> https://syzkaller.appspot.com/x/repro.c?x=17b20b8f680000
>> >>
>> >> If the result looks correct, please mark the issue as fixed by
>> >> replying
>> >> with:
>> >
>> > #syz fix: fs: Block writes to mounted block devices
>> >
>>
>> I don't think that's correct.
>>
>> The bug is ntfs instantiating an inode with bogus type (based on an
>> intentionally corrupted filesystem), violating the api contract with
>> vfs, which in turn results in the warning way later.
>>
>> It may be someone sorted out ntfs doing this in the meantime, I have
>> not checked.
>>
>> With this in mind I don't believe your patch fixed it, at best it
>> happened to neuter the reproducer.
>
> OK, I didn't dig deep into the bug. I've just seen there are no working
> reproducers and given this is ntfs3 which doesn't really have great
> maintenance effort put into it, I've opted for closing the bug. If there's
> a way to tickle the bug without writing to mounted block device, syzbot
> should eventually find it and create a new issue... But if you want to look
> into this feel free to :) Thanks for sharing the info.
>

Maybe I'll get around to future-proofing by adding validation before
the inode escapes the filesystem code, but I'm definitely NOT patching
ntfs. 8->

-- 
Mateusz Guzik <mjguzik gmail.com>

