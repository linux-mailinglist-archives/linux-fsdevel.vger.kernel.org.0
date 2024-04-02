Return-Path: <linux-fsdevel+bounces-15860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDD9894F9A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 12:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70FBB1F25515
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 10:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4587D5A0E6;
	Tue,  2 Apr 2024 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsBsCrx0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCCA58AAF
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052604; cv=none; b=uFwZJATtmE+w2LtZBHNNRNZXsgFw5PM48N71giaAXIvM8Ortz5oPXYa90hC+TB+eEpkCT0Bvwof+xJKwSLT30Ay1FjoGRbRrNLOk3oiR+cxeIQ205Mv5yH9exrYP3cX7JxgrAZH5yKm5jIbqt9/sZ8oO6mxAfbZ8jL990D2ndNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052604; c=relaxed/simple;
	bh=/JGXRN8dEC7eeRXxGa+oKn7ljW+2uWu90I5ZH1yx0qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0i7jGa2mGvmjAAP3z0/ruLSiwHo6moS+8kWTpj+YzHTAcfskMxn4PiJ+ohSPYXKTZwdaqaqGWkLGN+yHYgR7KrtusrQUTUukz9m36Wnzw+9RWqLmGG5UCgp7qpGEd6CzqzSA2C/i2QppV0fMaifVGkxpEakCiXZzoK3eS334Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QsBsCrx0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712052602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v9XlJw1dV2M7uYBf21EnZFlthleFX+QwDn8eShFVjlA=;
	b=QsBsCrx01nJGGzmctI/5mh1ovuv0aipcXaE2CJDmPwgkC7Av53Te+fGvt1wFjbMAa1DtXl
	BEgxl8n/VvaoHsFPt8DCs/gkGo5qqQ/3zg11xgi4JrsMYgT6DyeGuLmP7OHZcIn+wAmKy4
	pFU/IXob3lWIr8kPLEpVamGAo7Aig6s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-Pz8FRAX7Mk6FpHUWab_kqQ-1; Tue, 02 Apr 2024 06:10:00 -0400
X-MC-Unique: Pz8FRAX7Mk6FpHUWab_kqQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a4e8e4efe58so27598666b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 03:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712052600; x=1712657400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9XlJw1dV2M7uYBf21EnZFlthleFX+QwDn8eShFVjlA=;
        b=Pf7eYygJYYtqCftOD9QCP2j2UUaf1r77bdpl5XM73vlkvIfzYgTcLRp4ZvZ13iR0US
         CKO0kPemjuwen7WrGb8RMp7/B5sBzqQ+J/wdU2jJ2fzduUy9PVIvW0BFqnAOrVcdAxdk
         bpkmoGmQjbGsn1D0VFO1qTIKbZPfyf79QcX9N/S5TO6GdPfIiFd1rNW+u9GVvzfnvEJf
         NDLys2oRI/pcmVBofEC7R5UAr7OhgAHvtRMG9EI0UTeLCgj6Efg+FdJHJa5BatbS0qJ8
         Rk4gM/j3fo8hRKJc77heIzsRpLX4YOTufo2C+6gg4azi0um89GeuHeDp1fOfW3jHytBR
         w0uw==
X-Forwarded-Encrypted: i=1; AJvYcCXK43bcwOmvEPtfJIe3HrdXFyTPJ/hes56RJyDQ4xEciBEWTyOnNLSyKXL1oe1EPSdsETTAaEdXg1jcqpdOr2/TUUl9EJQgUmz0XAAYDA==
X-Gm-Message-State: AOJu0YxkAe5RlrS7vewvrO4VK/DCX8HzaXZVbIoHWxUMoWjkePmx53Ul
	JRY7u6dBIk4Ir7OZHC/YNJHGk0Z0kbyM92KE+Wvaj1RgLMqtvy397eU41+110mLhYNrECXNAUoo
	4hrchWwXWeTF4tVif2/hMmXL3nG4bqWDPBCawcTaiyMEDZxV5A612393k68HQhg==
X-Received: by 2002:a17:906:db04:b0:a4e:2b9e:5b73 with SMTP id xj4-20020a170906db0400b00a4e2b9e5b73mr9263820ejb.49.1712052599654;
        Tue, 02 Apr 2024 03:09:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPmM5eoOjJMkZksPERAor7w6Un4kTdCaPd2xs3JL0jSqmFfArdXtjO3HZoKySsiA/UzXarTQ==
X-Received: by 2002:a17:906:db04:b0:a4e:2b9e:5b73 with SMTP id xj4-20020a170906db0400b00a4e2b9e5b73mr9263784ejb.49.1712052598992;
        Tue, 02 Apr 2024 03:09:58 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id pw14-20020a17090720ae00b00a4e35cc42c7sm5177827ejb.170.2024.04.02.03.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 03:09:58 -0700 (PDT)
Date: Tue, 2 Apr 2024 12:09:57 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: ebiggers@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 03/29] xfs: create a helper to compute the blockcount of
 a max sized remote value
Message-ID: <evbfen2l6tkue4flt74faxzwhwn5rm3iemnzuxeyvy6rfeh444@uqffnmrogel7>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
 <171175868610.1988170.11402681235329108487.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171175868610.1988170.11402681235329108487.stgit@frogsfrogsfrogs>

On 2024-03-29 17:36:50, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create a helper function to compute the number of fsblocks needed to
> store a maximally-sized extended attribute value.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_attr.c        |    4 ++--
>  fs/xfs/libxfs/xfs_attr_remote.h |    6 ++++++
>  fs/xfs/scrub/reap.c             |    4 ++--
>  3 files changed, 10 insertions(+), 4 deletions(-)
> 
> 

Looks good to me:
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey


