Return-Path: <linux-fsdevel+bounces-50577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69274ACD73B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 06:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138DB3A6EA3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 04:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDA62620CD;
	Wed,  4 Jun 2025 04:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="k4r5apP8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96981DE4CA;
	Wed,  4 Jun 2025 04:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749011619; cv=none; b=hmQJ1ataKC/LZ+AwVSSYouw9U73HUf020EkOXZExWwT+wMGO8a8d2vvEfCYx3iaGF5KgeuSk6z0zcYXhqHcCj1CNrFlPwBjNb27mTAp4ymLlk9PwGFVnTmiGFj3BeEz83UvU2lWfxHZ9nDLeKVkhDEEdgVPA0kQf3Q7IE6VudXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749011619; c=relaxed/simple;
	bh=9NeDDdxV0q4sXEFhvG5y3MBDGxM6rM76CNHh5/RF2/c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NC8D+iUZ3TqthMzUw+yLLb19gIzAgjl5oAlCMv5Qxt/X4b0tgr8c4eJHM02LsPQDaieyzKftsqT1xlexmE23x0Edq5QOPFddOXUGjuRiaW09gqVhkiaW+O9tJzfy80nZJgwVMbcq6ijfV/Qj8MEPzSmFezo1clpljITdvOcGhb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=k4r5apP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD94FC4CEE7;
	Wed,  4 Jun 2025 04:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749011619;
	bh=9NeDDdxV0q4sXEFhvG5y3MBDGxM6rM76CNHh5/RF2/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k4r5apP8Gx8lEe5htLA+PcDXUKwh7TZpQZgx5DX5ZFjAb+lHsV+QQC/pZDznExcu4
	 tgEPBts+Tx2ZiHI3hZe0BW0QYQB6Q8KEZnGyfZ+lLO4l2QDJ4bWLQ4B2xUIi6J88pD
	 cOyBO/+8jH2lK3ig/zy2cKtbEg2B0MinQpkPGiB8=
Date: Tue, 3 Jun 2025 21:33:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dev Jain <dev.jain@arm.com>
Cc: willy@infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, david@redhat.com, anshuman.khandual@arm.com,
 ryan.roberts@arm.com, ziy@nvidia.com, aneesh.kumar@kernel.org
Subject: Re: [PATCH v2] xarray: Add a BUG_ON() to ensure caller is not
 sibling
Message-Id: <20250603213338.7d80bbe0e021052c20e1c5f5@linux-foundation.org>
In-Reply-To: <20250604041533.91198-1-dev.jain@arm.com>
References: <20250604041533.91198-1-dev.jain@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Jun 2025 09:45:33 +0530 Dev Jain <dev.jain@arm.com> wrote:

> Suppose xas is pointing somewhere near the end of the multi-entry batch.
> Then it may happen that the computed slot already falls beyond the batch,
> thus breaking the loop due to !xa_is_sibling(), and computing the wrong
> order. For example, suppose we have a shift-6 node having an order-9
> entry => 8 - 1 = 7 siblings, so assume the slots are at offset 0 till 7 in
> this node. If xas->xa_offset is 6, then the code will compute order as
> 1 + xas->xa_node->shift = 7. Therefore, the order computation must start
> from the beginning of the multi-slot entries, that is, the non-sibling
> entry. Thus ensure that the caller is aware of this by triggering a BUG
> when the entry is a sibling entry.

Why check this thing in particular?  There are a zillion things we
could check...

> Note that this BUG_ON() is only
> active while running selftests, so there is no overhead in a running
> kernel.

hm, how do we know this?  Now and in the future?  xa_get_order() and
xas_get_order() have callers all over the place.


