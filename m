Return-Path: <linux-fsdevel+bounces-28448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA99096A74B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 21:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C4028629F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 19:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336AC18E047;
	Tue,  3 Sep 2024 19:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kibzVtUa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3595C1D5CEE
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 19:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391527; cv=none; b=HJviLNO/hqd/FMhBQgOtAw/EzPpm78LWrX1sUMqtde+WV71SGMaP6re5eG/ANGMjR+PQENM5y5nJqEEMA91/PMhJFm2wTkPuYBKGhXSXbTILjMA0q1jLE9evCOIPvNat/gm3/TSFsMqNDbuIaj2rtPLV6gRRwdaOSXs9R4Eu2nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391527; c=relaxed/simple;
	bh=eH65FtbXcjL3NdySdQNuDbtsiecYyLab7Jes7YSCprk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQrlWXMBeKrreqxa3g5on+pOvtCUq4/vbArkwo0FRCejC1CcxTKliNva4PHhDEX8BTmcPlywiHds8syKt/zXFQ+xLJUWugEUd6RYbIwDGOH/XaynkWTRZ3720y3dABE5b4qStcXEwHr2N614Mn1Ll793x/OfjJw97uBAO5aRNQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kibzVtUa; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7d4f0181be2so744276a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2024 12:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725391524; x=1725996324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zvvSQSIvOqN9m72hiUZP3NpocagPN1JI/W3HnfMPVIY=;
        b=kibzVtUa+qc2AXgIQ6UO2iHOuernnz5gvjLXyuq2KvUFs1mO2jsJj8eHeH/ts4xTJn
         K1S+toOBjgocApvou2JALRgnZn5XMrlo2MhEcNgZLPGBStF6UG50ifQVtN53/BSLW+Pg
         yg+79z3gvzLRe8S7TZjdWINmHBUXKHbP+/jD4y+f4bFQPFcbp3mEZDWdNhZUsvOHUKq6
         bmKfnJTtbC0HVTnboHw1Q5GLqcTRHGrKZVoEdQK474Eo0Arh1BaFW0kMsw06Xaklz5Bn
         Yz+qid383OPO1uQZ7shp7l9JcuQFFWgWik5rS57ZZqAbs/Dz5GiqV6LFinZ4HG5xoV8x
         N63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725391524; x=1725996324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvvSQSIvOqN9m72hiUZP3NpocagPN1JI/W3HnfMPVIY=;
        b=K52BecI/WJ9lfTFDaOL6Ll7y3LlLC/3B4dqIJwNU9GDcAeO8e9IOaVNfDYSrAHoSuj
         iFqkOseGbbQi5V75coj+U5Z+TE2V2dcnzOVbC7yDHROkwWNPAwLcmP7utB1XdYwny7gV
         3lmU0Ol7xd8EpfGRJu/WQoQ2VnUoDG6RJgCk7/xcCq23KVoTs/wW2lqXNvN8f2SEECCW
         g9vg58rn8/Rxh/rS/Z9/Mw/Ik2uBc91lT5ZWqFGk5Lsa196s8gNzdTIe55Yc9BMRPf+j
         Nwr8nwoAAnBlpoRVbBUu9ZnShgs3xPf/Fkqpdp6eMKG+TuH629FtzYCXicVZ+v4YuXVt
         AkuA==
X-Forwarded-Encrypted: i=1; AJvYcCX0aeE7AkTa9FOtSmB5WwIL6XFw80IxogUxvRPB54EA0YG/oXiR6YvMc76bmEWZDNmlPLy8U9OBZITBKXRQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxziGodefjsRT0IZhYet9lGyUqmNTh2xkhcUjXM9Y7ECAiBHalQ
	OZc95FGHmdiF7/7irgkq98jZwV3iYyfZ7zc57pa8mfYDrRTjNc7zBOtxO+haajg=
X-Google-Smtp-Source: AGHT+IHaWsVznbLcYLFEg1FdWcNri04dfRvVxa2kecF/sCjhTUkpPnIgm5ZFToTBj30tcQXpsW56hA==
X-Received: by 2002:a17:902:e5c5:b0:206:892c:b751 with SMTP id d9443c01a7336-206892cb7f9mr57365375ad.65.1725391524498;
        Tue, 03 Sep 2024 12:25:24 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea58618sm1860425ad.226.2024.09.03.12.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 12:25:23 -0700 (PDT)
Message-ID: <2270dc9a-aa60-497d-896d-fe51974db588@kernel.dk>
Date: Tue, 3 Sep 2024 13:25:22 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] slab: add struct kmem_cache_args
To: Christian Brauner <brauner@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

This is a really nice improvement! With fear of offending someone, the
kmem_cache API has really just grown warts over the years, with
additions slapped on top without anyone taking the time to refactor it a
bit and clean it up. It's about time.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


