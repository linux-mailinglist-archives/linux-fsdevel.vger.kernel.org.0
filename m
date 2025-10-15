Return-Path: <linux-fsdevel+bounces-64327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F7ABE10E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 01:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58B1A4E61BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 23:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF3D239562;
	Wed, 15 Oct 2025 23:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VevUj6rS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236941C5486
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 23:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760572155; cv=none; b=OPw+uHTg/oEhS9UcRX8q4prPQ/x1TNNxLhMcqZnb2a/qs71EsQeuYiNL365kmndAiu3FVg3ng8K87GdN40REml9zCV/U49xQDij6Ml6M4FTMVfQzuIPiSHTh6YKp/apzxZz2e+FmJk2+NRsfNdnALBBjes08O7QC2Kx5FpLu49o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760572155; c=relaxed/simple;
	bh=7m9wrbyvmgZ9oAv1nn7RmkTXEu+Nb6Sq1s2MIMpQMBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T017+ZjArsp4Gidt7Lodo2obzycsLTsV0buz+Ik4u2gkd9BAeZ5x4lBdoEBy9R5PpLvvVw0yK3UgOv02LmYg7HbSYBwKkrGx/RXH4LAt0K0K+AKpLp/QjsZWbY+HPhNerhUfbRwU0y9XJI6J9GpJutqUWu2duuyqbucxY/ILE94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VevUj6rS; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-78e4056623fso2115976d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 16:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760572153; x=1761176953; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RER45b4/yrM/+nzJNRKL4qzzuM+kcBeqee8XvLEAMlw=;
        b=VevUj6rS/WX/3jhQCvmoxBR0i0HM4sS7vcZhsI7Z5W71Rg81X19p1giNgpJE+ODErC
         TjZiMSbYrjsr4KIAOap8dkfM7/LOr5GGRlN4rlEZKJ4KwqbuftlEJTueM/2R6ek7PeY3
         kONUyDSGU2GhzT29ywiH2MJwoSh+V14VQxrKyBJdR2cZUFAajyF5IZlaiGpj5TdI08qK
         wx3Ps3DHUSwH79Ab6PwiwsGiDHxDNNcFFaFhtVNWFWfo+u5o+707+M5JEiSJmSeR2lWN
         R3DOThNUBbQO4HkQ/mKbBNML+XAi4+I/K3uJF2WBdIdpuNc5RbHuTjraptcV5hD6mXLK
         KAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760572153; x=1761176953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RER45b4/yrM/+nzJNRKL4qzzuM+kcBeqee8XvLEAMlw=;
        b=TNOkC7K99YT19gECZ1Dw4E2bHMLtSwVDQoX4HUwG3nn7bTOToU51UiuS1H/205twGp
         zv8PkSHLid0BxkMXwpxtNyaff/iYBl3QDNRCIG8j5TUW0aexcxQo/n9AZcpVsY6AJJCT
         uJI1Ix82G64ETC0L1giaIcIXC5f8826yoU4Uhpbb87jUwzG+WvguqBUyMgmlgFW09Fqo
         c8L9s3YrZu7PoXl1N0KiiPokrBb1e3jD1Ha9rIWBYoliM9nPtJh9GK+CCZ9N/a4sPBd4
         Y9TxwYiS2Hl1bTSHZjKi/kh/jLHsF0PieGV7yAxcLMTrE4OvQgkyUNMzCS74+XC0qqkp
         nqSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP/YWli2TOsfgNTVIIZ7SS88MtVJfi0hnS9LGw5IfjZixQ7ssD7SMBjgaw4xVdTbFNapQMyHoxuDTNUsZg@vger.kernel.org
X-Gm-Message-State: AOJu0YxAI2nBZvYGfosIO1JI84/cTz2jhPijoc8mt5uCRELkAHs8xLG9
	tky37QQX0jeWiHYw4cjSnmPbow9xPGkLN2Nmfa2IUszYq9d6TKeya5yppDqZNmx/IE95iDC17cR
	OsiifR8YZbmM0lQlB/pCx9Z8ZjQ6WCwA=
X-Gm-Gg: ASbGncva4DMyKQ2V7JNO6m9rqg+TpJx3trWW2FpImlXtfXUMVZqQai6WgNLv6MGE7Td
	hPdzmT2cVbfjHn0vBxUF4phwK+ANiwItkRGk9MXVkLMfWo9e6h6GqoeoaCMJjGd3tq5QZiH1um3
	FmAlbitFDAG97vmG1mXrzohWCin2RWp6ffsqQ3qrIEBOXxK60vxygoi4hfMTheCwHhlnkUI5f1d
	Wcg6wI2MElwnIZ3UFBSb0yf87TrSDIcWUepH2M7Ciw2k37WO+TL6NmPh+CJwM/svWzfX+hd1hSB
	G/IqYlwgn2nHnogsn6nqCJuCKPU=
X-Google-Smtp-Source: AGHT+IGrzjK9F8YgFBHw/gJarm5WrUJqkgN152k/TJHvnjquECvIJrGsCAsmIbOP+jzcpgK/nA9FQw2qcPBoXOrYMVc=
X-Received: by 2002:a05:6214:1256:b0:875:a069:8849 with SMTP id
 6a1803df08f44-87b2ef6ded3mr470513326d6.47.1760572152696; Wed, 15 Oct 2025
 16:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com> <20251013-reduced-nr-ring-queues_3-v3-3-6d87c8aa31ae@ddn.com>
In-Reply-To: <20251013-reduced-nr-ring-queues_3-v3-3-6d87c8aa31ae@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 15 Oct 2025 16:49:02 -0700
X-Gm-Features: AS18NWDFe4u323eTrqNRSLlS564DOaXaaLGGHAczkx3EeZttP5KfrGcaMN_AE3o
Message-ID: <CAJnrk1aaVa4hc_VC4G1axT1_=b6eyRW01KVczhvitCcsN7cACw@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] fuse: {io-uring} Use bitmaps to track registered queues
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> @@ -983,6 +1031,10 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
>         struct fuse_ring *ring = queue->ring;
>         struct fuse_conn *fc = ring->fc;
>         struct fuse_iqueue *fiq = &fc->iq;
> +       int node = cpu_to_node(queue->qid);

Am I reading the correct version of the libfuse implementation in [1]?
As I understand it, the libfuse implementation sets queue->qid
sequentially no matter the user-specified cpu-set [2], but the qid is
used as the cpu id, and we get the numa node from that. My
understanding is that in practice, sequential CPU numbering often
follows NUMA topology (eg NUMA node0 cpus: 0-15, 32-47; NUMA node1
cpus: 16-31), so it seems like this has a high chance of being all on
the same numa node? Or am I missing something here?

Thanks,
Joanne

[1] https://github.com/bsbernd/libfuse/commit/afcc654c8760f0c95f9e042fc92f05b1b9c3df13
[2] https://github.com/bsbernd/libfuse/blob/afcc654c8760f0c95f9e042fc92f05b1b9c3df13/lib/fuse_uring.c#L830


> +
> +       if (WARN_ON_ONCE(node >= ring->nr_numa_nodes))
> +               node = 0;
>
>         fuse_uring_prepare_cancel(cmd, issue_flags, ent);
>
> @@ -991,6 +1043,9 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
>         fuse_uring_ent_avail(ent, queue);
>         spin_unlock(&queue->lock);
>
> +       cpumask_set_cpu(queue->qid, ring->registered_q_mask);
> +       cpumask_set_cpu(queue->qid, ring->numa_registered_q_mask[node]);
> +
>         if (!ring->ready) {
>                 bool ready = is_ring_ready(ring, queue->qid);
>

