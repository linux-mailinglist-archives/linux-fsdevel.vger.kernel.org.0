Return-Path: <linux-fsdevel+bounces-55885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B9BB0F81C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 18:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F087AC3F1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 16:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8B71F3FF8;
	Wed, 23 Jul 2025 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX5hZ1DM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCAF1F3B85;
	Wed, 23 Jul 2025 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288078; cv=none; b=glDzNn5aEno3rL2m+LzqOfV8pe64TJvs5UmcHbupl4HTZ1mRk6rHaPGrioAAwHGi8FfO2+RiFj3TTTLPqWWs9UJZN0wEkYuLteuxp06rIhW7quQK7b/qxxlPHlkXkfYENpSjsCDsygP30lW5F0LHBhmcgRSch1A+4+zoyx0oQmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288078; c=relaxed/simple;
	bh=iSX5a+3YqWRfEq9O3P3EgqeNWOcjvV7RTWJigTAIeGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiK7CyNPiwYuPO+aBic62FlyIBFTLKKVldkJetYEy5k7zGjwInTVnz3oW9IuuEUqMBlAJSR2jA670IH08O+Q8n59i69kdsf3UnsJjAWcJzSrsD8SCUCYcpIlzhfCtkUlX4aF4d+tOGjpebgJiXJaIi9JLLV9W06WgOxDDDCZbNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gX5hZ1DM; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0dffaa8b2so4134866b.0;
        Wed, 23 Jul 2025 09:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753288075; x=1753892875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSX5a+3YqWRfEq9O3P3EgqeNWOcjvV7RTWJigTAIeGM=;
        b=gX5hZ1DMI3OlcllI/dHu0yxmqIk235eMJghcYI70StuL4KBl07iTrn52HsZkXaV5wj
         BbBU/W8Fb4aym9xtGPUrLFVvN8+fbk/fiDDxNjpTmdARuRsYrqALYYjbnOIEEkLgLYCN
         fLBVqEtqGAGP5hLC0PwkixZ+M7B0e2XChfQr7eFAMIs1iKoR1cyJn+z7hY/J+tFvDSl1
         4Gdg+15G3PFMmsYyWJ+S1YNqFrYx9rbJoXslsk11n9ceZCr85+FQU5rF8ItLuCwYL8UF
         sfPS2ABPuc0kB9BW5x9N05oS2Qxc+dbgRAKz9SN5efQtl3LTd3QQ2869hmdnbzEcLBQv
         UzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753288075; x=1753892875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSX5a+3YqWRfEq9O3P3EgqeNWOcjvV7RTWJigTAIeGM=;
        b=oYjOVJQTG59dGmCeNr9p2hhvuoqUauNh2wFqnQG7Fup1IXWInhW1lWvXrARrOPQINy
         jWQ12NT350i9fqCiiHnB2UKF4B6Qkh+77XAonJwim3UVPochKT7yHOlWlrBtMU8ns7Lx
         NfBho7aj0PiB/URSV75SYv4CcGlnFHavGzuctkK49FCQxeX5KODyvhNq7acod23v7LIs
         ApcQ+YprYSY29tKKQ/nd7GtBFH4CtewPs8c+GwdQ10WObEoriAzj/m9jcpjOuLs4e0KK
         c9m7wVAwvG1ezD3t+LULVew5wWiDkWCgXV8SFeUqcXGsDGbQT5SbXgcrW8TWf47TQKm4
         pcvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkGVxsRRh0O8r8waav1epoHKfsWK9fkXXHaEA7nT4Y+ytn8aHYuezb8Wj2i7eCSDP+XdV7zh8/XJgxephE@vger.kernel.org, AJvYcCWMSseW6SD4TjgYeun7/V0tZMnVCVf2+qWGHrhqJk+Lbm4AiZ/xyJJg/sgIu+xJAPjO2V4=@vger.kernel.org, AJvYcCXHFhptV/lP+NtUFSEnU+BmSDOCXB4Xq0P8LnYsy+YCQ0FFJLsNGVEvEwJdB/QQKvOEBczuaZ7uxQIx8X0Qew==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc8KDrsufzWQOI27CFOhRyAPls8ePlf3SE/Ox+hovwVrXGAP5H
	pTehmKDEajcWs2hycMjkgF9k7EVrDxTwmoy9uzswVEsrvwzmqiFQ0IgGL/sBRD7N4t1wZ2MkkIl
	Zs4wHVjgRkLEJfoabSz8OeEs55PsY4uc=
X-Gm-Gg: ASbGnctAEv6zmbPtHGEAdB0jzvEBO73lauKmr8aCQBVw+4jG9+NV8VQuAno8xgD4kjr
	tcsv/i2Oo7oZs1uFoJo20HAjtVR4awin5wsnHYdZVRF09+EjULC6QlyRAOd/D9QFBbtelrU8omY
	8+Wi8zsD8IghAiIvRKarFasulpVXiuFr5zzvsUi++EKGJ/7WbJ2LPkzxcbh0weDbyW03y2Vw/MK
	noGTK80PBkpHAEHYaOTKoL/WHt7El3y+wU/1Pq7
X-Google-Smtp-Source: AGHT+IGpucOA3gmc/pEiQxwAKbl5KaV+tYSoHV4OqBtBfWT+cy89XcJM/EwbfEFJLKpvutRONbISPDuvnXHQRtgYrSY=
X-Received: by 2002:a17:907:7216:b0:ae0:9363:4d5d with SMTP id
 a640c23a62f3a-af2f66c1f40mr354169866b.2.1753288074947; Wed, 23 Jul 2025
 09:27:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721-remove-usermode-driver-v1-0-0d0083334382@linutronix.de>
 <20250721-remove-usermode-driver-v1-2-0d0083334382@linutronix.de>
 <20250722063411.GC15403@lst.de> <20250723-heuballen-episch-f2b25d1f61a6@brauner>
In-Reply-To: <20250723-heuballen-episch-f2b25d1f61a6@brauner>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 23 Jul 2025 10:27:42 -0600
X-Gm-Features: Ac12FXxTBuT6WdshnWBc3Nz_2uGW9_2R65lie7jB5BAADrF23vSl6KGtAg5kI7I
Message-ID: <CAADnVQKDwEPa0hQFqdoPUGt9bsx6V1xt_HJ=uhxWACoy4+KvQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] umd: Remove usermode driver framework
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 5:49=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Jul 22, 2025 at 08:34:11AM +0200, Christoph Hellwig wrote:
> > On Mon, Jul 21, 2025 at 11:04:42AM +0200, Thomas Wei=C3=9Fschuh wrote:
> > > The code is unused since commit 98e20e5e13d2 ("bpfilter: remove bpfil=
ter"),
> >
> > Overly long commit message here.
> >
> > > remove it.
> >
> > Otherwise looks good:
> >
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Fair enough. Democracy wins.
Will apply once I'm back from pto.

