Return-Path: <linux-fsdevel+bounces-52888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C12AAAE7FBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 12:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF8518882B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3913029E0EE;
	Wed, 25 Jun 2025 10:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1OfjUGE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E451F29B23B
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848051; cv=none; b=hwRvKGYB8Vud5sqFX1myjl1dr9uB1084L5wAw9AOvas1vX1n5GuMrGHBPRvkVme6dKSQWey5HlbZja7GrFmgHL3P4Al8dUfkTpNkpjLNecuevzHRCdttjgeaF7egQU9CuOmlbk0AXlf/vs0JUgl8fG+ha2iGhTd/zZ2IJqFIWds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848051; c=relaxed/simple;
	bh=kdRywbgWT5zbIjE0V4UnI7MGY64eaZ1GFQ7MxZL739g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bu72+6MGv4JD4/Ed7f5DKVYRXfPhNhqmIgoaV9XPHY7E8vZFxsZ68W8JxgziHJkZtT4jeG7dOL0GHJDwwkGM1IlNa5fEAvSvD1pSIoR78n9QKo1Bz5HealHLl9yIKu0GAH6Qu+CO7qUl62vDLSQQo3c3FrZwMDU9/mbdTjXUhIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1OfjUGE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750848048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7h/KHM+Z1ETmgfw7Ga0CGtwnfJFvbJCAzq2poHb47zk=;
	b=E1OfjUGE/bASkxoIcT24gx9xi4xowDN53yti9azMKhvg/7FTh9vKrB745m849iTQsiPSIK
	s4v2Sbo4VKB4TuTL0E6L29to0WPuyozoWaG1SbOtU5AhYQtAVHBLv8O6Ic3C2+yx76zVpO
	4rhi0LXOIBWSetuflfJ8wpiUk05Y5G4=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-D0IvX1wfNVOsyIz2hBSWiA-1; Wed, 25 Jun 2025 06:40:45 -0400
X-MC-Unique: D0IvX1wfNVOsyIz2hBSWiA-1
X-Mimecast-MFC-AGG-ID: D0IvX1wfNVOsyIz2hBSWiA_1750848045
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-4e7f9ad4db5so5141160137.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 03:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750848045; x=1751452845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7h/KHM+Z1ETmgfw7Ga0CGtwnfJFvbJCAzq2poHb47zk=;
        b=D2KEGPcbsWqIKbv4mzg6Zf+SVuSo4c85aY2+ytVrHdk6oe/jLXaHOe2Dfe0ui/oSBp
         ktY8ZfEFYb0fXnt1uTp6Xu7tdDW6aG07/3QS/JtkfMGugefRJmNeA3yW2Rv9OTftd7sq
         +CkwB+Beof0t5rHnqKA4MK/zoU3g4DyDcq0jx5oNadf5wC5icACBd0PvUcohDefuhpOs
         VZobnYi+wEHFpnodnunbeaFkBrByABEBODrItr/m2lbeZGfrwj1rjBrmJpJ8pIAs9SwI
         8DOgySvWy9+Qjcd29kjRy7NRWiUTgaXBxMfRJrrbdS7txv8E+T2jmmZOZLrso7qGJgiG
         pRJg==
X-Forwarded-Encrypted: i=1; AJvYcCWLhu93PQyufO1vj1TGpAXu0MzEwWYsjtI0eXX/WYwoAMxKFlaezivCJHqQZ1jb9Y1jzHXGOMlYnnMTvn0d@vger.kernel.org
X-Gm-Message-State: AOJu0YzcohMCZrV+FZhCBa9Sih+xlTAWzUMsyXNnQF99+LynMlg2UWEe
	XukO8K1ji5GYfCea09GKUzUsDsh8J9wPhQUxRrsbjLEJ+o38qvsc+3Ojpj10Zqh2wW7BNnU8vlQ
	4E8CfSrzW5ZI63iYsaHny52f2PFZEg7JkNY2FZzoqWqVWyxaiaJWOkRJeTWaLqCtFIohuJQVvET
	97uRB3CVfXckrFmpLjuopLvi8Oyhn/ZWnN1yPEllN0sQ==
X-Gm-Gg: ASbGncvCzRwya0Eg4uJ3h+BBZByZTo3iQsUdRtwUbVJ63L8NgVAeO8t/42BP662zmW3
	hBCLK82BWiw3Bq2N2oLxVZ/tEbPDdCp32A+fq+wRyr4OWClFraFnI5gIF/YJgZYSZAiSjDZz8LE
	pt
X-Received: by 2002:a05:6102:2927:b0:4ec:c548:e57b with SMTP id ada2fe7eead31-4ecc63b0f4fmr1247640137.0.1750848044935;
        Wed, 25 Jun 2025 03:40:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7Rrly+INsD2FyLdl36Be/L5V6Eddn3BzuS4sqrDJs6t6pJxfkEkXvuFGZkctU3cnellCkS1CHwmPPaKFihXQ=
X-Received: by 2002:a05:6102:2927:b0:4ec:c548:e57b with SMTP id
 ada2fe7eead31-4ecc63b0f4fmr1247636137.0.1750848044685; Wed, 25 Jun 2025
 03:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612143443.2848197-1-willy@infradead.org> <20250612143443.2848197-4-willy@infradead.org>
In-Reply-To: <20250612143443.2848197-4-willy@infradead.org>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 25 Jun 2025 13:40:33 +0300
X-Gm-Features: Ac12FXyMPBCBLK4e87Hspuz-o2CzX-UVv_jmEtLCyzergMQSVwUQNGmL3GwfGWY
Message-ID: <CAO8a2Sjtc9xfBjhe+MGjHwc=9vJP7pB1bwno1mgKpfZgAO1QLg@mail.gmail.com>
Subject: Re: [PATCH 3/5] direct-io: Use memzero_page()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good cleanup.

Reviewed-by: Alex Markuze amarkuze@redhat.com

On Thu, Jun 12, 2025 at 5:36=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> memzero_page() is the new name for zero_user().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/direct-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index bbd05f1a2145..111958634def 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -996,7 +996,7 @@ static int do_direct_IO(struct dio *dio, struct dio_s=
ubmit *sdio,
>                                         dio_unpin_page(dio, page);
>                                         goto out;
>                                 }
> -                               zero_user(page, from, 1 << blkbits);
> +                               memzero_page(page, from, 1 << blkbits);
>                                 sdio->block_in_file++;
>                                 from +=3D 1 << blkbits;
>                                 dio->result +=3D 1 << blkbits;
> --
> 2.47.2
>
>


