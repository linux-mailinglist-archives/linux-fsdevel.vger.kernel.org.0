Return-Path: <linux-fsdevel+bounces-32135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E929A1241
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 21:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DDF3B24484
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 19:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877BB2141A0;
	Wed, 16 Oct 2024 19:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D0GWx5zV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB5518BC33
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105545; cv=none; b=pTz9aYnB6MLucvrynue9uwXYI9oaynz14PMaEWdOoc3R3daBSl5OHDSCMU21jmQVN1cHyJg9NrcLnGJ08am3zO9xsY/qFdwsQimYXSfGytCGqcwrJmsDOMk7Dr502Xr97NtgFsIT4go7cZAA3QKlUGvlhcy0IkRyYPygwrfUQQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105545; c=relaxed/simple;
	bh=8AJc7nnOVnEcgZoFHh8+qQ064B2g1njgKpyNk4S+kxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eo4yPszRmKxx0mWQWHEfgUAqmGOJSveQ9WhDGIoqMAJQZVXcoZQsCE43tk9xdc2XEYw8ANDHAinxynjWu7qMmiutmz9fr5MOuuuiKdA+P2ouO8KHAOFNWcjMj/XdAvUFR+KpGElUasTssFvt5etCvqLrROHaQE2mGvHjVeeQ2zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D0GWx5zV; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4608dddaa35so51421cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 12:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729105542; x=1729710342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o4fS3U7sZSvRVdJyoUhS3TF3Nb+W11QQ+SMyGO80/sw=;
        b=D0GWx5zVsXJGXrLVN3Z1PKbfrK559qbciGomzq51fZ5A11ObhY3KPZqPmeVSV+9zIs
         PdHjAf/+lSNAfegGle1b/wTRvCc1oNsFSbqim4SpsOFoyl900/8s/AtNw3dQ9RJUQXTo
         OQBYCGxDib+WQhcdE9RAvLXvuWfnirC00vcmkaaOTPj8n9K4sbSY8tMf+kQhwOGm+fet
         SnEyk3Z9Xc7CWUWgugt/AHXRV3HgD+vkaLdZbv12eCQ11IOUL0rmowMwkhLPLsdyOukT
         E5sLyS24p2mkioOfMrpFKoYKmDLr8HpLQRTdfmQ/nT/nWZaxKF4+5mdDYQe75jRvhWOM
         059Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729105542; x=1729710342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4fS3U7sZSvRVdJyoUhS3TF3Nb+W11QQ+SMyGO80/sw=;
        b=kOG7QQ4Ntzvx/X1QU8tkNNXlq8UxFwVXVD/X8w9OBzUOsYMjuQdF/CR4viY1Xgwzut
         Cb1LVO0mfSZEciv6LPVs+mus9Vu5jd/uYJAD8PXcknyb6XkA5F8xPOpsHSkRlLzVEKCy
         0VHtRNck07barJ+ZCUdX25O7hPYbZcDcjmep4k7I6wLidE/GSLO8nQC+o9GoP75usGUt
         tqov8zOIFmJeaWTSCA15La/y4+gyp3lT7jk3SrGhZCaHCqA9JrUMZSv/u1Qq7ioPgMp4
         fNBUwDUETdfZqpXoZQDK2+AIjMpZ22PJFcXUYXQaewGfPYNPd053aNP4Qk9FSR+/i4pX
         eyeg==
X-Forwarded-Encrypted: i=1; AJvYcCVYR2CRo6fnwnwmnFn27W2X97Ut1jukgx4xxil481At+5Gv1GqucqWMRWdvw5R+jCobEg+BSDe0pCtkAIHf@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd4OHcm9R7HwJMr/KFhs5qWYOiFf48gvwIzxOVrrpvtN1GiAiv
	MF/Tx/2gwDz2UYxq7P0xpHc9LBvpUy3KRJSA8u8b+82mVnICK4Mz3ClpB7lVKQ==
X-Google-Smtp-Source: AGHT+IE5vMu8b7tn/Vo4Stb0Ua1CGr54lW9KQb9aB0aHmUEk+fl1QrOBTLpAkMbB5h460JEQLGsq5A==
X-Received: by 2002:a05:622a:a313:b0:453:5b5a:e77c with SMTP id d75a77b69052e-4609c7856e5mr528301cf.10.1729105542146;
        Wed, 16 Oct 2024 12:05:42 -0700 (PDT)
Received: from google.com (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc229245fcsm20946876d6.58.2024.10.16.12.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 12:05:41 -0700 (PDT)
Date: Wed, 16 Oct 2024 15:05:38 -0400
From: Brian Geffon <bgeffon@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, jack@suse.cz,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	cmllamas@google.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
	jing.xia@unisoc.com, xuewen.yan94@gmail.com,
	viro@zeniv.linux.org.uk, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	Brian Geffon <bgeffon@google.com>, stable@vger.kernel.org,
	lizeb@google.com
Subject: Re: [RFC PATCH] epoll: Add synchronous wakeup support for
 ep_poll_callback
Message-ID: <ZxAOgj9RWm4NTl9d@google.com>
References: <20240426080548.8203-1-xuewen.yan@unisoc.com>
 <20241016-kurieren-intellektuell-50bd02f377e4@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-kurieren-intellektuell-50bd02f377e4@brauner>

On Wed, Oct 16, 2024 at 03:10:34PM +0200, Christian Brauner wrote:
> On Fri, 26 Apr 2024 16:05:48 +0800, Xuewen Yan wrote:
> > Now, the epoll only use wake_up() interface to wake up task.
> > However, sometimes, there are epoll users which want to use
> > the synchronous wakeup flag to hint the scheduler, such as
> > Android binder driver.
> > So add a wake_up_sync() define, and use the wake_up_sync()
> > when the sync is true in ep_poll_callback().
> > 
> > [...]
> 
> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc

This is a bug that's been present for all of time, so I think we should:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2") 
Cc: stable@vger.kernel.org

I sent a patch which adds a benchmark for nonblocking pipes using epoll:
https://lore.kernel.org/lkml/20241016190009.866615-1-bgeffon@google.com/

Using this new benchmark I get the following results without this fix
and with this fix:

$ tools/perf/perf bench sched pipe -n
# Running 'sched/pipe' benchmark:
# Executed 1000000 pipe operations between two processes

     Total time: 12.194 [sec]

      12.194376 usecs/op
          82005 ops/sec


$ tools/perf/perf bench sched pipe -n
# Running 'sched/pipe' benchmark:
# Executed 1000000 pipe operations between two processes

     Total time: 9.229 [sec]

       9.229738 usecs/op
         108345 ops/sec

> 
> [1/1] epoll: Add synchronous wakeup support for ep_poll_callback
>       https://git.kernel.org/vfs/vfs/c/2ce0e17660a7

