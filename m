Return-Path: <linux-fsdevel+bounces-20856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 430228D8874
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 20:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742D01C21772
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 18:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF02137C3F;
	Mon,  3 Jun 2024 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lfq+vRAa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885B0135A46;
	Mon,  3 Jun 2024 18:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717438166; cv=none; b=st+uNO08TB8yuJxRkefACi/ZPXnRQ5PL7R01+1jImiE8UQD+6PC97UKrf28GPhPsLke2+QJeSMfq/IesLrzw3PeZn7KHCwjmH5M7fRw/aIWeWKkgmeTWwHPzFn57fDPwwmk9Ea5KalPG/UBnn15nKQgqvNsjDly8me5hUr2A1hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717438166; c=relaxed/simple;
	bh=EbQBKymnLfQkHlodvpkwnhhpbzot4LiyZVD0ZhAWyCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCjL1WsrdOrWkF0AtCZCsjRF8hsMXKMScEPmv266Smn3YbHTWxIGhpp+YbnIQdkzZSXb+JpLhkfnK/2k16DMNx33ZquJ2vOfcFB3+oVqO3nYqR1/7TaJOqlAGHBkyC96P4XbWi4emtNaYg9IHMt3aVNqw5ATjqt/DzTw9B+tEjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lfq+vRAa; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f44b441b08so35895345ad.0;
        Mon, 03 Jun 2024 11:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717438164; x=1718042964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YXl034VbTvbkD/cq16AaCovQc9yLMytZtK7abGPdXzg=;
        b=Lfq+vRAaISDhvDLknkoLHki/FQCIq6svqEOFK6DlMyAZFpiXzsTlywDgF8seIMjWnJ
         Xs8vndg1e4ehy6nC9Zob99UxkxIcrUEAT7u4TFnnIF66D9S7HLyMCnS2D2OTCMV1YXRe
         nzGXh9uifhdGxVT2xVwFi0f+vF6p2y/i+Bv6RMNxvTPXrAMCHsc1CSdSUFHPdvOGpFU6
         Bi2acZaIanCt0qyP1du8P3o3hooxQFe61+rakK4OI6Yg1dz+VZfXD/CWwVJLjxnv+bA7
         u5kPDiAYvO6A9Kl1T6Sksf5zo9BX1Y5eZsaq8JHEuXw65NmI/zG9xksDNK521975vY9N
         9USg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717438164; x=1718042964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXl034VbTvbkD/cq16AaCovQc9yLMytZtK7abGPdXzg=;
        b=BBbYjcmBzSAiqyHFXiQHS4MZWEYsDNEF9n+RfcB9ql5p/R1QljdkRkJW7IA4zWwB0A
         erYebopKIx8JH25Tnu19LLhRpFOO1Adi5ZY27ceAuMBpKIMO2rYVbYCuKDd/7oS+WMTK
         OxtDcpLwA6URDzh81dtVCDzkaMK250M/iMm7wUyniToHEruIj3sVWzWXEvF/DJ5hAuBS
         akPwn1j0ehk38ox5r1E7M/T5l+E28rDk/N0gddtteTHi1QPQrmwIKnay0uXuuXbDL8CW
         QVm+IM8kgnquAwqqQFmFAA5S0hSnhPOrLGRbq1louwqx6J769IcPUOda1IKGXVNu9N+r
         nrfA==
X-Forwarded-Encrypted: i=1; AJvYcCVzkiEddbQPFn54ZfDeKp6OUwVodfmq4Fh/7LKXG465RchBXlzQb1sCosN3ytdaFi1yfa52+XzIqJAYF7m+t75bb7iD182W6EuI4ect/+mo+endAklY0Z1pp9z4s+wJVT2D6dDvOY1uFaFr6g==
X-Gm-Message-State: AOJu0YzqDY0dB/wn95u3EuavLXsXS0Xtc6aOBy6ZJzHFUWsGZR208igU
	QLPJzPChAPOy8iohzkOXGhjR7K0UjKM9QymmLLveZukpMAVhriZR
X-Google-Smtp-Source: AGHT+IHSwf3aVNsUusaergW0STCqU0itWuY9cjfQCrhrIMhWg30627T2Ovf4HIXKoM2Fm2C8sSjl7g==
X-Received: by 2002:a17:902:fcc8:b0:1f4:bcef:e970 with SMTP id d9443c01a7336-1f6370cda21mr76848495ad.55.1717438163739;
        Mon, 03 Jun 2024 11:09:23 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323e27a3sm67526665ad.180.2024.06.03.11.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 11:09:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 3 Jun 2024 08:09:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] writeback: factor out balance_wb_limits to remove
 repeated code
Message-ID: <Zl4G0tI_0CHKIWHh@slm.duckdns.org>
References: <20240514125254.142203-1-shikemeng@huaweicloud.com>
 <20240514125254.142203-9-shikemeng@huaweicloud.com>
 <ZljGiunxmVAlW6EE@slm.duckdns.org>
 <cfbbcc80-7db1-8277-98ab-1f32c3a629ab@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfbbcc80-7db1-8277-98ab-1f32c3a629ab@huaweicloud.com>

Hello,

On Mon, Jun 03, 2024 at 02:39:18PM +0800, Kemeng Shi wrote:
> > Isn't this a bit nasty? The helper skips updating states because it knows
> > the caller is not going to use them? I'm not sure the slight code reduction
> > justifies the added subtlety.
> 
> It's a general rule that wb should not be limited if the wb is in freerun state.
> So I think it's intuitive to obey the rule in both balance_wb_limits and it's
> caller in which case balance_wb_limits and it's caller should stop to do anything
> when freerun state of wb is first seen.
> But no insistant on this...

Hmm... can you at least add comments pointing out that if freerun, the
limits fields are invalid?

Thanks.

-- 
tejun

