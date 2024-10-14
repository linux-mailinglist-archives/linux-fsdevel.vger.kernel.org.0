Return-Path: <linux-fsdevel+bounces-31860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C263099C39A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 10:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55226B22C45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 08:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E62C14F9D7;
	Mon, 14 Oct 2024 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="YvcxHBfc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DA61494A5
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 08:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895260; cv=none; b=b9VKcq4AolouPImgl0mulPzh9+OmauGwhPZu/n8ujDPtJGeEQjwm0IzroFOi0pYg+0XTZyF+CHkUuUgU6vx+XUNyYPVso+mCBK7JIQSoHG5Wb3rbguJ5/w59ALrF04nSmlgJ+fcsXILxiZXEJ4lJj64s8a08LEcUizpMXEhW+jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895260; c=relaxed/simple;
	bh=a4Q9bCVJe0gEt0BqMDW/XkAnRW7XYhAoeXHJYMQITXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BH3B6kWh6AgrEpZsrzqfnu08BFelBZPX3TxzK55LHHMTU+Tegkm9Gjzrly4Rx2SDXILNfFw+ydWm7fEvnbT8qD5zsChXs8Du6BeLPS7NQNL59JgrCvPs/4qT50bgiT9xyQv+ZSenGoWp46pEx0vLIVfVZQAXeowjHOkSEyiSqXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=YvcxHBfc; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c9850ae22eso272592a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 01:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1728895255; x=1729500055; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kxugCYYBKNRjpuuLFNOCBbHjPUaE6ueWu0O7LsHc4Kg=;
        b=YvcxHBfcoO7vjo4IUUss7qaKkez3hhDQwAYIxgHvmOdYuO0vv2s3jKe2f5ksiVH+d7
         XeCbAP73POkkkPWapaAE8HIyVVlJH40sXqlynP4GSBrCO418Dp4yoBYidBlaEBgu38tF
         8qTXPXFSkml73jJ4B7fKeaFE2EYEDpUVsLwI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728895255; x=1729500055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kxugCYYBKNRjpuuLFNOCBbHjPUaE6ueWu0O7LsHc4Kg=;
        b=A4s3Ro0o6Uu2wjypOMsAeglqUeC3gEwp09Hh8xrJHgkE/6340an39HaKNZbKlHCBOX
         uJNrVAB03sQfmtyKxP43sVSK0XXTUSIBMQb3wyxf4dUOO5qrvT6Dh4gIbRA6sBn/+gvY
         Ygbjtc9/lAFtR3e21h2BB6ehfvldqPQEuecYjKKzMmC2z+hQER4WsOHcD3EWxbRwhDQM
         lI72oZg5NVm71g5Mj7oGp/XAcazeu1XNTAhNLfAvqlftzGhGQNTlfG4lh1cUWVG4Z12D
         ubEJbfEYefC3sD2RYG0sG3d3k9whgACGOIrmDDdPsFdgnXqRW6VVTOBa/4n6q4cmhX+J
         sw4w==
X-Forwarded-Encrypted: i=1; AJvYcCVzzv0ckqr4zT4S74i65q36SMsg7t/zIEJTDdR5cMriWtG5ny41TLJvr3GlP5O1QxhBTOpkF5+mqgHus3Jo@vger.kernel.org
X-Gm-Message-State: AOJu0YyvcFfBY8w7XR+j00LhdW7BOsk5gMdljd8JNZUTWB7F6dhGjGH2
	fno3sYMxMvoff7X6MPe7E50f4o0zZ85qDoZTBDMRCopgXThMRsQwJcipgDF7dDTU8x3i+d3kU5M
	5K2RoZ9gHIzydjsNyGmbPleq/s8lChZNgSzv8vg==
X-Google-Smtp-Source: AGHT+IGNARnjlGYaHYbQdE/AahlajiwIgQ6pHIYjyJXZ/wgRltF2wjPGjogZyiaItM4ET0z/lXUmI3kgiiVk8tDd1SI=
X-Received: by 2002:a17:907:7f89:b0:a99:f167:47c7 with SMTP id
 a640c23a62f3a-a99f1676d6cmr600274366b.55.1728895255066; Mon, 14 Oct 2024
 01:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011135326.667781-1-amir73il@gmail.com> <CAJfpegsvwqo8N+bOyWaO1+HxoYvSOSdHH=OCLfwj6dcqNqED-A@mail.gmail.com>
 <CAOQ4uxj1LjzF0GyG3pb+TYHy+L1N+PD59FzBUuy0uuyNLgW+og@mail.gmail.com>
In-Reply-To: <CAOQ4uxj1LjzF0GyG3pb+TYHy+L1N+PD59FzBUuy0uuyNLgW+og@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 14 Oct 2024 10:40:43 +0200
Message-ID: <CAJfpegs=cvZ_NYy6Q_D42XhYS=Sjj5poM1b5TzXzOVvX=R36aA@mail.gmail.com>
Subject: Re: [PATCH] fuse: update inode size after extending passthrough write
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org, 
	yangyun <yangyun50@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Oct 2024 at 19:57, Amir Goldstein <amir73il@gmail.com> wrote:

> But why do we want to avoid copying attributes from the underlying inode?

Because that's just a special case.   The general case is that backing
data is mapped into fuse file data, possibly using more than one
extent and not necessarily starting at zero offset.  In this case
using the backing file's size doesn't make sense generally.

And because it's easy to avoid, I don't see why we'd need to force
using the backing inode attributes at this point.

Your work on directory tree passthrough is related, but I think it's
separate enough to not mix their traits.  When that is finalized we
can possibly add back mirroring of i_size on write, but I think the
general case shouldn't have that.

Thanks,
Miklos

