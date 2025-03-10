Return-Path: <linux-fsdevel+bounces-43668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E786FA5A367
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 19:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 490167A695A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 18:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47B2235371;
	Mon, 10 Mar 2025 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+dQb5ju"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9174E22FF32
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 18:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632643; cv=none; b=m4T22vDxXr8lfJldQPrfYTQEUKGtiahKC8eTJ3Mr1bfnhutLGWsKwplZi0emkvmotHknho5TET9tTzCRKvgKyfI2M3kLEfwIm4SV/Wnpzeubi+Y1bAijbRTnNkCrpZJyo8sfmU+VAzWrBsdj11EJWoFZeuji+fu3jeH4NgYcpj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632643; c=relaxed/simple;
	bh=dPX9KXMSSrozDVw+qUXao0MbiQYYiyrdTiOy2wYJvtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IV0vdTCgYg0uaX1RWErz4CdhKHlNmacc7aGif/UYQZUV3+9XDGM81BgpMO6BaNFGTdUkVHzYfSSINbd2o2nDmF63bvmkH17i6O1HYPjtYqTNyAyFyEXfcr4MMmACKsWKLqOXXWKkqyUi8J0YHBSpBlBkfbLXF2la0bSl2xlSEnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+dQb5ju; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741632640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbs7NSbL6vKlRMHSJIXxZs2mfOWdL12EXaa0cm8bbjU=;
	b=M+dQb5juiQK8ZspEWopOoHO3GHUh9uBObo/M5O5Nf7EIHx8epbgcR49VpIGrJSegH4//iE
	FkQF8+yWFQEdJjo6ovHZA4O1lJW2YLBcNJuxcgvGLGvg6ApH8Pu0sb7tRUDvLnSb6+1qZu
	krwGW0EdcaYZDfHAPyyrCqAQQrvoAbU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-N0c1C0EhMOKFDgcgGlcBiA-1; Mon, 10 Mar 2025 14:50:39 -0400
X-MC-Unique: N0c1C0EhMOKFDgcgGlcBiA-1
X-Mimecast-MFC-AGG-ID: N0c1C0EhMOKFDgcgGlcBiA_1741632638
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e913e1cf4aso53707656d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 11:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741632638; x=1742237438;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wbs7NSbL6vKlRMHSJIXxZs2mfOWdL12EXaa0cm8bbjU=;
        b=FugjTENyrkeXXakYPaEFfzKQuPlKSgmC2432ZOJXg0ifGclt8oPvLTKDFCzx9M94Tz
         tQNLvw0ufdRc7VdodlKN/xsPGh437U+yocf2bxkHxHTKlvKboOCiz0A0+2/Tcii+LtXr
         yCQoWZMxIdE7NSv2Lsg8mLULVdphBzH2m3DSTZXEMz1iodbl7sPtvZCSddw0C9MH+yZ/
         JG6sy5S0xbNZhx23VFnXOFM21d3+TngdXH3LJwnLF2y6kbb23T8SjRcI65WA103MRkTa
         yzPXi1gbG13eXJmSC3KQUNDxS71xJOE0X1i0Z5fDbx7ge//rXNIs0M5fpg5puTN4lx9n
         VVAg==
X-Forwarded-Encrypted: i=1; AJvYcCWnPs6e03bDgEI4K8s7a1v70wTGcuna65BT4tUeo5OZIBeW70RwuZPjqA3CB/8MHg1HySr6jsJrIWrfWcYV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/THqqoRUKmQFMevDo5l241JGNXsPCQeq60no+WgZDjKKIjnpb
	TsAP5G5IOpzQ0oNd8ifs/vKl4J0D6COiuuFnDauH/wUlc9dFHzG9qBfG1tsiUYH8N8to22xWufQ
	14zLRwO/ntgprPodujmDS9x+OGSgY6N2FBK04+ocqqd/cZvt759qINdC1/SxKCgE=
X-Gm-Gg: ASbGncsFT+/bei+Z5qHAZEqE/clSPlJju0BXqaXFbpMunpHbRyCgpIlpGXcpLElZcj6
	I2heuTjhnuUkNh3cj7eCGiTN+KuI2SFhaJXYYPLGw50UxAqDkJp6V4kmEAnIsy8nFQNKF4UQzUC
	YFUR2hzc3IlaoHfOll0lvR+f0EY74h6xR5PnwidvdN332QHLi7LMvd9lhlOluwDE/0C2opTTw8n
	gkxcEeDx/SeLqPHMRAFmodhcKujqKjPKrXMbSbUWiGmEY1ti0Rz4DGwwI59MJFdTpapfhP1oVGK
	Wk5rZ7c=
X-Received: by 2002:a05:6214:21cb:b0:6e8:9fcb:5f7d with SMTP id 6a1803df08f44-6e9006913cdmr229708426d6.36.1741632638612;
        Mon, 10 Mar 2025 11:50:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFie+mzm2Bw8VvHKP/u+MGW8Iw61YPMj501OCpii1PEfvhFOD2xnDZkzVVnlM30dQ3KOy/+cA==
X-Received: by 2002:a05:6214:21cb:b0:6e8:9fcb:5f7d with SMTP id 6a1803df08f44-6e9006913cdmr229708106d6.36.1741632638222;
        Mon, 10 Mar 2025 11:50:38 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f7170958sm61093186d6.108.2025.03.10.11.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 11:50:37 -0700 (PDT)
Date: Mon, 10 Mar 2025 14:50:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Jinjiang Tu <tujinjiang@huawei.com>
Cc: jimsiak <jimsiak@cslab.ece.ntua.gr>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	linux-mm@kvack.org, wangkefeng.wang@huawei.com
Subject: Re: Using userfaultfd with KVM's async page fault handling causes
 processes to hung waiting for mmap_lock to be released
Message-ID: <Z880ejmfqjY1cuX7@x1.local>
References: <79375b71-db2e-3e66-346b-254c90d915e2@cslab.ece.ntua.gr>
 <20250307072133.3522652-1-tujinjiang@huawei.com>
 <46ac83f7-d3e0-b667-7352-d853938c9fc9@huawei.com>
 <dee238e365f3727ab16d6685e186c53c@cslab.ece.ntua.gr>
 <Z8t2Np8fOM9jWmuu@x1.local>
 <bb6eb768-2e3b-0419-6a7d-9ed9165a2024@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb6eb768-2e3b-0419-6a7d-9ed9165a2024@huawei.com>

On Mon, Mar 10, 2025 at 02:40:35PM +0800, Jinjiang Tu wrote:
> 
> 在 2025/3/8 6:41, Peter Xu 写道:
> > On Fri, Mar 07, 2025 at 03:11:09PM +0200, jimsiak wrote:
> > > Hi,
> > > 
> > >  From my side, I managed to avoid the freezing of processes with the
> > > following change in function userfaultfd_release() in file fs/userfaultfd.c
> > > (https://elixir.bootlin.com/linux/v5.13/source/fs/userfaultfd.c#L842):
> > > 
> > > I moved the following command from line 851:
> > > WRITE_ONCE(ctx->released, true);
> > > (https://elixir.bootlin.com/linux/v5.13/source/fs/userfaultfd.c#L851)
> > > 
> > > to line 905, that is exactly before the functions returns 0.
> > > 
> > > That simple workaround worked for my use case but I am far from sure that is
> > > a correct/sufficient fix for the problem at hand.
> > Updating the field after userfaultfd_ctx_put() might mean UAF, afaict.
> > 
> > Maybe it's possible to remove ctx->released but only rely on the mmap write
> > lock.  However that'll need some closer look and more thoughts.
> > 
> > To me, the more straightforward way to fix it is to use the patch I
> > mentioned in the other email:
> > 
> > https://lore.kernel.org/all/ZLmT3BfcmltfFvbq@x1n/
> > 
> > Or does it mean it didn't work at all?
> 
> This patch works for me. mlock() syscall calls GUP with FOLL_UNLOCKABLE and
> allows to release mmap lock and retry.
> 
> But other GUP call without FOLL_UNLOCKABLE will return VM_FAULT_SIGBUS,
> is it a regression for the below commit？

Do you have an explicit reproducer / use case of such?

AFAIU, below commit should only change it from SIGBUS to NOPAGE when
"released" is set.  I don't see how it can regress on !FOLL_UNLOCKABLE.

Thanks,

> 
> commit 656710a60e3693911bee3a355d2f2bbae3faba33
> Author: Andrea Arcangeli <aarcange@redhat.com>
> Date:   Fri Sep 8 16:12:42 2017 -0700
> 
>     userfaultfd: non-cooperative: closing the uffd without triggering SIGBUS
> 
> > 
> > Thanks,
> > 
> 

-- 
Peter Xu


