Return-Path: <linux-fsdevel+bounces-22836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D6A91D62F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 04:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934F51C21100
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 02:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C708ADDB3;
	Mon,  1 Jul 2024 02:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="wMVytl2h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A22C147
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jul 2024 02:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719801280; cv=none; b=lDXU9gzwCIXqrc66BGTXj7UPH/tKa9Zezl8rzCYy3I//D15F1+X0YCVE3ZEGU+VS+6/+/ROLc9UGITCkFZXIhE28j7xFnRxdXV0cx3rGbLYTH09YYYgYOyXCkcE03iQqo4wLpN8iAp/fG1p5O+nGsJZ8Ye/1+SZOIzISodxwYCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719801280; c=relaxed/simple;
	bh=DlkcM4SlWpgQaq76rEi7Pgs0fMGW100ZEJIUZ8O4bdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXYEqqMtMejbiGHlrgBZ8C8LTbs4q0Jv3y3vVVrGVSGZCNKgK0XgYRBtDjlSdg9RyAff+REIacDEXoNFIA7FnOhOsZdvEk8j6Ymjvs599uAKXpkujDK6tCrtcyVcZf86pbVY4qnTB7/VQsN4OX+OOMzpK5GIXxR5lrBsc8/4Vcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=wMVytl2h; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-700cc97b220so1056471a34.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jun 2024 19:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1719801278; x=1720406078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DDgWV/1M0ZHGACEenRn+Ob+1qKeNo9iohlOwDr3DlCI=;
        b=wMVytl2hXErjqhBwnoFOH+8yQshav5x/7Zrtr8npl2OGEY28pJl9AaE5cFHxDy1SMz
         U4rPDt9Nyzc3qzES9T864inMv6wewv7WQ9MsnwgVbrJD8J4MZ0VrT2eyRFAd3AXpzhWM
         8u4aCgA5XY5rkTFWgAe1cXR03rQ64bNUGHg4kELyLMKFr2PCZ5Mx8G+GFmgkA7n/fJ77
         a/NeBvcS4k80KBsWWzc0YbNyP+H7rcQBNsakXH0S0FOfbQTXxpkMCap3eT7Ai5jgmPmX
         xDNF3xQeuHTN9K1iL5KLM7exYRKq4garLvFpEmJ0KMAomgX23hzWV81TRoGfwy+XbgAn
         5fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719801278; x=1720406078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDgWV/1M0ZHGACEenRn+Ob+1qKeNo9iohlOwDr3DlCI=;
        b=ua9TxwP3SQEQgL05inGAGvsHVtiMq568g8beLFG2FwabLYzatM/6wCUXSAMj8j+3Zp
         Nvhgk18t/HOrJgIX2Uk4ojrfG5viz63ZXqHjGx9ud5rtLReJHT23Na/mLklPDEdFTOe1
         WbLCAywJWBmZjy9EkHxxzA7kB0z8Q8e2gDrSP+je91GPyzx1GPV3aFygniPo2mJErzdE
         adrWo3kSN7hhtcHhl7ezDidYY9/TH3Y29C32jwHUlOVo1amF7ezAE5QpLlm0NPyqYmwk
         jkMhF0BI2npTCf3lpMUn1vK7VNfxCpCtTnX2JqgKrR0Q+WIggO1zaAMrMYxzfa0UW8D9
         aDmw==
X-Forwarded-Encrypted: i=1; AJvYcCVGvPgHfbROQtdcwSYqTvnHk56sgoLNTyNH+IxwWSmXPxod0aSyecTDl+wmMga3Dwq3hvq9HSUnF5vMR1kj+0ymdzAgkbeY9EoRsjZxLg==
X-Gm-Message-State: AOJu0YzIsTLHMQbeK5AEk8T0e0e/GWh1W2s7L/3SjoFQZBeR6YEuWDpy
	uD6Z0pBVsNag1xh+D6AfuKmOCn25ttdqbhgmOLQA5fvX2fOw9inRz3JhM2+wCiw=
X-Google-Smtp-Source: AGHT+IGgOd34C7aRGMh1d04uXW7hNhMkkm6eNwIGWoMV3VIS98zXVTuuNpmdYFB3rotkj3bxL+qTug==
X-Received: by 2002:a05:6358:78c:b0:1a6:7af3:22ca with SMTP id e5c5f4694b2df-1a6acefbf70mr99620155d.32.1719801277568;
        Sun, 30 Jun 2024 19:34:37 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6b0adfb1sm3536332a12.44.2024.06.30.19.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 19:34:37 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sO6sE-00HR0O-37;
	Mon, 01 Jul 2024 12:34:34 +1000
Date: Mon, 1 Jul 2024 12:34:34 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: willy@infradead.org, chandan.babu@oracle.com, djwong@kernel.org,
	brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 10/10] xfs: enable block size larger than page size
 support
Message-ID: <ZoIVuvIBIYFFuRX3@dread.disaster.area>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-11-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625114420.719014-11-kernel@pankajraghav.com>

On Tue, Jun 25, 2024 at 11:44:20AM +0000, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Page cache now has the ability to have a minimum order when allocating
> a folio which is a prerequisite to add support for block size > page
> size.
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
> @hch and @Dave I have retained the min_folio_order to be in the inode
> struct as the discussion about moving this to xfs_mount is still open.
> 
>  fs/xfs/libxfs/xfs_ialloc.c |  5 +++++
>  fs/xfs/libxfs/xfs_shared.h |  3 +++
>  fs/xfs/xfs_icache.c        |  6 ++++--
>  fs/xfs/xfs_mount.c         |  1 -
>  fs/xfs/xfs_super.c         | 18 ++++++++++--------
>  5 files changed, 22 insertions(+), 11 deletions(-)

all looks fine to me.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com

