Return-Path: <linux-fsdevel+bounces-45899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E185A7E5D9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 18:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F49342427C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 16:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE012080C3;
	Mon,  7 Apr 2025 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dBUV91Ve"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222A92066F9
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041634; cv=none; b=AV/Ks7VDjk73BFMtyFEjCWTAELr2amLipXBPl/waCQ5MHzbkjq6RPdnKtmCtCKQmbIIGD7DyCb3buWYgGoVCxy/dPEqZodwEEila995pQWF8J7tgBSyBCm9eket0wjQFEuIZXlqf0AvIdi6hqPY9bOPdaX2q2CUPxf9OJFP6sWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041634; c=relaxed/simple;
	bh=16jnXUwEzg+6vjOWlFFNf1AIjcyTPaes4VV1VjBmRVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQOtHs+Ez39TkNjX4BF7RWPoEUmal84hQ/y8d84dm/zlONRJqThIf0C88dsykE6ise5CI2tKIugBg2pO1JGnS7YrJrVMXjKHV+Ek2+vNr55aD8Rs1auU/gH4d0TnwgqPFW07KmkQ1zwQpq1q9gNzIlXkJcS3AxiqUuj0Vm36GA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dBUV91Ve; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abbd96bef64so875584066b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Apr 2025 09:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1744041630; x=1744646430; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8zO4Ev4894plW7TI/YV+dAf1aUzFJZSWz5C8372wjus=;
        b=dBUV91Veyx1/pWwVzLKQ6SOciqYt0N7Ywee2m+eZc6xMxDKRLfvIM9Uvd6a9F5Al+S
         DapuU9Ft3WFxtyvRtyrKVVtVI9XefnotybnQ5rfYkKVPPFK2c0jpm0qNJMPFeMw9U4fY
         ED8SMKkivsfiqQGLhATflPsMbAhlxo8e40JLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744041630; x=1744646430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8zO4Ev4894plW7TI/YV+dAf1aUzFJZSWz5C8372wjus=;
        b=Nz9YUEipV4GjGmagWigp9HwMmcTAFNbYlbKstolQVhSdSQKvbs4xudSGkXCbFAGqF8
         GaiMAqyTnz4bOSJU/5zAapOTG7RT5tKmNkvO5wlEMxA0Ssel7P9ZZSF3fP00ynV8c8An
         ZF7QhNupAxUKEwEvLwPj0mqfMcG21gJK7fh00EVoLJZ8BAOnn4EcbJG9DFfcEhDgz38K
         uP65N421i1rQAj2de3w4FA1V0FlOKsMiQ1gJTmhN+7txc/lyYD50Nnm05cNt5tx8xQmA
         UWaML1fScStihRVQ1+cvkQQCY3kjll9T1HBHvO+pMrU/TJQFdMcv8dThddgkvwLpxbFm
         obIw==
X-Forwarded-Encrypted: i=1; AJvYcCUBDDakpk55CH3UIYgjjfGSu/gVazPC1fS26Pyc/WiCIVFn0FM2wRH9zYcqtwuJWxUEFkeaIJjM8Xe0V2p6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvhfr8+4Dl33nCFQdvP3EntJsECEnjUS+gada8hXu9DOoz/Z3g
	APAaG0+scMAtxHqpPatQ0ty7t5JPVd2OKuw3QZGjeogzO8U1r3XrBhTwxfylTaDOUwdZk3qbxJA
	qg7Y=
X-Gm-Gg: ASbGncu4yDGujcx4/kx5qRYd1qTjkqi574RVUI0Dd0Vz4EEDvZRaiQDtf+IZA4D8YIt
	81uexuniZf4dg+GjuzedPsfTMZlURH5dII6W011BjzzN46dXXDCfIuj6MpF2iQiHnDueKxSKsK4
	GO5XfarfkANaQ3+8FLdn3WvSXxv2jNeKzuUXulD9Uy4cZg+Hyeof3vrx822NogjCYn3YN2Fs7xL
	/Sz9axE33EzOEifZtVnm9IvNl8e/61pZVDaG11muwRhr9g57waWLmiNyxlCQtTuDi2Ur8aXXI9o
	6SIWXejFnjhw2DV2V+pMW4HKSSo0VfzyMtjGmAYoK87+Gjl8VPAz5d+VayxFNJU1dhMxzHsB1N9
	qC/ZkmwM5XrDBzRaIL48=
X-Google-Smtp-Source: AGHT+IFO1r03+acxxMls7WAND//bpIeBqQr+14TCYNEAyZqTr2ckyJkxs2DWwY6ZFA+DlIrhmLmxEA==
X-Received: by 2002:a17:907:86a7:b0:ac3:3f11:2955 with SMTP id a640c23a62f3a-ac7d1b27f2amr1330134566b.39.1744041630112;
        Mon, 07 Apr 2025 09:00:30 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe5d3d8sm766945666b.31.2025.04.07.09.00.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 09:00:28 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5f0c8448f99so5881007a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Apr 2025 09:00:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRdnnNf5QCY8TCnFpLUVe6PPPBi9CrwE1UUZtdAFGTCJenwS1lRNVfE1hVxaVnrdl4LU9egXOQMq/YwHd0@vger.kernel.org
X-Received: by 2002:a17:907:3da2:b0:ac6:bca0:eb70 with SMTP id
 a640c23a62f3a-ac7d1b9fe8dmr1237120166b.56.1744041626801; Mon, 07 Apr 2025
 09:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322-vfs-mount-b08c842965f4@brauner> <174285005920.4171303.15547772549481189907.pr-tracker-bot@kernel.org>
 <20250401170715.GA112019@unreal> <20250403-bankintern-unsympathisch-03272ab45229@brauner>
 <20250403-quartal-kaltstart-eb56df61e784@brauner> <196c53c26e8f3862567d72ed610da6323e3dba83.camel@HansenPartnership.com>
 <6pfbsqikuizxezhevr2ltp6lk6vqbbmgomwbgqfz256osjwky5@irmbenbudp2s>
 <CAHk-=wjksLMWq8At_atu6uqHEY9MnPRu2EuRpQtAC8ANGg82zw@mail.gmail.com>
 <Z--YEKTkaojFNUQN@infradead.org> <CAHk-=wjjGb0Uik101G-B76pp+Xvq5-xa1azJF0EwRxb_kisi2Q@mail.gmail.com>
 <Z_OSEJ-Bd-wL1CpS@infradead.org>
In-Reply-To: <Z_OSEJ-Bd-wL1CpS@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 7 Apr 2025 09:00:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgtKqZoQZB6VzJr+EQNfsT1r1A9U2zxOrGFb+pqtkTXFA@mail.gmail.com>
X-Gm-Features: ATxdqUGe2UEcBb7-HxSxAS-BggZkNNT9Atl96RrMDJ0cWDe458YcI4kTYsxsNfo
Message-ID: <CAHk-=wgtKqZoQZB6VzJr+EQNfsT1r1A9U2zxOrGFb+pqtkTXFA@mail.gmail.com>
Subject: Re: [GIT PULL] vfs mount
To: Christoph Hellwig <hch@infradead.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Christian Brauner <brauner@kernel.org>, Leon Romanovsky <leon@kernel.org>, pr-tracker-bot@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Apr 2025 at 01:51, Christoph Hellwig <hch@infradead.org> wrote:
>
> The scoped one with proper indentation is fine.  The non-scoped one is
> the one that is really confusing and odd.

Ahh, I misunderstood you.

You're obviously right in a "visually obvious" way - even if it was
the scoped one that caused problems.

But the non-scoped one is *so* convenient when you have a helper
function that just wants to run with some local (or RCU) held.

There's a reason we have more than two _thousand_ uses of it by now in
the kernel (~4x as many as the scoped version). It's just makes code
look so much simpler.

I was nervous about the lock guard macros initially, but it really
does get rid of pointless boilerplate code. Even without error
handling complications it just makes code simpler.

          Linus

