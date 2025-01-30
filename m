Return-Path: <linux-fsdevel+bounces-40424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21D9A234AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 20:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6AC164F9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 19:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EEE1F03F5;
	Thu, 30 Jan 2025 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jqnMymBM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6631E522
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738265486; cv=none; b=ZRq1awACC/usoUVEkaV8rGSJEb5yd/FVEAcsQZ3W7yQMhvRqEY4XwJO/0o4b1A/N/t6bMD+9QT1+UIp4TOReOL7ZaLsNbRlH5payzbgCehCEFd0OZ/hVQ+U7JJLTBQ77GznLQMaz0MhI0wVhvqR9owV+oWUWyHpXdHF0fpFx3lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738265486; c=relaxed/simple;
	bh=d1rgKVEl8OUlaljZGhdwTW0BxXvvCP6MoRAeb84p26k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sg5+PPaLQKRmoEZbNOqhbXrXfEsH3S7uCbhcXTUVbfnFOEtJ76U9wELjAxhsmVFNgKjIKH+LkVcgc2aIaKWU2EaXmDBuVwCWqn/aNse+ewg7W3DniUvu3GUgr/nERc2mNThOa+MkViLtOTuN57ehuenwSe6zbG2kYEi+Lhi4vWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jqnMymBM; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46c7855df10so19403401cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 11:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1738265483; x=1738870283; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hNJlrraj+NS8urRTPwYhzJT1Z4ljAUAGM1uhK6PJJ3A=;
        b=jqnMymBMH1bJBANsLKsvFqomsqJqevG68UmxOpNw+qsZbLfIhhLYsNL9HIIWHFD5Ie
         H7NsxOrExeCXB09tM9IZDyMv1/MeMW3IDrDOw5aejoWZbT2yZh7jfsSm8LaAqAAxMted
         x349UmqoEST9WPLdvJ/AtYROgi/mpgrMravXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738265483; x=1738870283;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNJlrraj+NS8urRTPwYhzJT1Z4ljAUAGM1uhK6PJJ3A=;
        b=pROUY7KV/Jpc1RQX054BOIW710c/PXNWX8avnk5cR4bTyxRUFcEZEmu6o34z1nBzlq
         yagnrr+srWuFoY4CsseCL1o3gw0MwzGpaVzwoZttS/e190O4rVv4YonAAiJoqacwQZ4Q
         Bo8hVSJSGNb1Tgiwv8Mi/MXjdkvllgoGls8fxLHdJBWLWrJZeqEklGSZc7K5DO65t4vI
         Y+Itt7WfQjbZ0y5Rh1/XTZSTbM+LwANgrlGxpamuL51Daods3zfjvAZpsDiqHfgYR9A3
         d+yfG3+U3n5WmMyynBnjDyPNfQyuwg0Myw7IHBi94mHKw0JiDli8BtCSyke7hOTKt/17
         y4oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTB1mPe9+M8mdiEhzf0qBXPdy9ZNIZui0NF/A4YtO0Jkgy8bWNlOdsJ+YuqLhwYrh6VcvWjpq7Gpw5qNCm@vger.kernel.org
X-Gm-Message-State: AOJu0YzlNjmXZD7Ma/TiKWZqGTsfkeFRhb6RFQ0ehEZoY6uHthJ797aw
	BmIRzQ+6b4oyrIToPpMvlHPsuDrK0v+4R4Zy0wnb/BgHp5o8+gFgl0z6iIaQn/gi6Xn9TP2j6oV
	2h55qe7DSSvIWMIXyWbfWqhF1VS3iCpGhp2Z+Tg==
X-Gm-Gg: ASbGncvt3zU22vS332Y/62x7r/MQUn0dQm6yNapM0qoW/etaGOokBPhUB+O/ouvilro
	bvgKbiuwXe2ipnbVQXz80YsEA0r/cSPelR0V3g0LC5w2rlu0FjVD4WpJPwPy42n3hSqHcbk8=
X-Google-Smtp-Source: AGHT+IFl4CMUaxxoTAkD3ytGkNPTgdcXl7FHT5IGxpTES0qvo6U1WEtsDKa/o+LlYiHbMpSzEfndZl4dXRo18XfEkb8=
X-Received: by 2002:a05:622a:1e92:b0:467:6226:bfc1 with SMTP id
 d75a77b69052e-46fd0adcbeamr143067151cf.29.1738265483293; Thu, 30 Jan 2025
 11:31:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127044721.GD1977892@ZenIV> <Z5fAOpnFoXMgpCWb@lappy>
 <20250127173634.GF1977892@ZenIV> <Z5fyAPnvtNPPF5L3@lappy> <20250127213456.GH1977892@ZenIV>
 <20250127224059.GI1977892@ZenIV> <Z5gWQnUDMyE5sniC@lappy> <20250128002659.GJ1977892@ZenIV>
 <20250128003155.GK1977892@ZenIV> <20250130043707.GT1977892@ZenIV> <CAHk-=wjKkZBM6w+Kc+nufJVdnBzzXwPiNdzWieN3c7dEq9bMaQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjKkZBM6w+Kc+nufJVdnBzzXwPiNdzWieN3c7dEq9bMaQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 30 Jan 2025 20:31:12 +0100
X-Gm-Features: AWEUYZktgPbha6NuweUOoTEq2caO0ElwB8qKM3f-z5Cb9qH4_d_KA6x5j2Uvctk
Message-ID: <CAJfpegs+Lnp=zw1auUhVrahTg08RvK8eEFTK1R6jMfMAUNRg2Q@mail.gmail.com>
Subject: Re: [git pull] d_revalidate pile (v2)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Jan 2025 at 18:25, Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> So my resolution continues on that, and ends up with three in_args, like this:
>
>         args->in_numargs = 3;
>         fuse_set_zero_arg0(args);
>         args->in_args[1].size = name->len;
>         args->in_args[1].value = name->name;
>         args->in_args[2].size = 1;
>         args->in_args[2].value = "";
>
> which looks straightforward enough, but I have not tested this AT ALL.

Yes, this works fine.

Thanks,
Miklos

