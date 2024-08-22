Return-Path: <linux-fsdevel+bounces-26809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A33095BBB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 18:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA15CB2B619
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 16:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE721CCEC8;
	Thu, 22 Aug 2024 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tYebXSDi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AE81CB300
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343462; cv=none; b=PmJcD0ghBMmkF+ZrmV0w4/Ru0Ger0yNlPQGxXKY5ZYfR3cCQv1ck3KytF6cErCU3UcW7EUK7UF9KJL4/lwxGi9iwy+zBgA9z9/SLPBSIuhUOprWuTH3nt34GVxi8W51hpa+WRuc7BPbigBZihfM3QssaQmDZydLgOu5NFrj4KV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343462; c=relaxed/simple;
	bh=fO0Ny0NtwVEL9QvLvwMKpoXuQjWCs9S6npzgo8t5ShE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PtUKrPUysH5ITvlwJHc4r+bcrC5jIHpmKnJFy2uEWFIa+4ppWtxJykMr3zkHnOVFr1Lv9xQrPBM3eaPDx19X7FnQ/xNFDn8mvTK2L17p0heFSoHMmfdizNSs1+pppDuvs2z8i1vtyog+w8uu7tZy6NPQWzYp3iOpAhS3ZxPQeS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tYebXSDi; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-81f86fd93acso37490439f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 09:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724343459; x=1724948259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iTA3dVfPUK8s/I9Uyuvr1/h6o9HC9dmzI1TfveiHvG8=;
        b=tYebXSDiW3437UO+b7iYjbGssUXpZpUPfaDIUOkBjhBt+lYHXtQK5eRtULPdalHfca
         8vphBz8dRr/SnhuaAgJTm3ZdIgzqy8yVVfWRju0WUb7LubvYL+s9u5NIAHPpgfYypSfi
         bnYRLNv9Y+r57HgexfMyRrXqlpy7djSHprAC6QVrxoVtC2QZ97JEFLOXzKCdcO5MdOc6
         CNgH+I0NGSdM3v7iuJd0mzVx02BM1tjhgyOaPUZ2Qj2y9QMAY3+JtqOSCzmj48TH0xtV
         Az1ZRBOPxht397z3De2MAfnTNRPJA7A8fjkmSm9nGOg16ceEFrME4TkToxLYsJFPTugu
         9+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724343459; x=1724948259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iTA3dVfPUK8s/I9Uyuvr1/h6o9HC9dmzI1TfveiHvG8=;
        b=vNulTtm24aXGB2jpX1eKnG3ZsqSz4SY1fDbqpfmNdSYdtllU4Ii6VNiCt+RfZ/DoLD
         jOp2GQGh3Wd6gWtFJ+iICVhUjF9uaywU/ehMyfhkI7Yiyu+WF20EJ/2sXxBDBzn7Qs1j
         dbzXpQdGsS3NRCqYl3MItjCqvJLYtvuEGpNv85wUxXR+codj5LPKdkN+g8JyPhTEhCW5
         F0+lHdZj6rO7UIoALJOKkb2VcKy7M1MgB4OoB2zMJocFsQvYJfQ4xMXt7NcIr7PTawDG
         1oxWBlV/NmKHKd7u2mPTidrox+mYlYNMyV2Fs51YaaGOssry3b3sU82Ka4V6OUr3I8aJ
         BXOg==
X-Gm-Message-State: AOJu0YxpwwMlMD+SB/ALR1aOJFY5ENXheaEOQ+U8A1jU2ZZTgjll2gWK
	3DDg3l7tJVMBDpXShhq5GXlbv+qa4iDy3PxkNkYoH1RqX4bpTvqoOe/7vtTRPnk=
X-Google-Smtp-Source: AGHT+IESipPjcGGwhmp4O93xpblLyzSE9rwR5JoN+eXdj9RYHy9FyF0K+2gsQkvGL8qFvpxJfsJ6KQ==
X-Received: by 2002:a05:6602:6193:b0:81f:e064:db03 with SMTP id ca18e2360f4ac-8253a65c996mr286463939f.2.1724343458757;
        Thu, 22 Aug 2024 09:17:38 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8253d5bf606sm60352439f.21.2024.08.22.09.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 09:17:38 -0700 (PDT)
Message-ID: <47187d8f-483b-45e6-a2be-ea7826bebb62@kernel.dk>
Date: Thu, 22 Aug 2024 10:17:37 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: switch f_iocb_flags and f_version
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>
References: <20240822-mutig-kurznachrichten-68d154f25f41@brauner>
 <19488597-8585-4875-8fa5-732f5cd9f2ee@kernel.dk>
 <20240822-soviel-rohmaterial-210aef53569b@brauner>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240822-soviel-rohmaterial-210aef53569b@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/24 9:10 AM, Christian Brauner wrote:
>> Do we want to add a comment to this effect? I know it's obvious from
>> sharing with f_task_work, but...
> 
> I'll add one.

Sounds good. You can add my:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

as well, forgot to mention that in the original reply.

-- 
Jens Axboe



