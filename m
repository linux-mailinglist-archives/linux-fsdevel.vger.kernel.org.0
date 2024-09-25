Return-Path: <linux-fsdevel+bounces-30104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26562986352
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 17:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E871F259C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 15:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08AD1D5AAA;
	Wed, 25 Sep 2024 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5AFSXns"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F8013D50C
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276714; cv=none; b=pPNH04NbsGwi8eQTeHq3JjJ0HuxdacUUPmkme3Fe4S6FEGKbbEL+xoYbvZGbwBQSO8IsOjzVP4LWoj3y3Oe1RlrsdDv3zM8hHgRW9/j9MqvImlmXghahEtKopmN9LDb0ZMs3cIo29w5ggnPXrl4i/bt5HsMjcBsPEeKlmjfVDUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276714; c=relaxed/simple;
	bh=i4aWQ74F68GcZ66T0SPUsPClUeL1Pwn1OnLNsTQW20M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AmzCxvlHhImOHhdWYt6t99fglwFa2oiLzmUJHNIoSwSU9G+FcxoEwHDPdZb4hYgEoKH2ioprsFD17sHbotGDOCmWkUX5rnZSMo814WYd3fONK3E6zliEvY+92qhfLiaAZDoI27RalbLMv2gBPil38lupYT3BmrgJIoqId/9syRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5AFSXns; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a9a7bea3cfso427993885a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 08:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727276711; x=1727881511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4aWQ74F68GcZ66T0SPUsPClUeL1Pwn1OnLNsTQW20M=;
        b=I5AFSXnsQnjrd8Aga+kZuRjCBQYbDZ7+p7RKGsQJxnj1ld4iVsftP1BKhrx0otVd4I
         Cyi7PqiTTSWoaomJMBJsUkCock1gCzn27BI1gJALZAXg99GFuf/1czEW3lxa+uAK3a1U
         IpdLY8Gm1wpKyjpPk0y3v1k/m0cbx1AJkpgFN9vmzB7bQ/8+8HsZN71PFCJvVSVe+k1I
         MeRbrHZeyw/oCB7Kk96luLGWO13+IW0l0WUXsJ8gFx2TVK54IyUvbmywl6Bg5xl64M7K
         w7Z2an47+yIEs9ZRQNIoUA10IDsYiL5n5iSSUK4+v40VV5ljUI89PxSFJYQ1iFLDgd5w
         Z4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276711; x=1727881511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4aWQ74F68GcZ66T0SPUsPClUeL1Pwn1OnLNsTQW20M=;
        b=r9SJH3jW7pXwLL54+OIc/6T/aVGvvqihZncAk/so36bVFdRXKKD/eLYWuO4LWh3qVe
         4WvuAYV4qauHzYQOogxS9u++VVIbfLts7DItVgpDPba/Z9IgByRoPEsO7FWdktxoxJps
         mgBvd8DsgWmEmr2RJqnS+vcXohIWHSnVEhC3Y7IE2RBjHA2eUVboHw666IvWR93yKJU2
         yGYeFQfBl8fGQsFihntw+op7dUPQi/w8lDbir8Hpjd2cIQ1wjYYp/7m0KbmAQFA2WAk0
         f86txEUU+7+qPR/MMMcqR4Wfn0n86OVNBY3kdORWoW0oPdFnWqPj1IUgL8Dm+WkKsTJs
         Mw2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXiV4q7ZXJugV64deFVKqghD8kNQgE/GHQAGtUeBQY1R6NwdA54oApLmSarfJEsQ9RgptrUMPcsUcUDV5QP@vger.kernel.org
X-Gm-Message-State: AOJu0YzOJn2dIcH2tI6+kuci4J7zcNfI86L6JL+xdoYNcKGBO5auhqjR
	0gBA8NbjfBfP2ShW8Q4CFt/GhYytRcZteo8Q0bR+h+HQa0O/KcJLW8uXJSxLF6jOn1ZlX0rRuHH
	sqlTeWO9+99l2RKgbop8FrTQgprs=
X-Google-Smtp-Source: AGHT+IHLRkUkrQz9oX2/jWpdyBnuBn0AH6wAkFvLI7fK0CnB4oT1RUmW00sdQaCzOkjws2SMxFckIGwkQIeAn/NNTSY=
X-Received: by 2002:a05:620a:4145:b0:7a9:b04a:b324 with SMTP id
 af79cd13be357-7ace74658ebmr362468785a.64.1727276709328; Wed, 25 Sep 2024
 08:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxiuPn4g1EBAq70XU-_5tYOXh4HqO5WF6O2YsfF9kM=qPw@mail.gmail.com>
 <SI2P153MB07187CEE4DFF8CDD925D6812D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjd2pf-KHiXdHWDZ10um=_Joy9y5_1VC34gm6Yqb-JYog@mail.gmail.com>
 <SI2P153MB0718D1D7D2F39F48E6D870C1D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <SI2P153MB07187B0BE417F6662A991584D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <20240925081146.5gpfxo5mfmlcg4dr@quack3> <20240925081808.lzu6ukr6pr2553tf@quack3>
 <CAOQ4uxji2ENLXB2CeUmt72YhKv_wV8=L=JhnfYTh0RTunyTQXw@mail.gmail.com>
 <20240925113834.eywqa4zslz6b6dag@quack3> <CAOQ4uxgEcQ5U=FOniFRnV1k1EYpqEjawt52377VgFh7CY2pP8A@mail.gmail.com>
 <JH0P153MB0999C71E821090B2C13227E5D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxirX3XUr4UOusAzAWhmhaAdNbVAfEx60CFWSa8Wn9y5ZQ@mail.gmail.com> <JH0P153MB0999464D8F8D0DE2BC38EE62D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <JH0P153MB0999464D8F8D0DE2BC38EE62D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Sep 2024 17:04:57 +0200
Message-ID: <CAOQ4uxjfO0BJUsnB-QqwqsjQ6jaGuYuAizOB6N2kNgJXvf7eTg@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: Git clone fails in p9 file system marked with FANOTIFY
To: Krishna Vivek Vitta <kvitta@microsoft.com>
Cc: Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	"v9fs@lists.linux.dev" <v9fs@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 4:22=E2=80=AFPM Krishna Vivek Vitta
<kvitta@microsoft.com> wrote:
>
> Thanks for the link.
>
> Also can you try the third step on your standard linux kernel by omitting=
 FAN_OPEN_PERM in the mask and share the observations of git clone operatio=
n. Does it succeed ?
>

So it depends on the definition of success..

I do get this error with the fanotify_example watching 9p mount:

root@kvm-xfstests:~# /vtmp/fanotify_example /vtmp/
Press enter key to terminate.
Listening for events.
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/info/exclude
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/description
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/applypatch-msg.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/pre-merge-commit.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/pre-receive.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/update.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/post-update.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/pre-push.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/pre-commit.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/prepare-commit-msg.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/push-to-checkout.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/pre-rebase.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/pre-applypatch.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/fsmonitor-watchman.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/commit-msg.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/HEAD.lock
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/config.lock
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/config.lock
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/config.lock
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/config.lock
read: No such file or directory

But git clone does not complain at all:

root@kvm-xfstests:/vtmp# git clone https://github.com/filebench/filebench.g=
it
Cloning into 'filebench'...
remote: Enumerating objects: 1157, done.
remote: Total 1157 (delta 0), reused 0 (delta 0), pack-reused 1157 (from 1)
Receiving objects: 100% (1157/1157), 1.13 MiB | 1005.00 KiB/s, done.
Resolving deltas: 100% (812/812), done.
Updating files: 100% (136/136), done.

I did get the same error with FAN_OPEN_PERM:

root@kvm-xfstests:~# /vtmp/fanotify_example /vtmp/
Press enter key to terminate.
Listening for events.
FAN_OPEN_PERM: File /vtmp/filebench/.git/info/exclude
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/info/exclude
FAN_OPEN_PERM: File /vtmp/filebench/.git/description
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/description
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/applypatch-msg.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/applypatch-msg.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/pre-merge-commit.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/pre-merge-commit.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/pre-receive.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/pre-receive.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/update.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/update.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/post-update.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/post-update.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/pre-push.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/pre-push.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/pre-commit.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/pre-commit.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/prepare-commit-msg.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/prepare-commit-msg.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/push-to-checkout.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/push-to-checkout.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/pre-rebase.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/pre-rebase.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/pre-applypatch.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/pre-applypatch.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/fsmonitor-watchman.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/fsmonitor-watchman.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/hooks/commit-msg.sample
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/hooks/commit-msg.sample
FAN_OPEN_PERM: File /vtmp/filebench/.git/HEAD.lock
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/HEAD.lock
FAN_OPEN_PERM: File /vtmp/filebench/.git/config.lock
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/config.lock
FAN_OPEN_PERM: File /vtmp/filebench/.git/config.lock
FAN_OPEN_PERM: File /vtmp/filebench/.git/config
FAN_OPEN_PERM: File /vtmp/filebench/.git/config
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/config.lock
FAN_OPEN_PERM: File /vtmp/filebench/.git/config.lock
FAN_OPEN_PERM: File /vtmp/filebench/.git/config
FAN_OPEN_PERM: File /vtmp/filebench/.git/config
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/config.lock
FAN_OPEN_PERM: File /vtmp/filebench/.git/config.lock
FAN_OPEN_PERM: File /vtmp/filebench/.git/config
FAN_OPEN_PERM: File /vtmp/filebench/.git/config
FAN_CLOSE_WRITE: File /vtmp/filebench/.git/config.lock
FAN_OPEN_PERM: File /vtmp/filebench/.git/tSXZBNw
read: No such file or directory

I do not get fanotify error when watching and git clone on xfs mount.

Thanks,
Amir.

