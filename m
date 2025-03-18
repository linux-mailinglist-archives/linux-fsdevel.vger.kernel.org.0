Return-Path: <linux-fsdevel+bounces-44310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E009BA671D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 11:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C201A167B8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 10:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB6B209667;
	Tue, 18 Mar 2025 10:51:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45662EAC6;
	Tue, 18 Mar 2025 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295092; cv=none; b=JshDD735LHbcEK7EUfMtP3dGWZoBA+WozgCn8CNL4RxuaKmMwNM5seUQY9awf07o2wOcVrr+Pa1+EWGM9VwuWXmNu/haqm4Qh68fwi4f+RyMeqFySsxKCcYzB8zs05yqq2/13LBxyYXlMj/iS72w4NEnPC+IVKswBgkRU1m1jh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295092; c=relaxed/simple;
	bh=4umO4f6ePd0sJ1/++/GgZoX7xLdyK7mbDiQ6/iNDCaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aG6OvssbfjLz0W3gT+o6/sh8pJYNZtg/Ts7wYQdmt2pJnPiglAahIQfHkz5z3Hrc68xyvGIn06HWjQDt5N3rI4/2zHrEsPZxHnrf2+cMAbFbSLlPwMsZS8LLua5QU8QgNnvle95erWS07pgHf6gXEEB5E9nSSGHYijGiQdFKUGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-51eb1823a8eso2394283e0c.3;
        Tue, 18 Mar 2025 03:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742295089; x=1742899889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNxLDnoSRAhm1nLn1xN2OwKLhUKpRiAxSHPfWger/54=;
        b=XAt2m6ykDB4MjVDJReOq8/HMPQnEpwp7NW6gY53wKh66kpWfIG5Jwh5wnPZ31MVwWV
         HhbKEZgLt0LXN6iSYjsPIz55alzBS3PMRdqvEK3aBd8Wt2w7daQN4FlRO3QW3fQVH1ik
         u4SiozVCFRs7vwnAgpSwjucBGOCMT27TVwLjL16wGIINpdASf5GdJuhYG6lDDSJ87+W3
         CG11R/fLf1S1GHE5yvDaJqFWhNwkjffpLaY4IVriCQ0l9ZJ2/ixO3C/HOGVEliRwgaje
         cT8wUXiz3nnjhg0okHXRkuFSSCz3MfRbjzNuC+f1b6X47F74l8QJhILxJTYIwCukiHLJ
         TGyg==
X-Forwarded-Encrypted: i=1; AJvYcCUeE20qxew57HOpgJgTjHP27BIlq+eLOEDsONMQJHaCTnjSIE2WsvaIMAiSLeU8jitxf2uaH2HeCablp1/zwg==@vger.kernel.org, AJvYcCVwha4Rw4dSHWxhHqfi54YDJHy/73nZpXkcKN99z7Tlw677hRC1vNhWfHbcSV5HgzsajtGQnedaI9bj@vger.kernel.org, AJvYcCWtA/sDPlHH92/Zv1mHqaNW/xJZAHMt0qxNKmznFvKti+/d7GSls9s562z6ri3NVd8IplwlfE2MchzydN0=@vger.kernel.org, AJvYcCX2hjkUXj0Stsws5M630J+4JoYT9Vb5QkXU9mjodb7uynM5TqDqaJx6VDepgMJ3J+Asl76UrDrdPOoW2rv4@vger.kernel.org
X-Gm-Message-State: AOJu0YyPMPHtp6AH3aole9OaS60Wg0FY1e98pZocGmI4Dl0AO4iM55vB
	ihtFZQF+ykYELnBiTPszU693rtN5f1g9ZnC/A0FuBOwsKOw2vDJrqRdGLkGi
X-Gm-Gg: ASbGncsKn5l8mw/rCtHcpVlNfL0vt9BzRabLugNaDDbUReGRd6wvY0727jLtDr71Iqy
	orgS92osTP0cZYf++uobUsK6c2bT6VlzD6g8IDJnQKo9CvlvZl1y2c2FWFp1oOWfA8BRrAINfXs
	eSHWudUmPtCbD+NSnYs7jYQiJAh8zzpqivYe1HSxHVMLap53/zJdd88JDqpSE0QUUh/q1ta6mwz
	fqyWaVWZKxNjGOkaU9lPXAQPjkEiKzGSuNVkUZJPSroBooJ43jmOr1I1pJgUNr1Z7QKSna+ecWT
	NG3824mw+6cU2PM4Y1HSrVXE4HRTbtNXRkvE/h7zV1t/kSl7QHTLEr4URR/LxIBDM6omYhZpIKx
	JEgB6s0k0eZY=
X-Google-Smtp-Source: AGHT+IGK8W1ulz1rqCWNtWhzDi7y6+XmdCKftGr72HNdqdyMYPhgG5vfge5b/TrjlBcrh59H9zkW3w==
X-Received: by 2002:a05:6102:38cf:b0:4bb:d394:46ce with SMTP id ada2fe7eead31-4c38311c3dfmr11424948137.3.1742295088753;
        Tue, 18 Mar 2025 03:51:28 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d90e8c43asm2026998241.34.2025.03.18.03.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 03:51:28 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-52413efd0d3so2262813e0c.2;
        Tue, 18 Mar 2025 03:51:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9BRsrE+ro8YMqiwm9mLHwbN3cBCYVdc2Py/m5AQpJp0LtmcDpWSdoVd/i6I+SX8JV0l7k/pbRs1gqw5M=@vger.kernel.org, AJvYcCVR1Tx4Xa6lmRSwA5yjZiBywI3qitQxTOh1iDlhIwRy4gDBSE9IfB4Z96+V4nGfXZYVBEMLmbodhoK5D0QmMA==@vger.kernel.org, AJvYcCVi/JVzTfuO9JBowpV76QT7Op2r48tXj4c6S5amyfORi398b8AmXs7fg05Ef6lPSrFRunxu8b8vf8FFDb7c@vger.kernel.org, AJvYcCVi6fbeEjQfKlTuZmcDsxQyqvVNnQ6xin0Z2yUL5SsRXQQqf3pNgUHcONbZpmfFykW3jUrzL77UEd+F@vger.kernel.org
X-Received: by 2002:a05:6122:400f:b0:520:42d3:91d2 with SMTP id
 71dfb90a1353d-524498ae7d1mr9420222e0c.1.1742295088389; Tue, 18 Mar 2025
 03:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203142343.248839-1-dhowells@redhat.com> <20250203142343.248839-4-dhowells@redhat.com>
In-Reply-To: <20250203142343.248839-4-dhowells@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Mar 2025 11:51:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX0ShSafh44_D7D9GW5OzxYPx1NUc4uxpsKe1jAiTsBaA@mail.gmail.com>
X-Gm-Features: AQ5f1JqexfcZ4Wr8wl7KhbMINkBkWsh1eamHniftlMSeRlz46aDdMofNJr-x84g
Message-ID: <CAMuHMdX0ShSafh44_D7D9GW5OzxYPx1NUc4uxpsKe1jAiTsBaA@mail.gmail.com>
Subject: Re: [PATCH net 03/24] crypto: Add 'krb5enc' hash and cipher AEAD algorithm
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	Marc Dionne <marc.dionne@auristor.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org, 
	linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Mon, 3 Feb 2025 at 15:25, David Howells <dhowells@redhat.com> wrote:
> Add an AEAD template that does hash-then-cipher (unlike authenc that does
> cipher-then-hash).  This is required for a number of Kerberos 5 encoding
> types.
>
> [!] Note that the net/sunrpc/auth_gss/ implementation gets a pair of
> ciphers, one non-CTS and one CTS, using the former to do all the aligned
> blocks and the latter to do the last two blocks if they aren't also
> aligned.  It may be necessary to do this here too for performance reasons -
> but there are considerations both ways:
>
>  (1) firstly, there is an optimised assembly version of cts(cbc(aes)) on
>      x86_64 that should be used instead of having two ciphers;
>
>  (2) secondly, none of the hardware offload drivers seem to offer CTS
>      support (Intel QAT does not, for instance).
>
> However, I don't know if it's possible to query the crypto API to find out
> whether there's an optimised CTS algorithm available.
>
> Signed-off-by: David Howells <dhowells@redhat.com>

Thanks for your patch, which is now commit d1775a177f7f3815 ("crypto:
Add 'krb5enc' hash and cipher AEAD algorithm") in crypto/master.

> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -228,6 +228,18 @@ config CRYPTO_AUTHENC
>
>           This is required for IPSec ESP (XFRM_ESP).
>
> +config CRYPTO_KRB5ENC
> +       tristate "Kerberos 5 combined hash+cipher support"
> +       select CRYPTO_AEAD
> +       select CRYPTO_SKCIPHER
> +       select CRYPTO_MANAGER
> +       select CRYPTO_HASH
> +       select CRYPTO_NULL
> +       help
> +         Combined hash and cipher support for Kerberos 5 RFC3961 simplified
> +         profile.  This is required for Kerberos 5-style encryption, used by
> +         sunrpc/NFS and rxrpc/AFS.

Hence shouldn't the latter (e.g. RPCSEC_GSS_KRB5) select CRYPTO_KRB5ENC
or CRYPTO_KRB5? Or am I missing something?

Thanks!

> +
>  config CRYPTO_TEST
>         tristate "Testing module"
>         depends on m || EXPERT

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

