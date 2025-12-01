Return-Path: <linux-fsdevel+bounces-70363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4ECC98AF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 19:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DB274E21C2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 18:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F154338F23;
	Mon,  1 Dec 2025 18:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhCyHkxL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13D43385AB
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764613018; cv=none; b=oT+LmR50Tqd6jh2RGwNjo/vr9KAbNuV30C6Ex99mZIZuiyr3vLIvLe4xcCjOWzhRuZbz9TdByGG41lhd+x4Hk8us5flX3f4h92SqkGpk0ZKc/npBSEw+fYENwDVSNsBpq7x/ezOsuuBZnfe2pXSzyfYtV+eZFn1F0KLB/VJQ4/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764613018; c=relaxed/simple;
	bh=ppk1uMVa5C3mwrdd8AKTnxZaLsInyOE9IJv+OBp9CEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgziBcCgbCuducd/fnPc6HKvOdDLdqxhAtYoqy98E3xIuuAfkAuo2rCOHtb+8nhEFnM1ItBA7PNIzXxyridoAsRH1DnABvNXpExkLbkPXyB3bggP/4z3ZsUbrUDukVdEYX9jgLkHmxlA6U/Bo8oGZnQHu1qHWaiMgfM8bnE1Beo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhCyHkxL; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88246676008so48550136d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 10:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764613016; x=1765217816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+ahSNRHAPTpSStGMQ+T6U8mmc9yGXaa07sdg/NiO2Y=;
        b=ZhCyHkxLjz4+6l1NpWzro0ru4WzbE+gdc37L3YNnOjfYDj/7M9zpVJhCPVgOCC1Akw
         DvLkSQFXg9UG1C72dJ6D5HWngzSdSfUQFrD3o0P8+jSc45Di0Fumw80vNEal78gA+2++
         RQZrpMIvWel52JISpNP50qtuth98DxGdutAurzWc4kGpknCsgstOZNWILA1nNa6bGnVe
         4HX3bnPmdwYu/yjw2XBvNgKX2CUifeiYt1eHrFhNYkEN0atpYc0Kz1v8PIaz7oIZboiU
         V1VVv6MtWrSqBCsq/3cnlZncJz0NDbDUAfTWjxEf8juFL4CtkHw3m5THWP2HtNl564ic
         yEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764613016; x=1765217816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h+ahSNRHAPTpSStGMQ+T6U8mmc9yGXaa07sdg/NiO2Y=;
        b=IL0/P/yvKChPCOaGj9b06mQY5qWU57+wcyoPV/DqMqjr5KWIN42iY0Tt28RdG8vrfj
         i5ULXNOrRd1GCIRALPHN0Luvw1uQ1l0+j+KgfMbrqroWdurNTaffJAlCzKEG7cinn/Kk
         zCxrdhyfZVcJVE/sP2J4xTYOz5dF3Rook4xMKgCYgs8/k6gwkNuAEGNfowOk21SyYIdr
         GXXk8CWyqHsICpusk0wVmXRqT249HXPqSqHsoAwktXt9vl9rtFxNWc/d87gsfSxNjnS5
         5wER2cV2NbpPW3kt+aDpfN0Z3u5z8gwoNWKOXm5OFnx1CjWGO94QTe9MY/0MYUVqzrVV
         yQag==
X-Forwarded-Encrypted: i=1; AJvYcCVJqrbNEI7yZj9U0zbzYwKP22PUtwSuaG4dpN5juKa4ms8aNOdAu1GFtHwcHwzS33MfCbdaPnu0LMjjo97H@vger.kernel.org
X-Gm-Message-State: AOJu0YzbSzlxZ7ZIpNQ3t7H7epVs4EJqBDs7d9W2RlWFV8bQjLKWPAlJ
	UyZIsjyp1KSATQuT6Qttjuuv+OE4LtoZ3sjuaqeQa4cj73I/OwJ0hMqPmvpq+/yCSqSDzlvilFe
	A7aVuJpC5brr+fbFg9rBjqwtSbX9frsc=
X-Gm-Gg: ASbGncs3BIl4NxFp6jfRlPDtPaf4HgovV4bd3NssmvbeXhU4WDRgtRucEmdyn3MRrtz
	vANDOrw4aUSw0wYt+Y+j8jGjr4DXHU/qhsdOcdTH6af6FpEX+3BSsX95AvnJIWjaVIqdpMo3NBK
	Kl5dzfhMSpHP/lSiNEeV+fExw+5+UvchkbX7UUnVBnNdbTaiRfEb2en0g+VLjWI+E16MPicakP0
	R997+oFNHWCZhHhhd2pqW25cm7BkKqmlO2/RPQKTIozSShxVWEgH/EiAZ6izxY59p3SVyz/ij/j
	rvSAsTW9p0JXrztUw3hORmP5q8nAaN5ASKy080W7pd2cEuFFGy3kazrVmyqAzb9rBMaM7yBidZk
	V8szsGmWbXJJ/Q8LVYz1CfnH2myz9FfX+OgBoLkr9MVeE5Gg7iL6LQkZVtyYeqUzPmwRD7gzkE4
	CRoMg+QTkVcxYOtdbIUss=
X-Google-Smtp-Source: AGHT+IFG03chWckzr6y67x90QnGTqSMzQEluv5uCYHggyp/mWqt04gwhoT62JeF58wPH5dyi6hZU8IjEaZtL+ktDuZ0=
X-Received: by 2002:a05:6214:5889:b0:880:6a57:1a48 with SMTP id
 6a1803df08f44-8847c4d5725mr517223716d6.12.1764613015780; Mon, 01 Dec 2025
 10:16:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1430101.1764595523@warthog.procyon.org.uk> <qvtkweac7g5ejiicsnb7cqxlxl35toi2ykdmguaszqkcnir355@zvaw3oxlxzex>
In-Reply-To: <qvtkweac7g5ejiicsnb7cqxlxl35toi2ykdmguaszqkcnir355@zvaw3oxlxzex>
From: Steve French <smfrench@gmail.com>
Date: Mon, 1 Dec 2025 12:16:44 -0600
X-Gm-Features: AWmQ_bnpAyukHfBdaWxuRuWreo2AZSOmO4GxUpTXZ0FYkkhIDzupPaCil5Cr954
Message-ID: <CAH2r5mu13Jva4nP-rdk3QeRe=Y5iE6RcM7txKdRDHJM8a6AoBQ@mail.gmail.com>
Subject: Re: Can we sort out the prototypes within the cifs headers?
To: Enzo Matsumiya <ematsumiya@suse.de>
Cc: David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
	Steve French <sfrench@samba.org>, Shyam Prasad N <sprasad@microsoft.com>, 
	Stefan Metzmacher <metze@samba.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I don't have much objection about #1 and $2, 3 possibly if not huge,
but higher priority is 4.  Agree that 5 and 6 are lowest priority
unless part of patch that is fixing (or perf improvement etc.)
something

On Mon, Dec 1, 2025 at 11:32=E2=80=AFAM Enzo Matsumiya <ematsumiya@suse.de>=
 wrote:
>
> Hi David,
>
> On 12/01, David Howells wrote:
> >Hi Paulo, Enzo, et al.,
> >
> >You may have seen my patch:
> >
> >       https://lore.kernel.org/linux-cifs/20251124124251.3565566-4-dhowe=
lls@redhat.com/T/#u
> >
> >to sort out the cifs header file prototypes, which are a bit of a mess: =
some
> >seem to have been placed haphazardly in the headers, some have unnamed
> >arguments and also sometimes the names in the .h and the .c don't match.
> >
> >Now Steve specifically namechecked you two as this will affect the backp=
orting
> >of patches.  Whilst this only affects the prototypes in the headers and =
not
> >the implementations in C files, it does cause chunks of the headers to m=
ove
> >around.
> >
> >Can we agree on at least a subset of the cleanups to be made?  In order =
of
> >increasing conflictiveness, I have:
> >
> > (1) Remove 'extern'.  cifs has a mix of externed and non-externed, but =
the
> >     documented approach is to get rid of externs on prototypes.
> >
> > (2) (Re)name the arguments in the prototypes to be the same as in the
> >     implementations.
> >
> > (3) Adjust the layout of each prototype to match the implementation, ju=
st
> >     with a semicolon on the end.  My script partially does this, but mo=
ves
> >     the return type onto the same line as the function name.
> >
> > (4) Move SMB1-specific functions out to smb1proto.h.  Move SMB2/3-speci=
fic
> >     functions out to smb2proto.h.
> >
> > (5) Divide the lists of prototypes (particularly the massive one in
> >     cifsproto.h) up into blocks according to which .c file contains the
> >     implementation and preface each block with a comment that indicates=
 the
> >     name of the relevant .c file.
> >
> >     The comment could then be used as a key for the script to maintain =
the
> >     division in future.
> >
> > (6) Sort each block by position in the .c file to make it easier to mai=
ntain
> >     them.
> >
> >A hybrid approach is also possible, where we run the script to do the ba=
sic
> >sorting and then manually correct the output.
>
> +1 for the cleanups, thanks for doing that.
>
> On backports, I think points 1-3 could be done together, but in separate
> commits (per header file) to minimise conflicts.
>
> 4 looks good to have.
>
> 5-6 would be most problematic (moving code around).
>
> Not sure what else to say here, but more atomic commit are easier to
> backport than big/monolithic ones.
>
>
> Cheers,
>
> Enzo
>


--=20
Thanks,

Steve

