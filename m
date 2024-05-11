Return-Path: <linux-fsdevel+bounces-19323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D168C3265
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 18:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C797282446
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 16:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BF956B72;
	Sat, 11 May 2024 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ULeq8KuK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F1F54BFE
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715443682; cv=none; b=CltOeRSDVm2NQejLvvFj7xNuJJV+XGJitIMytcMi828FUJSFe7evvklKMg6IIiHnqGzFBiavrS9l7ecL7AZCQdLZtqVR2k3CQgvgbUHghtAX28oLAqzsqSdySyLnAra/wSJyiFYKk9onLTYaG+xAD/2AU99NEUt4zwZ6VFyYXNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715443682; c=relaxed/simple;
	bh=b2xgLWJ12B9dA7yJvvCHrNMtVEglRAoJlfEOtNuES5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XxgiCTpTM3tpLRx8CjkTeY4oVyOrWuS0EcXMUn8/yUdO2dlg+IBuznmv2DuKxf0cLJvwefPrhNBPlmnflDISMTbn1nGEYKSSAq1Vao82ZTgG0TEWjVfDqzO34Ufbm7dxgLh1bzzP9YExtB7amrYJWuaNjXB2dRY9us4OJw/1wBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ULeq8KuK; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so646788666b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 09:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715443679; x=1716048479; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7or3kRLBqC+pZwYgpkMPFAu5PqcPO71P/FhC/dzq1io=;
        b=ULeq8KuKJ8efXEI55kwCCnDXXZ3kDXgGi+3kzPneTXm6fueqMaCtSXmzUMyJhvg8ot
         MnF99qQvLQDiGAKcNoKcdiY348ogKOArW25HHWyDINrEtmfSPPHFvBE8CnQL5IWILUoj
         UTOUK4lifhOvrVy3IzInMqDPbHlwY3Og3KCg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715443679; x=1716048479;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7or3kRLBqC+pZwYgpkMPFAu5PqcPO71P/FhC/dzq1io=;
        b=ch0Q3vAXZ0WkhxMvqXL4gyKIJinh0k0n73NE8GIczly38+FT+MGTlgKb7AF29MTf3I
         CN0Ynvbm99JKuEDCIftH+ChaukosbPhQ4T1oIUVy+HWjtULNkwQhWkBT4E5V14/BhvZp
         dVEUaucud3pMZebifP33KHVkmx7+APk3E1YjZg2XQT4Jht3BqNvaQWk3O+G078vYLJTR
         l8sMolQg6FG1jfS4N+Ss02zEYlXFPWFFR6OBSrJv5DmImSa//Fra7lhYmgejml7f/W95
         5EhfGqnTcF4VGdc6Lq5Zh8TB0ZceT1L887FiMEb7IYCmdXYQYPODPRD63zH6X+JDwD72
         F3mw==
X-Forwarded-Encrypted: i=1; AJvYcCVg3OR9v8Uw2SjsBCgErvZ/P4WMl4uNeh9OfZ0sjajRPvjEmQ4upkLCGT5NIGDR3SuzaMYmsZ77t/QA+pVHAUYriP97a1dghTRdIRM+IQ==
X-Gm-Message-State: AOJu0YzfC0KX4MqEVywvPDDHdyBJYoeskKGn+vGwLDL5tC+s5tK9WcyB
	jueziyLNILllZZnPOuDIMcPi7vQAHVSYSyXBg09bKvx/j2Gjixtdz0S8O23yRi6+BbInqwSUtcH
	GHbO/ag==
X-Google-Smtp-Source: AGHT+IHR7iDHKVyTfrH0ChEdEpiu/soW7Zmy2egEoErOyAZY0KSe9VQdJPTPNvI73yNOVrYO9DaVag==
X-Received: by 2002:a17:906:4a95:b0:a5a:1562:5184 with SMTP id a640c23a62f3a-a5a2d53af6amr585745766b.3.1715443678774;
        Sat, 11 May 2024 09:07:58 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17555sm341645766b.189.2024.05.11.09.07.57
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 May 2024 09:07:57 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a5a1054cf61so777297166b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 09:07:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZWjUNY6ZP1CD0PpGnZ47Wgn0NHtgXzyNszAxVR5yCdWk1t0F64LrnyhUXRq8Awpb9+LJqkLDy757njozy0lCY7Ii22ToUbSZ7narUTg==
X-Received: by 2002:a17:906:dd7:b0:a59:d5e4:1487 with SMTP id
 a640c23a62f3a-a5a2d5cb6ffmr538476466b.42.1715443677246; Sat, 11 May 2024
 09:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511022729.35144-1-laoar.shao@gmail.com> <CAHk-=wjs8MYigx695jk4dvF2vVPQa92K9fW_e6Li-Czt=wEGYw@mail.gmail.com>
 <CALOAHbCECWqpFzreANpvQJADicRr=AbP-nAymSEeUzUr3vGZMg@mail.gmail.com>
 <bed71a80-b701-4d04-bf30-84f189c41b2c@redhat.com> <Zj-VvK237nNfMgys@casper.infradead.org>
In-Reply-To: <Zj-VvK237nNfMgys@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 11 May 2024 09:07:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiFU1QEvdba4EUMtb0HXdxwVxqTx-hoBbRd6E4b8JkL+Q@mail.gmail.com>
Message-ID: <CAHk-=wiFU1QEvdba4EUMtb0HXdxwVxqTx-hoBbRd6E4b8JkL+Q@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: dcache: Delete the associated dentry when
 deleting a file
To: Matthew Wilcox <willy@infradead.org>
Cc: Waiman Long <longman@redhat.com>, Yafang Shao <laoar.shao@gmail.com>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	Wangkai <wangkai86@huawei.com>, Colin Walters <walters@verbum.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 May 2024 at 08:59, Matthew Wilcox <willy@infradead.org> wrote:
>
> Some multiple of "number of positive dentries" might make sense.

The thing is, it would probably have to be per parent-dentry to be
useful, since that is typically what causes latency concerns: not
"global negative dentries", but "negative dentries that have to be
flushed for this parent as it is deleted".

And you'd probably need to make the child list be some kind of LRU
list to make this all effective.

Which is all likely rather expensive in both CPU time (stats tend to
cause lots of dirty caches) and in memory (the dentry would grow for
both stats and for the d_children list - it would almost certainly
have to change from a 'struct hlist_head' to a 'struct list_head' so
that you can put things either at the to the beginning or end).

I dunno. I haven't looked at just *how* nasty it would be. Maybe it
wouldn't be as bad as I suspect it would be.

Now, the other option might be to just make the latency concerns
smaller. It's not like removing negative dentries is very costly per
se. I think the issue has always been the dcache_lock, not the work to
remove the dentries themselves.

                Linus

