Return-Path: <linux-fsdevel+bounces-39735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3391A17350
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 20:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8060D1889A06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 19:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107D61F03C0;
	Mon, 20 Jan 2025 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GPGIUb+m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5D71EF0B9
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737402630; cv=none; b=tp8PaOIC4G4++276HxRtug7Hs1+ASxFOH4qNu1pQCvIW5ihe8kroTvOTRhAtQVDCaovRM//+Hp8QSM4ynk2GHTEVj+WgDkFnIfPDEqeF8J1Xw0xXegjKep35JC5kUVMc+X0xJQBmZXNl1rnpNZZXONosHgsJ+0lgf+BE4jp/gt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737402630; c=relaxed/simple;
	bh=+yC97igTnAUGxKYY6ti7y91h3A77EOTvGMJgEtHNrUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUctnHrAVMhuhM1qMzIkbk+a73hSXz54ItZjhqM94/aEMAXoT6M/kuXhUf8F99fugLoTesuQVABEyj65fqJEJf3hPj2goFTre8Knkk/KvD+IcGPQLJsM1yPyimRDxPf+tbpH4d+cXKMKhM6xfGjkWxeBzydPrNYjuRKcI9/Nfck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GPGIUb+m; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaee0b309adso729939666b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 11:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1737402626; x=1738007426; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l4Q6wz1X73PCFp0PWUlpXQpQomHGAshPS4KN5fa55XQ=;
        b=GPGIUb+myzjsCIxTTiY83lFbdY1aek1A4ycUpjYGnuS6Da6yPH6UT/iKIYX+TJZci6
         /MMhGsyFn14u2O1UKcvmuvaPGOzEibqOk6dfM8OTC2TV8JJEn8nXkNzCUj8e09wZt4Ks
         Zkq8au1yyybwesJk+J6jZxXyRvgnjuxS5ui3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737402626; x=1738007426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4Q6wz1X73PCFp0PWUlpXQpQomHGAshPS4KN5fa55XQ=;
        b=mjbOcGUc7Yj2W0Cu61OU9YFX+g9BlUhMqPCfRksTtGV8QDZ4V766bR59LHyQLwEHv8
         rCAmEqFDVZ/QJ0o3b3UQ446gzbe6793L3MeJqHkNh6D7kD3xCNDw47WpkSPUMsZuRbDm
         WOVKxrutxli0iuJxJj6sYMpVaTrniNQIkPaI5CH44TmHWuynpv0pdOojGRkbNgYbcbVW
         /V2QKe9M175h59Td+wQnOFV0BXGaFEPaw5ezuYp853OT9lyFnNNjexZp2fnNB8uJulBm
         XcG0Jl7RdgqJXRHYZSjkx6WPP+M09+R+mNQKwVd0m8fMMD99hcHx4O8k0e0kwXW8rbXD
         ebEA==
X-Gm-Message-State: AOJu0YylNSJz5j4BJoXfsmZJGW58KU/R1MpK87844/dCVnG8WKEMrebl
	INHEt/f4osvej9CB4bYTmIFzGEXnGji3Aym/PRl6wrRSfY13h7nJ2HBOdLC67uPvuh13zvcZ6et
	Rr3LaiQ==
X-Gm-Gg: ASbGncugtarsD6gXjM+6M4lBFTJXx3ubJ4HwhonLEdypR8+m7dd/wkmjs3OfaKhar8U
	4KLMVtFhl0rj7YWh/wD2yYKUAZ71VGt19eaqw0JYGUTNtFtDD/dn/ByLmYZBHBmBsdZ12RC5dua
	D6Gv3dDKim/28yza+0/HUAlD5RZ6Vm/J2uHjZZZTbFyQ7Z8BSt8MO2ct/ESk/xh4j/11/G145WX
	Arl8r95B7EDOH1R6WeBVMSwqaMOaRLsEw6V7yzY6pxSVmZgY2exF/vJKSRgQduTy5bzbZYj30Ou
	/YRVoS8vKcYeTQbvADB6q3rfARme1ZBKr2bR3IudjcRP
X-Google-Smtp-Source: AGHT+IHMGvGBC5Nnl5+5ST0ZFHJjw1QlEpG1MpuPreDh20WCJAn4a4HzKfLafq8Bz6kKAr22Jf2c6A==
X-Received: by 2002:a17:907:72cf:b0:aa6:8676:3b33 with SMTP id a640c23a62f3a-ab38b3f8f45mr1231384966b.47.1737402626481;
        Mon, 20 Jan 2025 11:50:26 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab398ac5879sm528144966b.162.2025.01.20.11.50.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 11:50:26 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso822207866b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 11:50:25 -0800 (PST)
X-Received: by 2002:a17:907:724d:b0:aaf:f32:cd34 with SMTP id
 a640c23a62f3a-ab38b10ba91mr407917266b.15.1737402625546; Mon, 20 Jan 2025
 11:50:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250118-vfs-dio-3ca805947186@brauner> <CAHk-=wj+uVo3sJU3TKup0QfftWaEXcaiH4aBqnuM09eUDdo=og@mail.gmail.com>
 <20250120-narrte-spargel-6b0f052af8b6@brauner>
In-Reply-To: <20250120-narrte-spargel-6b0f052af8b6@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 20 Jan 2025 11:50:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgdZJQFfBnKXQm2EZiej-KVk5=E1gOBhW72XnQ_SBZ=cQ@mail.gmail.com>
X-Gm-Features: AbW1kvbtA8rTH_bf0K0Xc8TT16YmQaiHKcCezhU-SFr_zSCoJ4_Elt9ZztB37Jc
Message-ID: <CAHk-=wgdZJQFfBnKXQm2EZiej-KVk5=E1gOBhW72XnQ_SBZ=cQ@mail.gmail.com>
Subject: Re: [GIT PULL] vfs dio
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Jan 2025 at 11:38, Christian Brauner <brauner@kernel.org> wrote:
>
> It is heavily used nowadays though because there's a few
> additional bits in there that don't require calling into filesystems
> but are heavily used.

By "heavily used" you mean "there is probably a 1:1000 ratio between
statx:stat in reality".

Those "few additional bits" are all very specialized. No normal
application cares about things like "mount ID" or subvolume data. I
can't imagine what other fields you think are so important.

          Linus

