Return-Path: <linux-fsdevel+bounces-19383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0A88C44B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 17:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F0E1C21690
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 15:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5CE155323;
	Mon, 13 May 2024 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OsAtQRCf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FCB155322
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715615935; cv=none; b=FkL6rpyIgwxXgBGoOCgFSELWjN9fE1InOmTGt39jycZCpGtSn7XC2T+4spe2gdc8BdBz8Iuks5ulw+IJm7bkfAiIhaGr3bsjU3BPwsGzMGjpTB0PHeU29k34ylNgi+tZUldn7hlNibdiazJAfbLh62aQtjLtd5pnc8WX9ODtOUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715615935; c=relaxed/simple;
	bh=oBJ137LRijXux97+FLE5JyhZTRarw/l53g6qNfP07HY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKiexcOZNZmA5RimPwen6cGHJkI9E+fAG1hDBuUWUQyj7hft7PYPfD3rK/DaK0amD89LpsmbNTR6LJvGp3+Zd9k7pPQD/Amg1hnM02BRx5NUiku3qw3v8ks1zjb3VfeNCX16M+cFLjyN4HmIsFJdi1cqlme6R8TTO4lXgEmRoW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OsAtQRCf; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59a352bbd9so746905466b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 08:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715615931; x=1716220731; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7ypCPkWAVlTZ8y4R+nvEYeO8W5uHWbd8eZTRWk2xCKY=;
        b=OsAtQRCfbgUr2jWAXf+8Rysk57EZJM1CHqQI2beYLIhK5MRXmpWl00EPOUq9eudV3a
         grZosT20EWmZE8/OX7q1qdHqeeejRb+N5gawpu2q7go82c50UkrNvdLEt0/CA/6Pl5LA
         yLz1vWNkrU2oiHc9U4G7NHpQXmKJPTM0yDbmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715615931; x=1716220731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ypCPkWAVlTZ8y4R+nvEYeO8W5uHWbd8eZTRWk2xCKY=;
        b=lG2rrQv9f7djDDvms06MOWzRZH3Uwph7Pyr/uZIDqQWMtudLpgVIT1wjChGcR1Do5k
         votVjuFR3mRQLEt+2AXoUAELEvsucRsTr1ruKsBm2sIHiVKyoLEeT7CBKyh6CIB1w1MP
         NXBlrxmW8bhH6mdsOQ+agzNdcuN2WHBBFkrRd9OlLKZbmmw7e8ycijsm/omz6XiyPsLp
         YWuaWVMQwY3r3JzxFzvFdN8NArw/U89ItszJJOfi3FJxI1bag7/poUI58IUeNxKL1G1P
         o3ZtdGTWHmqfU+leUV8c+3aNNhdFIgTiezVF27K/crZM4cf/7xvDnRzTVOWZEjL/uK2w
         33uA==
X-Forwarded-Encrypted: i=1; AJvYcCVo7Xq0XYuo8Ea5pmvAv50tOB39iYpBcEkuVJnKF4Q6FcBgF+tHVjBymwAOJp4i5RUJFQJiE4SKoJssuojUKpkXNgI0oCwCpVATbjYemQ==
X-Gm-Message-State: AOJu0YyeyKNM0EkaLAscH8eWfCDxrUR4vuBO6jBaudL5VzvM6it2GbWm
	cVTaCd3V34wZMN/2aZqQdYgszIhCC5/+lhJKj124Ij0kmJufbKkcsPoF7Vup7Y6mpMp82EtcZZL
	ZnVs=
X-Google-Smtp-Source: AGHT+IFTe0HaSJHTCjhTChVQUpp2ApByq9egff8DMzXbK8BWLs8+zcJ34gHOPwZSUaTchriCtxfSLg==
X-Received: by 2002:a17:906:2845:b0:a59:f2d2:49b1 with SMTP id a640c23a62f3a-a5a2d1b0df0mr835358366b.9.1715615931372;
        Mon, 13 May 2024 08:58:51 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17891f87sm607100166b.65.2024.05.13.08.58.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 08:58:50 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59a609dd3fso781441466b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 08:58:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXhqYaZARd0YsR3/OLP/LD13pZ35t3bytP5i48P1wCp4qNYlSZ8+nfC3kJ6P3FuJ6snPPxL/SRdF4+XgLQWyy2OD6Me3kEZPf1MQ0NV2Q==
X-Received: by 2002:a17:906:2449:b0:a59:9dd7:35fa with SMTP id
 a640c23a62f3a-a5a2d3177fcmr814409866b.37.1715615929991; Mon, 13 May 2024
 08:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whvo+r-VZH7Myr9fid=zspMo2-0BUJw5S=VTm72iEXXvQ@mail.gmail.com>
 <20240511182625.6717-2-torvalds@linux-foundation.org> <CAHk-=wijTRY-72qm02kZAT_Ttua0Qwvfms5m5NbR4EWbS02NqA@mail.gmail.com>
 <20240511192824.GC2118490@ZenIV> <a4320c051be326ddeaeba44c4d209ccf7c2a3502.camel@HansenPartnership.com>
 <20240512161640.GI2118490@ZenIV> <CAHk-=wgU6-AMMJ+fK7yNsrf3AL-eHE=tGd+w54tug8nanScyPQ@mail.gmail.com>
 <20240513053140.GJ2118490@ZenIV>
In-Reply-To: <20240513053140.GJ2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 May 2024 08:58:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZU=TFEeiLoBjki1DJZEBWUb00oqJdddTCJxsMZrJUfQ@mail.gmail.com>
Message-ID: <CAHk-=wgZU=TFEeiLoBjki1DJZEBWUb00oqJdddTCJxsMZrJUfQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: move dentry shrinking outside the inode lock in 'rmdir()'
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, brauner@kernel.org, jack@suse.cz, 
	laoar.shao@gmail.com, linux-fsdevel@vger.kernel.org, longman@redhat.com, 
	walters@verbum.org, wangkai86@huawei.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 12 May 2024 at 22:31, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Recall what d_delete() will do if you have other references.
> That's why we want shrink_dcache_parent() *before* d_delete().

Ahh. Yes. So with the shrinking done after as my patch, that means
that now the directory that gets removed is always unhashed.

> BTW, example of the reasons why d_delete() without directory being locked
> is painful

Oh, I would never suggest moving the d_delete() of the directory being
removed itself outside the lock.

I agree 100% on that side.

That said, maybe it's ok to just always unhash the directory when
doing the vfs_rmdir(). I certainly think it's better than unhashing
all the negative dentries like the original patch did.

Ho humm. Let me think about this some more.

We *could* strive for a hybrid approach, where we handle the common
case ("not a ton of child dentries") differently, and just get rid of
them synchronously, and handle the "millions of children" case by
unhashing the directory and dealing with shrinking the children async.

But now it's the merge window, and I have 60+ pull requests in my
inbox, so I will have to go back to work on that.

                  Linus

