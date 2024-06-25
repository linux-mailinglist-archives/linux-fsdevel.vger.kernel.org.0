Return-Path: <linux-fsdevel+bounces-22416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85898916EE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 19:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E881F2236A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F7117625A;
	Tue, 25 Jun 2024 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="bdsO3xwl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77564204F
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719335529; cv=none; b=X3KYLUx0RE2X2Y0CRJZYR0kuMV189bHJDy90Ub8cwEg6LDfiKyw20bMDDADltC0Jt78Y0T10mpfh3QZuFp7+wz4fXHXDTrMp+yAwod1UnQbd9JeCoIIL1PLPsq6RhigHNE7CZHzEaHe7jTsi8VSjeR2gEDNgmizbjNf2sglpYIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719335529; c=relaxed/simple;
	bh=hf8XXyFQ/fdSAAnr8FHHS0ommE3KBqOIZgcNrR4+2Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JI8ZidZxNx/EIwnnMw9D/quMTksHbk+D3TkPyKqR1aHvKHghOeKwgLpAXtVqI1G58Aj5hhw8GDJEG6sVi2JKCZdSTteIOiL5FSsHxatIrUS0QLV6NSfUmlFeQxmGElWXXZdBuhH36stBKa25dfU5bEZJNvxNwMKkZbqu1/Y3lQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=bdsO3xwl; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b4fe2c79fdso24083426d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 10:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719335527; x=1719940327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WZIbVVFwCm0LobQXtGnzuMPIvM8lMcPFoEmqjMJNQvY=;
        b=bdsO3xwlDz/230WSI4Wbj0ubb7DcPcUL7HiVHsylZdW/09RYTBjx0z13RG1G6YmubQ
         ahLhWtbI6AKzdW4ehBI2JvrXC3k58meu2//dQAhSfKXqsGsIR0Go5BV+i6Gb1dmqN47e
         EcFkKqr7v859SHJ1/sp1+jzemOOeRhkqwTjJBJEChaqIrYD41P9YsJ9ax6R2/ysir//G
         A5zD7FoIWPkhn1Ut3ONEH+bYP0RCTiFvh/j6yYqZJ+EXkAJ1R6AjxeuHMYI7jGOyxSWj
         RG1OX8kpA7lzAm2dsH98OO627bmyjCP1mG64HUyFixQ64msuh/AqVEDKtPZPq9l5SWME
         iV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719335527; x=1719940327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZIbVVFwCm0LobQXtGnzuMPIvM8lMcPFoEmqjMJNQvY=;
        b=Pce/ww3nQKIp2vguKrdFNmrMcNZU8+DLwf+2JPTb3OnUMHIwUGdmXp3+fY3ScadNAn
         pbTh5zFnPdr5swC8QqcJaP2hphKo7K+t+Xma3sFL1mIDFeS1HhlPIdKzFssKXdHyP6s3
         PhUixSdWcF9lX2L9yFmzJCZ9nGsFnIerG+wjX+whApjij7A/y/nakE3Vu8Zb4K/2C/+8
         alJdqSB1wmpPemPKX+ZOuxSjN2AefGjDXNr8KLm1qUs+Oc3T9widrcDyzvRq8KyeADcM
         0v3otjvOzEsNcNrLhJhzVElx9PUQaM0QcaevYzKNUh+gv4lWe9nvaTYlqCzsuZ2UXjyf
         JmNg==
X-Forwarded-Encrypted: i=1; AJvYcCXXZ6QxabAqEZUG8PdeJNfoTkFavy3ja/L9VmhESqqPxYL+o0Hnc+0VTKGeo8eFw8a+4awf5wJ+2+Y25TW//6OnViYtlAjKpEE+XbtijQ==
X-Gm-Message-State: AOJu0YyhqMRkBFoFENqKf2dB+9/4hpjnbkWTc9iphbwqEnQReQ+0XtVT
	p7AfQiDwjI2a+8hdo4p3a7A2uIgKlx4VQqfRX84pndVB0hkwnXn/mRaOZJnb75o=
X-Google-Smtp-Source: AGHT+IHczZ57ec4g1O5Pwq+tC1jElf0G+38dBVecKWC5wRHU310zRZoHK2Re1mZ4VgPi9U7QpsGEUA==
X-Received: by 2002:a05:6214:17c8:b0:6b5:6a1:f899 with SMTP id 6a1803df08f44-6b53bbbece7mr72186356d6.10.1719335526687;
        Tue, 25 Jun 2024 10:12:06 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b54e09628fsm22817646d6.20.2024.06.25.10.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 10:12:06 -0700 (PDT)
Date: Tue, 25 Jun 2024 13:12:05 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/10] mm: Fix various readahead quirks
Message-ID: <20240625171205.GA2948656@perftesting>
References: <20240625100859.15507-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625100859.15507-1-jack@suse.cz>

On Tue, Jun 25, 2024 at 12:18:50PM +0200, Jan Kara wrote:
> Hello!
> 
> When we were internally testing performance of recent kernels, we have noticed
> quite variable performance of readahead arising from various quirks in
> readahead code. So I went on a cleaning spree there. This is a batch of patches
> resulting out of that. A quick testing in my test VM with the following fio
> job file:
> 
> [global]
> direct=0
> ioengine=sync
> invalidate=1
> blocksize=4k
> size=10g
> readwrite=read
> 
> [reader]
> numjobs=1
> 
> shows that this patch series improves the throughput from variable one in
> 310-340 MB/s range to rather stable one at 350 MB/s. As a side effect these
> cleanups also address the issue noticed by Bruz Zhang [1].
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

