Return-Path: <linux-fsdevel+bounces-20509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FB88D4819
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 11:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46B541C2429F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 09:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056DB183965;
	Thu, 30 May 2024 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="pQ7OW6TE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE708183969
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059992; cv=none; b=f9rlxxsbsNDQhHNBzKwB8m2pawrkCAQ7c4L38SXwFWY8mZupQRbNs49BHuTCEdXde+NrcLXDLJYYPLDFkGfzp7OvRh/AxNEdaTxzNrbdj89J1hIQcTNu9DQJ/7kPWpzD0v+ZrvlKHewDaoltRwkKwzJiBjnXgO9EIeFVOmTY6i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059992; c=relaxed/simple;
	bh=2SlXO2clAhdignpywm732PA1nnVo+Es/NHnvGg91cY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPcEI14gKr7U7FtFMT4Zyn75zfYLl4NIyE/btSthIMqHy5b6aUyIPNn/lpOc44MJW1mY5rJ0k1K4h1i27Gj811jxeb7pNRT7/mI1OoFrST8C7EpOAql3FLLyl3ADvJCg5k4mzC1S7JIszyd6CuAYfmYCFoErPXV6W9gzYJbaWaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=pQ7OW6TE; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6269885572so150815766b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 02:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717059989; x=1717664789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2SlXO2clAhdignpywm732PA1nnVo+Es/NHnvGg91cY8=;
        b=pQ7OW6TEx/AH8npODiGPK5E5WPkVWC7ly090v7UQ+2I136FH4cpTjjhQnPx/eXDF7Z
         72onAt8ZquKICFT4F+aPl0eNvF+O/G6giXLTS3OHkdiJE8MK9ULca2IAhuKGK4hkyMKV
         nGSBU9qvaJRvuS09aS4COhXE3G8Zm40s/nMzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717059989; x=1717664789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SlXO2clAhdignpywm732PA1nnVo+Es/NHnvGg91cY8=;
        b=UJa+XK0ytNtCU07TbYPDmkqUwx0XNE0+7BTVZHW+EUM6cJGCKXV3lht+ZW4E4K9qS0
         eSpErUPT42KcyxzwstiG9AsiTd8c7WfRYQK1RMLh+S4peOJPpfiHO+RCOtqpJ8pJxlzz
         vRIvw/oUjF80pOXCreRy4k8AhKSq4pMdvI+OSasftes19KQ5pwou4mTNoNGeHUDkNEMX
         ar61594UWHwMeWtdiShSClMYGwTbWGs/zBk9FIEqWMnbof/3UBV5DyJd/O5hQsJZf5bR
         w/kLQ5JJQfYH9C00NIAu4zRUNpPlahUraUICT/esqlrTY/gYupDdWB7+PVUcT25pMLUJ
         GDzg==
X-Forwarded-Encrypted: i=1; AJvYcCWdcPcb89i6Az50rOnOxLoysjH6FRVRTiXd1hz+bLIipKXcMq6QaRZkffvs72LCq1d6ggZ6k6dr3CbIp9FtCYGRTZyxm7xYtris+A8r4w==
X-Gm-Message-State: AOJu0YxgdQaylTCFtc0e+ibbd1OU7lCwXufiVCIlI8Vjw7rPVwz1yAfn
	dahxD3GnNeD6e0/UyRFLHhAgbayz7sap/e/uIGUrGx7A9CjN8BL2EK/YYDNKLagwLkUvg0cnkNa
	I4UtnbgHdTpgWrv5ZIcwtCCV75JVOk9HbQL8qAg==
X-Google-Smtp-Source: AGHT+IF2ROW2D7QQi2KBd4btTcLT0IhYRKSDbw2K7YstlOyb5B/N8AQT7s7U5qGsYIeOkmkLJoZcgLieUKeLTzGCEfw=
X-Received: by 2002:a17:906:f2cc:b0:a59:c807:72d3 with SMTP id
 a640c23a62f3a-a65f0a68e65mr107437066b.17.1717059989102; Thu, 30 May 2024
 02:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529155210.2543295-1-mszeredi@redhat.com> <20240529183231.GC1203999@fedora.redhat.com>
In-Reply-To: <20240529183231.GC1203999@fedora.redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 30 May 2024 11:06:18 +0200
Message-ID: <CAJfpegtWhTQcOCjwvPCsfO97TPPNu7+a3+0NAMqBUHfyAJYjug@mail.gmail.com>
Subject: Re: [PATCH] fuse: cleanup request queuing towards virtiofs
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Peter-Jan Gootzen <pgootzen@nvidia.com>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Yoray Zack <yorayz@nvidia.com>, Vivek Goyal <vgoyal@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 May 2024 at 20:32, Stefan Hajnoczi <stefanha@redhat.com> wrote:

> This is a little scary but I can't think of a scenario where directly
> dispatching requests to virtqueues is a problem.

It would be scary if it was't a simple transformation:

insert element on empty list, remove only element from list -> do nothing

Thanks,
Miklos

