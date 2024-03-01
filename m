Return-Path: <linux-fsdevel+bounces-13251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EB286DB9E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 07:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492581C21C9A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 06:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A21C67E7D;
	Fri,  1 Mar 2024 06:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U4u6iMtU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AC767E89
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 06:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709275565; cv=none; b=sRK3WnXD24c3K+LYXCD6PFEeZ9CeY8jc66L+fSrErXf3MH8dHKykHYVfYBZwhVh+luJWYfV7cOz7nqMZUaVizBV8KWqFjSAViKOXvrHa5CRCe+v9+PJh1xOaQLPWTve3B615OuvGYOmD4GvalXOIKQOaGE7IEcJyzkORkDQ+zfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709275565; c=relaxed/simple;
	bh=B3cdWh66TYi4qF3aFQRUC83NrB9JAnALdJiLyJjAIZI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Zmkob0AZTawMPoLmmvCAJUx5OIXJ5k/mrX7pAIEhKqYEhKNtlKZTaA6D25s1k/mrCxoYh7zytLDeRxPVHUHODMy8vU9kQ0TgKLuvea0nwhJ6NMInO5M2NXFAgQ1mbZKB1/hFx+tSsgnR6P9UqvP4E51xELidQR2/Dlt821pTKS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U4u6iMtU; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709275559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+hYtXjShCl5X9wGqiDZzOLF1iThBwwEIMXOWjYHLdw=;
	b=U4u6iMtUGEcOKJrEoGJdxIF5RLdDOSEraoG9U1oUAKfJhIieAe1vcQzzporgLQoKSQxArn
	zW7YQFKRaaQiRi2BQ2chVxCWpG065oMmrmo/4bnlJCOFAbg4SrwzYbex+hJK7A8hg5d2EW
	s4udu9qfoasOHYmZvci3w+Gme+IMFZM=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH] hugetlbfs: support idmapped mounts
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240229152405.105031-1-gscrivan@redhat.com>
Date: Fri, 1 Mar 2024 14:45:21 +0800
Cc: linux-fsdevel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>,
 rodrigo@sdfg.com.ar
Content-Transfer-Encoding: 7bit
Message-Id: <1B974CF9-C919-48F5-AC0F-7F296EC5364F@linux.dev>
References: <20240229152405.105031-1-gscrivan@redhat.com>
To: Giuseppe Scrivano <gscrivan@redhat.com>
X-Migadu-Flow: FLOW_OUT



> On Feb 29, 2024, at 23:24, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
> 
> pass down the idmapped mount information to the different helper
> functions.
> 
> Differently, hugetlb_file_setup() will continue to not have any
> mapping since it is only used from contexts where idmapped mounts are
> not used.

Sorry, could you explain more why you want this changes? What's the
intention?

Thanks.




