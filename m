Return-Path: <linux-fsdevel+bounces-32906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E01BE9B085A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 17:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E9E1F24537
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 15:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9191494CC;
	Fri, 25 Oct 2024 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="XOCiIT0N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7B470837
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870383; cv=none; b=rqdM7j4XMf/IbRjVtyEBPfDe+Uo5bGR1pi0UJWX3FLzu8DA7ho2e4DHP5jGY6IVYlCRmyT/MUyZglIFvxc/nTOLmf+m8elR6JGvV/RkQWijEiyhXMSgbaHXEUh/uwgDh8VqtLKqRlcF5/E4v4BYyNA8JVGE9yXV1Ev2j3ysToLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870383; c=relaxed/simple;
	bh=dr+y7iTGtWeeXfUuodUQl5tLluhiPCudNwaGMNX74z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUatgQftS9f9CB4sBmozbdcaVXengCEGSabaaPUySCsowzNdkKnVzeakKnRcmCMDWauYTqfOxE4l5yahb3H/VpPjqo+ZkO0KzxL3KTt/XQMXB+Cxb+m3VPwgk56AQA4DE5p0xCX5AHw2kYsAlpAHiA4acQ5QbmNSHF5IQXEMqEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=XOCiIT0N; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4609b968452so13953621cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 08:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1729870380; x=1730475180; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OZfk6Xd+iHgwqL80w/veikPrz/acZmk1d1UazX7V4Iw=;
        b=XOCiIT0N2L7TQhVc8ePUXFN8mUrdok1Am8XvAoSUSMj5kkXTROYOcTqzrLmYRRH4Wq
         mF/2wcXaB3mUhFHaKaOhbumJ/uErk4TZxf5mzsyjkfJVzYXoQ84H7ahHoqpUmcdPEHrO
         AfIy57A/AiPt+cgM33eUBdMttq3+WgILgf82c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729870380; x=1730475180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZfk6Xd+iHgwqL80w/veikPrz/acZmk1d1UazX7V4Iw=;
        b=ADbQY2HPxcMku2MkROFBCB22FSqB13vswU5mUy4tVVozasFM7rsskLUOEzYimk8WmO
         xMtBMoUyJJxVQ/jxpPJRk7qeiD6+2DepdqVU8YFWZe1WBQ4LjG6kQ2qb/g9Bsbw44pPA
         z3F9PVHquaep4HPfP8PME/JxCWHp8wWxzigf949oRQljv2baGuOsjIdJMdElFse/9l2D
         iKsVtGcCToqFFFBlMQCatGeu01P3w0pO+Hy5tOkxcGo9f9e7qGsQS5mqrBZSI8Bc7n+O
         q75LTveZw5VnvqiykIciFv/sbOjc/ZnVkI/1db+QOQfU8IMAMOXAtxDTzNCE71r7Jzkn
         z/XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLhr6DsKfdiPASPy8Op44cXUgsvTLyCXq3wszNictFTVjF0Th2+eM/y7sJihaMoaofPv8zXkCLNlUbjgzR@vger.kernel.org
X-Gm-Message-State: AOJu0YwX+1kniU8ZUG3X5rdlbZd65J5tzkdTfahdVjp3a9CMy2RqVkST
	0IR/qfzNWoAmydanqSssuYTa98CEf7qzHIo8a2/7aN7E3VzP0hkTjtcGCnGpqbHJg+z6gUn6YSH
	GGc+5JQ6tGDEgRW6p2jZPgPeEO8pKi+TSbPPMdjEqOOltcPXO
X-Google-Smtp-Source: AGHT+IEgN6oTYbsl5OF1VE38es0Me99VfID3QP83mB4HzoUefsOcErEmenp25jkyu8vXC94P4Hi/pZOg0sRSJLRN+cU=
X-Received: by 2002:a05:622a:60b:b0:456:801c:a20d with SMTP id
 d75a77b69052e-461145b7453mr128997211cf.2.1729870380224; Fri, 25 Oct 2024
 08:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com> <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
 <CAJnrk1a5UaVP0qSKcuww2dhLkeUqdkri_FEyVMAuTtvv3NMu9Q@mail.gmail.com>
 <ntkzydgiju5b5y4w6hzd6of2o6jh7u2bj6ptt24erri3ujkrso@7gbjrat65mfn>
 <CAJfpeguS-xSjmH2ATTp-BmtTgT0iTk2_4EMtnoxPPcepP=BCpQ@mail.gmail.com>
 <tgjnsph6wck3otk2zss326rj6ko2vftlc3r3phznswygbn3dtg@lxn7u3ojszzk>
 <CAJfpegvd-5h5Fx4=s-UwmbusA9_iLmGkk7+s9buhYQFsN76QNw@mail.gmail.com>
 <g5qhetudluazn6phri4kxxa3dgg6diuffh53dbhkxmjixzpk24@slojbhmjb55d>
 <CAJfpegvUJazUFEa_z_ev7BQGDoam+bFYOmKFPRkuFwaWjUnRJQ@mail.gmail.com>
 <t7vafpbp4onjdmcqb5xu6ypdz72gsbggpupbwgaxhrvzrxb3j5@npmymwp2t5a7>
 <CAJfpegsqNzk5nft5_4dgJkQ3=z_EG_-D+At+NqkxTpiaS5ML+A@mail.gmail.com>
 <CAJnrk1aB3MehpTx6OM=J_5jgs_Xo+euAZBRGLGB+1HYX66URHQ@mail.gmail.com>
 <CAJnrk1YFPZ8=7s4m-CP02_416syO+zDLjNSBrYteUqm8ovoHSQ@mail.gmail.com> <3e4ff496-f2ed-42ef-9f1a-405f32aa1c8c@linux.alibaba.com>
In-Reply-To: <3e4ff496-f2ed-42ef-9f1a-405f32aa1c8c@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 25 Oct 2024 17:32:49 +0200
Message-ID: <CAJfpegvL0fVcaap3JOhuJcvmH-9Ws45oKjW1UvHqtArhnkUXKQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, hannes@cmpxchg.org, linux-mm@kvack.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Oct 2024 at 03:38, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> Actually as for FUSE, IIUC the writeback is not guaranteed to be
> completed when sync(2) returns since the temp page mechanism.  When
> sync(2) returns, PG_writeback is indeed cleared for all original pages
> (in the address_space), while the real writeback work (initiated from
> temp page) may be still in progress.

Correct, this is the current behavior of fuse.

I'm not against changing this for the privileged server case.  I.e. a
server running with certain privileges (e.g. CAP_SYS_ADMIN in the
global namespace) then it should be able to opt in to waiting sync(2)
behavior.

> I think this is also what Miklos means in:
> https://lore.kernel.org/all/CAJfpegsJKD4YT5R5qfXXE=hyqKvhpTRbD4m1wsYNbGB6k4rC2A@mail.gmail.com/
>
> Though we need special handling for AS_NO_WRITEBACK_RECLAIM marked pages
> in sync(2) codepath similar to what we have done for the direct reclaim
> in patch 1.

I'd love to get rid of the tmp page thing completely if the same
guarantees can be implemented in the mm.

Thanks,
Miklos

