Return-Path: <linux-fsdevel+bounces-20557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED46F8D51C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29FBD1C227DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 18:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B3450267;
	Thu, 30 May 2024 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+mkWtRa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303244D117;
	Thu, 30 May 2024 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717093761; cv=none; b=H7ckkOWaoGRpvQRYljJ3ky5pGTBFHzNnC2vlpxCqiJvgDYH0Kv7UNmDGTtx9yephR/SGoLClyJr9+w2ArA6sYTcFKDyrk5BoRQ4mCp6CWyGI2pd4BLmFbNz0566b4UlVVD1M9lk5hWE97SxvBsi3r+OZzms5hynmZ6QL7AL0fc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717093761; c=relaxed/simple;
	bh=ZTWJJtOnoCEjjDR1YvgdBuP7PEVdi3wWf+FmqRugq7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pbm9W8dDdMUQRiYzQ58go2qNtyEKyiVpAJc8dR0gBCKaKRr/bH905Dq++AJWblmc0bj5d4v0BQaIyrGYt0pnZh2wtCpiOgBONjDrz1u/bxPixX/HiwGhYawcR95M5OOOQSgdUucbsSuit6wt3O5x4jLKuvhjkuPuas6IMAxGfG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+mkWtRa; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f480624d10so10459045ad.1;
        Thu, 30 May 2024 11:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717093759; x=1717698559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nhnjgQ6rE1XRAEbHs7A8p+fYG6USGpWs0Q0HH94k2uE=;
        b=c+mkWtRaiUJyN47Ego5ly7waU0aqiK6aEP6VHakjPZZIUOXCMR9/VMfJhWjSDoGvbO
         GN/fao30gw9pbfV2ebN3ORvHrlLvfaXxjDTInMe8vWbGONPwTHCUyC+LTlhovoYwP76B
         Ade1j2Fx8M9ZZYvzKIeHaVTmTFyEU49FGFiCnbiQrJj36lGpbJZwYLu8jfomArnGqBTu
         7d1YpI+I5SppIq5nouUCa6AL5bDwRn7a8/t5ye9NjSo1ubv8oiYUvLUFP6gaQuU4/xwt
         n4y4rH2+Vx5oXqoErXmJYLgOCanVYB0izFPK9DAxxFG9zBLM1OxeGudJBZ4KjRIcMZIR
         Bk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717093759; x=1717698559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhnjgQ6rE1XRAEbHs7A8p+fYG6USGpWs0Q0HH94k2uE=;
        b=hiefzF8nF6VcxFYcqZhYQcm9wMkZTH4RUW3NaiPApFTwm+Ok6shVvZuXanDaJbvyDd
         ATm9/+O0Pw4s3CdRgIoiCIoJ/fktCWOnOAWkK2SgHEOhM5pp9t1Prp9pXWRNi55Yi6Su
         suUpVuRVkSwkt8jjDhMecBEaACgbvgy4di6d4N89VZjy4keExBO0VU8umY1Bp9Ku93YS
         lvKksB4YLDBVYZPYFEzmeA6+NTra75MCVn698ra5CuckOtDo8y427sp15kM+2qxWDBzw
         Iio2RwHX0VbtfOfyESVId0BSoioUDDgXvl06bvMeZWmBwqY6oX5ntPKk6ERhveM7syFh
         RFsg==
X-Forwarded-Encrypted: i=1; AJvYcCWqsM29MxFgibpFjrbCSkSoQ5I+0Z+7TLJR869BrncL2iOhdpdk2rah8brqxvNNos8ddt/RIVKACxtdmXRf5C39ZHU/J6dydmxUp6zRXsaBh8W9UdTJQwJmVJ9DxPe7jasUscXVUYaRchg5nQ==
X-Gm-Message-State: AOJu0YxD6Bez8NMVpO+WNJrE9B+Y8prGeSm4CcbOlxCr3V0pcwFO7IPx
	pmIY7/JLJEBNlIUfEXOhZ67lcGw722MrWnaZC5gPWcHyXzf13Ol6
X-Google-Smtp-Source: AGHT+IEIvSA83Fm1beIcN7N5DqFxEn0p2FT7DfcpBfoR0l5W7lY+eiAwMxWAF/z92+SPWST9SQlwig==
X-Received: by 2002:a17:902:e547:b0:1f5:e635:21e3 with SMTP id d9443c01a7336-1f6195f6418mr32102755ad.27.1717093759360;
        Thu, 30 May 2024 11:29:19 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63235a619sm970975ad.69.2024.05.30.11.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 11:29:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 30 May 2024 08:29:17 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] writeback: factor out wb_dirty_freerun to remove
 more repeated freerun code
Message-ID: <ZljFffFosO0qxE1T@slm.duckdns.org>
References: <20240514125254.142203-1-shikemeng@huaweicloud.com>
 <20240514125254.142203-6-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514125254.142203-6-shikemeng@huaweicloud.com>

On Tue, May 14, 2024 at 08:52:51PM +0800, Kemeng Shi wrote:
> Factor out wb_dirty_freerun to remove more repeated freerun code.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

