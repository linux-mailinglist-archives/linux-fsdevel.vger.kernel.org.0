Return-Path: <linux-fsdevel+bounces-71374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC69CC05AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 01:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A67D73019B88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 00:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B1F23B61B;
	Tue, 16 Dec 2025 00:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lW4iq1F2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2820C1E1E12
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 00:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765845254; cv=none; b=cOjFLDnqj58w0bkKXMcBJF7eKY+VhoLZQ942hZw+IY+nPJGy7I0Kwq2yTfiee2BZPfGZsP0xIAWSo2kTML/KkIINx8WHuaLQfQhRJOIL4EdQmljxKGgCnw3qDKN38I/j26WI/0/xl7+Rf7cbI8Zr6F7p9DNQ+QM1jpE0bzcmMo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765845254; c=relaxed/simple;
	bh=527Ki6DG61yutNPw3iE5vYB3nLGpUwGz6BX2Mkg+X8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPqazxMk+IJBmCBo54hvIr7rzXHKGIZgtxOzDfIQ5g+GiZE0bOd+l/dJcbl/OdikrcywzScMRa4+pNZhIBig80O8Kezjs4jKDNeyALpUdIcMaCB6P956sPYqX5BTq8+gPcNiL+qP0dpyiUqYOlmBIxPKvv1IIq86XeqHVfdrAdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lW4iq1F2; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64472c71fc0so3556043d50.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 16:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765845252; x=1766450052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lF/Ed64PRuSu8RyJdfDoB9EbQSHWNT/BHtYaKlCLiao=;
        b=lW4iq1F2mUilqaSPQBycXnKlj8cCDmc9mbstCIdv1YT2NIGOZ+g9EZBgEyPMex82m0
         VgQEzRtp6NZXLZih9gETCQDF+Fa3GeDCONmK6tscxqx8QtBd9xw2+VqMvQk/MbZ+gCCp
         6ywHRUjtztiFO3+nxzMcuOU1mWGuvSK42uPmBHcJynv78r5KTOKbrS2oxFuxc/9EuNni
         ntRpnk918cBe8QUA29qxeG8nYXjLacoC7CHTuQKslrW8dplOMNm4YT1sRthrxtNc2itp
         Zdo5lnMuAoNvCyJGR66ZQk5Ri390EKGidONJrmzV5zCfR5pRzAg5zaauS8QrrnZW61oj
         bc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765845252; x=1766450052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lF/Ed64PRuSu8RyJdfDoB9EbQSHWNT/BHtYaKlCLiao=;
        b=uKl3mNUe5uCXqktqlw07uvuBnx3sLOwTGF4Vqpb/szwtuYivYqBMa/iQWE9x7J43Fp
         z6VbRB6YgDfNfWFnObmWiqr7JE89HbGP1neqIySzOhugEhG7jBcwCj/B2CcbSJ0m5PkE
         WorQwRaE9AEGHFlKB7nkPqps7sq9Z5hba7iEroRPGU2nHFOXGaM0vfRk2j9IWnPnyypR
         OkBEYBwFpjkgnZobUEd8onlCcdHw56GTH9y0raKv9EgmnpVfdZu1wkh3m7VAp92Lqo1C
         B2cMFrnTObbv+ioAjklHslA1dyZNi09Hx7+BD89bldS4U4BwK6D7LZHUYfTw2VPnpudX
         hFjA==
X-Forwarded-Encrypted: i=1; AJvYcCW+e82DI1L1jt7HerKgBebFaQDnNN9k5zO44BEg0gKW4uh10co+zdxrVq29p+S6Fvor5p1mFq9kq0+SZ2/T@vger.kernel.org
X-Gm-Message-State: AOJu0YyJgKn2W7SqNdam8oKKT0CNB4H9unYkKNBLDVva7IDawwNodr82
	Rzn7nZCp35WCBKsYrajG4UdknGBAzs6eoHueu7Di91Zl7GkOQbzQZZqvG6YFNvY57AlEv4o6cQi
	D6KWs98F+Uvd2HRNMgpOGlWpk5bXsO345/g==
X-Gm-Gg: AY/fxX7sSiOQ62WV/Jauu6DzECOH73c+LFhU446SeswifQ0zViAy7ZmcC1o0e+4zNY/
	RPF1pBe32YJ2AiIlNIqBNQZe50qo9pVpSPaPQuj19VQR96XEjkwFzvaljtcY4ctlMv9Ck1JMW5H
	VEFAmJ234kQ0DYmR1Qw4O8jBzd4f3HgAmViot/IsXi7OfrHH7fsV3Mi3AW+BvN/ICchSNURNzpY
	5tmjzAosSWEVJycbZa6/zV9hmpv8RTLGm2a6/vbaoGcx+SYwl97wx+pXJw+MqauBQuxFFN5
X-Google-Smtp-Source: AGHT+IHmBZysfgneKViKTEeYfivPpplY4LKDIFEiwX63GCxKWbRBeeC13S5RHIZoqmtHWOmmooT2kyyGkYJ7ULr9ves=
X-Received: by 2002:a05:690e:1348:b0:644:5c55:a817 with SMTP id
 956f58d0204a3-6455564eeb7mr9879964d50.61.1765845252018; Mon, 15 Dec 2025
 16:34:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212181254.59365-1-luis@igalia.com> <20251214170224.2574100-1-safinaskar@gmail.com>
 <87cy4g2bih.fsf@wotan.olymp>
In-Reply-To: <87cy4g2bih.fsf@wotan.olymp>
From: Askar Safin <safinaskar@gmail.com>
Date: Tue, 16 Dec 2025 03:33:36 +0300
X-Gm-Features: AQt7F2p8cHZTmFwqwPe2o06gHN83p4HgsaJygt-muB1Z6Idz4h3ESqOTuBH13D8
Message-ID: <CAPnZJGBtHf3p=R+0uxNuK42s5wteMi01Fs+0yhW3gUDMF0PC6w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/6] fuse: LOOKUP_HANDLE operation
To: Luis Henriques <luis@igalia.com>
Cc: amir73il@gmail.com, bschubert@ddn.com, djwong@kernel.org, 
	hbirthelmer@ddn.com, kchen@ddn.com, kernel-dev@igalia.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mharvey@jumptrading.com, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 3:08=E2=80=AFPM Luis Henriques <luis@igalia.com> wr=
ote:
> No, this won't fix that.  This patchset is just an attempt to be a step
> closer to be able to restart a FUSE server.  But other things will be
> needed (including changes in the user-space server).

So, fix for fuse+suspend is planned?

--
Askar Safin

