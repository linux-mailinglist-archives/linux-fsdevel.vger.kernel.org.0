Return-Path: <linux-fsdevel+bounces-30889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 660B598F0FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 16:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9715D1C2105A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 14:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7C319E981;
	Thu,  3 Oct 2024 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="RdfXWhUC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0084D4C8F
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727964283; cv=none; b=e/Y5qX2MuD1K428Fpz0YWZNfMHBzrS6ZbsVgN0+UVmgrtjOdC+ajiQ+VfLa5gWiLuhfgyMTo45ccYMEaCU5ypK2lMbYQYdrC6u5qE4XXZ6rlH0IEUx83r7uUB2KK4HiUKNe8nidUYx9LYd3qHu382zenIlWKzAn0lSVa4x269js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727964283; c=relaxed/simple;
	bh=WJDCIALVRGTbinRjPXv9hrLbXvmnG91/0ybK8K7Aukw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Awnu/q3ToW54FrDdtUe32Urg2gkbEcycZII2oskFdbhNQEag1r79yUUxaCAdeLeGbnxgPbYPjz81qLkoEHOokKFdJpTn3iEFIu0c04smwrl3WN6xx8a2KbTbGD9u9Aze5dh95jXvwwg2z+UHVfzUoshcVgWMzB7QwK5d58dOG6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=RdfXWhUC; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8ce5db8668so164957666b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2024 07:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1727964278; x=1728569078; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h62pxMTHqspgxICJtwzTYNCT2BoA3qHyBGfuUBW5yXU=;
        b=RdfXWhUCMo/nJJNsTvPrGY7jm79LyOiVi7c5N0brhfzAVy/IDdIdv/SfZ5RxeAR6fk
         dYPX8RnrPKufwuaZqs0jpNU5t4gZrGc18oKGDCtkE8XXW9SgSywcBD6OcRImb0Qi8+7s
         CBZLXCJUtaoAAqyq5rYAMY3+IRVHkWrSDCnFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727964278; x=1728569078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h62pxMTHqspgxICJtwzTYNCT2BoA3qHyBGfuUBW5yXU=;
        b=LyjiquhhdD5mseykRg65BbfLElFzsWvcFtikhKHEUHd8xiuyU7Zg7/QXQioVzbGBpo
         uwAQuexmZoelOrHPf0Lr/BwmxZ1+iwbZ6wVXdYfEcKkuwpXS19cWodN11DtHr0bn0jYI
         ZukwWSWvl2/TVxk359vTrBOBWuE1BV0vgEXxlBJgKa3MQB7quDaKrG+1eWXZ8hY9Tkts
         0m8sNDSR7+vVheNvpoVwzI8f9TNIbItvfl9t16KCj8vGMxiARjs6mDtltoz452pDQrqr
         1FUcIO/wdUwSnAU6rXTw2dZi2Nll7TqcEPaHe5urQsqVVs2/Mbzw4633LsqopwINF9yP
         bStA==
X-Gm-Message-State: AOJu0YzB16AffPTCleguYCgvmYissPFMAmUizb5osTV99yHjf/y9vVQQ
	Um1C+ZEvymxIWBTC5+lhN9D4p8KtSDvr1dPtuyBcEk0PkOVBKdS2KWFfj7E43ILtIVG6Qz3WJLF
	6cYj3QF3wh/E5xokDBg0DLg6AQ3nIh2F267acuFZQ6ueAtYVe
X-Google-Smtp-Source: AGHT+IFGHivFTPcO8yld4cQUbuwXWhsaxV/SDSV+6B4JCQvyA676tPMwN6oT/DaBchNHcVMNDR/aXky637bN4kdLRnI=
X-Received: by 2002:a17:906:dacd:b0:a86:a41c:29b with SMTP id
 a640c23a62f3a-a98f8207dd3mr771044766b.8.1727964277970; Thu, 03 Oct 2024
 07:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e3a4e7a8-a40f-495f-9c7c-1f296c306a35@fastmail.fm>
 <CAJfpegsCXix+vVRp0O6bxXgwKeq11tU655pk9kjHN85WzWTpWA@mail.gmail.com>
 <813548b9-efd7-40d9-994f-20347071e7b6@fastmail.fm> <CAJfpegtazfLLV9FoeUzSMbN3SoVoA6XfcHmOrMZnVMKxbRs0hQ@mail.gmail.com>
 <c2346ef4-7cf1-412a-982c-cf961aa8c433@fastmail.fm> <a97070c4-c3ec-4545-bff5-496db3c9e967@fastmail.fm>
 <CAJfpegvK2+Q=L4hM5o0fZPuJc-zkCwZHj2EcLXFFEq__sPmXgQ@mail.gmail.com>
In-Reply-To: <CAJfpegvK2+Q=L4hM5o0fZPuJc-zkCwZHj2EcLXFFEq__sPmXgQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 3 Oct 2024 16:04:26 +0200
Message-ID: <CAJfpegtpCdGPN=X1_58bpD9eBnnK1gCBKTkGsRqn7cK3wJzk8g@mail.gmail.com>
Subject: Re: fuse-io-uring: We need to keep the tag/index
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Oct 2024 at 16:02, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Thu, 3 Oct 2024 at 15:56, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
> > I'm inclined to do xarray, but still to assign an index (in the order of
> > received FUSE_URING_REQ_FETCH per queue) - should still give O(1).
>
> xarray index is unsigned long, while req->unique is u64, which on 32
> bit doesn't fit.

I suggest leaving this optimization to a later time.  Less code to
review and less chance for bugs to creep in.

Thanks,
Miklos

