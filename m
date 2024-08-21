Return-Path: <linux-fsdevel+bounces-26477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A8A959F02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 15:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC38EB224F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 13:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2685F1AF4D6;
	Wed, 21 Aug 2024 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Pe7kGIqx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29491547D7
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724248091; cv=none; b=C1VR7GGbs+0dm7KXfBL76gCMU8fI/A739KaOnQRmjlDrMuB8jcrxnKlwBG/8DqVYNAZ8hc4/cSCTd2M8dKyvdmyWN7ZKHtEyk3rFYCMdCiaA5mawnuQYJtvR4GuSfrV6bubBkfAU4wfuiihZpgWrmRzyRfiguVlmsWVK0S6G+2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724248091; c=relaxed/simple;
	bh=vvEQjKTkoDcMWsOy53sNfVohXyGob/mreTjtvJ6259Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2qhr4Vfr3KQxRu1tXiwHW9yzOQ5Bq0k8XVC070UgPNbU/a4CIs3vEaIaTCYZ19XalH6QYTuu5jUBbIr3PvQLeSnD9XfNkswndwIbb7DaknbjxH4pGzEAh242P2XYoQULC5a1+D6pWIStATsnH0Otz10gS5SN56/WdFfoi/Ld6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Pe7kGIqx; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-533462b9428so2333249e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 06:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724248086; x=1724852886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TkR38jWDrZKdD5D6Yz+GstsLuKEJPKe1Q2ijxeJuDHo=;
        b=Pe7kGIqxA+NuzS+ibU31+7tmaUlmM60R6GgcQXlVDwf5bn4dnK2h+GB95aDGxiy6gs
         6xa0JM7eSvi0S+wqq5+R0YLUxKuYEgsnbQsFpmJK+ni1+IR6UkQwSXuShLxLR/88JrEy
         vVJoBSS1BhOA9mwH5FRCbRpKv7FtgVkkaq40s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724248086; x=1724852886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TkR38jWDrZKdD5D6Yz+GstsLuKEJPKe1Q2ijxeJuDHo=;
        b=L4NqspzueifAP9JiknpFjcNv5+DQ8Eclzku2HkzYSpQ8Yyf1aya+06S/nClJpWud85
         D2SWfLjaq4nG89aQy9Rv/t7Fw29w+dXRvykA9NShGKJSIEM98OcWSgj6pk+Z1i4OyVZi
         vMrcSehlrV4FtsmLvZBcGLaE7UU9izcShvBSJjSJ0Q4Fw6BRPWehuP9KwY+7q0TayYn0
         /pDvTMV/x7pTMctSaEaHnAw5Z+z/3CdJ4mQFJkEPtggLcxI2DCqTkZysKiakrXi877Ln
         rK7aQqfi7fnU/o0M7SfsZGWHSzA5p892x2IHURmqu1kZos84Lkljm2RJnEqCW8KLsUYR
         n/Ig==
X-Gm-Message-State: AOJu0YznbrSoxZlrZxy2Kv3u4rO6T387EjmtAvMU+LOXtKURmxhsGChV
	+3cjiPSfXJcYglIWi2qXbb/lkG9jr9k1E0G6EJ0gRU1qo0kixIzoX8VwDf1JBVUVYsQkfWiKsl8
	QPfSOBEhbXCxIUbh455PHAJtGYyBXeqYaZYRlbg==
X-Google-Smtp-Source: AGHT+IHS3QQRfH6iti7o6ueobmZRNya9N7t/vZUxiin5CUeHAWZPrCuGW9AIcSMdmRg4+K+ERl2XcLxZLhonajKf4/k=
X-Received: by 2002:ac2:4c46:0:b0:52c:e119:7f1 with SMTP id
 2adb3069b0e04-533485ddad5mr1602807e87.51.1724248085206; Wed, 21 Aug 2024
 06:48:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813232241.2369855-1-joannelkoong@gmail.com>
In-Reply-To: <20240813232241.2369855-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 21 Aug 2024 15:47:53 +0200
Message-ID: <CAJfpegvPMEsHFUCzV6rZ9C3hE7zyhMmCnhO6bUZk7BtG8Jt70w@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] fuse: add timeout option for requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 01:23, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> There are situations where fuse servers can become unresponsive or take
> too long to reply to a request. Currently there is no upper bound on
> how long a request may take, which may be frustrating to users who get
> stuck waiting for a request to complete.
>
> This patchset adds a timeout option for requests and two dynamically
> configurable fuse sysctls "default_request_timeout" and "max_request_timeout"
> for controlling/enforcing timeout behavior system-wide.
>
> Existing fuse servers will not be affected unless they explicitly opt into the
> timeout.

I sort of understand the motivation, but do not clearly see why this
is required.

A well written server will be able to do request timeouts properly,
without the kernel having to cut off requests mid flight without the
knowledge of the server.  The latter could even be dangerous because
locking guarantees previously provided by the kernel do not apply
anymore.

Can you please explain why this needs to be done by the client
(kernel) instead of the server (userspace)?

Thanks,
Miklos




>
> v3: https://lore.kernel.org/linux-fsdevel/20240808190110.3188039-1-joannelkoong@gmail.com/
> Changes from v3 -> v4:
> - Fix wording on some comments to make it more clear
> - Use simpler logic for timer (eg remove extra if checks, use mod timer API) (Josef)
> - Sanity-check should be on FR_FINISHING not FR_FINISHED (Jingbo)
> - Fix comment for "processing queue", add req->fpq = NULL safeguard  (Bernd)
>
> v2: https://lore.kernel.org/linux-fsdevel/20240730002348.3431931-1-joannelkoong@gmail.com/
> Changes from v2 -> v3:
> - Disarm / rearm timer in dev_do_read to handle race conditions (Bernrd)
> - Disarm timer in error handling for fatal interrupt (Yafang)
> - Clean up do_fuse_request_end (Jingbo)
> - Add timer for notify retrieve requests
> - Fix kernel test robot errors for #define no-op functions
>
> v1: https://lore.kernel.org/linux-fsdevel/20240717213458.1613347-1-joannelkoong@gmail.com/
> Changes from v1 -> v2:
> - Add timeout for background requests
> - Handle resend race condition
> - Add sysctls
>
> Joanne Koong (2):
>   fuse: add optional kernel-enforced timeout for requests
>   fuse: add default_request_timeout and max_request_timeout sysctls
>
>  Documentation/admin-guide/sysctl/fs.rst |  17 +++
>  fs/fuse/Makefile                        |   2 +-
>  fs/fuse/dev.c                           | 192 +++++++++++++++++++++++-
>  fs/fuse/fuse_i.h                        |  30 ++++
>  fs/fuse/inode.c                         |  24 +++
>  fs/fuse/sysctl.c                        |  42 ++++++
>  6 files changed, 298 insertions(+), 9 deletions(-)
>  create mode 100644 fs/fuse/sysctl.c
>
> --
> 2.43.5
>

