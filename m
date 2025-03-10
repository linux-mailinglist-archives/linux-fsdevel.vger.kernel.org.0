Return-Path: <linux-fsdevel+bounces-43642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2B5A59B84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 17:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9FBA1694E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 16:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED3B23536A;
	Mon, 10 Mar 2025 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="e9YzPdcR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F2E23237C
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624990; cv=none; b=oSJZmJfued+zTA2RqJqEb9GP//V0JbyiLhM4CqprkRxeYsxVj66bb8QdVbehuT6ZwyutZ7G1q/3Vw4MdKTYxbmvMFjsmIKJWciGRP0HlQFH4yc0+FDeKlfOb2r5Qn0r2Y7NgQ+KXYVeDvx8zq6eNRLcprF2lQPomdu+rQlLnWfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624990; c=relaxed/simple;
	bh=KeJ1RRzvTqUvULwTdyZYl5//YQOn9JBoSQ1imwwbGMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXi0kTQlWKV2cU9QeiJliNEr2pCwFqBlf1xS99RhKkfxO6lKzOEXV1piIRUuJG4tNbzxUIaWgIzimFuwUV348atBbEAaWwCwDpkQ37Lan2K2+Ma4RT5xCT5CaodotT9yGQT8QtKFWSOm4g5GyLHo6S74f5U86rWA7L14O0Zg2GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=e9YzPdcR; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4768a4fdfc6so12634311cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 09:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1741624986; x=1742229786; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o7+xCb6XzG3joR6a4M5865iGYkCdDkI6eexc4SK+HB0=;
        b=e9YzPdcR3SFGD+bZJnuWgXoRnN1teJnbhbLGJ02CMSZV/2Sh/iFUP1vtA+FZICDd1h
         /ojuL8ALW2tgQyVBsfq+shE/L2G1YWwcfx7MgSnvikhjzOwwSlt663tDAohogz99P02b
         RdYm8pHf0JncWM8AzIv+qaLfAktzdvfUkyHtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741624986; x=1742229786;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7+xCb6XzG3joR6a4M5865iGYkCdDkI6eexc4SK+HB0=;
        b=MQ/R2YSdj8Y9fi43+xHN11Ajr5VPYPop56NuGVYPDBQqLoyUcA0M3K53LWnghnGEOQ
         MBV4buUVlG/x6C7EGOEaNcwvY+L1xlJcul+u5ZWyYdpZBBv+AetlxeNvZzjwSOEd1yq9
         zmkvMdFNb/LApd+fSR8WTQtWyEGoWN3TnRCDOeuaaEfwXL1u5Y9hFy3qVXZIB+W/jEtE
         zNS7b0Mf320BL+iuKvSPSaVCTd+MJffrJRpCQTU0YFgC4l0ftrPI4js0RrpVX4CfTOFl
         bs7iFJHkg1qcaEQm+8twSN7ibarc7kqj01/ENQzup6gHEo+xmDopvswHRXjvF4EHxXN7
         iy/w==
X-Forwarded-Encrypted: i=1; AJvYcCX+YDKnlYJgZGZUPY0ygswGspZgwpA4FGOqQP3fpY9hHzSficNvkJRSI/q2osoyn1sw2RtiP2F0gua1hF8G@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5H25q8WDNPXfOtIoYB0d+pxq/2CRpsvIWRt0cU1jdMj68ad62
	0XHRUFubyfNK1txxuSexC4spNUNbbI4w7RPGvW+4Izk6G4Sl6h7SHf0k6HSnUfstSmV54KMV4WC
	u5/xTouRXe53tIbNRAcRtBw1gR9BbQ5YS87IRQg==
X-Gm-Gg: ASbGncvtdXIP6S47xsy9xlttuGIVW4KFjTw9Ub57cBb/6K3aNyyBW6svIYEu/HlxOJT
	A6Rioob66FamWJ3NcjWxxhQSe2G1jx3SjFQyDf/xoFPsr9o7FbXbSRaYOKFZa0/4ig42GRqUa3C
	yRm9s5B3Sc9SlalafhWtu9LY+N/2U=
X-Google-Smtp-Source: AGHT+IEBIzx9e6K8gY1P3uwG4053vKnCQo/A/45CHTp4TpCwHW2p6fOzKlu/gMvt4iEwPXinaX6bmM7d+7zufNH5siI=
X-Received: by 2002:ac8:5a4e:0:b0:476:959b:7592 with SMTP id
 d75a77b69052e-476959b7aadmr25117691cf.17.1741624986587; Mon, 10 Mar 2025
 09:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226091451.11899-1-luis@igalia.com> <87msdwrh72.fsf@igalia.com>
In-Reply-To: <87msdwrh72.fsf@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Mar 2025 17:42:53 +0100
X-Gm-Features: AQ5f1JqEE_1WaqbsqdDTMPa4eJILmqSWGchDRmitOQV2dELsrChoGlHoLVS5zaw
Message-ID: <CAJfpegvcEgJtmRkvHm+WuPQgdyeCQZggyExayc5J9bdxWwOm4w@mail.gmail.com>
Subject: Re: [PATCH v8] fuse: add more control over cache invalidation behaviour
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Dave Chinner <david@fromorbit.com>, 
	Matt Harvey <mharvey@jumptrading.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Mar 2025 at 16:31, Luis Henriques <luis@igalia.com> wrote:

> Any further feedback on this patch, or is it already OK for being merged?

The patch looks okay.  I have ideas about improving the name, but that can wait.

What I think is still needed is an actual use case with performance numbers.

> And what about the extra call to shrink_dcache_sb(), do you think that
> would that be acceptable?  Maybe that could be conditional, by for example
> setting a flag.

My wish would be a more generic "garbage collection" mechanism that
would collect stale cache entries and get rid of them in the
background.  Doing that synchronously doesn't really make sense, IMO.

But that can be done independently of this patch, obviously.

Thanks,
Miklos

