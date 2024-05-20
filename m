Return-Path: <linux-fsdevel+bounces-19818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EFC8C9F5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 17:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01AB81F21BFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 15:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A76136E18;
	Mon, 20 May 2024 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BF/4T0Rx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9674F28E7;
	Mon, 20 May 2024 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716217789; cv=none; b=CfszjD/bn76U3tEEEOiB3OH+DYzhYJ78EIrx5jgUCvR2oJlOH1nyCSDrzqW2NZfGJuFLaam5r1prK+9AyhkyF5Z70oyvDDXYyQUuDeROYMn5K6rZ90ZG+tKI4cMmN8D3kUqHx3osa3ICH+skdhxf3G1kDhgcrIwqJ8w5W2kC378=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716217789; c=relaxed/simple;
	bh=3ZPzTccGxeYiZ3UCRWcRKYqjZ6SNEtUDp0r4ooVJnSg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZsVZc2ZpJaFhP4PacuARu9hcRRxLanUvGRljdFdrzdmxS9ADpIDZFotdB0scT/d+TA+3r/WFTPbcWHPnQca3m77M2DLtOEjsa8SzW2iND9eDtHQeXqdoo4vYRdcdYO6+MFomQKDQeJBlIYQPBmMswI3763ge7+skP6ywyI8sTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BF/4T0Rx; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-23d1c4c14ceso1440709fac.0;
        Mon, 20 May 2024 08:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716217788; x=1716822588; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ZPzTccGxeYiZ3UCRWcRKYqjZ6SNEtUDp0r4ooVJnSg=;
        b=BF/4T0Rxls8Bhm4YqXf6pHPnHuaLO3lm2MWs/ZDcelKiAy7gRpA324g8DU4sGfGQqy
         nwPTcNIPfSn80Op0vCPXywUF4PeJjPx4muTfMQ7AHmHLYuBB3A6pMG+xS+k0nla5oqSk
         nj8gkSWCHudBPPus5Mr7RWNRPktzIqUHZHZCVoTb2t9QVczU0+eE4xAw59Gh9/9X/UHS
         OWxa90j6dE2L71iJ6il8Q6vGIdNYTgTCwLMM2KGo05IuV5sheW6QEEzSTikrp2IbKjc/
         TEuQgi5Y1f37NQLKKzQidHmCy6yqT+niBUb/zxD8ZDieZGsP1K/QCOB34eeFQC4i6SK/
         OLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716217788; x=1716822588;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZPzTccGxeYiZ3UCRWcRKYqjZ6SNEtUDp0r4ooVJnSg=;
        b=nRh4M+Rvab291VayoHkIO5ACZtzYMCpT6nemD+xzBVF/Z0DK0HaxoxZJqoglGGijF+
         JeAQmDLHeWC8y5UoWOaKzq8VlJ9ZFkZxBchr2UrAnnFSR40wypjE3J70LNeq+RgSvzaf
         9sjEVJGHHxCzC1XmWqCpZiYTHjYv2sYSvC+oe+MH/ZeDe4HldcNJWHE13cCcAcUuQ2xK
         0DlZzA6wGCkJAzex+xdKmDSWyN3fac9pheHpgZFXZNCQYnOXHsRMZZ/RJOYLdwlgd1DC
         VGy7ATdTP/nB6E72PGrl48OS8FrOdcnXbGewBuGNJwFKOf3M33n65AIS0NdWjV7FOT5I
         Zffw==
X-Forwarded-Encrypted: i=1; AJvYcCVB8GCUDSaplHHU0dcDzHvduewx7ORZkgyTgvUlpvd570lV7cZ7RbE4cafj/M/tX7gFoQXdI+UFegf7qWVSyd6hTOlo8Z1avhIqDf3Yd+6MYQKKsYc8cCNC+ONNhZ2cp1aoMumwl5hLH5++BwL/IFQMucBsXg+KbKNR+R+BhUSMhcqpUiP7tINgp5AdaQ==
X-Gm-Message-State: AOJu0YxO9fU0XqXdgc0gD5hRi8f3/S2re3DeXzke7oOmuE5q9ja3f3d3
	GPZ7q7iSmoMBTxH8RyFokWaLDGtlFsOlXSrAPa1JqyjvS4yJKlXD
X-Google-Smtp-Source: AGHT+IEEwTNwDG/5OWJKkrOQ+QtpD76b+5Ie4/DQJOETwsN4jDmj2Z5/18baOTuuE1EhEH6prG8TgQ==
X-Received: by 2002:a05:6870:5246:b0:23b:b0fd:47f4 with SMTP id 586e51a60fabf-24172a8b902mr33765767fac.18.1716217787405;
        Mon, 20 May 2024 08:09:47 -0700 (PDT)
Received: from arch (recod-gw.ic.unicamp.br. [143.106.7.151])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4df85902f10sm2923274e0c.54.2024.05.20.08.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 08:09:46 -0700 (PDT)
Date: Mon, 20 May 2024 12:09:43 -0300
From: Artur A C de Barros <arturacb@gmail.com>
To: willy@infradead.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: First Contributions for KUnit
Message-ID: <Zktnt7rjKryTh9-N@arch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

We are students from the State University of Campinas with an interest in contributing to the kernel. We are part of LKCAMP, a student group that focuses on researching and contributing to open source software. Our group has organized kernel hackathons in the past [1] that resulted in sucessful contributions, and we would like to continue the effort this year.

This time, we were thinking about writing KUnit tests for data structures in `lib/` (or converting existing lib test code), similarly to our previous hackathon. We are currently considering a few candidates:

- lib/kfifo.c
- lib/llist.c
- tools/testing/scatterlist
- tools/testing/radix-tree

We would like to know if these are good candidates, and also ask for suggestions of other code that could benefit from having KUnit tests.

Thanks!
Artur Alves

[1] https://lore.kernel.org/dri-devel/20211011152333.gm5jkaog6b6nbv5w@notapiano/

