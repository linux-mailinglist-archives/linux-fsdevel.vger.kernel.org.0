Return-Path: <linux-fsdevel+bounces-14160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F29878876
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 20:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586002877AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 19:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B882254BFE;
	Mon, 11 Mar 2024 19:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGCYRhos"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9172A54BD8;
	Mon, 11 Mar 2024 19:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710183679; cv=none; b=lzADERRnNHb1QzjnSaWlaWK5oGA32MdJNwqXSuhTdE2OHIeki8we2iidbJBIGvARmBTj3yWA2Kd+WCIZeC0JsFXjE6RDYWov0NjwwTARGlpkJLfSflfVWExHATrteON3dio1hvdNNTVZfxvyxJuMHSC4m0OhLVq4J4UkhxuAU3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710183679; c=relaxed/simple;
	bh=ABrnR59EXiIp9yllD51+UosefIdej7Y6MVt+J8pZeT8=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A249mVgwy7fIzmaq7TAvsfKysQEaGbMiYm01XroC/RXs6rvAg2pqnT6PxteUsvgXBZdzKS99GpNsVD9bWRDpHdk5OI3/Zn0bjhYVe6bCtIQr8pfHr1F52FCb5aleTTRHFHI2sr1n/zslR0GAtSDdo3Ve2vML2SPf0JvSG+kgRYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGCYRhos; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a450bedffdfso619783666b.3;
        Mon, 11 Mar 2024 12:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710183676; x=1710788476; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EuECgiC6YMc7b0Edc0Kt2KDyl4Um6oShzEC+/b9iZLE=;
        b=UGCYRhosXcJnoMlzanQ8LKTq2VwQNNzIzJfTj7o5xajh3TeSthC+wY0RHOoPWYbJXy
         dgHCI5OwCwRBjmVjrzy2Q7ibBNjnPQg1vRrZqytiBSmtsaWxbAK8UzeApKsHbJtN65pp
         VDsIhhvDZnMyQw0ENH9c7Wyfzx96hWDI39jCoaM/EOeCJAC5mG4SaWBp9QJ83xIEidOs
         9Vm75MocVnlUWpElKvLn0DihlYFR0xl/CQOlgbCscxOiKmIXACqeyyBt31YQsVj7cKYL
         1e+dUpokvrDbqrMX8Tf6GTGaoi0+LcLzv8ZSCZd09VUsGw7ftWYbs9RaIDbttVdwV3uY
         k9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710183676; x=1710788476;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EuECgiC6YMc7b0Edc0Kt2KDyl4Um6oShzEC+/b9iZLE=;
        b=NhFXpO1XE0CMqP8wdaEznB3yyN0360iemY9KSNIcJC0LqsGGSZvVDfZBkNE+TqH+Jf
         WVrA7/7aMCZCLBt8c+q6g68pgExzHHuov9S0BnomUVEkhcAz7Hnp3gLhe/lFUawjVKRw
         6nymMKNfBVdpjPd7w9XTaw7q8Ls4etYEXcK9GHo7acsCM7PNPC2GkXkw29bnqkx8fyJ7
         yKSpezRmGMmDula2pAoEPWsw+xsrLVyg4+NaFIc8yWFsFo5pUyCtdbCe9sj3oASMtQQY
         8FRbSzT+6PcnKc6rjwOCGJBd6KDvS1S4ByfmTGDYuJwnA9iTGamtbYeA44iM1k5YyNUo
         u2pg==
X-Forwarded-Encrypted: i=1; AJvYcCVVLoyzb4yht7V6hekKquX0wjyMxR1zXpT4AwtkGrViuBhklT1Cf5Ju8ho8l7fJulo15rpQ/vfeYUevx6XDmy6O8hqfbJ7YMOddgU0QcGczmI4bVG4WEojtQuzcuwH8kYnPfA/mEgHoGeuOBg==
X-Gm-Message-State: AOJu0Yzi9HQ5aawo9R2o3KkgzBu3nzCK6A3JUPpOPIx/brP90kHRoJZ0
	eu7jQvIkAO65RE7iNFRcuXf0a5MNPP/8zxwE2DgD5Dd1G/4FiZOCUC+1NzL1J4xYJ6lzh1dDi4Y
	qidDwiZcMGn8nCAt8NZSYmE0pefI=
X-Google-Smtp-Source: AGHT+IHJ0O15Wf5Z2bUjYqjgmX08pg1z5eDQTDE216uygC9BNgkF8rcTIvSKcoh4XNj8NWUD8NKETARv77vkcti1LEc=
X-Received: by 2002:a17:906:52ca:b0:a43:6146:a4df with SMTP id
 w10-20020a17090652ca00b00a436146a4dfmr4237847ejn.21.1710183675559; Mon, 11
 Mar 2024 12:01:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a05:6f02:f0d:b0:65:b649:35ec with HTTP; Mon, 11 Mar 2024
 12:01:14 -0700 (PDT)
In-Reply-To: <20240311184800.d7nuzahhz36rlxpg@quack3>
References: <000000000000c74d44060334d476@google.com> <000000000000f67b790613665d7a@google.com>
 <20240311184800.d7nuzahhz36rlxpg@quack3>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 11 Mar 2024 20:01:14 +0100
Message-ID: <CAGudoHGAzNkbgUsJwvTnmO2X5crtLfO47aaVmEMwZ=G2wWTQqA@mail.gmail.com>
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

On 3/11/24, Jan Kara <jack@suse.cz> wrote:
> On Mon 11-03-24 11:04:04, syzbot wrote:
>> syzbot suspects this issue was fixed by commit:
>>
>> commit 6f861765464f43a71462d52026fbddfc858239a5
>> Author: Jan Kara <jack@suse.cz>
>> Date:   Wed Nov 1 17:43:10 2023 +0000
>>
>>     fs: Block writes to mounted block devices
>>
>> bisection log:
>> https://syzkaller.appspot.com/x/bisect.txt?x=17e3f58e180000
>> start commit:   eb3479bc23fa Merge tag 'kbuild-fixes-v6.7' of
>> git://git.ke..
>> git tree:       upstream
>> kernel config:
>> https://syzkaller.appspot.com/x/.config?x=bdf178b2f20f99b0
>> dashboard link:
>> https://syzkaller.appspot.com/bug?extid=6ec38f7a8db3b3fb1002
>> syz repro:
>> https://syzkaller.appspot.com/x/repro.syz?x=15073fd4e80000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b20b8f680000
>>
>> If the result looks correct, please mark the issue as fixed by replying
>> with:
>
> #syz fix: fs: Block writes to mounted block devices
>

I don't think that's correct.

The bug is ntfs instantiating an inode with bogus type (based on an
intentionally corrupted filesystem), violating the api contract with
vfs, which in turn results in the warning way later.

It may be someone sorted out ntfs doing this in the meantime, I have
not checked.

With this in mind I don't believe your patch fixed it, at best it
happened to neuter the reproducer.

vfs could definitely be patched to catch this when I_NEW is getting
cleared (only when  running with debug), not in the spot which
generates the warn.

-- 
Mateusz Guzik <mjguzik gmail.com>

