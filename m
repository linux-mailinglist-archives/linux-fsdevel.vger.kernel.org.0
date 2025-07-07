Return-Path: <linux-fsdevel+bounces-54169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5388BAFBC0E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 22:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79CA17B83B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 20:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46191F3BB5;
	Mon,  7 Jul 2025 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="YDzi6grW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6003C8EB
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 20:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751918454; cv=none; b=IMzCypyMwgItLuGadazpSqXQgyAjKDCr7Y7JdsV0fKvuHDyL+Seif8M6dctbJWt4cCfnHoJYoHgkVFAnbOyuQZdCbVpm0XgqAxZDzPYgRzlTnyJrQOIKRy+sSKkuIyq8RS6+IgvlJt+zZtXHhyx5zHEhtIPKOYNn9fNxgtDFH6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751918454; c=relaxed/simple;
	bh=/KYYIIAaEA50FFoHqN0bbqdz2W1OkeVAuaeXrR6zOMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGSJHjxz9102PJVgGGx6mj+m/R5fMtITXNoRSgucAlXWmydp3mPC/BlXEv/vwP2/eGStkKjjDElFpBAR61GcQgLVtfh6sDSXfye6JOuPJwUhcPdGH6p1WS1mY0EG1iy5xwJ7KzGhu8TVtOfwh8+xgPVwwkjQU2k1PPtI7D2hNNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=YDzi6grW; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso761036666b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 13:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1751918450; x=1752523250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRpplLoinrrECBffAVQ9TdX/+j6yHXkuMoC+Y8fOL4A=;
        b=YDzi6grWtyapskvL2gYqAQeRZEpr3XdvrOuSOqJOpg/NJjcHR0y58+YwWJ4+kKuDCU
         cBrPKJtCDdwnskoOa9kqWC1trGk7oaE/i33bXr4YYKJC7haLQhVkHBTSRsQac+DbRHza
         NQjovyUCz30lp7+V/BzJ0QP9CVGcM6zTwgSDDtZyq7X/njZjTO1H/dKdp8b3fq8w2VJE
         vqOfVjc2Lpn6J2Mijz6/r9AhAES2ZzB291qant5kdr6G/PDDNsrLBhYmpNK7TeOT9qgD
         KyDEe7APpivjOeNdj3G6+dRwNbOs4zVZ7uhpIQqBWINWj1pMFUEEXHb8AcQVTR34kDRu
         kh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751918450; x=1752523250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRpplLoinrrECBffAVQ9TdX/+j6yHXkuMoC+Y8fOL4A=;
        b=T+ROuXx4UXdIJi/h4SUUSF9v5FmgA76CW5rJuz4fJzwU+1cQu3Zwk1+7Meq+y/dJjA
         cniyBX0pJjpA4UuIv6lGWbf/WQ+LyXQqpFKwCYE8+T+yZaTOOG9hPrwHWLWF8CmWVrnU
         iRiHqi4XthnRA9JWiDs+/fQeNJbMrtA/HfkjW0kHB6uyUrqLsH3wYEib89bOF5so46v/
         d7SqPkJyqQ8eproylCzLQurXMtZdUSS28H7e2GWq5wg0pTSwlkjPvA+YAxKvBDJR0E+/
         kXNySmL8ESgCT8rxp9XRicftMGzva2F22nvWn1G5sd1EKPZKoMNs99jyzcd+iHlX8eQK
         TR1Q==
X-Gm-Message-State: AOJu0Yx+MT4zPXKsDwhbkuHpGL2C120A3cQ5s1b/0+dtFGPKr0ijl+XG
	n19DCJDGfz4jnAguHcBPipZFbXM70IodCy0XgoKhszxmCdM26a66gSrp3bsU+JEBjH8WHkR+p21
	i+7K2oZ2yAS4JGk9Im9NPVAmy7PmttPu11UUY+jwGaQ==
X-Gm-Gg: ASbGncujb9WECLA7DOFvMqHUilVMrayn7KSVr7CWZOvB1hmAw3m3gFHA48cGpt/8TDR
	//eMfsZ993sirhUFjYuinQ6SrS2k/9ZeXy1MP0mI9odhut39EbtPIVJwyq7ToHqsFYimeItpaK2
	qKGDXfgm2wpDcyL0q+ooTwKoU9/xMEsjGKThcQrbT1d6rENnIwCLGT4/JSEoC3EmQh2GAGIfQ=
X-Google-Smtp-Source: AGHT+IGm2tY6OAfddzH6X4AE09gT/zniYaaONXquFOnJq8efUbUw/BgpBbDbGw1cSHmppqHG1dTd6772q/o7fgq/bQY=
X-Received: by 2002:a17:907:869e:b0:ae0:3f20:68f8 with SMTP id
 a640c23a62f3a-ae3fe6fb02amr1404832266b.39.1751918449809; Mon, 07 Jul 2025
 13:00:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124060200.GR38156@ZenIV> <20231124060422.576198-1-viro@zeniv.linux.org.uk>
 <20231124060422.576198-20-viro@zeniv.linux.org.uk> <CAKPOu+_Ktbp5OMZv77UfLRyRaqmK1kUpNHNd1C=J9ihvjWLDZg@mail.gmail.com>
 <20250707172956.GF1880847@ZenIV> <CAKPOu+87UytVk_7S4L-y9We710j4Gh8HcacffwG99xUA5eGh7A@mail.gmail.com>
 <20250707180026.GG1880847@ZenIV> <CAKPOu+-QzSzUw4q18FsZFR74OJp90rs9X08gDxWnsphfwfwxoQ@mail.gmail.com>
 <20250707193115.GH1880847@ZenIV>
In-Reply-To: <20250707193115.GH1880847@ZenIV>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 7 Jul 2025 22:00:38 +0200
X-Gm-Features: Ac12FXzDnEuya4ABV1F2toI6cBgTX6YkificHgygpbUaXW9Y5dV_8shnc-sxg4I
Message-ID: <CAKPOu+_q7--Yfoko2F2B1WD=rnq94AduevZD1MeFW+ib94-Pxg@mail.gmail.com>
Subject: Re: [PATCH v3 20/21] __dentry_kill(): new locking scheme
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 9:31=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
> > But why did you add code that keeps looping if a dead/killed dentry
> > was found, even though there is no code to do anything with such a
> > dentry?
>
> Huh?  That dentry contributes a soon-to-be-gone reference to parent;
> it's still there in the tree, but it's already in process of being
> evicted.  The parent will remain busy the end of __dentry_kill().
>
> It is *not* dead; if you want slightly distrubing metaphors, it is alread=
y
> beyond resuscitation (that's what the negative refcount indicates), but
> it has not finished dying yet.  DCACHE_DENTRY_KILLED in flags =3D=3D
> "it's dead", and those can't be found in the tree/hash/list of aliases/et=
c.
> Negative refcount on something found in the tree =3D=3D "it's busy dying =
at
> the moment" and parent is kept busy until that's over.
>
> And we *want* those to be findable in the tree - think e.g. of umount.
> We really don't want to progress to destroying fs-private data structures
> before all dentries are disconnected from inodes, etc.

Sorry Al, I don't get it.
I understand that objects that are still referenced must not be freed,
and of course a dentry that has started the process of dying by
__dentry_kill() needs to remain in the tree, and that its parent must
not be freed either. Of course!

But none of this explains why you added this "d_lockref.count<0"
check, which I doubt is correct because it causes a busy loop, burning
CPU cycles without doing anything.

Maybe it's just me, maybe I'm missing something - then sorry for
bothering you with this. But I believe that there must be another way
to implement this, without burning CPU cycles. A busy wait is (almost)
never a good idea. Please help me understand. (Or maybe maybe I do
have a point and this should be optimized. I'm confused.)

Max

