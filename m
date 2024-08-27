Return-Path: <linux-fsdevel+bounces-27311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DB396023F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 08:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BBD31F219C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 06:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2601814659A;
	Tue, 27 Aug 2024 06:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qdsb9Vhz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209793A1C4
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 06:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741393; cv=none; b=ITa+hqOTpffP3KM3mJQ9KUOHyuVaI1Yq8PsJS14D2KkNnSLVrkLsNYyUfc5RIem7VXO/3vSIXktaQZW2KMsQXuiHNSobo/L9repYD/vjz0qeAEvcgDLcgJi1nz+BPuwNWWCN3wbGZrueWBU6f4u3J2bjusJhM2WkFoiLt2d0Ghs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741393; c=relaxed/simple;
	bh=9ojnZ9KJm0GThQVUCAK+IX2K/fgnDiwoUoBn/WNobng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8MGzWtrasTy4CL3lYJpHYzvtAhMUY6XZ9Z7YvgOqvSAWav/36L2CHs4BP9PHFi7dlV2idIwe11joJs28bF/zNbta/R+waHxLfEySK8wiNVaX4kBz6kuMgSc5pqnYPHRXWCZF4BrLVOpSqravza/ntzfAy2yqfvlhcb2SQ1bjBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=qdsb9Vhz; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e1a2264e907so1280475276.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 23:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724741389; x=1725346189; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NaSCqeePu3M8nYseClfaN0Dq/yFsd5BoRfoPOMvbtm8=;
        b=qdsb9VhzO0dVmVchDwxNZ7EFScsQSOUqedx8cIFBVKwtcUmai6isrqRYf/lGqK/ksa
         6tvoeRl5yd09XAtkg3iF3v9EgJ5Dq2pdw9Jx+VhehU6pHhvCF4NGbvJQPHdXprpaRp70
         NHE7yoOEKIPkq13ZqpoI1PCGxoBxRB0+CEd0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724741389; x=1725346189;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NaSCqeePu3M8nYseClfaN0Dq/yFsd5BoRfoPOMvbtm8=;
        b=IBGr47BO4EhvwPX2IyqoXVj1MfubFQ2eDWCQfBksdPzrsf4Fy+woBSkCZGe3Y9K3L9
         cvp6Ez2/JOJZym/C83Q8R6w9LuBNzn/gJ0SHUxIf7WIhHClYa17B2T5AwkBTIGCneY0c
         NSOL7n6NOvcAC+a7yM1S5/izx6MSZSjC2q87axaaK20QNE85sUeaPp7Hl/D82mYTuX6t
         gFaXrbx0oOkAWDQ2Hm9uKtlNgswtJbwkztnSYrB4317zkrquBLQbMUxSHeMEQU24p9WE
         GpLhZhoDmBrul1UNHchC7bdp3kDZrvIIYc5gLKt8MXwMY+Br5OEgUIka2VlGbO31Ms7L
         exQQ==
X-Gm-Message-State: AOJu0YzExt0DHqZT57E8Nik3uCNng+WxFBaLsyQcJpiT0o0/+iUYocFx
	XlmdtV8Gh+lG9rE5i/wpGKj29wuB4V7h4zHm/1rWG4LWH/csnd+/zQ433Pr8hb628To/kEuh5tw
	GleFpPE5Lsq3c5hY3FgsdxttDyZCCs6N5UVZnYuEByfSsgtrM
X-Google-Smtp-Source: AGHT+IFGKUKrPXPTArUKDoRj+i+SIABpUwYkeH8ZUrjwRFf/lf2sqSgysg1JNlRrmTxISyu2gQclbhdJgl0flZNnloc=
X-Received: by 2002:a05:6902:993:b0:e16:6feb:e615 with SMTP id
 3f1490d57ef6-e17a8e65ed9mr17584291276.48.1724741389029; Mon, 26 Aug 2024
 23:49:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826203234.4079338-1-joannelkoong@gmail.com>
In-Reply-To: <20240826203234.4079338-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 27 Aug 2024 08:49:35 +0200
Message-ID: <CAJfpegud2cp6EoGa+Q5og3rEXKf8Ds32wXeReUMMktjDJvtMmQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] fuse: add timeout option for requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Aug 2024 at 22:33, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> There are situations where fuse servers can become unresponsive or
> stuck, for example if the server is in a deadlock. Currently, there's
> no good way to detect if a server is stuck and needs to be killed
> manually.
>
> This patchset adds a timeout option for requests where if the server does not
> reply to the request by the time the timeout elapses, the connection will be
> aborted. This patchset also adds two dynamically configurable fuse sysctls
> "default_request_timeout" and "max_request_timeout" for controlling/enforcing
> timeout behavior system-wide.
>
> Existing fuse servers will not be affected unless they explicitly opt into the
> timeout.

This last paragraph seems to contradict the purpose of the system-wide
maximum timeout.  If the server can opt out of timeouts, then
enforcing a maximum timeout is pointless.

Am I missing something?

Thanks,
Miklos

