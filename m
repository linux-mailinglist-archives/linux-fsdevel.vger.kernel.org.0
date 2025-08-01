Return-Path: <linux-fsdevel+bounces-56519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C7EB1850B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 17:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53D407A3AA6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 15:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5232737EE;
	Fri,  1 Aug 2025 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pmGrHBPS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F39E26E158
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754062418; cv=none; b=vBHMro7fu1UKHcqxyrn37UDnRHdUEhNbK93RWVU9dv18OxcQrc2azMrrZ367jiP1dRHlQ2aGAOgiP33VtnFT2SuzNFzAbh51XusescGL9q6K3SBGYEUzn8XV9fTZr3IdJxowbt7f6qJUy4rDOiz6u/HfDMI7jQNB+x650ZCTwuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754062418; c=relaxed/simple;
	bh=Hlg5IiIUSg37cw8hEXFqC6WPT7GHYQIYrncw2fqeeFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhaH5ii3ZZctbVpmWcFd3FkA00ftca9fxijiwSlmLgVw/tIUtHiaVFHNl2DpAwrJseRpYemTnmJyRKnP9IkbqTlxOfmv3JWW0PTu9JuN5Is1yPy1U/iZnIwME3p/kMSyOigOG8cxuRLjE8A3VB1FhT6yu2D1cAPG56+dn/Rg2sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pmGrHBPS; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4aaf43cbbdcso169841cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Aug 2025 08:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754062416; x=1754667216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hlg5IiIUSg37cw8hEXFqC6WPT7GHYQIYrncw2fqeeFs=;
        b=pmGrHBPSRxXBV1OSQ7R6Hr0nBWQrrtE3INbqCauaijfJpLKw/GOL+eHypTKyS8G+dr
         VSc/4oXlN7WwcPY0ZP+t8XGkwIYqn+OT+YJusKYEB6fsuYgU/I2la2+vSbpgCbAB9H6Y
         rHhG7agLldSS90BG1kf+ASUt1T+fYncjKBN4NN6dXb2Dp6fexe+xhupgkbTOgmFv2D27
         EfFIbZ/xwahEBaGu6bHXZsuwJjKDSBkm7jE3nj3vCVrYuT7oFYOO8JPNEcb1Qkns+XMj
         b7ugjf13JV86x1/MdFyBlptOmPQkSd+zFoIRtFvAD/0UY1FY8dd/J8bXuD7yzN9lrHZk
         zpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754062416; x=1754667216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hlg5IiIUSg37cw8hEXFqC6WPT7GHYQIYrncw2fqeeFs=;
        b=A8kcQICo/4F0YuqzGSwjdNLKMq/RgOcIh6Qc7whXCQil7jgD9dP4Jj/gg0CWnvah/7
         b5llFB5NU7m1x1VGcC44yo8aRYiGlM75tzxJ4Gmdne29u+jbLXr8q5FhLM9V9HVlfk5B
         qShxRsxqz2fplACPaDe50vW4g/zwxcUygcOMcnVZniEQHJawuZytNtpSmm+tawwDZgtm
         WZ6I+fwyPWPJtIMc3t+2OxIqK1JqkuY3Htsivfco2ha2YvBEjiVBcvoP4L4FUv0AlBRd
         e9RMVdM7xF3ef8+bTz66Yth9vT89/6aE1tGEeoZVmag/tIM3cpKG4FVKrmrMsfH+F/GE
         wArg==
X-Forwarded-Encrypted: i=1; AJvYcCWDM46LSxhgomW4vvPv8ix7ZxpILkZTmwxmRIh+RrQ7CWj/fAUQtWyAaXBMt3FW8KkPTwLbo+4r5co1Hxds@vger.kernel.org
X-Gm-Message-State: AOJu0YwUf97kRRW/R8zIHY2PrlwETmthqr61PwUhzqqUQr0SiF3ajICe
	qmYJYct8BCUoJiLrRFb0qXpCTGblM+vWOQWrCyMF7rFHM7mtTxmRZjYDhq3TJzILlASrUa1OBVb
	osLHj1gF4yP7XZ1xFfWX4QY2L9CCDxBYSKwDSafSv
X-Gm-Gg: ASbGnctmG+BFTr2RuocQnQqNKqIdvDwzFwoxg9SIvuu7yMI7q4woCvDgileKW4ChBLS
	92vc+FEJqAayYcW9Q5VXU6um8WXqm4TOCrsj/fgMUNuS//tTpFEY7lVkznn4eHIC3EfRRXJ42U9
	HrDZR7KJOo1ockMZt70PP3F17Xxwu8GOnHJE8hMbZpR6kkJHux7YCLUC6rPdPUkv52ms8qQHeUA
	sRf9w==
X-Google-Smtp-Source: AGHT+IEsz7cqbW/kEbKXp/wzbnkRSdJg8iPGlbcCDsMA3W/EALhw5TKX2XX+IJPal4VjoqUJ4+13OZd6BTyXLQ5Nvpk=
X-Received: by 2002:a05:622a:1652:b0:4ab:54d2:3666 with SMTP id
 d75a77b69052e-4af00896fccmr5243681cf.25.1754062415661; Fri, 01 Aug 2025
 08:33:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731220024.702621-1-surenb@google.com> <20250731220024.702621-3-surenb@google.com>
 <7821b672-eae7-4730-afe4-b72b80ac6ea2@suse.cz>
In-Reply-To: <7821b672-eae7-4730-afe4-b72b80ac6ea2@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 1 Aug 2025 08:33:24 -0700
X-Gm-Features: Ac12FXwW-ZHVyxPhLTgiyxybxi8oKVAlrLZn75JD6yLNdxGMHYIyQEgr1Szxvd0
Message-ID: <CAJuCfpEhC77ZD7Zvg+9nqb=DAj2kufnLGpD72gXFbQ5Bbp-ayQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] fs/proc/task_mmu: factor out proc_maps_private fields
 used by PROCMAP_QUERY
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, peterx@redhat.com, 
	jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, 
	shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 3:55=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 8/1/25 00:00, Suren Baghdasaryan wrote:
> > Refactor struct proc_maps_private so that the fields used by PROCMAP_QU=
ERY
> > ioctl are moved into a separate structure. In the next patch this allow=
s
> > ioctl to reuse some of the functions used for reading /proc/pid/maps
> > without using file->private_data. This prevents concurrent modification
> > of file->private_data members by ioctl and /proc/pid/maps readers.
> >
> > The change is pure code refactoring and has no functional changes.
>
> I think you'll need to adjust task_nommu.c as well, minimally I see it al=
so
> has m_start() acceding priv->mm directly so it won't compile now?

Ugh, yes, you are right. I'll need to adjust NOMMU code as well. And
kernel test bot seems to be complaining already :)

>
> Also not sure about the naming, struct is named "proc_maps_query_data" an=
d
> priv field named "query" but the read() implementation uses it too, via
> priv->query, although it does no PROCMAP_QUERY.
>
> Seems to me it's actually something like a mm+vma locking context? Which =
can
> be either stored in proc_maps_private for read() operations, or local
> on-stack for ioctl().

Yes, I struggled with the naming of this structure. Any help with this
is highly appreciated.

