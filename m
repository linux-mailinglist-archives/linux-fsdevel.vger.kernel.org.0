Return-Path: <linux-fsdevel+bounces-35407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7329D4AC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5681F21D67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 10:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C070A1D6DB3;
	Thu, 21 Nov 2024 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBP8yMmf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66DF1D4323;
	Thu, 21 Nov 2024 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732184453; cv=none; b=n5XZ5xAQPcC/AgykXUJoZLWd3tvz4G3fWSf59uNyKgf4JKvjBEkYhszLmeQIDWPcEHdsCVE9XJ9BzD0Rc0IWsCBGlaY8+wALZuHq7qR+y1evepVCuBRxdGgbRnp6Lc2U+a4mmyB3pd23OelZuLGfII4zUly71VzeoyEmrdoNNUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732184453; c=relaxed/simple;
	bh=r8l8Guvg+pRpg11zsFVkjjS0LsXXaYLn80593k5Vr34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G3GLkv/3AeFwj5JSjLISVpq93je7TVlG18BDTG9zAW+PK2O1ayzhggvUxRiEbP8NJpbLdkalL3r9YK5Tvx3UlIOwj1G71DcaRWleP0w+I/5OcZEAooEh3VQuWjG5ZGX8jBWDUR1naFPAz9ZTUv0vU602X187NiTpQ28ZM9flIPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBP8yMmf; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-720aa3dbda5so547140b3a.1;
        Thu, 21 Nov 2024 02:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732184451; x=1732789251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFKaQJ5wKCRONLmaMfXTjFMeyMJYF8DGbAeQN6+N0hA=;
        b=iBP8yMmfpDcls8yYnFOgEyQvxiI5FpaLvZbsjDHWwqsw0O92+n00dgWkeggTopZBQK
         Qlwiz2oVmiTeEKBJ9DQlwUobYMtLhojm6fHh90V6vEEGjXg+MDFnRzwat4Zya3StfVKx
         b68sjJeTCrL8tv4xX4Vm12dyQghoo6rK1vv/ipeg2kYwwjUUAqACnDgvAlbXQCenM8Po
         PVLnGpgNwmhQGLpBOtkYqwoNWWk05opb8L7H4WEh5/Ka3reQxOofWg9SA2N8nhAaT3y6
         eVwYi4YZpswgXWJG1i1vwDuFKgjEwepL09DhVVYO8wjgzKnrbXh0O5VJ9Zq8008dOnEQ
         3fdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732184451; x=1732789251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFKaQJ5wKCRONLmaMfXTjFMeyMJYF8DGbAeQN6+N0hA=;
        b=ZvcppE0FHme/ygpqtwvVnBwzUPrqhZj9iMwYeLP3q1b2P/tsXDdjnNhAFHR4XD5p5J
         yLB+LRGKObMwvSXOaUigpghkgVdIWtXCzbcS+i6xUIbVrBu8rf4hSMbZZEigcaca5Pvu
         F8WaO/n2RtXhwsPWPmNRxpOkN4PTt5dcz/kp0QTZuyvHShrrE4dtFkdZfVvBgDf1fcH/
         pn7SJh57lvewZoKWWZqulkFhTuG/s0SruT8T4AERZlMhw6dLCVLqGz3DzOVSdY+R15wc
         YtQPIiyXywpdpuPCUzO8fNz6FmDNo22yD7YUfY/B8TRugptQbogvFbPISJ0aSK5MjYHC
         OxLg==
X-Forwarded-Encrypted: i=1; AJvYcCU4q0taFbRUxuSScdpMcTg9CyxG7TbEtrT6rRtmzS6FCcbazg36jKP8vmwU4ufpWEuGGXvFyDMCO/q5asmW@vger.kernel.org, AJvYcCWIm8zRTao+cX+Pgjm3aGFuLNW7l42sJ255Wk8YhZUwwHAyW8t7uSk+GMSd6Za3s0K47wMhNg5Ayz3/Mtih@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg/SxXpQQvjI6BNhUwXbYYlBb1Km2snboL8eE0nCIWGm5P9H0p
	2yjduRFQU5LpGhdQeLyGkRpRppxMx3nlr4Wm/OwGBnSUQfcfXcDB
X-Google-Smtp-Source: AGHT+IH5idc+duKEBmcHZ8WCavEtCgrW2+wGsc3I6OeXvDX0AWBqaokS1ncGgHEjyWAUqVtWcbcVwQ==
X-Received: by 2002:a05:6a00:2308:b0:721:19bc:4bf4 with SMTP id d2e1a72fcca58-724bed5a66amr8103271b3a.23.1732184450990;
        Thu, 21 Nov 2024 02:20:50 -0800 (PST)
Received: from localhost.localdomain ([43.154.34.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724befa6167sm3219860b3a.131.2024.11.21.02.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 02:20:50 -0800 (PST)
From: Jim Zhao <jimzhao.ai@gmail.com>
To: jack@suse.cz,
	akpm@linux-foundation.org
Cc: jimzhao.ai@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	shikemeng@huaweicloud.com,
	willy@infradead.org
Subject: Re: [PATCH v2] mm/page-writeback: Raise wb_thresh to prevent write blocking with strictlimit
Date: Thu, 21 Nov 2024 18:20:47 +0800
Message-Id: <20241121102047.610700-1-jimzhao.ai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241120115731.gzxozbnb6eazhil7@quack3>
References: <20241120115731.gzxozbnb6eazhil7@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Tue 19-11-24 20:29:22, Jim Zhao wrote:
> > Thanks, Jan, I just sent patch v2, could you please review it ?
>
> Yes, the patch looks good to me.
>
> >
> > And I found the debug info in the bdi stats.
> > The BdiDirtyThresh value may be greater than DirtyThresh, and after
> > applying this patch, the value of BdiDirtyThresh could become even
> > larger.
> >
> > without patch:
> > ---
> > root@ubuntu:/sys/kernel/debug/bdi/8:0# cat stats
> > BdiWriteback:                0 kB
> > BdiReclaimable:             96 kB
> > BdiDirtyThresh:        1346824 kB
>
> But this is odd. The machine appears to have around 3GB of memory, doesn't
> it? I suspect this is caused by multiple cgroup-writeback contexts
> contributing to BdiDirtyThresh - in fact I think the math in
> bdi_collect_stats() is wrong as it is adding wb_thresh() calculated based
> on global dirty_thresh for each cgwb whereas it should be adding
> wb_thresh() calculated based on per-memcg dirty_thresh... You can have a
> look at /sys/kernel/debug/bdi/8:0/wb_stats file which should have correct
> limits as far as I'm reading the code.

Thanks for review!
Yes, It should be caused by multiple cgroup-writeback with bdi_collect_stats issue.

@Andrew, 
I sent patch v2 according Jan's suggestion. 
Since patch v1 already in tree. So I sent out the diff of v1 -> v2:
https://lore.kernel.org/all/20241121100539.605818-1-jimzhao.ai@gmail.com/
Could you please review it, thanks!

Jim Zhao

