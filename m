Return-Path: <linux-fsdevel+bounces-10589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0843084C827
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 10:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3434C1C23065
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 09:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC20D24B34;
	Wed,  7 Feb 2024 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1r/rU/k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3382241E2;
	Wed,  7 Feb 2024 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299915; cv=none; b=Wy/8faTOzWpK/717rNHaW7R8Wopmque5VGSn+bkQjmLoiIvIuLlnLFDACQfmyQVQ6js10ds/KZS5Vh59rIA363eIzlUnrxqkmUxOtAdG9ETSaMB5Arl7vTE4+2grMQ6YgSFBn7wkHZUOYvbMq7YBnUXeruPWQH12pS6NDhatmsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299915; c=relaxed/simple;
	bh=6Ad9WzFtvo9M9Xye0eKtuBffWmmUE/kRJcFrBC3A2Do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoMmS6PAgUdkv/d38xjQ5AQPHxLpgsxj1Rg2gLwL8Aj1bangbU5DGILNY/6YP1bjGL1lHzRI517Xn+nEjo/L+tLcfBzFoUXXgeH5IJSCAkdB57JqxGEdqugy4YDa9UFJCfeRv8ZnpzMPPu8fUAPpR7nuzCAemz+fhQGeLbdjNKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1r/rU/k; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso303137a12.2;
        Wed, 07 Feb 2024 01:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707299913; x=1707904713; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Erd6iBOvSQTLPmH7ZQkIyD7+FFOkCKWDHeq/h3o0+w0=;
        b=N1r/rU/kkDPAl2RZ7a/wHiOKy0lrqy7cBtvo0p/aQbShs8MDiiyWtj9+kvuFvPmOLD
         S5nB/CIL8J8hew+0FUvVuw2rAeI4OMC18ppnzP+AEHDD4vS7St4+iwoQN2cNblzkzoNh
         tQhWcw9KCbQ73Si82PU7fDq9jhpKMMQkuVeYic03J8blEuHmBIitO+sh9OEK3eSDDfSQ
         kxv15MJMLTIZeBDLM7k/jfjdEw2XKuoXtwYRXh86cuKTSU22k5mcRWe7EFBR9rT/bsjp
         YHmLHABXsV2QktVcxa5i8UqlfXunI2UN+TSAwTKY/YsVEFFu6sPs6zdcXdFaSsYdyWKG
         FgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707299913; x=1707904713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Erd6iBOvSQTLPmH7ZQkIyD7+FFOkCKWDHeq/h3o0+w0=;
        b=KZke2VuAZcFwDX2jyyWNLDWDjcb1e8TxwHDOqu5QT6e7MdxrwkUJRJ+rEAVbxW6HgK
         txcd033/9fMOv+cO7YdquuuZWjWUEER7XJKe3Ki0vCMZQSg996sYCGEJKcT4/E96hKz7
         wmWxHXvC+ncFe//RiN9cv2Ru4UHWvlSopMELGSoVhffcCAbSgPYOeLBgx19X77ZiuCKf
         UMLoyXBJQSBOw/zOUR1mPWDwWc8WQH350LrkFppZX322lPCfrhg7eyeBUYZH3swQXx6r
         0ktlQkPCAPbgkAdYwCNDMdvRt0nGsw1nqX9Dy02O5hLBzYbuSCZM5WTcBN3tnC+PqAJY
         ipZw==
X-Gm-Message-State: AOJu0Yw9estfKQBDACSXqHQTfmxH4ZQekSaD7sarad/ba6VK1KxeqsjI
	LzfXzAFdQLwKUXwyKSAejdyMlr/nXKMmYSyMI7XHPXfGLOpPqp24cAXPV1QX8jiAXJhN5+ESPBw
	LqR/DUiO5Lb45V0WJheGh7nzsYQI=
X-Google-Smtp-Source: AGHT+IEDEsrK1KFnPecZ1szkOLYZhCRUwr7hLOiAqL+ZyxsW7BljzbU1PbbAuMJQhZz31hyJRU8WhXblTas3eAn2Plk=
X-Received: by 2002:a05:6a21:150b:b0:19e:a7c2:eee0 with SMTP id
 nq11-20020a056a21150b00b0019ea7c2eee0mr727047pzb.8.1707299913069; Wed, 07 Feb
 2024 01:58:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5mswELNv2Mo-aWNoq3fRUC7Rk0TjfY8kwdPc=JSEuZZObw@mail.gmail.com>
 <20240207034117.20714-1-matthew.ruffell@canonical.com> <CAH2r5mu04KHQV3wynaBSrwkptSE_0ARq5YU1aGt7hmZkdsVsng@mail.gmail.com>
 <CAH2r5msJ12ShH+ZUOeEg3OZaJ-OJ53-mCHONftmec7FNm3znWQ@mail.gmail.com>
 <CAH2r5muiod=thF6tnSrgd_LEUCdqy03a2Ln1RU40OMETqt2Z_A@mail.gmail.com> <ec454090-da42-4943-9685-67e2b5a040ca@rd10.de>
In-Reply-To: <ec454090-da42-4943-9685-67e2b5a040ca@rd10.de>
From: ronnie sahlberg <ronniesahlberg@gmail.com>
Date: Wed, 7 Feb 2024 19:58:21 +1000
Message-ID: <CAN05THT2oYX35oGAJde8Q_Teu_dWL_G7iOGN6D6nG5L_s6Kkrw@mail.gmail.com>
Subject: Re: SMB 1.0 broken between Kernel versions 6.2 and 6.5
To: "R. Diez" <rdiez-2006@rd10.de>
Cc: Steve French <smfrench@gmail.com>, dhowells@redhat.com, linux-cifs@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Matthew Ruffell <matthew.ruffell@canonical.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 18:56, R. Diez <rdiez-2006@rd10.de> wrote:
>
> Hallo Steve:
>
> I wonder what would happen if the SMB server said it can take a maximum of 2048 Bytes, and you insist on 4096. Would the connection still work later on? Wouldn't it be better to abort the connection with a descriptive error message?

There are no servers that we would care about that have limits that
low. And if there were we could just open a bug against the server to
fix it server-side.

If a server refuses to work with anything larger than 2048 bytes it is
completely valid to just shutdown the session and refuse to connect to
the server.

>
> You stated that this scenario is very unlikely, but my Linux client is negotiating 16580 bytes at the moment, so if PAGE_SIZE happens to be 64 KiB, that wouldn't be very unlikely any more.
>
> About this other change:
>
> if (round_up(ctx->wsize, 4096) != ctx->wsize)
>    cifs_dbg(VFS, "wsize should be a multiple of 4096\n")
>
> All my SMB connections have been automated, therefore I am very unlikely to realise of such a warning. It would also mislead people using the current Kernel versions into thinking that this limitation is there to stay.
>
> If the SMB client cannot really honour the user request, wouldn't it be better to fail? In any case, how about mentioning in the error or warning message that this is only a temporary limitation?
>
> The second version of your patch file looks like a VIM swap file. I gather you attached the wrong file. The best way to fix this is obviously to switch to Emacs. ;-)
>
> Regards,
>    rdiez
>
>

