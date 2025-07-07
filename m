Return-Path: <linux-fsdevel+bounces-54160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157F2AFBA69
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 20:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B8D77A36DE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 18:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC882641F9;
	Mon,  7 Jul 2025 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="fjy2trOS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDA1262FD5
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911918; cv=none; b=osWw99TeuzPxibNpEfZSVu8hEcg/TlbYb7A7OLOCXk7/wth9e/IrIQX75kWmCQWUT6h3ZrYj7K3q2N5xc5p7ztQahf8OwGSSB5iSPS1UeoftSYd92Vg9DxAJrELTkFhalz68tPpAohLsYRuXC1Dz/Pj9mfkoqnOpKb8gaV36k4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911918; c=relaxed/simple;
	bh=FeelGp03cD6nLu/ebjrQ7bTkW6++SjPk99pll2SXrOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSVcaJXI7S/NlvBu8Ka5bfOVUnd8FgchfMnFSydFunN9QlI0aI1ayfgMP9ajorQ7b7lSrL4hAvrqdcS1P/Ax4UpvNkleBcVeJ/am4HrSLl9FEndvunAj4sEG0WsEQC80GjW9nTBzhewKR1DClKtu8JZ261Dpt0/E2gcbTaxvZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=fjy2trOS; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo5675617a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 11:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1751911915; x=1752516715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeelGp03cD6nLu/ebjrQ7bTkW6++SjPk99pll2SXrOU=;
        b=fjy2trOSvSdioE6gvXfAjOsWeKh4iZVp2tyhGQzz3YBmnT0sgzj0Lc9EVX96ypJyA+
         4hBda97eFh1814NUIkID8HAI3nrJB/mRlqtX4aXcvwEcDrGVqFO5CL991DZvO6Dmp8jj
         1pqDCTsM+IVwP2eN8FOLy3WGQ4tWuumGdyxc8jDk7s4qW/0tos52gxzeO0h2cn75OA40
         nHna2VRY1UeOwuM8jYciRbfZdJl/PdcYJvi86TjAisXIE5vSubk+BJU85SlStFJVYioq
         zbyWPegH8mDxFvlmVKZnyc0OMRd4hZr4ikLLPAaDEpUgY22e5Xwm4AAQ7Rb9V1+P+Ojr
         g4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751911915; x=1752516715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FeelGp03cD6nLu/ebjrQ7bTkW6++SjPk99pll2SXrOU=;
        b=AR1HdmhSfBubzNtDyUVLQUJYXhFjwDdnrxjMfGt5LxzxVX07rDZhCsXl/ZxH0TLZBh
         oOZ4TPX/okktcp8odZ6wrnBl7Ki29IlDHBeOHdYeV7oEHZLauOYnEAlkjvNGobLingA+
         3h5XwPjS1B+DaWHW4wzlfqQQcK9pSn9wOzb5HmcThAAh5eNyvF9XItR3p9hOZCrLhfqv
         Xa47Et1GZFC5ABo02Vz4eCtnhd3e9vHJeio+QPrMaSDbPYPvOcBDpuvDn7srXHYDi3/7
         sQ+TPm0h5THOX44Rvwf2BiP+H4Kqz1le5ewOx2sWmp54kjuNpCx729g8ON6ern20Ou9B
         0+ew==
X-Gm-Message-State: AOJu0YwODn9oz95WXTTUuVa4gDXOv9laMyUa6D0VBswFgWmQw8uHOUXq
	R7KD4hGx16PVA1PTortXpTQb1fAPfTiOXDBngLpdiZCgJvznR/ZLs2iFreIweldIEvGD9ObMOGf
	whR78r1IjHP4FoGjP2tOA76DGU5u58Vdm5oRVwCEjXdnv04mluCYl
X-Gm-Gg: ASbGncve3X+baSg3686Tjr2js4HtJ4aOhpPizGopKrstl0GXP2cjn3u29MAqS/asAoA
	sDqnVY/5BrbQjb84pWZhZtEE7qJfA4bM+RNf4zLTPb7UNojzbGiaIKBZaz9oneF7B/vvEeHTQF1
	1RQ4c2nEaF6fh43eRnhSjY2mSN8tcsfez7+4kbjMordxP3JUqC1PsempizqRBPFKis9+7zCgg=
X-Google-Smtp-Source: AGHT+IEZrzrTgSciHz2HqpKMsXdqz6wjFZtv8s3b3A3lB+TjADzu/8zqD3hp7DHb3vKX3ijtpaXqg7Tdj61r1dHnlAU=
X-Received: by 2002:a17:907:7290:b0:ae3:f524:bd2 with SMTP id
 a640c23a62f3a-ae3fe64e7b4mr1172327466b.10.1751911914757; Mon, 07 Jul 2025
 11:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124060200.GR38156@ZenIV> <20231124060422.576198-1-viro@zeniv.linux.org.uk>
 <20231124060422.576198-20-viro@zeniv.linux.org.uk> <CAKPOu+_Ktbp5OMZv77UfLRyRaqmK1kUpNHNd1C=J9ihvjWLDZg@mail.gmail.com>
 <20250707172956.GF1880847@ZenIV> <CAKPOu+87UytVk_7S4L-y9We710j4Gh8HcacffwG99xUA5eGh7A@mail.gmail.com>
 <20250707180026.GG1880847@ZenIV>
In-Reply-To: <20250707180026.GG1880847@ZenIV>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 7 Jul 2025 20:11:43 +0200
X-Gm-Features: Ac12FXz6qldypWeq_Bn-GGOukpKg9f4xiRwm8xS7LHIlbt3qzKLA3vBlj5r4ti0
Message-ID: <CAKPOu+-QzSzUw4q18FsZFR74OJp90rs9X08gDxWnsphfwfwxoQ@mail.gmail.com>
Subject: Re: [PATCH v3 20/21] __dentry_kill(): new locking scheme
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 8:00=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
> Well, it tries to evict all non-busy dentries, along with the ones that
> are only busy due to (non-busy) children, etc.

But why did you add code that keeps looping if a dead/killed dentry
was found, even though there is no code to do anything with such a
dentry?

