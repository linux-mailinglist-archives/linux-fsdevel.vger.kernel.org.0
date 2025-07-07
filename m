Return-Path: <linux-fsdevel+bounces-54155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ABAAFBA12
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 19:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1191818907C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 17:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B3A2E7F1E;
	Mon,  7 Jul 2025 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ZZ6vvviz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C90188006
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751910246; cv=none; b=fSjpJ4xaKvXLryD2tUhYEpUYC/vusR0unmOjynwc7PkbO/nsTzdhsmBMGr8mlMEfudZfr1sF8Br5RNtBgSEz4Fv3oaGuzHC0GnOTcPvkPuldiKU2LOvgHjl4gbwrgpzXXdXK9tw7FlQBmyxgVXpLPtebvLRnPcv9h42TowaVL2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751910246; c=relaxed/simple;
	bh=o/HDZs7XPt+q8MHWK8dAkhY3tq2nEc40nkWYVoPA6DA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4HcFywFrNJduGmLL1KNP24pM0IswaRwubWBFB0L1ZPY7hO0X5D3eKF+peo6kSO+6vyEpRgPjv3KV4d0ofn07hYfCHMXoZDXO80FYewmqMpOkbJBkUXyvir31QL1VloSwsf5hZ3KzcdqB7nWUJE72tNvSeNC9LsMFcn5Y43Rdas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ZZ6vvviz; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0c571f137so662907966b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 10:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1751910243; x=1752515043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6DAOBmHCUHaxqHYSRkMxeN53Fncoy3XLXn7MalUFJo=;
        b=ZZ6vvvizpt2uudiiQ4A8FKN+MD6qjVHiHj2geugqLmwv7eUdXLVW+taMGCKrQgAv79
         X+TIIgMNqkqK1ovNQXpkBqwoLPWCUouJU7EMnhclpTZWXp8OR3fwH9yNOejdCdraW9tG
         L77KqudpEWo5Xbr16CYOcevyVG12ppMTbmyxfOoeXr8n2NFAQcyjxRmAfc75GxdXFe03
         ZW/KKdF6gWPTwFZKCUm2AYUj2P0GMfztOiNQaD/0iOlQYWKN2ToQ87CwV0490E0bc1hr
         jKoWF3RciHSPd2/hPzVqkgtW85076x8LFu9s6pFmXhpGVIwi0ecJ27+VDJLncuQw7KKO
         Fv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751910243; x=1752515043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6DAOBmHCUHaxqHYSRkMxeN53Fncoy3XLXn7MalUFJo=;
        b=WJm48j/zojUCONQ+WChq6P7ylbxHrvr1KXkgcbt2AVfE5saDq8H4GKGqcQZqtXvqua
         ym10fEN0SO2tGMQlV4cYy8N11jq5volVxOZSFBTlUNsyIlLemtYzZjfiDkiyzmGkPKLC
         21h9sStv4yXHl9XBs4DSKGiKfc4iwUkMQng5HE43k4LEe/Kb5NxljlX9MrYtSJrhUlty
         tJHxG2tccRE5DzJ0W9bSqetSimgvtKEf2EMeC54u+7p9XSgo8mHK8ZapILjGKlDZpN/S
         AiK7wMDsB9hzzix1Kfkl92hfs+EDHB4zl9ZCpjpxpeEnxLz+T7hj93wfj28R4w7yMbEl
         W4cg==
X-Gm-Message-State: AOJu0YwMtawD5HPelHPwdrYawkeMPM7mPtRX8/BAcLwSqLTD2Z/nNREj
	60rtEsHipeKKfUbHlXRwta7WYVKlcWej1MhSqntMQ9DUV8TAyWBOr8UJligENpfl0E+L3QkTixA
	dfSyRHlJrMNoU9eEm2Hdei7G2qvQCtg4MU46fZh3Aw8TiXYYIQDZHvrA=
X-Gm-Gg: ASbGncv57vY1Am0kbOGsLqlLuwVVTYo8Z/hPta9oD98nOIN4Wx2DrC0xoGs5H9UpTHe
	mgRj5ZYXXDgWqnrsKG7n7Cf+SG2oLLK3OXeSaYYfWisgBlhAFsFlsjBERhvsI0BKvdzBKndwFBD
	t3FCWn4D8yHyCc142wdHa7Pd0wurPtMz7Aa/58FYdVvXqDANHhj5ypmG3bJniFO30TERoP4Rfyb
	3/zQZEIng==
X-Google-Smtp-Source: AGHT+IHansgZkeOlieDK57LFfjlu4rcmUxtW3lZTuC3Ur35sXnZg9qWS5gVNMrBeeSWLdaOlkpMIsGFOiNHbh9ej7Mc=
X-Received: by 2002:a17:907:3c8e:b0:ae0:da2f:dcf3 with SMTP id
 a640c23a62f3a-ae6b02bf79cmr7436366b.59.1751910242854; Mon, 07 Jul 2025
 10:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124060200.GR38156@ZenIV> <20231124060422.576198-1-viro@zeniv.linux.org.uk>
 <20231124060422.576198-20-viro@zeniv.linux.org.uk> <CAKPOu+_Ktbp5OMZv77UfLRyRaqmK1kUpNHNd1C=J9ihvjWLDZg@mail.gmail.com>
 <20250707172956.GF1880847@ZenIV>
In-Reply-To: <20250707172956.GF1880847@ZenIV>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 7 Jul 2025 19:43:49 +0200
X-Gm-Features: Ac12FXwa1m6lh5O0rYtmshnvYFRpOLMyvh-XRnRfNKbXLatxwTMpJYQvwe0IrE8
Message-ID: <CAKPOu+87UytVk_7S4L-y9We710j4Gh8HcacffwG99xUA5eGh7A@mail.gmail.com>
Subject: Re: [PATCH v3 20/21] __dentry_kill(): new locking scheme
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 7:29=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
> > (It checks for "dead" or "killed" entries, but why aren't you using
> > __lockref_is_dead() here?)
>
> What's the difference?  It checks for dentries currently still going thro=
ugh
> ->d_prune()/->d_iput()/->d_release().

Just clarity. There exists a function and using it would make clearer
what you're really checking for.

> What are you using shrink_dcache_parent() for?

I don't. It's called by Ceph code, i.e. send_mds_reconnect(). A broken
Ceph-MDS connection apparently triggered this busy loop.

(I'm not a Ceph developer. I just care for the monthly Ceph regression
that breaks all of our web servers on each and every Linux kernel
update. Sad story. However, the Ceph bug I'm really hunting is
unrelated to this dcache busy loop.)

Max

