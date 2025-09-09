Return-Path: <linux-fsdevel+bounces-60704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA92B502C6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 18:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503F617ADC2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 16:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BD425D1F5;
	Tue,  9 Sep 2025 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDkkaKHa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BA625D218
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435678; cv=none; b=h1moFdZJMA3LZTZCZcxeEq7iLaVT5ztRWI753r68mDNCkov9zlLkNXeOtSs4fbrrh4nIxLD8J++afdm6nVc8uG8tD3iw9mzoSJIyBOG6XiqIIAbKJLPsiCE5melfdzsEeo1XSMGWziqgylbZ/wWwZjAX5Re/Fd2bMM3jf+mHGhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435678; c=relaxed/simple;
	bh=lA8s6t9HOiBQdDuKb6zNLDpNnljx8itOeiGroYksHhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=mtmmoHcm3Cr1Q56mjjkvakCWd2kt9jkbRItkI1fg4ytE15PgUBAC5YUjQuewt2A2CTK6fqk04abaKrsfEajNWEu7t6jIzCQnZ1kXiT75DpJ4rFLdshbzGVLIIxt7xclp+pCYCdUlleUiIbSESMlX98aDAICnh60eWn/Hk83B4hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDkkaKHa; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-329b0e14980so1052799fac.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Sep 2025 09:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757435676; x=1758040476; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KEjAcB9Qu+OXbnub5YLZ7li7S5r42VgcPpOdc64aBEQ=;
        b=lDkkaKHazi+dL3AnkxPgt6XGE8hWujOj6Af4IaaTy1is1FMIU7Lf8plILNkXw3KenK
         84GF34ijSIdyeB4xqRlZEgTs3eG7QusmiIlYKZsVF8cO8zJYmM0TF0yuhwvsCGxNFrVW
         zwu//RNJW2XB1CTvIbH5x9T4ZishDmSfYov+8Uf0uE3GdhczTgqkbX3AYiA18WSNYgXH
         I9WxO9yktl1bWRkSng2IWDtxH+Pnilw4S6Tzur9z/FujU/vWZkWsbniaVMrzUSDhw09J
         mL7Y52Mug3922fkZKmNIEXCp6nxiywPiuK0dbBNh7KI1lFA44gDCS9S9bnjz98kvFcD1
         IbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757435676; x=1758040476;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KEjAcB9Qu+OXbnub5YLZ7li7S5r42VgcPpOdc64aBEQ=;
        b=S55sW53oY3nlu0JhwWkcWioqkDEqEddZWXfgVK8k6qRRoCcEp3X980GX1yYtYCmRFB
         lxx1n/HqFMNDpC5bSLff2AP8g7CAxoZnDPwrfX6hlzPIvtO+CGU1UmhiX0gYv0/kPjuY
         6TzhuyUMX+mmN0WUPl+QVp4Oz6jamo9CA58bptc4phuMgtCxfVmbN1OYbff0Qs5kYEzX
         83mC6QFt535saIxCOnJiAp8UCFZWJ2iiioGMZoZaYa06Qe9qYu46yCsKUiOErel++HT+
         E5yCHOTUjk4a4cslvqVJYjc/HcLxtrW2cejVEBbb0G6Co78eCC2GyMLO0/Z4dnhV7uXe
         xxbw==
X-Gm-Message-State: AOJu0YwgAt2qxEJepv2XAb9c45hJU+S3eRxEXEFQ3ImVICMxyYefbIYo
	MtulRR1zXrPLZIzqtUcdla7odvWcx8QxwZyybRlbgu97tUshMOX1+bXld54Sb64eRohKjtHzHxH
	ycRs5b7VeIAaxzMguvcBRW609f6zn2IqOKsdd
X-Gm-Gg: ASbGncuvof3mJ0lcimxzmg9GBm5bwBZoo3ej5UPDNcXDmGGHODvbJR2E2GvPwEnMQ5P
	d3doFaMnUcd/PKSzA8ip2QRoYM4xzcFLzmvMm9+fFCsylSsUpH02dwV95EYTF+nHkQe3uWIyNuv
	MPe7mJ5QmiKdBDCB3h+RIS2Vaekt8EH1nSLmkZ1+ll6ZhJEdwTrL+pYICvaHM7hVEvWv0HcrTZ8
	B0oXoI=
X-Google-Smtp-Source: AGHT+IHaFag27p8U/7gscmibSnO1PlecAy3FJaa/rHW0FHKW994nM5DQz6H8aSJd2KEWNPQ1JkfqS3KxUbGqKpDJBpY=
X-Received: by 2002:a05:6870:b4ab:b0:315:c1c9:a5be with SMTP id
 586e51a60fabf-32262648406mr4912629fac.9.1757435676093; Tue, 09 Sep 2025
 09:34:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0Ufzm66Ors3aBBrua0-8bvwqo-=RCmiK1yof9mMUxyEmCQ@mail.gmail.com>
 <CALXu0Ufgv7RK7gDOK53MJsD+7x4f0+BYYwo2xNXidigxLDeuMg@mail.gmail.com>
 <44250631-2b70-4ce8-b513-a632e70704ed@oracle.com> <aEZ3zza0AsDgjUKq@infradead.org>
 <e5e385fd-d58a-41c7-93d9-95ff727425dd@oracle.com> <aEfD3Gd0E8ykYNlL@infradead.org>
 <CALXu0UfgvZdrotUnyeS6F6qYSOspLg_xwVab8BBO6N3c9SFGfA@mail.gmail.com> <e1ca19a0-ab61-453f-9aea-ede6537ce9da@oracle.com>
In-Reply-To: <e1ca19a0-ab61-453f-9aea-ede6537ce9da@oracle.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Tue, 9 Sep 2025 18:33:59 +0200
X-Gm-Features: Ac12FXy3sHHh8H3-76FUylUsxwCyfmz6CIQhKzrWD-jbZqvQEUwlALfNSyCS5D4
Message-ID: <CALXu0Uc9WGU8QfKwuLHMvNrq3oAftV+41K5vbGSkDrbXJftbPw@mail.gmail.com>
Subject: Re: NFSv4.x export options to mark export as case-insensitive,
 case-preserving? Re: LInux NFSv4.1 client and server- case insensitive
 filesystems supported?
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Sept 2025 at 18:12, Chuck Lever <chuck.lever@oracle.com> wrote:
>
> On 9/9/25 12:06 PM, Cedric Blancher wrote:
> > Due lack of a VFS interface and the urgend use case of needing to
> > export a case-insensitive filesystem via NFSv4.x, could we please get
> > two /etc/exports options, one setting the case-insensitive boolean
> > (true, false, get-default-from-fs) and one for case-preserving (true,
> > false, get-default-from-fs)?
> >
> > So far LInux nfsd does the WRONG thing here, and exports even
> > case-insensitive filesystems as case-sensitive. The Windows NFSv4.1
> > server does it correctly.
>
> Hi Cedric,
>
> Can you send a pointer to some documentation for the Windows NFSv4.1
> implementation of this feature?

That is just ON by default for the Windows NFSv4.1 server if you
export NTFS, and OFF by default for DVDs.
We never had to change it.

https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/nfsadmin
explains a bit of it, but for Windows Server 2022 and 2025 it's a bit
different. Part of the more interesting docs are behind a
paywall/Microsoft login.

FYI like NTFS, you can pass a translation file, which can be used to
do the codepoint mappings between uppercase and lowercase.

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

