Return-Path: <linux-fsdevel+bounces-40458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71597A23769
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 23:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656583A3E0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 22:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9380D1F12F2;
	Thu, 30 Jan 2025 22:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ata4zVJK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BA712C499;
	Thu, 30 Jan 2025 22:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738277649; cv=none; b=omhfxlZOV6Ad4+tk/OaLZONiZdSS/wTWDtIVqO6SN0Uxtr8T12wZWBAgiFSBzyIcTvw0IJwF/KsLx5GroUs+WwzuaxS+M1jiBTRMxolVOghEQBHyKSHhIuFKpLNRDt2mnNoDhKHLMIfJM46W279UoeaoASPYrVMmYoWizlNtIe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738277649; c=relaxed/simple;
	bh=tZYXKgz669d+08cfrUT5RpN64nD6dpIHipevvKTwAGM=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YfUBAQ3XSjBbUQsgqVp4AtqbUrVTT5iOfRiX+oJ2opAhliQu442iYxJAnAOnRXKoZCdkRybenv2bcaEfvZmgdTryMjghCENDd8EUdu9KeQDXXpqQar1emWrv2JQZsnXNgdgvOHtqrUUxUTr2QW+veR3+/mWXrN1kmoDu5qE2Y0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ata4zVJK; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71e173ed85bso713188a34.3;
        Thu, 30 Jan 2025 14:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738277645; x=1738882445; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1dnOMjSh0d+bW5MlZ5Vpw9v4g7OqihbDB0XqrU9wYRM=;
        b=Ata4zVJK4mRLZPn9RnfilbxTuZ6PorE+jnIZN4IjktpRcqos685z3NBuI/GQ7tje1v
         I9aBekuyXIV6/a/AtPNMSb0iLEw6efhf3lzyB/XAjkstypSxEU9HnYGqzfEFtd0XhoKP
         t2wlYquQZOTFfdo+XQ0w++wIaakN3ecYKaAN7H5CqJWVxbNGBw74/ltSUwtsy5kXyurk
         kZn2qkRtZLkY2CucLukewA3P/3EcQnVLDXdWtH1QT09YchlNhMpIpYRx7ycKspHVezBt
         TzhENJ3ZuIn118QJVx4+ergYmwiArmx3Ci9SjvWXyvkobYLq1b3PuvPJvg2IsA+Nmh7y
         gogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738277645; x=1738882445;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dnOMjSh0d+bW5MlZ5Vpw9v4g7OqihbDB0XqrU9wYRM=;
        b=BpE5OPqa3DyMiRLlAr7FMynhD3ox2jjhBzV+2q3NTl8i8L/GmkYJ+8KL1rxqjfP4XM
         SovITN0VsUMWjKX2b6T1F5+1zAXdUfjCRIbBx55bQyqq/tdT42yRGcNPzBZ74YsScbMe
         KUrXVP4gASTet9HxSEcXpmmEMhacVrIOhcUxbetESccIwsEQ2kfCiUTvnqr0RTTVMCsd
         2Wkth3W5sdu106XpAG1s5sd/h5qu+5ttkuNlkzdYLii3dt6arXCzcF75tIN+5ePvtKaP
         eEWUVny/b1Yrqjiw/efdhpePFFgionDV9DtJ5CueM35NonifVacXCCWLfJGK6WTMhsRZ
         PYwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK7yrm8mE2E+xJsT3pEtyF2BHPhqeV5d9wa6JMWMYxq29XajIalsy0ILV4X0o6lliwrLooCTNcwoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/jNmKKuMd+mJC6hFxyO8sSfmM3s5BqMzsf0V+daIrM9sIlRv0
	UEliJ24PWCRgahLzYksQU3PeKmH58t5nIDeRwBh2FmMijVWkj/Bu
X-Gm-Gg: ASbGnctX0cC2A6IZYVX8J/hCuT3MYyxvlpvQsikeQSP1qPs3GWF9lacwoZcIaeDr9su
	y2F7V6DlwkH595mC88VeXIRLLrMqEYkyrZUJgxRwTUKnvMcHTpkzEuPi8GczPSsWXsSyYzQ14lp
	hFqb8YJ6DccRTarVxY7b8yf2MJK/zpylXrpITPjw8Iv77dC+xJS1Sy1IiNxoStRps9obmSrzp/o
	4/+ePw7RehVi/MMliJ2kVtDAX+27h4Ra/L8qAIjPuCLMdXCKZmYITZjdkSdTwqkXgUkHSlAxQpK
	qWTfgqHoO/Y/QGthmjGSWkz5eVeKLYPU
X-Google-Smtp-Source: AGHT+IEdr2RBJaZ46mgRFf+nont1bdKP9SJhSxgwB49Hu5FCb/9DLH3qYKKZSbVJFjobkYX8iy/Yew==
X-Received: by 2002:a05:6830:3808:b0:718:4267:d3c2 with SMTP id 46e09a7af769-7265676f065mr6751858a34.12.1738277645214;
        Thu, 30 Jan 2025 14:54:05 -0800 (PST)
Received: from Borg-518.local ([2603:8080:1500:3d89:ade3:d3:5a45:83b9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726617cdd7esm559916a34.21.2025.01.30.14.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 14:54:04 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
Date: Thu, 30 Jan 2025 16:54:03 -0600
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, john@groves.net
Subject: [LSF/MM/BPF TOPIC] Dax, memfd, guest_memfd, cxl, famfs - Is there
 redundancy here?
Message-ID: <hobfuczt5sdnj3acjara2qzv3wvhcugyx34tr6rkxsddzo5gix@ta2ysllb6h2s>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


I have been hearing comments that there might be redundancy between dax and
memfd - and have recently become aware of the guest_memfd work. A session where
we discuss these related abstractions, their use cases, and whether there is
redundancy seems like it would be useful.

I come at this primarily as the author of famfs [1,2,3,4], which exposes
disaggregated shared memory as a scale-out fs-dax file system on devdax
memory (with no block backing store. Famfs is currently dependent on a dax
instance for each memory device (or each tagged allocation, in the case of
cxl DCDs (dynamic-capacity devices). DCDs create a "tag namespace" to
memory/devdax devices (and tags are basically UUIDs).

Famfs, similar to conventional file systems that live on block devices, uses
the device abstraction of devdax to identify and access the backing memory
for a file system. Much like block devices generally have recognizable 
superblocks at offset 0 (see lsblk etc.), sharable memory devices have UUIDs,
and may also have superblocks. The device abstraction of tagged memory is a
very useful property.

I've been asked a number of times whether famfs could live on a memfd, and
I currently think the answer is no - but I think we are at a point where these
abstractions should be examined and discussed in context.

Brief famfs status: At LSFMM '24 the consensus was that it should be ported
into fuse. That work is getting close but not quite ready to post patches.
Those should start to appear this spring.

[1] https://github.com/cxl-micron-reskit/famfs
[2] https://lwn.net/Articles/983105/
[3] https://lore.kernel.org/linux-cxl/cover.1708709155.git.john@groves.net/
[4] https://lore.kernel.org/linux-cxl/cover.1714409084.git.john@groves.net/

Cheers,
John


