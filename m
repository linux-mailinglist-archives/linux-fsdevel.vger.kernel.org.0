Return-Path: <linux-fsdevel+bounces-43114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F3DA4E275
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 16:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6524188CF0B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 15:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E612C25F989;
	Tue,  4 Mar 2025 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqNdyrXK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B508525BAB9;
	Tue,  4 Mar 2025 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100343; cv=none; b=g/nWUr1dutA2BgAK7BGGjV36Lo7QpoYiKErXbg8EBYUSNqsskf3m9byb3zRr3tnd9r967vEY/ZjeJETGIJMfYgZileTXqWWvckHQZLRgsqSNJa2IloCGoUdmiHQ7qsxM35JjHYeMDSSAVHI9JRyFK6Z5GP+kANSyaw5F2fnDi4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100343; c=relaxed/simple;
	bh=D4YcNmkI17JcMAmDab9BoC3TRgIvy78YbJHpp8JLY3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GgyoWeXcQc6+axZ57uJO3A2cXPuXIIAHt3xE6ubJXtdDOLUsTvh0pydHc6MmjnLC0UFbxq81wabcua2lOt+XOc8LUrlofLf2IuLXeXy/agV90ffTAyVsEKrbBMXCBdFLokfWxiKHhkW0o5GU8Y3Fj+DL3Saidf4PSf/rhrxTgYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqNdyrXK; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e4bed34bccso8031078a12.3;
        Tue, 04 Mar 2025 06:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741100340; x=1741705140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6q23FkBs0G0M9uG5SQsvl59j8Mn0t4OB9yLyS11XbfY=;
        b=fqNdyrXKpBP2j5nxNVEJvCJScP7CmVIA71Kwor7E/zgPwDW01pam9TAxAWgfKC3tUr
         zLNyyEe5ktCNzhTLMsxltQZQob98v7pxp+sh62c/OjoAf8Byu8MqRAiNs6TiWb2mLuXx
         eih6s1tHdWYNy9IhTi7R2qt9ns4/mX2NB9zKjLzp3rFRw3IDtTCBkN3a91tvI2Jo0I6r
         Yhw2SQDCxbSu+fsbLLd+ZKVFO2TwTOXznI49HIfbxtu3nPMRBmuoosUx9NJ/U5OC22u/
         rVKYif81QW3qgcUiDFytuUPsUdnw7kG48uhnABXlKPv3Ap3UyL5Y6e1qNww5HMN0G7b9
         +PHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741100340; x=1741705140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6q23FkBs0G0M9uG5SQsvl59j8Mn0t4OB9yLyS11XbfY=;
        b=aQAHrYcFvldgqxJ+8iCOPQf+kw8KNHbcS8Blof74ZbNk5wtdG+OUS/0kdA2GoNobYb
         Wrgm08S+WcEloa8tEmbGroOIEQNfRRGWaEhQO8sU4nvMnZotaaN6cDJ5+Ye5G7xrKY3B
         KhdnTEEUjUReWVCJ12NQjTRzhdj1h/x0Kq3haqCwMi7irpiuAn7hAd5enUqLC/WfCRk6
         6m15PPgCkBe13PguVJ6j145/rL7nYhY6GSQKUeuRp45Ip5O9pKwGcoLDnm1WmGGXB7gL
         GhD3fcepUE9FRetA0+6AzRqZozPxaRxgOSrOj+hWSrrA1NRixFa6tHrU/eiIQR6sO6kt
         cvsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4ciEtEMzGyhKRCFJ2hxZf3TdwyLxbR1Lk1p7rAe8SM2E9m4qfxn7hPGQbwPst5SNPQkd94oKr1NoF7rNp@vger.kernel.org, AJvYcCXVerfrolZyYIrjBtqbPDV7FNnukstaOUnyG8xm7Du8UwFujcipH6tNLRIfaIr/MSErS5qCPcChOZCjltsN@vger.kernel.org
X-Gm-Message-State: AOJu0Yyocl1heqT1x2DFo+ZvF8tPFe/r3xsVXb+fiWY4p+0rtgKSI+Y+
	t1eqnPlRdkvC8807QI5yqY2E3uCgVMfsb6HxHNWygLd8txObDZ33re/8jOKOXu8wFs008rYJudF
	PqLlnv3E/aqi6kKUljr6K9oZs50A=
X-Gm-Gg: ASbGncsvH7FlKj5Va/8po0ay8bJ4aIoKpuhSHaseujR+Z/vFwUSyEM4URoS5wfMaQPv
	K8DBtvvMftXElggZ0+NCYncYA5vV/bye81d+mqk++vn9HXkx+L2+t2ULXLBGjFbb1eHziLI2cOI
	gaJm9bUyur9JTsojDWEpKM7Dd1
X-Google-Smtp-Source: AGHT+IGCNnhECb7Np3uW3fUWywUVpYgDwvIaP/KUU1AiHnLMF+DqOVDEnPHdbVx7fH/CpOpbIm3mQnj0U1qAZNBvLLM=
X-Received: by 2002:a05:6402:358c:b0:5e5:2c0a:448e with SMTP id
 4fb4d7f45d1cf-5e52c0a4c52mr14886070a12.6.1741100339682; Tue, 04 Mar 2025
 06:58:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303230409.452687-1-mjguzik@gmail.com> <20250303230409.452687-2-mjguzik@gmail.com>
 <20250304140726.GD26141@redhat.com>
In-Reply-To: <20250304140726.GD26141@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 4 Mar 2025 15:58:47 +0100
X-Gm-Features: AQ5f1JpSa7e-GdiaaPjYs_YULNoyhTuFfUJjb-GCh1Qr7NUS3Orbw_EJwZw2c2k
Message-ID: <CAGudoHG260oJkBPXwe13YqeC_si8RVUAHdMU1wMhNnXrZUFvPQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] pipe: drop an always true check in anon_pipe_write()
To: Oleg Nesterov <oleg@redhat.com>
Cc: torvalds@linux-foundation.org, brauner@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 3:08=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 03/04, Mateusz Guzik wrote:
> >
> > @@ -529,10 +529,9 @@ anon_pipe_write(struct kiocb *iocb, struct iov_ite=
r *from)
> >
> >                       if (!iov_iter_count(from))
> >                               break;
> > -             }
> >
> > -             if (!pipe_full(head, pipe->tail, pipe->max_usage))
> >                       continue;
> > +             }
>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
>

thanks

> It seems that we can also remove the unnecessary signal_pending()
> check, but I need to recheck and we need to cleanup the poll_usage
> logic first.
>
> This will also remove the unnecessary wakeups when the writer is
> interrupted by signal/
>
[snip]

There are many touch ups to do here, I don't have an opinion about this dif=
f.

I don't have compiled stats handy, but few months back I asked some
people to query pipe writes with dtrace on FreeBSD. Everything is very
heavily skewed towards < 128 bytes in total, including tons of 1 bytes
(and no, it's not just make). However, there is also quite a bit of
absolutely massive multipage ops as well -- north of  64K even. Doing
that kind of op in one go is way faster than restarting rep mov every
time interleaved with SMAP toggling, which is expensive in its own
right.

Thus I would argue someone(tm) should do it in Linux, but I don't have
immediate plans. Perhaps you would be happy to do it? :)

In the meantime, I would hope any refactoring in the area would make
the above easier (my patch does, I'm not claiming your does not :P)
--=20
Mateusz Guzik <mjguzik gmail.com>

