Return-Path: <linux-fsdevel+bounces-48384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD819AADFD5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C471BC732E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 12:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D680D2868A5;
	Wed,  7 May 2025 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bQgEfzl9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F61286882
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746622482; cv=none; b=fZYeeehrKK8rwZNryukY3+bkJfKTjSg12p8a+/guspQ8ClTmutB+idmBd4DPq8YZ3aD7YW8yt1rLWomAuw91cp+8EZndOujyFkl2JU+6XYaf5cxqgFoKrkcm+R63/KeKlEbXeJhPrnNDVuOQ09Dvu6Xr/aMO2gU0zLYkjUQidzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746622482; c=relaxed/simple;
	bh=rlYkutOJbTy9t4vetbaK1MFW9+WsC8kSGvqRmbg4uTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dn95KbHjTBi6YjNj0lbuHXx4L4xdtD/y2hoIrfWcTxt0aWw4iH2NpyQdLWK3VbBdl1AwEZUSbQPGbM1yjoxiRfvyqo59YTcc1WvmyGQL6yeXcxRWGjzhli0jLZiMURAqnOOlXXQBzX1bBUDk+Kv6EVlQkkp1wlbN7FQmscO8Sjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bQgEfzl9; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5f4ca707e31so11090880a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 May 2025 05:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746622478; x=1747227278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ypa3PBqDtPswGp9XxxvAriQxh6M+XVug4d/DpMvuJqc=;
        b=bQgEfzl9HbV8Ufg4s3XJVQe96sNXP7OOsBMso7IeTpJK4VOET69YYJ7wptPA1gA8eT
         hyO2wPLd9NNQ9HSUjdgA34EoT5aAx5KDPbmW9s+C8Ke555bjUvd6sZ0/QOxpM/q0br9S
         PAW0e2+pDYwW8NWIqmmyRM3t5BRFt01Nm0tXBo+LMwByHGRN8BaZHxC8o5iKDbvkJC4E
         QHLBhrEJ0XLqWnVsFYUPizrj/K01Fa6hjsj3H3ubi3FHqIl9v2E6JwcWsCtyrt/CGwZF
         mKO6U/3Ysm0+0GGZXPgJKGq8Q87Rd55yLH8z/AdEAyaoVfXUn/gUhP5TwHUi7tAcqDtq
         Wreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746622478; x=1747227278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ypa3PBqDtPswGp9XxxvAriQxh6M+XVug4d/DpMvuJqc=;
        b=Ex4UnRXPruOx1IKyLaA3jETRk8xt2Iq3YU8BWcSpRosJt13/fR9VjdtZGydApzAnua
         0VRKhRcDdGFYb3vN7Ef0TPnQSafFqSEODfPau39UmyzRFkLY2AiolJk7n78GirJASP+/
         /Fx8SH25x3qBbpGVR0e+2rmnyaJAsEVY2ZlgrGC2qoYfwYm7VciADdTgVR1VjMv6RCGO
         A2gGNyMO8AUU2SeZc1vVHB6QQOzdCEVq9bNJPFyTu+GYRu7fXmIOqYyA9TvpZLwDqAlj
         mAHBe1pEZFusLc90lg9wxOf6mHanjuZeTIoANwxmdKA83WrQ75fwkI1NYbxExnJzTZRV
         cOKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwCOG9Yj5ca3lS5Io3Nq223LDcyieNSPn0dOzaz8CjGOx6jcufzuNowAaDLpA0hXmQz+t4vwwGFIp1kbMD@vger.kernel.org
X-Gm-Message-State: AOJu0YwluQYb4eBBs5mVOobAJtElwQLWrxdRyn5OnslLfxwrmKf1pqGa
	muJ1HIgg/0McPM9V/1Hpp6CV+KwNDW7MagVP9k2mrTSWaAaYg4KVCZ0Q9EAuIFlPqroGZRr6Pls
	F
X-Gm-Gg: ASbGncu9O82gds+xfA9jVUWSyouOnEuFKrbeSbti74z2CB32bZ1NP2Zx3sv7PrL3ONL
	30aJPkQAfC+np6ELl7ZXJZJztBn2I92DCkXBT+vbzeNTcWvo+tLGzysI44LYSyyzzZeduw0PwLr
	o8L6zA9qW093RtBrur5Mnv71q2648dnLOQZDLyZAJhCHtU26IHn41/bEtfsxlEcKmwrJkkIKIei
	OOa0BXH380iaXAdj8LGqZvvJeWJzYsPdqeSywVmnEzoiTxu+W2Avt09Q0jsEZjx7vIvrc2Gtsbc
	x5GJAjZRlzPXtfYJKVmMzodcRER9IVSnEW6cT1RGbtIvjbHbbn8=
X-Google-Smtp-Source: AGHT+IEEHI/oSTREUk8HTc9X/nZpZu+JH0JNL8Ix0W8ZxxBaMoWEfgZFH93pE+NmBTNHIMjXerli4Q==
X-Received: by 2002:a05:6402:2547:b0:5f6:252b:f361 with SMTP id 4fb4d7f45d1cf-5fbe9dbbe1amr2731807a12.11.1746622478474;
        Wed, 07 May 2025 05:54:38 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa77b914b4sm9354161a12.51.2025.05.07.05.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 05:54:38 -0700 (PDT)
Date: Wed, 7 May 2025 14:54:36 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
	laoar.shao@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
	david@redhat.com, viro@zeniv.linux.org.uk, keescook@chromium.org,
	ebiederm@xmission.com, brauner@kernel.org, jack@suse.cz,
	mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v3 3/3] exec: Add support for 64 byte 'tsk->real_comm'
Message-ID: <aBtYDGOAVbLHeTHF@pathway.suse.cz>
References: <20250507110444.963779-1-bhupesh@igalia.com>
 <20250507110444.963779-4-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507110444.963779-4-bhupesh@igalia.com>

On Wed 2025-05-07 16:34:44, Bhupesh wrote:
> Historically due to the 16-byte length of TASK_COMM_LEN, the
> users of 'tsk->comm' are restricted to use a fixed-size target
> buffer also of TASK_COMM_LEN for 'memcpy()' like use-cases.
> 
> To fix the same, Linus suggested in [1] that we can add the
> following union inside 'task_struct':
>        union {
>                char    comm[TASK_COMM_LEN];
>                char    real_comm[REAL_TASK_COMM_LEN];
>        };

Nit: IMHO, the prefix "real_" is misleading. The buffer size is still
      limited and the name might be shrinked. I would suggest
      something like:

	char    comm_ext[TASK_COMM_EXT_LEN];
or
	char    comm_64[TASK_COMM_64_LEN]

> and then modify '__set_task_comm()' to pass 'tsk->real_comm'
> to the existing users.

Best Regards,
Petr

