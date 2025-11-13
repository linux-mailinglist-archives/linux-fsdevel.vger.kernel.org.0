Return-Path: <linux-fsdevel+bounces-68283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC38C581A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A57D4E35AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 15:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652212DC338;
	Thu, 13 Nov 2025 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAxpsHAi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C822DCF69
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046008; cv=none; b=nHTSfnK8o4ofULOmQzCS+VHMOEnL9DraYlycyCTPVreAyPyWyae/dVd1bk30k3XhEcGym1UPamKzvMDNUYHdBxcc05hhQLipaglmofr1U7AXJQ+uZBEuJRAagBYKv7mMtOJVcYznvlxAPS4OevX9CLYH19XZLisikmmprM8NTY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046008; c=relaxed/simple;
	bh=O/yCT7PlPSFi+823nhk2sKmN9yyj5JOnUSuTqphJE/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKbxdNsdGq/ZfjjrJyUuAt1SvGBdCgIpelGBM0eoEN8S/+vbNJEtPlqYlszwCWnV5S1Kzm19yifztRydcn+ZTk6virXHPP51LhKLv23Um3Yt66cjpYOKl4OxVwKrLPAQqb31dsgI5irN/s2E3iT0qWaAL/59vcrW6T6CWokxF34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAxpsHAi; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640a503fbe8so1565137a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 07:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763046005; x=1763650805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/yCT7PlPSFi+823nhk2sKmN9yyj5JOnUSuTqphJE/I=;
        b=iAxpsHAin1M98Rd5jXgyyAd8ikNqjHHPehBjtF/dggU4Bd5OBt581GClGCcuwp6PHe
         AIzgmAv9SLMCkOoEWsK+vLUh6prLhzeHGQKEu8tNgDB+2CrrUFzP3zljnofB4sY3kCcx
         IUXc2lAbkmTxkMrUHbep5G5UkXt1Ek65HRvmBXknUUoVIQn1PEw75/nWIIFJqmPnH7VC
         RIMzh+8DEvz0V8+nqIJsaYIp3/uDT30ByHvJXFUBZrnsBjhqP9exKY1HkiIvCl4Xh6fQ
         iw50HfdA27ktmNMeYTQp1U89laDh7cbb+MTvg2+fpNCrzcKrvZxMH3ZEjyMQu+y1lefh
         Jmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763046005; x=1763650805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O/yCT7PlPSFi+823nhk2sKmN9yyj5JOnUSuTqphJE/I=;
        b=fVXmOjLuGp4Nwx7CjBrhR+AA2P4mlp8qxnudRf5vbjLyE4hyTxHl0bKLB41C4Qxh+I
         n78F1xBTGMNuB4Rx1KRX0o5108UsZM8ssuF3TkpcapG/ckXYulNGJr+w2fCVxV7SxOyb
         OXBRbVjBhX9ZfBZytG6JsdfYl/HqgckTlqIkZuKRgn3fKe2wRYBOljRMu369/3r/5QKl
         YttFAokCsubYl6TQSGu6e6k72G+FrPdLRGL1p+FNOfG76bEhQiIDfYawnuP2TITP02TI
         c+PsaqSigXnSp+oz4CL+FLFIrwGfQEmUdHZidpRLsH4Hb04MYi8tf5b01Ipwy2Vcd3ZN
         wTwg==
X-Forwarded-Encrypted: i=1; AJvYcCUQIsL8m5q9gkC1seCoAke+Tww7Co+kKa+s/TAOIwJFjYQb0z5xe7AvBwR0HkGZByluj5bRAnTa/ZqGeoyA@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8KETfXGa60DSJ4Yr8m7Pc1DjrKM1Dfk3dX+ew7N1HpZPDmHV1
	yAhYiHJoYl5s4DkN/hOT4UIddCaAOxbFo5x+YwfHDvDDSBBTCYpkWhWGtE0A6nBxRdz60nzJOfH
	zU/Epr4qo8UDM/DMpYVmlGY6c0Ie+GLA=
X-Gm-Gg: ASbGncvnyLwV2HRpumzijljCraW2IceQ/2I4FBcIVa78ecBV8fGXbPezYJ+87juhuQr
	xlEhzq/FCD3xsEZ7XvIPcjE9GRVdkwuxd/DbdAGnwagv8JPtmrPA1xCh42KGhGpKY2SJKucvBx9
	yKGdf7b/L7+OH5b/m/wCH2o0sleoaHBksoSwyxVw4rTQBD/P0rU2FDA7mk9qOTxIqVVjl+uMGym
	/eu8BuybCfg7rsm7oHwvomaSuFEnDJzAw7+zIXyXy9YnIITW5HiLc56I3W6wmxMbI8Eq9L9z49k
	kv4KacjbAMGODvapWIo=
X-Google-Smtp-Source: AGHT+IEDnnrdyjK2JdHgeBEZ5BnpsnIko9j1ObXf9NNoM+/cKdcKVuz+jY+fl+ySjZunGU4KLJ2MUywEqhqb58AcRWE=
X-Received: by 2002:a05:6402:5350:20b0:63c:3c63:75ed with SMTP id
 4fb4d7f45d1cf-6431a55e44amr5574505a12.22.1763046005246; Thu, 13 Nov 2025
 07:00:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 13 Nov 2025 15:59:54 +0100
X-Gm-Features: AWmQ_blxDDO7DcV-76HHqY6hmEjNFx9_5jUOH2XhLsxh9hm-3Edqln8C5IadzHQ
Message-ID: <CAOQ4uxhUMC0+wy1oVKfemy-ia8tAbWe7rezdFy8MH3eB_4C5ng@mail.gmail.com>
Subject: Re: [PATCH RFC 00/42] ovl: convert to cred guard
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 2:02=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> This adds a overlayfs extension of the cred guard infrastructure I
> introduced. This allows all of overlayfs to be ported to cred guards.
> I refactored a few functions to reduce the scope of the credguard. I
> think this is pretty beneficial as it's visually very easy to grasp the
> scope in one go. Lightly tested.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---

All reviewed now.
Only minor issues found and one ovl_iterate() refactoring patch suggested.

Feel free to remove RFC and add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

after addressing the minor review comments.

pls provide a branch for testing.

Thanks a lot for doing this work!!
Amir.

