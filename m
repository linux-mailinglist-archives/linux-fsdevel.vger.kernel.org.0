Return-Path: <linux-fsdevel+bounces-13575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C3A8713F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 03:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F224B230EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 02:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0135D28E3F;
	Tue,  5 Mar 2024 02:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BpM0fgbl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0E528E02
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 02:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709607306; cv=none; b=OdYOwaVpwX/Lq7KEE9JL1soLKmfDS54jayCY5PPj6fiC0Z2HlaZnm1BkshapARL0a0DH/Ilx/u0C1Ax9QM24B2v9R6POe85me1ywycufP1WTAidjqw0dGFDskAI28uwoLbKXtgQ4cAI3UanRg0Am175K1kgygWJzJZDu/zZh9Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709607306; c=relaxed/simple;
	bh=sRHvWRHHbrNY2VbwRvTObTjBSe2twH6ZX793I1nCHr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qktl2trjrpZszCcr4ozJu4fD5nfAXh5PY9UGSTMFEYgJRS0H9QhkkULt8RJD4d/mFgBmK6YkTAlyTEifrZW2LJrckhZRqSvx2uhabzBp+B0N46At73YhMjsX4e3oOyTN7itZMUJd6yiDFOQmSxPl5cOS668Hwhhn4FTcFu38TTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BpM0fgbl; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5133d26632fso2992967e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 18:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709607302; x=1710212102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAIg+K1FyMraMU/hEXtxnTmOqsREezzXahRBlOT5IeM=;
        b=BpM0fgblWVmwue2p8/qTo557+EGbxIE1LhYchjLXvkRPm4OCgcY2waofursGXXp/rF
         TbyigQ7a6meIzt5awNYREaU13yvXlwX+73n/8V+VqCorxLNjFSTf/6BjYPIP9qTJfvu8
         ATV0J1kBthdFyxdioYAXQ0GRjd/odRomUy09KABPK1KxwCgD42FLN1Prs+kMpJf3WbLL
         mdQtvCDRYaZ+GdpWTu6mW8CjT+eHpVRaYWcpYm7INFob1HcPYZYmpywBPya39F6oUTLd
         mgz4a9Cyz7Ftk5KxKixV276e6Ip1+6TCTqnTpFWECIbxZ0k5Dc3vQjI63HBI+OCDK0O9
         mzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709607302; x=1710212102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAIg+K1FyMraMU/hEXtxnTmOqsREezzXahRBlOT5IeM=;
        b=So8W3dAYM5HtifyOLFuzSa4ITob3IDRBJ0mKPdFATLZXM9TYEAvMLsFmICBxJ5Tsry
         W8e1Bfr2HVr/jmP+A+mAdzFlUbsW8GOwrC0tBIOrUObz0BkZV7Foi/mAkdrjpCYEOXJ3
         MfntnQybtNhFa38UPD3lozBcuION5dsZ8Qh+x4htqUeyGkwcAOa3cY4+V78WW/wDvHU/
         3EzvVk7MylUueDAGebECE33q5VjR46a4SIVlwncPgE76DmK0EQ6cMMXtvnlT+3zIxCRi
         Rg4v+AFwFmWPlK8C6GKEBkPs+FbuoG3p0Ug2lX8TOBXHVX/4f4Iook/rZO2y5FgGJB7R
         TuzA==
X-Forwarded-Encrypted: i=1; AJvYcCWqaKLfc1f8uKsQO+LatjnoDsdfJUJD3OKf3PxgWQzaJFklJ6ocTdsqPCbPcQZbaOm2S2RZ9/t8cgzDrCCzpO6pRll/Rz/9v1U3IgMi0A==
X-Gm-Message-State: AOJu0Yx4HuGX90oeyR6eBDx03r12qBmHy82sYYN+hAxg/mIAm8XgYFhy
	8ukt5nmHWhemHIUHM36Qlq9U56RpvA9IAIqG4Si95DeE5PGbHyKU3qp3fj3kJJP4VaHrbd61jWE
	3cDG1yYCYwAloaQbgNZMIhySiw/IEtsWTKd/I
X-Google-Smtp-Source: AGHT+IHjypstYaY+noHFLDhZJNZzB9IufGE+xprQ7AYUqakRJaFNUa2rIE/XsEzEZvgz+iRo90pAzOdIMDUoOZ4dwxk=
X-Received: by 2002:ac2:4186:0:b0:513:3483:e727 with SMTP id
 z6-20020ac24186000000b005133483e727mr326818lfh.48.1709607301552; Mon, 04 Mar
 2024 18:55:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org> <170925937840.24797.2167230750547152404@noble.neil.brown.name>
 <l25hltgrr5epdzrdxsx6lgzvvtzfqxhnnvdru7vfjozdfhl4eh@xvl42xplak3u> <ZeFCFGc8Gncpstd8@casper.infradead.org>
In-Reply-To: <ZeFCFGc8Gncpstd8@casper.infradead.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 4 Mar 2024 18:54:23 -0800
Message-ID: <CAJD7tkYNqdxD+ThSzLuw1Z00K=tyVDwpyM=acZv1eM8L=d7T2A@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
To: Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, NeilBrown <neilb@suse.de>, 
	Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org, lsf-pc@lists.linux-foundation.org, 
	linux-mm@kvack.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 6:49=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Feb 29, 2024 at 09:39:17PM -0500, Kent Overstreet wrote:
> > On Fri, Mar 01, 2024 at 01:16:18PM +1100, NeilBrown wrote:
> > > Insisting that GFP_KERNEL allocations never returned NULL would allow=
 us
> > > to remove a lot of untested error handling code....
> >
> > If memcg ever gets enabled for all kernel side allocations we might
> > start seeing failures of GFP_KERNEL allocations.
>
> Why would we want that behaviour?  A memcg-limited allocation should
> behave like any other allocation -- block until we've freed some other
> memory in this cgroup, either by swap or killing or ...

I am not closely following this thread (although it is very
interesting), but I don't think the same rules fully apply for
memcg-limited allocations. Specifically, because the scope of the OOM
killer and available resources is limited to the subtree of the memcg
that hit its limit. Consider a case where a memcg is full of page
cache memory that is mlock()'s by a process in another memcg, or full
of tmpfs memory and there is no swap (or swap limit is reached).

You can get more creative with this too, start a process in memcg A,
allocate some anon memory, move the process to memcg B. Now if you
cannot swap, you cannot reclaim the memory from memcg A and killing
everything in memcg A doesn't help.

