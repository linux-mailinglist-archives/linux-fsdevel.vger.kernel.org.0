Return-Path: <linux-fsdevel+bounces-31123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6CD991EE3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 16:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC36282564
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 14:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8F38175B;
	Sun,  6 Oct 2024 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="a7wAsigS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CEC2557A
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Oct 2024 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728224940; cv=none; b=dFKnPrYbeFZuSLn50MaRKO58vOM8f0tqlhUb4uAuEzVV+XY46KIYKfW1g+0qnqaCVRefMii6sIP8hkuvxa6wXf4AGWY/6ZDZSaxMDIxea0QOTbyh5vW6sNEkjhtMUoaGW7b/LPnXJy2e0/ekCyhjppQtvT2MsJDlPx+KQt94Qvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728224940; c=relaxed/simple;
	bh=cvh1VNDKgVQtS0kqZZTJM4ITFk0EyN0F03KA/hlcgRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLt9eBWNS5hEqXMrYc47npaTmSQYxs9SIlYIJai7mEbU8zC5QCIXhF4Z/3kK1f1KTW3IF/2w/TrHdSX6pRqRy41cZNSt43+CMEZ2NkgjtO5yyseUPqyYetjz31r9f85s2+sd8ZbAocF6ntdJUSKT43SJTQe4anVYXWATZDKgGGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=a7wAsigS; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c89668464cso4786941a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Oct 2024 07:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1728224937; x=1728829737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvh1VNDKgVQtS0kqZZTJM4ITFk0EyN0F03KA/hlcgRk=;
        b=a7wAsigS5KIW3PMQtmb31aKgweL8Wu+uluAFdSiVe7P/vEPZT/mXnWkMEPuWFnvNUC
         PyLAMuIuUjt5jwDR3UJo8Ncn6+TXiBmPYskawrZ/Pv/3Fn65wTUUQmR3CCSzhyTM40nv
         1yODh4aQqQH1NwsFvMX/Xa0wanoMLES8JevOc21PZs9URxAsn6RRGLGSDgw+gfkFqjsG
         wXhKLDing37MOZpsQic8c5ZlJDL+heLllM6w/DA7O75EAC2gaipoYqILxiOtKGQ8YT2I
         q3sUmqQVbwKJ07Xg2r1yX+ThgHmgwZvLJWjnR9cr3Z2rIiOhosv+rNAYlHh3/ORFT4pO
         a+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728224937; x=1728829737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvh1VNDKgVQtS0kqZZTJM4ITFk0EyN0F03KA/hlcgRk=;
        b=SwrFSMeY3g3C0dvrP4BevyJGXlOmEYGFMS362+CWz+oCg414lgTxvCqnTQdfkSReMH
         awRfqihUtzihe55BRcBLVL7JYDENvEC/S93sC1A4bt3sez8oeG2n0ZNvo9YUUrNfe6lU
         xsH1eBEmepk7CRiARr3HZBDE70I7iWqRDyMe7eEKn9Kh3AkHvPv/PSkQUFDmtZKaZbF3
         Hw0zMd4ml1uYL9p6kdDK56UaJdYxwUI0lxN0Gwzt0C2GH19xwXMsa8BxF6WKiVU+bUnH
         0eGv3v5JiL5bA7W8oZh2qWkOvnuXwRMh8WvjuFZUq9oJgxLGcPqm7OpDVnN41I67S+uT
         pRxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTYe/ph0W5u8/KEOdqkb4w9OrK2JgLz4fJ67r/msWm+qMY9+LR9B6qNgyKLGFaVqb73YnEi5p75lyjMHI3@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi9NESlA3XyOK0iDGzUPlt3H/6xEzvCX6S8epfvVL51d4iAubl
	4UetsWcPzdnM7D2+WJ/TAfd5j354/zzIJ1Qt7gGirZSxFWhq5UMJ3MLY7H6KoVjy5Fz0qVSWfc+
	vz81n0FHEtlg2pCSf/uGyhhspPqpO+zmafsgDfQ==
X-Google-Smtp-Source: AGHT+IERmoeIAzbY//wPQ0ALN0hsGZOsI5Ri64LPZKPMVqcGOVQM6SZuK6lN209r8+tDeh3E7y0WZX9FnBRU4TONBKA=
X-Received: by 2002:a05:6402:3512:b0:5c8:97dd:3b03 with SMTP id
 4fb4d7f45d1cf-5c8d2e9ef80mr6600615a12.33.1728224937414; Sun, 06 Oct 2024
 07:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002130004.69010-1-yizhou.tang@shopee.com>
 <20241002130004.69010-4-yizhou.tang@shopee.com> <Zv1OYxSYWUHarUrL@infradead.org>
In-Reply-To: <Zv1OYxSYWUHarUrL@infradead.org>
From: Tang Yizhou <yizhou.tang@shopee.com>
Date: Sun, 6 Oct 2024 22:28:45 +0800
Message-ID: <CACuPKxn=XaJPcANC4VwtSX63EaVpYJA5FJ9mcN+LR+XmMpASiA@mail.gmail.com>
Subject: Re: [PATCH 3/3] xfs: Fix comment of xfs_buffered_write_iomap_begin()
To: Christoph Hellwig <hch@infradead.org>
Cc: willy@infradead.org, akpm@linux-foundation.org, chandan.babu@oracle.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 9:45=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Wed, Oct 02, 2024 at 09:00:04PM +0800, Tang Yizhou wrote:
> > From: Tang Yizhou <yizhou.tang@shopee.com>
> >
> > Since macro MAX_WRITEBACK_PAGES has been removed from the writeback
> > path, change MAX_WRITEBACK_PAGES to the actual value of 1024.
>
> Well, that's an indicator that this code need a bit of a resync with
> the writeback code so that the comment stays true.

Thanks for your advice. I will rewrite the code following the logic of
writeback_chunk_size().

Yi

