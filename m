Return-Path: <linux-fsdevel+bounces-45633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E42BEA7A29C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 14:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562431896DD3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 12:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B0B1F790F;
	Thu,  3 Apr 2025 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="DnHv1Ow5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01811D5150
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743682547; cv=none; b=emvB1A9OoTnzspGz/66AravhS4yJkabOkgyF6kqQwvsuistI9ES9UJznYpeq1ikNBLS1iSB/nDY4V4CqVBS5hGLuEpHTryFEeN/kmVqR7ZgaxCbp5PI1Twb7SQVXPqNTW79kFlSbiE6w3fH4QtJwCEnqcm7XzeZ7aIomgjIKJ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743682547; c=relaxed/simple;
	bh=LlPhdws+Eo4xjIxUlXnZt/V94sc0zpMR7QjwM4hm3AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIuePVKSkI0HFntZuZV68hMN9m/3GwM0kN5WEHLi1uMfyJJMhVFYwPFkpnVBIY1jWv4dPsCumNF9+MiwVew04ohCtZDnhXnqMzJsO8C6esjyQS4arwxlNm6YI/53NhTcFB/gHu5yrX83lE5ZbXFem6JDYeRs9DwRclxXynGtrPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=DnHv1Ow5; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4769f3e19a9so5191481cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Apr 2025 05:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1743682542; x=1744287342; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SZdLMKriX7DABWvhenmEbHf0m9Rm6NkrtVKJnjeaJ0A=;
        b=DnHv1Ow5/sa19ib+46A97WRMMddnCGZ3tfjZkiCD/pgLebE79f3LykQVm38DSYNeeg
         lFiMPiqboDPltvpy3adTalvyTFch6wZY7kXMp9cXRIXMG+UcgKx1r2BwXCn8+L4Rarc0
         laLgu6650fsTR5cinmN/hCIVMmcKCBfQcQphA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743682542; x=1744287342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZdLMKriX7DABWvhenmEbHf0m9Rm6NkrtVKJnjeaJ0A=;
        b=Fq1l/wF3Bnzy7PDHn/z+1CCsSmar1wU1HVu3v7SXQfidmUJWHaiaF71JCs6HHc/51A
         I/7fINShREiNFPITyrhtvY+B51s7rVOv3CNADGXj7+qCOyxNOq2JSA+6ksOkCTJNLUH+
         GKLejqRzOlLQeESLtmxSGv0SVGi5BrdkCUEt5GnhROSstEzW8+W2UBtqhVpk49St8mIW
         LBS1/hR1/Cf4ADHw3vaVQCjEPM7FW1TisHGzELYXurK/LZ4JbQmIMwFl2VG8fbRvB5Or
         07UyyR5oq6+hZYfbCVpXegFZAXCSZsBMtY311Brs9PE/mvBxaC9KayAwq8pQBQFyZlN4
         /xlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq3E5Bl8uuxedyRZ1mSqWaPpukeH6sFgZGimqJNNlZy78pjgBo3m+SCSpAm1zUSCRrMinvizxyG3ljtd3r@vger.kernel.org
X-Gm-Message-State: AOJu0YzgvBFoINwPBSQjYLa9gK2EuGozFBxGKJ4BGZYqklnWRVgyqQxt
	h5+qCTg52Zif7h3w5LZdmn6JjXGWTn4hVY5DsWLtUe2XnJSz6C/mZouAJ4guOi+zLeqa7ynCWc+
	IDW/IKOm/mSG63iM7Ldwe/b3FeE1Ewf0GMOfF0w==
X-Gm-Gg: ASbGnctmR4x/HD1pp++ekDcQBBdU9f4mC55L2yBYGMDEfJfR18sbmMAIKS540ce4q27
	gBU9+jDh3dYE8I4zteiRtIaTBoZOG2YziPfy28cafeDbcLHvCeghOkf8ha1o5x7fGRAR42zz92l
	kWaV2WDKgvCejj9PXYYzL4c4UvdIUWoPInUpeL3g==
X-Google-Smtp-Source: AGHT+IHy6rNAXW2ozoNtBlNyNPgUxuW5qvU2G4CWl6s6/9uuGLJPjerWGcBRa4veIxe0SSd1cFRhB6muASpPletLMO8=
X-Received: by 2002:a05:622a:148d:b0:476:c666:d003 with SMTP id
 d75a77b69052e-477f7b0ab84mr271438131cf.43.1743682542585; Thu, 03 Apr 2025
 05:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402-fuse-io-uring-trace-points-v1-0-11b0211fa658@ddn.com>
 <20250402-fuse-io-uring-trace-points-v1-1-11b0211fa658@ddn.com>
 <CAJfpegsZmx2f8XVJDNLBYmGd+oAtiov9p9NjpGZ4f9-D_3q_PA@mail.gmail.com> <b1f59622-5d4b-48d5-b153-a8e124979879@bsbernd.com>
In-Reply-To: <b1f59622-5d4b-48d5-b153-a8e124979879@bsbernd.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 3 Apr 2025 14:15:30 +0200
X-Gm-Features: AQ5f1Jr2HM-7bTScORkLQ5XnBIzLJF6rW-mxhig7gldtqgYljrN2mNzqvNHZIF8
Message-ID: <CAJfpegvKbtbUmWw9EE92iV49+gn9ZpLF9B4sVnW-M39kzLFXEA@mail.gmail.com>
Subject: Re: [PATCH 1/4] fuse: Make the fuse_send_one request counter atomic
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Apr 2025 at 11:16, Bernd Schubert <bernd@bsbernd.com> wrote:
>
> Hi Miklos,
>
> thanks for the quick reply.
>
> On 4/2/25 20:29, Miklos Szeredi wrote:
> > On Wed, 2 Apr 2025 at 19:41, Bernd Schubert <bschubert@ddn.com> wrote:
> >>
> >> No need to take lock, we can have that in atomic way.
> >> fuse-io-uring and virtiofs especially benefit from it
> >> as they don't need the fiq lock at all.
> >
> > This is good.
> >
> > It would be even better to have per-cpu counters, each initialized to
> > a cpuid * FUSE_REQ_ID_STEP and jumping by NR_CPU * FUSE_REQ_ID_STEP.
> >
> > Hmm?
>
> /**
>  * Get the next unique ID for a request
>  */
> static inline u64 fuse_get_unique(struct fuse_iqueue *fiq)
> {
>         int step = FUSE_REQ_ID_STEP * (task_cpu(current) + 1);
>         u64 cntr = this_cpu_inc_return(*fiq->reqctr);
>
>         return cntr * step;

return cntr  * FUSE_REQ_ID_STEP * NR_CPU + step;

?

> Slight issue is that request IDs now have quite an up down,
> even more than patch 2/4. Ok with you?

Being more obvious is an advantage, since any issues will come to light sooner.

Thanks,
Miklos

