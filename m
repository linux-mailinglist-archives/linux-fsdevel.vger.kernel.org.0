Return-Path: <linux-fsdevel+bounces-10088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEF0847A92
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 21:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF34AB284D9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 20:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D425B1F6;
	Fri,  2 Feb 2024 20:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OUq4Iv26"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C39C41764
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906349; cv=none; b=RpcYtsqsccpE01+AwjP/G/QhXuCE+ObuUCTOq0pv4qRs8WjAiVC1rlCdBPYSZ7EYPgapDy6OasCGthGvPj0Ij4eCEZZA1CXWkVllOFk/YJsOsuKU897HiimtYj2k/qzCQUBYr2/bRxaGlY7ViAIjSiLZl+5H4pgXlQEg+Svs540=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906349; c=relaxed/simple;
	bh=C1NOo2D6BqxPz3sCVOg601jHnW2UzAwYZ75CPDqMBRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVP41w0qq50czDErh+QLHqqgVZuLEhJBAyznP70Re4Mk0hHh6gi3y7QR9M2DAa8BOkfuEXexy7TacCTf6Q1PXk6P+0P/fQcO7lTPVyLszuTTCt+uTMsm8I1tBVMz/M5b69hkC2l0hghLfU2kX47PkZiJ3YsWavcB+nL4ru0F4mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OUq4Iv26; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55ff4dbe6a8so1380925a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 12:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706906344; x=1707511144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1NOo2D6BqxPz3sCVOg601jHnW2UzAwYZ75CPDqMBRk=;
        b=OUq4Iv26V4WQpkJH/KnFKGihfYDL14ZwgEXqYIXKSYN23Wx63Nbav8PM3WituGIeGf
         ls63tqh/xK3xnHwLivtDx11jMsA8cFf/qJ3Nn1WvJcwaJGZQ03E7vxpszPP0y+ymNOFf
         LSe0U9Omt7/TKwzS5xaWTnwLypBb1F/3ZzLvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706906344; x=1707511144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1NOo2D6BqxPz3sCVOg601jHnW2UzAwYZ75CPDqMBRk=;
        b=cq67V3Ggku9ah9atZJnwC5tLGK9RcIyeCF+ZE/e+n2lCp+Bb87vFiiUUQsRSNKw9Ye
         +GB757mKS8JGeWnENlKouVFQ+5KdDGwfgV2LhNWocfV4SFhS0ELDNqnVCLMrCopXs/M4
         f55wOzteHgI/PucBSwbOks9marTLerrj5XXmrCI5vQ88wv5kDP8uRJUnfhXHKHOQ8+Wh
         cIhf3mptUc8p20dF6thnHVAzrmBpgSoA+zrE6k2FkwEHmpBFIdeH+Xog0XGgq5qjC0BL
         H6Ya8JyaarseVq5pd+Qk9Zz0hhkwkHfX0W090r4aSYAu/ZDpMPKoJ7Sxd4lgXX4343Dk
         cNWQ==
X-Gm-Message-State: AOJu0Yx9TOBzhwQCLwMb3QDZ5ZtwEMiMnvU8nEI94LSLyzvlFbrRnOvF
	7aEqrirtAgmbMi1MsY+pnUbvbj8VKDuKSRX/6ErMUahODTIvGTcP/T/7T4M5KVpD6SKmVw3vFco
	Y4H/z
X-Google-Smtp-Source: AGHT+IHxRMwacY6NjemqbHNGsl7SJjsT1XDDuGGcJHMIRB/QvVKScKPtvGwp5D0Vc8E2k1GTBTYrRA==
X-Received: by 2002:aa7:c6da:0:b0:55e:f640:125a with SMTP id b26-20020aa7c6da000000b0055ef640125amr502315eds.11.1706906343831;
        Fri, 02 Feb 2024 12:39:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW7E2ReH5Z6l0TQ5DBRGzL4moDztd+k4Jc/FnWQBHJPl8hi86UC0jvv1tXwaa1Ipc6Y0GQmbuvmq/8h8iZ/mAoz4UuFTzhX+XHx66go9Q==
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id fk24-20020a056402399800b0055d18d6a586sm1101518edb.13.2024.02.02.12.39.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 12:39:03 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40ef9382752so11595e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 12:39:02 -0800 (PST)
X-Received: by 2002:a05:600c:a3a4:b0:40f:c2f1:9d4c with SMTP id
 hn36-20020a05600ca3a400b0040fc2f19d4cmr7485wmb.4.1706906341770; Fri, 02 Feb
 2024 12:39:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202012249.GU2087318@ZenIV> <CAD=FV=X5dpMyCGg4Xn+ApRwmiLB5zB0LTMCoSfW_X6eAsfQy8w@mail.gmail.com>
 <20240202030438.GV2087318@ZenIV> <CAD=FV=Wbq7R9AirvxnW1aWoEnp2fWQrwBsxsDB46xbfTLHCZ4w@mail.gmail.com>
 <20240202034925.GW2087318@ZenIV> <20240202040503.GX2087318@ZenIV>
 <CAD=FV=X93KNMF4NwQY8uh-L=1J8PrDFQYu-cqSd+KnY5+Pq+_w@mail.gmail.com>
 <20240202164947.GC2087318@ZenIV> <20240202165524.GD2087318@ZenIV>
 <Zb0vem7KC28gmT5U@e133380.arm.com> <d7154f86-d185-495d-aa84-63d4561f1e47@sirena.org.uk>
In-Reply-To: <d7154f86-d185-495d-aa84-63d4561f1e47@sirena.org.uk>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 2 Feb 2024 12:38:38 -0800
X-Gmail-Original-Message-ID: <CAD=FV=ViEjvEevLq+1ZEVQB9qh4ofJHvLYfNu0XTQSjNRpZzAA@mail.gmail.com>
Message-ID: <CAD=FV=ViEjvEevLq+1ZEVQB9qh4ofJHvLYfNu0XTQSjNRpZzAA@mail.gmail.com>
Subject: Re: [PATCH] regset: use vmalloc() for regset_get_alloc()
To: Mark Brown <broonie@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, 
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 2, 2024 at 11:43=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Feb 02, 2024 at 06:07:54PM +0000, Dave Martin wrote:
>
> > So, if the only reason for trying to migrate to vmalloc() is to cope
> > with an insanely sized regset on arm64, I think somehow or other we can
> > avoid that.
>
> With SME we do routinely see the full glory of the 64K regset for ZA in
> emulated systems so I think we have to treat it as an issue.

Ah, got it. 64K is much less likely to be as big of a problem (only an
order 4 allocation), but you're right that it's still a size where
kvmalloc() would be an improvement. With that in mind I'll plan to
send out a v2 of my patch where I use kvmalloc() instead of vmalloc()
and update the commit description a bit, including a link to this
thread. Then I will assume that others on this thread will move
forward with actually making the allocations smaller.

Please yell if the above sounds wrong. :-)

-Doug

