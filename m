Return-Path: <linux-fsdevel+bounces-18931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC528BEA04
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 19:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ACA11F2249C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 17:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D97B13D63B;
	Tue,  7 May 2024 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NP1Jd2E4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981E853E28
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715101499; cv=none; b=qrJ6tiV6TTbrVIcBZqwTfahNHQbgXr6wtveaxry/CD2Lz2GUFRFyzCBbjiXsVQfeirLVETKb7lpUw39KVMRuhp7TqCazt08y5Zjvz6lYO1wl98UbhuwAz8pEVWvqMaFqA4Lqb4Pw4pppKcszTiovDQ/V74FJTeVtCfQwx3wInJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715101499; c=relaxed/simple;
	bh=UZKao+sUmzHhKthGvkHfgeitNibMH3RZ6Xh64koB+Lw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGk3E37uPy9hibjKhjHKeQjX0d4F+r2D08X7Ac1WaQD/aCXZjOP9q4PFMJD3JugR29y6NyRbiKBPeZqY9EtcwWg2rz7LgfwWTwnP3VsQmx3/tgpuQG2QBVgCw6FaP9zt8vEK+h+YNLyiA5X5+5Vk1PmIZ074Hwk7xM2QijOjbmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NP1Jd2E4; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-628a551d10cso1540348a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2024 10:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715101498; x=1715706298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VvOdta0CTNgaMD1FjE1RDD1M1Oa41gzPaIknnALqmo=;
        b=NP1Jd2E4RmBIJlrelGZ/+76ImElVUG9DMF4wvsPa44lLlWeKXFAG9mcMYCoGvODY6V
         m5PwkefrpLYqCjXzZu5sF60KYaQjXPy0HfaT1C0PS67PEeX07+KP4QbpiSZFWciSwb4q
         q3WRp77Kh2zijIaM3/9r/gJcKTGjaCY6wc0kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715101498; x=1715706298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VvOdta0CTNgaMD1FjE1RDD1M1Oa41gzPaIknnALqmo=;
        b=fq+Jk61d13oE80BMqnTAaSOXreb9hvSQwZj5tgFoAYj+gkvZa2abxJiHKSH0JZpjLD
         ieDfa6GmpoMjKS8EWWiHpBTleuS26UedpRhBUDct4mv2IYwq+xrSAaLSFtgtf2o27uUx
         pv8U3l2RyOokgXmMX2K25h/VmYDzIzqtiBK/f8ZqmDeS4IwuI6O8p4zfnh7IUXy9VQh4
         taF6s8lZuJMKhYVIFLWjBnZF9/Jlc3JN046KDFnqRijRagKmjy9yv5epX1e3o/EwWhVA
         oU72ilEHuDdOdpaeH1tkE51Sr3QRY2y7x61gBGpY/Lo0I1ylZPJgsciupZg1l5KwF26h
         mmVQ==
X-Gm-Message-State: AOJu0YzTm34rdjjFV0dnKsRkQYz85L48SOeJoefT3H+qV99ohTtoFSDv
	NuCrFuG2DQ2Z2ZVsb91svKDljJB238BeXBgMuhGoR0gDvj9RZYyYqqoOJP199A==
X-Google-Smtp-Source: AGHT+IF6VIPpzWidq8Xhn8vQ5vy8+tHIstOIQn9hSeNKvmfkqoOMJtcT7bQA79cHqdnrlPj9ICle8g==
X-Received: by 2002:a17:90b:1889:b0:2b1:74ad:e252 with SMTP id 98e67ed59e1d1-2b6166c9f85mr157870a91.28.1715101496921;
        Tue, 07 May 2024 10:04:56 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sj16-20020a17090b2d9000b002b27eb61901sm11927831pjb.21.2024.05.07.10.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 10:04:56 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-fsdevel@vger.kernel.org,
	Allen Pais <apais@linux.microsoft.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	ebiederm@xmission.com,
	mcgrof@kernel.org,
	j.granados@samsung.com,
	allen.lkml@gmail.com
Subject: Re: [PATCH v4] fs/coredump: Enable dynamic configuration of max file note size
Date: Tue,  7 May 2024 10:02:53 -0700
Message-Id: <171510137055.3977159.13112533071742599257.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506193700.7884-1-apais@linux.microsoft.com>
References: <20240506193700.7884-1-apais@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 06 May 2024 19:37:00 +0000, Allen Pais wrote:
> Introduce the capability to dynamically configure the maximum file
> note size for ELF core dumps via sysctl.
> 
> Why is this being done?
> We have observed that during a crash when there are more than 65k mmaps
> in memory, the existing fixed limit on the size of the ELF notes section
> becomes a bottleneck. The notes section quickly reaches its capacity,
> leading to incomplete memory segment information in the resulting coredump.
> This truncation compromises the utility of the coredumps, as crucial
> information about the memory state at the time of the crash might be
> omitted.
> 
> [...]

I adjusted file names, but put it in -next. I had given some confusing
feedback on v3, but I didn't realize until later; apologies for that! The
end result is the sysctl is named kernel.core_file_note_size_limit and
the internal const min/max variables have the _min and _max suffixes.

Applied to for-next/execve, thanks!

[1/1] fs/coredump: Enable dynamic configuration of max file note size
      https://git.kernel.org/kees/c/81e238b1299e

Take care,

-- 
Kees Cook


