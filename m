Return-Path: <linux-fsdevel+bounces-21672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD2A907CB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 21:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA96B1F23FA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 19:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EEE15217E;
	Thu, 13 Jun 2024 19:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IW0NQsVR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D69914B091
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718307261; cv=none; b=fyuIzhCmxkeDfauLY7ipYL0NAYYX1JT8Rfdk7wuHXgv4XJvk0E2pkwIJSK1PTImcT1rmUu+oEMU3cQ2aKNW/cPdDcL7VuI60irObbXm6eZzVCDSHedjnDd1+NF6pbHi8y0yk5oG/EB6st9lnzRKHtxtpvqL0+CgfZr2Edb9BBB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718307261; c=relaxed/simple;
	bh=Lwk7smutNQj9Ma2l6ms8QeeuTagK4tf2FFnHtSPVUfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHEbEowI2RaHP8oLOhuqXQgY03cV7EdKXNXBJZixy+D/M/TBCi/HhAOhk1ZOSDDzrg6zGwYaFUFEQdcRXZSEjfp/8PuiEYXJaTQm0VonTQaEnNb/kkjBtFWd2QVzgI5jqebbtZTRJELywZHJWQEizeYlQWfqvQtCiY1UnNTJCl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IW0NQsVR; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6266ffdba8so175120666b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 12:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718307257; x=1718912057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BZg0hrY0cl/sTszXcVnYwhyU3X3/PKHb3J+JILn3ksY=;
        b=IW0NQsVRX3Wf9NS48HWHJMiflIPZgwaLXPZm7Y8ivxdlBbR05Up0IQLkY7k58de6gJ
         faCCH/nASJG30RZcVoA+/4ErLh9YWlP4QCOQYpPqKGngTlKn00lBqRQcTseQI2OJeoQS
         Wanz8ICQM0pUsi/ikf+HpMgUVUa8P9LNjuXnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718307257; x=1718912057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZg0hrY0cl/sTszXcVnYwhyU3X3/PKHb3J+JILn3ksY=;
        b=bRNu+uo59xWFwhsbLW1qN5t+M46r/yBuNxsBIEXFJXzpdQAAoVDgSZLFHEjm8xCfcr
         3269mbNxIBJCtqOTX+9SGF6MtVsV+6CdhhAsIIY7Rou7bJCK7zkVe7hDJeGURXyxjaMw
         vPtrgF1Hx6iz1tj/AXauhmpvyzN2P6u1BeS9VKQ1hEF5Fcm95ibq4q3eYb1pdsXmvej8
         okVy4mr7iiu7DfQ3h9ABbWLJvogKG9e66GoI9dnp/TCE7QpijGxX5tM0U7/XhC+IHxAw
         +CUDRprFdvLGcHsc6qsv8E+iZDDIUp31ZFHAhPB7g48EMLL0awLS/wmV8GLjZRce3tRE
         Q6xA==
X-Forwarded-Encrypted: i=1; AJvYcCU6q+JrLdqrVey+ANhHZFS50ym20sX5Cl048QS/o0Vt4MbXmGbCquhQaM+Qq93Nc9XDYhcS50YhmdGcixcTT1gWjo0w/NsYNApJWkFBFQ==
X-Gm-Message-State: AOJu0YwRA6Hg0mkRG3wUKMR3zzWq4deHlZTJwk8e3CNKyiAsJO/TGWtc
	I4U2fxGuqtW6PdSSi2BTlTV61pbo28SBncXgXIRF5Cyr4SHf8lNfNEDaUuty3jcBn0C/ceubRYA
	0qSqgeg==
X-Google-Smtp-Source: AGHT+IGctalnh/PGYzlFKdygGOHU4ARW+2y5wJdaLfRA5uwXa67+TwWNtZwUb75oKwVEhZ0HTdT8TA==
X-Received: by 2002:a17:906:48d:b0:a6f:501d:c224 with SMTP id a640c23a62f3a-a6f60dc4dd6mr46321466b.57.1718307257380;
        Thu, 13 Jun 2024 12:34:17 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db67e5sm102568366b.66.2024.06.13.12.34.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 12:34:16 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6266ffdba8so175119266b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 12:34:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbhYtbsmK9c81ZqeA4t6VBobH2FnJBCMA1WV0Ab5NsSKPfYAJHTDvvdvqZ6nP/SNiHXo2xJHW8T8VBlL1ijigTmNWZo0Y5X14CRVvSeA==
X-Received: by 2002:a17:906:f105:b0:a6f:586b:6c2 with SMTP id
 a640c23a62f3a-a6f60dc4faemr43433766b.60.1718307256510; Thu, 13 Jun 2024
 12:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613001215.648829-1-mjguzik@gmail.com> <20240613001215.648829-2-mjguzik@gmail.com>
 <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
 <CAHk-=wgPgGwPexW_ffc97Z8O23J=G=3kcV-dGFBKbLJR-6TWpQ@mail.gmail.com>
 <5cixyyivolodhsru23y5gf5f6w6ov2zs5rbkxleljeu6qvc4gu@ivawdfkvus3p>
 <20240613-pumpen-durst-fdc20c301a08@brauner> <CAHk-=wj0cmLKJZipHy-OcwKADygUgd19yU1rmBaB6X3Wb5jU3Q@mail.gmail.com>
 <CAGudoHHWL_CftUXyeZNU96qHsi5DT_OTL5ZLOWoCGiB45HvzVA@mail.gmail.com>
 <CAHk-=wi4xCJKiCRzmDDpva+VhsrBuZfawGFb9vY6QXV2-_bELw@mail.gmail.com>
 <CAGudoHGdWQYH8pRu1B5NLRa_6EKPR6hm5vOf+fyjvUzm1po8VQ@mail.gmail.com> <CAHk-=whjwqO+HSv8P4zvOyX=WNKjcXsiquT=DOaj_fQiidb3rQ@mail.gmail.com>
In-Reply-To: <CAHk-=whjwqO+HSv8P4zvOyX=WNKjcXsiquT=DOaj_fQiidb3rQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Jun 2024 12:33:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whtoqTSCcAvV-X-KPqoDWxS4vxmWpuKLB+Vv8=FtUd5vA@mail.gmail.com>
Message-ID: <CAHk-=whtoqTSCcAvV-X-KPqoDWxS4vxmWpuKLB+Vv8=FtUd5vA@mail.gmail.com>
Subject: Re: [PATCH 1/2] lockref: speculatively spin waiting for the lock to
 be released
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 11:56, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I didn't *think* anything in the dentry struct should care about
> debugging, but clearly that sequence number thing did.

Looking at the 32-bit build, it looks like out current 'struct dentry'
is 136 bytes in size, not 128.

Looks like DNAME_INLINE_LEN should be reduced to 36 on 32-bit.

And moving d_lockref to after d_fsdata works there too.

Not that anybody really cares, but let's make sure it's actually
properly done when this is changed. Christian?

              Linus

