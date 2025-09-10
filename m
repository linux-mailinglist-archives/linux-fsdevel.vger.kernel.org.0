Return-Path: <linux-fsdevel+bounces-60828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DE4B51E34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 18:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12537482C91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE98727B4F7;
	Wed, 10 Sep 2025 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rALV00yq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009C325CC40;
	Wed, 10 Sep 2025 16:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522932; cv=none; b=jAB69W4fsv9qkRb2azoOQHyKMfqAr0vYG2WMIzJzaiXe6QqJ6r/wqxIm3Yd0wI6T1chscLssxAhgXBaEd3foFyVyXK1Xszw8ClZHoPzBW1gCoolb2c1jzenu5q7ILYIofoanpPk528dq9nqvaH59MuT5pFEEzsJYeKxFmtnfJac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522932; c=relaxed/simple;
	bh=CaZJB936f6x6jAPejT2mFRYLV0h4EVhdrhS9aolT+HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9dfemnuYJRvB5FvRqpSZUmJO96Nn6BMKl5OIIEzWIezI9uTxrH17va3Sg/z6qzU/I5EVfqVue2nrBYd9TAtPUdB9qHO1vSGcLNSaMYRB1O7GxSKHt38CDgscVL9Cdo4BgaYoSyh8p/dpHjCqjtvTyuFL0hbjTGLv6AYSfrISUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rALV00yq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A5EC4CEEB;
	Wed, 10 Sep 2025 16:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757522931;
	bh=CaZJB936f6x6jAPejT2mFRYLV0h4EVhdrhS9aolT+HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rALV00yq13zFBYaiTVxZZKExTyQ8ddoSKuBGN4RZz8Zj86KPpAuEyasGAEq6SILcY
	 ZKvPbZ4FkCmVVwzdgvcOPViWrVUdVxIZuiaNL+ETAcxoDv1nNvWv6aavhlVM2Ug9rn
	 BwR7V3Hen3mjLAqkubyEg9Lj8X2OGd95JZh7fwx8oVefPaNtdgfkbLR6U6yTHCdcKG
	 vZinpis7sVfGRSYdmKHYpqIsHViXi/0A01COPCjj+LrW8pTBpNlXv/oLAJBnlL5zFv
	 LZxQ3o6zDCPFDGljHlWss/zxFhFgqxeg0BOf2ESGDKFH8UDvSKcR5h54sSEaua4G7x
	 S9Uzs2rzC+QWg==
Date: Wed, 10 Sep 2025 06:48:50 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 18/32] cgroup: support iterator
Message-ID: <aMGr8q9q0kFE0JHt@slm.duckdns.org>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-18-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-work-namespace-v1-18-4dd56e7359d8@kernel.org>

On Wed, Sep 10, 2025 at 04:37:03PM +0200, Christian Brauner wrote:
> Support the generic namespace iterator and lookup infrastructure to
> support file handles for namespaces.

The patch subject seems a bit too generic and could be misleading. Maybe it
should mention it's for namespaces? Other than that,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

