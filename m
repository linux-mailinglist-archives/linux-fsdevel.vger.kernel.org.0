Return-Path: <linux-fsdevel+bounces-59076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEA3B340F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61A03BB84A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F7127380A;
	Mon, 25 Aug 2025 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuL6A54a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37541F4CAF
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129238; cv=none; b=eB8V6JxgdGhqBnhI/L4pbAjBjuIM5m2QGoD+Ii3X7L3DtiEBclfbvk9qpHo5eNATEaObMhgnFXyGAqBEq4cDqBlvupW9n493AogPIUkGUE6qMDnyJpHjXRTewKYlli8eHZHh2n8SIIpSN0OfS5/1+ncqoTFsokjAzTabTid59UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129238; c=relaxed/simple;
	bh=rlcfCtsaLlDJGVdhQwESy/TC8li0psbdup924kg8X04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQlayCZMsLpsaMtWCIAlxWmBeWvNeEj8AWA2PcwAHekNb0Jl4E/mnR2W0l16HML41lX5COG02wpSbuRnwHRu1CYyEmlW+gdCU1FyUu2DtNqa/e8wdbCRx4FdmzsRUjWGJCRz0wh9rNXU7RWATlJndkoVX0g1BARvgwsTtYJ5OYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuL6A54a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7D8C4CEED;
	Mon, 25 Aug 2025 13:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756129238;
	bh=rlcfCtsaLlDJGVdhQwESy/TC8li0psbdup924kg8X04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WuL6A54a+GFeH4RffdNgioVYEAHzoaGKsvmdK3CbShU7ElVe53PZH3k7ncNj6txf4
	 Nw9TpP9EyDgxO2n9yEd4Mzvwk34XNKMfVoI2Vfwl1KOTrTOo3hqpg1tEe3PNfGQAnf
	 wmQ5O3YZksYrq42HJno0fqPe2RZxxkoE4eEdMzuXjWPRPeEpKxulqr6SU4wYS7Ihsy
	 s9CVGQDssXUeN+jHxyWlqAS7McsoOzCO0vY8oVba+50RT2vjza8WoRmctAGyiVt+XW
	 VGth0bTG6LyT22LlaoKWnf/qu+2yxwTh57oHrjJsyPmbBM3pndV3PINCi+ERikKs6+
	 WRYY1qHmsFALw==
Date: Mon, 25 Aug 2025 15:40:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 45/52] may_copy_tree(), __do_loopback(): constify struct
 path argument
Message-ID: <20250825-degen-gigant-817ff7ed9b52@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-45-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-45-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:48AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

