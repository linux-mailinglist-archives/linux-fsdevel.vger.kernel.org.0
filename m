Return-Path: <linux-fsdevel+bounces-70321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39218C96954
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 11:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 161F44E0382
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 10:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9788030277E;
	Mon,  1 Dec 2025 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nh8Ea9EF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D682AE68
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 10:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764584044; cv=none; b=neT4paHVqNJW1iQjduCgJuE90fu3TNtfQfYLEeazUus3lLBIXwQd8/HVzKtpHtdaT5Mx416esXsKAJeyf37yzZF0r4TNggD6icU63GHCKkrmEd6w6bRgT8qr7sq4heQzWA/FqIijHQK/5JLmM2ctLb5nnhpcK1ZlhP+4Y3rLegY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764584044; c=relaxed/simple;
	bh=10MAsaOAyxvRMyNWTa7LP5uT/gsuj+68eCxTSSuxX2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/n8yQZmWImCBR4EC1b04ISuIklbiDYwXfSbG/FX+Nf/N0R9z5C1XRm/OeomWiL7okd2vpCVRYTCdR7dAqTD5XO9e/+5t7zGD6vEpaPi9zsqvVez/oIz+z8WqaHumERxsRT9l9L10GI540vaw5y5rC7UBQvKmtqaAwy0xFkyhDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nh8Ea9EF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F4BC116D0
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 10:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764584042;
	bh=10MAsaOAyxvRMyNWTa7LP5uT/gsuj+68eCxTSSuxX2U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nh8Ea9EFywn7lKWzdvP/Mfx3vNHOLpRkCz84/o+eRYQF4vUx9LZ9Jw1XG86CHAKrx
	 qh8rf6O0zNUfwf8Zp57gwuHEY0+bkMa0k6R5Z4DwvSO329fYAynndqyPgCwQCE4mS6
	 RmgTNEYOx6fUV49Qjc1D9KAbamof187hxUafHJZklGMLVgKgPdKVMRU9dwsTCyi49Y
	 15Ad4XCMUN58MVVL+gdXw3ClYxUNAwdJf89jxCvA/1dZ1RI5drtnoNlvuHj4PsZUCG
	 p2fwhPGbgQp7spVDqc73lBqnUWdr4fgShaE14SL/c6HI3AfStcZEZ+bnDe17z0PXpE
	 VlFanzprghgOQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b73a9592fb8so1034202266b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 02:14:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXXez+Kbz91pYs1gO/0wp8IV7xQLh6MeMIWZoPuyiBrOQkGE7qQpz0ShMw/j07kcUAQ8DoYFeRfxM2erUfR@vger.kernel.org
X-Gm-Message-State: AOJu0YyRtDcfFoqxvihdssi+FLaPmHUO7jK3R6MdWpCgxEQ0sM5AKLUy
	XaPT3L+YTxAr27TpmsKqVOF+QHICY+3vsPWXlXMNbZ6N5+LJiU4ri9FGn8Tw0G1bTpp5yDY6BrQ
	lxQpILzk+Vw/izrW3kwhCadq8WygHFLE=
X-Google-Smtp-Source: AGHT+IGrwqQVIBTSufO1GP8zUzTCH2dW/Mttf+y98FRONrxdedacCnXPgK8yP9tykH/QHeW09CuXJVtL6iU0LzYBJBM=
X-Received: by 2002:a17:907:3ea1:b0:b6d:f416:2f3 with SMTP id
 a640c23a62f3a-b7657285452mr4492025466b.19.1764584041336; Mon, 01 Dec 2025
 02:14:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127045944.26009-1-linkinjeon@kernel.org> <20251127045944.26009-2-linkinjeon@kernel.org>
 <aS1AUP_KpsJsJJ1q@infradead.org> <aS1WGgLDIdkI4cfj@casper.infradead.org>
In-Reply-To: <aS1WGgLDIdkI4cfj@casper.infradead.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 1 Dec 2025 19:13:49 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-UO=E-AXv4QiwY6svgjdO59LsW_4T6YcmJuW9nXZJEzg@mail.gmail.com>
X-Gm-Features: AWmQ_bnj2nAjrV6G941L3u0BMPGwk6v-nfqO6XGMVVGfoiAsxYaLVslUkGhvCcI
Message-ID: <CAKYAXd-UO=E-AXv4QiwY6svgjdO59LsW_4T6YcmJuW9nXZJEzg@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] ntfsplus: in-memory, on-disk structures and headers
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	hch@lst.de, tytso@mit.edu, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com, cheol.lee@lge.com, 
	jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 5:47=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Sun, Nov 30, 2025 at 11:14:24PM -0800, Christoph Hellwig wrote:
> > > + * ntfs_read_mapping_folio - map a folio into accessible memory, rea=
ding it if necessary
> >
> > The very long comment for something that is just a trivial wrapper
> > around read_mapping_folio is odd.  Also why does ntrfs need the special
> > EINTR handling that other file systems don't?
>
> I would presume that this is because NTFS is using the page cache for
> metadata and they don't want the metadata read to be interrupted by a
> fatal signal.
Right.
> Of course, this turns into a spinning instead of sleeping
> wait, so very bad for CPU usage.
CPU intensive spinning only occurs if signals are delivered extremely
frequently...
Are there any ways to improve this EINTR handling?
Thanks!

