Return-Path: <linux-fsdevel+bounces-7771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E299982A75F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 06:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00C5AB2148A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 05:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D86B46AB;
	Thu, 11 Jan 2024 05:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzqZMzEZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5DE5382;
	Thu, 11 Jan 2024 05:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50eaa8b447bso5330201e87.1;
        Wed, 10 Jan 2024 21:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704952764; x=1705557564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FJ87IotFFb22oBVL3yLTlm/KMv2+8lgNVJRq/vObCyk=;
        b=CzqZMzEZtvDdKV5J1zvfpPjPR0wILxDKt26BQKl6dgvHwvuCdUpx9zofNRErh3RHcX
         4RuSBM6WZWJ1QKGW+9aiqdcuZ62e09X44gxoTRBDE+voHnFnRDsr+edQ5ck1zC7LsJhN
         EMK1qwLK1bRNnbMuChx86E3Azw77svFukz6fqTpXK3bsM2rTrEDn7RijQtfJzRULk5fh
         03jquwf/rzboIOEKrCR16L4yr1+Xatxw99hk68jjfEH+31e9vDr7ITE8LCsNPBfAQQpH
         P6UrE+PD1kzUZiHQ0KvBiTXXqrktw2yk9LaQhbiPyPJxRxnNuSars1Af7vD/wPL9xNN4
         4M3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704952764; x=1705557564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJ87IotFFb22oBVL3yLTlm/KMv2+8lgNVJRq/vObCyk=;
        b=PZikC1qFb00UIl7giDpbUhRi+PwG7WMGC2I2TAEF1QH5b8owBpy+p/8rvT3vq+CCsV
         V461beb9lR8JKSyJ8vearvFNjmrLIwdr8iJQp047Rwx+y81rtRcoq5yQ/yYSOHA76ehV
         lG2l3qp7uLV1MfLdNTGrt1s2zyKLXu7rjfQwT4PmnAXsQMnVUVqx3nnKa0jZFzbUvrOX
         s/zCJhOF6LAB2tHaRWCdKxPTPkGzCPKp2F8Xet1nwZI0SRPETfv9nGa3Y0Ltqxv7XDHQ
         MJ8M7lvivuv4Xh6kXxoODM4mc+k54GZl5vBHmg5W8oItq7JtStAu94AtWAezRC/u+uR9
         5KZQ==
X-Gm-Message-State: AOJu0YyVqvzD5u0f/yOoNxYT7dq5ZdTTUXgj+AXRBVyKnTXhwC7XN5aF
	/LgPOEbucY8bFWak009t9Uj9eZlnQaX9WuTMcro=
X-Google-Smtp-Source: AGHT+IGQ5ZV/gXo7v/rJ2auVyXpmqs0QYfi3tBSjxW2wUQzS96ysR1EG48kjTCbHRzoOg/0bxoYvPzkVO6R5r9tJSuk=
X-Received: by 2002:a05:6512:3990:b0:50e:2e5d:10a8 with SMTP id
 j16-20020a056512399000b0050e2e5d10a8mr136706lfu.133.1704952763509; Wed, 10
 Jan 2024 21:59:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1850031.1704921100@warthog.procyon.org.uk>
In-Reply-To: <1850031.1704921100@warthog.procyon.org.uk>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Thu, 11 Jan 2024 06:58:46 +0100
Message-ID: <CA+icZUUc_0M_6JU3dZzVqrUUrWJceY1uD8dO2yFMCwtHtkaa_Q@mail.gmail.com>
Subject: Re: [PATCH] keys, dns: Fix size check of V1 server-list header
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Edward Adam Davis <eadavis@qq.com>, 
	Pengfei Xu <pengfei.xu@intel.com>, Simon Horman <horms@kernel.org>, 
	Markus Suvanto <markus.suvanto@gmail.com>, Jeffrey E Altman <jaltman@auristor.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Wang Lei <wang840925@gmail.com>, 
	Jeff Layton <jlayton@redhat.com>, Steve French <smfrench@gmail.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-afs@lists.infradead.org, keyrings@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 10:12=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
>
>
> Fix the size check added to dns_resolver_preparse() for the V1 server-lis=
t
> header so that it doesn't give EINVAL if the size supplied is the same as
> the size of the header struct (which should be valid).
>
> This can be tested with:
>
>         echo -n -e '\0\0\01\xff\0\0' | keyctl padd dns_resolver desc @p
>
> which will give "add_key: Invalid argument" without this fix.
>
> Fixes: 1997b3cb4217 ("keys, dns: Fix missing size check of V1 server-list=
 header")

[ CC stable@vger.kernel.org ]

Your (follow-up) patch is now upstream.

https://git.kernel.org/linus/acc657692aed438e9931438f8c923b2b107aebf9

This misses CC: Stable Tag as suggested by Linus.

Looks like linux-6.1.y and linux-6.6.y needs it, too.

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dv6.6.11&id=3Dda89365158f6f656b28bcdbcbbe9eaf97c63c474
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dv6.1.72&id=3D079eefaecfd7bbb8fcc30eccb0dfdf50c91f1805

BG,
-Sedat-

> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Link: https://lore.kernel.org/r/ZZ4fyY4r3rqgZL+4@xpf.sh.intel.com/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Edward Adam Davis <eadavis@qq.com>
> cc: Linus Torvalds <torvalds@linux-foundation.org>
> cc: Simon Horman <horms@kernel.org>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Jeffrey E Altman <jaltman@auristor.com>
> Cc: Wang Lei <wang840925@gmail.com>
> Cc: Jeff Layton <jlayton@redhat.com>
> Cc: Steve French <sfrench@us.ibm.com>
> Cc: Marc Dionne <marc.dionne@auristor.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/dns_resolver/dns_key.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
> index f18ca02aa95a..c42ddd85ff1f 100644
> --- a/net/dns_resolver/dns_key.c
> +++ b/net/dns_resolver/dns_key.c
> @@ -104,7 +104,7 @@ dns_resolver_preparse(struct key_preparsed_payload *p=
rep)
>                 const struct dns_server_list_v1_header *v1;
>
>                 /* It may be a server list. */
> -               if (datalen <=3D sizeof(*v1))
> +               if (datalen < sizeof(*v1))
>                         return -EINVAL;
>
>                 v1 =3D (const struct dns_server_list_v1_header *)data;
>
>

