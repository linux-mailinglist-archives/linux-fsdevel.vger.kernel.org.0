Return-Path: <linux-fsdevel+bounces-69010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3BEC6B507
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 19:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E9744E4015
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 18:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CCA2DAFA7;
	Tue, 18 Nov 2025 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="CrVn3Dt9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE58A2D7387
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 18:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492200; cv=none; b=BZYq7ppboMALHTRL7OQKxuhPIEuz2oE+1+RM8o17Z8FF6y+qQX9bAyZnxtGrnerih5i42uPIHvW9K2Fv/l6+FGJsOUZAGLoXkzPJ2sHKV1D9sStL9nwX+LI9GMlJo3bbAXI9S43R03AfJKtwmLv7dUEHLqt3icA9EALpyz3Mzc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492200; c=relaxed/simple;
	bh=/6mugj1ODPkBaYn733+xAcFs0BvD1UbpGR3NFy/rsFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BcQOcmAzBAsEF8AtikBfrs1V7NL5nwP/y2nc7d1J+22jp19Hj4VzR+z6HejfwJuD2qsbq9OTOefhrrBSOITeBzsCynCrISTrFNGzCzytNik0rZ5Tyl/rsNUBDks/5Dtq3rXx6kO5FbuwwS8xaxXgbvPTZ2iWkrxElw2KQsNR/5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=CrVn3Dt9; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64175dfc338so10932190a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 10:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763492197; x=1764096997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWpkfHNeylofE0Z6h0WbHIO4zlaztsQ0FoG6F0S+GrU=;
        b=CrVn3Dt9FrLGgyXT66OGLjBSSCiXvZgEGByE7VEQHcXPCTxnCpa6y2/ZyUAmWCBwLu
         fj/Ov0PIgxDRJdN1ITHc6cnyVpk4GtLX3aQozo045IuFeH+VMcBPLOTEz3o2alTEc9u4
         VD9vyfxZYZgcVQnd4AdaZge6iPvCsvINgxW3CiW42jnhFeHgAsLyFiaxgOWLFLfBmW/t
         2QfrH/ea8DABTKDByzngKcHZZZ/65Nw3vAnsrOEE4IPm32uaKclXpg3nHYaibk1TQoLd
         u/67k/TDvxGibDzfRN6wFOUCf44ZXBx5LxCtH0Cm+SlMfg5+6L7Zj7Qz386u3FDRpQ9j
         6RPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763492197; x=1764096997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EWpkfHNeylofE0Z6h0WbHIO4zlaztsQ0FoG6F0S+GrU=;
        b=l5Q8A9Cmm4fJGLTa0ceDMcjRiiDs2sPXF/r7tkg7r4twnWHLg55wmK6vIFJPudJ0a2
         qOSI7yfc+O5xSrVymHFQUhkKott0mBnwu3My7R2DSLQ/n4HilktTfl64mhgR5Vnxdmbu
         EO4fa33BwjdOL1ZgO/Itn0957HctPTXRmRLW3+tClW6bXaad4VLnEJPiibDJ3jnSen7w
         hZUBiA2/GAnwtV4B5mPWi9qYeCLzyD8eVjN7CN4umh1wKmjW/7joAz7PLb4Sk0AgUIbo
         XEtJznxIjGRQ3IwFJCtUbTFNSAqAFyDzyqCl43QL24fNjmZKBGJsw1iSote698DK40OB
         sVUA==
X-Forwarded-Encrypted: i=1; AJvYcCWQJAa2gNLCFVuRMLn1eM01yCbg882QKZI+ySNzirYFlbECGxotVZyRyUmcQ9qZ9i4w4/xTvBE4o3hDHbbY@vger.kernel.org
X-Gm-Message-State: AOJu0YydA1X0wl5tM0Zd3RbnS++49mA5u7+bS4uWeNXdpExTfY/U5/Zk
	bPQ/pMmwwkFX2YRGs2vynjJjGGWB72e5gF4Oo7afg6dxIO2KgJ03d6LNNGTqjrySY6TBD+TCAJ7
	ShgEjcB4OEvUrrT6rbfzWzsTZUpFrPTCgK8cXU7Rd1Q==
X-Gm-Gg: ASbGncuoHDr1b8oGivJ66cFmm26RkYZ/4mgyLP+v7UP8aMB9CU6njnM1XSVBjptjifb
	J71HBCIXeFiM91ZtR62USL0zApcpWN8BG9dBAWvrGXAV/+WayzimKgbC3NndM1MJpdjAIZSFv2x
	1Y4h2K8SBXst5gFggA8ksNzmZulUO62RqUJxJyLhNa+HrTPzjHGbYc2nRNOgu+8tnjD5TYp6AkO
	N1HXrLcLMMgQcHRb9SJOsK395S1+IwHJqGsWChGbKrj3dP7luZdbCYH+9u1BNbxxmT0
X-Google-Smtp-Source: AGHT+IGgDybvpAfSTAM0QVtXWFCd8Zz0wmhZ1cAG/e31tljPdau5VCVWsoT0ybcXYQwiPkOov7XlapMJ2f8EsH3dOmU=
X-Received: by 2002:a05:6402:26c2:b0:643:e03:daed with SMTP id
 4fb4d7f45d1cf-64350e047b2mr14705623a12.1.1763492196993; Tue, 18 Nov 2025
 10:56:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-21-pasha.tatashin@soleen.com> <aRsDb-4bXFQ9Zmtu@kernel.org>
 <CA+CK2bCfPeY558f499JHKN7aekDzsxQkZJ9Uz4e+saR0qtXyfg@mail.gmail.com> <aRxY53gBbeH-6L0Y@kernel.org>
In-Reply-To: <aRxY53gBbeH-6L0Y@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 18 Nov 2025 13:56:00 -0500
X-Gm-Features: AWmQ_bmbYhd-e9mYzXSDDQXbPDAXR6c91g_2UNYAnLwXIGaKe1n58qU41N1HZlE
Message-ID: <CA+CK2bAc2p=_BJ=P-GJ5tNcxSHLckZP5iv+4bV0zrS-RVLH3Fg@mail.gmail.com>
Subject: Re: [PATCH v6 20/20] tests/liveupdate: Add in-kernel liveupdate test
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 6:31=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Mon, Nov 17, 2025 at 02:00:15PM -0500, Pasha Tatashin wrote:
> > > >  #endif /* _LINUX_LIVEUPDATE_ABI_LUO_H */
> > > > diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_f=
ile.c
> > > > index df337c9c4f21..9a531096bdb5 100644
> > > > --- a/kernel/liveupdate/luo_file.c
> > > > +++ b/kernel/liveupdate/luo_file.c
> > > > @@ -834,6 +834,8 @@ int liveupdate_register_file_handler(struct liv=
eupdate_file_handler *fh)
> > > >       INIT_LIST_HEAD(&fh->flb_list);
> > > >       list_add_tail(&fh->list, &luo_file_handler_list);
> > > >
> > > > +     liveupdate_test_register(fh);
> > > > +
> > >
> > > Why this cannot be called from the test?
> >
> > Because test does not have access to all file_handlers that are being
> > registered with LUO.
>
> Unless I'm missing something, an FLB users registers a file handlers and
> let's LUO know that it will need FLB. Why the test can't do the same?

The test needs to attach to every registered file handler because we
want to ensure that FLB scales and works correctly with any file
handler. For this in-kernel test, there is no need to create our own
file type or to drive it from userspace (where a user would create a
file of that type, preserve it with LUO, so FLB can be allocated and
checked. This in-kernel test is self-sufficient.

> > Pasha
>
> --
> Sincerely yours,
> Mike.

