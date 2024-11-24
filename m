Return-Path: <linux-fsdevel+bounces-35736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33C69D7912
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 00:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9D71623F8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 23:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394371714B3;
	Sun, 24 Nov 2024 23:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQxw3xBh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DFC2500C0;
	Sun, 24 Nov 2024 23:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732489544; cv=none; b=WiRE5/egBkuEnv5fJAG/PPdFK5qOsVu7KSK5MwcsQ674S/kMh7Yq/zIaPza8V4BM1zoOJaJhIlWkCO2Cnd7kITVONEJ4+cLYhbhjvy0JqW0EWBnFFWX8xiXYJZKFWXJU3liVDgL1+lvITGvsY/D4k6gsppVa42qyTKMSn2sqGrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732489544; c=relaxed/simple;
	bh=KLRJvu6F6F2eBrKI57rJhWuxm8YzvfPXkTaPYw+/sjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dky80SIP4kxuc6lpPRvD1sLnFMxdj2OMEkf1thTbM8NsYAmCN8BNSTQH7s2Fdg9OZt7Qj7ZWv+TcfYEQp8OBUQhVMZQ/tUJdijKffQdGCfnVCVcdNXF1/OOk5sxlDShFX6Vk0AbgLlP6v+IMbKaaelL8evYkYwl7Aa1VX7PdYJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQxw3xBh; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa51d32fa69so329113966b.2;
        Sun, 24 Nov 2024 15:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732489541; x=1733094341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLRJvu6F6F2eBrKI57rJhWuxm8YzvfPXkTaPYw+/sjE=;
        b=SQxw3xBh6GKICDWDjpg8n8N3xO1lLPQBPhirM6GiZ1Rj6iMEvmqOH7cMa3hWuUBYU3
         Nq8RVqMiFKbH1YU4zbKulUKprynVodmLlaJlgxt6d4m2a3R0sXc3+tk3qVzbFB362zup
         Fxkdy/2mtYdUYlWyFw1kT1i+TYOGKf7alRNrxUp/3SNwj8llMLIQNihQDK7BElLzLEzl
         I+EnHMvOA6RxzyO5ELq4cveF114NGuVd3k+GIPYm9Ww0+CjEQenvCSyarwySCeQ1UZ9H
         3ChugfLo3ywJnoM0U3evmJUwswYdEdEHQVGUAZLppZuszhWHENcYES6dZ5ovmjLZREgF
         gBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732489541; x=1733094341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLRJvu6F6F2eBrKI57rJhWuxm8YzvfPXkTaPYw+/sjE=;
        b=ooaco/bKjWrAKm9lazx0Tfi9rRcIQB8peLjh+eZYQluLiyjNHk92sEUBybBUy4cMXU
         2PaleVZNynYoAH4YK8EdAX/FQdHE4Yd7BXeANBe66DLZkg45CiXy0ChtwWwxdcx73tzz
         ywe42D7FO0IruNkM/nSegYeC7E0nevtwLJchwgpym6+sAJqcXJG2ycqpPILOpOPcO/gh
         Vq/+vQJ5v2f2ak4GKiHoWKZBtozO2PFhwtb4AqksDmSLhXT6A6mFrvokFIWTB4UQhv33
         DHKnKrsfHP3EjxwIm1nWILq+zwgDCGSlQ0w+CK/u9xRdR3+dYH03wegBUQKKWAM4JcWt
         F4Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUdlNaIob8J1lGVPmVHIz8V8OZaPvadKC4l2IshTqHHFsbyIZeREHVmJ1fhzU2AVZHW3hvx7zi9EuIHKy4j@vger.kernel.org, AJvYcCVqSUnNt2FQItZQeHSCxjWSdPyw6QJ/KGFQtnZZRMwlbazT2mT+N3Z85VpLEn7x37zWckDsNRdYmm36z917@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Ll5lkZwEOR1iSpiAycVZpTp4xxzPVuWQFN51Ral3rD5xLN1x
	bjbUxoZKmJLc1lthZf2SjxWK1zy3u3K0Hi6pmVsufmWX6OUwRguoegXDv5JzgxrzlpL4Z2oIX1u
	BZVIQYkai/umTCrJhBTdN2EtL5co=
X-Gm-Gg: ASbGncslju7IfvnHploJMiCMUpcJ1E+CoFIZNTExa/k4+A4H2+e+n5NqmgwJ9BP5wqF
	HJTJ2SYXABgReKgeSgs6H0WEJef79CAI=
X-Google-Smtp-Source: AGHT+IGuusoOhvt1Q/m2LWuIO3jTUKliCFi27QGYvEMYqh/sTP+hYSjQpAl13IkZmip3FkZekkiNDJPny7mR+FTXCys=
X-Received: by 2002:a17:907:7817:b0:aa5:3168:ad3b with SMTP id
 a640c23a62f3a-aa53168b1d7mr609375666b.31.1732489541117; Sun, 24 Nov 2024
 15:05:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <61292055a11a3f80e3afd2ef6871416e3963b977.camel@kernel.org>
 <20241124094253.565643-1-zhenghaoran@buaa.edu.cn> <20241124174435.GB620578@frogsfrogsfrogs>
 <wxwj3mxb7xromjvy3vreqbme7tugvi7gfriyhtcznukiladeoj@o7drq3kvflfa>
 <20241124215014.GA3387508@ZenIV> <CAHk-=whYakCL3tws54vLjejwU3WvYVKVSpO1waXxA-vt72Kt5Q@mail.gmail.com>
In-Reply-To: <CAHk-=whYakCL3tws54vLjejwU3WvYVKVSpO1waXxA-vt72Kt5Q@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 25 Nov 2024 00:05:29 +0100
Message-ID: <CAGudoHEqDaY3=KuV9CuPja8UgVBhiZVZ7ej5r1yoSxRZaMnknA@mail.gmail.com>
Subject: Re: [RFC] metadata updates vs. fetches (was Re: [PATCH v4] fs: Fix
 data race in inode_set_ctime_to_ts)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, "Darrick J. Wong" <djwong@kernel.org>, 
	Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2024 at 11:10=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> So I mention the "rename and extend i_size_seqcount" as a solution
> that I suspect might be acceptable if somebody has the motivation and
> energy, but honestly I also think "nobody can be bothered" is
> acceptable in practice.
>

So happens recently the metadata ordeal also came up around getattr
where a submitter wanted to lock the inode around it.

Looks like this is a recurring topic?

Until the day comes when someone has way too much time on their hands
and patches it up (even that may encounter resistance though), I do
think it would make sense to nicely write it down somewhere so for
easy reference -- maybe as a comment above getattr and note around
other places like the timespec helpers to read that.

--=20
Mateusz Guzik <mjguzik gmail.com>

