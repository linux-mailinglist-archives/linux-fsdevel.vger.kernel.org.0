Return-Path: <linux-fsdevel+bounces-39217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3512A1163E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 01:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7579188A3F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 00:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD8C1BC58;
	Wed, 15 Jan 2025 00:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIVEMH3g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9D33595D
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 00:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736902267; cv=none; b=avg3A0La0p6XJ36unbf2pAIkUwJQn8sOQkGzpbPtp/NlXT68qscSYNLVbO30ak2v93aMuISCSLgd6rwfFpMY3dZIxy0tMBYaZumGFFh41Oc/Sg9b56zT2sS1B+oPVNZEdFyNswG33KuY89nM66CYCry9NSaK3DJTf/2Le9zSsDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736902267; c=relaxed/simple;
	bh=UZequrAvRvKd4UTlNzoo0boLDHb5K7SNUlbAXXqfxO4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MPgXNd+2LXVgHHcSJbIIQBnyojJY3fxCh5kjcTd9H5KuioeWFDZ3wj8gvo7nsiVCM0NlP2ybsbzYH5rcxCp008WIPZqy5H2uGU7Q8MfjxIaDSrSkFeq02fYOswwOmM6k96BjsidptseYdvyZwdjvAeGD+ypwSFsu8TuaTJSSLxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIVEMH3g; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-467a1d43821so3300091cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 16:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736902264; x=1737507064; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UZequrAvRvKd4UTlNzoo0boLDHb5K7SNUlbAXXqfxO4=;
        b=aIVEMH3guGzsGTqRJRSsshroVZv5ceLgEAvQ3/v1PZH5dphkRekjqbSq8I/5TlndI5
         vAET4VKiJv36yVOWw/QsTZ5MZLxvpbPRGC6fpmW7zUjg5yqcoz379GAZ7Pqx5ajnvRdS
         16JwsD6x8XRh+PvAPK+mIa9pp+PH4EGy1RQ+xqmMU8UZdoEDx6bwk2EK2Qm/Z3Fum10L
         4xwfuOQdpZS05Ci7Y2qbhbTCtq4bhc7HQoka2XqdvvVjR8XYH5F1r+pue45eCunHttYp
         IOAcuqQegfIDTv7wTlMZVrrAq/ZCQQZQDRcrR/vujwr+hffKmIQk5oCJuaLriz5BI/0m
         +mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736902264; x=1737507064;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZequrAvRvKd4UTlNzoo0boLDHb5K7SNUlbAXXqfxO4=;
        b=mPgOi9aPnGGhGxADXCBC5mvw8XTMki74Y0xwHC/1aslGzOaipdVw7Y9dWfVBepDv9o
         4irxrUjHExhuzW4n8K3WdlkVqi/VC6LHAFXY4gfw1Lbj9M4xWFNMK0PipVDsqEhPOGdJ
         BeMwZNS8lJR5yXSOQnQ0dM8CKFJvIl5i8YEAuMNOsNpX8qWkhRbgMVcVezF26eaNNFze
         iD5ZRIWlcHz51nncrYOASDID+Y3LwJgjsHyTddKrki5v0oiK5cHPbHFAjfkwI/mwyDlj
         loVWisekZ7WNBE1+FFeBFw/aMpHns9BRU3qTXsXN3MMTK80cmgHVFbqxp1f4upeKS1O5
         c2zQ==
X-Gm-Message-State: AOJu0YyYvf/tCKUscoyfR+xzK7E+xASAGHQ0wGc12om7XSNb7K47e/gH
	klA4XgGPqlmjq8gyohT4QuJKEYhWoClP44Xb/7OAtOGCPXHDm13UtJqmUHwAhaGDBvSDCdOaQtE
	12EaBKYRfpOsc+xIqWYiQ10r0BaU=
X-Gm-Gg: ASbGnctsnX03gg2HpWh38nUb34dWbK3yhsyfio53XHEGLxFISYLqmnLy8SMwzlRn+YV
	mkpHySa9ur3BoNTBFSqxzPuFa1Ag60n1Bm+vxzMk=
X-Google-Smtp-Source: AGHT+IG0ULU+4kvAJL+SO0+TmFf6xUXVq5KlUeuTmvQS82g8Yiivvwj1NtRlshMXZmhGdlkLuTKnnzqYcQntN7UeRXQ=
X-Received: by 2002:ac8:7f16:0:b0:465:2fba:71b5 with SMTP id
 d75a77b69052e-46df56d386emr17630041cf.13.1736902264576; Tue, 14 Jan 2025
 16:51:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 14 Jan 2025 16:50:53 -0800
X-Gm-Features: AbW1kva7ivpAyvaPfCT1YGtWlyt-QPg3gb8b4M71_XGeZ22TdVC_qesb44X4K2I
Message-ID: <CAJnrk1a38pv3OgFZRfdTiDMXuPWuBgN8KY47XfOsYHj=N2wxAg@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Improving large folio writeback performance
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

Hi all,

I would like to propose a discussion topic about improving large folio
writeback performance. As more filesystems adopt large folios, it
becomes increasingly important that writeback is made to be as
performant as possible. There are two areas I'd like to discuss:


== Granularity of dirty pages writeback ==
Currently, the granularity of writeback is at the folio level. If one
byte in a folio is dirty, the entire folio will be written back. This
becomes unscalable for larger folios and significantly degrades
performance, especially for workloads that employ random writes.

One idea is to track dirty pages at a smaller granularity using a
64-bit bitmap stored inside the folio struct where each bit tracks a
smaller chunk of pages (eg for 2 MB folios, each bit would track 32k
pages), and only write back dirty chunks rather than the entire folio.


== Balancing dirty pages ==
It was observed that the dirty page balancing logic used in
balance_dirty_pages() fails to scale for large folios [1]. For
example, fuse saw around a 125% drop in throughput for writes when
using large folios vs small folios on 1MB block sizes, which was
attributed to scheduled io waits in the dirty page balancing logic. In
generic_perform_write(), dirty pages are balanced after every write to
the page cache by the filesystem. With large folios, each write
dirties a larger number of pages which can grossly exceed the
ratelimit, whereas with small folios each write is one page and so
pages are balanced more incrementally and adheres more closely to the
ratelimit. In order to accomodate large folios, likely the logic in
balancing dirty pages needs to be reworked.


Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/Z1N505RCcH1dXlLZ@casper.infradead.org/T/#m9e3dd273aa202f9f4e12eb9c96602b5fec2d383d

