Return-Path: <linux-fsdevel+bounces-49659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A11AC05FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 09:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1AC57B07FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 07:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BF022259D;
	Thu, 22 May 2025 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/ytTYbZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0765221DB7;
	Thu, 22 May 2025 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747899726; cv=none; b=NtsWL27go23vAMYseYRr+Vaem/KR6AxVillBgkcju7UOdXfIIe/6uLv0ceDkQHBMQEZgQs26wLiFFL6aze8PlALwwuqLcB20RDm2FPm0NsI3GLSsuOOHc/W/aSk6TDN6rf4VLQcmodi/kQcMcEtwLa6yp2oRayhiuUfnTAQFY5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747899726; c=relaxed/simple;
	bh=lkvjKzIC7qOitL/n2B/DJjcIj5y92x8YUVwSHPnhL0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyTjXjpe4YLmQNCG0bPWd6EuFabTKt6oUjd+hxaHgU803JuhXdPHakDkjmqYo4JYhOiDl2l7qDIOkgvvPV+UyOI8h2tJ4Xc9tNwSb5TH6W7Ah8NBhBBmHVyikMBdhtP3opu+KiaRZxw+uDgQ5eeXZeP7d9c6wqlTPxJSsRN1qZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/ytTYbZ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac34257295dso1211433166b.2;
        Thu, 22 May 2025 00:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747899723; x=1748504523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G73sTlL/tYhn+0AKdLvnBgwwZcYeBuZlhw+dyfkbkXU=;
        b=N/ytTYbZJ2bwXbyql0vnEeE7xDdGZ7hciCqKaq3tJiZXqRfPyNXOvMvAN6If6TUg0t
         9ElGveRk+rBtxwAuHns12RRvCSjsQmHZjI02ap+eg2e9blg2ubMJBrH4QtihjtWCWHK7
         X13CbsFbsRUEkG8Acpp7T1X8Y0aUnyoik4JNM4BPZWc+aoGhfOhIupLpb8SnvS0XxppN
         JMKDAL5B3FELq4jCBfpDiINwy6bWZmKtp+udVc1ZMazmhSVbfTLEBbrELBbeFMtnmivR
         iNeqFG2KsVu0SvH6Dv2TBDnzCiNZMItAv9QOQ+ffOPjRzF1mu8U0q09M6/IDsaQoDr4o
         rzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747899723; x=1748504523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G73sTlL/tYhn+0AKdLvnBgwwZcYeBuZlhw+dyfkbkXU=;
        b=mNQSRDXldsVkwcEN+DpL8dpDbNdIdBL0dZjUuJ4A7OCB0mv7PuhZajBfE/f9Gn5TH4
         Aq9/AGKCxfkvaFz8nEY9cVvqerXZZTOEjEm9ce6qUAzXsg8Bu1dCWN3JtzP4QzOiTq9X
         QMDOdxXE3lfUjniu5Ob2hIfTPurMNDnhlIss0RTrd/VHKWxWqYvIFoOodysPtTVBl/Ct
         r//qgcoeaFACxU7obdc/oz6kLF4XIDCFtQvMktfTP3Do9SKdUBrncYkXVBiuVYabjC3r
         duSKHZAfUjSLE80t3qEyujimpisYwdKOylnP+gj6ENgv4CxQN2KSQsOCYvkowr6oD2JQ
         LTAw==
X-Forwarded-Encrypted: i=1; AJvYcCV0byFlaVc4YQxF/Nn2mxtgHxnlKFRUMHj4a7gvqA3p/O7pIPS8EVzgZQH0ouVR2QCjfxtkzEeSWZ/F0lia@vger.kernel.org, AJvYcCVknQ1UsuW3To8rI1LGals7jbHAZmZfFpPsZ4OGJarecOhDFMDdr8YkfuB0VHxOzBworCSBMBTi06L8yLa6@vger.kernel.org
X-Gm-Message-State: AOJu0YyYeaCq5QgMNs8N6dUhOou+8q5QkhPLMxUeue5s+uGUhvpWTM3E
	hd7gIEqt1e6XLNouHyXdXx+Dej6TcnbUNOHQeQPyFU32QhboPg9wCmxPW9XjXe3up+ZsUewh9zr
	IQ513820Zi/JfTVP2MaT4CNRWFtG/w7Q=
X-Gm-Gg: ASbGncsivEYvxCw/L1VKLRrocGCtGx1jgkHA6+tjOnn/zHbENI+HuKHXyQ18C9khOOx
	2Fe9oRt12WTIWMNjf7OlKwhJP5Be6TACPzR59dM9izXzIaCcnoexBGe6woKP64t1g2WF0/1jKfx
	0yyE8tmGOuEC69Pr4mYrILR3UbLbOnyFJz
X-Google-Smtp-Source: AGHT+IF3rREPIXdGv5y+4DDa1oDqHyB07OzP5ZIXIrNTCidXl4CNpmc1XGR3rM9RIBhSp5rfICER71ltoMoKfIYul+c=
X-Received: by 2002:a17:907:d643:b0:ad5:6b8a:a0a6 with SMTP id
 a640c23a62f3a-ad56b8aa760mr1542109266b.58.1747899722495; Thu, 22 May 2025
 00:42:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516032147.3350598-1-wozizhi@huaweicloud.com> <f6a9c6ef-1fd8-41d2-8f6a-396b6b191f97@huaweicloud.com>
In-Reply-To: <f6a9c6ef-1fd8-41d2-8f6a-396b6b191f97@huaweicloud.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 22 May 2025 09:41:51 +0200
X-Gm-Features: AX0GCFtRLD7IqffWX8NGU_n25kFEmyDHBvNQ9xmVO_dtMcu1Bm21gLnQ0LMX250
Message-ID: <CAOQ4uxiT=v9JKS39ii-em0XFNkWyskW_Ed3kxS5PE5Q2Rs+NMQ@mail.gmail.com>
Subject: Re: [PATCH] fs: Rename the parameter of mnt_get_write_access()
To: Zizhi Wo <wozizhi@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 3:02=E2=80=AFAM Zizhi Wo <wozizhi@huaweicloud.com> =
wrote:
>
> Hello!
>
> There are currently two possible approaches to this patch.
> The first is to directly change the declaration, which would be
> straightforward and involve minimal modifications.
>
> However, per Al Viro's suggestion =E2=80=94 that "mnt for vfsmount, m for=
 mount"
> is an informal convention. This is in line with what the current
> patch does, although I understand Jan Kara might feel that the scope of
> the changes is a bit large.
>
> I would appreciate any suggestions or guidance on how to proceed. So
> friendly ping...

Hi Zizhi,

I guess you are not familiar with kernel lingo so I will translate:
"...so I'd say go for it if there had been any change in the function
in question.  Same as with coding style, really..."

It means that your change is correct, but maintainers are
not interested in taking "style only" changes because it
creates undesired git history noise called "churn".

Should anyone be going to make logic changes in
mnt_get_write_access() in the future, the style change
can be applied along in the same patch.

One observation I have is -
If this was the only case that deviates from the standard
the change might have been justified.
From a quick grep, I see that the reality in the code is very far
from this standard.

FWIW, wholeheartedly I agree that the ambiguity of the type of
an 'mnt' arg is annoying, but IMO 'm' is not making that very clear.
To me, 'mount' arg is very clear when it appears in the code.

Thanks,
Amir.

