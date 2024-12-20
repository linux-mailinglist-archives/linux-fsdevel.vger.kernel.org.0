Return-Path: <linux-fsdevel+bounces-37933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A78CE9F940F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E5E1884F6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 14:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8AD215F7D;
	Fri, 20 Dec 2024 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="w+V5KDtN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A683186607
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734704192; cv=none; b=cbCNpu1FfcFTN+sEICsvF7K3rNdxzVPDyVyFODkbWHaOCs0XVNlM0PvoKvfuWU/hIAvOLRlbzqkdlPDXuvCXVaVLVtNps8rR0Onw7KGJ6QTK7RUZ/5fyap02J87wUyWaNrwrOvwUqmVbDmXc30gS2YYhqcrL39x2yqLQhPPcZQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734704192; c=relaxed/simple;
	bh=nKZxdsq5QzRXV5t8/y9W1d3t4drrwgatktzy5JRC8MA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxSThw6teNa2N/gyI+ERcczr4QisWmLEQiqGyhxG+J4aL8LD73nT7bVgzjfROB5ZilEWtoUHcK1WIsJm2IgG2YKX/OzaTtuRVnIDyOGfCWC6+R7nCGqCIU0+IIPXv5Vb6JUK/ffE4FMeAOdQkHDpduaPgwcVKGVayC0Dj7QTc38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=w+V5KDtN; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a77bd62fdeso13467165ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 06:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734704187; x=1735308987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Od2zcnvy+Skob7o4jzUxcFwew46oxr58HydCMFgN+I=;
        b=w+V5KDtNKlg9vlQqIfXw+INvOqVTZcDzZzTOPJm0QuCbzxS3fx5Dh23btgfK+2tybd
         UgFjSnppQxurKfyu0/ShFxRrQBGHJK1ZJr3f6XKgzy5gqtB4BaAD6g975KiyPNvhCJAM
         BmcoNHbrLlz2fZFWV85tVx2F+jZrZlDOj2OFj0e2qsmvVCbl42rtluxlB7aM7z8l9VNA
         du9IvDdgcqmLRlxcUU+dtE0RgjVgiGl4NufsJVDdCuLVsIh/qGEWmeOKkAlrRyynYF0h
         D8GL1hou58QBbSmsBiyIFy5xmZBDTP8ZcEGd/6124IrK7HmOBcVwP90Tqqn7iobmLI4B
         3n1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734704187; x=1735308987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Od2zcnvy+Skob7o4jzUxcFwew46oxr58HydCMFgN+I=;
        b=T9n9cCB28X6msrG99Q2zNQucrGy+p2g00/i9XhzRhONWgApZwz8dXT5HvJeKjGGM6A
         a7qQeHCt/SIEU3Q3Xw1Gi3elIp+z3HvwgiFFmz3Pc/JmhFGNpxkMUdVfI8V3alWFsP2O
         ntPVSRDmvoCY5FDvx3Upip0JkJTTMz+fZtBQrQCCfjhQLzadJ7kdEMaJ/opF4ZseUoXh
         khOuviQPvRjM+Cl0UvgtRx74Jr7LlOW//C99hE6gbaT2QvESwSeimIEuiOq0NKoanCdB
         ZZIVW8URNj7ffoFPkWVO9dSc/lPxCwJqkcTsRnfeJMXEWX+UckxoLA4abU0H7S/AafUJ
         26Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVbN2LP9ewnt/MMJTX/ZGivRWFvV2EGiSxVDgXqLxly95FCIHJ3OjBUayQ8bx8Tn831B6uIr4ue2PlXkfnx@vger.kernel.org
X-Gm-Message-State: AOJu0YwYEO8noPOKP20iJjJHFbHR3joKJ8JPX/AFJWNtaTdrNKD4klsq
	o5v+v+64Ue6mDa+9P3iuatvuuIhtJe4aY6JYNAQ7hr+9MYLPPVNqrv2IEKm1sz+OzTbQcaYB0wd
	r
X-Gm-Gg: ASbGncsiWKxJww+WtDO01AnK/wKqxEcGb3Sak39M391AOgsUMow7XYny1ziks8OmylV
	7NXYmnEojexRo8UIejPVp22doj8v2epn9+jvtlaB3KZjU/MRcPHELT26XqWv0Xqg3u2XukmCxN8
	YvmipSRzY5/Lvi0IPXEQblFDB6VlVK6G+pJ5WDFNG+0ELFJH1mekFvnYsBU2hIqJY72mkR9kV9m
	ObNZsg3b2KHRxtPh3xUi+fUhOPrifrHaL8zC/RWowtSRafm1WD1
X-Google-Smtp-Source: AGHT+IFK4GJzPS9PuZHJQMBiKb29k8t0eWkw3zO63tOvzuoY8e1x5vNSt8Y4g8JbZBqvV+ZRETd90A==
X-Received: by 2002:a05:6e02:1c8d:b0:3a7:96f3:bb3c with SMTP id e9e14a558f8ab-3c2d1e7df7amr28390245ab.2.1734704186767;
        Fri, 20 Dec 2024 06:16:26 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3c0dfb3264asm8870215ab.41.2024.12.20.06.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 06:16:25 -0800 (PST)
Message-ID: <d24ee33b-4207-4696-b878-5b2c4d47bec8@kernel.dk>
Date: Fri, 20 Dec 2024 07:16:24 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] mm/truncate: add folio_unmap_invalidate() helper
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 bfoster@redhat.com
References: <20241213155557.105419-1-axboe@kernel.dk>
 <20241213155557.105419-7-axboe@kernel.dk>
 <e5rdpzjosbzrddun7vx66dlb522pyo35qpcchaw6eywa3ylxkz@noj2be2j7vjl>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <e5rdpzjosbzrddun7vx66dlb522pyo35qpcchaw6eywa3ylxkz@noj2be2j7vjl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/24 4:13 AM, Kirill A. Shutemov wrote:
> On Fri, Dec 13, 2024 at 08:55:20AM -0700, Jens Axboe wrote:
>> @@ -629,18 +641,8 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
>>  				folio_unlock(folio);
>>  				continue;
>>  			}
>> -			VM_BUG_ON_FOLIO(!folio_contains(folio, indices[i]), folio);
>>  			folio_wait_writeback(folio);
> 
> Any particular reason you drop this VM_BUG_ON_FOLIO()?

No reason at all, I think it just slipped under the radar. I've put it back
now, thanks!

-- 
Jens Axboe


