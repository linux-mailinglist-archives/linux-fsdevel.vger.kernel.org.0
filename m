Return-Path: <linux-fsdevel+bounces-72879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C5AD0474B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 17:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B471230D85E7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 16:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D623327FB12;
	Thu,  8 Jan 2026 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNKHl54I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FACB265CA6
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767889209; cv=none; b=fiozhiNFqCTDkFk66NC63K6xrbt+Nl4pa/9QKdRUjirE86yzrYQgL096LJ/D6yupXNIo5d5xjtskhb6ncXrjv6JvG143YB3GNkmcslIFPpy+cj3+bWsnJUNorW/BqjOHUYqyvleWf3CPZ5ECumlx/ulET3QKuRKSkPq/Axk5x4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767889209; c=relaxed/simple;
	bh=yvNU1AvVWUsd+D1YN7GGiy/e4EfmDjtr0T/TuSwjWKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjjEZPqSwbexiXv7FYWlNk3BAvpiP6arW7go/NxOTXok5pXRqM7noK4OyF1kdFG7HoX4RDd98oFcDowmEkqwxSnSh/Q1grQaNXGFNnDew2hldagyURrHCxpyYGquHUjbIl0ubrvXwSQBW0cpslfAnZBqwCJhYahb3u+UtpTEs2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNKHl54I; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7ce2b17a2e4so2159797a34.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 08:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767889206; x=1768494006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVhhJuuiBGoK/sFvk0bqtRfj9CRgQvxP/k+MrdnYe6s=;
        b=gNKHl54IIO9I5g2NH+3g7xsv2nR/Ixg6cUgki8Aaw74Rt/gR0LM2AyWuWsD4mLIIry
         duuGPRIKgz09CE0Bs6h6GSthtteXS0bqkvzqdYaYUJYtnCi4XpJv+h31rWvn9wyaLU+v
         tflHiYFxeJVdLFrt6EGAOCTWIetZUyB2zbfcm85J27TiB34NplSLElsVEIbR8f4wu6vz
         u0KhDPjs2WABFD3dI3cPWkBYb3tgZ/AHtjMhDUNft73hIPuqsuKmSeS/3GSg0UiYPfiS
         NJuPe1UDBGKfxbVoUTpnQ7wCbx3+dCir9j/bmyXRbe5PppEkcs+KigQFcCM2vvuwNpxS
         xaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767889206; x=1768494006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HVhhJuuiBGoK/sFvk0bqtRfj9CRgQvxP/k+MrdnYe6s=;
        b=epRMJvhdfDNI4UiUE6hHM3CS7UyS/9QdaaJchanNCekSqgYtwDTvnCHRdOZuqWxjun
         pTGAr5X5TAGgg1Ljw/HgeJJ9k/rqhG7KP02DEdowW+CBu6oIHu4D35EnjSCYU2umSSpn
         xO9FLIAutWuWIdst34f67SuL002k7IAdRq1AXWFQZv1NuMEqaBtp++MpdL/F4V0F02sb
         YXcGm3PqyBFIe0uqG6XPLokpl/qR2LsN3FFDXB2xhjpydATOg9u50Bku9h5fDebMAdu0
         +NtjN0Smxb+n7QFPdN3ivezeXQQAdqKkjg5yB9pSIXtA+iUdqe7MkP4tMEYO/0l890LD
         GmWw==
X-Forwarded-Encrypted: i=1; AJvYcCXIaM656PkEZV+ixZGmaCxyaQdg7/efj2PedgA06dQyjLWXQbD/2sVG5L0xqV89op/0c/iWYrT/5ZYLshfj@vger.kernel.org
X-Gm-Message-State: AOJu0YwyZf48vd6wOHq8F7azafmqkIkVYdwBg3haGfuEWmjxlt4LUxGv
	nLD0nKAzzsVcyk31WRiYCdDiy+6QUaF1AbQEHKnCp+ZajJcuUHFal6jE
X-Gm-Gg: AY/fxX7IYykIwUej4z0plIrIARLz13QkaSOgWOElTYdsqerjU8JZsWZWZYKRyGba9hr
	zPnFppyfjZrMa5sO0IkXjy7ML9XrCgjCv75605ba9AhfuncW9nOSS5HHjqrzzgeGOa4kndPmUVO
	X/Tm6J/INnGpLOU44AIuPbzkM59+Tbc1rspH+TzbeeNqFP7ibJXiirU4hGjoiTXJ7Cg+GuWYJvn
	EmQx97n+hxhA3fKt98UUKScJedbQhHQagnJQMqnND/Ho+cjn2Y916RpnGNcGQFXNT+RAFycZAK2
	OyW9fwzz/CvxHTin8moFjmMzZhRB5M26k19INCZyYCWH4fzEwK196N1Afm3aiqUi7avew/uaJf1
	4HNBXGk6tLgCoWff7xkta4bkY8SlFP5ECTyOmZy8FFF1lDyoJ4448HsMwc/YwJPb801NcXJ2MVc
	gcwmsIseTxYYP+Ab/COhYFTNwo+4mGOg==
X-Google-Smtp-Source: AGHT+IH6THnfmjfea6h0UnYX2fNH0dcgns7iJzl58Bvp4j/zTpmPcfdP7f0qEllI2ONh7EMKMC6yuQ==
X-Received: by 2002:a05:6820:f002:b0:65d:1e7:9526 with SMTP id 006d021491bc7-65f54f06dfamr2864960eaf.10.1767889206030;
        Thu, 08 Jan 2026 08:20:06 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:902b:954a:a912:b0f5])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65f48bec1c4sm3344121eaf.8.2026.01.08.08.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 08:20:05 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Thu, 8 Jan 2026 10:20:03 -0600
From: John Groves <John@groves.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, venkataravis@micron.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V3 05/21] dax: Add dax_set_ops() for setting
 dax_operations at bind time
Message-ID: <tndv7ezryq5m57r5iyoyr5suq5lliy37ciqluia7gh6znaecry@nfwbtzmsvcyn>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-6-john@groves.net>
 <20260108120619.00001bc5@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108120619.00001bc5@huawei.com>

On 26/01/08 12:06PM, Jonathan Cameron wrote:
> On Wed,  7 Jan 2026 09:33:14 -0600
> John Groves <John@Groves.net> wrote:
> 
> > From: John Groves <John@Groves.net>
> > 
> > The dax_device is created (in the non-pmem case) at hmem probe time via
> > devm_create_dev_dax(), before we know which driver (device_dax,
> > fsdev_dax, or kmem) will bind - by calling alloc_dax() with NULL ops,
> > drivers (i.e. fsdev_dax) that need specific dax_operations must set
> > them later.
> > 
> > Add dax_set_ops() exported function so fsdev_dax can set its ops at
> > probe time and clear them on remove. device_dax doesn't need ops since
> > it uses the mmap fault path directly.
> > 
> > Use cmpxchg() to atomically set ops only if currently NULL, returning
> > -EBUSY if ops are already set. This prevents accidental double-binding.
> > Clearing ops (NULL) always succeeds.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> Hi John
> 
> This one runs into the fun mess of mixing devm and other calls.
> I'd advise you just don't do it because it makes code much harder
> to review and hits the 'smells bad' button.
> 
> Jonathan

If I don't stink up something, I'm not trying hard enough :D

Next iteration will be full-devm.

[ ... ]

Thanks,
John


