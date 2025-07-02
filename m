Return-Path: <linux-fsdevel+bounces-53609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D0FAF0F76
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 11:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E984440AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 09:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E946C242D6A;
	Wed,  2 Jul 2025 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b90bYBqD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABA4219A8D;
	Wed,  2 Jul 2025 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751447643; cv=none; b=gXE9WJ8QlPHGGguZFeTHIYailiaVLxgflva+T0urd5DfjmjsdcbCeNLk2/lz4s/CjqoEIxn1OBjomcgs7sVtwaZ5VtJJD1cwAdNmE7WKXf/8I+ybjy14gByMmA/hwuPF3qiGGjvBLx2o65nrZqCkBcb0p0sdjJhdTKj1vq0xvnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751447643; c=relaxed/simple;
	bh=arp/RXJFijFrUN/wQbLbSmWxuyiKJielKbqEREc+Y6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ol2jHyHFefd1KDiCciCbGw+4/t2ig1nMLAMeluIeg2AdQ8/XGQzAryF9mTD9m5H8MZqbwMG9GmKrm3X4HUg77BvrjmHq29owajkEjx3b59JxJXiFhG21FkIgyLvtET9RC6sTFzfNL1rW3xBYi3sqOYs/v99RVaRYE3/9srhkHVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b90bYBqD; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60c5b7cae8bso7024594a12.1;
        Wed, 02 Jul 2025 02:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751447640; x=1752052440; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YOnKL2iySZqX8VVh+L223ZxSRCRPq10Nr2PZwBL+7sg=;
        b=b90bYBqDrbJrzU3s3ghZlttO3/Zv+ncaWuah9dZLZUAWFNNfVGDoTNtIRlv39Cf0pX
         tCaGaXmi/r5ON9Z5j3Fn+SoC+Dn0Xyb8oNjIk9Auep1VYxQgupMfCKHDqxigomHkhmwm
         5MGopEKNMF7nzSIEi1fW+y/A+S+XvevZiV0mtBf/4a/60ei9MCJ1+qyHYY/DB3HZCGyw
         rHUQCEQwLH0CmPJVFeD+SYAztkugfgAQoyQHUPn/IC0s8RVtW3RxlVWixLiMrYFFSU3v
         aP9aEPEdYvwD4esDuZH2H6RGzPHKpgW2Y1sEW1mEdzDMHU8vdTtp5NdE0WwHe2WXngyQ
         E4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751447640; x=1752052440;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YOnKL2iySZqX8VVh+L223ZxSRCRPq10Nr2PZwBL+7sg=;
        b=Meh2qccrN75Psdg8tQKvBVFn/EE0hibpNSg6vPRlQ9nyt0pITdrAWzlOeoQQeZrNfU
         JGNyL3qSS0Xwf240W8ZW1K2lPCoiuUM3igURkcpED00vjLUfQRC0CvD6+falUp/cYswT
         GXDb8TJqu1xglM0acUefSajQ4nNcm1ZwZQjHNHNC/g5fOEZzKQgM0I6iTetwRa6cXd30
         Rbdai8rBIwk7nKUrJWXQYLJI8aRhI+Hz1FbYww5ThHPoJQ6xMdCWm5YAeBeJkjcPpZnc
         iuwoUFAGjLHTsPWKOI61QzXqFziuTNZY2U+V6HDFWtlhaph0m8aFsx5+uItWibfpRJKj
         CcYA==
X-Forwarded-Encrypted: i=1; AJvYcCUw4zEoPjHzrMXRKgiFkVCWOGDqCESVj2C4sk5vQCFdeUArs53i7gfDsAgrgD8TTAf0Mo3w01Lt/FSN6xYv6Q==@vger.kernel.org, AJvYcCV8o9/QKj23j9ONlAi58V3TV6OCQpg1QqIUAeJnOPhNVX2am2a90iIYjTUraZgX0Ooqf/KRhXI+2xe3@vger.kernel.org, AJvYcCViAhHhrL4Y6OlxvjAh71MMY5h6K6XFLfjyzuyZxqsMa5Z7w486tYr7/EWRJXqKsxMEkfWJ/TFlrPM=@vger.kernel.org, AJvYcCWDnLP2Auo2dC6CEPbMA9O/TeH5bD3BvmW9B7HP7gcoZtduAhuQjy5IRnXnayG0mS2VWvNLKVvW8Q==@vger.kernel.org, AJvYcCWVNlHl7mM7UN+YZT+skqUg8fvjB2Rq5NtcsutyxERRwIxMdVOEPckQIF2/VR9CwxoU0IYJG8Bogv/ezNCW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9eiT/JP11azitllBg1w+YkG2PVxV0EPwrTIufMS3ACOMF2Hr/
	AKVLNcLmZEL6TjI5t1fPeHiOtwjkE0XlGEU2RTm+M6D6wcOpw+62qpR3acvQjDPEwgiW0+0reeu
	8oQaq4oGqN1fNqI4DY4USwDTydTJ8kAQ=
X-Gm-Gg: ASbGnctg5wiXqaUbbJPpc/bjndt1NN1bb7DALM2h+UUwaW3lUYwEABSMhH0vCJnDdLm
	8SszhGfO8t+cgmZspNG1ie4fX504GbBPxSdITP94Mfow+UBaeo/3g9JgS567gDMPN1CC7qbcXg1
	IjgXU8RpMJanE+OU4YqO+siPsxnRp3RG5MZYMBDLGPSbGoZPUgCY5XqQ==
X-Google-Smtp-Source: AGHT+IGlk8ck2yGJiSvYpbNFUVRsx8Y0aQIabBLOLnPDFVgvwubtNKreUJ+vATAAMAwvHsiBczX2MScCqWUycc9KxFQ=
X-Received: by 2002:a17:907:94c3:b0:add:ed3a:e792 with SMTP id
 a640c23a62f3a-ae3c2da9581mr192429266b.47.1751447639461; Wed, 02 Jul 2025
 02:13:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-6-c4e3bc35227b@kernel.org> <20250701-bauzaun-riskieren-595464ef81c4@brauner>
In-Reply-To: <20250701-bauzaun-riskieren-595464ef81c4@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 2 Jul 2025 11:13:48 +0200
X-Gm-Features: Ac12FXwQ_wZQ_QCTo4zCnlXIsD2UE88jy3YPrf_EnnTl4HhmrEsOq9hi_uihdY0
Message-ID: <CAOQ4uxjfs=YJmgj0CfJ1NxuPaHgh4B6Vou6jG-WBoi1hGdSDdQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] fs: introduce file_getattr and file_setattr syscalls
To: Christian Brauner <brauner@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Jan Kara <jack@suse.cz>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, selinux@vger.kernel.org, 
	Andrey Albershteyn <aalbersh@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> > +/*
> > + * Variable size structure for file_[sg]et_attr().
> > + *
> > + * Note. This is alternative to the structure 'struct fileattr'/'struct fsxattr'.
> > + * As this structure is passed to/from userspace with its size, this can
> > + * be versioned based on the size.
> > + */
> > +struct fsx_fileattr {
> > +     __u32   fsx_xflags;     /* xflags field value (get/set) */
> > +     __u32   fsx_extsize;    /* extsize field value (get/set)*/
> > +     __u32   fsx_nextents;   /* nextents field value (get)   */
> > +     __u32   fsx_projid;     /* project identifier (get/set) */
> > +     __u32   fsx_cowextsize; /* CoW extsize field value (get/set) */
>
> This misses a:
>
> __u32 __spare;
>
> so there's no holes in the struct. :)

Adding __spare and not verifying that it is zeroed gets us to the
point that we are not able to replace __spare with a real field later.

I suggest to resolve this hole as Darrick and Pali suggested by making it
__u64 fsx_xflags

w.r.t Darrick's comment, I kind of like it that the name for the UAPI
struct (fsxattr)
differs from the name of the kernel internal representation (fileattr), but
I agree that fsx_fileattr does not give a good hint on what it is.

I think that renaming struct fsx_fileattr to struct fsxattr64 along
with changing the
width of fsx_xflags will help reduce the confusion of users.

What do you guys think?

Thanks,
Amir.

