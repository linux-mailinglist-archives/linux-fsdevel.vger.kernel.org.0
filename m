Return-Path: <linux-fsdevel+bounces-40405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA41CA23225
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 17:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525A718821D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 16:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5FF1EE039;
	Thu, 30 Jan 2025 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DkL0LmWb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713E51E9B3F
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738255425; cv=none; b=RQwfr3dlL1lq1+SjsztkF3UYSDxfqzSIufI4O2WaoYyxX1XHz2Voq1a+yutlCET7StttNpPKm0l9AqKmtvqImzjd9fww84W2YqeB+sSLeg3ImndWpGU8XTkY5cHxiTx0XpRQJKQ7BnbeTcWGW2hsFiAna7UyWOzRMH8EVGR4N18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738255425; c=relaxed/simple;
	bh=wm/GjTYZmSoQIdMarvhxBrtJ0uNjvcCc+5oIO1kYldE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXzbh58G3awzS+2fXK6R4S9MlNEiAxdK0pGOa4B319Pgtil+EDAgOdjrhK3L9r5o0DFtmEMrbsUJXSkX8QQhjFqdgWlqOkMFSb6DeCw5941g64yJUSWj+mk59R77hXKoR5P4e6lRbTb9BzWc7J2LCHnlHTyOs8qdEKHA6YxBO3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DkL0LmWb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dc149e14fcso1807552a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 08:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738255419; x=1738860219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fuEDpAnG1sazTNLQRV+DgH04oKDY04Gu9xv5BY6PwaA=;
        b=DkL0LmWb84hKpz8kFVQwe7WATu8w2oG4kLIF5cvA9T98NfSGgcAmw7v9elHfRlo/H9
         2U4xfPetb4QRmN/xGcwy+Fve+crr4AvhVh+8K3ZROWR8uy8366JieeNFwqtBejFr1H4j
         p/KNNE7QfkW2hcdBkVhGD3cFS0VoMZ2635kVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738255419; x=1738860219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fuEDpAnG1sazTNLQRV+DgH04oKDY04Gu9xv5BY6PwaA=;
        b=cnYn9GY81GWKeVOv/28LM5G9GTrnZmJ7QIZ7UBzSVmPC/6QYAc0MDJQLGac2lc/alz
         N2+no6cSPqDTzRkBPtJIRzAUYdcRAg8gACaypV5sFerFbQChtrrcNtsvN3/RUjQ5wovw
         lhJR/zIAe11wAe5WhqOUjo8yvMwupYPbCxzZpncugtpKGFTblN5COKWZTFsqSAoUyLjo
         uOBNFJdYErCYjf3ojuO6GOEKy+vXGChdig1JNHfslKSiCpbpKw9vj7nge3Hvyx/cTNsP
         TQAB64LVj3y1D8UKCRG7X8hS28UcjVwnUdkKA9gPh5i9vuX27GaQMfH/a0vj28aSY/x0
         AmKA==
X-Forwarded-Encrypted: i=1; AJvYcCV7O+SIB5GHkjQvVPssbyC9nuvF9kTAFErHf90R1SoN1slxJ+xgyzh6PMS/2tHoz3uS96HAVTVB4bzglMcN@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd2UuB0B3z7frP0/kikgloafK6QByM/shnZtiOQfpNC07dco5g
	L7Glh+mhDQAKVXufqEAjlViTZuyvrMdRsluOrbOKbcNcVqP7qbOpM9NA3CgqogiSJVonIPyecux
	WzWs=
X-Gm-Gg: ASbGncu50Vof0AtIzIVA8pQsmzHvGCxXbFXEAsnSjAnj2fjKZGwPIBne1nQzjnjEhek
	Kv7gO0u8zz8w3EVDU7+8mqo34eGdCNTQsg1wgNHUTshbURTf1wPPt/dWAD8ZmoVmuAC71tGG4gg
	KVwBybngLkdGxT8/VNcqIkgg5NYsHyS5y9Xi968Hu+f13p+z0jQXPuaAd2fmmyHf8cRFSzXj2h6
	/Wx7dCzi2DOZvo0fkBLmsve28G12P/PTAgKoK+OZIze49Z4UVTmdd/B9QOKsqQJZp8KiiZvfubL
	Z6nbvXCoBPkTCQdaJ+NTiOrddu/lO7JPIkkO8xWrRlPZmN2+Yvwjn2qcCm15PkqCpQ==
X-Google-Smtp-Source: AGHT+IHadOcdzYvrcmgAiWxNO5ClbUPf7fQfssURnA9hLKgOXGbl+QcQCi1nt/U3CP/WQEcypocWyA==
X-Received: by 2002:a05:6402:84d:b0:5d0:bdc1:75df with SMTP id 4fb4d7f45d1cf-5dc5efebbb2mr6808706a12.24.1738255419644;
        Thu, 30 Jan 2025 08:43:39 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724aa0e8sm1310190a12.49.2025.01.30.08.43.39
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 08:43:39 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab651f1dd36so218791566b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 08:43:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWLyetbPyF5Eq+JkxDIlYXLTk+0HdXo3qUKGZTx25vvwtvvH1goUNbeFQnu39a19cbYAggbPD42WiPJ62R5@vger.kernel.org
X-Received: by 2002:a05:6402:50c9:b0:5db:e7eb:1b4a with SMTP id
 4fb4d7f45d1cf-5dc5efbd32amr6334804a12.10.1738254929601; Thu, 30 Jan 2025
 08:35:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB50801990BD93BFA2297A123599EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50802EA81C89D22791CCF09099EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <20250130-hautklinik-quizsendung-d36d8146bc7b@brauner>
In-Reply-To: <20250130-hautklinik-quizsendung-d36d8146bc7b@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 30 Jan 2025 08:35:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjLWFa3i6+Tab67gnNumTYipj_HuheXr2RCq4zn0tCTzA@mail.gmail.com>
X-Gm-Features: AWEUYZneNxaHhpPSYfPAUA_rUTrk891uuSVIWZIkTE-aPADGZkPCsAjzruuXyrc
Message-ID: <CAHk-=wjLWFa3i6+Tab67gnNumTYipj_HuheXr2RCq4zn0tCTzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 1/5] bpf: Introduce task_file open-coded
 iterator kfuncs
To: Christian Brauner <brauner@kernel.org>
Cc: Juntong Deng <juntong.deng@outlook.com>, Alexander Viro <viro@zeniv.linux.org.uk>, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Jan 2025 at 08:04, Christian Brauner <brauner@kernel.org> wrote:
>
> I deeply dislike that this allows bpf programs to iterate through
> another tasks files more than what is already possible with the
> task_file_seq_* bpf api.

Ack. This needs to just die.

There is no excuse for this, and no, CRIU is absolutely *not* that excuse.

In fact, CRIU is a huge red flag, and has caused endless issues before.

We should absolutely not add special BPF interfaces for CRIU. It only
leads to pain and misery.

           Linus

