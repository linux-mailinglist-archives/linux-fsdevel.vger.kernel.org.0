Return-Path: <linux-fsdevel+bounces-11793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5FF8572A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 01:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC6228709A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 00:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330FF53A0;
	Fri, 16 Feb 2024 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vFhJ52U5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D42A50
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 00:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044006; cv=none; b=tZStQfPGQC5DijBjKH3FzvBiu+lEWE26RSBVr/jdpPHERSc0Ps99aCifgwBcVrrjYwQovtX1YCq5b6/jaruywA5Qpl08Q0BHL4GsW9pXJUSrDx7R75Oo7NmPADWcuwBFL0v6kmiJr4Pj7/p1hZGLc0pyMQ5wVWW2N034SCDqwF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044006; c=relaxed/simple;
	bh=lNWtY/B1xY1q4emMITPcTwneXwj+O8lm1/92kGWavpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3SEsovrmadNrbty6vv7AqGFfG8SjzHzUR2f8ku8h6yR5O8lvd/tahT6Ff1HJbOhES/0hpk3HbVqZvdglk2vvcD04oTwj6f8A2z0IbxTUMgcLlg6V+1zyEdKHHszk0JTA6QbJdfO57Wdr4nl7vQes+atWRYB3Cim6pAy9ZtFSWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vFhJ52U5; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcbc00f6c04so220314276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 16:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708044004; x=1708648804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNWtY/B1xY1q4emMITPcTwneXwj+O8lm1/92kGWavpY=;
        b=vFhJ52U5Ca5lVgqXIok35m/wap6nAv63NFbqMG9BgcMU0LoFgV5xwyrMj48LUMEffE
         Uszg0p7JKzKZAJkqmYynoxYdmZqkm0PYwHTP86g3ujio1PT6UdhgJ6QbUek6pLkAYEyk
         8NUh6EXYOeiKAn4WWXiH9wX4B3uc5iADYqTjIB1owC5fGlpDICK88WPAZsmZgct+VSSD
         Po7N2t6/E8cr3ZitpP/aeAZ81eZfWhtUt6rDQO7ncBVgUUHk3wkYo6DNepKipZYUnBJ5
         x6ukBbpUrq075zaiEYBqC7BD1U5d6GA5FUre9XS1dFH+rt4m12JjSyhuFoPon2w2UKVy
         HJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708044004; x=1708648804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNWtY/B1xY1q4emMITPcTwneXwj+O8lm1/92kGWavpY=;
        b=B2x27Q0QO33mB4y+cb28cOXBu+cn7ikQElZEVz3ISTKGGV+yaxr6zc/eaKP5v6RfzL
         ohwVLBm8mQL+vZPcfcOflSGWhghC4lrBbe9S41BfxN9sozwMrNrXhF2Ks9GSQD0MBsxc
         77/nZOFwdoYccXv2d9F3+P+BOT42bYaYR95U7ZRqSSKI/Ut4Dqth0fGqzgalyjv6IWwT
         rOvzr7cod+p0gUaepEP99WM7cVZonnkGy6Cc+U4+QuuVa2cRIJAKWY2Ut1Pn+1bgjQsS
         MJO0TNYIkyqIobqfcscLhv/u4OULUEAzkeH0DDAyQmG5l37YRGvck1HNsNimguuqga5j
         joNA==
X-Forwarded-Encrypted: i=1; AJvYcCUomlnUdP7GDX5ON05FgYU9O4iGa6SJkZK8Cw7Sm7VaR7othPoPlfMz1KKNwR87s94M/0WsJhzCOcFshLvhVrGx0hnbYkn1ZCmp0c6gkw==
X-Gm-Message-State: AOJu0YygUmUuTouPA1Yk0pTf/lUVNbL4ov1J3YTasZ2uExw0WlMCiAh7
	ulmSDYqh/xVudRFYmuzxo4x5HujNrd7qZ98WyxugnLn4wnoLhJYTZDue/SpHAbaoL3ZNtzT6MnX
	VCzg2cCj4lm/QY11VPhsyJLV3dYSmEFYaPTID
X-Google-Smtp-Source: AGHT+IHAAsugZ3/nqJLaPaGwbaKWrJXvPAuodtlX22tVU71nS9Rg5t7nXyOIvNMt6vhQws8u5s7RYzYtvfhsM7i5y6I=
X-Received: by 2002:a25:b184:0:b0:dc6:c510:4484 with SMTP id
 h4-20020a25b184000000b00dc6c5104484mr3417966ybj.26.1708044003733; Thu, 15 Feb
 2024 16:40:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214225741.403783-1-souravpanda@google.com>
 <20240214225741.403783-2-souravpanda@google.com> <20240215161441.c8a2350a61f6929c0dbe9e7b@linux-foundation.org>
In-Reply-To: <20240215161441.c8a2350a61f6929c0dbe9e7b@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 15 Feb 2024 16:39:50 -0800
Message-ID: <CAJuCfpHF=yxV9+=pUo+5DwSjvF=r2y7A9_8LHsUGUSoP7EUNXA@mail.gmail.com>
Subject: Re: [PATCH v8 1/1] mm: report per-page metadata information
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sourav Panda <souravpanda@google.com>, corbet@lwn.net, gregkh@linuxfoundation.org, 
	rafael@kernel.org, mike.kravetz@oracle.com, muchun.song@linux.dev, 
	rppt@kernel.org, david@redhat.com, rdunlap@infradead.org, 
	chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com, 
	bhelgaas@google.com, ivan@cloudflare.com, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com, 
	kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com, 
	adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org, 
	weixugc@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 4:14=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 14 Feb 2024 14:57:40 -0800 Sourav Panda <souravpanda@google.com> =
wrote:
>
> > Adds two new per-node fields, namely nr_memmap and nr_memmap_boot,
> > to /sys/devices/system/node/nodeN/vmstat and a global Memmap field
> > to /proc/meminfo. This information can be used by users to see how
> > much memory is being used by per-page metadata, which can vary
> > depending on build configuration, machine architecture, and system
> > use.
>
> Would this information be available by the proposed memory
> allocation profiling?

Well, not without jumping through the hoops. You would need to find
the places in the source code where all this matadata is allocated and
find the appropriate records inside /proc/allocinfo file.

>
> https://lkml.kernel.org/r/20240212213922.783301-1-surenb@google.com

