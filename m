Return-Path: <linux-fsdevel+bounces-72077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B46CDD266
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 01:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2164301D679
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 00:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FA510957;
	Thu, 25 Dec 2025 00:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdDC5qPv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80633A1E69
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Dec 2025 00:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766620900; cv=none; b=R0DDZK8QWVzPS6ZsIdO5D4z4HCRO7AV7crtUWRWAUZZOeu2SiwzVXPmNhaXJ0pWgfpEQosWlAUPW313eBALR2uw3wCDc5OdurQhFcEh5Que25JHKGDqw3hk1qX7uCyMPbG1y2ZK9urI6tX4ck+67rtvpltV3rd/8d6x1MdaHCYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766620900; c=relaxed/simple;
	bh=FVI3jtuH3HuHEdbQazAbBRERleXnnrhBoMIkI8kl3QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4873awbaT/ZntIqC/hjt2fWHvVNVb9BVoObW0hUDaqVYXczr9/8RlI4Uq/Ao7wE59V8gcvdvQFVe4cnhmluib1Ey9lAkdhIHLnAzltA3Ku6NgehqSH2UuJl9o6L4OdcPscDKxlPJwdG8Cvh7W1Xnilg6UiwncT07vAfCKKWXZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdDC5qPv; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso8655198b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 16:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766620898; x=1767225698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Id7F+wXHc93ibgG+/wtsMjOVpvvGjyYqeMy6APf/36s=;
        b=UdDC5qPv1lSCop1E94xo4uC7lIfoJzjij1wsFWWocR43UyXU7sgkjXKXyknOnSTHq9
         j65/vyDauZvywMf+6DxgDMPFuGW/deIjpgOm/NN0blGuekkVAueo1mQWDr21GKNKJOwp
         FzJkK+tUU2+lF32dKtEAMMKVQU7nVSDxYZLagvl0n0j8SfOs42jfVPVfWZmvKQV0N4f5
         m4TegH6+YpMuXBb/bxe2bbIIdcgQjGbK1mWclrjxPG8kAnEF0nUTWpkZGh0BMhWoGQvI
         79S0YPJM7TSwOX9iTaPZNKll66DtI5Irevv7CW2AtKTnCyYZWOxLv3wK0kVbq/aTluVt
         jVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766620898; x=1767225698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Id7F+wXHc93ibgG+/wtsMjOVpvvGjyYqeMy6APf/36s=;
        b=LEhc/Krqybk9UD5ki9my0oLMtxBMKBY+Ms+vlQDFjgN0gKFu7Cl2QJdiNzdqv+2q3E
         betcArDzE8txT3mI0AKgR1+rjlehlOFom8rRYuFSCti0UK/acw57tln1gZG81ninszpa
         vtp6NIshDnSobh6uJ+1nwwPR/k0WfG2OBRFUEn3BVdekHAVPACXNabPntO6zIlKmlCwN
         mhRRF5Cb4+pKV9QLeoEZC/Pjx684lAP0ObxRM/ZnOKQ2yIBN6bzgfxVxgOYrX71zHetM
         mmulzbpzheWqbz/IVEYrgrTJC13Eipxr74YhixdtbOSs+hjndbshmkxnwMBbGAUrtjrZ
         KlXg==
X-Forwarded-Encrypted: i=1; AJvYcCWpTDTkmcO/k8x16GQDqVzXmSQdk2uX/wipSRsGTFLftVlE4esA4w9l+ikGFHO+uE0RpHHxl00JStLYYxs7@vger.kernel.org
X-Gm-Message-State: AOJu0YwV9v27UMX+dPAxQ+sDz8ZK9RPBZ4Ctie3ZhvIBBnI2ZBkk/+L/
	3Y8MlX/0IqgTI9OZhXiZGENFAmBdBpw+NCPSHjKhG7+zhF4SpcGj/LrcC6DVRw==
X-Gm-Gg: AY/fxX5nqrtdk1JxT5AqCikcahWmp4QprR1NCucXYyPs5G9eCVh5CeT9C5fH/UAhXHY
	l8FeOQOUiv/wQ+HSMdW38A8TLtx+C4c4WA4pC6jZ1qUElJOIkK40yGuJ6oUumFwLizWznyeInoX
	UPjuV/MrwAzKJyzVAzpxsEPQ5PbvQ3EF5zVqRkky5ZlgSGsJwiyy7aOkH+ViowlTwbHUOPEiUps
	VT5rQ8ntOcpzbPqEKbsA97WiNVSmwyTCsm+pqL/yZgYGZCkuvL8mEe8rnUdeLtX2flm1r1h1MF4
	zXNGJDV0xR8JbYK+yxjoyopS3FOADj/y3tCptBs2HA4IphfDivRMKLjN5yYsk1ztdUJ0Lj0GAGl
	n7GMnV+vRXmqs9B2uV2x6X8QAw1Vk8U3AS12cPF3RUIb4niA4n/rE9qRudLJn9cHrzwMi6h1PXf
	nNRO4=
X-Google-Smtp-Source: AGHT+IEB9Z7kBBF0N2XVVf6Ns1PgmyYFeDwaJ/R5IJAH7naZu7p8IB3nqpfo83P0CwJYaTXa/bSbQQ==
X-Received: by 2002:a05:6a00:ac08:b0:7e8:450c:618c with SMTP id d2e1a72fcca58-7ff664814e0mr18371099b3a.35.1766620897943;
        Wed, 24 Dec 2025 16:01:37 -0800 (PST)
Received: from localhost ([2a12:a304:100::105b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e0a2e3esm17561219b3a.37.2025.12.24.16.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 16:01:37 -0800 (PST)
Date: Thu, 25 Dec 2025 08:01:33 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] exec: do not call sched_mm_cid_after_execve() on exec
 fail
Message-ID: <aUx-0YAA7QyjUbka@ndev>
References: <20251218032327.199721-1-wangjinchao600@gmail.com>
 <aUvYMRmkWXUuuWXW@ndev>
 <4b221d91-84f8-4600-83b6-a2aa16a02c57@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b221d91-84f8-4600-83b6-a2aa16a02c57@efficios.com>

On Wed, Dec 24, 2025 at 08:52:16AM -0500, Mathieu Desnoyers wrote:
> On 2025-12-24 07:10, Jinchao Wang wrote:
> > On Thu, Dec 18, 2025 at 11:23:23AM +0800, Jinchao Wang wrote:
> > 
> > Hi, mathieu
> > 
> > Please review this patch for mm_cid.
> 
> Nack. Your fix lacks context and removes a needed call in the
> common case to fix what I understand to be a init task issue.
> 
> See this patch instead which addresses an issue very similar to
> yours removing the relevant sched_mm_cid_after_exec() call:
> 
> https://lore.kernel.org/lkml/20251223215113.639686-1-xiyou.wangcong@gmail.com/

Yes, they are same issue and this patch works.
Thanks.

> 
> I added Thomas Gleixner in CC.
> 
> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

