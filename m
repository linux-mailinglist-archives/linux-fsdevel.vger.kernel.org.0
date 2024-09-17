Return-Path: <linux-fsdevel+bounces-29542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B62E97AA72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 05:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC92DB20FDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 03:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E8C2B9B3;
	Tue, 17 Sep 2024 03:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ySoM0jKv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C9F1B813
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2024 03:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726542824; cv=none; b=UdbghRQ3x/ph23qqsWA4SNi/qh8nP9cG2/axsqrYqwHwyglZWIAZiTyGByl+IJi8nFeV+BhIoPOcQZmfvhxpeQ47GurH9BsXeqmy9/ZLD4UCQGKbniwM7BsZXuBvd2FhtGKUn7Cs08YrO6OG0n67g3iWH9qvkjWbxvVACGNtgJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726542824; c=relaxed/simple;
	bh=b9zp8S4L69mhHYwxO1fV2qu9zGCfQQm/bw2PUjDgyeA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aSCu9LF/VHJs+9rCWIZjJZlxDVlDcKYZkspD1lRsdfF8Knn8dKQn9yTkcL1JRHrzZTLYtycmoUqvMCfEtKt0FU4nQAFd2T/M8nl8Un96pXU0WoAyJcR7PTt897nY6zD4/1nwqGwuhcU5BWGAUqfPD8YoghqOntd/Tggk8FnP148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ySoM0jKv; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-378f90ad32dso923227f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 20:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726542821; x=1727147621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soT1UXvVA3tbPGDxrCucTw3vZu1kU7ZaHUMo+dC+6jk=;
        b=ySoM0jKvzHTPHRMm8J7FMT6GiKdKtSgZj6IZFoAIXmbRlmD5hoqv4qdYA1w7bhQ6MW
         86MbMsoePGO7lSYuv2SQ2LemdOVRQgHnYJxP13ch2FTAEZfN0rfX+vudQDH03JUzKBZA
         7VY5fni0B5WoRznRqEY3xQHyyvHpc8sxL07jaG7HyMnMJJdBTjmG7yXvdC3nPAzUBARp
         EDK7QNrr9PvYe3OgFVMRdwNeclmWHS0OeID2RjS4z3mfgw0HbGM7lsHU75l6DTbW5GQt
         4rAbwhBoZ1gj75joDMWfjuOPQkRlqiXBNBPYNHxYOqms45lF4u/KJDi1zdGr5cM8LsTf
         ITSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726542821; x=1727147621;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soT1UXvVA3tbPGDxrCucTw3vZu1kU7ZaHUMo+dC+6jk=;
        b=ZA/pH/rjg3ag+nI96+WEn180jT14t/2SUzKU+wzOWc8iMhMs/o0W2r0RPdxClk71Eo
         zv8HXewHRjw/3ckf2DyBsCMzljtSk1EfE/I4oFVEyXxdFilaa2ABn3/pq9UC8yynE4Fv
         d4rfZuUpa1zPCybTybjPDMhJ/Cz+Twizp3IvTAEE5DeXnzlnJP5pxSTsVQ2ZjE5a2JXf
         BL1VmNYgaCoNyQCZtNfYt4Qa8V19ewYsDzArxfUw53i+Zo3O0Z0F8NaN2/n4aLwjq7V3
         tl/EbwvRMYgc0Rm7hKFfUA4N8C34JCXz2IKA2+kv1MfwuOk4BdLjV+Vg3h5QciNTKkSv
         eSuA==
X-Forwarded-Encrypted: i=1; AJvYcCVCv2VwaxTsGyywDO05L32G5R/e0TwNmhvmv6Q+Mukbhu7Z048Z5Zm0lEwok3O3xsPS66IPsidnVgd+n/em@vger.kernel.org
X-Gm-Message-State: AOJu0YzkdaQv3qZBZOFF15RD1gEso3pSS5iNOWBkVRSbnDQ0n9/N76OP
	PjJPR4YD5+5aeLLGaZVSDw5lQ0W2tX1NndtYiewgAHMOHFejoyFxHqWBD48Q8O0=
X-Google-Smtp-Source: AGHT+IGemQUFmu9PaIZ6xQzY5ZRBCr8YGPp43S4g/v8CMW8mcASU1L11oVlkDeXdzelxC4wlavmGIw==
X-Received: by 2002:adf:f94f:0:b0:374:c4c4:efa5 with SMTP id ffacd0b85a97d-378c2d58e61mr8809836f8f.53.1726542821104;
        Mon, 16 Sep 2024 20:13:41 -0700 (PDT)
Received: from [127.0.0.1] ([185.44.53.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e72e49bfsm8441122f8f.21.2024.09.16.20.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 20:13:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>, NeilBrown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org
In-Reply-To: <20240826063659.15327-2-neilb@suse.de>
References: <20240826063659.15327-1-neilb@suse.de>
 <20240826063659.15327-2-neilb@suse.de>
Subject: Re: (subset) [PATCH 1/7] block: change wait on bd_claiming to use
 a var_waitqueue, not a bit_waitqueue
Message-Id: <172654281968.102466.6048255578818127232.b4-ty@kernel.dk>
Date: Mon, 16 Sep 2024 21:13:39 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Mon, 26 Aug 2024 16:30:58 +1000, NeilBrown wrote:
> bd_prepare_to_claim() waits for a var to change, not for a bit to be
> cleared.
> So change from bit_waitqueue() to __var_waitqueue() and correspondingly
> use wake_up_var().
> This will allow a future patch which change the "bit" function to expect
> an "unsigned long *" instead of "void *".
> 
> [...]

Applied, thanks!

[1/7] block: change wait on bd_claiming to use a var_waitqueue, not a bit_waitqueue
      commit: aa3d8a36780ab568d528348dd8115560f63ea16b

Best regards,
-- 
Jens Axboe




