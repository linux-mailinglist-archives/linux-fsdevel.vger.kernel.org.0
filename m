Return-Path: <linux-fsdevel+bounces-31243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8CC9935BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 20:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71280B22157
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 18:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072CD1DDC14;
	Mon,  7 Oct 2024 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="E/3iwE+R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B572715853D
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 18:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728324596; cv=none; b=rBRYbRfXG4uJiEWdCZLkGgi+XE0UzbveZ5wltLevT6lMH3myLlZ43H2wf1Jaw0TLaSZ76XBFCsioJB67D+j2Vm+6ou9atoh2YbBhKsmI/d4ETeMfRrAv9mGTQlTYCenYhfBNlpKjkC59GQemjshbBgUudkdyNW1N8kGkR82BI60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728324596; c=relaxed/simple;
	bh=zLIMppPrugMzT25m7sk/+p2h9l3KxnUIurhtYqBnXRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQR4i2ATIbXKb3T1WW+vbn60iBsPNa9zyNXN+pxIH31PTgPc5KWyRaWBhtit0tPY74f0Ck/NQkKAxfJ6pdgmUi4lXZ0yUlhq9YN/2t7tx8BBJb2CIgUyEWoomzinvkEIfjx+IjnvYMIvwhEuFwDFbJw4IgYHlHa1pVcGAlAnEVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=E/3iwE+R; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-8349389f9b8so279696839f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 11:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728324593; x=1728929393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKx2q0E55QyK3Ag9/pVGGc/umM/e0PybS3c+2amWNpU=;
        b=E/3iwE+RetvIoLzF5R4gvyTNMl7iQnHh2A8/K/bBz/yQRlPuB0n+05LluR5LJsXiu+
         kK/4UFYOT7f4mqcisOZqQdmHH1dOJ3W3Yw5LeJTXfF+TFdwxb7D2e8O4nugRfNBlp0Ss
         kTzlvQr0RkDvCTgfwv6a/dftZct0c2YnWSBQyuw+0/e9l3fKFhXEzhJDVBxvkhML3fgh
         eQk+ZfkCg4IjBTG6syxFA/YO8jhBTBmM6kLvq0y56xW/STSRrwkpkBCqz9f0v+GQbt54
         QiARhKJxR2jI9qq5ZolALrqhxLL75gVUyCAb1CBl8hmT47LUldRH6SvzK+DgfwIu+umW
         4i6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728324593; x=1728929393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKx2q0E55QyK3Ag9/pVGGc/umM/e0PybS3c+2amWNpU=;
        b=NOZtzyBFc0zpC+jpeSMhjSlZJAyWj65hd6aRbIo6JOMkXu2IPmaj5xTfKOMZljgTVo
         RRxHBMrPxxLHY5ACtsyTcrhAbNsMQhFAaskEyjD35I0ikuYZEoD4JPPU1abRcqLKZ8IZ
         N1fY/j0XP3t8MZcT/LUA4aIp2VGDfY+7Z4/zHV1xt0LqbyKmadvqK76FAD5fjxvyRDAj
         ++w8uVXYr0qvA7/E7kIzX516MwP4gPIMVNKsKS9FpTenA93BWoE1yL9JJ889hQoEtxBi
         r593OjJ3GLaGVwr/8dimYnlh/ndeNY3jDfGnr542s8RCk4rI2l20D5V828pm6Ef0qkBd
         G9yQ==
X-Gm-Message-State: AOJu0Yxo7ItA5+p17HQzY7VdTVZ+dfPwazpqUgfhP0/1v4mfHIOYTrWt
	hyO/ypsKLhOWglNv9ORRZZWuIKKSY0OzIOJzPz43AXmmO+6mIOVrta4TJ790dnE=
X-Google-Smtp-Source: AGHT+IHhFJn70IIXJQ+W0tL8QD/Au4FOw48FkcEptLvLQrXMCQ3Y6tnncnEvSJ9XKQXcDAtK7gF63A==
X-Received: by 2002:a05:6602:6b0c:b0:832:4000:fc63 with SMTP id ca18e2360f4ac-834f7d9a65fmr1114094639f.16.1728324592865;
        Mon, 07 Oct 2024 11:09:52 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83503a92f7bsm133620839f.18.2024.10.07.11.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 11:09:52 -0700 (PDT)
Message-ID: <69e696d7-637a-4cb2-912c-6066d23afd72@kernel.dk>
Date: Mon, 7 Oct 2024 12:09:51 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] replace do_setxattr() with saner helpers.
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
 io-uring@vger.kernel.org, cgzones@googlemail.com
References: <20241002011011.GB4017910@ZenIV>
 <20241002012230.4174585-1-viro@zeniv.linux.org.uk>
 <20241002012230.4174585-5-viro@zeniv.linux.org.uk>
 <12334e67-80a6-4509-9826-90d16483835e@kernel.dk>
 <20241002020857.GC4017910@ZenIV>
 <a2730d25-3998-4d76-8c12-dde7ce1be719@kernel.dk>
 <20241002211939.GE4017910@ZenIV>
 <d69b33f9-31a0-4c70-baf2-a72dc28139e0@kernel.dk>
 <20241006052859.GD4017910@ZenIV>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241006052859.GD4017910@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/5/24 11:28 PM, Al Viro wrote:
> On Wed, Oct 02, 2024 at 04:55:22PM -0600, Jens Axboe wrote:
> 
>> The reason I liked the putname() is that it's unconditional - the caller
>> can rely on it being put, regardless of the return value. So I'd say the
>> same should be true for ctx.kvalue, and if not, the caller should still
>> free it. That's the path of least surprise - no leak for the least
>> tested error path, and no UAF in the success case.
> 
> The problem with ctx.kvalue is that on the syscall side there's a case when
> we do not call either file_setxattr() or filename_setxattr() - -EBADF.
> And it's a lot more convenient to do setxattr_copy() first, so we end
> up with a lovely landmine:
>         filename = getname_xattr(pathname, at_flags);
> 	if (!filename) {
> 		CLASS(fd, f)(dfd);
> 		if (fd_empty(f)) {
> 			kfree(ctx.kvalue); // lest we leak
> 			return -EBADF;
> 		}
> 		return file_setxattr(fd_file(f), &ctx);
> 	}
> 	return filename_setxattr(dfd, filename, lookup_flags, &ctx);
> 
> That's asking for trouble, obviously.  So I think we ought to consume
> filename (in filename_...()) case, leave struct file reference alone
> (we have to - it might have been borrowed rather than cloned) and leave
> ->kvalue unchanged.  Yes, it ends up being more clumsy, but at least
> it's consistent between the cases...
> 
> As for consuming filename...  On the syscall side it allows things like
> SYSCALL_DEFINE3(mkdirat, int, dfd, const char __user *, pathname, umode_t, mode)
> {
>         return do_mkdirat(dfd, getname(pathname), mode);
> }  
> which is better than the alternatives - I mean, that's
> SYSCALL_DEFINE3(mkdirat, int, dfd, const char __user *, pathname, umode_t, mode)
> {
> 	struct filename *filename = getname(pathname);
> 	int res = do_mkdirat(dfd, filename, mode);
> 	putname(filename);
> 	return ret;
> }  
> or 
> SYSCALL_DEFINE3(mkdirat, int, dfd, const char __user *, pathname, umode_t, mode)
> {
> 	struct filename *filename __free(putname) = getname(pathname);
> 	return do_mkdirat(dfd, filename, mode);
> }
> and both stink, if for different reasons ;-/  Having those things consume
> (unconditionally) is better, IMO.
> 
> Hell knows; let's go with what I described above for now and see where
> it leads when more such helpers are regularized.

Sounds like a plan.

>>> Questions on the io_uring side:
>>> 	* you usually reject REQ_F_FIXED_FILE for ...at() at ->prep() time.
>>> Fine, but... what's the point of doing that in IORING_OP_FGETXATTR case?
>>> Or IORING_OP_GETXATTR, for that matter, since you pass AT_FDCWD anyway...
>>> Am I missing something subtle here?
>>
>> Right, it could be allowed for fgetxattr on the io_uring side. Anything
>> that passes in a struct file would be fair game to enable it on.
>> Anything that passes in a path (eg a non-fd value), it obviously
>> wouldn't make sense anyway.
> 
> OK, done and force-pushed into #work.xattr.

I just checked, and while I think this is fine to do for the 'fd' taking
{s,g}etxattr, I don't think the path taking ones should allow
IOSQE_FIXED_FILE being set. It's nonsensical, as they don't take a file
descriptor. So I'd prefer if we kept it to just the f* variants. I can
just make this tweak in my io_uring 6.12 branch and get it upstream this
week, that'll take it out of your hands.

What do you think?

-- 
Jens Axboe

