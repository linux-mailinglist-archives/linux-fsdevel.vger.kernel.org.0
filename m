Return-Path: <linux-fsdevel+bounces-14404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3C087C035
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 16:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF8D228153C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 15:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C2571B39;
	Thu, 14 Mar 2024 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYVIS3Iz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4B851C3B
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430244; cv=none; b=j8J8YH6qMIAMsgxuZo7FzxESxDL/9GD/SldGCu+v7RbqQZnoZoiIMM+1H2kvGeYKr1SLbh9hmRDGNrC3yZHzZ1DKYj5rRphef2ETU3Ul/PWjD0Le3ghHKTa0I5SwWeNh88ES24KAtkJbGXWpml4ad2/JNER5u5QGj3/bxAdOsSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430244; c=relaxed/simple;
	bh=BiwkqsglGlHU+YDC6noTv64AqIcgdPhzbNn250fCqGk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NvdBdUXyGCqdzstUTVGV5GPDOH5Nuge007D12quzH12WRYS0goDUwiyksEmZ90d9X/A8gr/ovi4G6xfqHSupU4m46jknTVJaE6Ga670mpttnqdJjLEEMqeocsMM20ThukmU15GmoZEaI1HpLuzPTsI/Qfk+xTb9kJ/77Vkd8upQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYVIS3Iz; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so867407276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 08:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710430242; x=1711035042; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BiwkqsglGlHU+YDC6noTv64AqIcgdPhzbNn250fCqGk=;
        b=jYVIS3IzE/gxyADiCX7siHLs7WkdIpfgZSgPuAliFgNx8cWHNY9fH7wXphWA/q6sOQ
         1s6RPplMiBpj4GcRV6inFglGWVajDP1CTVpEspkDiayLoN2jQ8fhGyWgDC1QtwPqDBy6
         wZbH3n4s3Su7VPLTtaiFym/O5l2gUClaC47dcWA1Sx8sU0RUcBXOCiPGCWFzlxrLrbWs
         zMV1p/PgTNEbToW8wOTQYDiryS9eWZB60/hiwDazeYgVaYoe5cLmJsC3/00pRs2H+Wm4
         LNh45xxU8pTgentwMPDbm5yMg+b1tar5ftAKKDsSjd5XDQ8w4AgBDeWo8sfb9q4tjchu
         f00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710430242; x=1711035042;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BiwkqsglGlHU+YDC6noTv64AqIcgdPhzbNn250fCqGk=;
        b=YxXoQEZWJdY660olV9+EX3FEnhM3Xgx6W6kT6XhsAEfJPPDn9Lc4xyanISThebUX+P
         JUeRoBZf1RllUvLgTnO7KyxmI0FULAPo0M3KfU0ofz0wJLBbdGBG3IP6jmlyTEdJc6lI
         IBetnqytDKPJOIsynKaSyfezTrMEpwAcdoSj01UM1YPU0dYRKUnVsObJEvLtQvLJv6XH
         A8rKUsk4rJgjDQNh9KcCWMusVLnjRsGNMr5zGis4o87okhGPQpVOxyZrKUEoN8guDCpW
         1KvTwG6HqMdj8NN5mCkKNGbb+1lvW62wvbuR64MKSL0ClQQncOejlu6iLa87QJOg+Vr7
         vOeQ==
X-Gm-Message-State: AOJu0Yzig77910kNluAHizkVgrkuCDjGmK0J7WFdh9eE0kHeEZKF6/bV
	SOCOzBdcsK6nsqHzfGJyLwAEkfnTGUbZTC076h+5UPAKYqmGMqyiO7nMNcSR6+KE3zdoHK4oW+5
	kyULo/xCawkZs6iRo55l31J6ttSVxp6zET7iKSg==
X-Google-Smtp-Source: AGHT+IEGBGDxIkGFMfx1rSATyOu/7oC72+eoNuX9oZNygDfbgCZ24lEtWDNQvnxXaLxOcxuzls1vI8zvQAGFxhfcDrQ=
X-Received: by 2002:a05:6902:348:b0:dcc:a61b:1a72 with SMTP id
 e8-20020a056902034800b00dcca61b1a72mr2064489ybs.47.1710430240280; Thu, 14 Mar
 2024 08:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Leah Rumancik <leah.rumancik@gmail.com>
Date: Thu, 14 Mar 2024 08:30:28 -0700
Message-ID: <CACzhbgQakTF_ahv9HokgnwpW69q8M103w1kmhBBi21ZTkmRTEA@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Filesystem testing
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Last year we covered the new process for backporting to XFS. There are
still remaining pain points: establishing a baseline for new branches
is time consuming, testing resources aren't easy to come by for
everyone, and selecting appropriate patches is also time consuming. To
avoid the need to establish a baseline, I'm planning on converting to
a model in which I only run failed tests on the baseline. I test with
gce-xfstests and am hoping to automate a relaunch of failed tests.
Perhaps putting the logic to process the results and form new ./check
commands could live in fstests-dev in case it is useful for other
testing infrastructures. As far as patch selection goes, we should
consider what the end goal looks like XFS backporting. One potential
option would be to opt-in for AUTOSEL and for patches that cc stable,
and use bots to automatically check for regressions on queued up
patches - this would require a lot more automation work to be done and
would also depend on the timelines of how long patches are queued
before merged, how long the tests take to run, etc. As for testing
resources, we are still looking for employers to sponsor testing,
ideally in a way that anyone willing to contribute to stable testing
can easily gain access to resources for quick ramp-up.

