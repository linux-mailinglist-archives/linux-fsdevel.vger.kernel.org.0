Return-Path: <linux-fsdevel+bounces-32877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50129B0083
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 12:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9EE1C221B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 10:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2AD1F81BD;
	Fri, 25 Oct 2024 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKuTxrpc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A4B1F80DD;
	Fri, 25 Oct 2024 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853496; cv=none; b=cYg9M5xhkwvTKTE03rF3bkL0UsqBFMYiZHhJtChOD85sjE2dtxamKhj+LUr8YeCw72naT1rkp1k+zsZiuW4RF8/Ixy6RxSvFxSOXDA+RTr1nzPRry7h0JPQlN83EZ6wxPS9vqpEdYY8EX1EbgAmo0IklfrwWmoyRhuxyqKj5dbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853496; c=relaxed/simple;
	bh=tFtrWadSxWkNbn0popvPy/EZHyeiRuvarB9rsCc4mT4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=oUHM2RUo3mJlaDie59wxVREgogaoWvhWG2/xjdmV7NITXHj6yOB6pkIC3p3vsktkuvU1mXtGWTr/EI7xts+A+LD1dOZSv5TMCaAB0lTO0bj5Aop4jf6bxoombAVdoOJ8rh1qxHBt2v3XsnzJGCMEXSGAyWE0mP1Mn7YBiTjSPaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKuTxrpc; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2cc469c62so1345731a91.2;
        Fri, 25 Oct 2024 03:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729853492; x=1730458292; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WkAiTu1bdb90IGHSZoidLF3RSsaRQic+WSNfrF/7YJc=;
        b=mKuTxrpcU2nkW3roi1uCR1dQIQcmizJdUyytBUawA/in95WU2IGkf6sHyMfFPqIAd1
         lfF8NNAH4r69QdLL1mRaPlCQZDbNNu26wJGsIhu+KE8RP8AlcXd4QfM+GKXdNWr5ftF8
         UKQlD7s+uEBDrqbPTk/SdaTIR8tj9BctZSLXWz3RLzBaIypIKB4GVtYMuD7YYdLja2YY
         7Hi4gXoUV24LMe4WXjj9XvTiT6SJd6hIhjGncf3sV1p5qwBixKWEUNmEE7zZrb/rvMhD
         dcqjKYi8d4afC2m+U47wB6LdiPxsOh8q/rEckJFN8YQ0md5vP++59LAjthVKDJaKoPTa
         40fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729853492; x=1730458292;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WkAiTu1bdb90IGHSZoidLF3RSsaRQic+WSNfrF/7YJc=;
        b=v+QnGYxBbvEKK4w+hDg44vo1XxEfDhoRfDypIhgKUxKsmsotw+U6LWLbK+fKV2dTkd
         Kjxk/rFAfTaO8pyjnm5ZI7xzKG66RaaYmYz41syFa3P1z+MwrZxk8FSxg+6RgoR/5Ur0
         X9eh5ZRwCBvzDvknN1PRH/Eoz0dKsZklPlRZDaHqVpi69X2DGwmkZZoORZhm0jypaP/Y
         36JGIvvSWyXPJD6hvkSjvl9qo+ZD9790MDmGkWU9brQw2G14VPqJQoOJfAeaUoxxRTVb
         uBFcXjGdQ+rbhwVlae96hdHR0gmZ4sU6Kk/A2AlcDdLUyQUHTgUdJgC4Nm9w6Au1bRdG
         NYdw==
X-Forwarded-Encrypted: i=1; AJvYcCUGFp1h+CnWGvsEuZHfwRijI+4p4qZGHf9c3mfQz345N546oI6gBGA3UeAAbyit53mSc7FfLXs99cBZ@vger.kernel.org, AJvYcCUGs7WjeoCWHmeg4uKOnlyYErMeuJykAI21tB09feaxdYhZqGY0+Lhk9oK/sYfklDODFgZ5U8gPi/yfTyYAIA==@vger.kernel.org, AJvYcCUNbvl19t7EpdsmAcxwc0Y+tqXgTVSlqHpGEveVEYDA8PhJ/eE+wHikr2q0GCgykI8Rd10cc+HijCDaYXdv@vger.kernel.org, AJvYcCVHp8B40bkAz/jdAxhv6p4K2R89Dpxn/tqC9UM+gJhXk9rQln9A88Accukf50DllXhc+iF45hTG0/kw@vger.kernel.org
X-Gm-Message-State: AOJu0YwBwr+noe2XQXaLTPaAaVOfthGksVoKfK71TlrvszYK4L640iQ4
	sKKMCL2qrRg3d9CA497ST9BmAjccX7/IyQAqRlXxApeUsCgQWzOAZnztoA==
X-Google-Smtp-Source: AGHT+IGRP0zjbo5mZSgxWtQDch0KrnR4hOUTM2Fq/27SJPqtcC67zJQuDBYwQ6BG7x766erRRae38A==
X-Received: by 2002:a17:90b:3a8c:b0:2e2:bd34:f23b with SMTP id 98e67ed59e1d1-2e76b6d5492mr10075435a91.32.1729853492302;
        Fri, 25 Oct 2024 03:51:32 -0700 (PDT)
Received: from dw-tp ([171.76.85.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e4e4008sm3135483a91.24.2024.10.25.03.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 03:51:31 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@infradead.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/6] iomap: Lift blocksize restriction on atomic writes
In-Reply-To: <fc6fddee-2707-4cca-b0b7-983c8dd17e16@oracle.com>
Date: Fri, 25 Oct 2024 16:05:03 +0530
Message-ID: <87v7xgmpwo.fsf@gmail.com>
References: <cover.1729825985.git.ritesh.list@gmail.com> <f5bd55d32031b49bdd9e2c6d073787d1ac4b6d78.1729825985.git.ritesh.list@gmail.com> <1efb8d6d-ba2e-499d-abc5-e4f9a1e54e89@oracle.com> <87zfmsmsvc.fsf@gmail.com> <fc6fddee-2707-4cca-b0b7-983c8dd17e16@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> On 25/10/2024 10:31, Ritesh Harjani (IBM) wrote:
>>>>    
>>>> -	if (atomic && length != fs_block_size)
>>>> +	if (atomic && length != iter->len)
>>>>    		return -EINVAL;
>>> Here you expect just one iter for an atomic write always.
>> Here we are lifting the limitation of iomap to support entire iter->len
>> rather than just 1 fsblock.
>
> Sure
>
>> 
>>> In 6/6, you are saying that iomap does not allow an atomic write which
>>> covers unwritten and written extents, right?
>> No, it's not that. If FS does not provide a full mapping to iomap in
>> ->iomap_begin then the writes will get split. 
>
> but why would it provide multiple mapping?
>
>> For atomic writes this
>> should not happen, hence the check in iomap above to return -EINVAL if
>> mapped length does not match iter->len.
>> 
>>> But for writing a single fs block atomically, we don't mandate it to be
>>> in unwritten state. So there is a difference in behavior in writing a
>>> single FS block vs multiple FS blocks atomically.
>> Same as mentioned above. We can't have atomic writes to get split.
>> This patch is just lifting the restriction of iomap to allow more than
>> blocksize but the mapped length should still meet iter->len, as
>> otherwise the writes can get split.
>
> Sure, I get this. But I wonder why would we be getting multiple 
> mappings? Why cannot the FS always provide a single mapping?

FS can decide to split the mappings when it couldn't allocate a single
large mapping of the requested length. Could be due to - 
- already allocated extent followed by EOF, 
- already allocated extent followed by a hole
- already mapped extent followed by an extent of different type (e.g. written followed by unwritten or unwritten followed by written)
- delalloc (not delalloc since we invalidate respective page cache pages before doing DIO).
- fragmentation or ENOSPC - For ext4 bigalloc this will not happen since
we reserve the entire cluster. So we know there should be space. But I
am not sure how other filesystems might end up implementing this functionality.

Thanks!

-ritesh

