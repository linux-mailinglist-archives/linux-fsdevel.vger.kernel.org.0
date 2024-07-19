Return-Path: <linux-fsdevel+bounces-24031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6A9937BF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 19:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE821F215B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 17:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1821474A5;
	Fri, 19 Jul 2024 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYWJACLW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455541465A8;
	Fri, 19 Jul 2024 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721411597; cv=none; b=eLmkm5iowYzccxt2x/jnca8mqV1AfqnWM6s/PJrzcEMmBmjENlU1nhcNnAAfPtiIMxYr9gaTjiTRLIcHnw/CMAVWbFfrll13xxCye6MkLKEz4W3HtlSlhi2KkE1N4CVcZE08jsQOjQBdKfOGfvbfEYJjIL/zxwiCK7uCFeWhXGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721411597; c=relaxed/simple;
	bh=D1wxxplXZk96khvpp/PN3Ku5ytPBuQTMbzsgvqqzpj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlEUMuP6wS8qK40xeWu/+7Y1intvbUbIT7vRewStRU+6r6tN616l+We2BLozhm51lkzzln/9mxtaGQcQdufISjlVuMfjcxHdl85ONIB0nXn+f2R7QbRUjv9zD8iJz1if7f8Ryz/d+BWDZfp2b/ktFbHw/jYTEdCiCi6287/X2P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYWJACLW; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a79f9a72a99so599827466b.0;
        Fri, 19 Jul 2024 10:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721411594; x=1722016394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qy8NAhkcqX2WgaFdfiUNXOc3h3r+y63jz4sEBx8rqjk=;
        b=KYWJACLWgBsH2Lmvet9nVPlHc+nNrw9BeOFcMPyZ3k3N49RcG4Psn7NQl02OFdvFpG
         be8ejT+vW6Jzw7+vbtHkxwxJ2Go5Ps2FsIjcmgfpe1jWqHihQcZd6mPBbG9+BzXMbsTO
         UeJIZyXukIsqMymB2WnC2KKcmvRCld6x7v8sXc5WWBEbB32iDM6amSCSXK8C2JwiobvC
         bXmTwSfmq48S17qCos0hjmFYSosp7ygbF7I/4RCHD2sDxbjJWVhMcspOu+3FjUPsHSeS
         e2XDyKDTlPovu6OLu3rlGE6TnnHIMYq+4A10ZQeF6iRPFMekPgqJW7XFIkdCWhHSVSeU
         Ihuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721411594; x=1722016394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qy8NAhkcqX2WgaFdfiUNXOc3h3r+y63jz4sEBx8rqjk=;
        b=Oc3RtdzFRg3ysApoU44FynNLalq1C5sDOs/kqNHv6TJRYGigq7j5veqnp8okRYJM7k
         u6dTSechD7kMF4arAUDPfnC7+mTOX+d87LTaQvejB5aK990Kckm6LRg+bfBJyU9dgrX7
         iZC/bWicH+ROo6JXmuhoSA8m+EEXnAOeLfMB3xVmTqg8F2WN2ZDFmuq88VFXi2oiTLY8
         283A7L0D5OTcsH5cY/vudhTYgPjo1t6UbrKKBxDnlkwRoBsMIk0d67tAnkwJ36CNFywt
         dzT73OE4ohel/xFzugH7l5tQAgwAaqqEsG0GCHP6JAJK1/6aGFzuQEE6J7a7dgYiGwBa
         PSEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcSmaIBsmGcEGFKrwH5IJ8geQquTKR0YtuYUHL8KbgyBN/5J/S+33/3yk6YkG8aZsD4/K18UtdRIu2AMOmP6NgCSuXvQ0KyzSRMkfwzf+k/R+lSECDsSAiKf5K2glD9Q9SdCGRvLbecpslTA==
X-Gm-Message-State: AOJu0Yxm4qezSN0IgyQhCv8vXe3A/OmgxWOMwhj8yJ4/VKJxM9+AtN0s
	PJ4pXry/k2o+SoczYqrvR5ceQ8iDadsWXhd2E6QLNJ7m//aHICN5HzuttL1TVOB2QASYZBkiV4Y
	3h4Yks/z/XK79J7s2FLxqySeYy9o=
X-Google-Smtp-Source: AGHT+IGSaMKODxUsrFCUt1HnQNY2uoBofnpURBnFZMpfztI1ZyT3mZwxaTYFG6j8i5pedcaQipiQ2eXOfkpmTCNpeII=
X-Received: by 2002:a17:906:4bd5:b0:a6f:a2aa:a4c7 with SMTP id
 a640c23a62f3a-a7a0f0c4850mr701989466b.3.1721411594340; Fri, 19 Jul 2024
 10:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614163416.728752-1-yu.ma@intel.com> <20240717145018.3972922-1-yu.ma@intel.com>
 <20240717145018.3972922-4-yu.ma@intel.com>
In-Reply-To: <20240717145018.3972922-4-yu.ma@intel.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 19 Jul 2024 19:53:01 +0200
Message-ID: <CAGudoHHQSjbeuSevyL=W=fhjOOo=bCjq4ixHfEMN_XdRLLdPbQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] fs/file.c: add fast path in find_next_fd()
To: Yu Ma <yu.ma@intel.com>
Cc: brauner@kernel.org, jack@suse.cz, edumazet@google.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com, 
	tim.c.chen@linux.intel.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 4:24=E2=80=AFPM Yu Ma <yu.ma@intel.com> wrote:
>
> Skip 2-levels searching via find_next_zero_bit() when there is free slot =
in the
> word contains next_fd, as:
> (1) next_fd indicates the lower bound for the first free fd.
> (2) There is fast path inside of find_next_zero_bit() when size<=3D64 to =
speed up
> searching.

this is stale -- now the fast path searches up to 64 fds in the lower bitma=
p

> (3) After fdt is expanded (the bitmap size doubled for each time of expan=
sion),
> it would never be shrunk. The search size increases but there are few ope=
n fds
> available here.
>

> This fast path is proposed by Mateusz Guzik <mjguzik@gmail.com>, and agre=
ed by
> Jan Kara <jack@suse.cz>, which is more generic and scalable than previous
> versions.

I think this paragraph is droppable. You already got an ack from Jan
below, so stating he agrees with the patch is redundant. As for me I
don't think this warrants mentioning. Just remove it, perhaps
Christian will be willing to massage it by himself to avoid another
series posting.

> And on top of patch 1 and 2, it improves pts/blogbench-1.1.0 read by
> 8% and write by 4% on Intel ICX 160 cores configuration with v6.10-rc7.
>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Yu Ma <yu.ma@intel.com>
> ---
>  fs/file.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/fs/file.c b/fs/file.c
> index 1be2a5bcc7c4..729c07a4fc28 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -491,6 +491,15 @@ static unsigned int find_next_fd(struct fdtable *fdt=
, unsigned int start)
>         unsigned int maxfd =3D fdt->max_fds; /* always multiple of BITS_P=
ER_LONG */
>         unsigned int maxbit =3D maxfd / BITS_PER_LONG;
>         unsigned int bitbit =3D start / BITS_PER_LONG;
> +       unsigned int bit;
> +
> +       /*
> +        * Try to avoid looking at the second level bitmap
> +        */
> +       bit =3D find_next_zero_bit(&fdt->open_fds[bitbit], BITS_PER_LONG,
> +                                start & (BITS_PER_LONG - 1));
> +       if (bit < BITS_PER_LONG)
> +               return bit + bitbit * BITS_PER_LONG;
>
>         bitbit =3D find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit)=
 * BITS_PER_LONG;
>         if (bitbit >=3D maxfd)
> --
> 2.43.0
>


--=20
Mateusz Guzik <mjguzik gmail.com>

