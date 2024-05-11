Return-Path: <linux-fsdevel+bounces-19303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888338C2FAD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 07:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BA51C210F8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 05:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F65A47A4C;
	Sat, 11 May 2024 05:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KrGvHg8h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E1A24B5B
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 05:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715405555; cv=none; b=kJgEe6hAeZc0RHcr8I9NsD4C3gQb7CacUiDdBxr88m70S3A7aWYuov91nU52FZ4tz3Kjw00ZiV6Iwo8g/n4efN/yCLb8tOBtNZEAU53BOo+ixKz05dXWSDVIHHHytDkPuMVY0C8gDRwJc0/I148DfL84SFIpiSXddQ77BiE7RZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715405555; c=relaxed/simple;
	bh=iqYw9bmZ6TXG0GUJx6gRvBiJ32S6onpLGvt+Vv3UP90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRdCi7aI4wWJTWQlLgTfyqYAjLEpwpC52zJ/9xjRyJaHBAds2u1qR2cusBdu8Yd3JqgIRedwy3qiVq27FpV999r4torts3D7P3Eg0eOcnzponjIzTnEHdQnJUD1OcLzX76ICJLbdAlmDi1RgUTFev+gaM5xqFJgwZVtq1o6yeL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KrGvHg8h; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5a157a1cd1so670426566b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 22:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715405552; x=1716010352; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7laKngTxhb8aV9SiRPQ+FRltxsDJ6U8Bv16HhKJObVw=;
        b=KrGvHg8h6JsZT8dPh2TOXAqRF7sSEKe2cMdXybZ2Xy6sKpCUjTiM6AWsXYaAZNqQvF
         BB788WWw4PkRRMimgaV9ynHQYDsIQwYGcl/BW114/mg0iZ9IFdje6eWer++McNNbZEzJ
         WTovW8ewxk7gV+ICQpMPyYHYxcE2oRqyn4jak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715405552; x=1716010352;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7laKngTxhb8aV9SiRPQ+FRltxsDJ6U8Bv16HhKJObVw=;
        b=Z/zWaCrTugUMP8XoHE9sBoxyqMG41DPT1O9t9xKMKs8NA45lM1nQLFS06jlqzPPd7T
         A6+Qj29oQ8PDA8ZPfHtRXVgR+aKfNjCMueMDNbwefrmeJoYRaevJGr99Wv3Upcb649PY
         sGz7vp5rYXqzMUE8i6wtxX+mzWw1XgA22KCPbj94JoQG3ZyYVQPd1W8RmqXjfSeXUrVn
         3jzvJQ3FNEasz9n+l2gRlgJ+MDcAdxu8EbP03AwjvXxSxyQIHf/9uWDm/xOFUSnXF7OR
         rbYOE0bvtXS2tnIpB5Hps1eNdGLv6Ba4Zrly5f1J8+bq+U4UJNMBmLmJnBWI9OtNxEG0
         pmEA==
X-Forwarded-Encrypted: i=1; AJvYcCVFmPugMAdFUQF8eomz9KbUb7iUO4VCcB4MJ9OiopFe3/qkRI/QMun6qSfkwJSfREqbzeM5cXr+FnOQlH34YZQhXmgDAqE1exb4HeWVQw==
X-Gm-Message-State: AOJu0Yy9MtbvW/hT6nysfT/HqzdSHE8gTarP7R7kcFjiD0BuQljlydfV
	8hehNy+OkFGisoYOKLMbAe6IQ7lzYSMHtZiUUPUj0CAUegq+xow/Mo1EaiKRZmYzEdClEYfyakt
	0FYby6Q==
X-Google-Smtp-Source: AGHT+IGnGXu0MDAWRvPGA4W8br717NI3LHmZLx9nBRoYwXSFXKDR2pj6iVOEovBCmjkoa3U1TzWizg==
X-Received: by 2002:a50:9345:0:b0:56e:2493:e3c2 with SMTP id 4fb4d7f45d1cf-5734d7047c3mr2984535a12.37.1715405551724;
        Fri, 10 May 2024 22:32:31 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bea6603sm2726641a12.20.2024.05.10.22.32.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 22:32:31 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59cf8140d0so665616066b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 22:32:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX66KS7czxnYdEHavMssy/DUtAhn9OHwkixGW/r3DeJeAb11+YFAP/GOmZBL/XVLIG8zohWxE9I8sse557B2++UP0c2IdgtmwlkKCM9Ug==
X-Received: by 2002:a17:907:3208:b0:a5a:1562:5187 with SMTP id
 a640c23a62f3a-a5a2d66a3a4mr336979366b.55.1715405550654; Fri, 10 May 2024
 22:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511022729.35144-1-laoar.shao@gmail.com> <CAHk-=wjs8MYigx695jk4dvF2vVPQa92K9fW_e6Li-Czt=wEGYw@mail.gmail.com>
 <20240511033619.GZ2118490@ZenIV>
In-Reply-To: <20240511033619.GZ2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 10 May 2024 22:32:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNEvBCSx2BTqhu1bBOGpBdR+8hU4CeXrgLskrZz_ao0A@mail.gmail.com>
Message-ID: <CAHk-=whNEvBCSx2BTqhu1bBOGpBdR+8hU4CeXrgLskrZz_ao0A@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: dcache: Delete the associated dentry when
 deleting a file
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Yafang Shao <laoar.shao@gmail.com>, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, Wangkai <wangkai86@huawei.com>, 
	Colin Walters <walters@verbum.org>, Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 May 2024 at 20:36, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Said that, I seriously suspect that there are loads where it would become
> painful.  unlink() + creat() is _not_ a rare sequence, and this would
> shove an extra negative lookup into each of those.

The other side of this is that the "lots of negative dentries after
people have removed files" is definitely something that has come up
before as a latency problem.

So I do wonder if we've just been too worried about not changing the
status quo, and maybe the whole "make unlink() turn a positive dentry
into a negative one" was always a mis-optimization.

I do agree that we might have to do something more complicated, but I
think that before we just _assume_ we have to do that, maybe we should
just do the simple and stupid thing.

Because while "unlink and create" is most definitely a very real
pattern, maybe it's not really _so_ common that we should care about
it as a primary issue?

The reason to keep the negative dentry around is to avoid the
unnecessary "->lookup()" followed by "->create()" directory
operations.

But network filesystems - where that is _particularly_ expensive - end
up having done the whole ->atomic_open thing anyway, so maybe that
reason isn't as big of a deal as it used to be?

And I don't particularly like your "give people a flush ioctl" either.
There are security concerns with that one - both for timing and for
just basically messing with performance.

At the very least, I think it should require write permissions on the
directory you are flushing, but I really think we should instead aim
to be better about this in the first place.

Anyway, in how many loads is that "unlink -> create" pattern more than
a very occasional thing? Which is why I think maybe we're just
overthinking this and being too timid when saying "we should count
negative dentries or something".

                 Linus

