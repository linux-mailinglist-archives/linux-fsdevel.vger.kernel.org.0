Return-Path: <linux-fsdevel+bounces-9455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F608414C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 22:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6CB1F2569B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 21:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85824157E66;
	Mon, 29 Jan 2024 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tkJzgch9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA365157028
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 21:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706562003; cv=none; b=Ets+wUZVS0LSg+a0FGF8F9AvI3w8PTTt+bqToJVoMeRe+yV317nKreub8DXEkgdt0L1/IIU9vYneO8j1ASn5AktB0MR+zcUXmizeD9eho/3CIz9bDLGQj/gxLeKgeH+iuWg3UjxH9r8S5tXmuw9ZvXkAoYJ7rvWSgXbgs9yaCWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706562003; c=relaxed/simple;
	bh=ibokadCESHSA11HDDNlCAcaBxiIM5GHQthJ33p4hMt8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CQulcIpoak7Azm7qIekAyMucvVuvY6DdBpkHkGAkhtkKD8NNBOjD9TNovvloZiqzK64pVe7LLsk0OTBxT/MoF+2IlGRpq4RpMwhY77Ugllv6UL3P4ehF8HRd76ZwUWF6C+oa9Nq6/fwh20D2XcTwGOqCDAXqIAR3IU5pzgNs+fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tkJzgch9; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bffe53850eso10661039f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 13:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706562000; x=1707166800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LSn6LBXM31HvHqvEALdWkrsVvyHsbFeG4dy64fSTfE=;
        b=tkJzgch9Nb/WNZ4ZTES2hmNvzK00dvws5U+TIcwWEETT0b/mGdDxaLfDZfglY+nohL
         HiwcI4XifHhoMDBblbf4SnuVXIvBgvsRblTo6SNQDn81TDgZ/p8OhaFnwgdEZVqhdR6H
         jbtana5G6JzhyNoRT9UrOv6cHkDEj4E8txCwXZd3GX2pnKBLVF7EPdwcm2mnxUZJLCkJ
         FXV6+N12FgxyIETeFQxEZkIPTcKqUWj8l0q9Uf/blOlgBnpViyDP/X1rJ8+CVUWwm0Ly
         OtaSMwO5+Z/yuqAXfOSVnFQdcE5zv/oj/rb2e+Qn36OHV5GPtSiBEEU7EGCBCUJZyx8j
         xt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706562000; x=1707166800;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LSn6LBXM31HvHqvEALdWkrsVvyHsbFeG4dy64fSTfE=;
        b=lRf416F3jVSexrWa2h/CZNEQe9ZdZqzekM9KnHsoPXUaoR68ySyqHSMT+0at50yXdl
         kzU3iNgrY8nh5b7JTHk6CzRxKwi1WEuduj6wHQ6RQOb3UY/SR/+Z/gmFZ3fc8l857Kgv
         f24e6qNwsa/O/h+Xik/VgblyPUu3ytU5v0WRCAu/w7D/XHIxhWbDABV8H+6nEX/C3vqc
         GQwLT9gnKNuefmd5QBcUgPYZaCjFtsUuOvKfy/DUeIRjAQHa0l9Cd9sQk0KD9Vc16AHD
         SFxkVhiKxCbkS1Tnaz7TE0Ahj8t/4dlWXjQlRA8yuxcKMzv66D2ePQHnPqPCF8bx5+yY
         sxzA==
X-Gm-Message-State: AOJu0YzU5Rxj0SLpDpFHBqisDmCTCPQSYA0FzQKQTqHpsplABVs0Nyy4
	xFS0+yBrAH7JYgmrKx5EO3dPM8/w9joqJ+2OaXSaavMgcFbqgRG9Xd4sC/2QvWQ=
X-Google-Smtp-Source: AGHT+IHPTdM7bWCC3uKdOyS9KP89WOgaIyn9pl+DIsnhjC44TMW7G+ElMdFDPse7HJKfD3zVMCK0Dg==
X-Received: by 2002:a6b:c953:0:b0:7bf:60bc:7f1e with SMTP id z80-20020a6bc953000000b007bf60bc7f1emr8003144iof.1.1706561999898;
        Mon, 29 Jan 2024 12:59:59 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d9911000000b007bf0e4b4c63sm2339741iol.31.2024.01.29.12.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 12:59:59 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: brauner@kernel.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240129180024.219766-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240129180024.219766-1-aleksandr.mikhalitsyn@canonical.com>
Subject: Re: (subset) [PATCH 1/2] ntfs3: use file_mnt_idmap helper
Message-Id: <170656199924.3224941.3075763153914506438.b4-ty@kernel.dk>
Date: Mon, 29 Jan 2024 13:59:59 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Mon, 29 Jan 2024 19:00:23 +0100, Alexander Mikhalitsyn wrote:
> Let's use file_mnt_idmap() as we do that across the tree.
> 
> No functional impact.
> 
> 

Applied, thanks!

[2/2] io_uring: use file_mnt_idmap helper
      commit: 712fc7e5862c2b9af7cf37418e4b398c5493ffb5

Best regards,
-- 
Jens Axboe




