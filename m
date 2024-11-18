Return-Path: <linux-fsdevel+bounces-35141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABF59D19CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 21:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31AAA283049
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 20:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403DC1E766F;
	Mon, 18 Nov 2024 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="FUJHfMNK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E5E1E5711
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 20:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731962571; cv=none; b=VX83TOc7ltQw9PEFZAvdxj/wVJ9MEvr3zioGOBxI9hLLcejo3eh5TFglxoqaheZu0xympaHhUX5oCQmEdWr3vGnCJQTiBWD58wmfpcZFVywCDoCHp2dA9TrcJH7yLqoDuQ9b5KptmVbyMHos+DrhRfQKISEY4/OQBMz+fiBPCg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731962571; c=relaxed/simple;
	bh=dxabNGakL9NrepH5do7y1wnleH+dNche06QzIaELHEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUNVDumcVyxnkPQxfrv0539B+nzuQZGGjQ5tLJdQ6Nz3frJ6cRYO77DK2pmnMXeWitwY5MfpGQo7j3H4aBLiJ7Ks8HEq+1qOeP9+jFMXTCVb42mTFsEhz9Np1kqddYceOPXEYDhZsMyHKo0+cUVBZDr4fegF9vXtcKHX1kxIc5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=FUJHfMNK; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ee763f9779so86337eaf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 12:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1731962569; x=1732567369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Az3Sp8d9covPjAGoeraghsVludZNEdQZrTadq9s3zg4=;
        b=FUJHfMNKRviJrGBdZmSorm9HK+yxWtkfXbWyRmPRefXg96VxXIpgXCvg99Dc0fDMFV
         WtUANSnAESrftl1nHDR8rfAMRXefAT6MLW+2v1wo5bU0F3O63e0MquGb1VAFyRK3JFZ1
         tXQRR32/lhFpiRQQ9c5wJSsWEa8r7Xyg47PaRRm2dajgn4sje9XjLkGZtIWLEsDgwnkv
         5EkDQMI0vW+MmYojcBo39EC3uZNx1x5AKrQts//GeRadpZpE4+Fejt5/46oLXVKI8UuF
         uncYQYieqpP2hhpWXFLIoR48ICLuf7IGkuRHC8CcqHDYsM/emmmQ81nuOZoGDW2Q13FM
         LT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731962569; x=1732567369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Az3Sp8d9covPjAGoeraghsVludZNEdQZrTadq9s3zg4=;
        b=mwe4zEx6SzUlCMN1B1hXP3zAueM82U5lJeurwnOQn5YlEGebuMbFdW//vGurJNjuea
         d+j4XkmcoaCkCIEnNEQxXLu21ni9V1zMEfEw534JL5EnzApa48aKKMz+0pCkW5L6qtaI
         XQIWr+LJbIwDYppLbSREj+1QyA5EpqYmxteIXi+mB2Vn1wG070lQm5LP0us5MH3zcgs5
         hbd6djGiAI/o7kfJ7Tl5S0x9EUK/r3ulMk1nwrKVkD5T9vEXmadKNpud1aPMk3DrT0cg
         qbFLLWbdMd7J4XbGZjILVq8lyXL69n07DP464NJErGilyDF7FMWYV0JwDPeEO3UKkCjj
         fZxg==
X-Forwarded-Encrypted: i=1; AJvYcCW1YcyXfinjWjmNGkaSl1+hmQ7QwcZ7eg/uP+ryODGoUOJl2A/K86Am1ZFVB/6qOgKi3KdK66hZ5gDR5t+0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0xtc5hJ96k5cp5jZIA2fxHE2Kkofh25amZQhLNtSWzXsXniqk
	LrIqu2sdXGdgXzEEvMgDH8mj684GTXFRioagskUcm2uSxmyMZs0LB5hbOzXhzCvDyf5eetC2Stf
	EwUJSD9ZS6u2IRWwG/wvfgrL7ifQORt9JsoMytQ==
X-Google-Smtp-Source: AGHT+IHttxr2eFNSFhV8PpJus1DCBKmx1o7nfN6x9M9fk44cvRJr2moQ/A4XKlnUEVw6YKcIvYheu82B5igacrHaq1Y=
X-Received: by 2002:a05:6358:170b:b0:1c5:e2ea:8992 with SMTP id
 e5c5f4694b2df-1c6cd22c1e4mr505681155d.11.1731962569411; Mon, 18 Nov 2024
 12:42:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <20241116175922.3265872-3-pasha.tatashin@soleen.com> <ZzrjYtoC3G0Yl8pM@infradead.org>
In-Reply-To: <ZzrjYtoC3G0Yl8pM@infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 18 Nov 2024 15:42:12 -0500
Message-ID: <CA+CK2bDp9A+ZzEwm60vDW8m_3U7u3FM0iUdM1N59VjdwM4_j5g@mail.gmail.com>
Subject: Re: [RFCv1 2/6] pagewalk: Add a page table walker for init_mm page table
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com, 
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com, 
	shuah@kernel.org, vegard.nossum@oracle.com, vattunuru@marvell.com, 
	schalla@marvell.com, david@redhat.com, willy@infradead.org, osalvador@suse.de, 
	usama.anjum@collabora.com, andrii@kernel.org, ryan.roberts@arm.com, 
	peterx@redhat.com, oleg@redhat.com, tandersen@netflix.com, 
	rientjes@google.com, gthelen@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 1:49=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Sat, Nov 16, 2024 at 05:59:18PM +0000, Pasha Tatashin wrote:
> >       } while (start =3D next, start < end);
> >       return err;
> >  }
> > +EXPORT_SYMBOL_GPL(walk_page_range);
>
> Umm, no.  We really should not expose all these page table detail
> to modules.
>
> > +EXPORT_SYMBOL_GPL(walk_page_range_kernel);
>
> Even more so here.

I will remove these exports in the next version, as I am going to
convert Page Detective to be part of core mm instead of misc device.

Thanks,
Pasha

