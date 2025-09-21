Return-Path: <linux-fsdevel+bounces-62321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FE2B8D3B4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 04:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9077A17883E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 02:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531A41FF7B3;
	Sun, 21 Sep 2025 02:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhjV7ttH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E221EB5CE
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Sep 2025 02:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758422598; cv=none; b=GeJkBrygTawHey68QeHhFGqkySbdtq9pU2YsjuXI7YrJ/Zq8MU8wsiMZH/8FBjuvWABeZ29qrXQf4OAWoC+VCevqfU34M3Kqeg2kfhihubM58D0cJtMp/YyWrRMgzbOYMhw+81QMAR2t5KVlJkH1WMni+XR4xoz/Rt/37bbOJy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758422598; c=relaxed/simple;
	bh=IOLNp7bbvWfurHuoNIdJ0OXo/N5Q2rG8Kwy2TSpxEww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiLbQt3FZ9A+6G3LygsMXS2cyu2yU0UuovLEJkTzflMopqqSGH8VJQciL8HSQ80X6LvtHOn4yc7WhpG3cC+SjRVmKIe0kQbveBLwaKGnDw/FdO5iWVRH2HKCQnUw4uyGPfiMWiawdSmqnFNiWSvruz+yF6+VpiBb6PjvIsoDWWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhjV7ttH; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b07e081d852so661781166b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Sep 2025 19:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758422595; x=1759027395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuEJ7Kuw6nXBxfCflCZImXovS/FAgf8BObIoPTsH704=;
        b=fhjV7ttHOrlrbrtH01IvFX7CntG4DvBxipSKCbmNFeb1/wcuzEdqikiTbDNnHRKrQr
         nkEaMVH6M1jJ7nga/pW82uwiN7qAy0GJBMMM12DIPMmNjFXTlbGaB1gDy9ahuI68viWu
         nr5MAtJG516HckWQMgtqdOT2iJ7bwsU26y1HG41lMrtdJ44J0snLpW/2ehfPfiimpGAf
         hxnmP7OSoD57TWz9oaiMcV+vNTfZgPHM3PXaer3u2Oh8k/qGgzephwKWiCZ0lrdipz9R
         qgcJ306bkLKYp7nUyNTKBEj8FXvK4EE1Z+WGxpWC3pPjRi0vmo9pPAPbN9pY8un4J6/8
         kFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758422595; x=1759027395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuEJ7Kuw6nXBxfCflCZImXovS/FAgf8BObIoPTsH704=;
        b=WvMFCZsjW7PVqOb2FHAxFGjyuz9U6jW8L7GqOud8c3ek7g2mWmfzA9q8EvFy3V9qSM
         IGFnPRvPXbr+1gRvCXvKVSbx09iIn89j1JSNonSX3IrskP8Zar7RS6+bcPWRJaMwoLPu
         3eHZw7ffcL/7bV09TI6dl7Lt69hXPv2M18hBjPAReXLPQciCkHK7+4UwIaljQsyHgBPz
         H2rRgx+Z70pc698iZa7VFaGnymBOhRjq9iKoJulAUm+rgyijyUMXskFx/H/EUi6Ndvwe
         TqDFle0rOnpZ+tGNocsR5lm+uT3UVhLun+o4c1T/POl2qViofgyJC3A+GoLHMSObXXld
         JLZA==
X-Forwarded-Encrypted: i=1; AJvYcCV4Zw2+tdNlXq6710jIy44/XC1t10K3PWX912/B3L56uyh+Azo8xrzRWJB3FPQTDfYMDwK2fcFt/Tg9P35z@vger.kernel.org
X-Gm-Message-State: AOJu0YxI21Wjc9Gs44d9p78AYf+n99awgJ4Co7uFNlyp+faH4mz6KVKu
	2KA4tYUtT+K7VCeWZhuNPOAZ/UOY0ny1Wi096T70n0LaIZK5Z2qTHGqU
X-Gm-Gg: ASbGncuxC64koyiOlGOqxOiebpPe3L3sxWJAOb/Q4bRMG8bq9u0qfNXxsHMaKqHjp0U
	LIFYfonkjlSfKDqRDBMhxJocbhX6fM7t1PV4JleSnOQ0vUaXSIxb4AATpm/UonRJpPu6zu7pqtW
	pz6TGuG0D2A2ECcAmL3zClgNAqqWjj+xBnt1XspRoI9yreljzMYobkeA5bKGdhZSpHgxP06E6dP
	0uzhT8qO13Rf7yWBjloCMEHgZrI2Uvwuav6t9v4+w+231WhMZe6AcsG96Y/CBT+G5CcvmYtxyte
	SUEWZGIjofMJZALwh57SheZNr0r8OB4ruZaQQZb2rRw0yLo0BOzXXylkdHl9CMaxAD1ot00eR2M
	dnOjfCQ/L84vS3zdJVzA=
X-Google-Smtp-Source: AGHT+IEnp3bNDrsmT04jwsuiPJbBPOdlnvUNGeBA+GfxOGwI+dq26By1MGxiqYL9UlRIJoqPtfeHuA==
X-Received: by 2002:a17:907:96a4:b0:b04:830f:822d with SMTP id a640c23a62f3a-b24f568a6cdmr856877566b.63.1758422595233;
        Sat, 20 Sep 2025 19:43:15 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b28be3fa38bsm224619366b.46.2025.09.20.19.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Sep 2025 19:43:14 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: cyphar@cyphar.com
Cc: alx@kernel.org,
	brauner@kernel.org,
	dhowells@redhat.com,
	g.branden.robinson@gmail.com,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-man@vger.kernel.org,
	mtk.manpages@gmail.com,
	safinaskar@zohomail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4 00/10] man2: document "new" mount API
Date: Sun, 21 Sep 2025 05:43:10 +0300
Message-ID: <20250921024310.80511-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aleksa, thank you! Don't give up. We all need these manpages.

I see you didn't address some my previous notes.

* move_mount(2) still says "Mount objects cannot be attached beneath the filesystem root".
I suggest saying "root directory" or "root" or "root directory of the process" or just "/"
instead. But you may keep this phrase as is, of course.

* Docs for FSPICK_NO_AUTOMOUNT in fspick(2) are still wrong. They say that FSPICK_NO_AUTOMOUNT
affects all components of path. Similar thing applies to mount_setattr(2) and move_mount(2)

* open_tree(2) still says:
> If flags does not contain OPEN_TREE_CLONE, open_tree() returns a file descriptor
> that is exactly equivalent to one produced by openat(2) when called with the same dirfd and path.

This is not true if automounts are involved. I suggest adding "modulo automounts". But you may
keep everything, of course.

-- 
Askar Safin

