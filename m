Return-Path: <linux-fsdevel+bounces-30393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222BE98AA3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 18:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB49A2819C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 16:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBF01990C1;
	Mon, 30 Sep 2024 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJHYfrs9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9681946AA;
	Mon, 30 Sep 2024 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714804; cv=none; b=ik1EqUmQWvcFXq8/m/mn+1syl6nBg0RrWwUJv5KYHq86M5UccLO55ZxVGSDjPaSSSktILhyYNMYVLkCUnJ8JDAhRCPQSUXGk6wTHwbRA6X5AfG2djAyYhiqhi7nh9did/zWUV0oIgC4Jh7N10Svs0ND5XUaKmMIOJzMOm7ZL35g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714804; c=relaxed/simple;
	bh=1rGJ3ml+BkufanYBiG4ElBjkODsCW83l25J2SX/Nfmc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZaUPklMNsKYNvD+Mjh4I/wDxnu0iEmmQP00eS6gJ3B8I/VAYDDFspb3GP1Bu7N9nc0m7urHGcn9Z7ZbzgeZDFcUHPncRdaOmtS2Cni4jEb3CQhE3rv8cxO6wWdC8OQgpRhFhzVNGHzFU/2jfIIzo/53seHYuI6KgW2i8AXmE7Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJHYfrs9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20ba6b39a78so3168215ad.3;
        Mon, 30 Sep 2024 09:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727714803; x=1728319603; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oFMgdLn7hB0TMtt+qsWxpUh5i8iT0KYc/LM27VmdFOA=;
        b=YJHYfrs9rpOwz+to2j6Ewri3t9bulRdMja1hdfA+4zSyelhdRwvxLUkdTp82IwFElq
         BXql3ebOzd+EZ0dI+c/vxh92LxBsv9Uu0qtdFrEU4cdBRdB9vcwMT8j84b2iQr0c/I9A
         Lk4sv7eUnDmCKfx3B+Zjov7D3gkzu9ix3sdZH0SCEM6ycWlOsEhlpjy3ZMEJcY535nHL
         YTy+KGU7pGeMAulxfv1eP+Qn1UYOMGlLZQERGvfj3gPXht7XdBVZPUVc+FWh57rV6xFY
         YtpVY/TNPtuFOqg5RQcoY0VWJdXuriWGMzazx01WzMDFGdPVwV/af2iMJmBFfh1E2LHH
         nlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727714803; x=1728319603;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oFMgdLn7hB0TMtt+qsWxpUh5i8iT0KYc/LM27VmdFOA=;
        b=uwT7KMhsGPy75Myyn0ejoae+y/DdljZCiYXdhyNo1eRQORxrbLAg0zoPc8uukkoMcf
         lNNI5ZevBVCQeaL5IIJIKkyoyi/HRPVDzr1Ns08t4UZC7lb0iT5/w3Kvs3JDvRRP8VlC
         7/aHmwbKKV5kkOL/Kv48g59Bh1tvjKqwTDmG3Y88dshYZgk6Vy7u5pU/WVhVFKFHHZRp
         IbAWtHfJV0CXM62lu2IcWH/bWKJlDghNZOWxutPaoDAbcwGjdKW8njvEYmIj+pZOgx4q
         e3vfZFUzsl0d928g5ENWK+KsbzJc3Mq2Wb/kpbdbcAxYA7/3cPTZxNRi3hsTpUZgejjA
         FgAA==
X-Forwarded-Encrypted: i=1; AJvYcCUurJcBxE+Jf1VdErf8gnsQNhLUa5tet9/FhHqD7rfQRH4uwXWdzJKIbUuj8IAj/dz5Yg1nhGsl1cIX@vger.kernel.org, AJvYcCV3yGyHlJ9hE7W3Y5aXSnhEJgjTMMG+kHRCsHys5Uobv1haaRmLgRyg5fct3ByPWuMBkNchMfy/zOhdXg==@vger.kernel.org, AJvYcCV4sbMorniZ3KfQc0Rih4TZ9ZWlJgcBgpSZqePsWlFe7ubS/caetrCgOeKzGpM0d8Jydpoc50ULZtuwypTt@vger.kernel.org, AJvYcCVb6pIf1TbZjzsiLKYVxRS7TPzolRyG6Vy2elsiHFh45x8RHqahw2Gl3UKV5UDr6j84a3kA+b1Z@vger.kernel.org, AJvYcCXXL5UV8hH0YeVMWh/DvPd0jDv7VgJEHYqfd1T0sQ61PzVZkubiSl1pz9sp+Hg83uPa5nUFH9Su+Qde@vger.kernel.org, AJvYcCXrkyUnt7g+t5QYVU2eJU1ZynbB40QkddROShZ4HQNURiGCf532IpTCrfO3XdxT9LPMgJA72U21Lwu9vQFQrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJME94YiV0877LQk+iWJrD6qCwVVUJF/LlFnYLHIY6PB22WCxp
	mO7zjjtLd0Aj4HsCgnFZf1mOTrO71GLznNYhQH0bSZ+s9IXisZiy
X-Google-Smtp-Source: AGHT+IFZC3EJ0qzaaUHzbstF3Ibe+95zgKik8WWlYGIZbkQX0EKejoD/dNihbdBEqG2pUNucAQRStA==
X-Received: by 2002:a17:90a:bf03:b0:2e0:a28a:ef88 with SMTP id 98e67ed59e1d1-2e0b8eeebe9mr12068969a91.41.1727714802654;
        Mon, 30 Sep 2024 09:46:42 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c9d354sm8211290a91.25.2024.09.30.09.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 09:46:42 -0700 (PDT)
Message-ID: <423fbd9101dab18ba772f24db4ab2fecf5de2261.camel@gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
From: Eduard Zingerman <eddyz87@gmail.com>
To: David Howells <dhowells@redhat.com>, Leon Romanovsky <leon@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Manu Bretelle
 <chantr4@gmail.com>,  asmadeus@codewreck.org, ceph-devel@vger.kernel.org,
 christian@brauner.io,  ericvh@kernel.org, hsiangkao@linux.alibaba.com,
 idryomov@gmail.com,  jlayton@kernel.org, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org,  linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-nfs@vger.kernel.org,  marc.dionne@auristor.com,
 netdev@vger.kernel.org, netfs@lists.linux.dev,  pc@manguebit.com,
 smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
 v9fs@lists.linux.dev, willy@infradead.org
Date: Mon, 30 Sep 2024 09:46:36 -0700
In-Reply-To: <2969660.1727700717@warthog.procyon.org.uk>
References: <2968940.1727700270@warthog.procyon.org.uk>
	 <20240925103118.GE967758@unreal>
	 <20240923183432.1876750-1-chantr4@gmail.com>
	 <20240814203850.2240469-20-dhowells@redhat.com>
	 <1279816.1727220013@warthog.procyon.org.uk>
	 <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com>
	 <2969660.1727700717@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-30 at 13:51 +0100, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
>=20
> > Okay, let's try something a little more drastic.  See if we can at leas=
t get
> > it booting to the point we can read the tracelog.  If you can apply the
> > attached patch?
>=20
> It's also on my branch:
>=20
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/lo=
g/?h=3Dnetfs-fixes
>=20
> along with another one that clears the folio pointer after unlocking.

Hi David,

dmesg is here:
https://gist.github.com/eddyz87/3a5f2a7ae9ba6803fc46f06223a501fc

Used the following commit from your branch:
ba1659e0f147 ("9p: [DEBUGGING] Don't release pages or folioq structs")

Still does not boot, unfortunately.
Are there any hacks possible to printout tracelog before complete boot some=
how?

Thanks,
Eduard


