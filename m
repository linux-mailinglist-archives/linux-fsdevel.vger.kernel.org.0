Return-Path: <linux-fsdevel+bounces-16940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC7A8A5420
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 16:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1EE1C21366
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 14:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2592780C04;
	Mon, 15 Apr 2024 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pTCvqqa1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3767D82D7C
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191476; cv=none; b=uWth3LZY7JNjg5K/7TxB3zdEoXMJkb6Kfsd2Uid8OLaPAwLlXWoAUQmlXbgb948cO0pigXYEh3s+YarW/AzkyPluLt77XnJ9nW/fEKQP7fOOM2VSzL/SWmUNCUR1Ebo/RWXsg2as3LkRoyXdE+KsSBB9vG2sNVMuZXuNVSmbHqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191476; c=relaxed/simple;
	bh=HqcXRnFyce4t6qwtROljrSsa/5ZmP0WlXQyFVrryB3A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LPhwoNEh4wp+8oxe1VH2zC6d/6fg0fLjXUhcyHhJDhcRV6C9LvD3g+PKVespQzEm0EL/XpT6rIMne0JGAVg9G0dg3ZI90JcJGLqDQHUOdy6xTTbMATmvQg8CO6YyNdSXEUAhGwtAW2MASUVQK/LbE6oEIhqP3aGyTT4R9yOpkP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pTCvqqa1; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso15325139f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 07:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713191474; x=1713796274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OnyTUnI7yjOjaMRaS9jTa0qNIFpYhtFJ/FJeohWZYZ8=;
        b=pTCvqqa1YGZFhKo4ZTRdU8zW5RCFBoqBKmnvgh4cnWy331LViylg21Hl2KvPV1yTls
         l4bnb345PFdQqO60qjRHMw4Lg5gZeI4GkrDM/yewXNtzmI5Iqdkw6AguiUvKCbZ2lB57
         zXi9Hnm1+SmWPx5wLUOYO7CS4WjJBat3nY+UdRPbkgoKL/8WpR+wvOVoX3e5evJ2bY0e
         Rl5WHizsqKC4UNEOynZNUe/+EuVY8MLoa9M5EN2/QA2eVaevC3HtdezEjFNneEFSFlt4
         R8V5xgwWWnpgv9xoucMln38BWHQq8Wz5l3z6VGpjKoCEgW3mdlYkjktrT7L1yJKHozyO
         pquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713191474; x=1713796274;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OnyTUnI7yjOjaMRaS9jTa0qNIFpYhtFJ/FJeohWZYZ8=;
        b=itAlJ+c5WzcjJ5j1cSIDxnTFRXXtO5ieFASMND87moY+dTjwqBVOLz6XxeEL6UepdC
         U92x2bClfLj6YFRQUIw9HfpNJeNB0/Kz6Tx9YIXYo7OsbsAS6oQiCaihpmj5XDE8row8
         9KdGaVVnDREAEstaJfksGhsDKyporpPa2BBhcPOoop/hleMpwc1c0MS5HuukenWskt1s
         qwmwz7QpCp63Tj8XnEAV/R1638lKwnVhmdv3HwH7kKLCxxMr1DM1ulVcm/Q4uZ4dTOoH
         Y9OvvRM60v8+r7qv0OQxbXkmFIMAq++JVGi/DCTOhkpIf4VKtK8JE6xBh24xmkNfdceV
         2p1A==
X-Forwarded-Encrypted: i=1; AJvYcCWCn3jvQiQF0bQ3HRWW2O8kA9YRip6N6NwWGA9NLUV7dmJ6absPfkK2siTdMvTHE325CFRsE+6zafO7cJod/BDjz2lhu71COI1tMhwKEw==
X-Gm-Message-State: AOJu0YxEiwoZKP5vU2l/6NVftZxmf6kuAjYfHEg4VsROlSmlA7AjTF8P
	Tqo6mal387CgHkH9kBvdRMNg/q6cGB3kfBbiPC570WjZr0HImtsCjJFmxARFUo5zquv7tWoNqZA
	5
X-Google-Smtp-Source: AGHT+IGxjV6l3osWhSBMqMq8bHa6oq22HWgvV00Vl7O88jIAahhIDnE/sRlw5ymP4XlITqHuj3e8aw==
X-Received: by 2002:a92:c14d:0:b0:36a:3ee8:b9f0 with SMTP id b13-20020a92c14d000000b0036a3ee8b9f0mr8165771ilh.0.1713191474351;
        Mon, 15 Apr 2024 07:31:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id j10-20020a056e02218a00b0036577f79570sm2634837ila.54.2024.04.15.07.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 07:31:13 -0700 (PDT)
Message-ID: <a81c7a79-44ce-44fb-8b33-4753d491bcec@kernel.dk>
Date: Mon, 15 Apr 2024 08:31:13 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [syzbot] [fs?] [io-uring?] general protection fault in
 __ep_remove
To: syzbot <syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, io-uring@vger.kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <0000000000002d631f0615918f1e@google.com>
Content-Language: en-US
In-Reply-To: <0000000000002d631f0615918f1e@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This isn't related to io_uring at all, not sure why syzbot has this idea
that anything that involves task_work is iouring.

#syz set subsystems: fs

-- 
Jens Axboe


