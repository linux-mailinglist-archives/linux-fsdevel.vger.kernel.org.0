Return-Path: <linux-fsdevel+bounces-2981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA34B7EE826
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 21:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1611C20878
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 20:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1214D46442;
	Thu, 16 Nov 2023 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FMF9PAQy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167B7D6A
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 12:12:20 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-28014fed9efso1014549a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 12:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700165539; x=1700770339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QgNHea2v2D3O8dTZ/sAPUHfYW1P6pznus4pS0an/UkI=;
        b=FMF9PAQy+KMNZyywHS3QaMw3KW8iD81ulTzSwGbjpqRp8iAw3Xypg72VqW2SOqEug8
         bAGDeFOaG5eOaSQfujzTpEZ7ABEfEPR99qRCuEkzb1g8qK4ty/SSGh/OWCLHMDKqlKQM
         vHbF7e58xXFbFtovJnodBSinozC+g3kXK74oGiDuypF+xiEp9e4ZZrfU0g8HiPg1BBD0
         JZ7ef6SbeSxoZnMxfEBENhqsx+HIeMdNYkiUvDdZ/AX3uZUZNZ6ZDEyff8CmhO2nD4Dj
         8Kr9x6MepXu4JLi8kSshGAFq1vU/Zh9FmLEnT6iGOOFnc9QzPEvg4Hvvwq5MvJbtgon5
         ydkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700165539; x=1700770339;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgNHea2v2D3O8dTZ/sAPUHfYW1P6pznus4pS0an/UkI=;
        b=ZgJHtNeL5DTcDE/0pfgeffU38bhCHDxbtI5NPdJk0WhmhBu60wGCLdxcpK8t5F5THi
         PUo68+3q+3Qe25slQj030E46DxpNaJrFju46XhXQ1hd+H8JeMl9cGsheOJhz0o5we1Fo
         Rkij89RR1DBRzPd0PYKnhgWrmABPqIXSLCvsPVNkck+UWzpzTj3u03Afu7QKZssnlDHx
         ne88c43U/nsCO5ienmjg6aeCiof575z32LN42rtJh2aVKrf4o+dcm+Aen/JNrzMbktRZ
         N0RZ13i2XA6zfnAxJ6pzUjU+6jZddpvutL3qH2Eu96YDDHVNZaf6WLD+J4Oj28+BrxFN
         mIZA==
X-Gm-Message-State: AOJu0Yy1RhGrLkv15PLBkmmd9PRd8TRtrn/jkytTSSOitPa07hp9J7CT
	C+nv9r6ltbIws4eUmhdGvVDgDw==
X-Google-Smtp-Source: AGHT+IGlTO9JcHdCtKOhihATNGgTtRYC9vKdjkaqj9QXzXbsWQRaGgZTBC22Xdz+4dy/RIkiK9RklA==
X-Received: by 2002:a17:90b:390a:b0:280:48d4:1eb3 with SMTP id ob10-20020a17090b390a00b0028048d41eb3mr15760995pjb.8.1700165539109;
        Thu, 16 Nov 2023 12:12:19 -0800 (PST)
Received: from ?IPV6:2804:1b3:a7c1:4617:716b:3ad5:e6b:26a9? ([2804:1b3:a7c1:4617:716b:3ad5:e6b:26a9])
        by smtp.gmail.com with ESMTPSA id az2-20020a17090b028200b002800b26dbc1sm1940133pjb.32.2023.11.16.12.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 12:12:18 -0800 (PST)
Message-ID: <938766c0-4cee-4363-a089-d5a6b10698d0@linaro.org>
Date: Thu, 16 Nov 2023 17:12:13 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: proposed libc interface and man page for statmount(2)
Content-Language: en-US
To: Miklos Szeredi <miklos@szeredi.hu>, libc-alpha@sourceware.org,
 linux-man <linux-man@vger.kernel.org>, Rich Felker <dalias@libc.org>
Cc: Alejandro Colomar <alx@kernel.org>, Linux API
 <linux-api@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
 David Howells <dhowells@redhat.com>, Christian Brauner
 <christian@brauner.io>, Amir Goldstein <amir73il@gmail.com>,
 Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>
References: <CAJfpegsMahRZBk2d2vRLgO8ao9QUP28BwtfV1HXp5hoTOH6Rvw@mail.gmail.com>
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <CAJfpegsMahRZBk2d2vRLgO8ao9QUP28BwtfV1HXp5hoTOH6Rvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/11/23 12:08, Miklos Szeredi wrote:
> Hi,
> 
> Attaching the proposed man page for the new statmount() syscall.
> 
> It describes a libc interface that is slightly different from the raw
> kernel API.   The differences from the two API's are also described in
> the man page.
> 
> Raw:
> 
>        long syscall(SYS_statmount, const struct mnt_id_req *req,
>                     struct statmount *buf, size_t bufsize, unsigned int flags);
> 
> Libc:
> 
>        struct statmount *statmount(uint64_t mnt_id, uint64_t request_mask,
>                                    struct statmount *buf, size_t bufsize,
>                                    unsigned int flags);
> 
> I propose the libc one to allow automatically allocating the buffer if
> the buf argument is NULL, similar to getcwd(3).

The glibc getcwd implementation allocates a buffer with maximum size
of max(PATH_MAX, getpagesize()) and iff getpwd syscall fails it will 
fallback to a generic implementation that keep calling openat and realloc 
the buf if required.  So for the generic case, it would require malloc
plus realloc (to free some unused memory).

Making statmount similar to getcwd would require something alike, where 
the libc will loop to reallocate the buffer if syscall returns EOVERFLOW.
I am not sure this would be the best interface, come up the initial buffer
size and the increment might be tricky and not ideal for all usage cases.

Maybe setting the initial size depending of request_mask bits, by assuming
a reasonable size for STMT_FS_TYPE and PATH_MAX for STMT_MNT_ROOT/STMT_MNT_POINT
would be a reasonable initial size. 

It also always pull malloc, which is not ideal for the static linking case
since the interface not always return the strings.

