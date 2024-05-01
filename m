Return-Path: <linux-fsdevel+bounces-18440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6D38B8EA3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 18:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400551C20C2F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 16:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0451CF9C;
	Wed,  1 May 2024 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FITOxSIH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F231CD2A;
	Wed,  1 May 2024 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582595; cv=none; b=Z1aaavgRnNGmDVdZu3LD3RWpiJpsWgxV0dsEVKam8PLSIx46rKVhfgha2adz9zX5wMvBj+DW0yOOiU/nq3EAt3J3tCcj0uAFWvn9yFg92ClRBWTbtNoq8flm23/1hXo2OFJ6XlfwS0Cyoz4jHSSOepBPuNP2GD2OpLMg95pf520=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582595; c=relaxed/simple;
	bh=MkOBCpDoX/hXqvbravacUywKHeELXgwfknmiUU+XbIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKl6J28ye12PNfQ+BHrDfCaFdmXEil6pE+DhonhoRiViZZSdQgtWtVg4R9WhO+wgW1H/AkDtOzl+pAlT3/D9WeqL4FdrCgNalcKOs23oQ3/eOCbLGtCQkFKJQghZDP4inrFrqsEQjMpql0xKZdx5fHyruQktG5XZ7MpIgHCO1lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FITOxSIH; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2b3646494a8so312137a91.2;
        Wed, 01 May 2024 09:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714582593; x=1715187393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tjVFocR8HRNJS6GQuQDt5En/FwiwWy5FzW6t9DX2PPU=;
        b=FITOxSIHcBQY6nrwrWTWmEPeI8F25ZsyaFmnDxZvnPGGrxSFmUieqrFgzTw/JbXJzu
         VGmTWtwCyPI28Z+OGrGQS9rbi8XVGW0Hs4OqJOigwFqa2DFvFn1gP9RnrK/pz9lphbnc
         v588RB0eSiQXReb9OwTQyJ9HgvzgzQ6oJv24kzG8kIzrV93u2Qjoif+PXjaE7V54Tg2Q
         HjeLolVWfbQo9/Cs6ILt6ueD1cDYOJgNHaEqS7rhOM5MH9SyT6bfu0HfK/zEDmVpGZ3S
         ns3LF/BkibHQ7FKbJSrrHmFDQwAPkwmyNuAFXs/J07fzybG6dZ3LH1gwpUs8+CKTNgTS
         bJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714582593; x=1715187393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjVFocR8HRNJS6GQuQDt5En/FwiwWy5FzW6t9DX2PPU=;
        b=Osmsc1vrtWm+SGFfamKF7Wm4YtlkpS2BmjPtshc68InF1HR4C1Eo5iOH4Oxkvl8kuc
         s+NwYlvrOB+NPBv9RnGIiR/pSIIU62mCQM7la3GAJcp1pXxM4NVYJLGHWC9bEHeflKs9
         2ZI4XPmQXMSTFs3r4YEHjhFQXF2TNRQ8hNOW8fuokXSuDXSu9duYP8YqNDmD5x7WAlNC
         vJLKbV/mBahrDB9ux4x82p/ntoZ7uiVPSKaygAdHs87JBKoA3Dj0uYrztGL4fRsCZ/Jy
         F/f88O9tgFlwbi8lWdQdaDkVtlEVCunlzbu4pcXAHvW7+PcEsC3/nkMy0PwtkD5iJcZQ
         7tiA==
X-Forwarded-Encrypted: i=1; AJvYcCVbegT2lL+uhIf7eqHnVmyADTzVuQD9xzg79f4EzhOnTyASgOuQ258Rktp4TKT6WG6fZOnyr3j8LRneAe4soua+2CQBAwFIBiOXVblSxw8Mvf131OZr6+WbykCGTjY9Jng0wqL1kCRqEmKKSA==
X-Gm-Message-State: AOJu0Yyj5jkoz7adwKhgKn5pkwTFxcdwCWUmK30CBoEDUaX3BYn3HSCR
	Vbf04XF1x5SsmpgUgmC9F2EHtpXPRWdMShpGvTdFKbDnRC7u4Kz6
X-Google-Smtp-Source: AGHT+IGkYSiO+thE/tfIcL11qO/RGQ8hfJ0DuDW9PTxBvBNqA19mckAL6RMPxVEZ90n1ugYGZPCGQw==
X-Received: by 2002:a17:90a:4906:b0:2a5:3399:b703 with SMTP id c6-20020a17090a490600b002a53399b703mr3151680pjh.11.1714582593236;
        Wed, 01 May 2024 09:56:33 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090a1f4d00b002a2b58ee4a9sm9264634pjy.1.2024.05.01.09.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:56:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 1 May 2024 06:56:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] writeback use [global/wb]_domain_dirty_avail
 helper in cgwb_calc_thresh
Message-ID: <ZjJ0P2d5v5fW5J7h@slm.duckdns.org>
References: <20240429034738.138609-1-shikemeng@huaweicloud.com>
 <20240429034738.138609-5-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429034738.138609-5-shikemeng@huaweicloud.com>

Hello,

On Mon, Apr 29, 2024 at 11:47:32AM +0800, Kemeng Shi wrote:
> Use [global/wb]_domain_dirty_avail helper in cgwb_calc_thresh to remove
> repeated code.

Maybe fold this into the patch to factor out domain_dirty_avail()?

> +	global_domain_dirty_avail(&gdtc, false);
> +	wb_domain_dirty_avail(&mdtc, false);

I'd just use domain_dirty_avail(). The compiler should be able to figure out
the branches and eliminate them and it removes an unnecessary source of
error.

Thanks.

-- 
tejun

