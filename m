Return-Path: <linux-fsdevel+bounces-37196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D458F9EF6BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 18:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4521942B82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 17:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6358D223320;
	Thu, 12 Dec 2024 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2VAQ1OAw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2775A2210E3
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023694; cv=none; b=ux0c7Qoh4tJChykALKr/3dIWyOjBAlF2PJ7YDgWbw2fHQ4kWSZf5sxVMHsn4vaSvNyc9+QH0Kkm5QiTedkGgEM7g5aLNSb+ZVbzpwmRlcgFyoIn3XVGBO4+OTBFRPofRUivM9hconkwzvAzJT0VxHXbelG9wTLQDBs8d9fb/OYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023694; c=relaxed/simple;
	bh=3VhHoxhtsIYlY9delcNaANiN7hnym9vuOfGY5s9r26Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2HYhnK27ILaGU8cSwvjhbM6E0oRS7pwwbHjRIJyUZXXYCRhHPUjzLl/8mXnfKaBpg9BCIll4Sd3VLWOiZat9q5BkyB2VWKk/K0/4RuWhB2X+hhLuET9EENW4lmuD0Zbfbm+XauKpVQ5BJ10cv84IKVMmdsQP72h8Zjyv6YSqLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2VAQ1OAw; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4678c9310afso299771cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 09:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734023692; x=1734628492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wUN1FGW9s6aYaX1rahb83q8l6+aJSntI9ZnzO5TRvUw=;
        b=2VAQ1OAw1bc3MBS17U0f/2tZvXsavPeWgpMiube6+fGHeX1/hPeuttKMvmZ2Tmk5tC
         KBCVUWzIPEQFZzZVBjOtrx51baDoAUHwzLf1dSVWMQKhFftQFdLYcHm5COIz9obkdQbB
         xaaUweIYtTtO+BgVJqxu8T9JuYmEP9mAdfmlN87IQP6FI8Wtjba/MUjGJ1ddMLRcQX3J
         nNOKHbdv5AS5RQfy6nKJoyidtJQ4KvKv3n7S747jMUFgXYykpPN77B8Ky7sIsium2ZFe
         XhqO1Al/PlnOoVCnTUx2s0d5dyNGxWyCTjERDFbSxeRQvjeDXLbV+ywNbzkiylwI5lLg
         SFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734023692; x=1734628492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUN1FGW9s6aYaX1rahb83q8l6+aJSntI9ZnzO5TRvUw=;
        b=cHMywx5zar/Bi8VTHbAndzwuducSMP59+FLlfsRUBno5bGzpWX5lof3YYA9fAqO07O
         wCbjPZ1EKs9X54VYrx8tB9oxQ6nX0cVhyUBeZxg5nohIQX4yovkGknaGik7rGy4YAJTb
         1TSLWciaONIIvDWG6Qf58IgBn7N646vLc2AuydQrsT7IHreY+Xaht/AaoHFJTLUVhVO9
         kEH/sjOgZSogfuBLZ6KNP48jf/TIHq1Edt1wFbwAuqchkCOjuVcEVrT/sNJTzzq1rZO0
         OZmwK5HQxUpue5jScGi1Q+UHTPZNNaySYZUup5aK6tBycPtcuQj2Ng4sNDN6meuD7ZNG
         7Eqw==
X-Forwarded-Encrypted: i=1; AJvYcCVmAY6Idx44BczQyj8UVfd49bTToC00duSiLbvUclfx7Cayx51yuyvmYRDu4iTsLpPGTg4mTm6phDRvcCu9@vger.kernel.org
X-Gm-Message-State: AOJu0YzotlmatWaG8DD62SMYtnkviFRxVTXhrBwvD6PMW6OclSFR9CjV
	oc3z0cotyF+5aDnAwu8TTRhFwYxOSY2n2Qru1vE86Ijp04PuTAR0PJ4RS2BI/w==
X-Gm-Gg: ASbGncubkXrZBy17DHi8gBckW41qd7ojq5ixeo4VMhDQkA5W8kyD+flZas+mpsy31HT
	2Z3WYbi8TT39F/ccc70vNkBh8PXFF8T2iIPgJTpYRBV/uO+xBTW8OcEitEzeRkMkWn1cTNuvEef
	CTO5B0fjJL3eoZr0Ks2tZZAmRuYt6Lrv0iNd8+WqDJfdJW9cj+xJ4VvraIE923IAcXPbZh4hEGN
	PqTMetVlLQZbZiN1VIQCVphd+eSfYt6uBA9wS0UhJNTrGUcL3k/orAyBzs05tIvcsfWxD5TrJxo
	KhN4oasiqW/1kaTaiQ==
X-Google-Smtp-Source: AGHT+IGgjH6GqV4jXXmphoAA+pxi/+QUQrcufFJsbeUtuxETjKPMe94758G2fCviij2ZNFYfuwddKA==
X-Received: by 2002:a05:622a:5197:b0:466:8356:8b71 with SMTP id d75a77b69052e-467a10186aemr1322081cf.19.1734023691781;
        Thu, 12 Dec 2024 09:14:51 -0800 (PST)
Received: from google.com (129.177.85.34.bc.googleusercontent.com. [34.85.177.129])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d90299bccesm55849206d6.60.2024.12.12.09.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 09:14:51 -0800 (PST)
Date: Thu, 12 Dec 2024 12:14:44 -0500
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
	stable@vger.kernel.org, lizeb@google.com
Subject: Re: [RFC PATCH] epoll: Add synchronous wakeup support for
 ep_poll_callback
Message-ID: <Z1saBPCh_oVzbPQy@google.com>
References: <20240426080548.8203-1-xuewen.yan@unisoc.com>
 <20241016-kurieren-intellektuell-50bd02f377e4@brauner>
 <ZxAOgj9RWm4NTl9d@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxAOgj9RWm4NTl9d@google.com>

On Wed, Oct 16, 2024 at 03:05:38PM -0400, Brian Geffon wrote:
> On Wed, Oct 16, 2024 at 03:10:34PM +0200, Christian Brauner wrote:
> > On Fri, 26 Apr 2024 16:05:48 +0800, Xuewen Yan wrote:
> > > Now, the epoll only use wake_up() interface to wake up task.
> > > However, sometimes, there are epoll users which want to use
> > > the synchronous wakeup flag to hint the scheduler, such as
> > > Android binder driver.
> > > So add a wake_up_sync() define, and use the wake_up_sync()
> > > when the sync is true in ep_poll_callback().
> > > 
> > > [...]
> > 
> > Applied to the vfs.misc branch of the vfs/vfs.git tree.
> > Patches in the vfs.misc branch should appear in linux-next soon.
> > 
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> > 
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> > 
> > Note that commit hashes shown below are subject to change due to rebase,
> > trailer updates or similar. If in doubt, please check the listed branch.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs.misc
> 
> This is a bug that's been present for all of time, so I think we should:
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2") 
> Cc: stable@vger.kernel.org

This is in as 900bbaae ("epoll: Add synchronous wakeup support for
ep_poll_callback"). How do maintainers feel about:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org

> 
> I sent a patch which adds a benchmark for nonblocking pipes using epoll:
> https://lore.kernel.org/lkml/20241016190009.866615-1-bgeffon@google.com/
> 
> Using this new benchmark I get the following results without this fix
> and with this fix:
> 
> $ tools/perf/perf bench sched pipe -n
> # Running 'sched/pipe' benchmark:
> # Executed 1000000 pipe operations between two processes
> 
>      Total time: 12.194 [sec]
> 
>       12.194376 usecs/op
>           82005 ops/sec
> 
> 
> $ tools/perf/perf bench sched pipe -n
> # Running 'sched/pipe' benchmark:
> # Executed 1000000 pipe operations between two processes
> 
>      Total time: 9.229 [sec]
> 
>        9.229738 usecs/op
>          108345 ops/sec
> 
> > 
> > [1/1] epoll: Add synchronous wakeup support for ep_poll_callback
> >       https://git.kernel.org/vfs/vfs/c/2ce0e17660a7

Thanks,
Brian


