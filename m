Return-Path: <linux-fsdevel+bounces-49587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B43ABFB3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 18:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ABE57ACCD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 16:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359A522ACFA;
	Wed, 21 May 2025 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0U8w8ga"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5AE74040;
	Wed, 21 May 2025 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747844886; cv=none; b=ilDYYZnGmdTnFq3hWzO7aLe6YCkONFh6Nleiz0/0XWV2AiwW2flCb14nllxOY0OgTITzVfYksXeufTFrZD4VrBTcvk16isTC9QK4o1dV49fHggxQAqUChOBSUWQMXgpeXsCZfgaClI9M9ZCzfXEf3/cz5Yc+5BqPow2viosZDnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747844886; c=relaxed/simple;
	bh=hkYsZjTKh8+Lp6DlZpq/TDRKDHkOiRiet7Xu0/jptts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmLHkoiA9WbR2fK0DXyNprRbty+d7tnA2+MEyo3+jg5rWrgHH8Wc9b6Hhbt7NzlysBlz/kBnOKnRa47/MZ/G1OtWFyWxs8ef54IM3kNKLTe9CBSb8hfxEQKRtvy6QGsO4ipRgX6+6yMyvnnGlM9IU3SGaZWhrYj5OyCfRH58jNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0U8w8ga; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-231fd67a9aeso38557275ad.1;
        Wed, 21 May 2025 09:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747844884; x=1748449684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hkYsZjTKh8+Lp6DlZpq/TDRKDHkOiRiet7Xu0/jptts=;
        b=b0U8w8ga/NXkbae61omVAK7KuKVlyfXl5/RRbinlA3x1dnNG9rcdPKMPGSQiR9nJn3
         uE9oyGf6z7SnkjqMWoSXNBAq0g74uSExU4ZECHgFiSxBitcEFBQEIk2qFvKNdcbNN4Y9
         1RPgsfjXYdFo8gL84jnglj+UyNVz8wl0Rn4DdmFC0swssNkusG3bgVffIMjQVyUujDAd
         2DJgdN9V7nKKs9fEOa2cRe1v5dC3UZO7Vwfhd6iGmVTkFB95+/a0/5V+aI4sOAs9WuSO
         dLF20DMdReFaG0oemSdtumc90oXxZ7Hqkm9RTU2/myffgDGGgKDOOpCR8m9woEJkZ+Mk
         5SYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747844884; x=1748449684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkYsZjTKh8+Lp6DlZpq/TDRKDHkOiRiet7Xu0/jptts=;
        b=Gm+yTT3nZrDln2Q3vO1ML++6ZDUlhA0PfL07TarWYNhcKZZsrSucxvqQp4Bz1ANyZ8
         k9+z+jQjnNO8Q9BNICYH9AMTnuGZAuobde/GGirSk4fGulMErHBYnjhbvNQhUGsDgo4j
         0SQUUfP6bz9Th8trqjYNUGGoxUKo/o+ZRtID03gM2vQEAmE7NT/N9PhjQSVijGIuD5cy
         TglmwiTrpEaywC6+cK91PWNtpI8sEfqCJuWiZMjHh+omKQHizkdLOJV4ESgCAB/kOGpT
         mnkQcViqeYChKsh6tvMhtgSfBYBcAqB/EiQ8vFEy3hf3t/lyvz5jLfPQzInCZTGgS8Gy
         a9qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB0JKCIhK5FqJ3l+UcWCPeOW4dVJ/WhZm2Jx2x6WqaNydWgGJpOEgdfl8dpwC14GZkdhb9yZOD7evoT31G@vger.kernel.org, AJvYcCXZGiyzxiBniQFRa19Wb/T9c0DFHbA9lzsGr6QTJBQLCiozIC0UgEefW43UJ3JaHcyrpKKGYF1dzjDU01ce@vger.kernel.org
X-Gm-Message-State: AOJu0YwqqOp8Dz+gWDK0Wm3mWXoJiDKmFCmRzD9PxKGq9i1+lEqwbtJa
	sLJmbxc+Ka/hSVSbCl/XYcVJUn7ySJC7eY9X0BAsdXlBM1jbJQ2Vf3JyDfsHZcWP+7g=
X-Gm-Gg: ASbGncv/1UeY5vkPxQ7Yc3/IjUppZMKtOtmgGPl8s1pWNQrcBzy1k3U5G7WF3g9SYbW
	bVrlneaEswSwE6uqm3WO2sZOlO7Fjl+ksSblO+YquiUkZt4KCx3RDmkuvDfY4V6u6pW06mgLPab
	SGh88Gsskzq/OLR6oh+Y6MwRGJnIbBJbimR0UEY4TpmB2mPiPYscfqmUE7B+SGK/K4ZwR37df8K
	NiycZNy6LUSfnOWykY1htdpvO9AAc3WsNRRkNjTxH7tqnXOesTGAt52emw/w3gI2qXY+Fx74h8Y
	79kbu8WR1IlzR+XwthlLQwivlIzBVWeUNSAC9nBu0BGYgQj6vfRHz2uX
X-Google-Smtp-Source: AGHT+IGDFAfADczlykPv5P2upLGOWFwo2LuRz6MNJKlIPSGrAoz3aDFMma+mezPuKEYNdVrgr78y1w==
X-Received: by 2002:a17:902:d484:b0:231:e413:986c with SMTP id d9443c01a7336-231e4139adamr268386555ad.11.1747844884384;
        Wed, 21 May 2025 09:28:04 -0700 (PDT)
Received: from eaf ([168.226.86.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4eba368sm95212305ad.200.2025.05.21.09.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 09:28:03 -0700 (PDT)
Date: Wed, 21 May 2025 13:27:53 -0300
From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Yangtao Li <frank.li@vivo.com>, ethan@ethancedwards.com,
	asahi@lists.linux.dev, brauner@kernel.org, dan.carpenter@linaro.org,
	ernesto@corellium.com, gargaditya08@live.com,
	gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	sven@svenpeter.dev, tytso@mit.edu, viro@zeniv.linux.org.uk,
	willy@infradead.org, slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de
Subject: Re: Subject: [RFC PATCH v2 0/8] staging: apfs: init APFS filesystem
 support
Message-ID: <20250521162753.GA6112@eaf>
References: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
 <20250512101122.569476-1-frank.li@vivo.com>
 <20250512234024.GA19326@eaf>
 <226043d9-068c-496a-a72c-f3503da2f8f7@vivo.com>
 <20250520185939.GA7885@eaf>
 <n7kkoptktdvldadvymcfmnaw3yqbk6bfmzpxvgdkpsvvpc3p7i@ilqcgz7wur7i>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n7kkoptktdvldadvymcfmnaw3yqbk6bfmzpxvgdkpsvvpc3p7i@ilqcgz7wur7i>

Hi,
just one nitpick:

On Wed, May 21, 2025 at 12:14:53PM +0200, Jan Kara wrote:
> We already carry
> quite a few filesystem drivers used by very few people and since few people
> are interested it them it's difficult to find people to get these drivers
> converted to new mount API, iomap infrastructure, new page cache APIs etc.
> which forces us to keep carring the old interfaces. This gets particularly
> painful for filesystems where we don't have full specification so usually
> the mkfs and fsck tooling is not as comprehensive which makes testing
> changes harder.

For the record, my fsck [1] is far more thorough than the official one, I
don't take data corruption lightly. It's only for testing though, it doesn't
actually fix anything. And of course it could have mistakes since the
specification is incomplete and buggy.

[1] https://github.com/linux-apfs/apfsprogs

