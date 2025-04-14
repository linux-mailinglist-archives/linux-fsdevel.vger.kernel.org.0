Return-Path: <linux-fsdevel+bounces-46398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE6AA887B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 17:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6703AAEA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 15:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092DF27B4F5;
	Mon, 14 Apr 2025 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FDKFgFIS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F6E18BC3B
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744645581; cv=none; b=uRuH4mWmFdSpT5y7OGYTjr+XjjXUDwAJbWImjx2BaXTk1Zrt/P7Cf6XnvgQG7ILceWFY80f0Ak2oxxD7oGAmOfahOfSuefn3ToyjJLmB7tHTl+XIePZjSTnojmjipYN+IsMgviAkiX6AJtr4KOKLsPEv76WsQPz2eQrLGODPRzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744645581; c=relaxed/simple;
	bh=eYbIADCAabe7j+LtgMC8MoX3eskEhtClGsrJDvbhXVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2dQLlAN9ipsSpIamLn1P4ERnqqyYvfNz4DuVy7eSc70ZjwwL+rvHNP7+O4VL/Ltc4WhkRSbUxTyOfJTnkmZvKNl0+FyqIfJf3jz7K8i7hLxWyaFSJ2Lbl99g7v9SGhXZHsjtFSJd0DREcB0fNzsTEnJdQLtfvOJkcTFJu6SjWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FDKFgFIS; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e66407963fso8293738a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 08:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1744645576; x=1745250376; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NeOhHf5iGFXCR7KyyiaekGGStl7/ERESKKOdW516A3U=;
        b=FDKFgFISJD79jq+mDNybSB2yZsynp/pIuWWKj0vPR9H0Op7NU9iET5FGrsVXStVv70
         /u2yVtCLLXoHFfLMym4yeINnCzpL2PN+kAItbVxnhrRgg9A8RpIh4U+ysJrf2dMIeV85
         uAQmPc1j6s9DW/5XxTp50vXVIzdAFtRyDQvNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744645576; x=1745250376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NeOhHf5iGFXCR7KyyiaekGGStl7/ERESKKOdW516A3U=;
        b=pH8xf2P+9KrQE+NJawte1/TzDqdqqteQDfi18dPjimvIWkyIxiQC+5EPG54/7xtU0A
         RcnXcFeTsqCrc1f/B0fUj8J8Ct62mbSYIo3qkINQYY1DKOGEfBZwpQ3Hf9ZQyxx+ZnkK
         yIVF2CcuyC/IHLWL6pRniwgzKPEztiofDGq39gG/sdALciluag9H878emyCNgZBGHkR3
         t6So4H8nF07VWwYeIZCOoUK2r38xubOWYTitewgjEFJm8J3KYCJl51zSXWCk3pwW0s0o
         HZYESQel6erbg5NIFl90jPI4KbMP17tV8kR47u4QApbnNa7mYaNPewIOFYucX9KPXKwp
         EBxw==
X-Gm-Message-State: AOJu0YzWYx7EynENOAQFTDmKMVcUILjtKhGsXyzmsQO/YHTPsk0g5WrZ
	wEJeyFPGPr+874Gw3qt/lSJuU0r4QPSqp/hqLo9rpa6yO5oZSTelQOVYundURBcU7N/LTObP458
	/ZDo=
X-Gm-Gg: ASbGnctXQHJ0NGYpUfwhTkE8AvQZ7UKWQcvLpXgGIGiSK3HmVwqiqJYswqdUeIWdZF2
	zje5eBfwLkAgKx7wV76TjY56SwlRJRuLTwFt2nXWOAGpFdPZ7CEJQPgZ3F0IzLD6l2IxjbolUua
	YzA9jsEF+HFzVPa7hIMOcRoRAe5KFx6LNsfaDSnPEi29hw/S8HJfifTtoMw1livifURRBpIybzD
	nLw74DzyqXxxbQqHUy7wvE/q6s8zn+dXeWpvn/sKsjLp+Dm1EJbWSls42VGoi+d67dK1U3Yt/bQ
	QqQ6RfXOE/kZ+XMahdOzQld3sLw7q5gdkEKm+ba50mdFhYNhWh+tanpLxAmW/7eaEMzJ/TJL30S
	tAjmqNTw7ZGgeVx8Cz9Tl+x0jtA==
X-Google-Smtp-Source: AGHT+IFkdOgNeeRjtqeXEodkmxBhs9BTkEYuZLp5yw2LdBT60Mw43Zqab8BM9UMQZXi+eG4pcjTrcg==
X-Received: by 2002:a17:906:1413:b0:aca:a1e2:8abc with SMTP id a640c23a62f3a-acad344606cmr925321966b.12.1744645576288;
        Mon, 14 Apr 2025 08:46:16 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f505744sm5252662a12.57.2025.04.14.08.46.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 08:46:15 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso768213866b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 08:46:15 -0700 (PDT)
X-Received: by 2002:a17:907:97cd:b0:ac3:4227:139c with SMTP id
 a640c23a62f3a-acad34a1b8fmr1001357466b.24.1744645575182; Mon, 14 Apr 2025
 08:46:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414-gefangen-postkarten-3bb55ab4f76a@brauner>
In-Reply-To: <20250414-gefangen-postkarten-3bb55ab4f76a@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 14 Apr 2025 08:45:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+SJCYnBT-CZx0sCgWg1jovGZHb+OKs7kqN-enF-Gz8A@mail.gmail.com>
X-Gm-Features: ATxdqUFcZRqjzxVskb_5zncAuac386QemHaQvCGNI8pZffnqZykRilBFVXJ90Gk
Message-ID: <CAHk-=wj+SJCYnBT-CZx0sCgWg1jovGZHb+OKs7kqN-enF-Gz8A@mail.gmail.com>
Subject: Re: Can we remove the sysfs() system call?
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Apr 2025 at 06:35, Christian Brauner <brauner@kernel.org> wrote:
>
> we've been carrying sysfs() around since forever and we marked the
> sysfs() system call as deprecated in 2018 iiuc.
>
> Should we try and get rid of this odd system call or at least flip the
> config switch to default to N instead of Y?

We can certainly try. But I bet it's used somewhere. Deprecation
warnings tend to mean nothing ;(

> (Another candidate that comes to mind is uselib().)

That one is already 'default n' since a few years ago, and only
enabled on some legacy architectures that still use a.out:

        default ALPHA || M68K || SPARC

so ...

          Linus

