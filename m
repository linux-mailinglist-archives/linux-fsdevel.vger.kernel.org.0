Return-Path: <linux-fsdevel+bounces-32910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 348469B09A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 18:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0711B284364
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 16:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47E9186298;
	Fri, 25 Oct 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qf/a52J9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544387082B;
	Fri, 25 Oct 2024 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873161; cv=none; b=Wo1QwpYmhx1FTuvgbMe4jha/xEmZZYtSXAG+rDizwyCiPxmW24ExDpvJ4GHacW1zI0fDM0LH63q+uKl8WqdDeCCpZxNpC2DMSU/YSyyuERYP9rWkljGjppdkZq1sA+ojdZGSozi0hkdmLqltMnGkmahJ+VqIPKHM4hve3sg+AYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873161; c=relaxed/simple;
	bh=k0r3WOrb2CXmy30/tV6kcdOv8W3nxY/6aW3AFGdzRrA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jbI3oereOt1yYvWBPABQR4fnWNgx9fmNesenOWm7LmeHGMH5m/6461cPT3VzgqtYOajevovI/5ylZTW4U7XYXnn3YRBXPtY8IP2DYLNvR9JUYJnxr0juLEwrkF0GVtreEqXF7vEV+4jYNKGiQga+Y8BwgpwM2dJ1yPhtgLMUd5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qf/a52J9; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e5ef7527deso25949847b3.0;
        Fri, 25 Oct 2024 09:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729873158; x=1730477958; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vxUXE1ju1lVW9j8FPLrrWfH8+vzsmqWln+XfSxRyQ8M=;
        b=Qf/a52J9io6SIedxnWaM/vnN02lZb9jvzKpOCVpi+mbS5nwEFi5nRiLD2YY96vTH4S
         43xIfWFGf4e3qexHAWMzanxxrpJ7sC8AGiGZPwP77fsxNwl1ta+JTy9Dv+vtXGpuleCy
         z3ny/GGHlGANHx0LOMr5Eg1u7bompZzCDieOJMxbWhBNAo1J9KqCf3TbwkCb1sRYMFJl
         TSaGN3ZFoSFQNFkRvclqa6VEUks5zR+yF5kDgjMC6XazAhuEePAVNqToxp8X5ZL6S7uS
         uJscVgwMFfgOw7eAKxyEeJq41XzL7Oa1KwTiBBqWz8nODjCkqcqCDJ6RYThNE+vTqU1C
         xfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729873158; x=1730477958;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vxUXE1ju1lVW9j8FPLrrWfH8+vzsmqWln+XfSxRyQ8M=;
        b=dhB3Fpw85tgM7LbXVn4lPEFJ+qUsWlUQiCotmuWJnqv9HtcNT/tv+fgWTyVUtEwSlD
         TwIoJzNm+PkcatGGTKi2VbMfSIOODYkvt6Cls3y4mKLGvgAuL5m4E3+Hwm1EA7ogXklQ
         6jPAEC84wOHyGDV1U1mzu2FfN3VzTLKkhMbffv9JI4gWmiTQ1Alw8obCfNwD/1k/UJTE
         RY99AX5oSmyWd6vr6DLhS6XNkZeL/Q3xf4SR2PzzvEZfdAh7SimcfX1l4KywKUm1rd6q
         qQ/fO7rzZ1RLo95VxVXojjJgqv8/exry0mD/xhY22E2K7jdi28GvxAQus9cDtaja3mQe
         mQSg==
X-Forwarded-Encrypted: i=1; AJvYcCWydp9Gf9xE7hSk/71RmXaEXp2pRfNJ54SqIaWhkLHTMc8eUKNkDzRo6XbiVtZ3gzuMhSkJeAGQjLVV6ESf@vger.kernel.org
X-Gm-Message-State: AOJu0YxSbBOq9I2AGliyqZ1Y7cGAb75V315Ikdmkur7nnmwRjHgK8Q3Z
	bqefVXzIrYKxOaBj0jBA0HEGTbYVySknOnN0JuKK8kApTFREp3TIGuVN8xXdij9Xl6o4+zhIRWh
	V9lxGWvAbdrqP/u6grqTg92WvN4Lk0R6BvRk=
X-Google-Smtp-Source: AGHT+IHUpz9ZwAfXIOasMpVe4eRYejrDsMrmUdXt/yfsYIVGqbQ+JiZAnKZq+qLhFP6qSO+n+5bWerJXKYQntsaVHQQ=
X-Received: by 2002:a05:690c:660a:b0:6e5:e571:108b with SMTP id
 00721157ae682-6e9d88d0944mr1182027b3.8.1729873158313; Fri, 25 Oct 2024
 09:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Guan Xin <guanx.bac@gmail.com>
Date: Sat, 26 Oct 2024 00:18:42 +0800
Message-ID: <CANeMGR6CBxC8HtqbGamgpLGM+M1Ndng_WJ-RxFXXJnc9O3cVwQ@mail.gmail.com>
Subject: Calculate VIRTQUEUE_NUM in "net/9p/trans_virtio.c" from stack size
To: v9fs@lists.linux.dev
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Eric Van Hensbergen <ericvh@kernel.org>
Content-Type: text/plain; charset="UTF-8"

For HPC applications the hard-coded VIRTQUEUE_NUM of 128 seems to
limit the throughput of guest systems accessing cluster filesystems
mounted on the host.

Just increase VIRTQUEUE_NUM for kernels with a
larger stack.

Author: GUAN Xin <guanx.bac@gmail.com>
Signed-off-by: GUAN Xin <guanx.bac@gmail.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: v9fs@lists.linux.dev
cc: netdev@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org

--- net/9p/trans_virtio.c.orig  2024-10-25 10:25:09.390922517 +0800
+++ net/9p/trans_virtio.c       2024-10-25 16:48:40.451680192 +0800
@@ -31,11 +31,12 @@
#include <net/9p/transport.h>
#include <linux/scatterlist.h>
#include <linux/swap.h>
+#include <linux/thread_info.h>
#include <linux/virtio.h>
#include <linux/virtio_9p.h>
#include "trans_common.h"

-#define VIRTQUEUE_NUM  128
+#define VIRTQUEUE_NUM  (1 << (THREAD_SIZE_ORDER + PAGE_SHIFT - 6))

/* a single mutex to manage channel initialization and attachment */
static DEFINE_MUTEX(virtio_9p_lock);

