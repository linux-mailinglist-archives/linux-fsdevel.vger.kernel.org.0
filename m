Return-Path: <linux-fsdevel+bounces-19910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3708B8CB1BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 17:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCDCDB231EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 15:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ED1143C54;
	Tue, 21 May 2024 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SQL/+628"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51EE7C085
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306758; cv=none; b=tt8dKBbw3s2/4x3tkALtCfV7wiVVeMYj2kg7wrr+4IAkWYv7Mln8IuNFjcB/aUDYO7Ljb1E0m0WPlnFITvzUyXl02hUlSY8Egb1SgnTp3vogLAyQLKvRQvK3i/vyYu6AC9heodwDkKUcvJk4i4vtXJu/j5DT4GnC17QYEY6JROE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306758; c=relaxed/simple;
	bh=ydWfB8Ixx2WGgADol03f1VZf4M7vv9stY1thXdwwiug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZcajG2JUwII3wK1xSEWAyQVWtEj1FNLHiR0EWOMR3PEcKu/Xdq1Mh+7rrPCCe6FCNPyQJSnTXLHS4cqijwJo4kITeUCO0ALBeGpH9DOyaGuTOGl0eRcV2eUWsziQ5y/T3AqZZ72uKK9T5NCEab1gJLG/sJC6bHAs+VzgpC7TPv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SQL/+628; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36d92f4e553so1574705ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 08:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716306755; x=1716911555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lu6Cz3W/7JBafbJfSPoliRhPwzKJFkEKd4ea8AjEFNM=;
        b=SQL/+628XzU/iFw0p+1n/p5apKqFAR8URGHIFVH+euFdLfDLL2souMjSKPpEQYBqKv
         9hDyoN+KJqZM7d9TlKf/7Mz7Hb7IKaQAcy9gIvPnfdhavv+gKwhMafD0dFap3PM0vKXc
         Av4aDiMHRW5vGgbAU9iJ+1qVQ0/qieyrHot/fR6coa49jpoNuWMJSgzxI6Hg94c9A4Wb
         rE/nhVtAzfZabpc1OQuZMMp7kIHVSgNjbaU6NP+sCb6pfpKqdJ3pghLuQAnW5kRUjTTP
         e2qgNeP1D9hsvMj31t6ojW6cE006kOWJ8GcfFQynaMzSsp80tJB/E5MxmB0ruJAig6B7
         a6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716306755; x=1716911555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lu6Cz3W/7JBafbJfSPoliRhPwzKJFkEKd4ea8AjEFNM=;
        b=ISxtMv0aeAzTc2v3fhe8QKEAXI1wSHoCPmgIdw8SxKEkhOC1vCGycuJHLC9sdtif/R
         olEiEGuo52nB52k1N7zpRMOxDN4kWm26RuJtzD8Ox0a2UclRimeMltiCw7wp0T/EgGD5
         6sNnYHm1Bz/vqJYAGV7naKxu3oMorxcHbdKhjJJhMYcMIHCkTNQUavExMkf3VdEf83F3
         cNcytZygWENHCRJ9Pr7qYeJITBexLweYrHttZoSNBKGS2rzEU/NYkNqAn+jgwqsHnS4C
         bvClF2+pK7UsJIepXQNWRIT37fs9dKeRYWhE9Fy2OvQkbwvYthk07IqNjpD9wZ3y0pqx
         bRzA==
X-Forwarded-Encrypted: i=1; AJvYcCWRPHVfuvudFQX+VgYP0y340+VZEzLy/dgOOQoxwSBu/7yRj6pXRYU2d8I5JQwJBxB27hpBavO7z+eK26iksVYJmpHTZZbVgoTYvZp1qQ==
X-Gm-Message-State: AOJu0YyQDm7ID/6iace6AIpl5MJ5ejOka2x4stBAagqLazSYq1quhVHt
	8LqPZaWZdUbomIOBjypwg6BEchAjf036wLKZJkjv3UccBfUR5a2iE8ND1lO9tHo=
X-Google-Smtp-Source: AGHT+IHa1zyl6cmZPdjySIykg2SQdYZupp88XF9rpgThrnqOxMjg4dDFQSMzR/ggbhek66vW9xxDQg==
X-Received: by 2002:a92:c988:0:b0:36c:c86b:9181 with SMTP id e9e14a558f8ab-36cc86b9470mr305103065ab.0.1716306754979;
        Tue, 21 May 2024 08:52:34 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36cb9e1363esm63659975ab.71.2024.05.21.08.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 08:52:34 -0700 (PDT)
Message-ID: <2e73c659-06a3-426c-99c0-eff896eb2323@kernel.dk>
Date: Tue, 21 May 2024 09:52:32 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfs: Fix setting of BDP_ASYNC from iocb flags
To: David Howells <dhowells@redhat.com>, Steve French <stfrench@microsoft.com>
Cc: Jeff Layton <jlayton@kernel.org>, Enzo Matsumiya <ematsumiya@suse.de>,
 Matthew Wilcox <willy@infradead.org>, Christian Brauner
 <brauner@kernel.org>, netfs@lists.linux.dev, v9fs@lists.linux.dev,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <316306.1716306586@warthog.procyon.org.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <316306.1716306586@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/24 9:49 AM, David Howells wrote:
> Fix netfs_perform_write() to set BDP_ASYNC if IOCB_NOWAIT is set rather
> than if IOCB_SYNC is not set.  It reflects asynchronicity in the sense of
> not waiting rather than synchronicity in the sense of not returning until
> the op is complete.
> 
> Without this, generic/590 fails on cifs in strict caching mode with a
> complaint that one of the writes fails with EAGAIN.  The test can be
> distilled down to:
> 
>         mount -t cifs /my/share /mnt -ostuff
>         xfs_io -i -c 'falloc 0 8191M -c fsync -f /mnt/file
>         xfs_io -i -c 'pwrite -b 1M -W 0 8191M' /mnt/file

Looks good to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

However, I'll note that BDP_ASYNC is horribly named, it should be
BDP_NOWAIT instead. But that's a separate thing, fix looks correct
as-is.

-- 
Jens Axboe


