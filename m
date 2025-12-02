Return-Path: <linux-fsdevel+bounces-70484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8082DC9D2F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 23:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355283AA0A4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 22:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF132F9DAA;
	Tue,  2 Dec 2025 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6KXZfCD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDZTYanC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B5B221F0C
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 22:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764713564; cv=none; b=ePrq6TNNqB8q8gPNBoC3/qalcBlo3eY2sRFUDtVnROUJ5dYyqAXFgk3XIqXDe/86W2ofsu5SNvLsSYbF1Oj9waw79VQpKwyVzKb5nIpgIFXOb0tEkC0G9oE0wV+E2ziF6sKX6AzvzXALd96Nj30K5jYjnSbAf9PMyczDA1OV3CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764713564; c=relaxed/simple;
	bh=DFk6jkyVaJz5NFepFvphO0aBbU2Yqr0IduPDe5gjTNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UA/xRBU3y1gIpIQN/o9uW4y+qYoP9AXcqH3f3+j2+qXgcOiyzj+MfTo6dK3UyGlA54ZOxnTaRwuZ2j7WlzQSW3LqMMj0JfHVU9aQWBikVrBPvbo2WjwZTzX4CUNa9+MlKM5UY1VVm5xWLeroIg6wTcePYMo3Nl4u78GUPAyFx30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W6KXZfCD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FDZTYanC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764713561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5HR6Gpebm8idLOLOm3Ct3v+B3+RBobPQirAADkyH+HU=;
	b=W6KXZfCDzd8MhPn7I9uhkdWzLKdenwaHZdc0uBVdINrw8cs7GkIyYq2ASn2RKGZw61m/kT
	8KunMVcNkszPC2HioGjn2Fr2+3xBBwid9R7wZQgF5p1cUPzh7muMlGKFUhU7qPfry246AU
	RZwTPsQ0GxT7N6rVPxznQrtdp4gQ08s=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-61h18LocPj-b88BiUFEp5A-1; Tue, 02 Dec 2025 17:12:39 -0500
X-MC-Unique: 61h18LocPj-b88BiUFEp5A-1
X-Mimecast-MFC-AGG-ID: 61h18LocPj-b88BiUFEp5A_1764713558
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4501b05fcf1so2181981b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 14:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764713558; x=1765318358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5HR6Gpebm8idLOLOm3Ct3v+B3+RBobPQirAADkyH+HU=;
        b=FDZTYanCDdrTcrGa/dubK+uBTa0VYusXpfjzyXRsknAzsMxL5GqcIpqMUrrcrhyzZE
         XwtTYfDgKZy1RNDGVziJY/1fx/3NVba2IgJnS/nj9Ynw8qqViXuUWoUqe3Ws11sMJDg/
         F8uZLQAwcfn4twwr2tQCxPZCn9t0bhj+59UX2c3dOodCsRROsRIef5nHeyIoCN/nRp/V
         Y1PIOefTbuyeJsyIUhsn2KVa+8XRgfvPeD1vHL8zNxThcFr/BxAv5kR8vl0n9YOBWJL3
         5BQOkICvQ7JERBLiaCf8Cd4qee+tzjSUUJpPNNg/ePjW4ckbiOawBRFcKOrRnHallr0A
         4QOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764713558; x=1765318358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5HR6Gpebm8idLOLOm3Ct3v+B3+RBobPQirAADkyH+HU=;
        b=OVuB0kdBoLaz2WqKNHRaIbRnsOtqL7g2Lf1nd6c65nI+oZGax77KibHB0y+Fh+AizA
         Y9XQ5rAH9+i+EfmPtvADn2QjeFH8BndgcoD23a8fJqA0MvQVIkoVBJ7cm5P96PpOeySF
         dazJqjA/ubG70BaxRcVB3+wtaQvdkKK2zrhSuM/CmeZITiiNa+Ucd2dYJq8M+Ck3d1bv
         uhoA30fJYMW/FD9bxLsiqnRYVnCBSYkkZ/CMdEW0TbIr9rSfkK219VcGZZQFSfKDFaOX
         Kso/M4t3c+InVcOlvEb9+SCdHmnjRsD6sv49AQIM4Pl7L45ENTt39LVE+JYBkOz8cy1z
         pVRg==
X-Forwarded-Encrypted: i=1; AJvYcCWdintw+OKwzJAUZ1KmH+6543zP3sazV9McyrL+E6MQVpRu1HnV8TYoqwJ31LORaRfMVZkxkqfWeHI9lkfs@vger.kernel.org
X-Gm-Message-State: AOJu0Yw644eo1M3x0d4TKZRH7oyWRlp/xFurkWujGZ5tl4xoC+H1/4ZV
	FxtDV8QNfAocTJVya+twFcOepwvNzbyqzaLN3k5lV23fPY+sHvywkBAqh2WnsE1b7W+DW5KdoZM
	0o3jYL2zGpzXMAz04Ddy5Ys00FJ2xsbNUIPLCyLSI8P7cKnKg8l3dafxan/9FBQOjzcY=
X-Gm-Gg: ASbGnctH/FSbtlU4nnAicblxovYh4Eou12wcbXxepSkeIMUat1XQiD0iFGY/IqDYdGc
	zZAPc/5jgpQtZ3v1Z4yNSl/C+TYmgQQU3buPg+rKUyBCxagh3focSx3TFHH0fSPc2lQnsEKgd/+
	4xeGG/lHxR7VLLqk+aKPyAaAkDe/vcrk6akXF2d1P5Ag46GDfwGIbyPOker9RbC0cYlYy4IDaCe
	IWWdNG4A/yddeS3fgKeJHtQoClRTySVSLzhRwgHK0lV1Q3s70nGzIoEUUYU8N1+w4R1obzxAJDV
	jadccQcgOD1SJsM9cnuUjjzK4O0DZScSly4bNHQr0LXWYw9awdxxfxc3Wx4l45ALS/hQPRPqj91
	hOxEFcBmMKLtO1rBaWWDOAXVFdIjjHCOaKmywlrZT5pi8aoVopVY=
X-Received: by 2002:a05:6808:1a19:b0:44d:af21:bf34 with SMTP id 5614622812f47-4511294e751mr22168653b6e.2.1764713558427;
        Tue, 02 Dec 2025 14:12:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEz/KymsEP/xs/W+jYnCoHFuQlJpYUDhkDP/FaJqgHwkUGYC7jbKunrQ9FAPvoBzltjcKzjZg==
X-Received: by 2002:a05:6808:1a19:b0:44d:af21:bf34 with SMTP id 5614622812f47-4511294e751mr22168636b6e.2.1764713558085;
        Tue, 02 Dec 2025 14:12:38 -0800 (PST)
Received: from [10.0.0.82] (97-127-77-149.mpls.qwest.net. [97.127.77.149])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-453169fa988sm6331014b6e.9.2025.12.02.14.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 14:12:37 -0800 (PST)
Message-ID: <13d4a021-908e-4dff-874d-d4cbdcdd71d4@redhat.com>
Date: Tue, 2 Dec 2025 16:12:36 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/4] 9p: convert to the new mount API
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Remi Pommarel <repk@triplefau.lt>, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com, eadavis@qq.com
References: <20251010214222.1347785-1-sandeen@redhat.com>
 <20251010214222.1347785-5-sandeen@redhat.com>
 <aOzT2-e8_p92WfP-@codewreck.org> <aSdgDkbVe5xAT291@pilgrim>
 <aSeCdir21ZkvXJxr@codewreck.org>
 <b7b203c4-6e4b-4eeb-a23e-e6314342f288@redhat.com>
 <aS47OBYiF1PBeVSv@codewreck.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <aS47OBYiF1PBeVSv@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/1/25 7:04 PM, Dominique Martinet wrote:
> Eric Sandeen wrote on Mon, Dec 01, 2025 at 04:36:58PM -0600:
>> I suppose it would be a terrible hack to just extend the enum to include
>> hexadecimal "strings" like this, right.... ;)
> 
> Yeah, that might work for all intent and purposes but we'll get someone
> who mounted with cache=0x3 next... :)
> 
>> I think the right approach would be to just reinstate get_cache_mode() to
>> do open-coded parsing as before, and get rid of the enum for the cache
>> option.
> 
> This sounds good to me!
> 
>> Would you like me to send a patch 5/4, or an updated 4/4 to implement this,
>> or would you rather do it yourself if you think you have a better chance
>> of getting it right than I do?
> 
> No strong feeling either way but I think a 5/4 would be better to
> clarify why we do this -- I could probably do it as well but I'd
> definietly appreciate if you could do it (and I'll just have to make
> time to test at the end!)

Working on this, but something that confuses me about the current
(not for-next) code:

If I mount with "cache=loose" I see this in /proc/mounts:

127.0.0.1 /mnt 9p rw,relatime,uname=fsgqa,aname=/tmp/9,cache=f,access=user,trans=tcp 0 0

note the "cache=f" thanks to show_options printing "cache=%x"

"mount -o cache=f" is rejected, though, because "f" is not a parseable
number.

Shouldn't it be printing "cache=0xf" instead of "cache=f?"

(for some reason, though, in my test "remount -o,ro" does still work even with
"cache=f" in /proc/mounts but that seems to be a side effect of mount.9p trying
to use the new mount API when it shouldn't, or ...???)

I'll send my fix-up patch with a (maybe?) extra bugfix of printing
"cache=0x%x" in show_options, and you can see what you think... it could
be moved into a pure bugfix patch first if you agree.

thanks,
-Eric


