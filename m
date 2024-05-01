Return-Path: <linux-fsdevel+bounces-18435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 906048B8DDD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 18:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C196E1C213BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 16:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB7312FF87;
	Wed,  1 May 2024 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+T9GnP0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861EF14012;
	Wed,  1 May 2024 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580189; cv=none; b=Xe4uyX6HvseWvVUl1nF6QxQqZZfH3mVIFXI8O+Tx3PRHNtE1QxQrMcVNoHN5lRFgU/Xt7JTOTsQmIQAt2AhVXuZOlraYkc12+ykcCcsh9O6z4dHIesdvPzOFps/Z4UAMSB2XaDc5EsqHOwEXt8aS9O1jbg7pUUsy68dkUREjf6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580189; c=relaxed/simple;
	bh=//LEnlvSVSXUbJfMDjvd6bTaR+rRYvm4s7OOaxCY8DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0X54kC5USrkZJjXdiCe1bQOzLg0chwyAKB7Sc/3AzerhmnkHfEXOpdO/Yqg2H93LAP1ZfdUC1UsF/7YarFwQKmUXUdqchTq+JyuGChmF0jBqCMxq04jxqm+JMSSDdMjTRIYYORRdhUhR+pRGElAGPEB0Bo2gym0wMHsvQde1Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+T9GnP0; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f3f6aa1437so3420740b3a.3;
        Wed, 01 May 2024 09:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714580188; x=1715184988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2eqaP89xJW0ujXnZ+hB2QVGRIufSQtfLwgVff4XKb0I=;
        b=K+T9GnP0zY1PolGTDO47p/z/r9Kr5Nh796dYcTGsUTAWeUUi6NEbUlYlfKN7sf7Tu3
         pOTbbMZ8COlFKma6rWD8koC2zkCKHKiodpL+JfKWdhT/UBcRMFGBpIJpRWVLbuTfj0ST
         Smlu4ag9xHlds/h9SmYfs9TObfPkoTfOwzBIfDWCblggFh1JBs145OLJyKKxl694jIG1
         lumKGNxBLhF84kBrYCMY1/QVPnOgN5jjtpn+R/S+ZsHfZIq4Go39NEUQauY34Yr40ozB
         oHNae+pUO/BH4ayfpDISzBEmfGLOeafRbQ5YwyIaPeOP/Rvuan8Q6yBHZ23kP4HiubQ+
         Ro5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714580188; x=1715184988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2eqaP89xJW0ujXnZ+hB2QVGRIufSQtfLwgVff4XKb0I=;
        b=cMzoD3zu8BrCvxkzI1YHEYYCictcnR9aW/H2goO9yQZdnvofrz3QeEU/RDTvWpD/Ck
         aqiRlGP8DWugUGDI+3tdfjVN8WrycUTeULab5OjEGKFrzy3SZMFvnHcTe9YcKLTxaoHC
         5uG3HmLps0P7fEzumclS5PyEnmhKV90aAnoTFj723c1odVGdgO3lIN5S9HoU0pgJz1Wk
         BUJCxVMwdDoTR+69sVhihT5k/gMUtgrdVYDBFVk+XxKjArYfHQ5qSg+HmXsFDCYsavo8
         n3dlvyFJLVoUiVKPpImzdAvRQ7Yc2mwTkI/l6UvsJpyOAh5kHEbj4mIJ+v2CUM0Dau8T
         9Wiw==
X-Forwarded-Encrypted: i=1; AJvYcCUs7IYm0RrhZu0pCcQsB88vO6kz794WBfMhrg3TpC0fIlTFM0eX0gV+a7Cya5dZH6rVVgH4XlvTMfvSUU1VdJo3Tm0E158COqsJOpJwNMa4gtUzEleSn9oPG1xum8zjrsvezQM8hOk9v3jQnQ==
X-Gm-Message-State: AOJu0YwwE63iuX4H4gz3WxjrXiuPMn1Wvpigz7sipKQWGKEXfQMc4qXv
	egvPL0Ac1L6xuWoE/E9qWNsvhP8ZlbhozFw+TUOp2yx9wzAly+5k
X-Google-Smtp-Source: AGHT+IFG4/zw2BTucTObEcs4prhPN8niNp0Os6Yg5zzDwEAG7i1CghqpTQkkOnlieXo3HxSODetzjg==
X-Received: by 2002:a05:6a20:430c:b0:1a7:1b6e:4d4 with SMTP id h12-20020a056a20430c00b001a71b6e04d4mr3003804pzk.23.1714580187677;
        Wed, 01 May 2024 09:16:27 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id a20-20020a056a0011d400b006ecec1f4b08sm22766536pfu.118.2024.05.01.09.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:16:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 1 May 2024 06:16:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, jack@suse.cz,
	hcochran@kernelspring.com, axboe@kernel.dk, mszeredi@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Fix and cleanups to page-writeback
Message-ID: <ZjJq2uvuXZoZ5aj3@slm.duckdns.org>
References: <20240425131724.36778-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425131724.36778-1-shikemeng@huaweicloud.com>

On Thu, Apr 25, 2024 at 09:17:20PM +0800, Kemeng Shi wrote:
> v1->v2:
> -rebase on up-to-date tree.
> -add test result in "mm: correct calculation of wb's bg_thresh in cgroup
> domain"
> -drop "mm: remove redundant check in wb_min_max_ratio"
> -collect RVB from Matthew to "mm: remove stale comment __folio_mark_dirty"
> 
> This series contains some random cleanups and a fix to correct
> calculation of wb's bg_thresh in cgroup domain. More details can
> be found respective patches. Thanks!

Isn't this series already in -mm? Why is this being reposted? What tree is
this based on? Please provide more context to help reviewing the patches.

Thanks.

-- 
tejun

