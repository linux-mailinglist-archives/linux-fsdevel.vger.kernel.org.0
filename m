Return-Path: <linux-fsdevel+bounces-62264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC7FB8B663
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 23:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4363587079
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 21:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B198B1BEF7E;
	Fri, 19 Sep 2025 21:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eW70eqBq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25A21917ED
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 21:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758318586; cv=none; b=U613quJy5nwJQ+fuuvFzd58XVloPJ0p0RqqLxcaxRQuPPOZCq2W+IK7mTL2y47RJ5cOY5YY0FX548hl1ijDL64u+fS2hob30pkV+x6wd/4lW1i1EPBL4Ed3qhnCpn4AW1+MG043lSAF3bzkCC4VVy7YRR8KkE07+Tt28FWGHImU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758318586; c=relaxed/simple;
	bh=0aQcHZJWQQeW9yo8hR1nNAM5CRX7BlGY3LIdgSKSlYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bo75Y6kSEKloTvt3mBqkCwX4qZ1opaJ5DSS5mD1xdsDk6DFzyzy8v8T8aDxSdgHMChKk9dxLiMrlMPnRQhcN8suX4un5sTxRsMshv4KXQb6Twyc8HNAh9z1pymPDYexXLAmGl5cudQOImhIMENaHL9Vvngh0yj5JBgjd4zLKUgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eW70eqBq; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-827906ef3aeso235683785a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 14:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758318583; x=1758923383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtG2V3rhaxoUutbvI8N61mAeUd2OHMQkInuGPq642ME=;
        b=eW70eqBqg057Ax/4qvFpDyeiQIUy7/3f1+l1HF2oNLdxtWlLXACa3t6taje+YUzUeb
         rZubD8NaXZ9MDnpOiHAuco0cQuN8khZXWvc/PSpMmyh9einlmjDq4CFRCfmDGyh+qz46
         4sPvmQiP7E9pT417JrUTcCqT9IZBOhqdq2lrxJDEHk0Dqw9nMpf4X1qMNYU2FzskVMUM
         uVnHIEVg3zPoFGz4JW6awFlPF+w9rY7GKTCdByA055rxfYhhuiQxpotpY5Rjnp8gFd0N
         fkBM/+SeUWiWc+mNJr99WTbHo2DMga3suSKabq7rYc+xweK3fxCHMqILkYe6fD4akREv
         yCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758318583; x=1758923383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtG2V3rhaxoUutbvI8N61mAeUd2OHMQkInuGPq642ME=;
        b=vik6VKjuWbepy8X4bIznVQHxJUb6fuuTG3ss+SOQ/49jDlC4W7ygWSr30cgA1ISTAD
         3v0crw24jgVYYSX4gS2hBRPbv+F6OyFATowew2NIc7oETCFQ5/WnqwFeawzWhIhzvgVr
         EDKjT05yXuTinV6tXEKwvi3qJaJ6owGMeslvMMimAYuZBWvueYkfznM9Q35BeQiS+fE3
         ek9xqnMzRMuNRZ8xV+vIdSHgNcmoZv8TffjfmfAvrUnPeDnZwJ/BEG2IXyXtESdy9KE+
         GY3vFgeXol8hPHX//maB+IdmYjFcPM3GcMijVm3a0GXVDnQ5BrsWDsze4mBN2UvYvTGc
         JUOw==
X-Forwarded-Encrypted: i=1; AJvYcCVAF/YBIObPAhTPUmV6EOBH0/WgcXrLKoliikJqJ6OZV8SHtCQR1t3+mqIjdtLfptjMY6/fp8rJATdiD7hM@vger.kernel.org
X-Gm-Message-State: AOJu0YzlLS9AdgoKMlktnXuchPs+hk6etVO/Rm3/Z+a+V8W6A/94x5W3
	KngWapzDq7o8bF36dInzHhqtndAsUyYgzEtin8Fb+QsUfEF8dEtQk+aZpJl4CaH+kA7HTtHlBpp
	hzhjGMur3fL2delcGtdN+fqoS9Mtf614=
X-Gm-Gg: ASbGncvwYsUZCb30EwhJKm1ssZX2r+HKBXhDEM/1tlrBAdaM1mznl2qjmgvDApWPEVU
	+JAdvNsjCKNz8uHQ9fe3OfUICiRk02DRmZZICzz9i2USscojYohJUPDBNOrZLqAMrv4x9tSPsSK
	K0qBVTVGwSnnS6GMySAkqMc9BYjPHXh2DapWjTw55QSBMgoMj/jNaZllhUmTy+TwzzY3u0SS8Dj
	v1repEogLjA2eacAAmoJ0pblPQN5TtZzbxgY83m
X-Google-Smtp-Source: AGHT+IEm3+pgmfyT4o85Djdp2zQ805Ehj3RXRTIuTklmNqY2JIj84bnLQG+QxbIr6wwLAP4mnvcoxqR7ANMHMFrlgAQ=
X-Received: by 2002:a05:620a:8391:b0:82a:169b:8636 with SMTP id
 af79cd13be357-83ba187e5e0mr540365785a.12.1758318583541; Fri, 19 Sep 2025
 14:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919214250.4144807-1-joannelkoong@gmail.com>
In-Reply-To: <20250919214250.4144807-1-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 19 Sep 2025 14:49:31 -0700
X-Gm-Features: AS18NWDFz4f3xchf2YtQIVwv-EzmZ65ti4tBBqzDDm21ir0FEHzna5-UmfHnvk0
Message-ID: <CAJnrk1aJf1cgpzmDz0d+8K5gOFBpk5whqPRFsWtQ0M3dpOOJ2Q@mail.gmail.com>
Subject: Re: [PATCH v2] iomap: simplify iomap_iter_advance()
To: brauner@kernel.org
Cc: bfoster@redhat.com, hch@infradead.org, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 2:44=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Most callers of iomap_iter_advance() do not need the remaining length
> returned. Get rid of the extra iomap_length() call that
> iomap_iter_advance() does.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/dax.c               | 30 ++++++++++++------------------
>  fs/iomap/buffered-io.c | 18 +++++++++---------
>  fs/iomap/direct-io.c   |  6 +++---
>  fs/iomap/iter.c        | 14 +++++---------
>  fs/iomap/seek.c        |  8 ++++----
>  include/linux/iomap.h  |  6 ++----
>  6 files changed, 35 insertions(+), 47 deletions(-)
>

v1: https://lore.kernel.org/linux-fsdevel/20250917004001.2602922-1-joannelk=
oong@gmail.com/
Changes between v1 -> v2:
* Add Brian's suggestion setting "length =3D iomap_length(iter)" in the
do while loop tails

