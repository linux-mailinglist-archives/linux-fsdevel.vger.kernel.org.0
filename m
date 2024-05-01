Return-Path: <linux-fsdevel+bounces-18418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1D68B8823
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 11:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64AB01F23777
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 09:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2C653E2B;
	Wed,  1 May 2024 09:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="nBBuin0J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1241453379
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 May 2024 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714555974; cv=none; b=Wy2oyRjZs4VsaveBqHjGKv2H8A7AI4rs8wQC8bNol1EvieR6FghBsmnDO1hcUrMlpLVQOjTf3cSGbDeiLDEQBghPO7htpFGmSdt0Vc5KunBdb5zKvmtx+pZMJArC9MTdXeoggCmrfJfge+yXTMnPCGM5V3bfXjUhPwSBYe7jcjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714555974; c=relaxed/simple;
	bh=7DoQjZ/S50dzYIa+1hIdi1nprJ/K1A8jB7QvyvxUWD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHPI777h9tXxQn6qdRaq/W8E8cdYglM1tiqp0IgGcVvezyMqObvYhY6Ph+a9kqyo5jjSdzJZejhXND7Ydsc0qcs9saGHAimga846w+RZ/tc6VZAFR7zNA3rlGzr0718e+AkSHPZkMVDNN/sfp2S9WAtbSS0XY6TOHdChXe13S0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=nBBuin0J; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso4488616a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2024 02:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714555972; x=1715160772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g8kpyhny34Sijm4UGjTcnGqLvDZUER/KHyPevVfWv1A=;
        b=nBBuin0JUMSr9Lh6ekcGdhM0MRs5TDPfDJsYugi1w+YBrE3UrDltYA5Xt/Iz1yp2sM
         1vCC4e3TpDRB5xoSdrcK24mGbx+TX4BNXOzK7hfqy5VrRcApfo1BjETAHJda5ji26sfv
         QYQZo1OiidwVuDpm/HW/ymhOHdpG45zqdGv/jk5yI9K0YqP/w0nyYKgYxv+tCztkYzTs
         LC8BqxtRjcrV8brDPdYiJDwsV5IQWt643awIW+MM/p9XE8iXWCCgqhPm7VPojJfJxgwJ
         ugY8gs0nc3Wp9rz2CoTw2zz8MEx/Y7kqKXjJITuL5QVA6fArXnC/JLW56wTZv3iq/CV8
         ADyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714555972; x=1715160772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8kpyhny34Sijm4UGjTcnGqLvDZUER/KHyPevVfWv1A=;
        b=eZCB6CHxb1RPPrR6jmrAwaqsTvnw1xdo5Z04RiYqnesN73tjp1xgfp/snF3vygsZTa
         EupQf+ZBz4YhEJPkOATIU5WOWoD7H9mhFHZpgJk2no34EeVm9gA0BH3cQOQWRTnGRxit
         il1VUeVmqNEyCIOQZYDT2loO45orhv0GtCh80Tmcdmy1hhFrEwpKkaoihbJxFnO0l1Eu
         X1yCJExh9/vYVf8YzpsI45uA5xRrbmIMQtwsz+BT10Tat96MDwMt29fsZp7ZsupFXwGN
         hbjaQRLKTAdBucjnowRXIs5ZAofQ+je4EiCA04RGYucrncLl/6VU/9kiQC7/txY+oi6j
         QigQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsIh7gGa2CM9spAehium9saH/CH7keJZsTdoEvUy+VNS1k2vG/EOjKOEAMJj3ZxZltwMBsD2iMhN9idN4eZlQF3RmTHIHt1FnD52R62w==
X-Gm-Message-State: AOJu0YzNUmOSQj6SJU/eormO5wFTv5BKfiniTVRJHU0Lcx7hJ4HTmGI1
	AvTYwAffmHgQmnA/KZ9p/isqO2oGsR8zC0oDqqUPv/jAkBLLV5Iiz7j8AoSM9bI=
X-Google-Smtp-Source: AGHT+IH0bIugehaR3h0BPg9B9iAy4/R0yTCrY6GCh03Oc+x1Ek3PGyNgMf041myAZ2k+mYUyYZR40g==
X-Received: by 2002:a05:6a21:1f1e:b0:1ad:9150:631f with SMTP id ry30-20020a056a211f1e00b001ad9150631fmr1566779pzb.36.1714555972064;
        Wed, 01 May 2024 02:32:52 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902da8c00b001e27557050dsm23833306plx.178.2024.05.01.02.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 02:32:51 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s26KX-00HDMz-1V;
	Wed, 01 May 2024 19:32:49 +1000
Date: Wed, 1 May 2024 19:32:49 +1000
From: Dave Chinner <david@fromorbit.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	hch@infradead.org, djwong@kernel.org, willy@infradead.org,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH v4 29/34] ext4: fall back to buffer_head path for
 defrag
Message-ID: <ZjIMQTAtxZ0NhCD2@dread.disaster.area>
References: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
 <20240410150313.2820364-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410150313.2820364-1-yi.zhang@huaweicloud.com>

On Wed, Apr 10, 2024 at 11:03:08PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Online defrag doesn't support iomap path yet, we have to fall back to
> buffer_head path for the inode which has been using iomap. Changing
> active inode is dangerous, before we start, we must hold the inode lock
> and the mapping->invalidate_lock, and writeback all dirty folios and
> drop the inode's pagecache.

Even then, I don't think this is obviously safe. We went through
this with DAX and we couldn't make it work safely.

Just return EOPNOTSUPP to the online defrag ioctl if iomap is in use
- that avoids all the excitement involved in doing dangerous things
like swapping aops structures on actively referenced inodes...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

