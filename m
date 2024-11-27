Return-Path: <linux-fsdevel+bounces-35947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8C19DA086
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 03:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAECF168276
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 02:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE5720309;
	Wed, 27 Nov 2024 02:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="J+RhvD3J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBB7D2FB
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 02:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732673030; cv=none; b=LPrA7YLlNXU1uHQQ7g5w/+SijIolIQp9HCG5gaNGZlurBaqQdIhZDuIoArOnxQyKWkCl+z6P4Z7+5CVF2UJWKRT6rQ9P5YLosZusaIYSulELzt6vxzD4gvqUq5vLGWLLdcS87PE95/MLRilNDD7D0SJEYw3cgeCEntfLbV8IsZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732673030; c=relaxed/simple;
	bh=wChJNgnYzcMtCDzPZ10Pu9wcJNKgLEuOvX6x66cMhvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hFHGA46HaFkMw0YTaFmhgJcIM0FjLiPBFisdihVqyqFI2NtgPTtaCcnTcmp+5mwgzG1YhmwuzpRZErh5gB+Po/IBelSBAy39KCTliWiWz7mQJtyZBONUw069LvNJ5yyawQkYYgFkT4KU/QZ2Zm8wABiF4O9ErMnqyP8gPh1vgik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=J+RhvD3J; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so5143781a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2024 18:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732673025; x=1733277825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VgG9DBEACJ4jXE8eCHPkHJXxlu/6sH+zgOA50ZjDxpQ=;
        b=J+RhvD3JURbx1Mf2KrkgGJjED5xjn+/pe3Q9gR+I2I/INfN3ilsscLaC86lI1QmpSH
         HKeDW4CSznJsT20963E66jmUbkQIdB+X/GP+YZmaDv/NiWhdPkvIGxAb2URbi5wIwnBy
         beLXqhvNS2Dt2Xu7sKuCFlWuDi/nhqck1bdrj4V04KvpwIn/RCjd5dcEGy42g3a8FXf3
         zQtzsLGT+99bmXHZlBu83AfKmEg2dUjEas/PlNre4rt7rIMRoSSU6LxkUh3ki6/GOoEk
         ZqrcLnkR0wE5bicxJVslnkxi6b8i8f2lImF3ulnxtYqkLzL/ffK/PYV6/bwyK1H3HOfL
         xk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732673025; x=1733277825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgG9DBEACJ4jXE8eCHPkHJXxlu/6sH+zgOA50ZjDxpQ=;
        b=TLkhCmnxq04Nx406bbcV+WkBWb+w7kbAnuYWLdLjdeX1W+Ms1zuGMwpx0xai1rjkL5
         jLv4e0pn9aq51C8bmjggkM8uXybAtpUORyLn0oG2lOE/xJtcrJriI33MhwNL+RlQ5r4s
         h6OejX3dyELVYGE9wv8VinShHXxP79wkc4UO/9lP3g4V8BJcu2AclZSVVVUGuYC9b84p
         Mbe7DCQA3gTRuf5sh2gaencXZzw2wYUG3H92frQxxU5nZ+vBXCdkHZ6khOpWuos54nFv
         iiX9otN0tsQEqkq4oITkghMLvs8MuL36Sy1KvCJBJGrQyV0MaLxXWN5ljJ4tT6Iec86h
         gjIw==
X-Forwarded-Encrypted: i=1; AJvYcCWFtXa8Au9By3BY5TkF1Azm88W5uYVbgIQYoFp6scYLgA4Vz3qIhSUAGygU87RXJpFZCUgSxhdfX+fOctp+@vger.kernel.org
X-Gm-Message-State: AOJu0YwRJuRIYW3d627KLO1+wNAaePVBV40yN9FWLTagNV57cWRf+6fv
	O4cq+gT4uK/25JvT5Mv5yfoQY+gbP2AW9d/g7/w8YsUx7xI6VAe6Cv4ZMhPWq6k=
X-Gm-Gg: ASbGnctYFHB9sCRwY6TqgNDoqsvtDtYQeUf18XVBOrjc65hrZmcKGxkW1BRbIKuBx3M
	uGAy0jQb75rGHZy7DuwF12NARA6WYxTKwZFTyT4Q4ABN+hU8GeCan40cZgFPtmo1D9GYQSnCldD
	yvuQ3LDaar9huFCWhWpsvFePZA/cGm4HwdgyvCRuoRWAwMF3KEDCnq2VS8FllqvbHZCKlccXCwH
	kQgMlpDBeUiDth/44iG6yN4yfX9oVCicUAwII0zZrWpl6o=
X-Google-Smtp-Source: AGHT+IH/s1qE54l01GT1SxPBRt+mFsHrg7IMP012Fq+ehYF84sKVoo+lh3zfChf531i0E25gNfJ8hA==
X-Received: by 2002:a05:6a20:7485:b0:1db:e536:974b with SMTP id adf61e73a8af0-1e0e0b5d863mr2527580637.34.1732673025302;
        Tue, 26 Nov 2024 18:03:45 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de454b41sm9073408b3a.32.2024.11.26.18.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 18:03:44 -0800 (PST)
Message-ID: <2f55f798-389d-41d7-ae16-f98f354c4ac1@kernel.dk>
Date: Tue, 26 Nov 2024 19:03:43 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/29] cred: rework {override,revert}_creds()
To: Christian Brauner <brauner@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/24 7:09 AM, Christian Brauner wrote:
> For the v6.13 cycle we switched overlayfs to a variant of
> override_creds() that doesn't take an extra reference. To this end I
> suggested introducing {override,revert}_creds_light() which overlayfs
> could use.
> 
> This seems to work rather well. This series follow Linus advice and
> unifies the separate helpers and simply makes {override,revert}_creds()
> do what {override,revert}_creds_light() currently does. Caller's that
> really need the extra reference count can take it manually.

Nice cleanup, looks good to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


