Return-Path: <linux-fsdevel+bounces-13511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A98658709A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A80BFB2B093
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 18:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060C278B79;
	Mon,  4 Mar 2024 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ft8rsBeU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A3D78688
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577167; cv=none; b=dcaGO8r5aOLLzvsS9xz0f8GrtiZyE09CICoaYDG3GaD+Jd/IuFnuCbvObWgWNd6aQuKEu+IIjETHRLEmL0UZVX+4vzhKYpR8UC3Z5D0rNFMyfQYyGNDTWNDbAZaQPgK92cUkluoEPY8+pb3Hs0EIdjGtviEPUAWJmczYYR3jyUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577167; c=relaxed/simple;
	bh=KtfWqAbL60dmDmNJlm82ls0DTRmdSK6fujqZ9REQ7jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUDwcKxWanLc4wFVt4l4RrGndMiKlJiLhfocXb/Rd7+vDxsRRvtL9yuZuvCACwUsHF3/sHBSkqrPIMGpbhM7VXeBmlZW334ySLZB/iGwG30/8Gs32EIjLCfMLNU6YJMWpvT188/p/utzMB9dWMzbXp6dNWy5pboCOXthPWw2yLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ft8rsBeU; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a44d084bfe1so301322666b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 10:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709577164; x=1710181964; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LczxhZqLEWu5Pcwo59Oo1yTNgbAQRYyUzuwaCxJZY78=;
        b=Ft8rsBeUc3g2FBu570fszPITOVyV/dDk3foDUKKBv8aAQ/gbUg0XxSKEXwuKebOtX4
         kgh/S3Kklx2j2onoMqiGVb5VEYJzACF25gcmzR23PIX5+SFPiWr+jqixw9i43Z/3Bfw3
         X5KmbeE0mGedJ8VZjSq3SXrh2F57FdmOHbdM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709577164; x=1710181964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LczxhZqLEWu5Pcwo59Oo1yTNgbAQRYyUzuwaCxJZY78=;
        b=dj5wmFXnzjXlTtLVzkOnFeeMRfhRiS4fRysN2ZBSy2a4gPRk5lxr/lu5kclj6lVbHP
         s9Ierp/Wh9uD4PutpRJLrLLBR1c0OQpUXWZlDsRHS1BclNXrpY8PhijHMk6S/62kCr5l
         hHq+Mt8owIyw8xVaTZaUKtQsy54OwKSeRvPvHlimEC+YeOMSSsr+dDwtllPi6ZXdx1eh
         ajfP0eHG67lpRgidlGBI+Fxp+S0/4uznACMQB/GgKsSfYQowx33oaQqKWyg26EslhEIB
         o1bAddk6oZfvyhaoY/97a/sYEudHk7++eoYE9fJPTH0KuEKTgfIn02nHYlc3mm3Capd0
         h8pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyT533PmdD2O9BE+2jdTcXWu9erBDbNpCUdky9sKDuvvf9yRMxsVzUZm2f+SaDaIxg/i5NNEyu5XnI6O6zTXXhyOV6PAC3K7wgjfaA9Q==
X-Gm-Message-State: AOJu0Yx67lx+FkK3YEZFOwIlS1USEKlf8UmpueaURN+2yq/ld5iYGQHn
	PfMtX5p3QWa48JELnajWqSqQiJmJnHrftD23G69JYObhyXllsFLTfXOXts1U9a9XI5dbi9hyGBu
	g1lY=
X-Google-Smtp-Source: AGHT+IFC3rQF4L7LQzYmv8T8VbM4I6iU3Bk3obuz1Pm7PumXV2Xw1e3QoCmCZMoiZh4esRb6sz2s9g==
X-Received: by 2002:a17:906:ad89:b0:a45:5109:5206 with SMTP id la9-20020a170906ad8900b00a4551095206mr1898735ejb.64.1709577163933;
        Mon, 04 Mar 2024 10:32:43 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id mp4-20020a1709071b0400b00a3d11feb32esm5164731ejc.186.2024.03.04.10.32.42
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 10:32:43 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56682b85220so7755029a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 10:32:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3SAYXH+CTJulRRt8SXIaIj3OSXk03srXz14Gvcpam5+j/RMIgHH6MMlj5Z7MXFeQsqfiTYSz9xu3ICDl2EftvYXmnmewc3CyBEN9xtw==
X-Received: by 2002:a17:906:8da:b0:a3f:ab4d:f7e3 with SMTP id
 o26-20020a17090608da00b00a3fab4df7e3mr7570338eje.0.1709577161818; Mon, 04 Mar
 2024 10:32:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925120309.1731676-1-dhowells@redhat.com> <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com> <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
 <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com>
 <e985429e-5fc4-a175-0564-5bb4ca8f662c@huawei.com> <CAHk-=wh06M-1c9h7wZzZ=1KqooAmazy_qESh2oCcv7vg-sY6NQ@mail.gmail.com>
 <CAHk-=wiBJRgA3iNqihR7uuft=5rog425X_b3uvgroG3fBhktwQ@mail.gmail.com> <769021.1709553367@warthog.procyon.org.uk>
In-Reply-To: <769021.1709553367@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 4 Mar 2024 10:32:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgrmt875HJNUY9a-ti0M6M1m6jHEGvCSjcOfXy_E7_X_w@mail.gmail.com>
Message-ID: <CAHk-=wgrmt875HJNUY9a-ti0M6M1m6jHEGvCSjcOfXy_E7_X_w@mail.gmail.com>
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: David Howells <dhowells@redhat.com>
Cc: Tong Tiangen <tongtiangen@huawei.com>, Al Viro <viro@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Christian Brauner <christian@brauner.io>, 
	David Laight <David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 03:56, David Howells <dhowells@redhat.com> wrote:
>
> That said, I wonder if:
>
>         #ifdef copy_mc_to_kernel
>
> should be:
>
>         #ifdef CONFIG_ARCH_HAS_COPY_MC

Hmm. Maybe. We do have that

  #ifdef copy_mc_to_kernel

pattern already in <linux/uaccess.h>, so clearly we've done it both ways.

I personally like the "just test for the thing you are using" model,
which is then why I did it that way, but I don't have hugely strong
opinions on it.

> and whether it's possible to find out dynamically if MCEs can occur at all.

I really wanted to do something like that, and look at the source page
to decide "is this a pmem page that can cause machine checks", but I
didn't find any obvious way to do that.

Improvement suggestions more than welcome.

               Linus

