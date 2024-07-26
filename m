Return-Path: <linux-fsdevel+bounces-24326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21BA93D54B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 16:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2DFE1C20C3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 14:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21C6182DF;
	Fri, 26 Jul 2024 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="LSGKgyxz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12AD125A9
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722005117; cv=none; b=lfYnJx7vQndtewzwGp/vEUWjsIqSbBUVQ1K+dTh1aERpSOsW6nVUb/Go15hAw01eHGwju8mP0s8yLZU1LpmCqQvtKoBrhY0RfoSnAPfOtNzdNrEcRR9/KdoJIqkgjARopyOGjDsixXvDPowNnAkhEnPhXFbDWUS83VdNEIg+68E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722005117; c=relaxed/simple;
	bh=T+KJ7cQfRCXjo91q5E32xqWylcaKB+qGBJ80nVcj5NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5NwvcZDhteWShEOSYYGjK1XwpHT6DTE4pJn5sUbV7V6CWmkcx0obaJ6xE+FVrCw33jktpwtYXTHinuJUOjvih95qtmGoCOoPK4J7Z3JA6UZgr5nmR0RRm8oH8XsDDDtOLq2ixhzdM+CDUGwpa+tCqwuRPFuHXTKwG4a0gpJ0ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=LSGKgyxz; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a1e24f3c0dso28229285a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 07:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722005113; x=1722609913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/VvL9tXNXLYJuSG2HUf/ouajoETjvl9NExJIkRRZ+eI=;
        b=LSGKgyxzn0d4ICxhlxzaudtG4Qh9lLEwajaXxV9ytvvAfdf7cAyJ0rViEfDD+V2fgv
         wd3c7AfsNDizUMWjoZBdTWhpm+AsThjkMATaN+829vsmXArny2oHDMrtfgY6gCS1K8GR
         tU/0SC/W6zqlU6qXF/9EK6y87fnw3HREw/UDpJSY8P1RbIUMng4m3RCa04MHU855mpYr
         pPRqna1PqP5xXrw8suc/GCBVEpfEsfrtCT6SZ9AkwMLx8b7Cn3OjPQO6IFtvluZ0dl9d
         DjWA2Fb4682QyJvAiiGjuhcH/7d9RHSfYgHTZ7Eaz80tgVpmTOKn0UGmMpz+V5vNWdXI
         bIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722005113; x=1722609913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VvL9tXNXLYJuSG2HUf/ouajoETjvl9NExJIkRRZ+eI=;
        b=VP4biLdkazL4tcONMqRVnEg89hIeMlJKRdhNkG87Opex7fODLdHB5l7xvT6BvXIG1E
         vjxbFftqZdO+MT4nRuTHt0UpnQ6thdezu46sGy/FZXjetHzQzUSTPKL87LJpzy9jCKIt
         pbpOtfWc3+/G5g5Aqh7/+V9E95yk/aUapdHuF3m3VytnWT3UuyI8T5sWRZtad8tfDvH7
         4uGsJb4BUdDM21hnOhXyHak665LzqUBipNGu5+4Ps57+MeN870t80ouRwFGSp3dWZrHl
         Mk9WmM0zEtvB4l68V9BsIvBZpyV8AQiHzxfHW28huPCrM4zLD2Mcl/AkJfoPB4XF0QW8
         zOzg==
X-Forwarded-Encrypted: i=1; AJvYcCXH2EZk0woEmbHiG++Wk/JQk4qgpc4fkXRsu0YMgfNq06Y0xMnwUgD8nGtPbJ9hjpmh/dw16USyaAfuRYP3oo631uONVarrFwlIhC8Amw==
X-Gm-Message-State: AOJu0YzOx5kiFtcKTBZ+x8YezjLKi9KuUxu+OpXruw/tR1YnL4C3PIK7
	zIFoiVFr6ZXh5ynCVvz2JcCSg3KRDfc9UeZlVl/DJ2wFEQoeDofg9JE9H3ZyXJs=
X-Google-Smtp-Source: AGHT+IEWD8GQVgW1l0g7s9LJSu4vyMi8fl58d7+j4v05ucpjRj/800uhBjyZvfrwBmzi5MnCaPb5DA==
X-Received: by 2002:a05:620a:4041:b0:79e:fb1c:a1a4 with SMTP id af79cd13be357-7a1d7e5dec9mr676872985a.18.1722005113649;
        Fri, 26 Jul 2024 07:45:13 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73b379csm182388385a.42.2024.07.26.07.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 07:45:12 -0700 (PDT)
Date: Fri, 26 Jul 2024 10:45:11 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	winters.zc@antgroup.com, bs_lists@aakef.fastmail.fm,
	kernel-team@meta.com
Subject: Re: [PATCH] fuse: check aborted connection before adding requests to
 pending list for resending
Message-ID: <20240726144511.GA3432726@perftesting>
References: <20240725175334.473546-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725175334.473546-1-joannelkoong@gmail.com>

On Thu, Jul 25, 2024 at 10:53:34AM -0700, Joanne Koong wrote:
> There is a race condition where inflight requests will not be aborted if
> they are in the middle of being re-sent when the connection is aborted.
> 
> If fuse_resend has already moved all the requests in the fpq->processing
> lists to its private queue ("to_queue") and then the connection starts
> and finishes aborting, these requests will be added to the pending queue
> and remain on it indefinitely.
> 
> Fixes: 760eac73f9f6 ("fuse: Introduce a new notification type for resend pending requests")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Nice catch, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

