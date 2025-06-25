Return-Path: <linux-fsdevel+bounces-52836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E01AAE74A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 04:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81BDA5A5740
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 02:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A043019E967;
	Wed, 25 Jun 2025 02:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aCu1mQrG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C53819E97B
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 02:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750817283; cv=none; b=ZkvOxgS2lryLgAWpoWBJdhV8gx0xAs0iq0l3i/CSQ/xQOQ5aOUL3xL6P8GBHK8IFBNqc+KJAJFP1+MflmOrwarOczPd3CyY43c8o103cnd317OA2/fk1Mx3zz+vhw3YNTwKV49XskeskRuIutEbHVnpevfSWkEtVt6vJ3QlqcNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750817283; c=relaxed/simple;
	bh=ma+88H5VpAOifU7fHtlXxdBKdlhmSUKKZ8A91So9mGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ll5FDtGd/yzaAZRo41fGeewJoNIyQze+bHOpWgcnhZUt69xXbL8xwlL8EEDNblpboxk4AEAY6zHTMbdbSU00TtnE/brTL6sXPNU5Ayi4+1qndjquEsRyG0X32zRs+UJvUJ/dF6YiYUK6ORYNBRW3zMERzq/Q5Q5Ci3WHB0NCRxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aCu1mQrG; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70e447507a0so46037227b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 19:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750817279; x=1751422079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ma+88H5VpAOifU7fHtlXxdBKdlhmSUKKZ8A91So9mGM=;
        b=aCu1mQrGTrvIeygS6AxuH3K2HUUERSjtj4eyshr4PdYU6DEjweIS7AdEeHfW1Rcfel
         NzeRw2llw+41r9aAyX6jQRlJpPuhGc9sX4bkMJN3PSq2wfUCwbs9/Sfy9QKgaT12ha03
         6eVU3bguO6Oll/5C8Zc3gWxSDRWuxI81r/P0rJIf8bzeIDoD7RRNonjonehOKpNxZIWb
         TLwJ3TCmVAq0byBuFhWj6bmtN21IdogFWjn8bFYiKQrK4LKfulmn0VjJan/YV4SXESDz
         WLJkmX+lcN767Pf7KkeamVsL8jo5j0UVsCVOCDita6KOGOnQEVG6qgNkEROglhWh6vwp
         CpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750817279; x=1751422079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ma+88H5VpAOifU7fHtlXxdBKdlhmSUKKZ8A91So9mGM=;
        b=DJl78GWiSHeMuzgav0EaPueQQOUEI1aOfDiQrQY3yQYiX1xmGHgoqdsMRsPMX6pjPd
         thAwjTvkIQmCf0kiW+Sl3sVoMF+/SChA1vHbU3uVq44nhi70jCATzJI4/8p++TA+V86m
         dNUbGYiNWO3s9HNmU4+vdduFU/VycaQuKuzZ3mOdizPPJ2j2QM1sw3A7BPwgo3T+/1W8
         glpZKRZnUXlIchdBXYSBhkMqquvo5vKh6NSfjabWvyAym+tm+42whk3CpCwre+KK27Q6
         BsStFkL342N5m19EM1M6dh0fHRUm9ezEGCv25sBOlOi0aJ0If6cSk9ljSWDt1OOyTjKv
         i8Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXCk87PSmSlf6oDTbewCDZkmfhDcZ7WHTUOazppZcwjDVQ3ohqLU/VYV07pUY71MTCw4EuYly7TR9CtV21B@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1S7V1G0R6RKRyhEnBN7QXodb97HrqCBhDMcZvAC6gGxhilexl
	GgrLN/Q0lBVjjjG+db/F7xAwTzewGIpnp+hhuxKCggZBWGV91uVrFY3HlMfyL0RKgO6TtJOEN+v
	NP+qKjadNsYe4Y3PYYBHSo4cwZqZAKgO5p5lgHmkJ
X-Gm-Gg: ASbGncu6UpKuyOTtYegOqMsg0+PixKfJ/UtVtggIM62TuVWNKrrhGEkOl2CpfpdN5vu
	ic7ipI+8HwuLL7GGxFqtGbnJ2WcJhC7cKmU088/QRzHrw1aqkBCyzTzuHSxkfBt2EQ2Ds8t8p0y
	e8/obwBoaqaIMhusCBvF7T3sN4+gXWRu00NeitVv5PnDU=
X-Google-Smtp-Source: AGHT+IGlJ3+t50Dx73mM8Air5bfcWg1IIPvwg/Vg5HkXBBKOKiLaOFTVUfjQ8shi4PBm0CiACEhKPb3fm1gsyHDeyKc=
X-Received: by 2002:a05:690c:3693:b0:70c:90af:154 with SMTP id
 00721157ae682-71406dd05f1mr17609477b3.20.1750817279444; Tue, 24 Jun 2025
 19:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612030951.GC1647736@ZenIV> <20250625014709.GQ1880847@ZenIV>
In-Reply-To: <20250625014709.GQ1880847@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 24 Jun 2025 22:07:48 -0400
X-Gm-Features: Ac12FXxDWMVHh8x3oQC-oksHsfE97o8MSwUkJxZcBW8YhsT9RmghUSqQlA1JLeI
Message-ID: <CAHC9VhSTzc-KZyd1RSOaFDMjmiXCQBscLE=d1wGvc=DWnfz6gQ@mail.gmail.com>
Subject: Re: [PATCHES][CFR][CFT] securityfs cleanups and fixes
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 9:47=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
> On Thu, Jun 12, 2025 at 04:09:51AM +0100, Al Viro wrote:
>
> > Branch (6.16-rc1-based) lives in
> > git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.securi=
tyfs
> > Individual patches in followups.
> >
> > Help with testing and review would be very welcome.
>
> Seeing that no complaints have materialized, into -next it goes (with
> Acked-by/Tested-by attached)...

Thanks Al, I appreciate the help cleaning this up.

--=20
paul-moore.com

