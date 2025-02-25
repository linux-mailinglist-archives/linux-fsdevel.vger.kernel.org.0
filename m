Return-Path: <linux-fsdevel+bounces-42604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDA6A44B51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 20:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5219E189E56C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 19:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FE81ACEAF;
	Tue, 25 Feb 2025 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H4hcWf0Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297D71A00FE
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740511608; cv=none; b=AnpxjFXxm5mUISaJhuRVqp844fyoaeveo02MDO1g0xdetqRGBVb4M5tb8UYeSM6b9b0xvAk1O+uOKxkndAB14ntSBz8mduEjwWL9ECEp6Je1SUE8dNwrhFxKlNLFYJlv7BOAL3UVQg97QgO/UuaVa5p71nnyJUaCIPoca7iLpcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740511608; c=relaxed/simple;
	bh=DJlfk6b3RJau9l+w6GknKKnQt/3tbE8gdqZES9yqU5o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cfw3TA820SYA5Mr/daTMZMCoqiVOvLby7lW6bBcm8LkRAMMbuL/p7DYw7rKpZ3/KtsC5jeZIpNZNea4eaCu98mTv0lS2eA/9VT0PUEcJxfBqtFYz8fNSQqnWzy3DdbEze11g6Zn6iwP/tEWKM/+f5QArGbx3com3j/lff8CUDWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--paullawrence.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H4hcWf0Q; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--paullawrence.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-7272acb753bso5721338a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 11:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740511606; x=1741116406; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DJlfk6b3RJau9l+w6GknKKnQt/3tbE8gdqZES9yqU5o=;
        b=H4hcWf0Q+oQQQ3tVXB9N28PRzDtT7eVVDRv1gHV3DZQ7xe6LumpB9/MqchQ0yASsxK
         ly0Hb9Q/SuYmBYIv/YLCE3y9p6G2QUKInZU/RiPPfDLa5f7lHrD6EidAR907TuhHOOBj
         1DuUMpna10vkjNvGgnJCfGwtkodhzlA00SgxvCpN/JJr/ePRn7LbnO1/bg3rYpLnq560
         D86JRVZcCmFBBsZ1ZUlV8Uapo9+4uegNmYLNK36Q0GO0D5ZXSPV/O0svVml6lK0ieMb9
         dZ1fhrCVp8r1VfjjFGIJInlcSD0q70rCkzu8SJShv4FrFXioXz3nV9Xhii2iqZIJMSSW
         dtmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740511606; x=1741116406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJlfk6b3RJau9l+w6GknKKnQt/3tbE8gdqZES9yqU5o=;
        b=unzzZpy2FGwOCI7Ihin7AnQLHtbcYVVyzfjyziskVga941eJihRBBekxA7Pr5zzopw
         gK1lxdQTARYSg4JkhO+SQJYYNa6iR6AJVkgVOKFhfujEOv5At1h92pOtxwNufuhRLeKj
         0QNtsPfa/VOQlGzmv4opBU8tmP5wZ0564vvPwM3EoCI+78LXCTzZQb6+j0kQvu5RxjEc
         BysKgV+0QTPbmd0TUdmLaP9OLx9Nprqu0H3hq2SGQ0xinFbd3cMhw4dlCw+O27JuCGi6
         ptcpvpiz6m55tCSfpKYAEo4wsbwUbKCOX+Ur00yrBL8FTvvZkl0UE69HP+/gRfgEDWeg
         3kUA==
X-Forwarded-Encrypted: i=1; AJvYcCVuxq5KS5O7jdwQ0V3/G4Wd/Rl9yjdm3JXMN/+TabnIp6WMckLTUsYBV2UzQNrN/XDAxyVwLwTxg1qk6xFm@vger.kernel.org
X-Gm-Message-State: AOJu0YxBlnr6ABYBoXf0z4Z8u28ILMkUnY3a0LtrqxFOBabBAYv33Nbg
	Ic6lI9jSUe+hXynqbs1oiOCfKz7DlMcNl4QPzlUPNOqAlwt+TBArwDPxiGg9zOfEVgFtuEXBO0P
	7jBm+MpmGMzJvomzq2TEX6Sl3kg==
X-Google-Smtp-Source: AGHT+IH42rZCjQxhtGaX41R/FygdO39bmt4VMVb9EHOMyqJQj1A1hd9V5S6V3ciDnhUFtYvqHYTc4Cmq0ZkSclZIm6Q=
X-Received: from oabxl3.prod.google.com ([2002:a05:6870:9f03:b0:2bc:6c19:c219])
 (user=paullawrence job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6830:2701:b0:727:26ca:bd2d with SMTP id 46e09a7af769-7274c184410mr11658399a34.3.1740511606242;
 Tue, 25 Feb 2025 11:26:46 -0800 (PST)
Date: Tue, 25 Feb 2025 11:26:44 -0800
In-Reply-To: <CAOQ4uxhxQfFfrpmRS6tOv5ANVug6d8dGx6Hsc7MYYe63sUOpcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAOQ4uxhxQfFfrpmRS6tOv5ANVug6d8dGx6Hsc7MYYe63sUOpcg@mail.gmail.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250225192644.1410948-1-paullawrence@google.com>
Subject: Re: [PATCH v19 0/4] overlayfs override_creds=off & nested get xattr fix
From: Paul Lawrence <paullawrence@google.com>
To: amir73il@gmail.com
Cc: corbet@lwn.net, dvander@google.com, ebiederm@xmission.com, 
	john.stultz@linaro.org, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	luca.boccassi@microsoft.com, miklos@szeredi.hu, paulmoore@microsoft.com, 
	rdunlap@infradead.org, salyzyn@android.com, sds@tycho.nsa.gov, 
	selinux@vger.kernel.org, vgoyal@redhat.com
Content-Type: text/plain; charset="UTF-8"

> As I wrote, this is one specific problem that I identified.
> If you propose a different behavior base on mount flag you should
> be able to argue that is cannot be exploited to circumvent security
> access policies, by peaking into cached copies of objects that the user
> has no access to, or by any other way.

> I have no idea how to implement what you want and prove that
> it is safe.
> Maybe if you explained the use case in greater details with some
> examples someone could help you reach a possible solution.

I'm going to wake up this thread one last time to lay it to rest permanently.
We have now reimplemented our use of overlayfs to no longer need these patches.
We will no longer be attempting to get this patch set accepted.

One issue - remount does not update the mounter credentials, either by default
or via a flag. I was able to work around this, but it would have been much
easier had I simply been able to remount with new credentials. (The specific
use case is that we load sepolicy from a potentially overlaid partition, so the
original mounter will always have the default kernel domain, which will not be
suitable once sepolicy is enforced.)

Is this a design decision? Would a patch to set credentials during remount be
of interest?

Thanks,
Paul

