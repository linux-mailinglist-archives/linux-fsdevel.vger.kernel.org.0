Return-Path: <linux-fsdevel+bounces-41228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEC7A2C861
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 17:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBD073A1198
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 16:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9850018B47C;
	Fri,  7 Feb 2025 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YuORY2oB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4724323C8D1
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738944987; cv=none; b=Vhtm/3m+oQ+RFdiC7CyB+tM9+ZWj1pk39J0dmsnM7lVM9tNn7rKaKQ23F1evJ694ZH7ah7npmchDM6Nq3mOYlkAezciyEjDU9Q9j/AnjYEG/sgN+nXBeIpux2mugWDrhshEyc9bp9KK57ksDMG7moMUJCJuoY4QFEHRpKIJu4WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738944987; c=relaxed/simple;
	bh=hD+eCZVAmu9HYlJ66O10gtRu+u/xshw0dNIF0ppHeG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T55wesq/i6ZTO4zy27e0O5niu5K3uuH+X0SSHlI/0d1gpph7k0EsXBE4ZuLdlnU57AbHIKM8nNa6qjzpOh0JVtIhFpkB2Z0a37uFsi4o2VI0mXsCh2SzDtdV8dY/d5rf9xtfihVPvztfB+RtG3VxmxMEn9JLGHDyEe4ibnhw01c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YuORY2oB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738944984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hD+eCZVAmu9HYlJ66O10gtRu+u/xshw0dNIF0ppHeG4=;
	b=YuORY2oBfCPOdTPGwf5EzqLLdAf/zylsM7/yufw/rTqoXFkFhWVRIbKCod4DmlFTuC2B72
	OOpRygSdG5jX9cfqsIAJB7CtLrMcJwXH1t38ti9M4U0zYrW4nORRrTAa1MOcmZ0tTJOO3L
	RJMpv9w1IKtXewdXpAksumqvh4/rUTk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-Kg5LBazyOfGWpsM07d8h0Q-1; Fri, 07 Feb 2025 11:16:23 -0500
X-MC-Unique: Kg5LBazyOfGWpsM07d8h0Q-1
X-Mimecast-MFC-AGG-ID: Kg5LBazyOfGWpsM07d8h0Q
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fa166cf656so3379111a91.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2025 08:16:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738944982; x=1739549782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hD+eCZVAmu9HYlJ66O10gtRu+u/xshw0dNIF0ppHeG4=;
        b=MfRwL4vY1zf2TngSzcEIIUzhFPDzjQiTv0N9vh+Tjke876euPPX198RmlSlBUTbMzx
         Bf9zOu4XtD3eFeTNiJuGqs84XwuiNh1RHc0F7+cW9Bc9mOy7JBLntRWJnAde6/NnxdAm
         +MQUpsETTimDoZbSo/wEEeRW4d3yUwYXrprwDTZoRQRUpQ825EH92FY+CGIqcEu/W5Qs
         6F0EhG9QyLI9l8n89ZLyY+gsJcaZhsj197+s2YM7tuP+3a8KdTo6qj4AdKaGenELHkYu
         jpr8I42nRV7NirSKO4bZRuAoYl8qLjhz9iK37uiXyUm08b+KUAkX35TtUoU7L09jozY/
         jKrA==
X-Forwarded-Encrypted: i=1; AJvYcCUutljdqJLBk78wbrbMwvIq5iBSuPzhtliVAj/odWGnEMrTHszMCyXMCrc2ErW2it7ZeH3Hm2z1fStMwmgj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9fB0+l1NGqMf7B/DSTZzx7wmQv3YDjQJe1FuNGfMbA20Grhu3
	yATvqNVWeYKcaHE6FrDxpD6ydt2C6sxH0etWV5uELwhLCvIlG6KWVZtXyTcaXOe+XErmo89GZkT
	Cklqmh66QHM+fxPKpkfmK/srfCz1+/Y0bTO+xL8aaHHhR4QCNTr222P+B5YPM+QRGOd1g3AD0nr
	CfizcjUS9u+AxatHezfo4QTpvME8kOrd6jW/shFw==
X-Gm-Gg: ASbGncufGe41hyBH5QlIpX0BRbbApvTcWJCPeXpj2Ol4B//birlm6ZnxTN3S0qBffCg
	IOGZzkrvfKtFpKCgtJdTSB517smUjNpykAxPgqB6LCm1yZKnBKNamKJFmIdCFNmJF
X-Received: by 2002:a17:90b:1b44:b0:2f4:f7f8:fc8b with SMTP id 98e67ed59e1d1-2fa242e7602mr5367378a91.27.1738944981884;
        Fri, 07 Feb 2025 08:16:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9qQ6Ac9CdjS0hM2Fp5CTCftFgkMjfVYiNIpp2aFlk5UPLOL/FOPn2I3gKNt5IDhZaRA3QY4m6BBB8aMlIkFs=
X-Received: by 2002:a17:90b:1b44:b0:2f4:f7f8:fc8b with SMTP id
 98e67ed59e1d1-2fa242e7602mr5367287a91.27.1738944981087; Fri, 07 Feb 2025
 08:16:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <bfae590045c7fc37b7ccef10b9cec318012979fd.1736488799.git-series.apopple@nvidia.com>
 <Z6NhkR8ZEso4F-Wx@redhat.com> <67a3fde7da328_2d2c2942b@dwillia2-xfh.jf.intel.com.notmuch>
 <Z6S7A-51SdPco_3Z@redhat.com> <20250206143032.GA400591@fedora>
 <CADSE00+2o5Ma0W6FBLHwpUaKut9Tf74GKLCU-377qgxr08EeoQ@mail.gmail.com> <e1630046-8889-4452-9f8f-07695ba07772@redhat.com>
In-Reply-To: <e1630046-8889-4452-9f8f-07695ba07772@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 7 Feb 2025 17:16:09 +0100
X-Gm-Features: AWEUYZnF6uEewR9F7JdT3B1cLzxz-kUGRVOwAxRfyR8MegKqDpoCLJWu8Fphkbs
Message-ID: <CADSE00KUeTp_C_kZPS1U2JcLiWuN1s6Se72gtFiN71kXCZx4UA@mail.gmail.com>
Subject: Re: [PATCH v6 01/26] fuse: Fix dax truncate/punch_hole fault path
To: David Hildenbrand <david@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Dan Williams <dan.j.williams@intel.com>, Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, alison.schofield@intel.com, lina@asahilina.net, 
	zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, 
	jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, 
	npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com, 
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, 
	peterx@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, 
	david@fromorbit.com, chenhuacai@kernel.org, kernel@xen0n.name, 
	loongarch@lists.linux.dev, Hanna Czenczek <hreitz@redhat.com>, 
	German Maglione <gmaglione@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 7:22=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 06.02.25 15:59, Albert Esteve wrote:
> > Hi!
> >
> > On Thu, Feb 6, 2025 at 3:30=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat=
.com> wrote:
> >>
> >> On Thu, Feb 06, 2025 at 08:37:07AM -0500, Vivek Goyal wrote:
> >>> And then there are challenges at QEMU level. virtiofsd needs addition=
al
> >>> vhost-user commands to implement DAX and these never went upstream in
> >>> QEMU. I hope these challenges are sorted at some point of time.
> >>
> >> Albert Esteve has been working on QEMU support:
> >> https://lore.kernel.org/qemu-devel/20240912145335.129447-1-aesteve@red=
hat.com/
> >>
> >> He has a viable solution. I think the remaining issue is how to best
> >> structure the memory regions. The reason for slow progress is not
> >> because it can't be done, it's probably just because this is a
> >> background task.
> >
> > It is partially that, indeed. But what has me blocked for now on postin=
g the
> > next version is that I was reworking a bit the MMAP strategy.
> > Following David comments, I am relying more on RAMBlocks and
> > subregions for mmaps. But this turned out more difficult than anticipat=
ed.
>
> Yeah, if that turns out to be too painful, we could start with the
> previous approach and work on that later. I also did not expect that to
> become that complicated.

Thanks. I'd like to do it properly, so I think will try a bit more to get i=
t
to work. Maybe another week. If I do not manage, I may do
what you suggested (I'll align with you first) to move the patch forward.

That said, if I end up doing that, I will definitively revisit it later.

BR,
Albert.

>
> --
> Cheers,
>
> David / dhildenb
>


