Return-Path: <linux-fsdevel+bounces-71721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84556CCF0BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 09:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C43153030FC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 08:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEF61C3C1F;
	Fri, 19 Dec 2025 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qF3lpoNU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695912E92C3
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766134405; cv=pass; b=A/9jhw6fQGvGBPXaKC9pTyeuPYzTZjGJap0zxuP0TJmhNswqWBoQ+gJVdNZDRSnu1Np6cW/Na2WESb+ikVtSacfEqpgHJuXXFfDBjSJMTMHiiSuc9E1CPCCTq2AgEGl0iDjrbNpaSwl/6SSwS100wWdqYgZXjxsZbi38417UDas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766134405; c=relaxed/simple;
	bh=hDsnAgQTN88zaXjzezRZfy0sE1W++L3Yumln8u0o1AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLsxm6OcNg6im3GURg6XXRqGBUHV7DQFee0+eObOogRSBTRpKtEUZYbZr9WMRw2KywvdUZkyJHO+sVBQRX6BVtIIqiI8h4+1kgnCgIs48VAiX+yTVeqCRtCBZDb6FqTwTnAOIVlKph+kFYEmxkxdlECiNIJpKnTjNjhyX/xvqGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qF3lpoNU; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64baa44df99so1313a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 00:53:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1766134402; cv=none;
        d=google.com; s=arc-20240605;
        b=lvM5elz812fNaZIFU7gYFY7J7TsMqOf22y19q4xJAYgJyPJHGJwkQOfrfriTYoQ9so
         Q/L0sBbQTHqX5R04/YIdtYK3xY07kng7HJeluYe4p4by4LyNCtXEQCEJ7MiYS3RNsVYW
         fh5+B5y9cx93kJSk+iR/PktdxUwQHGCgwmk47Ahveeq5aC9Fy0Al8HTjRAghApyGMYV2
         384UbAWF956xfGeIUD7Dqfn3yQ4++53+2BkGqKltx4y47d5EPLnJsVIX+T7/g17gp06D
         v0zFED46rmOzCVMD/MYj6OQZje8PyUTa15nnTYD6iei0ZqcxCuT5tdO0QwFaxc+A2nq8
         XWpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fs8T/bx/dvPsalE6IyzXiaKyBFs/NfE6tP6xBoAggoI=;
        fh=Uphzd24aMKvpHcZBhXSEX+3UbHUB4vvyrSzIoI25tJs=;
        b=dkeZHZreidprhE0fcQxBPQss7xWUN+esWyKX9u9G52RorALPUb0VvIOg/i92T+UzKs
         4k1zDjp+0dtKp+V+WBqhWIQ8jL8yiTlqQAom4jVRRKQ9QYPiBU/GAiLI6nMlNICwrGyv
         ZrWvc91afYLSVoXYDMYNzm+LME/7tQamOYDVCwv07og1nLTFKPC1wDOiKq4LsrC+xJQt
         A6h0CkJGWoP2GLPeE2+qrs+TACIevO7ndBJpeJuN1/D74PpAHx+fYG/cg5lGZ+z7Dq4F
         WXkt0TnX6Vq+k8tsol5PeN9f1mziJF4CWwRIkDExM3RxzCr6H3tXAUlH9Jd1C9h6SORe
         Lo/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766134402; x=1766739202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fs8T/bx/dvPsalE6IyzXiaKyBFs/NfE6tP6xBoAggoI=;
        b=qF3lpoNUuSxLEcE4qrUGxU7/4rVzyW/VjdzmPjYtXds5P50OM41in+JzIth4h44mNI
         khtJ5i+ZqjvjOSyKKWSlxDOQ/Trp8SvBAz3EWUzakl3ckkHMx7sCn0Q7BopsiqyDd9pM
         cw0q0bnBU89xcfsDmMt7K1g9sgUUHWqB7yY1G+okIrqR6MfgEduRny6+kIs0tBlbww15
         r5mFzRj4LEfMkDXVgRwH8KdGSKp3LQrNuJcvPFpBStyTp9ps1RKRQR2pEu1AxZGqO2g0
         5SS0aoFpaR0NuuCwkC43XngcjIKqhkwvQ3nSejmNO9EERBhbypLGVVFz3HBgu1SxUbAN
         0k2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766134402; x=1766739202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fs8T/bx/dvPsalE6IyzXiaKyBFs/NfE6tP6xBoAggoI=;
        b=tPfFbdDXDEIRUpaPrbGE0wG781+U8nkZAAHzeSupEO5dvhJKaMGx8yRwg1KGhZoVOS
         scwiXNxCTw4VPKA4ENTOJC1/zSCEWM9ySygZtHDHMLKFdYdYqwNYYRA/wg0DdvdCPPyO
         peKmYD3I+5WQ8PD30yOCTJR+fAu4kkIKpUwEHRXr33bqg1VZ7Fy0IQA1eg0KdwXEjr6n
         o3M9W9ustkx2a2zlJShW/bZTFLjMKHviGZilxFGRUrxLaM8ZAlAosRoa0azRGyjV/FQF
         nVzGpWU4HxpTIjc5bRNjydZame3oTEQc9Fm9DqzQ9jbrdvK4SFV3G3tZzf1NKyL2aHZA
         Zmeg==
X-Forwarded-Encrypted: i=1; AJvYcCXyHNkOPaRvgMPzO1Ov4fXlk7v3kAxMbx4rVcOcOpOoupBzhsOd3Ti6i6r9meUhW6Xb5rFCRNvkM1/1o9j/@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Yrpr0LWRFD637ZARiunuBZo1QcqmUXOhDJUZbqQmSMgZuBZt
	D/iTOWfJgFG8IUBis5p0iWeMztVXNErEub6sDkomc+TEFm8T0z9RbCp6p9cJ3OpJ0I/fuiiw7Sb
	OBHPTavmjLs52fJZFQbHXIN0dIUU7aXVOukWBXOGp
X-Gm-Gg: AY/fxX56pyXxG601R/XvLzafludBNQxzy0DGhYnB6qI8dOyJgru+1hENSCXeGzJLX03
	T/GpUfBWS7bxP8ip8xSc2KDQwxIpPqbxc/hpXJmdRGpbTCegEoGIdiuOXvnwyfansvtdu76W0Bm
	us9V7w+QqMNHxokmvHhUBmT5wXvZiHgBDWC0UVuscyY42kFGDYvZ/JQsEKWHhg+uVc583sLU7LA
	QtOo/LbuPjvzhIYybkhR34eG5XYKztWDJSHgS54bdsN95qvQPjWQshhiaXUvN0InZexdIzxT4S/
	kjx7f9EoCHx620u5Hz3Hu4k=
X-Google-Smtp-Source: AGHT+IHuq3d4KNN0YyYAniV+RPAme4gkyFjgPMmpMJeYKEriKWzrRS16Ut3ZIhRlPYydbLU+pSeNuVjrsmXnVjuRd+I=
X-Received: by 2002:a05:6402:289c:b0:64b:4a02:f726 with SMTP id
 4fb4d7f45d1cf-64ba219eacfmr11471a12.10.1766134401509; Fri, 19 Dec 2025
 00:53:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218071717.2573035-1-joannechien@google.com>
 <aUOuMmZnw3tij2nj@infradead.org> <CACQK4XDtWzoco7WgmF81dEYpF1rP3s+3AjemPL40ysojMztOtQ@mail.gmail.com>
 <aUTi5KPgn1fqezel@infradead.org>
In-Reply-To: <aUTi5KPgn1fqezel@infradead.org>
From: Joanne Chang <joannechien@google.com>
Date: Fri, 19 Dec 2025 16:53:04 +0800
X-Gm-Features: AQt7F2oJIHIkcmTVNq-CM0D_Pggo29w0ne08iqhRm5s3GY2QUVqSO82KqAeqqQg
Message-ID: <CACQK4XCmq2_nSJA7jLz+TWiTgyZpVwnZZmG-NbNOkB2JjrCSeA@mail.gmail.com>
Subject: Re: [PATCH v1] generic/735: disable for f2fs
To: Christoph Hellwig <hch@infradead.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org, 
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, 
	Chao Yu <chao@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 1:30=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
> On Thu, Dec 18, 2025 at 08:02:48PM +0800, Joanne Chang wrote:
> > Thank you for the feedback. I will implement a
> > _require_blocks_in_file helper in the next version. As far as I
> > know, there isn't a generic way to query the block number limit
> > across filesystems, so I plan to hardcode the known limit for
> > F2FS within the helper for now.
>
> Oh, the limits is not the file size per se, so the number of blocks?
> I.e. you can have a 64-bit i_size, but if the file isn't spare it
> eventually can't fill holes?  That really does seem like behavior
> applications would not not expect, aka a bug.

Thanks for the reply. To clarify, I meant testing the architectural
limit of blocks per file, not the current free blocks. Sorry for any
confusion in my previous reply.

The limit is indeed the maximum file size. However, since both the F2FS
file size limit and the test's requirements are calculated as
(block_number * block_size), I believe it is simpler to just test the
block number.

Best regards,
Joanne

