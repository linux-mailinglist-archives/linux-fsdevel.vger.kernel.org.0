Return-Path: <linux-fsdevel+bounces-26744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B408495B91D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 16:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544FC1F27A5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 14:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7481CC175;
	Thu, 22 Aug 2024 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HJzhsRQC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98831CB329
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724338560; cv=none; b=ZbxUBw48F/NuVAc7JV3VwUT+0m6/jRhpM8JGaeiz9rX5OzBQ7VFisDy3u3sxpTAZFUlQrvNQVnx/hG7upzSDO9+L80Xo8QjYhWfjbHsnvl54fSvCXQzEwqaMxA80eFuys1RVt4weaaPnoQCrTm1hUnrkHiOqF+cGG1iHnWzwWec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724338560; c=relaxed/simple;
	bh=6FzjtsfczkeDzqfflnaL28HSvRkafCDBfhrn77H5NEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vF0AX+ZVutAMRuADyFVlBaPQAe62VKdHIOOkYP22p9a+lrjYBGjraiiGdwKUkqZ4YFA7edOtGb2L/PQU8PYHMpcgKeE7x/pglyamm7TrjuqAziPj4wSpw5KRstUkhRwcPNngYqF4J/uvvMl2iluP160iolyrUr0kTqi14RfH2JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HJzhsRQC; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-81f96eaa02aso49184339f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 07:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724338557; x=1724943357; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cCjgk4zbnA01advQFiVaD59nntzMj0pgK0o5XLauJg0=;
        b=HJzhsRQCWlHhnhyntbQ2OZjcrTRhbFQ2VJrwpKyFh72p3dyUZMJhjwSeYPUda8FUXf
         B0DrTSj1rCwET72bXoU2ABtUlzFzKnSEiWD6SP0itgybFp/8K73cQ/p1oNGibrI2I6I/
         13cHSOCnP8f188Tl1BERcZ+rZqObaU24R4qvBWWra5wED0n2vsTEjcLg5SJRYBxDuUOV
         oH9Cuk/OsIdaEg7DYa7/NmJyXclIGu0M2idZmjprpmS0aIXlUM6D9GIrSdMIc3ohYJ8H
         5oxOvno/XA9gNwEEnqXBgijtnSExOhxCQGAVGgljYdyjigrCGtZWK1/6w6v1MJd4bXPz
         /TLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724338557; x=1724943357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCjgk4zbnA01advQFiVaD59nntzMj0pgK0o5XLauJg0=;
        b=TABGAg7McVL8CWjbOdsBrpVeectLEZ+JQd2MWLsXhWIn3k0cqKc2UtY+LKnPcTwwuy
         tRSEX3q388ul6E7Q6DSwSMf3hUajY+PM2P2BdCJP52agWUw+bvQtRN6asg6NSmxOTjJa
         TEPoX2uwoJMKGwXYr88jJSUWmtrynqftbYc2DT3eZ/0nWYB/vZfLaPk0JY+lrYgKd21F
         GvVubDwlKtI02y7KY2zS4LJ01yHYH00rDnKvb7nztLziZkHKcTV6cksevBPho7qp9G/h
         s997ICdkv+Ynf1l3n7KIyC3gZShOI2RVeShxS+28psEPfcOsLU2EQEQyNdyDlbkHvcud
         MKdg==
X-Forwarded-Encrypted: i=1; AJvYcCVgH41XeYqEouBldKV94d3gUi9Bo/kKDJ3yCZyUyLFy4mbqvI+AduUXDXhGJ7qyGTtp+y2YWFa5ik33FysK@vger.kernel.org
X-Gm-Message-State: AOJu0YxRcI4tDB/VuminqZT1ON9RXb9mlThjD2kFcUOtz4Ev92goK2Qe
	Ov20icrzsbBh7aF/cL0lpOiG6otzCI787nSNmhMyVEyZ5lycCBa1N5YVKDYHJFo=
X-Google-Smtp-Source: AGHT+IGtpJsIoM9eezAPjrEjuFlYb1Ps4Q4uC8eJl1JVJxdqqIA2WOAu+OjuZJtUzvGqfdlZEfZbkA==
X-Received: by 2002:a05:6602:3c5:b0:807:f0fb:11a2 with SMTP id ca18e2360f4ac-82531921dabmr681720539f.13.1724338556818;
        Thu, 22 Aug 2024 07:55:56 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce71140ee6sm510403173.170.2024.08.22.07.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 07:55:56 -0700 (PDT)
Message-ID: <19488597-8585-4875-8fa5-732f5cd9f2ee@kernel.dk>
Date: Thu, 22 Aug 2024 08:55:55 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: switch f_iocb_flags and f_version
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>
References: <20240822-mutig-kurznachrichten-68d154f25f41@brauner>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240822-mutig-kurznachrichten-68d154f25f41@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/24 8:14 AM, Christian Brauner wrote:
> Now that we shrank struct file by 24 bytes we still have a 4 byte hole.
> Move f_version into the union and f_iocb_flags out of the union to fill
> that hole and shrink struct file by another 4 bytes. This brings struct
> file to 200 bytes down from 232 bytes.

Nice! Now you just need to find 8 more bytes and we'll be down to 3
cachelines for struct file.

> I've tried to audit all codepaths that use f_version and none of them
> rely on it in file->f_op->release() and never have since commit
> 1da177e4c3f4 ("Linux-2.6.12-rc2").

Do we want to add a comment to this effect? I know it's obvious from
sharing with f_task_work, but...

-- 
Jens Axboe


