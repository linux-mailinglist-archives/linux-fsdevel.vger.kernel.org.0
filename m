Return-Path: <linux-fsdevel+bounces-23046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDBE9264A4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 17:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B8D1F214CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 15:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805CA17B435;
	Wed,  3 Jul 2024 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="NsVQ0EPa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA4D1DFD1
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019754; cv=none; b=GTBTMj5CR2RUj3Kz98sMgzC+tizXWRJrmBg+09NvGD3RQ2eAZByvAF6KvKnZS4ds7VH8+ikQs+cifeVO7HG56j9s8QgJ43Lr6YONq3zSqIHnG7GAJgNcJ3Lx9IsgIAd9bo6IiykOdSLwRqc84seT/PIci1ZszNYHCkusx/RJFxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019754; c=relaxed/simple;
	bh=ASBA+DJFkayr3DMcmb0ilv/HZ4nzpa3D0hLjIA5kCqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iISsHMpHY1fZtn1oJohOskWehaha/cQNLKiCVxMhgicfCTpRdFQyjxjcPTxbLE9POnbTv5rgHoT1FoNp8ZF5vgaYYwcAOtrqn84dxNXAa2OWnnvhWT55gPfjSOjUreuZzmMNLXTljTeZyQrhbS/9Sbbst/zk3CGDhr1+BnZ7yBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=NsVQ0EPa; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b5e0d881a1so5731696d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2024 08:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1720019751; x=1720624551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/YUC6rdruCrIMRPleK3eiF+SE+tSis7fnO4wVRkGdM=;
        b=NsVQ0EPanVmV1i4vPFRa2l7GvjuIGsTW1OvJ8E5K5GX1bp9MmGuXQF7jFBqzoxRgwp
         s3plOBb0Dp2Rm0IJqx+t650k4rrl7wLO2mLFxjl0/YmYQ/2m4t8+uTEt9ywXhTC3ZzAD
         rj9wnOlMGuXF6nahDW4EQglPB95JsVGfUgQ+033N1KNJ4+Yz6EzxnPbPA3zAtuM61KKd
         WZSvRUtAbRJogHuY0bOkYh7Uqi/EOQFu5rOOHIJJj6nPuB5xCaQw+knGOOxJwGMIHPV3
         ha9aw09CLHlWmCgS2AA6NQflOcybWIwSU52u8rUaAT6rZNfNak7hiFY90V4ERa3j4ZB+
         5Psg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720019751; x=1720624551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/YUC6rdruCrIMRPleK3eiF+SE+tSis7fnO4wVRkGdM=;
        b=CF+IpzjbEMT1Ng0qrTJQxpEqrYJZMk/rvjnFWQYFvT22rxGChHAvUQHHuobnt4TcZK
         hvJzVjSNvP6NAz3hbZEeKxdD5+45AqpOy6L4p/9bdrmKLUncgX29kmAbAa06ytfQoyov
         vnuEO3A0/uNJv/IEl1B1idlJwjpOnSU/B4gtoacC3GvKW9fTQENwi32jPGlFPkhzj+MT
         B0utD+bGGZcUhrkn1VuZjKDKtsk/dutpsPJ547Zlx0nh9bWvsuce+Z5CJAc1515RlZ9M
         SiUvZn6fp20wlndV8SZfVpKopH2fPn13UdwpjIhPjebrEppIy09x3RQjQaZ2HvSRrZZT
         aO+g==
X-Forwarded-Encrypted: i=1; AJvYcCUfT1V796yjY6xWDyoVS29WVxRwHaFnwlC7kwq5lJ3ZWeXOw7U0gwSIou5fwXpp1+eJjvESFO5w0t2pJZA9lCu/2FQywuteVZXD53eJnw==
X-Gm-Message-State: AOJu0Yxuxci0Gxr9hOol93pcc97LVReKHn8I9pfcJcXsnM+IUirWgjpB
	irTXYwMsQljRKMRf5YCtbwK2ZaToJzhEOmYKs5gGCEuElXthPPmjWqaJrkp263A=
X-Google-Smtp-Source: AGHT+IEepDDJ93tjYnldtbfqwd1hYVjD/g0INtUr4yoLqrQVUQFHbfjqAzx2rdJ6/HR/maFOXqP6yw==
X-Received: by 2002:a05:6214:20e2:b0:6b5:198e:353d with SMTP id 6a1803df08f44-6b5e18b18f4mr26354806d6.10.1720019751170;
        Wed, 03 Jul 2024 08:15:51 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5837cdsm54411006d6.70.2024.07.03.08.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 08:15:50 -0700 (PDT)
Date: Wed, 3 Jul 2024 11:15:49 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm
Subject: Re: [PATCH] fuse: Allow to align reads/writes
Message-ID: <20240703151549.GC734942@perftesting>
References: <20240702163108.616342-1-bschubert@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702163108.616342-1-bschubert@ddn.com>

On Tue, Jul 02, 2024 at 06:31:08PM +0200, Bernd Schubert wrote:
> Read/writes IOs should be page aligned as fuse server
> might need to copy data to another buffer otherwise in
> order to fulfill network or device storage requirements.
> 
> Simple reproducer is with libfuse, example/passthrough*
> and opening a file with O_DIRECT - without this change
> writing to that file failed with -EINVAL if the underlying
> file system was using ext4 (for passthrough_hp the
> 'passthrough' feature has to be disabled).
> 
> Given this needs server side changes as new feature flag is
> introduced.
> 
> Disadvantage of aligned writes is that server side needs
> needs another splice syscall (when splice is used) to seek
> over the unaligned area - i.e. syscall and memory copy overhead.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> 
> ---
> From implementation point of view 'struct fuse_in_arg' /
> 'struct fuse_arg' gets another parameter 'align_size', which has to
> be set by fuse_write_args_fill. For all other fuse operations this
> parameter has to be 0, which is guranteed by the existing
> initialization via FUSE_ARGS and C99 style
> initialization { .size = 0, .value = NULL }, i.e. other members are
> zero.
> Another choice would have been to extend fuse_write_in to
> PAGE_SIZE - sizeof(fuse_in_header), but then would be an
> arch/PAGE_SIZE depending struct size and would also require
> lots of stack usage.

Can I see the libfuse side of this?  I'm confused why we need the align_size at
all?  Is it enough to just say that this connection is aligned, negotiate what
the alignment is up front, and then avoid sending it along on every write?
Thanks,

Josef

