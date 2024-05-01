Return-Path: <linux-fsdevel+bounces-18441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF4C8B8EA6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 18:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4231C20A90
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 16:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D107617548;
	Wed,  1 May 2024 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0ou3njJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E140A134BD;
	Wed,  1 May 2024 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582675; cv=none; b=TQ3sPYhOeAuEfWvl12aWaQiO97vLZmZvklUa1elhVeG2P7oATeuDm2xpySbGB9pIhOSJNek+PncaQk0fmYQtv5q1mtTSmClmh3BHDBzITxNX8kSJnaiygNomUKSRBbtJsfZt6im29AO3OFRWlqs9EcYR1pSWBMbkQ0JWdKNTLpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582675; c=relaxed/simple;
	bh=pFx1BWK+X28fURyvOu+0BP7QUcQQFNG1W49Bi4z2gXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2c6s51fU7y7NMhTBoFUXBRI8IBOpKmj577xetQ3j5GnJLoxMBvrC4CYTXFlhoeMSwJsek8kJSR9b6pyEBnZjq/Y6CBXVDyqjQFIg/e4YqtOBmXWrUssDGQ03EKs2qbf4+SqobDhGsrRXxKePQ6FpYvPnKmlGReZBYDKqG+kkZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0ou3njJ; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2343ae31a9bso3421914fac.1;
        Wed, 01 May 2024 09:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714582673; x=1715187473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQA4lspcA/MWALXjkb0krn9YAGqjCZZVAgbrKw1wBEs=;
        b=D0ou3njJa6I0T5SO7BzZTQAEANKMSTQVN6lqP8UR+kwDngOfE3/3i9GjW+WM4ntmVK
         w4vU1DsF9H1D+gQADlhUGn+x4HHeKWJLburDvYMTKf7XBUmIHjjYUy/eU0RfOIcy+bMh
         bpkn78xhtiwCX2LbVSCW2IMaZB+TfYCqWX0xVznH+88dg+GqL/N/YJsnEZuG1ecrRbQp
         K9akrPCRrqi6CYFBqz1lqt9K4SZfLKqyuOheNAmYz182RiPrjejKrFTk7xSSKXxUeYvH
         jR5r9RyZTYQLvF3WLbtVv6KDwl6Yf7TD1+KHDgps/FvY0OLG0DFcJvdS73DMTHrvHEw+
         8r+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714582673; x=1715187473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQA4lspcA/MWALXjkb0krn9YAGqjCZZVAgbrKw1wBEs=;
        b=fpRCOxOcFm5JXV8P6MLrSOf/rIhQylnzqDknlQ9pSv26jE/p01d3FXY9dBphAlBDoa
         TyNwLcoCiIJa/8ebfUOUJWsF+rujFAIzX21tdCypmK2ZPQkuMR84HIz1zFWcCLV8gj0C
         vSYwIFFGwx1IKCZoCCxoi3yo9DuNvd0g74VoRAU9ZHCfll1/kfRkqj1ifhoCEWSlVt06
         Tadc+PvzcQ+fj1LGHO4TYUGRhtjSY2NAZauvW635tPalflHcyio9xxQWHLTrQg3Hyozf
         I+krtInFddWvcSO5TI8VReF9r/GQ9KKPYTyY/ZKwvtPWkHOd3bC/UJXNbnhO9aLyZqXA
         mFnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs2oXWYvzwpSBfQLnbQfiQ70tmV+waQuPOsVq+Dnz2kQ96xBjSlm5bDYRNMDGzOOhzhq+DCWp0mCLH0bSv8MridAohIIaPAOweBuWYVh1dHIBseUbwzO0R9GlHYfGGCH8ZSb8AqXxen1ertA==
X-Gm-Message-State: AOJu0Yxg3ipMK+9k+HuOvCzFujXDh/4YlvpZzJ+AcEIZRrNwzRE5usnU
	0NTUJNjcTKD0JxxO1hc85+PFSFYvqVvOPmdOTjonIjTyWyBLRq4D9sPMX8Wi
X-Google-Smtp-Source: AGHT+IH3HgMLRq4Z381xi4XV/eUV8h7UMXLj9q5zqibce+TFRhsU4gtyuB21GmJXkVu/nPvwq998sA==
X-Received: by 2002:a05:6871:2b26:b0:23c:3c38:1b93 with SMTP id dr38-20020a0568712b2600b0023c3c381b93mr3422729oac.24.1714582672892;
        Wed, 01 May 2024 09:57:52 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id n7-20020a635907000000b0061236221eeesm6773252pgb.21.2024.05.01.09.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:57:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 1 May 2024 06:57:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] writeback: call domain_dirty_avail in
 balance_dirty_pages
Message-ID: <ZjJ0j4V3g7oOn_rK@slm.duckdns.org>
References: <20240429034738.138609-1-shikemeng@huaweicloud.com>
 <20240429034738.138609-6-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429034738.138609-6-shikemeng@huaweicloud.com>

On Mon, Apr 29, 2024 at 11:47:33AM +0800, Kemeng Shi wrote:
> Call domain_dirty_avail in balance_dirty_pages to remove repeated code.
> This is also a preparation to factor out repeated code calculating
> dirty limits in balance_dirty_pages.

Ditto, probably better to roll up into the patch which factors out
domain_dirty_avail().

Thanks.

-- 
tejun

