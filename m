Return-Path: <linux-fsdevel+bounces-32698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 399A99ADD9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 09:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0261C20342
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 07:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F426198827;
	Thu, 24 Oct 2024 07:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXiaW/Bs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BCF18B46D;
	Thu, 24 Oct 2024 07:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729754965; cv=none; b=DjPrdyvayla/iQj/PSfAHlrKegAcgHZ+1qw6Z9jlaQn/aC+Gcsc/8dcqKLXxIS+SOHN9/FI0g1sGkAENS00r9A5Mg4HV0emJA86BiJW2eapDpdqMvmKkhofLhNfUXNq93lebKdC0339Gg/2yo4nhX3hXJVPvmEr7XPG15DJmP7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729754965; c=relaxed/simple;
	bh=62OiTPdLC73E4bSWiNopGU0nw3unHoyjiWfg3+9xkoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hWAGxC44esIcuALcUJ6P1a+1OUdKdWk8gGhxmImr3DQm6S7CS6bMdGIu7aAT2bxZKHRUjgkkHGBr2bUoBUD0S+pjjXPaBe+OzoLDBRh6/PXqWIcrVJG7zCFqiyGb7+vbMD9pZpPyyM6RpX6a+WdNq+v3SZGF1ncsiGtvsXjl2F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXiaW/Bs; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-71815313303so399450a34.1;
        Thu, 24 Oct 2024 00:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729754963; x=1730359763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYzWy6kio/5TGHmC4KnU0HU3SKktd6/yeFNR0szREPo=;
        b=iXiaW/BslxSuHbsN3sqKCLBX7F5Lkb3G6VtRuCcPKBI1yt3OiFbnDK2YlpQMNi6tOY
         TwKR9fy5fw4CKrAque0eKZn0TQwSvKascVj4WXMo1LI5MvdCozfg/fUaR5EsXNvuvgUH
         PZEpZQVRV2V/bVQXktCOLs2MUOMoXUC+AFhAL1uLfaVKs1Osw0ExRRQNGPUpSzYFefa/
         zx0pLKljqIqu9r17GU6swnftyy9fMgSxRywD15o8qpW+NvnytvLDe4WqVhGQomurhyNf
         lHi7t+e7kbDk4oyVSBhInyASCt4GnfbMXzUKQddBrYo4+yzd5/O7X0XvCAEq0wImq5/K
         UNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729754963; x=1730359763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYzWy6kio/5TGHmC4KnU0HU3SKktd6/yeFNR0szREPo=;
        b=DDqcocmuFSJaV8Ma54stPZOHq43qGI/Se5Y5NfBuz+Iz4xMl4cLlz0ARcVYA4/lhe6
         QH4Nu7kEDq+mvDr7Dwg6o5g3K2kgBPZVhvHEuPPwgfdQu2Nn8NcWQGIk5J7KeYnB9xSe
         gDKXcV+oksgqw6Ejkra3F+SrhPr/xLJWqIUMI5WGVXz+XHtTw0mcC/fh14e53P0pWyOA
         kDV61bhz6qxDn1qTAPamPYErbCR/zDm1UVhuM/4FqVVhwHWkvMA4I+yMneR7x1XBBj0m
         hKVSbM8h6lkM9RKqRAlCe26ca5vlId+VDj2ImNI5C80Oz3v5uZsDvtB9q6KaeRYYm/Lp
         IwWw==
X-Forwarded-Encrypted: i=1; AJvYcCUHZ3lVcg/uT7+024M1fapZ8wAZCx/m+G+qIj8XmWiPvuQGEzJkSLXeDpPaZfGiHy8Dr8ALNTKtl9c/XwWg@vger.kernel.org, AJvYcCUy4ARauPNth7VLEX3NRG/lQHsdLaYAYM1A6gX0ymItteYKdHRzpA5/mIOZaxXIUmslGyZdIxWFwLnh85vn@vger.kernel.org
X-Gm-Message-State: AOJu0YyHq47A0lYvSvuFnddrQLQlurYrfAYkUdPWAPr2H1xSupSZoxlj
	FC7d/1cWWXVpyWooQkgEQzTXJUNDJB7lz7O6LE7uDlZdeRkcFxC+
X-Google-Smtp-Source: AGHT+IFj/sLrVs1zpDnBVyrOd3V+tOWXLkNCExzIVHuijrdfZtdlUlBm11jYo8zP2Sw/Y2vR2Mnm+w==
X-Received: by 2002:a05:6870:169b:b0:288:865e:1864 with SMTP id 586e51a60fabf-28cecdcfe8bmr1079911fac.0.1729754962806;
        Thu, 24 Oct 2024 00:29:22 -0700 (PDT)
Received: from localhost.localdomain ([43.154.34.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13ea1c4sm7393825b3a.152.2024.10.24.00.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 00:29:22 -0700 (PDT)
From: Jim Zhao <jimzhao.ai@gmail.com>
To: akpm@linux-foundation.org
Cc: jimzhao.ai@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org
Subject: Re: [PATCH] mm/page-writeback: Raise wb_thresh to prevent write blocking with strictlimit
Date: Thu, 24 Oct 2024 15:29:19 +0800
Message-Id: <20241024072919.468589-1-jimzhao.ai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241023232042.f9373f9f826ceae2a4f4da35@linux-foundation.org>
References: <20241023232042.f9373f9f826ceae2a4f4da35@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Thu, 24 Oct 2024 14:09:54 +0800 Jim Zhao <jimzhao.ai@gmail.com> wrote:

> > > On Wed, 23 Oct 2024 18:00:32 +0800 Jim Zhao <jimzhao.ai@gmail.com> wrote:
> > 
> > > > With the strictlimit flag, wb_thresh acts as a hard limit in
> > > > balance_dirty_pages() and wb_position_ratio(). When device write
> > > > operations are inactive, wb_thresh can drop to 0, causing writes to
> > > > be blocked. The issue occasionally occurs in fuse fs, particularly
> > > > with network backends, the write thread is blocked frequently during
> > > > a period. To address it, this patch raises the minimum wb_thresh to a
> > > > controllable level, similar to the non-strictlimit case.
> > 
> > > Please tell us more about the userspace-visible effects of this.  It
> > > *sounds* like a serious (but occasional) problem, but that is unclear.
> > 
> > > And, very much relatedly, do you feel this fix is needed in earlier
> > > (-stable) kernels?
> > 
> > The problem exists in two scenarios:
> > 1. FUSE Write Transition from Inactive to Active
> > 
> > sometimes, active writes require several pauses to ramp up to the appropriate wb_thresh.
> > As shown in the trace below, both bdi_setpoint and task_ratelimit are 0, means wb_thresh is 0. 
> > The dd process pauses multiple times before reaching a normal state.
> > 
> > dd-1206590 [003] .... 62988.324049: balance_dirty_pages: bdi 0:51: limit=295073 setpoint=259360 dirty=454 bdi_setpoint=0 bdi_dirty=32 dirty_ratelimit=18716 task_ratelimit=0 dirtied=32 dirtied_pause=32 paused=0 pause=4 period=4 think=0 cgroup_ino=1
> > dd-1206590 [003] .... 62988.332063: balance_dirty_pages: bdi 0:51: limit=295073 setpoint=259453 dirty=454 bdi_setpoint=0 bdi_dirty=33 dirty_ratelimit=18716 task_ratelimit=0 dirtied=1 dirtied_pause=0 paused=0 pause=4 period=4 think=4 cgroup_ino=1
> > dd-1206590 [003] .... 62988.340064: balance_dirty_pages: bdi 0:51: limit=295073 setpoint=259526 dirty=454 bdi_setpoint=0 bdi_dirty=34 dirty_ratelimit=18716 task_ratelimit=0 dirtied=1 dirtied_pause=0 paused=0 pause=4 period=4 think=4 cgroup_ino=1
> > dd-1206590 [003] .... 62988.348061: balance_dirty_pages: bdi 0:51: limit=295073 setpoint=259531 dirty=489 bdi_setpoint=0 bdi_dirty=35 dirty_ratelimit=18716 task_ratelimit=0 dirtied=1 dirtied_pause=0 paused=0 pause=4 period=4 think=4 cgroup_ino=1
> > dd-1206590 [003] .... 62988.356063: balance_dirty_pages: bdi 0:51: limit=295073 setpoint=259531 dirty=490 bdi_setpoint=0 bdi_dirty=36 dirty_ratelimit=18716 task_ratelimit=0 dirtied=1 dirtied_pause=0 paused=0 pause=4 period=4 think=4 cgroup_ino=1
> > ...
> > 
> > 2. FUSE with Unstable Network Backends and Occasional Writes
> > Not easy to reproduce, but when it occurs in this scenario, 
> > it causes the write thread to experience more pauses and longer durations.

> Thanks, but it's still unclear how this impacts our users.  How lenghty
> are these pauses?

The length is related to device writeback bandwidth.
Under normal bandwidth, each pause may last around 4ms in several times as shown in the trace above(5 times).
In extreme cases, fuse with unstable network backends,
if pauses occur frequently and bandwidth is low, each pause can exceed 10ms, the total duration of pauses can accumulate to second.


Thnaks,
Jim Zhao

