Return-Path: <linux-fsdevel+bounces-11116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A51D085135D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 13:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD4F284982
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 12:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D266A3AC14;
	Mon, 12 Feb 2024 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CKG1fEDe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF783A29B
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740140; cv=none; b=t3UwxqJq4+meWUexYWhZanXaEeI+gAewfCydIle7FWnchl3cCog3rHXM+Wao3Nsh8fY8uuUcgTM31U6NbVKQOHGmrkqp8yOGU1Kp4dzHlH1hNJiZ9ouGLyt0xGw5zUZs9olzTyCHgPhPSq0K+rByCKQsosDUtvjK4gdkPKmC9U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740140; c=relaxed/simple;
	bh=N8tncqgbitEfsa+IsxrMjvd4SefbZ9HRuwb/K2AteQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SF+JiPey6gcov/n7dpG1vM4iTdQwC64oeOaaLqTkYYlIlV3seZ/XzO/wNFH0/6iIvMT4xnRqZSYwcHGpZM/oyxP/syEh4FZkjGd31mDMtGYV29mxZ8Kb6stpTWE4ZdlCu50D/2+gdpSQtLuTSMmYeH6XPbpk/TuvYFJVcjGPmLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CKG1fEDe; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d5ce88b51cso771705ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 04:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707740137; x=1708344937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bI7LEK4WDVLJPhhNr0Vd4fweJ6AqMok5h6N4cph4ogE=;
        b=CKG1fEDepN4CIrqaufVAQZYW9Vwd8YwefbBvLT+9KzBCSvoO3RAY03XMK3qD2JPKqH
         f+6mU2aD0eDZxFSiW+mjrLtlWSqJUnSg9b/6yZ6mWY2d47mGIIyxnacl6d2ZwiWg4Dnw
         oYzM1ezr4IJo17SA6e5m+CFbpZD2sZctqogk+S65SOna5BtlQ5J6n9KT2zLx0gWyuC3g
         FULci2RwlqWWC6XcB0kBSslamERgbM2GMGRv1rEYtoGurpfsOur7/6tqXdSRSwuTk6bI
         28SkN+7ywnqw7Bq2w1v1Vq3z0rS+Lji0rG0UN0S1pSnJPxBdD6QTy0ntlS/WwxEoshSX
         wOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707740137; x=1708344937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bI7LEK4WDVLJPhhNr0Vd4fweJ6AqMok5h6N4cph4ogE=;
        b=K+n5PEjuOP7iWE9iasLEMzaGkMOOdySUA+SKKn9xfSE3AVT8L3pK8Fxupn1RtRtw+p
         NeghVP8dBx91JykzSv0pUrmB9qJ2KtPp8Mh/xb3aAoo2nDGYIwKkynY8UnkbbG36D49Z
         65tFGoHv9S3xwTdbKuZUC5ybHoZQ6fjA8hOGdP0Rz2Hw19l25gWsxUB+zVWjadFCEz5+
         hEaa0bMKtIInV/0M60Y6DhSMfBWrfladPOW3lMyddFU9nfGwVoGrjf0GPhyJxvVpJqj0
         vFLQos0BG/FGzCnQMVslK+fuHogoJ3Q5lhlglbvKMKkpQm7D399s6wLJHlhZgw810LT3
         rWFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPzvJH+uxH9872P8Ir6Pv2jh84vr815nyTRNJTjjXM1qTDmtBc0WqkzrjnwRnVsbqmesbciEEwuy/txouIUf6H3CvK9Awp7BOw6C0iHw==
X-Gm-Message-State: AOJu0Yyy6rgg15VKVlVwT9oK1YZwji8yA29NYO+IQGwB3nPunEwrYGAv
	NSOSKoKPzRTRylGpo1gqF1oedZAfwhCYmCDHSgxA/dqICJTp2thRifs1xm/y+dhP4rxeVliJ5Df
	upktED5tVe5fqi6pPTuMgv0gAdsHqCUVYPVUu
X-Google-Smtp-Source: AGHT+IHBHINE+I1Ojvjs2h4YbI4fTibMLxN/GcemctMTpyQuPSntiSdNs0ixyKFyckYID55PescGAehf4Gwz57+8UM8=
X-Received: by 2002:a17:903:44b:b0:1d9:a393:4a38 with SMTP id
 iw11-20020a170903044b00b001d9a3934a38mr253072plb.26.1707740136946; Mon, 12
 Feb 2024 04:15:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000c47db50610f92cf9@google.com> <9175d10b-035c-4151-80bc-f76bddc194ba@gmx.com>
In-Reply-To: <9175d10b-035c-4151-80bc-f76bddc194ba@gmx.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 12 Feb 2024 13:15:22 +0100
Message-ID: <CANp29Y5f91cP6eLEX55x9rEQcTD1VZMEqYkcDjBDREOAzXMETg@mail.gmail.com>
Subject: Re: [syzbot] Monthly btrfs report (Feb 2024)
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: syzbot <syzbot+listad2f01a497df9ab5d719@syzkaller.appspotmail.com>, clm@fb.com, 
	dsterba@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

It looks like existing reproducers for this bug began to fail after
CONFIG_BLK_DEV_WRITE_MOUNTED reached torvalds and syzbot has not found
a newer reproducer since then (though it does hit the bug, so it must
be possible even with CONFIG_BLK_DEV_WRITE_MOUNTED=3Dn).

I was was able to reproduce it locally using the older kernel revision
built by syzbot:
https://gist.github.com/a-nogikh/f68aa687a72aad4bb46a64d995c2415f
FWIW here are the docs:
https://github.com/google/syzkaller/blob/master/docs/syzbot_assets.md

--=20
Aleksandr

On Sat, Feb 10, 2024 at 9:48=E2=80=AFAM 'Qu Wenruo' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> >
> > Ref  Crashes Repro Title
> > <1>  5804    Yes   kernel BUG in close_ctree
> >                     https://syzkaller.appspot.com/bug?extid=3D2665d678f=
ffcc4608e18
>
> I'm not sure why, but I never had a good experience reproducing the bug
> using the C reproduer.
>
> Furthermore, for this particular case, using that C reproducer only
> reduced tons of duplicated dmesg of:
>
> [  162.264838] btrfs: Unknown parameter 'noinode_cache'
> [  162.308573] loop0: detected capacity change from 0 to 32768
> [  162.308964] btrfs: Unknown parameter 'noinode_cache'
> [  162.313582] loop1: detected capacity change from 0 to 32768
> [  162.314070] btrfs: Unknown parameter 'noinode_cache'
> [  162.323629] loop3: detected capacity change from 0 to 32768
> [  162.324000] btrfs: Unknown parameter 'noinode_cache'
> [  162.328046] loop2: detected capacity change from 0 to 32768
> [  162.328417] btrfs: Unknown parameter 'noinode_cache'
>
> Unlike the latest report which shows a lot of other things.
>
> Anyone can help verifying the C reproducer?
> Or I'm doing something wrong withe the reproducer?
>
> Thanks,
> Qu
> > <2>  2636    Yes   WARNING in btrfs_space_info_update_bytes_may_use
> >                     https://syzkaller.appspot.com/bug?extid=3D8edfa01e4=
6fd9fe3fbfb
> > <3>  251     Yes   INFO: task hung in lock_extent
> >                     https://syzkaller.appspot.com/bug?extid=3Deaa05fbc7=
563874b7ad2
> > <4>  245     Yes   WARNING in btrfs_chunk_alloc
> >                     https://syzkaller.appspot.com/bug?extid=3De8e56d5d3=
1d38b5b47e7
> > <5>  224     Yes   WARNING in btrfs_remove_chunk
> >                     https://syzkaller.appspot.com/bug?extid=3De8582cc16=
881ec70a430
> > <6>  125     Yes   kernel BUG in insert_state_fast
> >                     https://syzkaller.appspot.com/bug?extid=3D9ce4a3612=
7ca92b59677
> > <7>  99      Yes   kernel BUG in btrfs_free_tree_block
> >                     https://syzkaller.appspot.com/bug?extid=3Da306f914b=
4d01b3958fe
> > <8>  88      Yes   kernel BUG in set_state_bits
> >                     https://syzkaller.appspot.com/bug?extid=3Db9d2e54d2=
301324657ed
> > <9>  79      Yes   WARNING in btrfs_commit_transaction (2)
> >                     https://syzkaller.appspot.com/bug?extid=3Ddafbca0e2=
0fbc5946925
> > <10> 74      Yes   WARNING in btrfs_put_transaction
> >                     https://syzkaller.appspot.com/bug?extid=3D3706b1df4=
7f2464f0c1e
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > To disable reminders for individual bugs, reply with the following comm=
and:
> > #syz set <Ref> no-reminders
> >
> > To change bug's subsystems, reply with:
> > #syz set <Ref> subsystems: new-subsystem
> >
> > You may send multiple commands in a single email message.
> >
>

