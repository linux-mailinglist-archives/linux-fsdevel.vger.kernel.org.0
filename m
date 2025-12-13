Return-Path: <linux-fsdevel+bounces-71246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B951CBA722
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 09:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCA5730B5B38
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 08:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BA72882B7;
	Sat, 13 Dec 2025 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QDKFUO/c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4DF285CAA
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Dec 2025 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765613169; cv=none; b=ahgOs3Lo5l2HsBubd5/P9WIgfk1CcLINpnejS8d7/CEUPbWZANh0HvwtuQfDZJzKL+8MuZTdzseGtyDWErkzcIvnkWXE536zfM09Rfo70gWdW9IdS3lj8o08SZwul9H1q55EttEtOzJFDp6wyJTG6RJDhQ3FLsdUgS0AHGMNU1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765613169; c=relaxed/simple;
	bh=RttTK+2nFeoQc0gx6XDB6WpCdREZepPnlbjYMFVrvo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=niFKIHMMP0l8GrW9UIRCbH4h8eM4lOG1LCpHAFYRaaz9if0Q4lKA6D372nE/HnQl8YJnuFvbef6Y0dMPLbdZ+HXyNm7LCJs92c5qlvqx/AxcEAAKnungkQ6HXDwjo0epOYEopuPNqH0dkECz94g/lMFcKhcljsLuFeWqcHoXShk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QDKFUO/c; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6495e5265c9so2911825a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Dec 2025 00:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1765613158; x=1766217958; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dly3pK0fQYfOoiUZDAVSj+GqwfGkYQ5ditNi4VkNN0A=;
        b=QDKFUO/cVd5ix+39TfAq+q02Wkugq/3zo5QP624TAQyZzP+hN0GZVrc8BUsGQ/6Q6f
         pg9+xxuaLDv7Uzs6mXeN/LOmw9LtHGVQNB60jZCaFw25TtKI3iOkKV/rN3qn+FmLtGhc
         r3zavwXRW1asjW0fj6ij8r0R8vCEtA5a9mlEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765613158; x=1766217958;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dly3pK0fQYfOoiUZDAVSj+GqwfGkYQ5ditNi4VkNN0A=;
        b=pI87DfngBjOutDfxWgRAO99rezLCK3AoPS6IlfdQraHcjxU+ioIlPw2sPFS0G9KoRL
         Mj0UDr6cOKl6/fLvI5fWGBC+XhVLIqxGIvDu7j88d1FpEZwpjEQha+8psAA0ZdHfp7pX
         8cj7d1g/pBJYZbjqldjW8TAJ4QhOSNNVcJ4I+DNs9Rr1zhsvCj6b1sUoXJs896yQ0AWK
         BlorcPZ0LvX20pyZyA2jZ88Bm9BNxnPgxgSJJ4Aq8FMq7uNZ0IcL9DNi7s0fttpTNRsl
         5/6QkQKeBO6nmKglijMeSuOryOzw8/7nqWwQzyCqoTAShOdGnhty3H9eLKawqfxqypbH
         ZT8w==
X-Gm-Message-State: AOJu0Ywv/l3oDtdx32Yp7dLjiVZyGznUjGKN1n/IIhorgt1UsuNwXeXq
	F6pYIUvUjou/f+nyir9CuFpKMx7wHaSouerUc5oYb2cb3Be42vmgs1qd6m7iS48xjl751P+J6j9
	6tzJVXkr7dA==
X-Gm-Gg: AY/fxX6Z+5gyNT1X7Lhe7OScaPOH/UyrmkHQRCfIfYuVW7Ce0bGh7PHLo/1KfC22a26
	pryGEyeJ1beKd2KmwOQ0Z8D4j1DJN5eZXoJq7vPq7LWkgrBbNU1h6j/BhDaugp+tY3+BbxyH5/E
	FCYjT70bXnGQl5rSLgedaZ5sOccDsl9vbVbSUQGGRqkogKpcm5PQeByG16peraJasFiu1vnQN5e
	V95KqNr0Gi/p9gj2KRdTaccZaCmh8b42ptIadROU/AYHtJc1j45EYC9lax3WMFgCXAkFcW79V4d
	d+OTP6lIlrWcT6efSo/0bzxeUdBbDXvStET3/t51qDbjGY2ROr6LYLAomTIMZiEpqEGlMQAwa1r
	5CILnMsn2sXG8c7vATGCWh7cS+74vDBjK50xcJglHkOkcw6sZbdwdxrLlfatexpn1x7PkQVbw2c
	SkJ1xd3GQUl9NnLwJIzGB7GuJuSb20BM8MYnhuyUOT3bK8nI8/ve9vxtbnneXc
X-Google-Smtp-Source: AGHT+IGz546o7tpCC6wv0uKH7VFzF650lY5A/kN6kZLsISGcUrKmAmDP6mZtX5xaG2dXLz1BXYIYcg==
X-Received: by 2002:a17:907:980f:b0:b7c:f77c:42e7 with SMTP id a640c23a62f3a-b7d23ad6abfmr487441066b.43.1765613158562;
        Sat, 13 Dec 2025 00:05:58 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa51756esm800346266b.44.2025.12.13.00.05.57
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Dec 2025 00:05:57 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so3840317a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Dec 2025 00:05:57 -0800 (PST)
X-Received: by 2002:a17:907:cd07:b0:b76:2f40:a307 with SMTP id
 a640c23a62f3a-b7d23b41493mr447008666b.57.1765613157231; Sat, 13 Dec 2025
 00:05:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251213-distanz-umgewandelt-c6179aac18d7@brauner>
In-Reply-To: <20251213-distanz-umgewandelt-c6179aac18d7@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 13 Dec 2025 20:05:39 +1200
X-Gmail-Original-Message-ID: <CAHk-=wgF4AEK6GPczjHCy9HAG7XDded=EBSzxztX_wq0-YGGuA@mail.gmail.com>
X-Gm-Features: AQt7F2rNS19KJ77pE4G43RmeqZ5KOAMp81er8MaYfcqGjpyHmmt-61SF0RIz-aI
Message-ID: <CAHk-=wgF4AEK6GPczjHCy9HAG7XDded=EBSzxztX_wq0-YGGuA@mail.gmail.com>
Subject: Re: [PATCH] file: ensure cleanup
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Chris Mason <clm@fb.com>, 
	Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Dec 2025 at 19:46, Christian Brauner <brauner@kernel.org> wrote:
>
> I didn't take my second hardware key to Tokyo so I have no access to any
> mail or relevant servers right now. I get back to work on Monday. Can
> you please apply this directly?

Done.

Thanks,
              Linus

