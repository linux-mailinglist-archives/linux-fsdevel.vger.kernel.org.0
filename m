Return-Path: <linux-fsdevel+bounces-31957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFC899E346
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 12:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3341C2204D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 10:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC3818BC13;
	Tue, 15 Oct 2024 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hbJvBxYl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089581E3765
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728986478; cv=none; b=YXOZtubBhEUEQMDCpoSsRsgDkdEXeoZks9wo7EazE6weCaVi5IoUXGG9XvbZNtBhqsbc5X5yKh9aKTCSEmluM1gv1rlFsN+BKLS+eMcthT3w5qO1bAm560G6e90F1LLZJMvM+dwuU5MAHo2oklsXphpliqz9OuI/az1G6W5CiLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728986478; c=relaxed/simple;
	bh=2cwX/br97fHP2+rD38JwoSqWF4VpNCBmKTCBkZi51So=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ek760raoYRZ41YRc6eCwow/Di0reJ0dbcmLLfeN8ih1wkbioZyJ6eRJf3FycQ1oOlL1fW1C1sZIOcmYAn5+RhNfT/3NkAt8VftCfqKhuHApnPUohgMJBkdo5KS+LkS6CMSlioJNV0SBkEKeEuXwudzbPhiIoj4IAPzp8HYjBGTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=hbJvBxYl; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c9634c9160so3026910a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 03:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1728986474; x=1729591274; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkXujz+AkPMr+hXtOemRGyDp0iKQ1I/BZJu2qkSfe2s=;
        b=hbJvBxYlzZPsho3aT5nqmFG76Mdj1x2yEylRwXDw83+hm6wMPNV6xWOf3NmdOkzb9S
         1nb5J6f7Y44hP61NVxr7IfYc71X8CZXETDFc7olFNXyAQrndePslBo6S3UOdgNixbq84
         1C3bN2GI2ycoS4NDj12EBP3eXg3eTzFEYKlyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728986474; x=1729591274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZkXujz+AkPMr+hXtOemRGyDp0iKQ1I/BZJu2qkSfe2s=;
        b=Cbb/ACh1Amh9i6d9ltprYXorhYIRItWx9Z4dvS10r8AwoAIh8YRgPNKAVdxEmnGsyI
         xp8UadO7n8xI3Akw7d3CwP3lpcM4CJK0mBuCJZW/dNTABRBperhkECR+Vxk/Ba58PxU0
         cip7pmlhdBZo9QPKCrOFjZ4V3O5BvAidorJTWTDcBINuz8DPb6dIzTomfG6gdVj5lP1u
         4VDJmdNBB9oSag7nX8yGtLuU1/NqjgRtv6Fy2+fzBs9FYrxL7STlpfNrmqIxMCCWeAOh
         g5tjIs9R6PR/460ihm93tdesYzFX7H/OILIMy7gSLfW1H4e4n4wLtf98snzxITV6NyMf
         5TeQ==
X-Gm-Message-State: AOJu0YzRi9OUCfTC/Y1rvfM+m+RuEdkeSRALBStExXTODeveo7QYyTBk
	SOXi8fLaGqTaRng/vKO2bljuHBeWdfmClVe8GrStkao1cVtL6VfnFlLuHji2uLfC5O4NFPtmXgM
	yadCeRun+HNr5vZPdREbk/Bs5nVw/i79NwKa1Wa0Lp3Kb8QOb
X-Google-Smtp-Source: AGHT+IGVXoQx9gJzbIH3x6IQ9zFCkGUg4As7h8fjBdik3kQjUSrUhjbURXqnVglvr0JZ1FSxYtJee0vidTJZcPmCSGA=
X-Received: by 2002:a17:906:4fcd:b0:a99:e505:2089 with SMTP id
 a640c23a62f3a-a99e50522d4mr1095725866b.45.1728986473980; Tue, 15 Oct 2024
 03:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014182228.1941246-1-joannelkoong@gmail.com> <20241014182228.1941246-3-joannelkoong@gmail.com>
In-Reply-To: <20241014182228.1941246-3-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 15 Oct 2024 12:01:02 +0200
Message-ID: <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, linux-mm@kvack.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Oct 2024 at 20:23, Joanne Koong <joannelkoong@gmail.com> wrote:

> This change sets AS_NO_WRITEBACK_RECLAIM on the inode mapping so that
> FUSE folios are not reclaimed and waited on while in writeback, and
> removes the temporary folio + extra copying and the internal rb tree.

What about sync(2)?   And page migration?

Hopefully there are no other cases, but I think a careful review of
places where generic code waits for writeback is needed before we can
say for sure.

Thanks,
Miklos

