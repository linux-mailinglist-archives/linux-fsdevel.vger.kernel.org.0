Return-Path: <linux-fsdevel+bounces-59415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 065D3B388E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 19:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE374630E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 17:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB68C26E706;
	Wed, 27 Aug 2025 17:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cgi4zJS4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D13273F9
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756316983; cv=none; b=TxB+9POjm7SrQJ2b53dTZLyPJDWvxxcX1b+77RSAywRyXsoOQXQcGUWEgTy+Uy5H9+gxpOAXZeUaiO2ftUoivaIndvO9aeJQMZ6TkJljdG/i0k6VN0g86oEqja6krWeJfbiyZoqAHFDDg/Nezy1n32OYisBGFVvsgRNpE8JUivM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756316983; c=relaxed/simple;
	bh=lT0WPddHkNFlFQ/gVRpJDkkbQIbmB/gYjhBf+YW67Ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q27DuCla+Co+vKSvqbE1AduIBtugg4CR4igyeaqvFDZ+gsarYpSPE4/SH3YnyBPprSO0SexcbDgUB6bVYsRHuBiW3aqiNXoijspt3VGF89laC8yl0/On7kvdgAMQbVimrIoKiACHa00hMJmwBUfK5Gl95MhhQZbvEd01EXyW3xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cgi4zJS4; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb732eee6so13659166b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 10:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756316979; x=1756921779; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SFhZJyxKoNnrXFKElWwUmQh9rmXPIWdq2wVO7j3KpbY=;
        b=cgi4zJS4tyU4+fgXvesqJKROWFBVJXLGvQz2MBgCg/Y0g7HjxCWXiLN4gL5idNqq/E
         xefcSVqYggktuhPfo6WtGb7fHSxvFp5dur3Vu+sjZ2H8KVXAuN5W2AfTugVUlyEvncz/
         7cn8G02biBLk6HYU3+wqJf18LeCZpmj43hM3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756316979; x=1756921779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SFhZJyxKoNnrXFKElWwUmQh9rmXPIWdq2wVO7j3KpbY=;
        b=G/Wx4dvv1Ug66QGtHCB6cWXTzCZUYMof0j/q4qr8Q16ytac5dZ1CGdL7UlCC7Kyz/Z
         rNoCUkpxUDvusJJJtUYUoiwQ+0ywE2Kjk3z/JYmzR3WlkGJi1rAMeeUIIiLMU9oYjj8z
         OebSvo68riQwH4fDPY4K0nGgT3DwiMzybsNQtXFvXgyNAQ6lBywO/AFVql/1C7253/aL
         YMjNGOfiROdVs/u5589FRfdE5qCurd1z0FySu8hZXMmyRuq6d5ksf9z0H7DYLUUToWzU
         9oBh+5yeIsuMqy4M/vpI2rVEc+H0C9vVxWbuZet/Awf/If6n975xA0CWuTR39YakFQcp
         5QHA==
X-Forwarded-Encrypted: i=1; AJvYcCULbnKjTwBuPQBkJRgp4sc27QhZpMElHJ0nu6Xuiclny0DFUqisAZ8wk1Nxrj9mytBfFjg7zZjnviq3+rfC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+daY+2sg1qxtHzeES+ysSBU4tDG3ww74k0AsjCPLtk3rFAI+3
	ekexq9gPCXmWtnL17qI1T2U4iHYB0aLYFpZ0ScSb/YhIb1tB7gD5phFLR+tGwWgH+UYPMtxnVQb
	Bp7hkOag=
X-Gm-Gg: ASbGncsCP0XCtv02ll1om1LWM+XIoMuhzgIFLfhdH+D1N/63Cj+yORCK+bj3hlDxU6T
	dVYegA81SbZ1nxO7svDAzbiCiWQHNrU3epa8QnuoCmdMFubCRcNmfvw6eJB/n/VDhuRMVV+26aI
	o32l5i6vpCCU3Gq1k0YCy8hp56SyMBuKPT2b+Xk+6D6c1w2w+2acu4amDezSxdv6EhttBz4wJdZ
	yTPYKh3mWvrGMjTe6J2WGcTUnZ1N30WGkj4+kkHvuSAwa6D5COEyWujg4glYZW/2yXZOCeY91Yc
	2pPmttBaDAP34YpwF+P2p26xlqdKrlqhcoJaLUofLk+yR5d1GQfYf3G/UjiwXFqwGUoNHnxWXwf
	8y+adhYbJQpXawnBsWlAzNL8dvSH9QdVLjkGM1tN384ncHpymB/o4JA4HKfOXHdHud0OqfvP6CY
	M/9S1n1+9LrrtWjW7MaQ==
X-Google-Smtp-Source: AGHT+IG9lhIKAW4FX+bNbnvn6qdgUHcC+62aT9BUzFnt5zX8pjfxRO9vHUt8w4O160EhJhJ4bb6lVQ==
X-Received: by 2002:a17:907:7e90:b0:afe:8a40:49bb with SMTP id a640c23a62f3a-afe8a404c32mr890085666b.22.1756316979142;
        Wed, 27 Aug 2025 10:49:39 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe89bd7acesm630191366b.73.2025.08.27.10.49.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 10:49:38 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61c22dceb25so94535a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 10:49:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqympKgfrQ3nnQNgkW8nxu9IKKLE4WBt/QVgVLmQCAV3idooszrWwsRrYDKViYpbvSTGsNHVjtaxInToc0@vger.kernel.org
X-Received: by 2002:a05:6402:5cd:b0:61a:9385:c785 with SMTP id
 4fb4d7f45d1cf-61c1b9227c1mr14854264a12.36.1756316977928; Wed, 27 Aug 2025
 10:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825044046.GI39973@ZenIV> <20250825-glanz-qualm-bcbae4e2c683@brauner>
 <20250825161114.GM39973@ZenIV> <20250825174312.GQ39973@ZenIV>
 <20250826-umbenannt-bersten-c42dd9c4dc6a@brauner> <CAHk-=whBm4Y=962=HuYNpbmYBEq-7X8O_aOAPQpqFKv5h5UbSA@mail.gmail.com>
In-Reply-To: <CAHk-=whBm4Y=962=HuYNpbmYBEq-7X8O_aOAPQpqFKv5h5UbSA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Aug 2025 10:49:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWD9Kyzyy53iL=r4Qp68jhySp+8pHxfqfcxT3amoj5Bw@mail.gmail.com>
X-Gm-Features: Ac12FXyQVuEdZ4_c00qombxn2Nx7cGM9gIvI8LGJIUWdhYAQXCWwb3D9xVmVxQ0
Message-ID: <CAHk-=wgWD9Kyzyy53iL=r4Qp68jhySp+8pHxfqfcxT3amoj5Bw@mail.gmail.com>
Subject: Re: [PATCHED][RFC][CFT] mount-related stuff
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 10:19, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And no, some "maybe people add acks or context later" is not a valid
> reason to add a link. If there was no discussion about it at the time
> it was committed, a link to some mailing list posting by definition
> doesn't explain why the commit exists.

Side note: relevant later discussion of patches obviously does happen,
but it's actually more likely to be independent of the mailing list
posting, and instead refer to the commit ID - and the shortlog of the
commit - than to the original posting.

Yes, some bots do obviously traverse the mailing list for patch series
to look at and test, but those bots are the ones that the developer /
maintainer should have reacted to *before* the commit goes upstream,
so finding them after-the-fact is simply not a high priority.

A much more common thing is that the "context added later" is a result
of people and bots reporting problems with a commit that has hit the
git trees, and they do *not* generally reply to the original posting.

So instead those much more relevant reports will typically make an
entirely new thread, mentioning the commit ID and the subject line.

Which is why I think it is so bass-ackwards to add a link to the
posting in the commit. That literally is useless garbage unless the
posting generated discussion. The link to the posting is not likely to
be the most relevant thing: it tends to be *much* more productive to
instead search lore for the commit ID and the subject line of the
commit.

That will obviously find the original posting of the patch too, but it
will *also* find those much more relevant and likely reports about
people/bots reporting issues with a commit in the git tree.

This is why I hate those pointless links so much. They are worthless
garbage. And the "but maybe somebody adds context later" is
intellectually dishonest, since that later context is likely *not*
found behind that link, but through other means entirely.

               Linus

