Return-Path: <linux-fsdevel+bounces-72001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE37CDAD53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 00:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6A38302628A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 23:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE05E2F1FFE;
	Tue, 23 Dec 2025 23:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+tkzHNs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A563A27FD71
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 23:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766532327; cv=none; b=IOcEPyNPrRJ4N7Qd4BeQXlZ1ztb0glQUXb+jWi/Vneqp9kztnL1cnjItxFF0pnXFjmTrfP1mVO3UsVtaDXwqPjXNBZL+PXO9Vy+gMJNJmVxs/QOcyw//I0Tlg1xRLaq5QsC9CWn2BldBZmyik9uptOCZAFfaK07q8fphvV7qu0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766532327; c=relaxed/simple;
	bh=bH4hm859hWi8Na0CDvaRgWQifcQ3UavBrUz9a7uZ/+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MrqbxaXNVyGxK4J6KrWIVMqjbkqRjmyMquevEBtHpTrGvFv/3J94Z4gTWic4g6UR/wEm2NmNNA65mIc5Z4NBdMVGkog6T6ZbnN5cBkQV3FSZ7UbVMsyXEG22fgG1TWwPIjyyqrd9PJuWwOoqCxKg8spq5BIJufx8n6xt+UK6T3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+tkzHNs; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so794526766b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 15:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766532324; x=1767137124; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vlvoklPggO5V2VvOB1NMWj76C7NPURSV8R5yE1vvMbc=;
        b=m+tkzHNs7aZfCPDcBvQxkINOqI9n/1rfLzO4iPOrKkPVwjvEBiyzFipQ2aqgLifkiW
         IJWfngZ5CmcXPK/o/gG06qVl0+IXQEHQ3+gT+W3OA4WzgwUXO6fWMJfxV9oevbDz1AA0
         K/s1TEfZVnYWVFLhuTLp8uhyxSBmuXpHTQoPH5eTi5fLq9UJlz3GKZ86XkyRryQ3pPQB
         3EHoeHtOV4XA4f5J04VlMEYT1nnfLX/n2ojs9W/28qwJlm7NN1AMlQgqXeHfhv59Xt4g
         Sw5TIlsf9FMNTd9vNK3W9Cftyft3sEZcBGBCVO/3QilMSy7msZQoHff9bME/pg8PVpYx
         ZadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766532324; x=1767137124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlvoklPggO5V2VvOB1NMWj76C7NPURSV8R5yE1vvMbc=;
        b=jqitmyY9wggIEDnsh9kloqAAwMel+X7vfosKduhdLdeZyrDYu8hs1ygGmEn1O8ju44
         eZ8m+BcZimD2XLBHdexasm61cgQNBzbtnrnFsm174KhouPUSJb/MZGKEgS+kWvs8xfqH
         IZOuyBXYjJIOjKPDXb+b8HqhpNxT+jHgWfesFKYYEesvUWPtRypJyJvROeH9KJ1FH93N
         h+UMMvf/bcHjNcDJ2rUjVFA8oLajkqSVgMAM+S00AkLkaHC9vGkGddevpHqYMn1wXHz7
         t/DxQgxIIMqLMMTs4W2T4NHehQeUkNj+3yPGhQ4d9ew/Hy8Oj7QJWCKD8gvvYLDmXedt
         KXhw==
X-Forwarded-Encrypted: i=1; AJvYcCUn0zl8vQkf5XTStmhB9Fbk+t5mKWe6KXPss2/1GI8/RGFHcb8GcY0CJZBiB9FZ+eFPn4oOu48xZdRjNYn5@vger.kernel.org
X-Gm-Message-State: AOJu0YwRRhpjqYpCOS2ADZ7jD3A0cAN2rnMQiVP3bNw1CA8eW8cn4zUF
	IlvN1f1bI0BB28Wat+3QQ27BWTfhVkfW52dKPy+pqMu0xSrx2JUHYgwCGhy2VRgnGo+6GyL/6wQ
	vphGS02E/qTkfZSJEVAk8zw4duLt6Xf0=
X-Gm-Gg: AY/fxX4auhno3tts5v28yTto40k74RKvE/Hw5MaYJp9DvH7NFKe4GDDgVvZPkEdivKT
	0bD2lB4v1nn9dzQNeEx4Jz/jZwhsiEw+/dTXuVsNOnBfU1WpgvgzS6Iz3SDrKUnLTwBpslD8klF
	c/LRctTGWAxIL9zTxdX3jWeV4KHd9hbKVHrz9pgURxbK6Yi2hybQxtK1nifRzUnL01xAt+scmz2
	asQaIIc4+1n68Mxg3xBwOKsPPVrXaOtTCerG1kPInZNdFSNuycJdPEDyOqAe8fOTtnTe+XY
X-Google-Smtp-Source: AGHT+IG6p1H6vOdORdN+4xiVy4gJwmwnr8X2HM3NfUP+87HF6WHRMN6GWxkKtl+bVfFyREtjadazGW6mzFzZm5TwbaU=
X-Received: by 2002:a17:907:6094:b0:b73:9368:ad5e with SMTP id
 a640c23a62f3a-b8037051288mr1679135866b.34.1766532323661; Tue, 23 Dec 2025
 15:25:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFnufp2ZD5u6pp84xtTcZKqQWtmtwN8n_d7-9UpqoUJUsEwwAA@mail.gmail.com>
 <87345fxayu.fsf@gmail.com> <8cd912f2-587b-45ff-a3aa-951272f1f538@cs.ucla.edu>
 <CAFnufp0zMe04Hh41-z6Yi8RTc0gZ7i74F6zRBDqOS5k9DZu2TQ@mail.gmail.com>
 <dabc0311-8872-4744-89ec-82a3170880b1@draigBrady.com> <CAFnufp35pGf6SDYRxf8YW17tdT0sTTXt_SXnPjpdWtg4ndojZA@mail.gmail.com>
 <4b3d3a05-09db-4a6a-80e2-8d6131d56366@cs.ucla.edu> <CAFnufp26+PnkY2OM=5NMvxDxrBf3F=FfoKBU8e0XVu4im6ZU0g@mail.gmail.com>
 <6831a0c6-baa1-4fbb-b021-4de4026922ab@cs.ucla.edu> <CAFnufp1z=-BfUVEX+wiiv+Y5f-fGbzBTZYwwhXM7VFGxAQLexQ@mail.gmail.com>
 <1a8636a8-bc53-4bb8-9ecb-677c0514efa2@cs.ucla.edu> <CAFnufp072=wSfU4TUY7DcymJCqY5VYw2dqxt=OAY3Op3zZwEpw@mail.gmail.com>
 <7e74a2c1-3053-4c2a-b1de-967d3d4f58a1@cs.ucla.edu>
In-Reply-To: <7e74a2c1-3053-4c2a-b1de-967d3d4f58a1@cs.ucla.edu>
From: Matteo Croce <technoboy85@gmail.com>
Date: Wed, 24 Dec 2025 00:24:47 +0100
X-Gm-Features: AQt7F2ppDxZq0zniEA6Uki2npZDIjrHh0e0P_nCkHWn9VQQMyZi8WAvfa66U4yA
Message-ID: <CAFnufp0Dtg1=mKaCgSHnossVE4h41uzigw5WMTy6wkOO90sskg@mail.gmail.com>
Subject: Re: cat: adjust the maximum data copied by copy_file_range
To: Paul Eggert <eggert@cs.ucla.edu>
Cc: Collin Funk <collin.funk1@gmail.com>, coreutils@gnu.org, 
	=?UTF-8?Q?P=C3=A1draig_Brady?= <P@draigbrady.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno mar 23 dic 2025 alle ore 20:40 Paul Eggert
<eggert@cs.ucla.edu> ha scritto:
>
> On 2025-12-22 17:28, Matteo Croce wrote:
>
> > Where in cat.c the code avoids the overflow? I see:
> >
> > ssize_t copy_max = MIN (SSIZE_MAX, SIZE_MAX) >> 30 << 30;
> >
> > which should evaluate to 0x7FFFFFFFC0000000
>
> Oh, I might be mistaken here. I was looking at my experimental copy of
> coreutils, which has some changes/fixes in this area.
>
> > also strace says:
> >
> > $ strace -e copy_file_range cat /etc/fstab >fstab
> > copy_file_range(3, NULL, 1, NULL, 9223372035781033984, 0) = 568
> > copy_file_range(3, NULL, 1, NULL, 9223372035781033984, 0) = 0
> > +++ exited with 0 +++
>
> Those particular copy_file_range calls don't tickle the kernel bug, as
> the files are at offset 0. But you're right, you can probably tickle the
> kernel bug in other uses.
>

Maybe with a huge file and a seek, e.g.

$ truncate -s $((2**63-1)) file1
$ ( dd status=noxfer bs=1 skip=$((2**63-1)) count=0 && cat ) <file1 >file2
0+0 records in
0+0 records out
cat: -: Invalid argument

strace reveals:
copy_file_range(0, NULL, 1, NULL, 9223372035781033984, 0) = 0
read(0, 0xffff273fc000, 262144)         = -1 EINVAL (Invalid argument)

I also see that copy_file_range() is used first and read().
I guess that it's because copy_file_range() returns 0,
so copy_cat() returns 'some_copied' which is 0,
which is propagated to 'copy_cat_status'
and then cat fallbacks to simple_cat()?

> > Yes, the kernel bug has to be fixed, of course.
> > Your patch doesn't compile due to an unmatched curly brace, I fixed it
> > but it panics at boot, can you check if I preserved the correct logic?
>
> No, but that's understandable as my patch was hopelessly munged. You can
> try the attached instead. (Notice that it does not fail with EOVERFLOW;
> either the requested area is valid or it's not.)

Will it as soon as I'll have my devel machine back.

Regards,
-- 
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay

