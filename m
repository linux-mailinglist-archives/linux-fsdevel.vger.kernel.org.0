Return-Path: <linux-fsdevel+bounces-58842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6562EB3209D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 18:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614F818995D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA26305E31;
	Fri, 22 Aug 2025 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/8zrMXI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626DA227B88;
	Fri, 22 Aug 2025 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755880572; cv=none; b=d2gSvbXhiwgUVN6x+lvMfZZ3hRGDkBZZVMtvrEAGGlqjwYIfnrNqTQQLkqA6sh4M80dvNhdnAi7zZfuDPDeeHpOAunDn4AFriUhK8IfshKZVcbTfzmokTUj73xYrhk4KbUsOwH/6eBnSuhfJNUxgVk6EU0w5rEuoRN3zgTfuJtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755880572; c=relaxed/simple;
	bh=zlac4ne9JQ4/3/nP0Z0Vm73XRoBj6s8jlsMxdeJxPqw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=AldCNDyx/dCgrv08x1fpQIi1AdSmGbKgVkctT7OLq1W0akUJuyULzkvPVyW/fJ2HId9NboobtECubfTYjOYOGKQ+YFCS/ZjoEMGfgaDkpUUkgeuolMroZowWGm0lpF4J6wrCm6UGgyxoErgL1102szREc27S3tToRRQYzCjGrZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/8zrMXI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2466443b37fso2076115ad.1;
        Fri, 22 Aug 2025 09:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755880566; x=1756485366; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7+W19uta0/JCBXS/qiCtU903XTuDwq5rwDIXqzAin5g=;
        b=I/8zrMXIKnKtUJbaBBSHwBoENG9czd+rNG73fRPNKW+Qykz6jIY9zX+0tgJP2ZDYoZ
         Au19MYkuRuxt0ZZjcJdUfVhDrjdhLfXMScgObuLxUiC+tQbqO5ZcvbQ7vQgsY593Oglb
         t2PHGlhFlB7sJc3FmMVdKjnSOp1kdh/SDat3rzEkPnnLA4Silalt5os5Rq5fU4ZlbmSh
         l1xOHjlVjVtPa9qN8oLkm/I8/aBfdV8w3r5sAQnYqcsGH8iC49s+jfrTg1q68824GVDf
         PKnwdqPcu9Qs8gbOYE+WRgknWSqQ75m/qqScW78ZsYYUnH52ss2s1wt75UgeOE/vlk2B
         dKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755880566; x=1756485366;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7+W19uta0/JCBXS/qiCtU903XTuDwq5rwDIXqzAin5g=;
        b=wClfiHbJVnzu9e2FGJPdix9AJNvoC0wmjuYgJgQf0HiRBRbH8S/+a2IJQeP5uf6aoU
         n7FFy65m6hY3sG95Nk1q0P/eF3xnJjxDnrWQSRKhmMpbAXNAbZXpVpxgFvjoDaodc3M5
         I8tTetaKxnxBPwcOQcEIHl7jDb6/jFIp+NEBJHIt+CdkzxwiULnwQtktDcxCVnu9KQGG
         8sTysPHdtFjQRQ7MO/P47wyjXVVRmR0NIVhAwHcbZxGocnaIBuIJ8MW06AbYCS76IXR+
         31TxApm/jvdc31HC+opFV4IDeU3OrMKHcHUV9nx64RGtybJNZwrt7JxyTardcHqUKtoS
         xfIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWszDiIi9una1aqbAOsrAA12LfXtHtqyWfb2utyT7UiZ/RcUibe2LGZvy6SlZE6nxg7ShAHmFC29O/YAEIsA==@vger.kernel.org, AJvYcCVO+oZhavGdMA+KQZ/qZvf0MAuZB/vaxW7MgekHZuo3BGR1fN8KY/OTdNyBej+qOjqBBZKwUfM9luCC1w==@vger.kernel.org, AJvYcCWgn4+G2BcpHnocd1eWD0QyI9CwFJLgEFhGaW00j1ZsSeIxegiyKEcYvST9y23bAE165tzG++zFLfQp@vger.kernel.org
X-Gm-Message-State: AOJu0YxRL5qP4cNoo+nGKsEHsviDJORiF1AH/sZOnC0k9O3fdiEipGe1
	weIk0ve0u4YXvfkkP621dEZ8/DJP2aW4/9fr888+c1TZVOzeM5H+48XaJLOCqg==
X-Gm-Gg: ASbGncttHGFqlHg9ULFKxl/oJ8QPt88M3HJ4zMpCygNxQliSmHpQQvK8ap7UumGjnR1
	2I/fNsg08VwDKWDsldqk0QZxlcmIQLo5x38ykGI/+Efn8FQm9JBovU2xHZuvFK3a7/ZNE6+J6ro
	40dJrs2B5Q2cMJmVHMUvgfJR9mPqETSegE1Aq1f10jWE3+72YNlSUa1kSpc2846pb71qjC2iDKe
	sd6X2pRNK2ZDkoNaz6oSQKO1lk6sjwNIze7+0mRUBTNnnduO5s/g718jmVH/qTxQOKlb18j1ccr
	RxLZ8FBeKm5BN10eAQSKnN+kDSlbhHACJBaXbybsTnVXKU2SkvA3zsQw+vT73FgR27PvefhY/it
	V74AEZTdi6AV4NA==
X-Google-Smtp-Source: AGHT+IHes62fiMS4IpdtBqzyPChw3yUsHCveBnOUgg26mM72ONAtG7ngUPK14OOYRwqiShG744/Arw==
X-Received: by 2002:a17:903:1b65:b0:246:5c65:4c52 with SMTP id d9443c01a7336-2465c654e07mr14567685ad.40.1755880566033;
        Fri, 22 Aug 2025 09:36:06 -0700 (PDT)
Received: from dw-tp ([171.76.85.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668871c05sm923695ad.117.2025.08.22.09.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 09:36:05 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Matthew Wilcox <willy@infradead.org>, "Darrick J. Wong" <djwong@kernel.org>
Cc: Fengnan Chang <changfengnan@bytedance.com>, brauner@kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] iomap: allow iomap using the per-cpu bio cache
In-Reply-To: <aKiP966iRv5gEBwm@casper.infradead.org>
Date: Fri, 22 Aug 2025 21:37:32 +0530
Message-ID: <877byv9w6z.fsf@gmail.com>
References: <20250822082606.66375-1-changfengnan@bytedance.com> <20250822150550.GP7942@frogsfrogsfrogs> <aKiP966iRv5gEBwm@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Aug 22, 2025 at 08:05:50AM -0700, Darrick J. Wong wrote:
>> On Fri, Aug 22, 2025 at 04:26:06PM +0800, Fengnan Chang wrote:
>> > When use io_uring with direct IO, we could use per-cpu bio cache
>> > from bio_alloc_bioset, So pass IOCB_ALLOC_CACHE flag to alloc
>> > bio helper.
>> >  
>> > +	if (iter->flags & IOMAP_ALLOC_CACHE)
>> > +		bio_opf |= REQ_ALLOC_CACHE;
>> 
>> Is there a reason /not/ to use the per-cpu bio cache unconditionally?
>
> AIUI it's not safe because completions might happen on a different CPU
> from the submission.

At max the bio de-queued from cpu X can be returned to cpu Y cache, this
shouldn't be unsafe right? e.g. bio_put_percpu_cache(). 
Not optimal for performance though.

Also even for io-uring the IRQ completions (non-polling requests) can
get routed to a different cpu then the submitting cpu, correct?
Then the completions (bio completion processing) are handled via IPIs on
the submtting cpu or based on the cache topology, right?

> At least, there's nowhere that sets REQ_ALLOC_CACHE unconditionally.
>
> This could do with some better documentation ..

Agreed. Looking at the history this got added for polling mode first but
later got enabled for even irq driven io-uring rw requests [1]. So it
make sense to understand if this can be added unconditionally for DIO
requests or not.

[1]: https://lore.kernel.org/io-uring/aab3521d49fd6c1ff6ea194c9e63d05565efc103.1666347703.git.asml.silence@gmail.com/

-ritesh

