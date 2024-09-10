Return-Path: <linux-fsdevel+bounces-29016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFE59737D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 14:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F38286961
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 12:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC7D190685;
	Tue, 10 Sep 2024 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wac0ExgR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FB71DFE8
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725972361; cv=none; b=o9IdCuc0USn8fydrMMYY/rgoNWpogo2rB6XZk2xsF77TgVllEZ95je/clc9Sq6LvW5I3NMum9lJiHwMrBbcIp3eiWl38XY687NStDQ+OT1bFIHzbQf9fvoL6g9FKyuNJtvQI0tz4KverMQbs3y4NwyIx5pBFiOJ1FKznaevwKyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725972361; c=relaxed/simple;
	bh=sQjXB6cF0d3aURfApCFHLFdHxEPzuZSHM1bWaArfz2A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WYDmwG99Evj93/sa5mSD0uMxYwANqzkc1lGD9aznbglrDQOP2pygVzkTMANwOPGcBvAGKHgYLHDhiezyc8UBqi3P/Q+KL98ZZWH79H4S2BsMLwYEm4iO4Cosj5/intN0ccC2VQZ0ZcCW/QstfDOlHODfoeYn8exU6VSFHmzMnGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wac0ExgR; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d86f71353dso3679444a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 05:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725972359; x=1726577159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dZcuOHeVwpeU+Mqt4HVdAwDmjh6VMI6oc6uTCyhYx4E=;
        b=Wac0ExgR/9jpenGES723LIV3ntZyICMegHjJcPV4uv1ylvBDzMfuni3vRwBQKufrZ2
         1ECOQsCnYIgLUusa5I9GhlzRFnMqKV7uiNqduZhaGjPymtfmDhsqerargW1R76gkHEx+
         DTaY6DFeIjzOLmePxuWnUZcMTd26xc56KmKy2Amuav+ljM5nn85CFAAQ2NLkRp4jSo5o
         FvonryUR35uU+85AoG9Jm4iRBWm6waZ0lPwtyu4zAkwxh6YpP5JSdf+0dDSlqPDlzWGQ
         /DUZQPBAcwAxMoRwlrJTxb3JMICRi/YCMo7TIWsytfYF4N7hdwVnDBx8VIFAoOBFb29t
         6Sgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725972359; x=1726577159;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dZcuOHeVwpeU+Mqt4HVdAwDmjh6VMI6oc6uTCyhYx4E=;
        b=osxPpU3fvCXWHHeEfhVItpii67ZieM4cfedBcSEo98CqIqcmp6S2nogJejY/+S2dEe
         +tdvjsU8rWRpa1WbvjDnGMo2AcRxAbIhwX18CaHaQIddYPdAwxfn4LD+k5cYncWw6GLy
         4Y3pJw6ZpQA39CUwpB4ofN/stbTZMlj4Y2L+HV+fGYDbS151CbFj8sJl0dNzo5xQuhgW
         c6XTXEeIahL1uofss4cKmPT40P2qbscNdlYywJBonFOE7o5d/N0+1Lpa18HGBefAR4T8
         cXeDz0R8Z2GYrGeePwTZksRTw1Sy1JbVqOxfXsLAyBKo6WVJ7luLWswZtcUILvRClPcs
         sXGw==
X-Gm-Message-State: AOJu0YxfM9Rq5lV1xh+2IONqm2IznDOUwkgy/W3qE8GmPpKVrztlSTGK
	Zl/21T3p2SpR81RN6/6NxkwSbMQGxHmoHznskkf6hnmk1+A3T4NlAe/wPOd0jde+0EPvcmXx4v/
	suAXvu77IHVFHPuTj32SlnFH2aOkjEtJt
X-Google-Smtp-Source: AGHT+IH4mAqJPz+MUZDBTU0HSbbQguTjI1SGiz3/7k4/MQbq1AjNezRlVERywQzWaiIwYNL3hC+7JZSO97wYsYM6GKo=
X-Received: by 2002:a17:90b:3943:b0:2d8:b075:7862 with SMTP id
 98e67ed59e1d1-2daffa3a79bmr13197763a91.5.1725972358418; Tue, 10 Sep 2024
 05:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Tue, 10 Sep 2024 14:45:47 +0200
Message-ID: <CAOw_e7bqrAkZtUcY=Q6ZSeh_bKo+jyQ=oNfuzKCJpRT=5s-Yqg@mail.gmail.com>
Subject: Interrupt on readdirplus?
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"

Hi there,

I have noticed Go-FUSE test failures of late, that seem to originate
in (changed?) kernel behavior. The problems looks like this:

12:54:13.385435 rx 20: OPENDIR n1  p330882
12:54:13.385514 tx 20:     OK, {Fh 1 }
12:54:13.385838 rx 22: READDIRPLUS n1 {Fh 1 [0 +4096)  L 0 LARGEFILE}  p330882
12:54:13.385844 rx 23: INTERRUPT n0 {ix 22}  p0
12:54:13.386114 tx 22:     OK,  4000b data "\x02\x00\x00\x00\x00\x00\x00\x00"...
12:54:13.386642 rx 24: READDIRPLUS n1 {Fh 1 [1 +4096)  L 0 LARGEFILE}  p330882
12:54:13.386849 tx 24:     95=operation not supported

As you can see, the kernel attempts to interrupt the READDIRPLUS
operation, but go-fuse ignores the interrupt and returns 25 entries.
The kernel somehow thinks that only 1 entry was consumed, and issues
the next READDIRPLUS at offset 1. If go-fuse ignores the faulty offset
and continues the listing (ie. continuing with entry 25), the test
passes.

Is this behavior of the kernel expected or a bug?

I am redoing the API for directory listing to support cacheable and
seekable directories, and in the new version, this looks like a
directory seek. If the file system does not support seekable
directories, I must return some kind of error (which is the ENOTSUP
you can see in the log above).

I started seeing this after upgrading to Fedora 40. My kernel is
6.10.7-200.fc40.x86_64

-- 
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen

