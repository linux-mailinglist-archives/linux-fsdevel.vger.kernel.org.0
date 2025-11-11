Return-Path: <linux-fsdevel+bounces-67959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B705C4E94B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 15:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2A6B4F5D3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06C73043BC;
	Tue, 11 Nov 2025 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hjxI1RFj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202C4332EAE
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872089; cv=none; b=btEExhUvYgaqkV0javKNtT1dt5krvE9nEQ9yjiULd2tlNoM2PAHyWefdyKA3pPvUIBtzyJ7mYQ7ygD6s8lv7ykE+zlYy1k8giZio5CsgKHbaI9Ku/CaC7YoIvk6Gy4P+lDCR4yYoCJvSCVgbsgh7LUwyV1xnuAvzz4nGRc68zU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872089; c=relaxed/simple;
	bh=KSxZLglOxeS+T2/tlk7iOWOgFgF+QB8I9cVugzlebVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KcbeXKexjncTRzOr40kczbdCnCJDza41ErUogeeBVK9f4h+HzvMsqWtzby/DYlHRTI7xtTSt9P83ZxHjQnzvc7qXzqHmOlBnWk8h++ZXtEKBpmmkFjHJq63oGyVHEt5t8WprB+iYlLEfpR9DKcSgdGfQPm4xJZjbVgcGOoWOmkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hjxI1RFj; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-9489c7bc020so110738339f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 06:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762872086; x=1763476886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LHq/vGiBYX19IyAjvpsj0s82ScpRukDdLxz2HyIHoFY=;
        b=hjxI1RFjk2o0gLtNesbkZPWIteNI1zXP3oSxD3r1To+j8a0ykk4vwKn5XUQS50xfYq
         zjJprVUNDuCLbQ6fRKHE0SP3yBYXMvUoi0Pe2l/69KLMHTh6xra5w+h/gTjYXl5tj2th
         TL8l4GAsroQ46W1vS4gNVr2preXtRpg+a5KrUx85y26VjYh+NypoZAXyLJ0XbnxlZYbj
         0nps8bbn2XkR6/1ZjHL8bomE2lOm+dHJqPj70VZfupWhrmUj31+2nil9/h7JFBo5zwSS
         cSuBhzlTqslcHBA5A45yaqlpzZC+DCiynQM304FE7XX3s6mcuPteShTUna7vp6YtIiQY
         QPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762872086; x=1763476886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LHq/vGiBYX19IyAjvpsj0s82ScpRukDdLxz2HyIHoFY=;
        b=pNijogM5Tn6hdlPgYBRviyEhdzYHgj6FBNb2LjDJvPCu3L++9muYiXQ197jyd7jaz7
         lMWE3QoJ2TJwrLuFUpL2S+Fa/DIwRLXUAdsZTDs6FS/B42/mI2efBXwrupCtK6KRld5m
         kNBmPBWNVquGSeeUEjwbLjjc9ePz8cZnxBQsDjFMviCG5LjM3s/IJvG1HI9hKRLvS/6i
         0N95xNsaNM3t66xFxY18Jkrcct6u4c2Z3sgaY1KyEphnWFiGHfC3ClDzKYhSQR7GQhyy
         egwfaOipWipMe3CfP/AV4freGX+hrQ4xRVXCPKOPtXxMbLmUruujSBm6uAHm0NaVmAsL
         RO7Q==
X-Forwarded-Encrypted: i=1; AJvYcCULbSdEW7EGm8NctWXNSek8YhI7pwiSyaCit4cyB87D9Aw/o84W3Ha40agEpHEKkFYrY7htgi8KEqZQwSu8@vger.kernel.org
X-Gm-Message-State: AOJu0YxJJEmxjpnAJYZ7CvLX74T/w3bzwQqk9h9m+OZQdQeCJggBoIFw
	utv8du/LVD+bEOME+ANQkVS/DZLIC3h0PV8+lb+1+tpQJLzdYSft5E25COwU9NwkqWzXl3k5xY+
	wH3vZ
X-Gm-Gg: ASbGncv9MZv9Wxiq1d8FFxA5ELRhhrbUBbVKdBYcd5LCiN5zpzCJNBfkm9CsyMuitwV
	RveYQuiN1S/LNm6nLG41g/wJH48PoN6ue4lsWgQ7ZbljzvyXmBviRPWnzixUK2peWYyMZQ085pi
	3kUqtzuH07Ki5mfcSY50yk8oHqWJAAx4RkFIvw7auX4fXeM8F2qgXSO74ZVT53LFREDOE2l+sK4
	wsGtDkO3BvkNzals0ePF3iFd0KcSLvEIG3HJknKQimhGzevbqPYoiM7JshhCYAwTaqBxbETLO2b
	QFdFYld6GKNk8FjGqaqLl+013Yu0NPaZUcXxyfAWS2dFXtHs93+TwD0qyY2dXQlR+cU5IBFcSgo
	xPKMt4p53zf2HDTtsI11QVY6xfspXf8iKKYH/UahvG7imMEpwlkp+elJoHQit01gtMarf9BgMug
	==
X-Google-Smtp-Source: AGHT+IF9qtXDJkW7aPNIhYGjEhbbO2h9PE5MLJY4LFYe3Ab10AJRovJe55m7m89B0ZJ6/+08nI7FPg==
X-Received: by 2002:a05:6602:6087:b0:887:638a:29b5 with SMTP id ca18e2360f4ac-9489602c03cmr1526890739f.9.1762872086130;
        Tue, 11 Nov 2025 06:41:26 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b746806d41sm6259258173.20.2025.11.11.06.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 06:41:25 -0800 (PST)
Message-ID: <257804ed-438e-4085-a8c2-ac107fe4c73d@kernel.dk>
Date: Tue, 11 Nov 2025 07:41:24 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 11/13] allow incomplete imports of filenames
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz,
 mjguzik@gmail.com, paul@paul-moore.com, audit@vger.kernel.org,
 io-uring@vger.kernel.org
References: <20251109063745.2089578-1-viro@zeniv.linux.org.uk>
 <20251109063745.2089578-12-viro@zeniv.linux.org.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251109063745.2089578-12-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/25 11:37 PM, Al Viro wrote:
> There are two filename-related problems in io_uring and its
> interplay with audit.
> 
> Filenames are imported when request is submitted and used when
> it is processed.  Unfortunately, the latter may very well
> happen in a different thread.  In that case the reference to
> filename is put into the wrong audit_context - that of submitting
> thread, not the processing one.  Audit logics is called by
> the latter, and it really wants to be able to find the names
> in audit_context current (== processing) thread.
> 
> Another related problem is the headache with refcounts -
> normally all references to given struct filename are visible
> only to one thread (the one that uses that struct filename).
> io_uring violates that - an extra reference is stashed in
> audit_context of submitter.  It gets dropped when submitter
> returns to userland, which can happen simultaneously with
> processing thread deciding to drop the reference it got.
> 
> We paper over that by making refcount atomic, but that means
> pointless headache for everyone.
> 
> Solution: the notion of partially imported filenames.  Namely,
> already copied from userland, but *not* exposed to audit yet.
> 
> io_uring can create that in submitter thread, and complete the
> import (obtaining the usual reference to struct filename) in
> processing thread.
> 
> Object: struct delayed_filename.
> 
> Primitives for working with it:
> 
> delayed_getname(&delayed_filename, user_string) - copies the name
> from userland, returning 0 and stashing the address of (still incomplete)
> struct filename in delayed_filename on success and returning -E... on
> error.
> 
> delayed_getname_uflags(&delayed_filename, user_string, atflags) - similar,
> in the same relation to delayed_getname() as getname_uflags() is to getname()
> 
> complete_getname(&delayed_getname) - completes the import of filename stashed
> in delayed_getname and returns struct filename to caller, emptying delayed_getname.

dismiss_delayed_filename()

> diff --git a/io_uring/openclose.c b/io_uring/openclose.c
> index bfeb91b31bba..6bc14f626923 100644
> --- a/io_uring/openclose.c
> +++ b/io_uring/openclose.c
> @@ -121,6 +118,7 @@ int io_openat2(struct io_kiocb *req, unsigned int issue_flags)
>  	struct file *file;
>  	bool resolve_nonblock, nonblock_set;
>  	bool fixed = !!open->file_slot;
> +	struct filename *name __free(putname) = complete_getname(&open->filename);
>  	int ret;
>  
>  	ret = build_open_flags(&open->how, &op);

I don't think this will work as-is - the prep has been done on the
request, but we could be retrying io_openat2(). That will happen if this
function returns -EAGAIN. That will then end up with a cleared out
filename for the second (blocking) invocation.

-- 
Jens Axboe

