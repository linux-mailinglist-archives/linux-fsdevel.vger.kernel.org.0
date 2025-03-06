Return-Path: <linux-fsdevel+bounces-43358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9081AA54CAC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 14:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC33B3AE8FB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 13:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF0D13957E;
	Thu,  6 Mar 2025 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NO+hsroC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A3E74059
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269331; cv=none; b=gr8FqLvLCd9itj75dm9jjI5+YPouPsFfeQyIYBc27agP0mETwXa0J6xRVuKnbjdQ2W9No49YU0CH6ENKLbvN6ysVpXOq1ZP+4k+aC5qskTzSGmVYkWcifZDNdN5FCPDR87W7NrpE6EruSrERPk8MXKXBEb1lfuLY75YcQo3Ee4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269331; c=relaxed/simple;
	bh=e4dIS6uRGrNz4cNFNpjtZYbdKDDxOseAZRayz8xAZGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0lt117EHVrX2daQGYB0W1tpoWFDahCuwPRAoF4Q6pcnctjdluWtyuNEZmyvmVRbfLt06tW5gwsbdGTzSOM00fKy3emJSP7m1SwXiXcyLwjy9EhdrgN0luoVVnUx5fCJxaVEXnIgoseN/kI67O/E/0sVWzFhz0MgbTlM9x6yLVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NO+hsroC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741269328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e4dIS6uRGrNz4cNFNpjtZYbdKDDxOseAZRayz8xAZGs=;
	b=NO+hsroCrhi3oUP9khpGT8dg4BmP+Fvtx1M/UN6xY2HTnjS/E7bJenM4CZsWjfdn3/BRF9
	Eh22DP+9y471VxiWIMdvVhLr488mRr+ZL4s99ZPXEPvxnuXxoU1DpFgIK9T/QDqQmarjOW
	/6m/DYm+XWmvQlq4BUUv/8f0QmLLND8=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-bwsL3GQJOfS1LvettHZ6fQ-1; Thu, 06 Mar 2025 08:55:25 -0500
X-MC-Unique: bwsL3GQJOfS1LvettHZ6fQ-1
X-Mimecast-MFC-AGG-ID: bwsL3GQJOfS1LvettHZ6fQ_1741269324
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-523c33cfea8so827008e0c.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Mar 2025 05:55:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741269324; x=1741874124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4dIS6uRGrNz4cNFNpjtZYbdKDDxOseAZRayz8xAZGs=;
        b=D/h+z0KeX7+MTybYRGPqPW0Qvw+qMAqODjo9IwvsppjnpZOcYjaYMXaoIQBiIiZBkX
         CZ8CcRx3TVNgbff9bpYd3QuUNnAHxlPnis/CcSNcDhA+Fc4gAQbQzE1ky25JU4I4tvwe
         VCpbt4GTMcY5/DCMcikDCjia4M48cs30R6kuv3UHy8OdlJnsZX404apkRDcJfzTjlad9
         HT/FcECCiXRQxr1F8VrjOpATEX4WCAjh159GSppmRkPH8JoGXXXeFgjq296ofl+qyAwT
         aflw40lUsGSqZDOeLHziaWa6vdirkCtxQAdBiAQtlYsSAV/FVutBbvEIpIm9Gai2+4rb
         Donw==
X-Forwarded-Encrypted: i=1; AJvYcCViicsr7V3UmoYw+fC7mDPduJaX/W918u2Q1C/L/+9stVLMidWNWYLmoQPY1wDT20PK3HYxRzmXd9DzDkQg@vger.kernel.org
X-Gm-Message-State: AOJu0YweMpXtk3QoSJ/vbVzb+M1bo9sxlPNOmBDT8AujCky/GVRYvX6f
	V+k2jNPijDBdQGxo8nnjNt/HkNS/3f7NVZeSolxHFYLhxxwaxULqigzJ7Q4GENK6A6yRIuaTdeS
	PFEZn7uMn1QeTStNAKpHPo3Zdyp/NBODgSObdV2DrqIPj4FKy52CH/BGkeukxqmnX8LGem3DprO
	w2XUjb/hSmllyWz4rzE6XMpAUosBtQ4YMO7UW9qA==
X-Gm-Gg: ASbGncsb4U2exXyJnjnl93yIq5xQRpxcy/GMsW8cFD8rGsc/MWxezkTbmy/RGhaMmA3
	L3qhXLa1md3irhzZJdTAhgPeBOO9+6o1evUDpkuTACIC+DfqwYEDvlmHVkqz20d50GwIRDuT0
X-Received: by 2002:a05:6122:311d:b0:520:8a22:8ea5 with SMTP id 71dfb90a1353d-523c62d0b59mr4131939e0c.11.1741269324524;
        Thu, 06 Mar 2025 05:55:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTTtFaQhbGWpFrtu91D+m0udH4MOo8rOp9CuZE6mF/YlW49JAX1pbPGdZ/JS2Fbm94bLdqsM0Q1gDbgqI9T6Q=
X-Received: by 2002:a05:6122:311d:b0:520:8a22:8ea5 with SMTP id
 71dfb90a1353d-523c62d0b59mr4131927e0c.11.1741269324263; Thu, 06 Mar 2025
 05:55:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3989572.1734546794@warthog.procyon.org.uk> <4170997.1741192445@warthog.procyon.org.uk>
 <CAO8a2Sg2b2nW6S3ctS+H0F1Owt=rAkKCyjnFW3WoRSKYD-sSDQ@mail.gmail.com>
 <4177847.1741206158@warthog.procyon.org.uk> <CAO8a2SjC7EVW5VWCwVHMepXfYFtv9EqQhOuqDSLt9iuYzj7qEg@mail.gmail.com>
 <127230.1741268910@warthog.procyon.org.uk>
In-Reply-To: <127230.1741268910@warthog.procyon.org.uk>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 6 Mar 2025 15:55:13 +0200
X-Gm-Features: AQ5f1JpnxGdeKrhKSz9blMqZa5LrOlpVW18iGxm4IojQwEugdRw4hShfJAhqRKI
Message-ID: <CAO8a2SiCLxrLMFx94Au2X47fiTwBhW=6YZrfC8O4D5G0x+VRjQ@mail.gmail.com>
Subject: Re: Is EOLDSNAPC actually generated? -- Re: Ceph and Netfslib
To: David Howells <dhowells@redhat.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	Gregory Farnum <gfarnum@redhat.com>, Venky Shankar <vshankar@redhat.com>, 
	Patrick Donnelly <pdonnell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That's just one example, presumably any request that is serailsed from
the network may contain this error code.
Specifically the ser/des of the messages happens in net/ceph
(libcephfs) code and fs/ceph handles the fs logic.

On Thu, Mar 6, 2025 at 3:48=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
>
> Alex Markuze <amarkuze@redhat.com> wrote:
>
> > Yes, that won't work on sparc/parsic/alpha and mips.
> > Both the Block device server and the meta data server may return a
> > code 85 to a client's request.
> > Notice in this example that the rc value is taken from the request
> > struct which in turn was serialised from the network.
> >
> > static void ceph_aio_complete_req(struct ceph_osd_request *req)
> > {
> > int rc =3D req->r_result;
>
> The term "ewww" springs to mind :-)
>
> Does that mean that EOLDSNAPC can arrive by this function?
>
> David
>


