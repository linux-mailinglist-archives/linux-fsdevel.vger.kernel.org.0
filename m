Return-Path: <linux-fsdevel+bounces-21034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CF98FC99E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 13:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9011C233B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 11:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D741922F7;
	Wed,  5 Jun 2024 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="RC9U54tb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979421373
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jun 2024 11:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585369; cv=none; b=pmEBy9LvEJ2BcTerd9VjLBYgqeT647HjgLkl5iweasNu2InwHO0eOw0vLoxz02c75iTh0ruj5Rmgj1fnwXKzAHe83Sd9kKiSeHfpc4r3LUX6V13mp+P7EVs+Nk/kcQzDg8LpxlOJgtOTa5U9g357UoKvN6x54mtgyFSQDSMlbx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585369; c=relaxed/simple;
	bh=7FgkUmzW4vq4WuhnkXWvITbhdqSRYHVlZ8igKZumwzk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UpcHNRitVpAjOeu2Qnb61y/MuoHFiobZN0g3sQGLvhTtU86XGzSR2dDnkFpZsd1s4w6BvOu4yAPovYNWMSQtEGIec7EszeU0bc7x9a7Hd8gnUvYcDUwvKxJY0WHcuXaQif4qOIZ+6ibs3qDKI9Wph4VUMTweOCM8IIG8bdqbdY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=RC9U54tb; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52961b77655so2286314e87.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jun 2024 04:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1717585366; x=1718190166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cEYhMckwB2/P4xzPW88npOsZyYkpk9RU9J5XlEXZ8BE=;
        b=RC9U54tb5Nd5PPrdWHPA6yNhk8ZJC0rAdL8c2Am/MjcAy73MwJOqNK4gajlwI7YG4H
         H9ZbQa63Mxs0OofE5sK94hG9uTEngRsZo75fT1EDjGX6Pl84KmcvM1+WrlXLNM7Ydxic
         CmA1OlQnFfiPkSrcL/nwXZqwh405yNj4G2DtZVLPvp53UIEfNxhXj8i+Jmta6xou5NVj
         /qUXCyFNJ9yhwIwJP9oSy0Py4MTLUMrBhEFCp9f9DoAnJW5959YdVZSwTohU3B04ydeM
         /V3aQ9RSWYjnyK86uUmD8gorVwD8eVKpaWWpytjKFAgpG97ihxfIYrD+DoZrY8SorHoX
         RaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717585366; x=1718190166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEYhMckwB2/P4xzPW88npOsZyYkpk9RU9J5XlEXZ8BE=;
        b=IVFmx0L17FyjxDgDeAVBa63N7a8X1JnS85asDjcnaSpuFsRdbLJuQBbMrmnc9wspgR
         /W/pQVxb8yAs1VvmESVNA6qSBJJh8rzJAIzuUF0VIPpm0vsMs4MRYqcwQxEKK+AFEy82
         sniRvbGci9fm6GJUtz36LNpn0dcEZPQX3fHe3KHCPyHMIiDt+s+t3HPGu5ajFPFVT8GG
         d5SMXkhqhX1mO25h9pbxvSmU+NOAdvfF3YMlRy+BO35vvYbQa8qYwadyowScHDoilM46
         63MN/ac96xS4v9VXlsoNLJBRVFuCLYx4S62tti2liHQ5sMZnkaqmwX6tyS+8/RqTSJT8
         ByJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGr7vj2yVNvfhvnnJrVvfQpI8u57ZevqAD4txkLYIRFfb6waQTbJ3b5UYnGdWlCCQuTg9d27dEf8Kh13q2pAw1tYg93yTFok9cCGN3EQ==
X-Gm-Message-State: AOJu0Yz8SLhGDRymRfz3kRgAa7nTGsErbp39RogHQnwqqUxVmQsqzvzo
	LDOsYYrkXpRfynx4QFlayFcBfSc2ZCVEn8f80un7TfVb8SjVpTdFRV7CNWteSg0=
X-Google-Smtp-Source: AGHT+IFTiG3JX/p/DawD0Ae2OAwaEN0LLyKy41m3I3xduQ2hQnmGquYk6KqGSPjPVeNVFNBYMBPhsA==
X-Received: by 2002:a05:6512:10d2:b0:51e:11d5:bca5 with SMTP id 2adb3069b0e04-52bab502b5cmr1623187e87.54.1717585365502;
        Wed, 05 Jun 2024 04:02:45 -0700 (PDT)
Received: from ssdfs-test-0070.sigma.sbrf.ru ([84.252.147.254])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d7ff10sm1762868e87.210.2024.06.05.04.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 04:02:44 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: slava@dubeiko.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC] ML infrastructure in Linux kernel
Date: Wed,  5 Jun 2024 14:02:19 +0300
Message-Id: <20240605110219.7356-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

I would like to initiate a discussion related to an unified
infrastructure for ML workloads and user-space drivers.

[PROBLEM STATEMENT]

Last several years have revealed two important trends:
(1) moving kernel-space functionality into user-space drivers
(for example, SPDK, DPDK, ublk); (2) significant number of efforts
of using ML models for various real life applications (for example,
tuning kernel parameters, storage device failure prediction, fail
slow drive detection, and so on). Both trends represent significant
importance for the evolution of the Linux kernel. From one point of view,
user-space drivers represent the way of decreasing the latency and
improving the performance of operations. However, from another point of
view, the approach of bypassing the Linux kernel introduces security and
efficiency risks, potential synchronization issues of user-space threads,
and breaking the Linux kernel architecture’s paradigm. Generally speaking,
direct implementation of ML approaches in Linux kernel-space is very hard,
inefficient, and problematic because of practical unavailability of
floating point operations in the Linux kernel, and the computational power
hungry nature of ML algorithms (especially, during training phase).
It is possible to state that Linux kernel needs to introduce and to unify
an infrastructure as for ML approaches as for user-space drivers.

[WHY DO WE NEED ML in LINUX KERNEL?]

Do we really need a ML infrastructure in the Linux kernel? First of all,
it is really easy to imagine a lot of down to earth applications of ML
algorithms for automation of routine operations during working with
Linux kernel. Moreover, potentially, the ML subsystem could be used for
automated research and statistics gathering on the whole fleet of running
Linux kernels. Also, the ML subsystem is capable of writing documentation,
tuning kernel parameters on the fly, kernel recompilation, and even automated
reporting about bugs and crashes. Generally speaking, the ML subsystem
potentially can extend the Linux kernel capabilities. The main question is how?

[POTENTIAL INFRASTRUCTURE VISION]

Technically speaking , both cases (user-space driver and ML subsystem)
require a user-space functionality that can be considered as user-space
extension of Linux kernel functionality. Such approach is similar to microkernel
architecture by the minimal functionality on kernel side and the main
functionality on user-space side with the mandatory minimization
the number of context switches between kernel-space and user-space.
The key responsibility of kernel-side agent (or subsystem) is the accounting
of user-space extensions, synchronization of their access to shared resources
or metadata on kernel side, statistics gathering and sharing it through
the sysfs or specialized log file (likewise to syslog).

For example, such specialized log file(s) can be used by ML user-space
extensions for executing the ML algorithms with the goal of analyzing data
and available statistics. Generally speaking, the main ML logic can be executed
by extension(s) on the user-space side. This ML logic can elaborate
some “recommendations”, for example, that can  be shared with an ML agent
on the kernel side. As a result, the kernel-space ML agent can check
the shared “recommendations” and to apply the valid “recommendations”
by means of Linux kernel tuning, recompilation, “hot” restart and so on.
Technically speaking, the user-space driver requires pretty much the same
architecture as the simple kernel-space agent/subsystem and user-space
extension(s). The main functionality is on the user-space side and
kernel-space side delivers only accounting the user-space extensions,
allocating necessary resources, synchronizing access to shared resources,
and gathering statistics.

Generally speaking, such an approach implies the necessity of
registering a specialized driver class that could represent
an ML agent or user-space driver on kernel side. Then, it will be possible
to use a modprobe-like model to create an instance of ML agent or
user-space driver. Finally, we will have the kernel-space agent
that is connected to the user-space extension. The key point here is that
the user-space extension can directly communicate with a hardware device,
but the kernel-space side can account for the activity of the user-space
extension and allocates resources. It is possible to suggest an unified
architecture of the kernel-side agent that will be specialized by
the logic of user-space extension. But the logic of the kernel-space
agent should be minimal, simple, and unified as much as possible.
Technically speaking, the logic of kernel-space agent can be defined by
the eBPF program and eBPF arena (or shared memory between kernel-space
and user-space) can be used for interaction between the kernel-space
agent and the user-space extension. And such interaction could be implemented
through submission and completion queues, for example.

As a summary, described architecture is capable of implementing
ML infrastructure in Linux kernel and unification of user-space drivers
architecture.

Any opinion on this? How feasible could be such vision?

Thanks,
Slava.

