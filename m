Return-Path: <linux-fsdevel+bounces-59034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D298B33FA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9B23B94F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6D872639;
	Mon, 25 Aug 2025 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDNjxJM8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396D3393DCB
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125452; cv=none; b=eaVUWnJAz3s99z3OEud3tRkOo4Y1ib+Fra86Ku8Z+hv36mA9QE3TQ4mDJBcVPL00KzSC4nKj0S8eAHdyTS+6r4pz1p9ACpq9e6VUMiqzQ6xsxgaEjWAMoCcfRdaWTEDpeHhlIp35zTgTn1+ogYMX2vbyCAuVk9WU+aTwzGtpWD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125452; c=relaxed/simple;
	bh=lWqhFnKn8i7OBepaOLtEEvWj22kp5QMfhEp7yzip2HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNhK5Lrqwvhc2Yrqu5K8ktWPvVL4uL+lM8nSWyjtzZoSjfwLt12+GwX/av0C9g84jI4zXtezqAebBDvWk1dI9lZAumjSycmFVSSMDs+FrLP4tQjep6tilgYC3SQ0aJJJSHO9D3P0mrAWfoFj0vXn4WWWZn+hrOKkE4u5hjwZfPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDNjxJM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB692C4CEED;
	Mon, 25 Aug 2025 12:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756125451;
	bh=lWqhFnKn8i7OBepaOLtEEvWj22kp5QMfhEp7yzip2HU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YDNjxJM8rtwylRgknSOvH5mX2MpZ31YUPurNAK08R7VsUpUYz3kSQoyW+qxHEOBCf
	 13nu1bs8lGF1JSi1o7Zc5OMUuFKEmRnShK0JARuWMBFL8ngQuz0bTeiopvBm2sddr1
	 Ef/ksbPi6gSJOUsDy9jj7jKScWFczJ9HCoB+tX0rizmfQmrLC2Ecvth9O3B8l9wivm
	 zgHB9S4YGmKwdKKpVk8wZeX43YCoOtWK2Ij9Tw+ksnfSfCe88xGw0Loz8EnGfGOkKM
	 wOqmQrVOdgdeydTFaJmC9f1ohjtgGtKKXSdEc+qVfn+4skADj+dopjfjYEvmmurbFH
	 G5GYuZmXP5ecw==
Date: Mon, 25 Aug 2025 14:37:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 09/52] put_mnt_ns(): use guards
Message-ID: <20250825-machen-mischen-8284d45162fc@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-9-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-9-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:12AM +0100, Al Viro wrote:
> clean fit; guards can't be weaker due to umount_tree() call.
> Setting emptied_ns requires namespace_excl, but not anything
> mount_lock-related.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

