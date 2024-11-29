Return-Path: <linux-fsdevel+bounces-35836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F0A9D899B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 16:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90A31B3BE05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFDC17C61;
	Mon, 25 Nov 2024 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OfsNQbt7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183CC3A1BF
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548888; cv=none; b=c/qJmdwusDplJ/l8fSc5OKULHzBLh+fhSn3v8O1pfzb/kidGn48WdcuL84WEsFO/bSmCScllPdOPe2B2d6Oe+pL34ZAyZYgg7ZAbsnLb8Q5t17A0tA28d1kSAxrfl/sVIIz3NaAjnZ+nfiCj/UnD9y66DENxqlZQ60zZ+RUzUa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548888; c=relaxed/simple;
	bh=86nOUeUagQJ2k/h5shMlidVE6VHGCZdOo0proGfjevI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kw5JlmTZ54b2aC1kYI7xxw2Y2dxHU7b/ff5UlRxA4RLTzWlXsosAEqrh5qvMSP8jWilZA5gckv8H2/8YjemJp8964qbly+LDEkYFHKBy10whtJUaT7deKcghUkK5GlxaQJGXci9057mKGSuUaqP1JDL41eXY698JTfoJ9vW64x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=OfsNQbt7; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4668d12b629so10479191cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 07:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1732548886; x=1733153686; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=86nOUeUagQJ2k/h5shMlidVE6VHGCZdOo0proGfjevI=;
        b=OfsNQbt75Y92G90NPfYCwQIfl+3mg/HRedxfuTOuyEYNVC3yADlppMzKWg6br4qoW2
         8EY1JowPBEROFAHhq/zTzGBuZ+V2jBjkpCeRebKs8mRnknJ7Y+obK0HAr7ijJFA4xAjV
         JXq49DJjMmjIZgbfJ63qh5rDk0sN/NiTIBWkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732548886; x=1733153686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=86nOUeUagQJ2k/h5shMlidVE6VHGCZdOo0proGfjevI=;
        b=BlPqAzOKTT3OQpOVEU+EzLgcZs+EMC+p2Iuk3HAaeRtFX8KGdOqJrV9vV6O9x81dGW
         Rm/1k5a7nFnYJiUhkQs9m50UenNzYb2jFaF+ArUlQSSBKgnLtzH/7kUz2dp3tp/oiZYP
         1EwAX7sHvZXT0t7OToJnhhKEo3YA9+WMSCWrY6wV0v6BNRLI8IM71jqGuKljT8g4oN1q
         toh5MxhHSJUPvgIQFXbV05eXGaGwldyGTiaMJndIIogfHQsyWH5woAYO3p045T9bjt6E
         wMYEPDR7u/bulw973NVmQqtcrVISaykXRW9a1XhPkTTVcKNGRlNyx/PnWV+IxxgpWIl4
         vczw==
X-Forwarded-Encrypted: i=1; AJvYcCVrm86tqpEUvq2zDKxjaX57XDGY4aksA90Kebx/OWe/GIedRaGQbIAUFNcRPI4xV7ZZhbygJWQjCO13kpEx@vger.kernel.org
X-Gm-Message-State: AOJu0YwqADqEREpjSanWd+Xduk7RQhCaEnSZTzBvGNy3zxSKxRnb+IEq
	r84hZyLlK3+XtwynI/dRNCn+AvYfy2dVics7+xv4lq83nSGTUdvJSdkmOJshC1YUt7mDBr49tvU
	uKuYHIMEfJQfjqhWjUYvHk4RowjbqWQcqRroFIQ==
X-Gm-Gg: ASbGncuyZ5Pn/zDnEkvGMP+9pJZ4Pe4SL1LlKmxan+qPh9H0xomin08/RU+/DaGZde8
	O8ed34GY4H1uK1AK+aE591haZSYcaearExA==
X-Google-Smtp-Source: AGHT+IEa8TehfeXB1Kg5BxElG/ZzztNpk45tPPXLV7SWp4eBM8bxfkmfKbGitCLixO+1HWeTBCGI/yZEmiS8+6bwsk8=
X-Received: by 2002:a05:622a:1807:b0:461:6aa9:9479 with SMTP id
 d75a77b69052e-4653d631425mr152114451cf.53.1732548886013; Mon, 25 Nov 2024
 07:34:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-fuse-uring-for-6-10-rfc4-v6-0-28e6cdd0e914@ddn.com>
 <20241122-fuse-uring-for-6-10-rfc4-v6-5-28e6cdd0e914@ddn.com>
 <CAJfpeguPCUajx=LX-M2GFO4hzi6A2uc-8tijHEFVSipK7xFU5A@mail.gmail.com> <6876e1cf-9bd2-483d-bd49-c52967c88397@fastmail.fm>
In-Reply-To: <6876e1cf-9bd2-483d-bd49-c52967c88397@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 25 Nov 2024 16:34:35 +0100
Message-ID: <CAJfpegvCZ8z54dX_bp=f039q_KAonNjCNVEum-CnXxuj-W6taA@mail.gmail.com>
Subject: Re: [PATCH RFC v6 05/16] fuse: make args->in_args[0] to be always the header
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Bernd Schubert <bschubert@ddn.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, linux-fsdevel@vger.kernel.org, 
	io-uring@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>, 
	Ming Lei <tom.leiming@gmail.com>, David Wei <dw@davidwei.uk>, bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 15:46, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:

> I have to remove the WARN_ON_ONCE condition altogether, gets triggered by
> /dev/fuse read (i.e. with io-uring being disabled), in generic/062,
> op code=39 (FUSE_IOCTL).
> Without the pr_err_once() and printing the op code it would have been impossible
> to see which op code that is - the trace does not help here.

It should, since commit 396b209e405a ("fuse: add simple request tracepoints").

Thanks,
Miklos

