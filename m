Return-Path: <linux-fsdevel+bounces-49170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC05AB8E30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 19:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001B11BC655E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 17:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F1A258CED;
	Thu, 15 May 2025 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/5vx0Tp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ABE35971
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747331645; cv=none; b=NaV+PinEXSmldE7ilHO8VprHCnCO4usOwpGD5+jRrrzHxHwK0ax6TU7oL38847DOhxi91MEaoRxAff1fQPcMUBj+et4HPI6KP0tOFYzJKFK54bltmAjgYAPcDXzTuXZUaXqjA94TzQ8zksnQh7VBZ6Y3ToHtf1ad5zOhIWWZCtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747331645; c=relaxed/simple;
	bh=fjngZ/GL/6zH8+Il20L9ilVYkZnQAuWnxJQtlmfx6hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8SgmZWNGMBJaUbbygMGaseba/Izf4FwmIjwqHYjE7g6pYVQ68dA2H0e7CLiZRznFWVBp4dnksvVQd9S8Wo9fKpSJlTFp7wndYPf8kp7dHAf6zByPTahXVSflgm4oT4cu/pF9rlA2unAVIFWRQh7oFPdhnUG31ceAZUt1c7yYwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/5vx0Tp; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47692b9d059so18576041cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 10:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747331642; x=1747936442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDmIsRpXKZCktXhk13whzw9nKqdJ/HWnI06+qc8/7QY=;
        b=A/5vx0TpVyaaO8lWJT8hHhspBizB6Elos46qyNg0dmbngdj985PsMRmmEt3EZJ1uOA
         4KEgAXPbG2YZWfpDlXTuMsRvbVNWFsNbv9kg375I4/o32oiDtXQOgUhQnZZ10ZbeJXvn
         HiI4zVLTm7eztusoV3SJB6JwUTDjwRuQFp0Ht/0l+XmiWCdnMbQUJfEiMPeBRX+Br+1r
         iyG4Bvu96Q8au+ntJ3zV4Hn0Ojm9Dd/oVnwCfKsgDt1emoekZN6s7Txgn3zaf1iU5QNo
         P9cxuK+cN1w1pcDyyPnkIttGMl8N0n6pSVzHvGO7FH7vOYX/c5zJhb4cXi962K086wDo
         FplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747331642; x=1747936442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDmIsRpXKZCktXhk13whzw9nKqdJ/HWnI06+qc8/7QY=;
        b=n1RXg3Idg1otz56JmDzH+D1FX9pgpdDeJiZI6ONRT8LP+vCX2mOCB6sAlnCKEcdGv6
         VtwCv7eNVWiCREuT/XF9CF94LxcpIVnigUEFZCq5BOcsNJGqCIFSJMke2Ht0cSvnR5Fl
         HbDnLY3/pMo6zF/w5fQmNp07uejrYLzATPcCHica53a8rYCD4rHxJQ7DQUvNaWlYyZWH
         vbM2sKrhH1k+S1HOngimAaEDBx+scgFQkIgZ6li9FuUihLpcqkPqC07yuJo4m2EmMl3Q
         MJxTZq2SKBD+X/8qrHJkMc0nwvJKc4Lr7EABB+8w/6QZtTNSdha3i8DvJ79YN78cnrzT
         q8Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVl+YzXF/EM3ZygUJlUD8dxanpD44qjVpfwhtde0hkzDnaoPBLTR93rGgc8QFzJ+m98L0MbU+ysSyQuPdXb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Z61s9P4dzoqWt6nhQ5WF93ZNl+Uuf2x9KPCA9NOjfkOI6SGM
	gtHaPB/B/WXhN7+ooS/SHTQv6b4sQMNhSN30wjL/omu2DfWLobzMPeSHGleU4bWzRoE2znoD6p5
	FjohX9jKNDPd+WRyvHBtW5RM+C0N6Foo=
X-Gm-Gg: ASbGnctSvojfjiZccbw09OzZSxyQ/Fx3X0N+1hEy2sn1xW7Sb1JQjt8R9yycH4Wvad7
	SwNkZHMDXAQkAS9oz4muxGKS2gCVBoVLxwn6xeURqGhaO7ga0fQiavQS2uBpfEbQmmyuw1phVlt
	4wOZ2F92cH3MnJt/MVG4HKSssa9RJm4ATS
X-Google-Smtp-Source: AGHT+IEnnAjQx48x6lE1sZA6PGWumWS4uAXusCl6x5dW9zYZ3iPehnFgcHNVvg2X6d25eE8zwCSJSLo2Qdkl24CXFSE=
X-Received: by 2002:a05:622a:5c8f:b0:477:e2d:2ec7 with SMTP id
 d75a77b69052e-494ae427981mr5468311cf.33.1747331641845; Thu, 15 May 2025
 10:54:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512225840.826249-1-joannelkoong@gmail.com>
 <20250512225840.826249-2-joannelkoong@gmail.com> <aCPhbVxmfmBjC8Jh@casper.infradead.org>
 <CAJfpegtrBHea1j3uzwgwk3etvhqYRHxW7bmp+t-aVQ0W8+D2VQ@mail.gmail.com>
In-Reply-To: <CAJfpegtrBHea1j3uzwgwk3etvhqYRHxW7bmp+t-aVQ0W8+D2VQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 15 May 2025 10:53:50 -0700
X-Gm-Features: AX0GCFv6E_fse6kP6Sf7-V3mAhgyV6ax8OLsx7RhzFtkFISkewgGGIg5AL5AaS8
Message-ID: <CAJnrk1aVcT5ZWT-KgrThQ4jxnd0=AvTggvE0CbaMG+9zOFxfZA@mail.gmail.com>
Subject: Re: [PATCH v6 01/11] fuse: support copying large folios
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jlayton@kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, kernel-team@meta.com, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 1:26=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Wed, 14 May 2025 at 02:18, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, May 12, 2025 at 03:58:30PM -0700, Joanne Koong wrote:
> > > @@ -1126,22 +1127,22 @@ static int fuse_copy_page(struct fuse_copy_st=
ate *cs, struct page **pagep,
> > >                                       return err;
> > >                       }
> > >               }
> > > -             if (page) {
> > > -                     void *mapaddr =3D kmap_local_page(page);
> > > -                     void *buf =3D mapaddr + offset;
> > > +             if (folio) {
> > > +                     void *mapaddr =3D kmap_local_folio(folio, offse=
t);
> > > +                     void *buf =3D mapaddr;
> > >                       offset +=3D fuse_copy_do(cs, &buf, &count);
> > >                       kunmap_local(mapaddr);
>
> Fixed version pushed.

I think this needs to be:

                if (folio) {
                        void *mapaddr =3D kmap_local_folio(folio, offset);
                        void *buf =3D mapaddr;
                        unsigned copy =3D count;
                        unsigned bytes_copied;

                        if (folio_test_highmem(folio) && count >
PAGE_SIZE - offset_in_page(offset))
                                copy =3D PAGE_SIZE - offset_in_page(offset)=
;

                        bytes_copied =3D fuse_copy_do(cs, &buf, &copy);
                        kunmap_local(mapaddr);
                        offset +=3D bytes_copied;
                        count -=3D bytes_copied;

else it will only copy the first page of the highmem folio.

Thanks,
Joanne

>
> Thanks,
> Miklos

