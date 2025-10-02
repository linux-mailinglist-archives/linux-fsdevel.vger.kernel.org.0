Return-Path: <linux-fsdevel+bounces-63278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FEBBB3D36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 13:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1D2188BC96
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 11:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D1A30F94E;
	Thu,  2 Oct 2025 11:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJx09Q2U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4F1304BC6
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 11:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759406092; cv=none; b=gm859oq4aN7t9fX4trRF3jqxiAF5Tq9dMbwtJzKxSpuI7BK4bZT4/NxNgb6HC4KlAoUM5onlU9alGQfCcVX0R3f9ZeeAiI+POxjDxL87Fa5WWPvhxGAb8wMAoOKX6Rmf3eB+gQd+vHXpMiXdIwZSpAV93RSfD5+jZMDKeGjEkhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759406092; c=relaxed/simple;
	bh=CiQaJSolDkLTBiP7d22ebBS222iLR/eWy9VY4O24jAk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=u9eQMerFF347lI09rHx8ymH23O1LRYzmmWyRaAUCkeCHyUXp5zAAtf2OB/qjKuNJFrIxeP3fI/5JbTncEJL6pSdRLC+OwqPbNd8Yh7obVFbZaDCTxhPqf8IVo4DpDQIH2fxbAh48dT35s+sMP9h7bJOPjCrNuxeEs7WI75FzKZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJx09Q2U; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3352018e050so951994a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 04:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759406090; x=1760010890; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2MEPE2QW27JrdMKZac1PCB7F11qUoZlbdLVQjAYukwQ=;
        b=kJx09Q2UwYLYuuX1l4+GF5GgZ/A9zAetWQ5ZeJ3sN2NHLX0qbc5ZBsl/Ffp+XbUOnL
         tOL746TKMTy1l7OIIW2P5+vued2ejIfGS7XuWeBw6P07wRrPMdHAqosjQaqgYzzLJxcg
         8LtbCD1qNrFEO1SfqzkZSxk+9lg3KlbN2CfZVzYg2RiegFA4F09fAUVNBHqD4NcKcOOy
         7fijxndreAZyH4dtt3FCayiWl12qfXfK3fH26qGYeaeE6HG7lS5aqd7saLIzRLEB+cWj
         Gm+4BoeQYivnvT0fgHEJKD/rQGHFTHoKVMyMGqqRnmIQhSsBZQv7lrqmn6KfWm3FdtrK
         w9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759406090; x=1760010890;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2MEPE2QW27JrdMKZac1PCB7F11qUoZlbdLVQjAYukwQ=;
        b=TdL7BOPXLK0wsZ7lJ8/EspeHmB511V6ctiC4EtATjqGAosa9N3kRYznVIYdLsh3LuF
         J8+VxmuD6AlFkMuaVbWw2lS5Wxokj0YtvbPnpuPne/+AiN3GEkgfpPq31X7bbg1LDotG
         YykccRskrtHENVVtbFYxmDY0PdgnqSVNcemwsa92pnU9n5d9DW8467Tn/fubc+hAD0yg
         famMG8WxaNZsqCNzIoApRwsUxdEw1db8PlNYenyFpovHGYnviVpYKQWTCgGG+FRGiHf/
         RKj6E1qVHaHTPpWPjL6nGu3FMoeS5EoOwr9fO1z/XSfsnwiM9RYRH+u4cHgxPHG3cpQe
         zlAA==
X-Gm-Message-State: AOJu0Yyr/zTksk1yfKymrco8+A6ngBjC7L35NjNVBal42TkazBo0XNc7
	6WFPGW3L/NRAQChyyhnmeDvo5VfDcsPDCc0jRhkGUh5BLJq0eQ96VC1i7Ms0YGtDtcUWWCN7SoE
	TRHgnRCSTbfh3vIsExAbVOvGVCbd/HJ42xsyi
X-Gm-Gg: ASbGncs4UbXYd8sZRJ7MFq5OkuqDjUHuTjiUXsmGIj+S7rEP35Ndo/C+9EGHn0JunOZ
	3TUBp2UPoKb25auqtLjynU+EXfwjTTe6wOTesjWCnr/G2uMUFdSVN2GkXQzMu4CeiFuTuAN5tDs
	rnU9U3cgpjPQ33K0bW6QIocV5r38TFrBCmzQZP7tLozrvHWDyxA69ouHvLNYiODKVEb5tzndPtL
	rhD7ZciqIkqp2g7tQJ53yrhDO1+JHp9
X-Google-Smtp-Source: AGHT+IFk3aIF0BG78wY22RKlYck29nzFIPPMLeLKddhrrMy+aWAB21y8ywch6FZgzUnECSW1RTfR/W5JHH1RtZxtsV8=
X-Received: by 2002:a17:90b:1c8b:b0:335:2823:3689 with SMTP id
 98e67ed59e1d1-339a6e63b9cmr7968173a91.4.1759406089883; Thu, 02 Oct 2025
 04:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Miroslav_Crni=C4=87?= <mcrnic@gmail.com>
Date: Thu, 2 Oct 2025 12:54:38 +0100
X-Gm-Features: AS18NWCej9-rA4yLi-eBlqunvC9hk6YieElLY_L85oOVRpimzMC-pVpTqhQn8WU
Message-ID: <CAD8Qqac-3Oss=M4aU0B_gKCzBhuUo0ChH+8wFkWDPz=mQVqSiQ@mail.gmail.com>
Subject: shrink_dcache_parent contention can make it stall for hours
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The current code can hit a substantial lock starvation on
parent->d_lock when shrinking a large amount of children.

Scenario:
- Parent passed to function has a large amount of children.
- shrink_dcache_parent is called concurrently from multiple threads.
- Thread one collects all children into a dispose list.
  To delete each one it needs to grab parent->d_lock.
- Other threads keep looping over children.
  This holds parent->d_lock stopping deletion work of the first thread.
- Work stealing does not help as it steals at most 1 item at a time.

We hit the scenario above in production in a cluster running a distributed
file system (TernFS). If you have ~100k children and 8 threads calling
shrink_dcache_parent can result in all threads being stuck in
shrink_dcache_parent for multiple hours.

I think there are two possible approaches to remove this pathological behavior:

Option 1:
Don't differentiate between work stealing and own work.
Collect items for work stealing in the disposal list along with regular items.
Fight out the contention per item with try_lock and continue through the list.

Option 2:
Change shrink_dcache_parent to collect a dispose list for one unique parent.
Split out unlinking from parent from __dentry_kill.
Run over the disposal list in 2 passes.
First pass does everything except unlink parent.
Second pass does all unlinking under a single parent->d_lock grab.

I'm happy to submit a patch for either approach, but wanted to validate the
proposed solutions first.

Thanks
// Miroslav

