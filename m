Return-Path: <linux-fsdevel+bounces-24446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE9C93F61E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 15:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4581F22E5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 13:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E503A14D2A7;
	Mon, 29 Jul 2024 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hOXkNMSv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0411420D0
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 13:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258314; cv=none; b=GBltHqwxnA1ulm1953/jCKH2Y86D7/PuGMULHixKY0qZXo5YhaS/EBTesQ2s4jiOEYhmyWhj70u0in2qMGkn5dw/f7fg3RRB+yZcg/ZKNua4HXxN9VfxuKrdhykwOxj5ZQTswH1JiGFJwLpG/VdtoBj7AYLk3r9FKhGUJUv8o3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258314; c=relaxed/simple;
	bh=Nwdk1Zb376HFbM1m2aApZjKPiZ11wbxbpIpoPekhWTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLQE/G46dMfL16cS2s7kkZUsk6bEerQ2r8SAnVIjFIdCQ/SOSoWmlL9tJMWpGnv85KPOBwf0FKIgrCPzv7/3YByMcnmwwKMByKPIvwVC2ELBq3WT6BsiKCwwsAs1UO/YNvrsgpsYj9MLJSK+q4L/w+5pT2vYWDx8FqbeIvZu+kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hOXkNMSv; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a81bd549eso309928066b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 06:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1722258311; x=1722863111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nwdk1Zb376HFbM1m2aApZjKPiZ11wbxbpIpoPekhWTs=;
        b=hOXkNMSvLOzz3irBecp3MxDUVaNByZNfDwzrGas0ykxItE7BSuBSS8gm9HQrYV/7+Z
         rKeld+8m9mlDyxsovQm8uqfD/UIC/Xq6Ti+4ipfCQFgDg2QPDewb2HnkccGa0NnZpD2+
         Ps8LhgmDNJEZCit5ygCCarR5bH8Gmxa7wIyOFxQ/ULcVGuxDVvB2wypBX50cXE5P+94L
         Lw7k6X04AFrr384CTs8cYCDe9IMUxI8pLWFYbIR3vM1dKEOGjoUQG3NH4dTQ9msGfXKp
         kWGqqd5hS3ywAa35v63/yd0uwBktaibM3eCqme8WPyJ7DV/4qSzqzUeZfIAY1zBoCl2l
         t3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722258311; x=1722863111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nwdk1Zb376HFbM1m2aApZjKPiZ11wbxbpIpoPekhWTs=;
        b=CTMqHTcKjF6vpkqbRDkIpPZRdH8NWT0fxSnKuuICUsEoVDd7OgUIz9iegBIoGV7CHd
         JrCHqvirI40UeFkpCFDQ84M/UgQ+a5RBEjr+DqCt/ja6+4D3+rK6mGvP0D3g+lE9tAOx
         qCJaNtqC2yV1RvNxPCG0aAdwwUNYzjk4a5O9s05oK0/oNbk6CLgYh1lqTjePKARSuadV
         P3k+hgwtH4l0/09HQ1e9v8WtLVwkHSzp5NLdHl6K62/1LFvmMQBEjSN3YzX58CTisXtZ
         FaWy0KP6JMXed2wp5QR3xJNyVcAQebeWof9NvHEdp1O+TkQBnK/v4i286sUz6Ac/HsAg
         MCnw==
X-Forwarded-Encrypted: i=1; AJvYcCW+pOFzkoIMWFuMfnJEXBWAM+uPmHq0VjTXArUJWmWBsQktzu2XPFSoChJZHLeBF3cQhoY/ZibXFFhLb53+JzhVk8lp9+HnitFjNO2mbA==
X-Gm-Message-State: AOJu0YwqIYKGG9RDgZUEh5R7gIdST2VoNZL8FQd5nkUEykWJw9fbI28V
	dnPmzCBjgq/QrpAb4eaVSeqazc9AAdMO1mNG0eiWcwbrAluMZMbP5jwdIs/BhXFZAIVftk1VvdH
	nl6h4Xrs5OLcBpB+TB+942wGorK0BubHOHeTw+A==
X-Google-Smtp-Source: AGHT+IF3q5HRQsp30wvL513VaLZ8ou7ZSERFd1RF1FMGbO2FLdRRU63BXpRqD92PQM6mpbVkAMHS0DgJYlggtS8sCLo=
X-Received: by 2002:a17:906:d54f:b0:a77:de2a:aef7 with SMTP id
 a640c23a62f3a-a7d40150ad2mr553058766b.44.1722258310918; Mon, 29 Jul 2024
 06:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729091532.855688-1-max.kellermann@ionos.com> <d03ba5c264de1d3601853d91810108d9897661fb.camel@kernel.org>
In-Reply-To: <d03ba5c264de1d3601853d91810108d9897661fb.camel@kernel.org>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 29 Jul 2024 15:04:59 +0200
Message-ID: <CAKPOu+_3hfsEMPYTk30x2x2BoJSb054oV-gy1xtxqGycvyXLMQ@mail.gmail.com>
Subject: Re: [PATCH] fs/netfs/fscache_io: remove the obsolete "using_pgpriv2" flag
To: Jeff Layton <jlayton@kernel.org>
Cc: dhowells@redhat.com, willy@infradead.org, linux-cachefs@redhat.com, 
	linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, xiubli@redhat.com, 
	Ilya Dryomov <idryomov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 2:56=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
> Nice work! I'd prefer this patch over the first one. It looks like the
> Fixes: commit went into v6.10. Did it go into earlier kernels too?

No, it's 6.10 only.

