Return-Path: <linux-fsdevel+bounces-5054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7509C807B67
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 23:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04FFC281B2F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 22:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B031D4B127
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="nC/044xl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5A5A3
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 12:54:02 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6cc02e77a9cso248098b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 12:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701896041; x=1702500841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6SI9NUj3p4Gfv2glpyOZDVlRHvagAXtWy0h7h1p+a0Q=;
        b=nC/044xlkhFwXi6PVIqo8s18XsCILkMF9Zmf+6Aqvhwf29q5Lu990pIltJqvL/SBJE
         +b9gW9aBhShy1Zbd8c1Pea1+X6FilNkpR918jQabZdzSUnjlahNGyLZKKj1GjrVMz9tE
         1UvK/n+3rpYx/pHkrgxRLJzrekzGeeu6x4Gm+RlZtmx1HX+mOUeUtCcFq6TBroQ/uE5I
         DjXl7h1WqKCfFjQ5CuiNTlssvk+0MlGYbz+AuGU1EGgj9vC3Gb7RZvEHS7hpPjEzJM82
         /bkUQ3S4xS8r2K+nXa5TghoGZJyUHmL0EdzDIPiNhNizArKZHdpinhtC7H5EJKLtq/Uf
         uSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701896041; x=1702500841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SI9NUj3p4Gfv2glpyOZDVlRHvagAXtWy0h7h1p+a0Q=;
        b=Qt3dULO13f0DPU5NvQaKWpsQiiBddLW+wVlEZ6IoPtOx5P3TjXiv//sUXfXiTkItQn
         eeH9ml0kza0e8Mq6ZKYxDaeSbhmGwJwaIgESH4b/ni4NRObmQhz84vRSehnIerJo+OWm
         hv10iK0pmJ1v2vAs9Wfc+CoKYPzm0mCAB2/lTBgTY5bBxIExniuAKkOzksDFcMAqIgiq
         7ApEv3Ku3ZJb6pVFvxD0PSJp6+h/v39RNc7DCcP9z/v613v6cqk84/Ei++baPOsfLE9r
         2uiFxoztTMvW0YMiT+g8rLqRsCeeWwwENAoyHbIpG3hfWP04oe/KbwGJ8+bxEJXoi8/A
         h8XA==
X-Gm-Message-State: AOJu0Yyw0LRTb7I3uLNUR++ExO3uhNCTVyqV9IRrsPQRzsYoKxM0VomM
	4TepcoaYaobdQ/32CEZprouHUA==
X-Google-Smtp-Source: AGHT+IHNBfqQJJPhOTnjwZGujfDWFf8BG5sZT9Tvt56B5TG2/2H4QFej0j8a1qVTj1OyroT4giRSLA==
X-Received: by 2002:a05:6a20:2449:b0:186:ff2d:f964 with SMTP id t9-20020a056a20244900b00186ff2df964mr1947104pzc.36.1701896041573;
        Wed, 06 Dec 2023 12:54:01 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id h21-20020a056a00219500b006ce39a397b9sm396884pfi.48.2023.12.06.12.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:54:01 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rAyu6-004mTA-1o;
	Thu, 07 Dec 2023 07:53:58 +1100
Date: Thu, 7 Dec 2023 07:53:58 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] mm: Support order-1 folios in the page cache
Message-ID: <ZXDfZkVAzB6najIo@dread.disaster.area>
References: <20231206204442.771430-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206204442.771430-1-willy@infradead.org>

On Wed, Dec 06, 2023 at 08:44:42PM +0000, Matthew Wilcox (Oracle) wrote:
> Folios of order 1 have no space to store the deferred list.  This is
> not a problem for the page cache as file-backed folios are never
> placed on the deferred list.  All we need to do is prevent the core
> MM from touching the deferred list for order 1 folios and remove the
> code which prevented us from allocating order 1 folios.
> 
> Link: https://lore.kernel.org/linux-mm/90344ea7-4eec-47ee-5996-0c22f42d6a6a@google.com/
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Documentation of this structural quirk at the definition of
struct folio?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

