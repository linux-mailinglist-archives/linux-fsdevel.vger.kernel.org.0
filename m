Return-Path: <linux-fsdevel+bounces-38849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B167DA08CF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 10:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F373A8F64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 09:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF4B20C03F;
	Fri, 10 Jan 2025 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KReXlo1E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED7120A5DD;
	Fri, 10 Jan 2025 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502488; cv=none; b=jctq9F4wVtn2WV3qr3sPUnhKx7+oa3wLV4T4XrPnXJJbup4HnMIlnihGvvHpxewX3s2W7OkJxKefJzIw1jJYLY4O5dK2cVKaidYOejPW0sEQ2HITlGPBhgO7d8JqeTAm/IzDx+CUdQfeR5YM+G5XOuhMIco2TlDHrmsx7vYNSZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502488; c=relaxed/simple;
	bh=mtBp3AyjCM/ZWQ3Dt+JtvHpf0ZzFbURIvx/WMvyfUuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+RmW4IXMZ+itA7gZo4W3kWKR8QsxNMVLOkbTUgUPnxYL5Ep/Mdb1EMPFxThyOsF77cyNBXnbq3lyPjxUgU6plqWJeaZi0L/cMOAhiQJSjzDjt5KFFyF0ZJYQqsIXJsoZESxKop8JvnDQg3LiUCvrmyXTN+o+1zVY081o/68f+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KReXlo1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B09FC4CEE1;
	Fri, 10 Jan 2025 09:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736502487;
	bh=mtBp3AyjCM/ZWQ3Dt+JtvHpf0ZzFbURIvx/WMvyfUuI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KReXlo1El0w8Eap63jMfFIWC4zPSM2kfOrgoj3Jkx31AZjSNdG0fH3RYQ8OfbtH9o
	 LlsKxxkkVgJ6xAWIWWnqvumXm0B1JceDx7P97H8XmNBwXQnQT5/bSt4N6rTltt/biM
	 TiuvOPlYJEc0NxoetkPFTIhpKSAL4bCnD5BJc7jZWTXfM3GWJOmRUdFcsek3XU3RXH
	 EZvpslsTygAb+pwz7iihaBmhmnvuC3dQbyV97ITCqBLLDYYoLsBgB4FH+UChAxiEZQ
	 Sr7FC2Ky7vKsfHXieyhcF6+1u1fKDCnUFyGCg5Z4P8UNRaApimY4N37hm7UKa3N5Zy
	 QqjhoEGN2AW1g==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5401ab97206so1888363e87.3;
        Fri, 10 Jan 2025 01:48:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUrSYfhjj4VD9dt4YQh7UK+E+7RL+/RYIEoN91zYO+OjTgov4MXX6tkefUzXo7uQEARkyaligjjrN22Yso=@vger.kernel.org, AJvYcCVEBDbvKsrw0A1THKNP8vCSMJyNvOrMkb2HfmtyVtWIvnzW4brnHwzcxYofeQwih4VY8fvVTxiH@vger.kernel.org, AJvYcCVr6ual1KIDaJYTVo4PM47iKIrosqlPqOiKIO0gDe3TnvnJFSvYmUALVJinopqSEcfxqhHVnHK2ppfs+1bvDw==@vger.kernel.org, AJvYcCVtwTUW1ldjezhq2gmdVHB2dlvdV3j8MVCj7vFLxQYx6hW/YoCQ0kQEeWK1mRdjrHNlAmMdCKvS5wzrkgbP@vger.kernel.org, AJvYcCXlc/0KlnIfPUndd8IZ1cfFNS31pN7zUFCmCdVkVpZDiczVpVS/L3t/w513sAGotK+ThbY0mJH8l6Rz@vger.kernel.org
X-Gm-Message-State: AOJu0YzhBWpKGxbGR87sxMuIJ174bxayl77gnExTaOUmixJgdyvHTti6
	fUkUnxSQh/l5w7ElJcSdVG7F2o2lLEQOehtKiXbrKWPyY24g+vpYjT1h6gSLb811jFbjqsv+2Vl
	0xljRbI2rO6x15JynhGN/zTXKz6Q=
X-Google-Smtp-Source: AGHT+IGw8EE7iwyfzN0h+0xxLtGtpQdXnmrLV+5rsgOpOep915zSvu0wEuCxYBjpYwWkvDsdG3N62lBbWn0iggorhOo=
X-Received: by 2002:a05:6512:1196:b0:53f:231e:6f92 with SMTP id
 2adb3069b0e04-542845491ffmr3512417e87.34.1736502485591; Fri, 10 Jan 2025
 01:48:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110010313.1471063-1-dhowells@redhat.com> <20250110010313.1471063-3-dhowells@redhat.com>
 <20250110055058.GA63811@sol.localdomain> <1478993.1736493228@warthog.procyon.org.uk>
In-Reply-To: <1478993.1736493228@warthog.procyon.org.uk>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 10 Jan 2025 10:47:54 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE2mhXJaa9uq==Xki3On9ZKYY+KV-oH0ednqWC6b9BTYw@mail.gmail.com>
X-Gm-Features: AbW1kvZNBd0gTj-dTR8eQGzNskVAFPXnGvmvtM6UKqY4sqGaw8a7UTaWuNi-eRE
Message-ID: <CAMj1kXE2mhXJaa9uq==Xki3On9ZKYY+KV-oH0ednqWC6b9BTYw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/8] crypto/krb5: Provide Kerberos 5 crypto through
 AEAD API
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Chuck Lever <chuck.lever@oracle.com>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	"David S. Miller" <davem@davemloft.net>, Marc Dionne <marc.dionne@auristor.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-crypto@vger.kernel.org, 
	linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Jan 2025 at 08:14, David Howells <dhowells@redhat.com> wrote:
>
> Eric Biggers <ebiggers@kernel.org> wrote:
>
> > It sounds like a lot of workarounds had to be implemented to fit these
> > protocols into the crypto_aead API.
> >
> > It also seems unlikely that there will be other implementations of these
> > protocols added to the kernel, besides the one you're adding in crypto/krb5/.
> >
> > Given that, providing this functionality as library functions instead would be
> > much simpler.  Take a look at how crypto/kdf_sp800108.c works, for example.
>
> Yes.  That's how I did my first implementation.  I basically took the code
> from net/sunrpc/auth_gss/ and made it more generic.  Herbert wants it done
> this way, however.  :-/
>

What is the reason for shoehorning any of this into the crypto API?

I agree with Eric here: it seems both the user (Kerberos) and the
crypto API are worse off here, due to mutual API incompatibilities
that seem rather fundamental.

Are you anticipating other, accelerated implementations of the
combined algorithms? Isn't it enough to rely on the existing Camellia
and AES code? Mentioning 'something like the Intel QAT' doesn't
suggest you have something specific in mind.

Also, this patch is rather big and therefore hard to review.

