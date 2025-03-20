Return-Path: <linux-fsdevel+bounces-44598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8169FA6A8C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 15:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825418813CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B54D1E0E13;
	Thu, 20 Mar 2025 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTFywso2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF741E32C3
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481437; cv=none; b=etLeWNVeT8QR1I3dI/5dkO1KWuF52puH8bWlcOQ/CKuaPEG5yvAleU4LA8XaCd+fec0N9ZviUL/ef111uh7joaysW9NcGcR2fLaISdoQ907k7fiEPUla1yuAyzuZnhjiv9QqGDeApKXiDS96ikgaZFPUCAqztSmJXyIQ0IB872Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481437; c=relaxed/simple;
	bh=dKWHt6FujybyOyL5cedYtqrafz17Hc5CfWsQ5YrnuQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXQPfYw0qDfYFmOtjNQJhTfMafUKQfyHRYQguSl3LgCRoaPDPSFRu2NN5vg6w5RF85UPQdll6xpdQLiygoAtgfLIoasLwYGKeuPr/q0T40I53/jLK2TYN48kBkNDQHLN5umIxFqiBxGW98KeeV6hHEU+omvZbptH4Ku/ju0FMIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TTFywso2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742481435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OhfkO0nOeFh31dBWlpIBHPp/23oMIm4/ZzrV7nDHXfs=;
	b=TTFywso2Ojbbk91z0cot3WKzNQzE37s53hI/f1SKJmBuXE0AV7gQFfbJMQA+Nb2o44fZ70
	4ny8nYiA02RmXk5yBkvvI2tyP+zRnEy38zYMYX1/guvTC7B8waK/mugIGkKZ/NprI0oTaG
	76ASQ+x2qm07nuSP0GJ63Is9pn7BYKg=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-2qONZDfXNp2TuBzvevIMag-1; Thu, 20 Mar 2025 10:37:12 -0400
X-MC-Unique: 2qONZDfXNp2TuBzvevIMag-1
X-Mimecast-MFC-AGG-ID: 2qONZDfXNp2TuBzvevIMag_1742481432
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-523f6535842so301551e0c.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 07:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742481432; x=1743086232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhfkO0nOeFh31dBWlpIBHPp/23oMIm4/ZzrV7nDHXfs=;
        b=pj6/rlpymPN/0tzX+Kvb9Fu8Z0v5r/ojwAKa2mlV3dAQ1MMESVV3CKbWNDh9oiGmV2
         59Uw4sfgDu4wXQJVYj+Llk+ZsLznMmEXS7vdjny0Bk9/Ue8LTRwsIZuQ3UL3CGywqmMO
         pnSF7sCi7H7FC4N1Xfg1tC3GCNi+n+6NpNQtafzYrWaLPxZzre9Oy4qPEpbF7XvI3jeL
         SqcXgZF2JCgAj3/nSglD8iuoRB/LCXU8MxGw8XK3Nx0ZxB3mANUMyDDErmPuqRx0/onT
         nQiUnYRz6OJPTxczBPXXIoLA7zaGdT+UxJh0pVscYJ+QYJ0jPokeRCoalXEtjpOC+O7t
         7mBg==
X-Forwarded-Encrypted: i=1; AJvYcCXPYgjc9WVgBI/0v1nbBRpiOeB2s2b1V18SpKTw4j3diHWtp7AjmYi5vlYxHmEUrzp8FC6hjofk5y0N7CrL@vger.kernel.org
X-Gm-Message-State: AOJu0YyZlR6CdQzTMsR49yIoCCr0jGLwz02KEqvcGuT2LgRnP7EehUCI
	FzE27eZIoQhQ8VgqbOntKZpyHTQZlAUCdoPv8/8m6CWoaMAFc8rG5733fYLpVbR/r1H7+qUOJg0
	rDCrQNQkl+juVMl+gndGKyBxyx9ZdxyS7qAf9zX4zSAVcabWyVKG1FOp+L1Ru3VhAdnn5RzRI+i
	2Gu2C+p6hydkLG0EjHFTAodPq+DmRh+8WHZEDf5g==
X-Gm-Gg: ASbGncvhB3lMr9HUdgr13RR/9/lxwYtJfB6WZwcwULWF7hz0ufSpjw/xwfPIkPNUMdf
	O9fPlDili+DEtXCMMSxaUst9VS1vs5E445y1ZoB9cXNsdCCGeebgy64Iu6gSpWZoDR8f9PvC5CA
	==
X-Received: by 2002:a05:6122:608b:b0:520:60c2:3fb with SMTP id 71dfb90a1353d-525960812c0mr3062146e0c.0.1742481431793;
        Thu, 20 Mar 2025 07:37:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZzOib+M1uSgBNdPU9As6RS1qawt2FeKNo41kWJkJdCE9L3Fh8fjGANZNClbTw9gJ8Xn1+es3nosLVtfd7E60=
X-Received: by 2002:a05:6122:608b:b0:520:60c2:3fb with SMTP id
 71dfb90a1353d-525960812c0mr3062090e0c.0.1742481431364; Thu, 20 Mar 2025
 07:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z8-ReyFRoTN4G7UU@dread.disaster.area> <Z9ATyhq6PzOh7onx@fedora>
 <Z9DymjGRW3mTPJTt@dread.disaster.area> <Z9FFTiuMC8WD6qMH@fedora>
 <7b8b8a24-f36b-d213-cca1-d8857b6aca02@redhat.com> <Z9j2RJBark15LQQ1@dread.disaster.area>
 <Z9knXQixQhs90j5F@infradead.org> <Z9k-JE8FmWKe0fm0@fedora>
 <Z9u-489C_PVu8Se1@infradead.org> <Z9vGxrPzJ6oswWrS@fedora> <Z9wko1GfrScgv4Ev@infradead.org>
In-Reply-To: <Z9wko1GfrScgv4Ev@infradead.org>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 20 Mar 2025 22:36:59 +0800
X-Gm-Features: AQ5f1Jr8FjeQhNt7BbY6PJzfG3RS9LN-fvPsePmLRNjHLbVpaQVZTtsZ8BaAdPI
Message-ID: <CAFj5m9J1BGiqG+P+7kidH4V0hR9f-BmUar=0ADDR9wpGbnWSZw@mail.gmail.com>
Subject: Re: [PATCH] the dm-loop target
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>, Mikulas Patocka <mpatocka@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, Jooyung Han <jooyung@google.com>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Heinz Mauelshagen <heinzm@redhat.com>, zkabelac@redhat.com, 
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 10:22=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Thu, Mar 20, 2025 at 03:41:58PM +0800, Ming Lei wrote:
> > > That does not match my observations in say nvmet.  But if you have
> > > numbers please share them.
> >
> > Please see the result I posted:
> >
> > https://lore.kernel.org/linux-block/Z9FFTiuMC8WD6qMH@fedora/
>
> That shows it improves numbers and not that it doens't.

Fine, then please look at the result in the following reply:

https://lore.kernel.org/linux-block/Z9I2lm31KOQ784nb@fedora/

Thanks,


