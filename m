Return-Path: <linux-fsdevel+bounces-17407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EC18AD077
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 17:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E00289F3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 15:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84D0153505;
	Mon, 22 Apr 2024 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="I1uDYXcw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BB31534EF
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Apr 2024 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799170; cv=none; b=ZNnlG3HPZg7Py8SHbSHPdGns1QYfeq5WKef9ETjch5U0FLGTpb48TaJy6VfIQEIjW13HyWjf29ssTF1lxWdjUuKYVysV+zL4fo+ouv2U9z7/ocSep1YDaFqfQ/1aOoBMS642WKuEdgMal7AxNq6tgqFvCjXkUetZH9eBU7r8Jm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799170; c=relaxed/simple;
	bh=J/L1wGSJw3wYTnWnsSxFTup1IHi4LPWiAUS491ylDsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdjsbxNtwvOhC3W7q1TwebCezoHRJnAyfBK0p66T0aHum4Ag+LxBloj97LK5bhFvcWeobjpIfF4Wj+Nbus0/nUDaRSpa7HE6IfS5qCtrTI+VV0QT6SqIuTRzTlf8fz82NspRTIDRfsPmCF5n7jUUSLV88oUxbALnFGwY/9iaKqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=I1uDYXcw; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a55ab8e8766so169146266b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Apr 2024 08:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1713799165; x=1714403965; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J/L1wGSJw3wYTnWnsSxFTup1IHi4LPWiAUS491ylDsE=;
        b=I1uDYXcwhkuN8lSFVv/MJhXw9f7yPs15Y6oqeaPr4gXv1lEvVTTH7Lr0AeG2fOdOfP
         xgu7QneCKy1Yd4Cle/LWH4RopfFbt10ypgOGhw/Rt4c7hg2Vvm8+tNVTBiQ87fLtSWZ8
         Qlu5R6rMrtbwI/KzuSJ3KlHngtSSuAv89TxFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713799165; x=1714403965;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/L1wGSJw3wYTnWnsSxFTup1IHi4LPWiAUS491ylDsE=;
        b=hmC+puTYMbDFQyg+In4TZOA+XGJE8fZc1vJOgNZZLNqGOlqrpuLiezFMSvW1V6VFtk
         nnUB+SW57dQLp8o9YX1HEjDWgcs84J9EabMTLG7RbWcNOYRJ1g2Sj+JPF4fvxiPq6+Yh
         rpqQKoANz9aCMbW6md+rYyslJ0oRXfpTTLNe8c/vOJ4/mYSTIPscoYNwL/6JEIdlJp3/
         riNZ+C2ygz0OOSxuRuuFmIQ/kEUra9zQNdW3Gf7YKivWI6n0rOLfysikYiH70ADeFiSA
         eiRuqHAu4VpRkoNoUTIpNEJpNchX4fwciAjw5NoGx3kvn+YE+4TCmBFu9rLxgHxqfJxv
         ocIg==
X-Forwarded-Encrypted: i=1; AJvYcCXRXbfHGZo+2f9DRUC9qThhMaOPCaTwog2wRqLM3Jk9tiCNwI5YEVGkNh/U2emDiNbJUv5jy/GsflETpB3MI0EXHzuUJx9wJCbVM8/ypw==
X-Gm-Message-State: AOJu0Yy1F638JxzBMwishJbVEau0zcFuJxY1a6fR42lc7J9RKk5YTgnx
	oJ8KWfaXMB9HmjGijiIshydKuVkgNAT5lfCDfwxAZXNTvr48XjrVrThYlm3H+ww6lQfjH8w4N4L
	gTFSuhMdQvS8e64tDZQ1g/LIW97U31Se3F5VjVw==
X-Google-Smtp-Source: AGHT+IEVg4uJdVmXxw7Iq/Jw91tIuuwRuH+uF8vJTwTF/ZZhhKDWs0/JKaXQdBhFDDYppdH3JCa+a4R1v1Hr4yiJ/z0=
X-Received: by 2002:a17:906:6092:b0:a52:387b:8391 with SMTP id
 t18-20020a170906609200b00a52387b8391mr6020148ejj.34.1713799164751; Mon, 22
 Apr 2024 08:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422064008.936525-1-amir73il@gmail.com>
In-Reply-To: <20240422064008.936525-1-amir73il@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 22 Apr 2024 17:19:13 +0200
Message-ID: <CAJfpegsT1WS+5wpxu60b0yX1gOTuKiHxNUQaWPxtnJcZJG+QFA@mail.gmail.com>
Subject: Re: [PATCH] fuse: verify zero padding in fuse_backing_map
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, Daniel Rosenberg <drosen@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Apr 2024 at 08:40, Amir Goldstein <amir73il@gmail.com> wrote:
>
> To allow us extending the interface in the future.
>
> Fixes: 44350256ab94 ("fuse: implement ioctls to manage backing files")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Applied, thanks.

Miklos

