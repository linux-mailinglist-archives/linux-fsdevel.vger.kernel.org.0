Return-Path: <linux-fsdevel+bounces-20919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AB48FABEA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 09:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 793E4B22440
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 07:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99F3142633;
	Tue,  4 Jun 2024 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Ki9jQCFl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE331422D8
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 07:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717486081; cv=none; b=Cb+aPjotSsKGp/c7iWQxlOyUh70xxUUBY1iN6xGnDJ0pr9/lFNLyfCDeKtQ2XXufK0ER6L9KEvzkV6H3OJg/SpU+VIRMjDX/wB3SQbtFZ85VAigWPnIJ9MdqcvcQjSga6DZw4yXMh7saXbjTElGlLmDsAweObcebRyx8x3G2AF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717486081; c=relaxed/simple;
	bh=DR4V6fxUL7BVZQi4V6RSFvrnLKBnKUkoN26ol3rLYPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+BwHQQ1K1moUZK6AYYrbPMiE7Ocj5A7C4snPJo6UMIkMbBpFacUZ/MyS6Nnp/c9G8uOXgpixxrIjDcCwS5MunzrkJhIcWXLCGT9VOFP693xVwAmponuFxEXIY1YfRn6GRohR37vzYoOKnwRBQ8xCg9yCHaFva/wTIohprPdt00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Ki9jQCFl; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a63359aaaa6so668265366b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2024 00:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717486078; x=1718090878; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GI2pqJxOQAyikMyXqbCZEDrAPCthTI9n8bYtOs9OMzQ=;
        b=Ki9jQCFlPJvE5s46Pl6z7pxQbFVKBe33hkV0yqYyCfTX9nVrgYUJ7YfDT5rO1g845H
         06iCCgxl/ljeUYzUinSNETHaf7ONLppj3X/UGDihtKELXMi3ovlAb7oQg8NGZZ5i1LXa
         M320Sd3PsSETXKK5cXANCFxvlpsNbTZ2+gFBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717486078; x=1718090878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GI2pqJxOQAyikMyXqbCZEDrAPCthTI9n8bYtOs9OMzQ=;
        b=U5ivBf+K5MtumwThtvx4VHUBwB36ezyKuoY1kTtggcTdTOJZLONRrPAyb4zwIhHDZK
         HNPYZbuqbX2C2vi+oZqJvf9QDK2LFqDLyPI6MqkIH/LSMkzUP58bwK6dGn2mEPpeLuhb
         vorwyFx4NyszFCl4pt2QJtzj/iX4N9NY1ISzuaiRTlbKGUYeHOrdtQmgJTYW4V1jILq0
         vL6pQJXAtNr0kJhjuS+cOMkCHGsWdmCmz2cyRY679G+QlHAiMcQnVuOyEtXbBqxuXGO4
         B7VhsBUHQLgxmoZFdmd6b0RRDIGvLIhY+kuh/qJQ4wKaaPeKQcARbs//b7Qz3XVdPEiG
         UZ9g==
X-Forwarded-Encrypted: i=1; AJvYcCV1VQpAcWVxlBpStWkt9KM/qf9yfs/M1zVcWJvGoFGBmPXpBsXO6TQ67KPwulGx+oQN6a97+qq8vIAmkPEi9Jjold8A2KrI/b7Xx41iug==
X-Gm-Message-State: AOJu0YxuRzYBdWgK2brTR+duszQ+WKmFhlilA43R5jknTCyXWo7lTmqT
	a9MJS32kC9iv5FtAp267vYs8Y9cXV/5vDDVI3k3OFI2BK7sxMl2ggPl4aDQeZELmbteC4k+Sns8
	Au91vLkmvRflQ9p4RrozJKnzUoEwyFlSHn1n8C0tJ/wp+hYeb/qw=
X-Google-Smtp-Source: AGHT+IHkHwQVQQ+JU0j4tmJ47OzP4TaYIBrz4JULPX6z4ohALU0M28Idc/S5Dk8Go8j4tRXyJg5zj04Gyzdyt17lHUY=
X-Received: by 2002:a17:906:1b5b:b0:a68:c672:9ea9 with SMTP id
 a640c23a62f3a-a68c672a238mr483957766b.28.1717486077990; Tue, 04 Jun 2024
 00:27:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com>
 <67771830-977f-4fca-9d0b-0126abf120a5@fastmail.fm> <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
 <bd49fcba-3eb6-4e84-a0f0-e73bce31ddb2@linux.alibaba.com>
In-Reply-To: <bd49fcba-3eb6-4e84-a0f0-e73bce31ddb2@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 4 Jun 2024 09:27:46 +0200
Message-ID: <CAJfpegsfF77SV96wvaxn9VnRkNt5FKCnA4mJ0ieFsZtwFeRuYw@mail.gmail.com>
Subject: Re: [HELP] FUSE writeback performance bottleneck
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, lege.wang@jaguarmicro.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 03:57, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> IIUC, there are two sources that may cause deadlock:
> 1) the fuse server needs memory allocation when processing FUSE_WRITE
> requests, which in turn triggers direct memory reclaim, and FUSE
> writeback then - deadlock here

Yep, see the folio_wait_writeback() call deep in the guts of direct
reclaim, which sleeps until the PG_writeback flag is cleared.  If that
happens to be triggered by the writeback in question, then that's a
deadlock.

> 2) a process that trigfgers direct memory reclaim or calls sync(2) may
> hang there forever, if the fuse server is buggyly or malicious and thus
> hang there when processing FUSE_WRITE requests

Ah, yes, sync(2) is also an interesting case.   We don't want unpriv
fuse servers to be able to block sync(2), which means that sync(2)
won't actually guarantee a synchronization of fuse's dirty pages.  I
don't think there's even a theoretical solution to that, but
apparently nobody cares...

Thanks,
Mikos

>
> Thus the temp page design was introduced to avoid the above potential
> issues.
>
> I think case 1 may be fixed (if any), but I don't know how case 2 can be
> avoided as any one could run a fuse server in unprivileged mode.  Or if
> case 2 really matters?  Please correct me if I miss something.
>
> --
> Thanks,
> Jingbo

