Return-Path: <linux-fsdevel+bounces-8751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E7483AA53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35EB11C22783
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503ED7764D;
	Wed, 24 Jan 2024 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oJ+RSQzQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03AD60DFF
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100750; cv=none; b=sENaiSJ7olCLNGEfIMNb68+Qq9jQ6MazN7O4k8q/2lcnkOy3to5V5Q4otY81fvsPfpBcWDmhzCkfrFCUgGL6SJ6p8/gCO8Iq4LL5gQ6IccSIl8xmuWGARKR0RzkpaDWXmWH6pqRgzrsU9dO1Dtyy4TymMBykrHN53LvCtQ/FZbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100750; c=relaxed/simple;
	bh=u87dgtOCnG858+2RLEm/eNuMK0BlwRijmTEReSQrCk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IfyaRZqALhPJLro4K7KEvWMoQ5OYD0MnvzQVgcWJmFpixb/MMB6X+kp4/hT16tvPxv4xFAI8pTExBZ6f/uh0G4ipJwbDMVCDKplX+bxqr2cH6UDIA3DzXjimyNZJGq8c90jjGGnQ1hYVBEeQyKv4VNWPBvgnI2HJKlGWAisQcf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oJ+RSQzQ; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-59910dcc17bso951331eaf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 04:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706100746; x=1706705546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RcSqh3U6uVN9tud0FaGQjxIaTxF3VYfhi3DfVDRmK/E=;
        b=oJ+RSQzQkC5D5Khb+wfZ7ugSP+IrJ2M4QfpGvrzmsObZWHQepayJg91ms388p+APHM
         vfB/UaCRoUh9IeXvMLXNDC+asyuyQ7N1ch5ODk+IyX/XtAsYdR/HTy6EgwIV/tuSmOXZ
         eE2IBjjPPXXbQ37z/RwkAVLStekEQ2XGZn59SKeB01TExfXCVDw/mIFQ9ftgCrnMy+K9
         tbS+kGfuNYh+G5n6o4/DOUHWfOkdeqODwX9BXjEJy7q0Djq6ePHDJnP4/O6zsg8cdlgD
         LmDdxrA5lsJ4o71oe9xNrjIFgMJo8tKoWurNmmNUEaNmFv6ytEd/O5ogHAb/YZ9TTVnr
         KmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706100746; x=1706705546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RcSqh3U6uVN9tud0FaGQjxIaTxF3VYfhi3DfVDRmK/E=;
        b=ujegfX0mKuh/2QNO7orlgv7XHXbZPMfDGg4LWgqUSopOwApmeBEdVeUbpTn3UEzPlr
         mrBWd6Xe6Ty4k+Dc9q8CPpobKd2EsWZYG0+pLAb+i9xWrk/IJVM+QnzBkaU5IaluzFVk
         /ZCnE4T4IKwuMB00RY6wBEUIjKx1XUvq6C2Fo1X7c+8SBEDcRG3NmhjmcWcmZP/wUkcJ
         0nul1aHpmNYXLnkrYDtn8Rx/SF5KZwwZH0bkYF92w+vuUmBP6iFPlSI3EDRsy7Jr9E5U
         +f0oMGA/v3ZUNydrO5n0HUfoQ3I610TDLaqz9HeWtwOM9pfsupymIuys2X1d2Y2414H9
         4xdw==
X-Gm-Message-State: AOJu0YwkYq3iCOLb8yCRZuhAlVg80V79Xe+u7hMfcF3+v7zINe9O0+OV
	WEGbLEetRtAvmb0T+fNeB6xq1GF9BoqMbQDbxrNI8hAVP8G5SIBmDL5/HY4UpaA=
X-Google-Smtp-Source: AGHT+IEV9XPoTij4w6t/c3jamgPJzwbW0uxPDvd2LhSt/JNYV5z6Ri6q0YWVg7VwoBycESUWkXZj8w==
X-Received: by 2002:a05:6358:e48f:b0:176:6189:de7e with SMTP id by15-20020a056358e48f00b001766189de7emr2503685rwb.3.1706100745748;
        Wed, 24 Jan 2024 04:52:25 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id h20-20020a635314000000b005d4156b3ea2sm2108542pgb.93.2024.01.24.04.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 04:52:25 -0800 (PST)
Message-ID: <fefaf2bf-64b7-4992-bd99-5f322c189e35@kernel.dk>
Date: Wed, 24 Jan 2024 05:52:23 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] io_uring: add support for ftruncate
Content-Language: en-US
To: Cedric Blancher <cedric.blancher@gmail.com>,
 Tony Solomonik <tony.solomonik@gmail.com>
Cc: io-uring@vger.kernel.org, asml.silence@gmail.com,
 linux-fsdevel@vger.kernel.org
References: <20240124083301.8661-1-tony.solomonik@gmail.com>
 <CALXu0UdfZm-UJcPqF5H6+PXPp=DC2SA-QFbB-aVywmMT5X3A6g@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CALXu0UdfZm-UJcPqF5H6+PXPp=DC2SA-QFbB-aVywmMT5X3A6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/24 1:52 AM, Cedric Blancher wrote:
> On Wed, 24 Jan 2024 at 09:33, Tony Solomonik <tony.solomonik@gmail.com> wrote:
>>
>> This patch adds support for doing truncate through io_uring, eliminating
>> the need for applications to roll their own thread pool or offload
>> mechanism to be able to do non-blocking truncates.
>>
>> Tony Solomonik (2):
>>   Add ftruncate_file that truncates a struct file
>>   io_uring: add support for ftruncate
>>
>>  fs/internal.h                 |  1 +
>>  fs/open.c                     | 53 ++++++++++++++++++-----------------
>>  include/uapi/linux/io_uring.h |  1 +
>>  io_uring/Makefile             |  2 +-
>>  io_uring/opdef.c              | 10 +++++++
>>  io_uring/truncate.c           | 48 +++++++++++++++++++++++++++++++
>>  io_uring/truncate.h           |  4 +++
>>  7 files changed, 93 insertions(+), 26 deletions(-)
>>  create mode 100644 io_uring/truncate.c
>>  create mode 100644 io_uring/truncate.h
>>
>>
>> base-commit: d3fa86b1a7b4cdc4367acacea16b72e0a200b3d7
> 
> Also fallocate() to punch holes, aka sparse files, must be implemented

fallocate has been supported for years.

-- 
Jens Axboe


