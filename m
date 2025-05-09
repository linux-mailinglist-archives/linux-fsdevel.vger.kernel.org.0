Return-Path: <linux-fsdevel+bounces-48630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 085F6AB19BD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 18:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3028B7A6601
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 16:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6C8230269;
	Fri,  9 May 2025 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="F2f8Yo1t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F471182BC
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806765; cv=none; b=PJA4ppKiu9bNpPgv/RjitO6ahGSIrzf1mlzqH7pncfRA4s+WtChqWzJc49vffEBZbWJ1lHMEYmQa9kslZLMd6Bby8Kwe+qvb04KaKvZt3+rRpBqhn0CjdKDxtihE+1ZzqAqJfDtyDzZtlljoUm1Oc80Kzi+cEnqCkJOkflkYZWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806765; c=relaxed/simple;
	bh=hpCV+wZEFfyUrH2luJ3W7iXAJRcOLdplJ9Cn2k9I0xU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0V1TuIiyylfQx1o5ySM1TmNWhL4Bbv4Av75X9u9Smntk3GGO4Zdg4I79CM8z+NSmo7IAfjHS1GzJZOSwd0pJKcT7dOxKQ6evvQFnMEqZmPj88w4+WNPk/sGHQc0UddyaAe0zi7UD5RhJMfs/rnx+704Wy6v3z3Kh++dNnCFQkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=F2f8Yo1t; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-476977848c4so29432411cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 09:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1746806762; x=1747411562; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oYYNA5Y8vNqJQ6rm+4NydDIpOhAL1lR7o58DtBKay5I=;
        b=F2f8Yo1tRJbvxsM8epr+54d8miICSZbQKEDfIMmoA7bnPqKllsF38CPMKjlyC/nJuv
         oQ0elwF//BoMs997UX+JAkjsfsw7YdyCiihidPVAkPzPq77d/kr3X4Ff+yZk8ApQdAem
         DGYstaVZSo9dWoaqWqg6j3zwTbCX5/Ggq/vSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746806762; x=1747411562;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oYYNA5Y8vNqJQ6rm+4NydDIpOhAL1lR7o58DtBKay5I=;
        b=HNTezK1l3ptM5RxqzC3MQurSMIHTO9FunsAb7nKgoFcwvO0HIg8RVGOe3ENmt5zRDN
         NC3IXoO/ah2kO+pANalaagce68iCKDu+QrBKH59f1JviW4e6Xb0GvV3aOVeWOt04XCq1
         fJf4kkw8HoANVju6bB2sHRyJJBkzfK99PEbl+hy2+L9XIli1SPnSijnahWbAd6xXdXxS
         FVdMuqLqVt55iwhTLa7lnwcrpxZfJDoLnx78mUXXzy3epObgx5WmPCoqTa1w8IDst+FV
         MyC+QzuFPFKgMTBtpYjlpHaaS5nE5cz7IYjPv+ViO2RQq99lGUiHiB4IiqGH6yhxhv73
         kE8w==
X-Forwarded-Encrypted: i=1; AJvYcCX4l8vP4DrKjPiJ2KBd4kvvyBeqWN/khwOcr9mxKOZV0YbZbgCp8cfA1A0ynBkSc819O7VCRtpOPFVjAUF+@vger.kernel.org
X-Gm-Message-State: AOJu0YxzJuS7JM25YeqTKn/tWuw0Q64dtDKWFtdbFRO1pq2vNJ6zQOP3
	mDyL5kBJG5OMWBSNeJZQ35OgKYpCiCV9PCtZnrW3v5hIcqzX1KUkw92IAhAWo3j5kXBvmAXTrd4
	32gH2OqBGk87eC7Qb3BOZwCWtNXfNZWIzex14rA==
X-Gm-Gg: ASbGncvl8SWqZl9EdZjC/SyfCaLmV2uEsYgicUsO7E7E5KCs7pEXzxd84jSkCTpxvqo
	AisA1vUOa4WV9aGjxKUiYgzvvhb6F9ZdLJPqkvDEtGBjRktUqI4WE/abg5LFzMpxlkQ6fq98Ku5
	nrcJCE711gU8N0PpSCTAHAeJWs
X-Google-Smtp-Source: AGHT+IEHiCPo7BQcQQ4V4LveV5lpWeKGx3e8fLIkl1enh0LnY61QSyytR7SVE8FYAnVezA0GudCivibZIeDxbD/YCGE=
X-Received: by 2002:a05:622a:cf:b0:477:5d12:aac5 with SMTP id
 d75a77b69052e-494527f3e64mr70459981cf.35.1746806762213; Fri, 09 May 2025
 09:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com> <20250509-fusectl-backing-files-v3-3-393761f9b683@uniontech.com>
In-Reply-To: <20250509-fusectl-backing-files-v3-3-393761f9b683@uniontech.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 9 May 2025 18:05:51 +0200
X-Gm-Features: ATxdqUG0rx57jgc06Deca5uke9zj1A-9nRy55YLo1ywJ9DGv7Z_yGO2Q0eAogAk
Message-ID: <CAJfpegs-tY8oebgc6YubXt-NCWA+gWEvu0yen0sAT8drM9Dghg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fs: fuse: add more information to fdinfo
To: chenlinxuan@uniontech.com
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 May 2025 at 08:34, Chen Linxuan via B4 Relay
<devnull+chenlinxuan.uniontech.com@kernel.org> wrote:

>  static const struct file_operations fuse_file_operations = {
>         .llseek         = fuse_file_llseek,
>         .read_iter      = fuse_file_read_iter,
> @@ -3411,6 +3428,9 @@ static const struct file_operations fuse_file_operations = {
>         .poll           = fuse_file_poll,
>         .fallocate      = fuse_file_fallocate,
>         .copy_file_range = fuse_copy_file_range,
> +#ifdef CONFIG_PROC_FS
> +       .show_fdinfo    = fuse_file_show_fdinfo,
> +#endif
>  };

The backing file mechanism is an internal implementation detail of
fuse and does not need to be displayed in the fuse file's fdinfo.
Currently we can only have one backing file per fuse file, but that
may well change in the future, as well as other details like offset
into the backing file (think FS_IOC_FIEMAP).

So NAK unless there's a very good use case for this.

Adding fdinfo for the /dev/fuse file is encouraged, it would be good
to be able to retrieve the connection number from the dev fd.

Thanks,
Miklos

