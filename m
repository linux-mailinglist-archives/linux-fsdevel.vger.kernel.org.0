Return-Path: <linux-fsdevel+bounces-47129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E732CA99936
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 22:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343BE4614DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 20:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75852741A1;
	Wed, 23 Apr 2025 20:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MiSEKTvM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FC052F88
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 20:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745439043; cv=none; b=KVbMy8JH0WfH1tW0MetK+WVxdQo/o2K9qvQg/l9qTMTThza2IPDt8X80JDaiNb9c/ouZ4MaMx/rzqyWPYZfOEuPWQmjiqC8Rhc3fl1eLv5GcqppUDhBfC0SKjlXP/DFcjKYlWkxnMofXjuDgCpXOjcyJcWs+JaMlXw/wcLw+rYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745439043; c=relaxed/simple;
	bh=HqIXcWpEBWid+l2OiDQI7nWiV0QSluTCCJghdbBX6dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eiJpVfJnWAFDOgUKNqtQp7BcH3aVUSy6Dv6tt2sQic8X9huucmMOqoFTpNZmgIaoE6+knfir7X3CGo4s1e0Mad3nDBx+XMyX1weav20WtNOA1KNE7gS9EipA77yUr/4PvZK93yNhOHijOgesvUhS6e73EF/TI+sw8fuVj5QxSM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MiSEKTvM; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-8613f456960so10702739f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 13:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745439040; x=1746043840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L4aZh75tam4hiDyoi4zEtwQZvmp/wQknrw8epVfbLHc=;
        b=MiSEKTvMIqJvuLqLM8ajCEgcpuFblwLhddbGYTD+0ZyEwTtdzaM4wOxWnJJGTdStVa
         be44CH4kCK0LAiNcnuHrpfOFre4rrr/6a3IiEZ82IsLrPuv0xoDBGCIIZVFPOtIsXce/
         59gTEwf3UwF3BL0tud6bVFy3B34ri9TFotChK5qS/zzxaOZo/m7oIFhnjN8+uIz2NyRL
         OI+QHF+VzjneNrt3MRHizQgE1+eu7BdablOCF3awH69JvweN0nMIUVKZIojo7sDao8VK
         hs/VopUE7XnSmod6rEMN+Hhx5QDs0E7pIOYfWerTVXYjU+e+xgZ4EB2NCp8bRP4vrOeq
         eVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745439040; x=1746043840;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4aZh75tam4hiDyoi4zEtwQZvmp/wQknrw8epVfbLHc=;
        b=ZKefCjqU5ZUPgefvVc50PkOqwELhCyYxDSPmTR/2hznljgk05gzmmurNGoPjR82Aej
         Oj2RzJc6n+f4wsQOwX4LZ8ct3i3pADJOjeTWfYmJVIKn3xj3oHviFnaiBMpz9jc8Fv7x
         oG/iAvyon+rMOwTw8psAZ7kY75sM3LFFP7hqbPclG3WiGcpb/AXWmDCFTQxuQ9dEINye
         djCmQoaLfoL2SdkDsOxZC+zb3/EYd20WhtPVXbgwBS9hdLO94KK3d4C4TrRzdem5+xD7
         49111l7OJ7amphLP63seHyO6vlIsALYNsfqCCTzvDa4Lt1GSXYjc+i2m0X/1Pdogo+9z
         TH2w==
X-Gm-Message-State: AOJu0Yx6smq/FvAlgsOVOe4Jk87elQ3BLYNHQCSGZeFXy3ShCxV96/mK
	MeKUVvsU/5QxunRJWYAdJxn79MhcxjDkJIog00RaiCex8FJaDysYcd1e9iypf3BPAdY+cAv5pyB
	4
X-Gm-Gg: ASbGncsMVPfx6tw7fyHBX9VWrfkgXKXDOIxmHKPKGOt3TpBZLxuUr/HkQ25jkpD1C7U
	2fxSL6uJOKZsWhdrwPi1IP7hcTUaQYQ+bMvkpKviPl8y6B59+/qp/0N6TaL+4nB7keAuNJWzqH6
	1IrJS+rsax3gVoyAVk2O12njxKQB2KRhTdNU1xGe5bJyM9WsEjmVA8j/JXkIXTooMAdAVs7tVcp
	7/szggo87EJG73SDWNkvMEpyhvtJoxLPFvWzmhAeK9A7zKu2iWmxh5d48RoALIvf52boFFdUxS2
	o7nbuLKNo8fO34i9oVYSQFnnH2sZBbSN54aD
X-Google-Smtp-Source: AGHT+IHUo12s5KpqBhFFTUaVnPuLGTIq+azon1loYWCZ4jeC2mqhJUfYZKyFttdMlmM23xuFgMyaVw==
X-Received: by 2002:a05:6602:4a08:b0:861:d71f:33e3 with SMTP id ca18e2360f4ac-8644f9b422amr34522539f.5.1745439040629;
        Wed, 23 Apr 2025 13:10:40 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a38383dfsm2918100173.70.2025.04.23.13.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 13:10:39 -0700 (PDT)
Message-ID: <c3880483-7cd6-4151-9af8-f6a1be9977c9@kernel.dk>
Date: Wed, 23 Apr 2025 14:10:39 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] splice: remove duplicate noinline from pipe_clear_nowait
To: "T.J. Mercier" <tjmercier@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250423180025.2627670-1-tjmercier@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250423180025.2627670-1-tjmercier@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/25 12:00 PM, T.J. Mercier wrote:
> pipe_clear_nowait has two noinline macros, but we only need one.
> 
> I checked the whole tree, and this is the only occurrence:
> 
> $ grep -r "noinline .* noinline"
> fs/splice.c:static noinline void noinline pipe_clear_nowait(struct file *file)
> $

Funky! Obivously looks fine:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


