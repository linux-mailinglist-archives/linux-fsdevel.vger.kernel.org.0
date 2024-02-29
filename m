Return-Path: <linux-fsdevel+bounces-13202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BAF86D0F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 18:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3348D1F25DDC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 17:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F1878270;
	Thu, 29 Feb 2024 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P+chWfKN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB1F78266
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228419; cv=none; b=lHxnGEQP6Rs75rY4K9WGTlDTLDNe/pDSaamWVveHgR0FRrfsZKPVk0NY2E5jPXnhacoH5A1SGwewkd5XbZmmJq9xBtDlqh75oAYyA1Aa57WcvsX9cEhLiPvR2OYCsbVrsjKLFbI6ngZcz3KdlPs5JSGwyf5cRx1HFi4tyFrjVnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228419; c=relaxed/simple;
	bh=jzGj5I4LRuYklOQyJfNOnG7oivOkxoCVa97TajgQgCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1fGHt5GBz+Nw7WFNFwBGAml93yAGyU/d+6i7827FVnjyuUaJLrG4luJtqh35NEmi20xMURCbktyIIPA2aEV82Ok6ChiwGHjJsjisCylhQVMp2NtMkGNlg5XF+zzin7977G3Q8pGM9AO/Gw2eV//6Q1QsOx+n+0uYQzVL5YtJCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P+chWfKN; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d24a727f78so13938411fa.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 09:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709228415; x=1709833215; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JQrqXSOy2jKpIC5hjgybMDfk5pI8gvMKo0UOhxnaCp0=;
        b=P+chWfKNSk4UXwlT4ROlIiyAXRgGgnU4cPu7d0xnA3pZG1fOtUE05So4SZI6cbTsuc
         hrL2VvdsAm1NqrrxV7Bejm+nsYC2SaFwZucFzZj9Bgbq7P2R8UokaSvpE3D1Lfng/nuH
         OzXRIGHHZ3i6rKSELbopyCWOJVpA4b6lWlvBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709228415; x=1709833215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQrqXSOy2jKpIC5hjgybMDfk5pI8gvMKo0UOhxnaCp0=;
        b=MuLD+h6U0b1GWumy7QEQrthwqQ5aRTOei+RbFOfRumVFTM0YN9SLkxPAxnCK3T1qvj
         HzIWOnIfYzo6LcLCdA9tVeljlhYKR11k5JDhFhwMrZMJ9U0j7XIemevcs/xPD9lFFVZr
         RnSIP0kFOzYB8yZsrvH7ugRRYAyCxzNH0WeUJTfTTIzEDt3/NALawnw6iTFeTkqcoNnQ
         BIsdadcpLFJdicmUcA+uAKvx5vnZ51urS12ntz3lONJ1TkNwjU78GnLgs6ojZikoHChy
         tWsI9xzFHMsKJLCI9TFNfk2mYb4RaGEx8/ZFnkV5Sb+0QP/+W4x0jMKYNzTXkNrehpBK
         wSuw==
X-Forwarded-Encrypted: i=1; AJvYcCW7VZoTe9EJ7T9zO2G8sZMcVB4ZGabBr8Pq3KkpjFniU2JhoPpLWKgqsEvaslU69kk5vwKhfN4a382K3+8dcqF7ipVd6O92Cl0Nyx5FWQ==
X-Gm-Message-State: AOJu0YxDpV/AFx1FeA7BHtYpC+a0cEkdZUSB3e/tn0C+Fi+y4x62b4+g
	DejI86giu8GTiJNro2ZgiX99B3mcuVbFsNJk6bwEGPaiFsQd2xKybPsWp/yBdytdhPVngSOeXhb
	MwiTPiQ==
X-Google-Smtp-Source: AGHT+IEqbvE63XNnyepVwgFtT4ImfES1a/noPwQkUZQm3tHO5c16M6ZhkOIN50NCy94g7nWXmV/hUw==
X-Received: by 2002:a2e:b536:0:b0:2d2:a433:b5de with SMTP id z22-20020a2eb536000000b002d2a433b5demr1601387ljm.44.1709228414731;
        Thu, 29 Feb 2024 09:40:14 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id y3-20020a2eb003000000b002d2ded7f592sm275589ljk.30.2024.02.29.09.40.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 09:40:14 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d220e39907so15699581fa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 09:40:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUi0OzZgPEioMOlMpMg9QCqsZ0QRlgpH1q7ZMJGVKj16TcXpi4rC67ay4xXlvjag4VwzDSYre62pzFWLan7U8QtXfl2kZd8gtixRBzKIw==
X-Received: by 2002:a17:906:b78e:b0:a44:176e:410c with SMTP id
 dt14-20020a170906b78e00b00a44176e410cmr2046490ejb.5.1709227968058; Thu, 29
 Feb 2024 09:32:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925120309.1731676-1-dhowells@redhat.com> <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com> <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
 <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com> <e985429e-5fc4-a175-0564-5bb4ca8f662c@huawei.com>
In-Reply-To: <e985429e-5fc4-a175-0564-5bb4ca8f662c@huawei.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 29 Feb 2024 09:32:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh06M-1c9h7wZzZ=1KqooAmazy_qESh2oCcv7vg-sY6NQ@mail.gmail.com>
Message-ID: <CAHk-=wh06M-1c9h7wZzZ=1KqooAmazy_qESh2oCcv7vg-sY6NQ@mail.gmail.com>
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: Tong Tiangen <tongtiangen@huawei.com>, Al Viro <viro@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Christian Brauner <christian@brauner.io>, David Laight <David.Laight@aculab.com>, 
	Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: multipart/mixed; boundary="000000000000e07d49061288a5ca"

--000000000000e07d49061288a5ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Feb 2024 at 00:13, Tong Tiangen <tongtiangen@huawei.com> wrote:
>
> See the logic before this patch, always success (((void)(K),0)) is
> returned for three types: ITER_BVEC, ITER_KVEC and ITER_XARRAY.

No, look closer.

Yes, the iterate_and_advance() macro does that "((void)(K),0)" to make
the compiler generate better code for those cases (because then the
compiler can see that the return value is a compile-time zero), but
notice how _copy_mc_to_iter() didn't use that macro back then. It used
the unvarnished __iterate_and_advance() exactly so that the MC copy
case would *not* get that "always return zero" behavior.

That goes back to (in a different form) at least commit 1b4fb5ffd79b
("iov_iter: teach iterate_{bvec,xarray}() about possible short
copies").

But hardly anybody ever tests this machine-check special case code, so
who knows when it broke again.

I'm just looking at the source code, and with all the macro games it's
*really* hard to follow, so I may well be missing something.

> Maybe we're all gonna fix it back? as follows=EF=BC=9A

No. We could do it for the kvec and xarray case, just to get better
code generation again (not that I looked at it, so who knows), but the
one case that actually uses memcpy_from_iter_mc() needs to react to a
short write.

One option might be to make a failed memcpy_from_iter_mc() set another
flag in the iter, and then make fault_in_iov_iter_readable() test that
flag and return 'len' if that flag is set.

Something like that (wild handwaving) should get the right error handling.

The simpler alternative is maybe something like the attached.
COMPLETELY UNTESTED. Maybe I've confused myself with all the different
indiraction mazes in the iov_iter code.

                     Linus

--000000000000e07d49061288a5ca
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lt7i5gtw0>
X-Attachment-Id: f_lt7i5gtw0

IGxpYi9pb3ZfaXRlci5jIHwgNSArKysrLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2xpYi9pb3ZfaXRlci5jIGIvbGliL2lvdl9p
dGVyLmMKaW5kZXggZTBhYTZiNDQwY2E1Li41MjM2YzE2NzM0ZTAgMTAwNjQ0Ci0tLSBhL2xpYi9p
b3ZfaXRlci5jCisrKyBiL2xpYi9pb3ZfaXRlci5jCkBAIC0yNDgsNyArMjQ4LDEwIEBAIHN0YXRp
YyBfX2Fsd2F5c19pbmxpbmUKIHNpemVfdCBtZW1jcHlfZnJvbV9pdGVyX21jKHZvaWQgKml0ZXJf
ZnJvbSwgc2l6ZV90IHByb2dyZXNzLAogCQkJICAgc2l6ZV90IGxlbiwgdm9pZCAqdG8sIHZvaWQg
KnByaXYyKQogewotCXJldHVybiBjb3B5X21jX3RvX2tlcm5lbCh0byArIHByb2dyZXNzLCBpdGVy
X2Zyb20sIGxlbik7CisJc2l6ZV90IG4gPSBjb3B5X21jX3RvX2tlcm5lbCh0byArIHByb2dyZXNz
LCBpdGVyX2Zyb20sIGxlbik7CisJaWYgKG4pCisJCW1lbXNldCh0byArIHByb2dyZXNzIC0gbiwg
MCwgbik7CisJcmV0dXJuIDA7CiB9CiAKIHN0YXRpYyBzaXplX3QgX19jb3B5X2Zyb21faXRlcl9t
Yyh2b2lkICphZGRyLCBzaXplX3QgYnl0ZXMsIHN0cnVjdCBpb3ZfaXRlciAqaSkK
--000000000000e07d49061288a5ca--

