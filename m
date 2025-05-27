Return-Path: <linux-fsdevel+bounces-49940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A17E3AC5DE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 01:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A29A3AC201
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 23:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCFC218EBF;
	Tue, 27 May 2025 23:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="wIGQMCt9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841DF482FF
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 23:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748389926; cv=none; b=BXeaxlDRr8MyznyPXXEgieoXChYcqwtvMDfL8LBYLsIdwTtUeYbPsTvPCauMCxzfQM3Oz2g4Kz6jmmd621XMno04xg0+iwBeYhJxr64RLAAXJWE1BdUrYFK8MG3QEKywt1o5QgM6FVPth7aN+SC4xgxSA3Jsuglzu5n7Kx6i4go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748389926; c=relaxed/simple;
	bh=4OXAg37CYDGTuf5cCjUJMd7uGdLLhj11Zq6JGYOYBVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0bJsUGZqvByQWM894y55WyX/ZzZINmw/Nsol3efewvuV70osv3AYlTGl+lTNF64oHcV0t5HFB7Nmw8O24bB4CAgbBzEm2mxMhv+N0BavIu4E0GkRu+TE/UWd3r2SaO6Jo1Q77vLrAoiOoDthOdLKauEp08A4rOs7rf0xl96xeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=wIGQMCt9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso4205299b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 16:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1748389924; x=1748994724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bmfh5PXzStZotlCYpKANwA843qFjQL6xga7R2lCb0vE=;
        b=wIGQMCt91F7Hg+2yTjD2hhJ/56Kfg4KHF2LHyxm8Ws9vZN/VEZb8sRxOQZdlgyfv94
         zEM10HnjiHs2CH0RP/GpCje4oMJ4OoHL8iJhnKF4xahEtzcxDPJ6m2iNGPpjuVNsuLaz
         dWB/i/owWBU+8WOrtDL8HXfyPPqXBtZ+Xl4YWI7LaWElWEGaqJc9gLc6ZEaZNlmELClG
         RhWnDlOLjEXQWzRbcOub7iUeBp5vEHT6mXpiyk8KwPlAa9kc6psBbn+nTCsNtLFTWFKL
         vvZBluAjvo4X+QNshY7XbbZzL8szcPSSbE0FdX9Wedo7NKrOHquiba0wynw5GjzxyUet
         ggHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748389924; x=1748994724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmfh5PXzStZotlCYpKANwA843qFjQL6xga7R2lCb0vE=;
        b=cXkly2HO3DEIyMdvHVx3HG6Pdf9zKxSj4IPftE3OE7a+iu7SMBohxQve5oG3pbSpnk
         vHN+6GWvVSpLDub5dzhkTK3mZq65mgxHUjrQ2Sk/wyDiOdXr24xGS7n08R70cJbWD/Nw
         9ZJepUTkrsdbYYllNw1VoWb9PIpjyORuCLOaAnVGEKVpvBsT4BWipkhx/eGQFSvFZXvw
         EvnqfrgTrHY8NB6INRIvWW5Bdy9rMH8WBZQbwLvs3AwrkecWeRLyajz9pF8rTZ+zktYk
         Q6K95eRv99zRIjwtS1Xiw7IgS9+NzDPqacxzg0NHgHSUsrtgiEh653OrxFsKn6043yEY
         Kjjg==
X-Forwarded-Encrypted: i=1; AJvYcCVCIFZIKjJPr2iOZHVyd8l89NqyX01jj7zziUcaXBt6inbgLlLXL1AdYZAct/BdisrgzzI7ouYiLFNTHO+S@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4OUDa7fCGcFZaaNguOISGT3X+I5ydnd251e6r+Sv7fComqz8s
	R4g9dFtWl8gqDJ/Cl4EgkSBfkOmBBfwoocYn4rbJYcYoZC2zPMi/5ceqqoGHSIxF5NU=
X-Gm-Gg: ASbGncsMzzJzVxBW64w29m+gkS52b83XjtscOWlKwlo6h6HmAsJJ8C7qJ0M8BZWFvd4
	Z+/cT84VCyhYFajRb5FrAmdjliLOgEEntMVVQ3pAV4K5a2eYSuUC9CJBaphJnTx1XMP7voNJRx7
	g0e6Ky9Ic+OGdsJqUi+GVRAjcS4EXtGBhyjpyz3ZBx+6D4cDN4CwZEGGp4CF4w/LYxZGdHexv7a
	wiw5mvCHLV/D5YUsyglcOzxZtkHF7EMVlAAqio4CzH4aJqH/YmRE6JYifAkd1DLHlo9OPrGI1wm
	f/9szi4iokWIgDWlx1UWUZ2r3zWQpxMqZCbhm95rvvNrQ7gpR+WzW7WaUxbdcFv+VQO3SZMr4+7
	0F1pFhp8AOLjEGJscGKPlErIok4Q=
X-Google-Smtp-Source: AGHT+IGjVyDrg3w6oPAW9PAypx8bpLsNzCm/OTJwY6v6hJyuA03GGUwylGYveFQDmPSqx/NJbXVihA==
X-Received: by 2002:a05:6a00:1482:b0:740:67aa:94ab with SMTP id d2e1a72fcca58-745fdaf1dadmr21994737b3a.0.1748389923796;
        Tue, 27 May 2025 16:52:03 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-746d5c642f7sm45212b3a.3.2025.05.27.16.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 16:52:03 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uK45Q-00000008zYO-2o3v;
	Wed, 28 May 2025 09:52:00 +1000
Date: Wed, 28 May 2025 09:52:00 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2] iomap: don't lose folio dropbehind state for
 overwrites
Message-ID: <aDZQIETrdC_4fKGU@dread.disaster.area>
References: <5153f6e8-274d-4546-bf55-30a5018e0d03@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5153f6e8-274d-4546-bf55-30a5018e0d03@kernel.dk>

On Tue, May 27, 2025 at 05:01:31PM -0600, Jens Axboe wrote:
> DONTCACHE I/O must have the completion punted to a workqueue, just like
> what is done for unwritten extents, as the completion needs task context
> to perform the invalidation of the folio(s). However, if writeback is
> started off filemap_fdatawrite_range() off generic_sync() and it's an
> overwrite, then the DONTCACHE marking gets lost as iomap_add_to_ioend()
> don't look at the folio being added and no further state is passed down
> to help it know that this is a dropbehind/DONTCACHE write.
> 
> Check if the folio being added is marked as dropbehind, and set
> IOMAP_IOEND_DONTCACHE if that is the case. Then XFS can factor this into
> the decision making of completion context in xfs_submit_ioend().
> Additionally include this ioend flag in the NOMERGE flags, to avoid
> mixing it with unrelated IO.
> 
> Since this is the 3rd flag that will cause XFS to punt the completion to
> a workqueue, add a helper so that each one of them can get appropriately
> commented.
> 
> This fixes extra page cache being instantiated when the write performed
> is an overwrite, rather than newly instantiated blocks.
> 
> Fixes: b2cd5ae693a3 ("iomap: make buffered writes work with RWF_DONTCACHE")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

LGTM.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com

