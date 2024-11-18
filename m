Return-Path: <linux-fsdevel+bounces-35117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 650749D1830
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 19:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221C1280F36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 18:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DA11E0E07;
	Mon, 18 Nov 2024 18:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V+8Ho1SF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6876D1E0E02
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 18:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731954603; cv=none; b=rmynosAyLoU2hPbbMkgImBQFI4BDnDGl12pVNQEPJlJMXiyi7jTsDD5AiegbLNtCPJB31iWpWW4+xVfcivs7N6WrxQgapKfhMfdUyYhr0dQ7cMlFPvMMeXVZd1tme61fH36INKB2tshfqaOAzlepmYcUsg0gpnEfB+j2txcEmFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731954603; c=relaxed/simple;
	bh=S5Qt9qS6QLVBwhpt3kD373BYFKzAK/2DH3wvxC89m54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFzAAds4YVEB7Rz32EvVTcafDMgMenMBSgACc/zxoCYShfIL4IdhXlo1F4dQoGojf9Q0GbUTAc+V+eGhfJ7Nl5nJM+0b2t5KnN+W0HIVEn+lwkQDUR9JVW308PIeuArqma0V0Ehw+2fDi65htuWKCasD+GJPiPnrmFNf/sZmIYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V+8Ho1SF; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso10360566b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 10:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731954600; x=1732559400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I59dkoh0V3qfBXYRyrpc9kFXQj8ZHogw+uWNVlQrPH8=;
        b=V+8Ho1SF/TNTGatg5zz/oYcUT3cXvIMwLbC9/zn2MCLDkYqN21ECXUJ6MnOxlnRvPu
         YEL12E1PVtewvB9MlHuvVnRJvXEX1MM7/UiAGtDN1Un6T7AqS6QR7eF0pqnvFVU40kAC
         jSWLW3Eax/B1dUFZbqqB3RgYxHA8Jb1Dmz8iA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731954600; x=1732559400;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I59dkoh0V3qfBXYRyrpc9kFXQj8ZHogw+uWNVlQrPH8=;
        b=iTQ1t5jDUwMIOTiYzFZajSTy4lZ4DPdEd1lWHovLwe9a3MlCWUnK0x/XvD5lIWr2c4
         UEVO/CWqgflt9LJAo13G2oSVtU2kRimtVbZv/vgylro1PYm2CPBIDxUy5enkDtfj2cV0
         1kV8HmOPxAuJ6zx1l6mpCBpC7ZFzYHJtG216F1ju4uOQ0LFPKZ1vNOyt7tu0FI5G3dZH
         hQjhKUQfyAS++NbugvaLDAUlfAQxAbHEBghHuQlEM7SPRN7tV3I3XLFYmujZnelwU63n
         afIoztsJBAxQ/vy5BiZACfelfGhXFZLkRkHEZh6rwqrkQAEy3bGpqaRMQYubwEZHPmId
         nqkg==
X-Gm-Message-State: AOJu0YxQ9WSt8/Yyh9WJ1dtOHixfSJuJeTAYYN7b1O2aPEE1IYu96TvT
	tipcqs+zprzG7llrnUitBRMvsXHeE7eR9X6f2nbidINWukt7B7GbURCEWQMy3BbHXt+7A5vH7rS
	QBrLSUg==
X-Google-Smtp-Source: AGHT+IEOw4Jpj/JsMg+Sh0y4E+uZRZPQ4x55/2EJx+Kre/1eCbzku1T3YDpvozv/3iN8k4P1ndTWDQ==
X-Received: by 2002:a17:907:7ba3:b0:a9e:45e6:42cb with SMTP id a640c23a62f3a-aa4834263aemr1373953066b.18.1731954599682;
        Mon, 18 Nov 2024 10:29:59 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df51ab1sm562926066b.57.2024.11.18.10.29.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 10:29:58 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so16667066b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 10:29:58 -0800 (PST)
X-Received: by 2002:a17:907:5ca:b0:aa1:e050:89 with SMTP id
 a640c23a62f3a-aa483482130mr1297287466b.25.1731954598521; Mon, 18 Nov 2024
 10:29:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115-vfs-netfs-7df3b2479ea4@brauner>
In-Reply-To: <20241115-vfs-netfs-7df3b2479ea4@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 18 Nov 2024 10:29:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjCHJc--j0mLyOsWQ1Qhk0f5zq+sBdiK7wp9wmFHV=Q2g@mail.gmail.com>
Message-ID: <CAHk-=wjCHJc--j0mLyOsWQ1Qhk0f5zq+sBdiK7wp9wmFHV=Q2g@mail.gmail.com>
Subject: Re: [GIT PULL] vfs netfs
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Nov 2024 at 06:00, Christian Brauner <brauner@kernel.org> wrote:
>
> A pidfs patch ended up in the branch and I didn't notice it. I decided
> to leave it in here instead of rebasing the whole branch.

What happened here?

Not only isn't there a pidfs patch in here, it also doesn't have the
afs patches you claim it has, because all of those came in long ago in
commit a5f24c795513: "Pull vfs fixes from Christian Brauner".

So I've pulled this, but your pull request was all wonky because you
used some odd base commit.

              Linus

