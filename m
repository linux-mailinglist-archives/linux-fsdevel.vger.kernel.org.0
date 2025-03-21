Return-Path: <linux-fsdevel+bounces-44718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41A0A6BF06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 17:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5F63B94C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 16:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C866226D1B;
	Fri, 21 Mar 2025 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QPgdE8kr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213F51C5F14
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573033; cv=none; b=T3N9j4o+BNoDDNBhIUJfCb7DRCO939rVIInb3tDqsZ8DsSGRw90u+ZBAtg+/85I1SIrVCMCt15ILjE2oZA7+O7EEdRPqb6GF/xwikSX3GmlGC04uEW+XEJw3BU7dsks78zY4fiJV1/XqyAMxf7D4eaWWRc3HthDS6BQuTIGXRuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573033; c=relaxed/simple;
	bh=Cu6cOimHwJqoR7VawNoCeLQ/UDK3IeeGCSIVPpFBjWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8MlNNBEpYgNxNaTdWqT8Zn+gs+1OLt8om+26BsV/bW2USDAqR5zoLOUvQQkfvPxJdkQc3u8kPgo836ydGnxJY/yU5CwcbUwNaWEP+KS5rlWwDGATE1gZ9cf8QcWAbCdJUlXedHp3KfxTQH7BtxpiF9SToSQthFp0jBtiKHzR4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QPgdE8kr; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47666573242so487641cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 09:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742573031; x=1743177831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeJPwSaX6HIdUR8KTOVsZ8Feg++HqdiUbFfhCHyoTMI=;
        b=QPgdE8krql5p54KhyRmjDHFZQMv1l/NEoJDfj+Kci2gf8eWErH/wmbwqwZb5HvRj2J
         6ILCM0WbQe59W+1GRF49kQKA0FQfK1j296eEii16dy8l3qH1/dSZgmHaX2THz8pcfw3e
         ij6oWsONldlhgRUTBKXNMW9DJWHMCI/7Moz20Tu2nJwc/W4LaYIKiUV+Ygh7n5dTEgl5
         fGsdFmRwNGdo+gcqJmJ/Gd2qKg6XvQF4CauyJe5lhw69vSbR0H0phppMkDe3JH1VKQ9l
         RuU+oFn+ytmZfAyNVhVvtm6VNt6zNEdCCZOoL9AuQmwlhkvq6EE0nQPEYLEdUYxFxjLk
         yLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742573031; x=1743177831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeJPwSaX6HIdUR8KTOVsZ8Feg++HqdiUbFfhCHyoTMI=;
        b=SwtmWEvBZPoe0jDhs0wu28JRfEcfztKpUl8y4KUh4x6Z2ncWkLUZnPJGUZNQHgRAC2
         rSbqohXGL0lFUD0wY8f1yUb4Vln+dh6EsyWPG1lwyUF2mNmlJkUWLAs/MTZ4yMgw6GIQ
         x2/UjwwhQ00nKEf8gGzkpTDs5wCzz7OCpt2roMACbmLBKTqLdNr/DldwJc3hYN9rp1ZR
         xqvm7sDgrNhlziP1LpwFYTC+q8CFqv0NFfyMbjVB9N77p01QYttLQwuDFcxukDDWUJwQ
         L3BoJ7AMCLJHpieX8fL4qMrc9AqD2iBDNoAIhyBtRVM2bj81mqmAFMD1jzBpRs1gHT9i
         TPpA==
X-Forwarded-Encrypted: i=1; AJvYcCU2SwOth1NAM+hnyT4LFhsma6oyNnle24oRnTyv3BxSSdYWbLcdFhyctyyC4mV0p9CllanXCigq/OdHpFLu@vger.kernel.org
X-Gm-Message-State: AOJu0YxJujVrTcm5h2fV8F3HX1ZIBkjK3f2UjW79DuyuXBrVIaERqyjE
	+gf+YfNC/QTRQr3s0CAbt4VlcWWAdNypPMBaxJ17Z0CGNdY+c7cSE/5VCF3G9+vA4Oj+yZW8eLS
	EW4wnYYJ1dccHi7k7sx+Cw7hZsvaORQccxyNY
X-Gm-Gg: ASbGncvgNqtRCp3Azru2i11LU2Ner4fKz2M97Cr8S/9wIQw/GSk8hRRVYuWkwHJvPkk
	4IQfGt7q2Y9zzmeQ7+XTsszEnHa3PNiHMa07Udl65xhV54pXsab70C8vtIcSGUn9t8ELa5Fp8BI
	kJW8nN/6VdDB+Z7SS98FBvIsK7Xw==
X-Google-Smtp-Source: AGHT+IFkXczES/4I5kcNrRXzjxrEN1n1yI01ly+4cs5jHTsrsjRGc5j6UaG3BY/6xhutMfdEGFSNPo3rGZczVOmOkmw=
X-Received: by 2002:a05:622a:1f17:b0:466:8887:6751 with SMTP id
 d75a77b69052e-4771f55786emr3998701cf.23.1742573030713; Fri, 21 Mar 2025
 09:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320173931.1583800-1-surenb@google.com> <20250320173931.1583800-2-surenb@google.com>
 <Z9z1lC9ppphUhDjk@infradead.org>
In-Reply-To: <Z9z1lC9ppphUhDjk@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 21 Mar 2025 09:03:37 -0700
X-Gm-Features: AQ5f1JrBg768vc8VQCwRG29x43voyrYWFfgAzMuHmylUPx3zi7H160snG2PZn8A
Message-ID: <CAJuCfpG9apLCrF0DXjzVtCJoPAa=5BLxArHC6SCKkfPNdpZ1wg@mail.gmail.com>
Subject: Re: [RFC 1/3] mm: implement cleancache
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@redhat.com, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, liam.howlett@oracle.com, 
	alexandru.elisei@arm.com, peterx@redhat.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, m.szyprowski@samsung.com, iamjoonsoo.kim@lge.com, 
	mina86@mina86.com, axboe@kernel.dk, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, hbathini@linux.ibm.com, 
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com, aneesh.kumar@kernel.org, 
	bhelgaas@google.com, sj@kernel.org, fvdl@google.com, ziy@nvidia.com, 
	yuzhao@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 10:14=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Thu, Mar 20, 2025 at 10:39:29AM -0700, Suren Baghdasaryan wrote:
> > Cleancache can be thought of as a page-granularity victim cache for cle=
an
>
> Please implement your semantics directly instea of with a single user
> abstraction.  If we ever need an abstraction we can add it once we have
> multiple consumers and know what they need.

If after the conference no other users emerge I will fold it into
GCMA. That's quite easy to do.
Thanks,
Suren.

>

