Return-Path: <linux-fsdevel+bounces-58397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 994E0B2E14E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 17:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91CC3189ACE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 15:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B7F2C21C3;
	Wed, 20 Aug 2025 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FbpltdNE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A644182D2
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755703907; cv=none; b=t0/LPNG1KUo1pyGmNvn6PI7xFoLVv5yB6TUhPZ/ZK/kdXX+JAW7oVTqhLQoHGKleZF6uSpk1+W6ZS+SPvfdkUiPoPZ4unJNT3p1dKfP8Ytho6M79xkjFXKEMi/UDcmKrK7D62C8fyGlcgi7ck0MOVXfF5UabolSxVusutvgrAYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755703907; c=relaxed/simple;
	bh=AocFYfdVxdzjcLBZxLF6mkq2kPn8AKv3ZWf4tdyTOeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibyz2c6L0okpk2zyFKSzhdRmhdLUQkYFQI2Id179Cvs88eIhqyOIV53JuCT/Uv4jJcMdY/Kc97+9L1enpYMuk+/irrG9OQQVDOw73A839aLXJ99zqawur9yRDihfxLdvt7qIlG6jgH/41mPsAkik3KSMKY2Rxz6u/vdEzROLsPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FbpltdNE; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b1099192b0so591131cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 08:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755703904; x=1756308704; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xcJBgFKPQZsO3+QTwweAqcsrbYI6nQfbfPFo7nZBAhU=;
        b=FbpltdNEIxWBWB5DW5Pe6HoPXlqoeGXnlume0+/YVhPsVUj+t8byR/OUhjwDFYJoAS
         sPilKHLPjaZdItVQLpJVmZCTEH1lgVoK6uPMB0Z0TPyvcub+SXRRxfBwE/zyP/ziYvMC
         AvKIKIDYMca91mOb3UQFMDDCYotl7aU37jkio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755703904; x=1756308704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xcJBgFKPQZsO3+QTwweAqcsrbYI6nQfbfPFo7nZBAhU=;
        b=rU98F2Yv4AoGSC6RJsITIwnX3vvD/al2++DSLwXnUfL5wxayA2z4+14dRnFkETstwC
         7T0de3xpQQ9BBqyG3UuZsa8ZmPNzmjJkySdC5dfcpn3J5mcyQz5MZfGYD2AhbqySThBa
         z945olFVnWAY0L/1elMkNMke6BzWSPX3kjtt1hpG4yA8MhoNkl2tJaIQrsfviN9TUIDY
         Q7vBWlS3LFYubwrMnq5aeI9le5Q6iAnLN6dJm8UO9tQbUtXCT3pioB/s/HNF0UuvjTzS
         J5BaWOAkgBrysdgbxJNcSfI+NGHuGme8GUvyIP92BLQpHcWVDUg0lpasFw43SBHbJHzo
         R4nQ==
X-Gm-Message-State: AOJu0YzSOyRH987yFDrvRonvACI94JlPnoxjQZwsO+B9+8zZ4pDbIfSk
	wr/2S2zG2BGrgWvtYuH6zGjBRsVwzQr0b5grrCb+l9ZizTkF8EoZJ6hVPjzb9A2U1pdw0tEh1Jd
	CtzJ8t671q+6HggW1dvwEGDcahR1pmLtqfPxiNvHzjVOTZrZzgnaFSoI=
X-Gm-Gg: ASbGncuSYrqjjF0ycWSv1GXbYCPf/YcHuueMZMUN/NXKgN/SbZbupUTr1nxdrr6YqMQ
	/mvwp5s+JJ4AYaMUv6xnN1GHpvCHWH1/YcTAyZCJmcoD1miFPdMMtFLq5Bw+EYHZRfT1qpv1Cad
	AxPPL5pYP/HIpA/7E4xu+ly3u0ws+IBKsDBgqpQFp9dCZIo/V3XTDtdr4SbiSNu+xAwhLe4KkfA
	KmJNFLSHg==
X-Google-Smtp-Source: AGHT+IEuMM5u87H8F7qHuveN1ty/VhLc9lBHP5NH/DRG+CIyy0O71ORnNHkLMgC6Fj83J9Ncz1RofaO426HdXut4Q9Q=
X-Received: by 2002:a05:622a:1896:b0:4b1:233a:6eb9 with SMTP id
 d75a77b69052e-4b291b9e39dmr39519061cf.46.1755703903637; Wed, 20 Aug 2025
 08:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449542.710975.4026114067817403606.stgit@frogsfrogsfrogs>
 <CAJfpegvwGw_y1rXZtmMf_8xJ9S6D7OUeN7YK-RU5mSaOtMciqA@mail.gmail.com>
 <20250818200155.GA7942@frogsfrogsfrogs> <CAJfpegtC4Ry0FeZb_13DJuTWWezFuqR=B8s=Y7GogLLj-=k4Sg@mail.gmail.com>
 <20250819225127.GI7981@frogsfrogsfrogs> <CAJfpegt38osEYbDYUP64+qY5j_y9EZBeYFixHgc=TDn=2n7D4w@mail.gmail.com>
 <CAJfpegv4RJqpFC0K5SVi6vhTMGpxrd672qbPE4zbe0nO-=2SqQ@mail.gmail.com> <20250820151619.GL7981@frogsfrogsfrogs>
In-Reply-To: <20250820151619.GL7981@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 20 Aug 2025 17:31:31 +0200
X-Gm-Features: Ac12FXzFnXIM3zQfATJFdXcyg6OaNIi1srA6MV9jX2uP2PjLlif7p9u0ci01_i8
Message-ID: <CAJfpegsPZMnk-0_MrRVtSo_o-Ywi4fC4sExe36APJsRt_TvvQA@mail.gmail.com>
Subject: Re: [PATCH 4/7] fuse: implement file attributes mask for statx
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net, 
	bernd@bsbernd.com, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Aug 2025 at 17:16, Darrick J. Wong <djwong@kernel.org> wrote:

> How does one add a new field to struct fuse_init_out without breaking
> old libfuse / fuse servers which still have the old fuse_init_out?

There's currently 22 bytes unused at the end, so it's easy unless you
want to add more.

Ideally there should also be a matching feature flag indicating that
a) kernel supports this feature b) field contains valid data.

> AFAICT, fuse_send_init sets out_argvar, so fuse_copy_out_args will
> handle a short reply from old libfuse.  But a new libfuse running on an
> old kernel can't send the kernel what it will think is an oversized
> init reply, right?
>
> So I think we end up having to declare a new flags bit for struct
> fuse_init_in, and the kernel sets the bit unconditionally.  libfuse
> sends the larger fuse_init_out reply if the new flag bit is set, or the
> old size if it isn't.  Does that sound correct?

I think that's exactly what the previous size extension did
(FUSE_INIT_EXT flag).

Thanks,
Miklos

