Return-Path: <linux-fsdevel+bounces-12981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B759869C3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 17:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF611F2467A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 16:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B21E200A0;
	Tue, 27 Feb 2024 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WKSH+jb/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66101F61C
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051701; cv=none; b=N/B8Ql5PEhKFEzYukCPFHBsz4WGEKP+Q7bZ6eE2G+CsZSpYnyCqoaVG7yFxX23ZLADORs600R/Kl7++jIjI4J5Uhl2aZi4DbFLGzwpywSKWpm1q5juYnbUoK0vq+AFmKMQ/t1BLWINt7jObBg/s76X01nWQxs+FH29zlu8RLGgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051701; c=relaxed/simple;
	bh=lPQa5RxpigNzA71YnzPbRX2zgaSmJ6QbBBpf0Jj1b8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScH4a5hIiqWdnm4WSJgI06RthV5XQJ2bxwCzGJOjGwM4av88cuU91/zC2Cj2PcQMsRaRXZgf9SLaxUG7aJsiy4UX9t6w00fyCyClbrZfGOzHVIKcu+eUH5S7/71Ct7efAXVIeNYgKX2Fg9NEkynaTJ549hSkheHDXMJAWG9Ai6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WKSH+jb/; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d269b2ff48so53858421fa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 08:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709051698; x=1709656498; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X4CCC7HPr1xJPYsLBko3V43q/xPr3hyjE8Q6yCF6mfM=;
        b=WKSH+jb/ymSeWZwUt0KMhZNWBS7Cm4RNacrzYi40b9cCy9zwKdpQfV2DPAzryfn0gf
         /xJCcnMStvKBylPbYg7Jt3N1WK7+jSA3om+3D/OkHrLL8qSUWgrSDimdWZW5x0Yoy/eX
         uCgKc8/UtcsgL489pzAzMXxBiyg7ZcsXFiuQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709051698; x=1709656498;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4CCC7HPr1xJPYsLBko3V43q/xPr3hyjE8Q6yCF6mfM=;
        b=kHzexP2rDru6h4O5c/5d+cVhPVc4jIsOAxGjpsM9TWfx3ed60BuBZ+B9/lG6BNRzQe
         NE1+sEHGxgUoOOjqWtUDFRpPn5g0CMWRpWmsUi9yWC/FQ36uVCJkpA/DJnpvfLbMQNDP
         hGkaW8NqiziqOIYdrg7qIONna7ErKG/sD/L/otcNFXDCW2cK5LOYzvuRHjSkX24iheoO
         KNHwBN7aDIVZIcWz/QHTkGYnp7QVXNrSnNFTnT+Ue5gY/DeUp6wOfVxsFvvL4RgqRBqw
         1y6kItQO0ElKqIUKGqLIBh1FJ6qkz0hO9Ct/YANoIPVH/Pd/GDgKno28J7Pb2btWP+3L
         lDFg==
X-Forwarded-Encrypted: i=1; AJvYcCXPTH4t8EFL4UqHpmNybuQOePSUyUf+54nUuUajj9CEBkL7mtMsHsQ8dqMvqELPHHPC+NeaUNcagh7oBAH38fbHCKnQ0RON0t8bham78g==
X-Gm-Message-State: AOJu0YwnPK/5ETzPL9D+4vuDhLEos9Q+0nTSMDJOWuJ57KLX1VoJFWao
	t1xDgaPoQhLWKSvC2FFfc2jZjw0Oxw+meFiFXLdn6XNTOOR0IoG7xbtr9br2fAYEgmHKjh4InA5
	CN70=
X-Google-Smtp-Source: AGHT+IGs/CB8Lwx6wQDBcvsOUi+p8du+oLlMs4Fhh6pJACTTcx1ibAEihBhEVD3Ajb7oq/YzeFINVw==
X-Received: by 2002:a2e:820b:0:b0:2d2:4c6d:e08d with SMTP id w11-20020a2e820b000000b002d24c6de08dmr6435762ljg.21.1709051697650;
        Tue, 27 Feb 2024 08:34:57 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id a38-20020a2ebea6000000b002d28c2b238csm699128ljr.57.2024.02.27.08.34.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 08:34:56 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512b29f82d1so6123374e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 08:34:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWAufpXgD5ryc+r8gEQmlmPiBLswVDBnh7ckMPLxFMen7sn8cAEPWKmygwqZCCu2/RyiiTfiUjfTa+S4p0UjrDJjfgl/F8UaWONV3kkTw==
X-Received: by 2002:a05:6512:3d10:b0:513:3b3:e6f9 with SMTP id
 d16-20020a0565123d1000b0051303b3e6f9mr2440207lfv.26.1709051696282; Tue, 27
 Feb 2024 08:34:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zds8T9O4AYAmdS9d@casper.infradead.org> <CAHk-=wgVPHPPjZPoV8E_q59L7i8zFjHo_5hHo_+qECYuy7FF6g@mail.gmail.com>
 <Zduto30LUEqIHg4h@casper.infradead.org> <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
 <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
 <Zdv8dujdOg0dD53k@duke.home> <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
 <CAHk-=wjOogaW0yLoUqQ0WfQ=etPA4cOFLy56VYCnHVU_DOMLrg@mail.gmail.com>
 <CAHk-=whFzKO+Vx2f8h72m7ysiEP2Thubp3EaZPa7kuoJb0k=ig@mail.gmail.com> <yfzkhghkh36ww5nzmkdrdpcjy6w5v6us55ccmnh2phjla25mmz@xomuheona22l>
In-Reply-To: <yfzkhghkh36ww5nzmkdrdpcjy6w5v6us55ccmnh2phjla25mmz@xomuheona22l>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Feb 2024 08:34:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjRXSvwq70=G3gDPoaxd3R0PDOnYj7fxOhZ=esiNjFvrA@mail.gmail.com>
Message-ID: <CAHk-=wjRXSvwq70=G3gDPoaxd3R0PDOnYj7fxOhZ=esiNjFvrA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Al Viro <viro@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	Daniel Gomez <da.gomez@samsung.com>, Pankaj Raghav <p.raghav@samsung.com>, 
	Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, 
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Feb 2024 at 23:22, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Only rough testing, but  this is looking like around a 25% performance
> increase doing 4k random reads on a 1G file with fio, 8 jobs, on my
> Ryzen 5950x - 16.7M -> 21.4M iops, very roughly. fio's a pig and we're
> only spending half our cpu time in the kernel, so the buffered read path
> is actually getting 40% or 50% faster.
>
> So I'd say that's substantial.

No,  you're doing something wrong. The new fastread logic only
triggers for reads <= 128 bytes, so you must have done some other
major change (like built a kernel without the mitigations, and
compared it to one with mitigations - that would easily be 25%
depending on hardware).

                  Linus

