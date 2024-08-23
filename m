Return-Path: <linux-fsdevel+bounces-27002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6858895D936
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 00:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C2C284AC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 22:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8257C1C871D;
	Fri, 23 Aug 2024 22:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVIUBaMa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3011139CFC;
	Fri, 23 Aug 2024 22:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724451728; cv=none; b=kESFMM5qDMRfWpYbEQTMztxM4fLXBdV2yDwKoyWWaERxYuYw5cBNn+DVxcjKiFEvqWaTNuWkDuEDCq5vxB/HJNyaty5AlBkaTX9hQBqp6LMEF81iVPiJ/XO0DF1RBGF24cE/e8/iuYmhPBjOz7g2bpnLiijJBSJwp0ke7NzKRB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724451728; c=relaxed/simple;
	bh=z42+Q8AZanZAyEhdmQQpfFOP7RxuncrUYLIRyjSCh9o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C38aPCPHea+nMGaWt+uYWIwqb7/Lu87jkUC7RWgOCC+1+4e9vkgtXjevIwT/bdpqqjMlGEsuvJS5Dyt+opx3e9muSjJDhao7aBq0muBMOaeniM0bhYMPtVwy43mS/wNpUlcmXaSfr9NEtW676Vxj6I+Nnr3S7KNyRqFPBlD8sCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVIUBaMa; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7cd9e634ea9so1486912a12.0;
        Fri, 23 Aug 2024 15:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724451726; x=1725056526; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z42+Q8AZanZAyEhdmQQpfFOP7RxuncrUYLIRyjSCh9o=;
        b=VVIUBaMaktKP9nz8snJlPUlrdtL0V6tViSNgHLtce/i8hJCHnPiTkMt4jtBDF1Cbza
         gIChOUxuGFWyMcU5ZHDIll9/Oj3DE2YTGqxkauoD7Ru8PG+Qgjx0sLtOlc26u0Ao4It8
         QYO/Hims1YqkAvJPh5azVmFjQCVvtAQ1twOIi7za9dbK5e4OQj236JXOVOEVa4xC9U6n
         NqeYnd4p66poBn7tGELW+uLxqjwcoj7k2eee5kGyTAcartNf1xXRBsfJhvxy94HvJCZ3
         KkQ6sLDYpigdpFEZbAvm9340eRGPwWw6OBcNujfaxqavx4p5hyaCJlVd4ooIz5cn4ta9
         bSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724451726; x=1725056526;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z42+Q8AZanZAyEhdmQQpfFOP7RxuncrUYLIRyjSCh9o=;
        b=E680AjRAVjax+9sMNQs70o/T2qfnaHDyxq4Lpw5gJyEosq01zswm4viFz36GRMhxg5
         nD+hGvjd2QAoNb4Buupu+cK7ia47jrCupvUJtTgTtss8qdLzENCcOh+CQzfeBx2Mmco8
         LlgMsprGELCsqz0/FEPd0cdH1XCL3J4ZvoyH94wnqYG8qtOjouUoOBoNq+6oJ5B23NHO
         e3khFDzU6BIisuGpMcPMY7jLmp4nQO368sY0gRJC88MbsgGmdKZeP22UFfpBwbnTKaS8
         Io8Yit6NnF1AALc5IZzjhBsMX6idorBFsiqeMKRlUYxL6GmMqQR9mA1B6F1Wjm+5DBgB
         tQjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTWu5y3n9Fr3oBi3bTdpXoChzYQC8I66m/3fimCxHvEh6q2zBxqQxbroiZ0qxfrIXl90A=@vger.kernel.org, AJvYcCVyij9FjGv4GwkxfEtGYJMO/9D/PVOALC1ivmzj1iU/bxvL7Bknr+TJC/hEwk91FLnRZo9UCEa9TMu4COjUSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAB2/dh3nrcr3oOSUz9ApdrRadF/STOyY5GeNRGgsdbgE/zEZs
	P6ayMpLfVdjhYvgM2y+JAUinps+seC/XhXgup4BYfl57rMrjlc29
X-Google-Smtp-Source: AGHT+IHe2MZNqfdwKxtjHPiq7/ZoqoBvwMUroZDtf9P1IkJ3Smw4qpWQdX0dyd5EQEp0cv9vlkwxkQ==
X-Received: by 2002:a05:6a20:c793:b0:1c6:f213:83b with SMTP id adf61e73a8af0-1cc89ed955emr3749733637.37.1724451725696;
        Fri, 23 Aug 2024 15:22:05 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613a420cdsm4691284a91.28.2024.08.23.15.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 15:22:04 -0700 (PDT)
Message-ID: <8fc31d49d4666599cc2ac6815ff3e0b09adc8a94.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 09/10] bpf: wire up sleepable
 bpf_get_stack() and bpf_get_task_stack() helpers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, adobriyan@gmail.com, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, ak@linux.intel.com, 
	osandov@osandov.com, song@kernel.org, jannh@google.com, 
	linux-fsdevel@vger.kernel.org, willy@infradead.org
Date: Fri, 23 Aug 2024 15:22:00 -0700
In-Reply-To: <20240814185417.1171430-10-andrii@kernel.org>
References: <20240814185417.1171430-1-andrii@kernel.org>
	 <20240814185417.1171430-10-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-14 at 11:54 -0700, Andrii Nakryiko wrote:
> Add sleepable implementations of bpf_get_stack() and
> bpf_get_task_stack() helpers and allow them to be used from sleepable
> BPF program (e.g., sleepable uprobes).
>=20
> Note, the stack trace IPs capturing itself is not sleepable (that would
> need to be a separate project), only build ID fetching is sleepable and
> thus more reliable, as it will wait for data to be paged in, if
> necessary. For that we make use of sleepable build_id_parse()
> implementation.
>=20
> Now that build ID related internals in kernel/bpf/stackmap.c can be used
> both in sleepable and non-sleepable contexts, we need to add additional
> rcu_read_lock()/rcu_read_unlock() protection around fetching
> perf_callchain_entry, but with the refactoring in previous commit it's
> now pretty straightforward. We make sure to do rcu_read_unlock (in
> sleepable mode only) right before stack_map_get_build_id_offset() call
> which can sleep. By that time we don't have any more use of
> perf_callchain_entry.
>=20
> Note, bpf_get_task_stack() will fail for user mode if task !=3D current.
> And for kernel mode build ID are irrelevant. So in that sense adding
> sleepable bpf_get_task_stack() implementation is a no-op. It feel right
> to wire this up for symmetry and completeness, but I'm open to just
> dropping it until we support `user && crosstask` condition.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

All seems logical.
You skip wiring up support for sleepable bpf_get_task_stack() in
tp_prog_func_proto(), pe_prog_func_proto() and
raw_tp_prog_func_proto(), this is because these are used for programs
that are never run in sleepable context, right?

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


