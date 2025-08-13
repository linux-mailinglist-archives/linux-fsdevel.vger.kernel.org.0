Return-Path: <linux-fsdevel+bounces-57776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D8DB25209
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 19:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF12B6252C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 17:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031351FC0EA;
	Wed, 13 Aug 2025 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="nAB04yGt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0153303CA6
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755105515; cv=none; b=J8SUhH1szwhG4Pw9mJf1f/ldmQT1aBSuPp0qTG9KkSHTbKZdQRHlz3zhdEkNZ/MxeMLZyz0O6LB2U8vxh7R20ulxdy5MTTlQXrstEjUF5jDuhJr9ppR08ozsr2ss76NueF4/dKPUpfHhjDPKpqh7H9ciI27j8fvLh7P4XO4wzp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755105515; c=relaxed/simple;
	bh=zM3I5lEk54EEWWnAQoRH/nDiivAhIEA/D22f3s86Mnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEBKr/76PCYURq8EK4X/VQpNcMsjLdRehnuXj0QsmoEeYIWqHQsQ6SjP/C7lEgflxnt/6XgY9/kNbt6qtZHv5XoVOhCqfEsn+A92oSQ/rkEvp3WXdt5e8R2Uk1VxQl6Et7Xea5l4ssvGj+GDUDcjLL5yUvFr7uMF42J1h3EylgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=nAB04yGt; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b0faa6601cso12435871cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 10:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755105511; x=1755710311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+LK9IFXl9zeFkPAypIpT/bCmfMpmHyOe/hS1FE0qHI=;
        b=nAB04yGtpGAXB9y85M+NQmgeApwOZDZdEbCMt9N5Vo4CfgyG99qT+QhgDRtOMtTQSy
         hK5JzQfHHmgvscvHxtWw4GebnoOB9eIusLeGr4NqnowbN60xMI7tQFyrIXrIvz+aU/4s
         gwR7By4t7QLSLLnUkhubE27Zfu97NiX3DIiR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755105511; x=1755710311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+LK9IFXl9zeFkPAypIpT/bCmfMpmHyOe/hS1FE0qHI=;
        b=K2ZVV9zzsmYiDuVIkohe+wkYs0WLypX4do6+tfXutES+4RN4hsR+UF24SPdiOBB8Sq
         vM7PuWzPa6chHORt+wwAw9fOdzFZlV1GPjobAkqQL0R/blk5kSFsDOtOgxHdg7jiWTF9
         oWoWrPBxp3QOndE+JWY4PVwrjENxkE00Y1KcSg2rrO+5D0EVwCACcVj99WUwP2UCFwTB
         UUYXHlwjMPUhyA7PiGljlhNaNkpjWTxS3aW8Cnaa0ze6LIoD8fJHJxW2+9rJG/8w6Yei
         5IO8pRBkDUQtWg8abAVMYC9FRuzkKU1iukqIBu704anurPt9nv3/ejUj57EZUS1GsNvy
         MGYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/d685tZXG+iezvD5etO+T6UKqQBOiQSOZtY99fNN8+6TFqNM1Mg926cDFK3WUlyd1B7sw76PAVhsVdNnc@vger.kernel.org
X-Gm-Message-State: AOJu0YyCiKiHqpD4mhFFfEagQF1noSbLdWjRjdBzZhsE6ERpoyQqB3E9
	nDr1i5Ln7UPNPgETDQ+4LOFUEJTZIeHlAicAFzdw+0PzXEFj37TfguCYjn+KXIusr6/8So2enaI
	9nxoBqra3GTe/mjOgSBvaPZmskwlVrvkSL2FHbbss5aNCL8Fc8xMo
X-Gm-Gg: ASbGncv524kaUrSXM0NXueVJGBzglDDU7TlOnMS2J33juks5AfW72e7WiUmk5tipxAZ
	DIraMKv7lzHcIm4MhPzzzpA7rwZrXrc9Y2i2ykdp7Fj0oXkuXD1uTpwjBdVzL13qh7UiNr9599W
	Hom5nFsjhu199NjYl/4ti41Nwr1LHdS0M5YNoCHe9syOQYsjvlZzF47jLizRE+Oa3pjFMBsgNSG
	a5KZtxyNr52kzc=
X-Google-Smtp-Source: AGHT+IHzymiHQb1CCxD+4YkKlhqM4ItqMSf6xicXZ/9a5S0dljFZX9h1hEfoKlI8U4Hi3TnCNvffaedX5uG3XWnCgos=
X-Received: by 2002:a05:622a:88:b0:4b0:69ef:8209 with SMTP id
 d75a77b69052e-4b109b32192mr4794931cf.26.1755105511125; Wed, 13 Aug 2025
 10:18:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813152014.100048-1-mszeredi@redhat.com> <20250813152014.100048-4-mszeredi@redhat.com>
 <CAJnrk1bfoumJHwc5p-WASXYxWG8tzz91LfzpiEkPTSOoTDK1ig@mail.gmail.com>
In-Reply-To: <CAJnrk1bfoumJHwc5p-WASXYxWG8tzz91LfzpiEkPTSOoTDK1ig@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 13 Aug 2025 19:18:19 +0200
X-Gm-Features: Ac12FXzY7xFFShPxMCLvliJm421oXnbJzImBdknL65quLxcaSyPHQanaUVtCM3Y
Message-ID: <CAJfpeguWQep97QjTGPAkWe3=wKxBfC0XuXBbrbfK0Y0HKY6_mg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fuse: add COPY_FILE_RANGE_64 that allows large copies
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bschubert@ddn.com>, Amir Goldstein <amir73il@gmail.com>, 
	Chunsheng Luo <luochunsheng@ustc.edu>, Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Aug 2025 at 19:09, Joanne Koong <joannelkoong@gmail.com> wrote:

> Is it unacceptable to add a union in struct fuse_write_out that
> accepts a uint64_t bytes_copied?
> struct fuse_write_out {
>     union {
>         struct {
>             uint32_t size;
>             uint32_t padding;
>         };
>         uint64_t bytes_copied;
>     };
> };
>
> Maybe a little ugly but that seems backwards-compatible to me and
> would prevent needing a new FUSE_COPY_FILE_RANGE64.

It would still require a feature flag and negotiation via FUSE_INIT.
I find adding a new op cleaner.


> > -               err = -EOPNOTSUPP;
> > +               if (fc->no_copy_file_range_64) {
>
> Maybe clearer here to do the if check on the args.opcode? Then this
> could just be
> if (args.opcode == FUSE_COPY_FILE_RANGE) {

Okay.

> > +/* For FUSE_COPY_FILE_RANGE_64 */
> > +struct fuse_copy_file_range_out {
>
> imo having the 64 in the struct name more explicitly makes it clearer
> to the server which one they're supposed to use, eg struct
> fuse_copy_file_range64_out

Makes sense.

Thanks,
Miklos

