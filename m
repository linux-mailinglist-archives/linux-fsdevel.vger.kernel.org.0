Return-Path: <linux-fsdevel+bounces-24623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC1F941A86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 18:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 020B7B244F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 16:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61DB189913;
	Tue, 30 Jul 2024 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="QnvKyE+P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778BE189535
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357101; cv=none; b=UHG62t+fHZz2Q0h1MqwGGKDDqEh3AX+VFlSj7jIje4ymGAhLw7fCyHLMkMJyT96YYHEH2RVleTTKhuC9KcQ6SGurzXWlg/uTjlfWQgAYUQdx6SyrtDUrwm7XhTEZGcN/sNLXOInrgJWBwgYtDwtHD1LB+uMENCL/5fIiJybB1+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357101; c=relaxed/simple;
	bh=nyrerJDyhxrjVhddkZkyuAsVrv4YgfVF935QAWq/eAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZXD7oL0GzovbxS/AFWEsgiDqhrWgUdff4TzmQRO6X5TZ+DFe1rwAXeJtsNRaTvBTD4MeyME32uln02JAqUfrrX70mkDbWK6ZI8Sbr7YFcGDbwvWd4WTeFIgMlPuQiIl5I1/kR7GpfYTUKx1kzPwQxkC9AdJ2ecQBw8vsqmr48Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=QnvKyE+P; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7ac449a0e6so374317866b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 09:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1722357097; x=1722961897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5cj6IhKT08G/JY9sA9ZAZBlaQGsxU+ED4GyGLcLHJ8=;
        b=QnvKyE+P7ei24VE0NqPYK3qsHjeemZi0qale+y13a3WGNC/yFv3GBiAmw0By4yXeLq
         chDpI2yu/44/lcwrtidEjFufcEWGYJlHMshTqSW9i6rgwXCrlWRB7w+MqhXKUCBB7Jc4
         ltl1mSZgefuYvaX2j2xHBm9uvuMmqtYKVN/AcQuFqfmKs6iHzP7NFfMf2vjcD8XRM5Yp
         9QnlC+TWA8R5mp46TPJvZpkYKEKcYXk2GSE5lyf3ICAG1tX6Rje3bqXUDzC1SmGjL4E3
         lAohMo5bN7gi1XmciGbR2jjmW2w2u5sKJJB2ilmSYAGdEWxazHWfKAyr95t+bDoTfTXn
         TERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722357097; x=1722961897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5cj6IhKT08G/JY9sA9ZAZBlaQGsxU+ED4GyGLcLHJ8=;
        b=Gcce//AxlQdy3j/EHOkzN2pZcDfWGJIpM5/RyS60adrFFBzjS2GIfrEfcjVgGnMuQI
         2spl3xXaKhWeHZmfg/XNRRRcTXry1DizkWdIaOchuqn7FeYUa7du/kOBA2dwSiPPxjY2
         7P9JDqFOu8kEeNIIL4qiMq0s/eq56u9ZV9bxj1/7JdLyRF/9jRTibLxP0g8H+E1XPyHa
         dVPbuICbiz0tr752w6yoYZeQC4czdRsWc6/QcUoMRPt092BOrsUf4gTQaS8RtpNFHFCD
         G+9vwHbaLOyHLh021FcXDiJPI0KL1+OkgYkL5XVaab2SGKpmGBPbxGdIifKZo2cZv+47
         A1vw==
X-Forwarded-Encrypted: i=1; AJvYcCVK9Ip/qPaHtPVAlIEhzKIKU+8cT8V5Dq8eofnDcJhoA5+Zmatft54GYuFsYmCsjfBG3GHlzyuarO1ACwB9qaU1DIde56jayaROIKCy7w==
X-Gm-Message-State: AOJu0YwLmeeNRkvHm3RPypXWaPZrsr9R5/WnMpw0f3SdVFrpOtgxMh5+
	kONX2drbeziVb4CNTKBhh7/iKTzlVK7ErY35ZG5nAk+3/bsQy0cmj2hDvTPf0htL0goTaD4AR7/
	b9u0ZTDODtOvRL5VuT8rTxe0am15Y9DJj/+AL3A==
X-Google-Smtp-Source: AGHT+IH7khnXrujEv1gKQnGzEfjEWyF4QEf2ukDbjiCueUR6RcV66FHsXp7NckoSkFnWoeFBMNqlnHILehdexStSq60=
X-Received: by 2002:a17:907:7284:b0:a77:dd1c:6273 with SMTP id
 a640c23a62f3a-a7d3ff7cb6fmr795199266b.12.1722357096904; Tue, 30 Jul 2024
 09:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729092828.857383-1-max.kellermann@ionos.com> <20240730-bogen-absuchen-8ab2d9ba0406@brauner>
In-Reply-To: <20240730-bogen-absuchen-8ab2d9ba0406@brauner>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 30 Jul 2024 18:31:26 +0200
Message-ID: <CAKPOu+9DPbtpDOtmLf=kSvK8Vw7OQfET4-Tn6bHAcXe90HFpKg@mail.gmail.com>
Subject: Re: [PATCH v2] fs/netfs/fscache_io: remove the obsolete
 "using_pgpriv2" flag
To: Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, jlayton@kernel.org, willy@infradead.org, 
	linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 2:30=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.fixes
>
> [1/1] fs/netfs/fscache_io: remove the obsolete "using_pgpriv2" flag
>       https://git.kernel.org/vfs/vfs/c/f7244a2b1d4c

Hi Christian,

thanks, but this patch turned out to be bad; see
https://lore.kernel.org/linux-fsdevel/3575457.1722355300@warthog.procyon.or=
g.uk/
for a better candidate. I guess David will post it for merging soon.
Please revert mine.

Max

