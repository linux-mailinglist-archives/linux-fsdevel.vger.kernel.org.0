Return-Path: <linux-fsdevel+bounces-19851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEFC8CA587
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 03:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995E428180C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 01:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95D5FC19;
	Tue, 21 May 2024 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deltaq.org header.i=@deltaq.org header.b="X2/o5gqq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCAA7F
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 01:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716253438; cv=none; b=AkhpHW9wdfKFuHxLGvHKIhXWo6MohiTC3KdnxTOxt9jJxoYHTmnfoeZoXmGS/lRWDRUtVhOEBzRT/Gj/0PYzZ10DokC/t1JP3IACYkHxAqQkb+wjC1a5xug8WLnL9vSO4vQtBzidYWyuWa3/rBmuBKF1S1Q3wN25mK0Ykrwx/j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716253438; c=relaxed/simple;
	bh=RkrkIyVA+Ctiw8S5fO2yzgsB2XirORKA4REdVGifxSg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ND7QUS3XucZBroSIggnGs4g3NpTwj3MM7mEDOuCAfQXN4gQcHD4SVm9YjSqClhOLw3JgB4SLkeHiuOL51zbwPDtbCAQJQ0FHtW1bSVZEcnnM0dd5efgLyrhq/DcgIkRDzwt1Xtv5LV9miFR5620CSOAEnHnzXmLY5lglDK+far8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deltaq.org; spf=pass smtp.mailfrom=deltaq.org; dkim=pass (1024-bit key) header.d=deltaq.org header.i=@deltaq.org header.b=X2/o5gqq; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deltaq.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltaq.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59ad344f7dso631763166b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 18:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deltaq.org; s=deltaq; t=1716253434; x=1716858234; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RkrkIyVA+Ctiw8S5fO2yzgsB2XirORKA4REdVGifxSg=;
        b=X2/o5gqqVH8Kt9dJxdLkLbkEVJzFH1EINp9CLUY7dR4gfWkxEMYVpwhhdCRCZ+HULe
         sZbaJHnbFlTWEAJoHAdJop0y3xgtso+88oBpMHB6/f/YzQlKfnF8vuS70spS1wQXZPtC
         9UjMV/gfN7riGKMZlBPV7fhly+T16/epw82jI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716253434; x=1716858234;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RkrkIyVA+Ctiw8S5fO2yzgsB2XirORKA4REdVGifxSg=;
        b=jTJSdCzhDAkxL44ZcSDeAAL7hWzjtw3AmWP5GefP5mmZCSilcPQkJjVR8CSTQ+qPr1
         rXf/q8R+Zh7R5dLs4qkNxQG4km12uD3t32i37i5+2XhaYG3mcMv3KZWh8G/f2CQgndX3
         DMlJ5l+DPUeSyGdTYLEoLUcr8HXXJPxBGSju9fzincjJz+Zb9uAN3jpvzIBf5yrjqMoG
         +dYfcYpyBNQpVL6cz4brSOee6j5jcoobTG923QKfLDWZqcc4jTlK8/jSgcXjLkWr0U4c
         lfVXSlIsgD6TZRPApvfQ+tQsczyGLOvCS7BluVqH6aiUaXS5atG0pjQJixrvLJCdorHF
         JmVA==
X-Gm-Message-State: AOJu0YynBB7G8OsFh31tCO+/i6402XI6kgC3yTx7PMfJYxAA7IMtAgXF
	4vSaYn5rrQQu32XJlnCoRm0/2rsInlB3pXqUHdRw62RTse8VIZBw/t4p9cJ2EHiEriHMkG6S3g5
	WUr96+ybzUfZT9I8RArtkTiwgRe9CwZt+SzeLfwSpOdr4+c5L1ooRNA==
X-Google-Smtp-Source: AGHT+IHV/07oFuJ/ajrFGVYGbjPZdbVyKc/Fce2DxkmyWnjHkblbJHeKOEHgZJxUCHxubzmPiYNe7m02xwHhZT2RJE8=
X-Received: by 2002:a17:907:2722:b0:a5c:e2ea:ba59 with SMTP id
 a640c23a62f3a-a5ce2eabb18mr770666866b.29.1716253434577; Mon, 20 May 2024
 18:03:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jonathan Gilbert <logic@deltaq.org>
Date: Mon, 20 May 2024 20:03:38 -0500
Message-ID: <CAPSOpYs6Axo03bKGP1=zaJ9+f=boHvpmYj2GmQL1M3wUQnkyPw@mail.gmail.com>
Subject: fanotify and files being moved or deleted
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello :-)

I want to use fanotify to construct a best-effort log of changes to
the filesystem over time. It would be super useful if events like
FAN_MOVE_SELF and FAN_DELETE_SELF could report the path that the file
_was_ at just prior to the event. Reporting an FID value is of limited
use, because even if it still exists, looking up the name (e.g. by
open_by_handle_at, the way fatrace does) will only reveal the new name
after a FAN_MOVE_SELF -- and after a FAN_DELETE_SELF, the file no
longer has any path!

I understand that in terms of a strictly accurate reconstruction of
changes over time, fanotify events are of limited use, because they
aren't guaranteed to be ordered and from what I have read it seems it
is possible for some changes to "slip through" from time to time. But,
this is not a problem for my use case.

I have no idea what things are available where in the kernel code that
generates these events, but in the course of writing the code that
reads the event data that gets sent to an fanotify fd, I was thinking
that the simplest way to achieve this would be for FAN_MOVE_SELF and
FAN_DELETE_SELF events to have associated info structures with paths
in them. FAN_DELETE_SELF could provide an info structure with the path
that just got unlinked, and FAN_MOVE_SELF could provide two info
structures, one for the old path and one for the new.

Of course, it is possible that this information isn't currently
available at the spot where the events are being generated!

But, this would be immensely useful to my use case. Any possibility?

Thanks,

Jonathan Gilbert

