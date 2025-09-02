Return-Path: <linux-fsdevel+bounces-60003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E183B40AAA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 18:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98C5486D61
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 16:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA21340DA8;
	Tue,  2 Sep 2025 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O614apoQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8593375DA
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830671; cv=none; b=qUpHI0QYh+o7iA7/nxmNNfEthsEOyPLpIB43R02UlWraxinKKqRD4Uv7WAXoy+BBp3zchYzFIAvoaDiDUoOxkIwH0oncZqf+8J7kvCaBpZo3IIP+jd3C1Xd3iwaHN1IXRrmr6wdmfly+8Du9D4XfOeZOxsbuZSrH2Nga/76VKYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830671; c=relaxed/simple;
	bh=0P2I2T1LAyCqTnkJ9VfJYe/SnE2+VU+9FNl1USJbPi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbqAbxBYJGNtuLoalJUFSnFsGPIcatq5picbqyg2N4anWk26n+vF68YuPJx4jzRF52g6rxx6m+x++vNdSme/csGh1HJqz2fEJH6CGpK3uyg9KByUYXRb7/VoExB+0u9ejtFBxvzqMdhs0YZzbTlHNcMqMuO02e+/77bOBVHGNwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O614apoQ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61ebe2ce888so1432178a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Sep 2025 09:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756830666; x=1757435466; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yPoyBpjue8NhIvnYr5J45YlODoceAn4KEOxCnAQM4D8=;
        b=O614apoQNdNaScF41pfT8ubD2vvtrv+ZFDmhjUNCK1kbkMg3d0sP/UiEZFGktyWD8d
         fD0BNEXLjnGvwbu6KgAH8dPgfD+uVygSlTUZ3snfFczUcTtL9e8/nGMAQmI7WufKi4Ea
         yAX2B/ISHPgJQLFmcjvh7o6gi2iaK+fkKDWNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756830666; x=1757435466;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPoyBpjue8NhIvnYr5J45YlODoceAn4KEOxCnAQM4D8=;
        b=sAcs8eRTADaROKmFwRmwA/Lh7guDdeSQms6xZPzzmkblLyoYT6pm3ttxt2Gn9KYSyO
         kL3R4U005KUWfiIr5V7OYgLfh3zESw3H+0lRc2iLU3BVYKoEt49cwIdjfhnM2yHp3hnE
         RfxblI/fEGdXX5K5nWP/w1f9czJgxxt61KbV6ynepN5PM8Br3y99HX9b0EVM0+iNElqr
         YIN0HRzlubZQ0hDlQd5RZ6pRMPQyXY1CN6IXH1C7JrZT2GNnr5suWNykkW9G7scJYItN
         s+7HqTCEgXrgM4fqOLw8VJ6itLgJKbVJVDVkVjpcTyBsLqEbo4s9s36ru307CWKeEJrY
         rMLA==
X-Forwarded-Encrypted: i=1; AJvYcCUVh3Vudsthxq2Vh0GX3cMPRcUPgL1VjzA8i+ahVjN8HvGO0xW8K2RUWJLkOwrDpM3UtITxtvpx29JgmkIB@vger.kernel.org
X-Gm-Message-State: AOJu0YykUz9IvQVbdiQjGcnw3/gEd8HfCNHjgqoEHoedUGm5xjqvcSnz
	AWa9oRRW/QTy7LwkyBelGNXiloLspeNOOF/Y5EQKqVLjHL3XcgcS0aasWwFFK0fbl6iBVeC/uXA
	agLXRtG4=
X-Gm-Gg: ASbGncv/H3KBZLxP+dPSDn585fcbUy/PNv3aV5dITlpmKaBQZX9O/9J7+CB8uNtZANB
	yKgpdriKyUbeTEnOHPiBMDS+lzIty0TXqmXCpJOAF6DMvL9CDbR90pOnIoNWyseNYBmBTdf0fI3
	5bT7KSTS9r/3OPVRZOPL/zHy+JMkt8cE6xtcG2ZInMLlJNi6d3ApDd+zGvoRDFN7ZtRe2IlqerE
	zEbXmm/KwiTmjsxLsZibPMRXhkdMELLd/HUCGUjwShss2GYB0sV4iY74sY1IGAKhS69SpQqD4zj
	mnJEmdbnC0WVJf/pimn+XqI1xozwHQS5XqkeYRY0eHTpoB0lcWofRzNRX/qWDrhdyHb45TpFXY2
	S9evt/MVcDCA3bCHdmJgrpsXmf+fh4GddKMFIkVJaNlexgsio7wOaZaargsa3NUjrPA0AAGMX
X-Google-Smtp-Source: AGHT+IFi/zW9YkfHwssMGhy6/fTtztXrwCOIeouebBFa752aIxs6guGsflpg7b0LF4BkVEaEq/zM2w==
X-Received: by 2002:a17:907:3e84:b0:afe:b818:a6bc with SMTP id a640c23a62f3a-b01f20ca2a4mr1165942966b.56.1756830666326;
        Tue, 02 Sep 2025 09:31:06 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff0681aefdsm1091741566b.8.2025.09.02.09.31.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 09:31:05 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b042ec947e4so359629966b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Sep 2025 09:31:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxECCJzVrpQhfJNp3BC4gn+fk7dxLTDd4rgm0M+OFaxZQP6ryPhHpR2h0hsvUVysj2KWILSHd2LcHJu5Cw@vger.kernel.org
X-Received: by 2002:a17:907:608e:b0:b04:2a50:3c1b with SMTP id
 a640c23a62f3a-b042a505d56mr838465866b.53.1756830665041; Tue, 02 Sep 2025
 09:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-61-viro@zeniv.linux.org.uk> <CAHk-=wgZEkSNKFe_=W=OcoMTQiwq8j017mh+TUR4AV9GiMPQLA@mail.gmail.com>
 <20250829001109.GB39973@ZenIV> <CAHk-=wg+wHJ6G0hF75tqM4e951rm7v3-B5E4G=ctK0auib-Auw@mail.gmail.com>
 <20250829060306.GC39973@ZenIV> <20250829060522.GB659926@ZenIV>
 <20250829-achthundert-kollabieren-ee721905a753@brauner> <20250829163717.GD39973@ZenIV>
 <20250830043624.GE39973@ZenIV> <20250830073325.GF39973@ZenIV>
 <CAHk-=wiSNJ4yBYoLoMgF1M2VRrGfjqJZzem=RAjKhK8W=KohzQ@mail.gmail.com> <ed70bad5-c1a8-409f-981e-5ca7678a3f08@gotplt.org>
In-Reply-To: <ed70bad5-c1a8-409f-981e-5ca7678a3f08@gotplt.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Sep 2025 09:30:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=whb6Jpj-w4GKkY2XccG2DQ4a2thSH=bVNXhbTG8-V+FSQ@mail.gmail.com>
X-Gm-Features: Ac12FXx59WVqLkC5mMlxQCBif3cCELBMwns93Jgla1NAtR1lqklG1oTPSCtnOW0
Message-ID: <CAHk-=whb6Jpj-w4GKkY2XccG2DQ4a2thSH=bVNXhbTG8-V+FSQ@mail.gmail.com>
Subject: Re: [RFC] does # really need to be escaped in devnames?
To: Siddhesh Poyarekar <siddhesh@gotplt.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Sept 2025 at 08:03, Siddhesh Poyarekar <siddhesh@gotplt.org> wrote:
>
> This was actually the original issue I had tried to address, escaping
> '#' in the beginning of the devname because it ends up in the beginning
> of the line, thus masking out the entire line in mounts.  I don't
> remember at what point I concluded that escaping '#' always was the
> answer (maybe to protect against any future instances where userspace
> ends up ignoring the rest of the line following the '#'), but it appears
> to be wrong.

I wonder if instead of escaping hash-marks we could just disallow them
as the first character in devname.

How did this issue with hash-marks get found? Is there some real use -
in which case we obviously can't disallow them - or was this from some
fuzzing test that happened to hit it?

            Linus

