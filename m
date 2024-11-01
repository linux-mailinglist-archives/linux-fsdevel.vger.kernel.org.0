Return-Path: <linux-fsdevel+bounces-33442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5869B8BF1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 08:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B13281E45
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 07:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C74C1531C2;
	Fri,  1 Nov 2024 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fICwDs9S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9D24E1CA;
	Fri,  1 Nov 2024 07:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730445441; cv=none; b=CcIM5JcdFPSMgVcwiYXr04mnE46REErPpQ3xd6xAv8rDRYM9gipnAVYMr6vLv5bW7j3upOE/9pasN3HujHv1Mr+1STZv5E+DEvzfTPb0n3InNKRns0EijzuWk11DNRobB8E9tzmSRWdjcU3TGuIWEfrdDVTt54sYrbgVbi7UdvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730445441; c=relaxed/simple;
	bh=R87Oj6EwN9I1UmpVHQXJ6UwyrWlYwJB6czR7sLZDWLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQucR+apUSUhHQM8rpV7ScqwgOfNikfg4uO31Sxe3ydj+ARLC2xTXMsMrNDfGSC5OxWD6jVWV6DeVcDY5ZZXG9B9QYj/XHRmxUd3Z1Hi11HufPY6YLTxMtl/kFPO3GRCPzCHMAOAToV7QMVI1JEpvqDE2Iv4YBLDS+TXw9Vk8a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fICwDs9S; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-720aa3dbda5so1249883b3a.1;
        Fri, 01 Nov 2024 00:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730445437; x=1731050237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zePBKOg1NOjIX6qGBpn66Tx/Y9R4RC4MGQIIOmHAXU=;
        b=fICwDs9SQCMCx+QJ+FXijaaYjv1pWWt9hZS8Xn25Z19PUs+Q8R0qanaDIZBcmrJ348
         9iPVfUf35GpiluWmfNpeNIJ+HtE3fCy6G/YKGk+GfY/cRQjkhSPkTlm5r4SywD1S1PGt
         l0lq0qqjpbKNaM2woLr677Fe2xB7nmK+HYNZiVIwmSMxKbftP7wePRMeoyNE0Mqo9mIN
         k6y97Z8x7kt9cXFIuHnJ49b33/S0z0i3q41WrrafpkZMUPDfluEZu3gJ+dvxqnLL9V8d
         ygnFWznGLku+k/M2jM4VEI23hVD3xlhShhdF2i+rtbNcGhMkqv5JtEDOGR8PO+E+J2e5
         KHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730445437; x=1731050237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zePBKOg1NOjIX6qGBpn66Tx/Y9R4RC4MGQIIOmHAXU=;
        b=WDgzGtlr51Bj1uFPqrALqvax7LCDzmPLgiPJjLWZmMhxQHzBiS9/bdMge6h/ERvXDh
         V/RDxqhITtTSLeheBu9zhSxHu434xQrzAu8an+m63oLTqSFqdVZQLKJPJB2NxAHdI4gs
         fYtw0ms+rGirj0nyHkGO/WFNboDyzGBQ4v1bACDW/7mtNypjPjQSkaUt4UM6PbYz1RXE
         jQDraIIBr42CkTzIqWyZ+0XWYeK1HuRDXt/NtatKgjo6TFS93bQksu/WFbXERH+4zhrh
         7x6PGe6sAEq6uMYHpeWq0o29v6pekMaJg5s7ae6jDsZgNYtH0YfJS2+ggh5oEqdIeZ1j
         b8SA==
X-Forwarded-Encrypted: i=1; AJvYcCU3ieICrJ5+qY9nq60dfnIjWjMwaAsWs1s9wcvXQiZdWGQUtJIsrIqNKYclvp/nAfPJKLGR16mM0rk+dOz+@vger.kernel.org, AJvYcCXSm/TgXgcMlr9AxVK7giRhwFct7T49PCCbAqAsZHFFHcMJNXRp4+6EKbDXRFAblY1YDUWw1ddDJa/hGi9v@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1v4+Ja4doYaGuhSbyMtDDnMLFTYEP8Z4iBo8U7601rWab06d7
	dPWhjISgTcCbS7CmFlbBtxXhvg/6GijbG8+NMS5Lg4Q+BKskELzf
X-Google-Smtp-Source: AGHT+IGbmekDEKQHy5m+gSdvzXWtzFsxIOVGg3WesPOFxjOBIk0/TiwjMbUOR8Zt+gDbBd6mHoSliw==
X-Received: by 2002:a05:6a00:b93:b0:71e:589a:7e3e with SMTP id d2e1a72fcca58-720ab39e77fmr12493848b3a.3.1730445437354;
        Fri, 01 Nov 2024 00:17:17 -0700 (PDT)
Received: from localhost.localdomain ([43.154.34.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1ba244sm2228025b3a.19.2024.11.01.00.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 00:17:17 -0700 (PDT)
From: Jim Zhao <jimzhao.ai@gmail.com>
To: akpm@linux-foundation.org
Cc: jimzhao.ai@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org
Subject: Re: [PATCH] mm/page-writeback: Raise wb_thresh to prevent write blocking with strictlimit
Date: Fri,  1 Nov 2024 15:17:13 +0800
Message-Id: <20241101071713.4085752-1-jimzhao.ai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241025170222.0ced663e778935946ea1c9fa@linux-foundation.org>
References: <20241025170222.0ced663e778935946ea1c9fa@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> On Thu, 24 Oct 2024 15:29:19 +0800 Jim Zhao <jimzhao.ai@gmail.com> wrote:
> 
> > > > 2. FUSE with Unstable Network Backends and Occasional Writes
> > > > Not easy to reproduce, but when it occurs in this scenario, 
> > > > it causes the write thread to experience more pauses and longer durations.
> > 
> > > Thanks, but it's still unclear how this impacts our users.  How lenghty
> > > are these pauses?
> > 
> > The length is related to device writeback bandwidth.
> > Under normal bandwidth, each pause may last around 4ms in several times as shown in the trace above(5 times).
> > In extreme cases, fuse with unstable network backends,
> > if pauses occur frequently and bandwidth is low, each pause can exceed 10ms, the total duration of pauses can accumulate to second.
> 
> Thanks.  I'll assume that the userspace impact isn't serious to warrant
> a backport into -stable kernel.
> 
> If you disagree with this, please let me know and send along additional
> changelog text which helps others understand why we think our users
> will significantly benefit from this change.

It’s acceptable not to backport this to earlier kernels. 
After additional testing,  under normal conditions, the impact on userspace is limited, with blocking times generally in the millisecond range.
However, I recommend including this patch in the next kernel version. 
In cases of low writeback bandwidth and high writeback delay, blocking times can significantly increase. 
This patch helps eliminate unnecessary blocks in those scenarios.
Thanks.

