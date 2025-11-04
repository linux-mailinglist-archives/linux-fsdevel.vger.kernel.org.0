Return-Path: <linux-fsdevel+bounces-66916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F79C304C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 10:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 685CF34D8A3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 09:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB17B1F91E3;
	Tue,  4 Nov 2025 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W/of/Q6a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3AF311971
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762249088; cv=none; b=Tsk6kV6buhtPJ1ui+z4vsaf9w3QSgxciSu1djXBaPrc9qH2t78hB3g5lQT+N/mcm2QH+ZOCRdXCGw/4wSW5rAHBSTJSj7gfzEEbmcGT3TeQ5K33wGKsGbMyu+irYmGAvEJ5uFMXpNAvmFDvCPOY2LaA5bA4v2qXwqKT61mkloV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762249088; c=relaxed/simple;
	bh=72R88Rn3rGukSOJyhGw/2xZ+YQukQNHhATYbzzxBpN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMsZ1h3lz2S2x9mCHil04MVTHsSAmIZRE5oxPhxzIZEhUNcO1qZiDfLFoLemXpU3VPLmGor+mjxena8/8VGCzz3xmEAXP1xyJZ3aDjuCwkbV3d5LnsHnmKIg97B3ER0+4wUuDtX6jeTOLmlamWW0zAL+TV9Xle1AtvTX7XYNdp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W/of/Q6a; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b6d3effe106so828712766b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 01:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762249083; x=1762853883; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4fFCVmjL0Fz2iZG689nRiXgSeTQjOQSeq4YnYrnmIn4=;
        b=W/of/Q6aoHFv4Zc89i7Nc5PSi3jvUe6utaZyOIee7XD0mcHsGpEAyAOJLASzThU7Zm
         u85/lmI+BdL3IlhY9Tsoc7Cx7WSjL9vwfANGpfSC6wWUBw6Vc4ZcZSB1SzWD2JBnap0l
         PdsXBDs4NQmbAZYfLVr+dvJoFKBYgvS1JtqoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762249083; x=1762853883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fFCVmjL0Fz2iZG689nRiXgSeTQjOQSeq4YnYrnmIn4=;
        b=jXmyL1IcVZpDNg0dx84f+xUTA+AcBwsSbITAY3Cvt4x5XH0OH0XRG1+MBGkguq2e6v
         JNgOcGSnC/b0ZJv/Y7QuvPSnG9GkxHBFnPbZNpwl6Ym0b5heMEsxHfrggSxkT+vVI3I6
         3y7lJqVuO/sEXYIxPARgPmInRaix7m0kxG+Qm5Y0Z5aKnpOU244ZoyGwsPfjmZYJf5cb
         8EHzDqyEWmbsiocAocbf+5Mhx0Oi294t9NJLt98YqHW1c5Tymdeb3xdhdD9oCUNKhTAF
         pendCDI4Qi3ubdsOmSAzfZ83YXn1rVUhx3uZ8pIOcp3eeoZ/lpgy4vo8QOraNnOuO7BE
         IJJA==
X-Forwarded-Encrypted: i=1; AJvYcCU7oKgkTHVg8EkaU7FU9reJSo6dlmy6Mn5BwAKEeWEI6C4PIQXi5t+KrPFZ23CVy5m0xKUyqG/QtdLd/gXT@vger.kernel.org
X-Gm-Message-State: AOJu0YyEdji27iB5yYVqRp7kLJXH5P0gjihS/kydH/ILrLIvdDicpTC6
	z9QnhgCGJuc1JdnqNCb+sZBJlopyE/NoJ0BE5+lO4Wz+GqmszFhOQKIwMCNZm5fenAgDgueC9ZG
	E6bdEGLVC/g==
X-Gm-Gg: ASbGncv3tH53nCrA6X41k5mDUJILM1khmuSHYuzr6T/Tjo+UAXkaIdU8lnfcTwe+lg3
	TOzIzzNfKXtKjCUTgDGN88E8741by9CzuHqKPReKhOSmprgf4hdxdrd1pjtw4hFCyecwPpOjC8F
	BWeWIk/gdIRpDKjZm9jiPcnxcY59rTkA5DCyLq4oz3nbZFZaxu0WuVYCNKPemlmHEKRSfFVgST0
	1R/fgHOPnDN0OPq4FRCT1MxrQbYVcmJD++764oA3lEyejQkyf1CeXDgjb3h+Tmf2Xg1R4r9QdnO
	flQeI1dJGRISm1wvqy0GlDuNXFLBXM0TvdDHdNAmJH8TST/O40YPPJe4L9t/uI/DvOIkyIFfHOQ
	sY61WbC7M9KEbFM+eL8nYEhOXuj1+qTVWMGLPDRM/XoP31VZQuZj7cutlz1Y1FsGXFQLYtw9/Qs
	Dax6aaKQowKbUIMpnfYysENLM6OokoUNBxdwoFHfy+O+3UqEtZ3Q==
X-Google-Smtp-Source: AGHT+IFU3I8jcHL5NLHOg6b3OxYO2DVB//xp2bXYQkba3/Wuj6g+VvmVKUMp7J9sKpx8ggCk79T3+A==
X-Received: by 2002:a17:907:6ea5:b0:b71:1420:3357 with SMTP id a640c23a62f3a-b71142047bamr543346766b.45.1762249083317;
        Tue, 04 Nov 2025 01:38:03 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fb05a02sm159137466b.58.2025.11.04.01.38.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 01:38:01 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b6d3effe106so828707166b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 01:38:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSIf2AaUpm1COx6DSVQeRGzKPOn6RfDx3PsVoK2WGxhlvBIYjWzVlaKISfh1YyvYdj32b7nYWdfqr/SB5R@vger.kernel.org
X-Received: by 2002:a17:906:c156:b0:b5c:74fb:b618 with SMTP id
 a640c23a62f3a-b70700baa61mr1757486366b.12.1762249081268; Tue, 04 Nov 2025
 01:38:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com> <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com> <CAGudoHESYkHNdZZ5j1KfZ3j23cEvPZUNWVuc7_TTKds=qNWt6w@mail.gmail.com>
In-Reply-To: <CAGudoHESYkHNdZZ5j1KfZ3j23cEvPZUNWVuc7_TTKds=qNWt6w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Nov 2025 18:37:43 +0900
X-Gmail-Original-Message-ID: <CAHk-=wjUWNCbq+GEvCRjBBKkRiJboGMjXMiRd5Z7tqKCyJkdtg@mail.gmail.com>
X-Gm-Features: AWmQ_bmYy6dvq-kHQF3LAm-hFoZjgaQ0Uxt5kmfzN_e8mdhKTNMNYStG4JPRvTQ
Message-ID: <CAHk-=wjUWNCbq+GEvCRjBBKkRiJboGMjXMiRd5Z7tqKCyJkdtg@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: "the arch/x86 maintainers" <x86@kernel.org>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	tglx@linutronix.de, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Nov 2025 at 17:57, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I would appreciate some feedback on the header split idea though. :)

I don't think it's wrong, but I don't think it buys us much either.

And it does make it harder to see what the bigger pattern is - the
code that initializes the constants is deeply intertwined with the
code that uses it, and you split it up into different files, so now
you can't see what the interdependence is...

             Linus

