Return-Path: <linux-fsdevel+bounces-24797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E7D944DFF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 16:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1EF1F25607
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 14:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE7C1A4B3A;
	Thu,  1 Aug 2024 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="tUmaI21Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0959F1A3BB0
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522496; cv=none; b=LtdIe1clpHUyTcJkSkxpYjnPMYWN+GN96hdN5mhKK9QsrRubxiypGgAdXhdlShtOzcQrihIcvcZST4yyEpCqDeU3qrRnd2mniIlyFxwTVmTr84Ml944U9urWZFPmF5lY5AydwqYEUWpfe4mupM8Vwbphi3QSNoqnz/IikwK3SzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522496; c=relaxed/simple;
	bh=/Pw3QSE2gQ3HGNcd8AdQrmQmNEZQXSpsYvrgZ7iaxws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGM/6sSVVoo+lIKNLq9J2uo5I4V9g378qWDCwTPCcvfQTMluHk+b3dFk/nM3eYyM8YDEzygiJb6yDiAc9lTjllsPxXexES9CPlF0oAPx/MaJvapSzxJhwz2+H3ozPyrjxdTpt8ssflf5bJCEgaU/eMqHDfq+/gCtYpwVFwcMumU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=tUmaI21Y; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-682ff2f0e67so32961847b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Aug 2024 07:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722522494; x=1723127294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EuychuuM4yFooarrHI4W2akU/wSqmgofCLcJrrZseNc=;
        b=tUmaI21YRAsuQBdGHYDQwncuOrTrAiwaiErANTD4ZLvZ7YPbvIzS5eMniLmAzxqcaQ
         1NoxjXUzZZntloz87+jZUNKyhxFk0/5J3rjHf/n1dRVQ/AECTSQ3KyYlp/l5AkIn8mc8
         w1H7/6a1QeFC2umFrXFzUWx5iw1MWb0Z0Ajw1AMw4Tk3d3b6eGbX/2NiW4PKB0accPe0
         OZtidiPZgx2Sdd9rTBVXsE6FYo9jkZDDwTFW7xeXB5bY7vYj4HSXNR62vSEYLMB2xSCS
         Tk22HbO3GojhMUUjujCpucxtARnypMq/dT0sb+tfmcyvU8SwMf+hasf9Fn5vw934RcJj
         6ZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722522494; x=1723127294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuychuuM4yFooarrHI4W2akU/wSqmgofCLcJrrZseNc=;
        b=NC8eihA+T0HQRG5lfxsaI/Q0+7ppf9pkmiEZtTiFcK2JMvycy1e26LH5qgKAEDl6d3
         KmTox7sVSIvz7PPt3nXfirp4vpjJk+MCgZCRCo8khbcVCIPdbvVhtQ1mYQuK7fdXLwCf
         yekr1rzPk047SDCzH1MdhQ8rUiu5dhmjlMlHU+LX8dRe4+VMpwZT+twBT3krqOd+5Dnj
         IR3cs8YvMQeQ0Vk5uU4qUNufBt54r3KmDMLxmRLqmDBjUD6W1Abs7+6B9VMape/YvuBm
         7+JQgmxsVH5yeg7C8a4HnbM3NTvHC1st5QnPrk/MUh1+/vdvqPsndSQUH4t6l2rOpHed
         WB3w==
X-Forwarded-Encrypted: i=1; AJvYcCXKS9SZPU5tISrVGcJ8lcrE7QxXCntqM40xQXKtjgGw9rwS18CTYY5VaHH3+YgB3OapMJR5Xzz+iLDEKZbNYumaYX8LbKGQIK5PmGXgnA==
X-Gm-Message-State: AOJu0YyS+tElSdr9F/1e1BXwFhS9I7U+rOYJBSDAvued9gp04/7m+zPd
	iAG0tyY7oTdwuBL1pISk1lx4aE7duaa1gAnsLCu6talG68bOFQitOnfMwIUYTcE=
X-Google-Smtp-Source: AGHT+IEWtdWvFS2c69Uec6FJ0Uu06+DfOjiepBA1ctw9pK/wJ9IdsjdEszDUF6QIPWxR6kd4lkyKQg==
X-Received: by 2002:a81:b406:0:b0:632:6615:3d67 with SMTP id 00721157ae682-6895f9e5e38mr1972857b3.6.1722522493999;
        Thu, 01 Aug 2024 07:28:13 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67568209b96sm32991887b3.68.2024.08.01.07.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:28:13 -0700 (PDT)
Date: Thu, 1 Aug 2024 10:28:12 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH RFC v3 0/2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <20240801142812.GA4187848@perftesting>
References: <20240801-exportfs-u64-mount-id-v3-0-be5d6283144a@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-exportfs-u64-mount-id-v3-0-be5d6283144a@cyphar.com>

On Thu, Aug 01, 2024 at 01:52:39PM +1000, Aleksa Sarai wrote:
> Now that we provide a unique 64-bit mount ID interface in statx(2), we
> can now provide a race-free way for name_to_handle_at(2) to provide a
> file handle and corresponding mount without needing to worry about
> racing with /proc/mountinfo parsing or having to open a file just to do
> statx(2).
> 
> While this is not necessary if you are using AT_EMPTY_PATH and don't
> care about an extra statx(2) call, users that pass full paths into
> name_to_handle_at(2) need to know which mount the file handle comes from
> (to make sure they don't try to open_by_handle_at a file handle from a
> different filesystem) and switching to AT_EMPTY_PATH would require
> allocating a file for every name_to_handle_at(2) call, turning
> 
>   err = name_to_handle_at(-EBADF, "/foo/bar/baz", &handle, &mntid,
>                           AT_HANDLE_MNT_ID_UNIQUE);
> 
> into
> 
>   int fd = openat(-EBADF, "/foo/bar/baz", O_PATH | O_CLOEXEC);
>   err1 = name_to_handle_at(fd, "", &handle, &unused_mntid, AT_EMPTY_PATH);
>   err2 = statx(fd, "", AT_EMPTY_PATH, STATX_MNT_ID_UNIQUE, &statxbuf);
>   mntid = statxbuf.stx_mnt_id;
>   close(fd);
> 
> Also, this series adds a patch to clarify how AT_* flag allocation
> should work going forwards.
> 
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
> Changes in v3:
> - Added a patch describing how AT_* flags should be allocated in the
>   future, based on Amir's suggestions.
> - Included AT_* aliases for RENAME_* flags to further indicate that
>   renameat2(2) is an *at(2) syscall and to indicate that those flags
>   have been allocated already in the per-syscall range.
> - Switched AT_HANDLE_MNT_ID_UNIQUE to use 0x01 (to reuse
>   (AT_)RENAME_NOREPLACE).
> - v2: <https://lore.kernel.org/r/20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
> Changes in v2:
> - Fixed a few minor compiler warnings and a buggy copy_to_user() check.
> - Rename AT_HANDLE_UNIQUE_MOUNT_ID -> AT_HANDLE_MNT_ID_UNIQUE to match statx.
> - Switched to using an AT_* bit from 0xFF and defining that range as
>   being "per-syscall" for future usage.
> - Sync tools/ copy of <linux/fcntl.h> to include changes.
> - v1: <https://lore.kernel.org/r/20240520-exportfs-u64-mount-id-v1-1-f55fd9215b8e@cyphar.com>
> 
> ---
> Aleksa Sarai (2):
>       uapi: explain how per-syscall AT_* flags should be allocated
>       fhandle: expose u64 mount id to name_to_handle_at(2)
> 

Wasn't the conclusion from this discussion last time that we needed to revisit
this API completely?  Christoph had some pretty adamant objections.

That being said the uapi comments patch looks good to me, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to that one.  The other one I'm going to let others who have stronger opinions
than me argue about.  Thanks, 

Josef

