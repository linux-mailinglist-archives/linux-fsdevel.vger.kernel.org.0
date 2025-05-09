Return-Path: <linux-fsdevel+bounces-48644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F46EAB1B15
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 18:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CD51898A2A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 16:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D587D237172;
	Fri,  9 May 2025 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5S7U+HT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C85717A310;
	Fri,  9 May 2025 16:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746809836; cv=none; b=KDhP5I+XdNrg0trqUwvqiyyid22pPDyfBQYPbuu/jcDBtFZCKNtUgijYwWV6QecVpV5pvFtXoNY7FmGpZ7jiVKO2/w2Uf1h5f2dXHXfcCj5RqOMWzw/qFxo+ZHWZ1Cf3Zpus+teGw8J0KmydH3s8zufI0RQrXPMZdNCQZJEXtJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746809836; c=relaxed/simple;
	bh=lT6+5lvqECP8bca6vJ6+nru4nUALqmOYT17O2NyHwKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dj/7ThXQoMdSR8sOJ23EZ5j7Fc3xm/75+QhYDABljy0NF9ieIxoaYPu1SX8czsYKS501PyYaVGjUNrd34cdBl3kqlb+NgCMUdseAONW+AzYm9MhJv70xIwDE8NwFoJV/lq7E/9Sr6l6PoEK4iqGikRytVOvSNbuRVxSbPe2k0kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5S7U+HT; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad2216ef31cso131480166b.1;
        Fri, 09 May 2025 09:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746809833; x=1747414633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lT6+5lvqECP8bca6vJ6+nru4nUALqmOYT17O2NyHwKU=;
        b=K5S7U+HTW8s3c5890DiWgC4g3nKFFWSfm9yEPQRA1hJ4c0PbVd19hQgyt+JFsxbilV
         ewA5hrZviCpzF2RsAFM9kMvHBoUclb2PcEdk+nVUWVqbKaVQquQN0xc4Px88NzpiuO9g
         hqWysNtfAPhUOyulSrV7PV4JFIU+s7f6a9erSAjPF8gQkn9Yje8QBFbol/ZpjaNIBrJW
         TEzTug3gVsQrMHtQAsSCLSs6Cw+GvJ5ZNC5Rph5H3lVyhJIIzZpv6iSOZfU15R51OvzI
         z9OHYDhszwUSXOXExCwLcO3rKvJQK2tRF66BjsnrykWjkHwoEV3JWoWjXpCHgalXI9CF
         EKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746809833; x=1747414633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lT6+5lvqECP8bca6vJ6+nru4nUALqmOYT17O2NyHwKU=;
        b=OQ2YNDniLL4ANNFWYHIuJZIj0JZic6ekz6Ut/VTIj35uUrIOE93Qg2RfL1c5kb8wpW
         G1v5cb+nts6Gwbb7v3Q+vGCPAkKmRKGyot+vYhls7wUvpDjryD3GTNww5nR9Gic/KGga
         XdR1terJXxkWWqSeWDHbjJcwWgwe9Q/e/yVDsiwakf9KZ4P34/f2QExdjauTwhqG9Q2K
         l/vdbgYPs5hemcocUpkG7/GujFe1y3Kqvm3C2Uy4dtnK6au8hp0YHFeZNjrn9PhiFWfN
         p9c6wFLJktVr65AAAp9PxaqeBYbcWcFlrLRHg90KBWKyWlnd7jJPeB57NXMDPu6xnJwo
         F8Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVkojI+o5Wc4vigRg7ITSabJRJumA9OdqioSd2G2USE8+gZA0tZRQV0izyjhrIedm2WwbEZVKmTf1+uNUMT2g==@vger.kernel.org, AJvYcCWeIHiq9qkP0uxe5JLrXFR+WlT30bYAIZJ/FaHYQ1Y7A/pHW9fSeBRhfQGvrGkoHJIZmsBkQKb+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz32MKIMPW5swxQNZG57EruwuOlAV3dSwggyuL4NSxpH/DVTHPq
	gTUdRV1A4+2Z3hAq/HOppNKZyGZyEE7gN9rPOR55it2IYdjgfveArVCvKLChZ52K3W7rAehoms4
	6EPUjr28hv5NykzFlpttcoImPEMPMhzntcmI=
X-Gm-Gg: ASbGncuVxYeEalcDzMCzGkN3zFZSR/txF+FvnFiiwmEPWo9vGu2Lc8dqu3ZJarm7Yri
	29OmjlhxPcePajnIC/L04cagRLBpvct+ayWlmWkOkjPYb4QLNsJqv1zBeUc8JMV6BUpB4n35u/Z
	cdJh+VoN/AWsqyRXmAtAHQnA==
X-Google-Smtp-Source: AGHT+IGvZRN8hq+P3TH772iRYkvZcPOIdS9vjkfIZHy/AcIHVXTSFBcM5QatXHEvNIvkkTkdyZ4y61F2w12HDAdke44=
X-Received: by 2002:a17:907:3fa6:b0:ac7:b368:b193 with SMTP id
 a640c23a62f3a-ad21905ef00mr496817566b.27.1746809832407; Fri, 09 May 2025
 09:57:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409115220.1911467-1-amir73il@gmail.com> <20250409115220.1911467-3-amir73il@gmail.com>
 <20250508193800.q2s4twfldlctre34@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAOQ4uxjZnL5AMwwc06tiGJGbkjjW+88jDGudtp-MLkkPdzHT0g@mail.gmail.com>
In-Reply-To: <CAOQ4uxjZnL5AMwwc06tiGJGbkjjW+88jDGudtp-MLkkPdzHT0g@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 9 May 2025 18:57:00 +0200
X-Gm-Features: ATxdqUGcy1EGyRl48rUpqVaNZLxic4o389FofG5c23mDJ8aj5-q68PMTlAz0nW4
Message-ID: <CAOQ4uxj0M6rfU0AfSMJEz60h0wHqyezUXUKyg=OaQMv+EDbdOw@mail.gmail.com>
Subject: Re: [PATCH 2/2] open_by_handle: add a test for connectable file handles
To: Zorro Lang <zlang@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 10:38=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Thu, May 8, 2025 at 9:38=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrot=
e:
> >
> > On Wed, Apr 09, 2025 at 01:52:20PM +0200, Amir Goldstein wrote:
> > > This is a variant of generic/477 with connectable file handles.
> > > This test uses load and store of file handles from a temp file to tes=
t
> > > decoding connectable file handles after cycle mount and after renames=
.
> > > Decoding connectable file handles after being moved to a new parent
> > > is expected to fail.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> >
> > Hi Amir,
> >
> > This test case fails on some filesystems, e.g. nfs [1] and tmpfs [2].
> > Is this as your expected?
>
> No. I will look into this failure.

So what happens is that on filesystems that really get unmounted in
mount cycle, trying to open a connectable file handle after file was
moved to another parent is expected to fail and this is what the test
expects, but tmpfs does not really get unmounted on mount cycle
so opening the file handle does work.

Similarly for nfs, the file remains in cache on the local server so opening
by handle works.

I have removed that test case in v2 because it is unpredictable and added
verification that opened files have a connected path.

Thanks,
Amir.

