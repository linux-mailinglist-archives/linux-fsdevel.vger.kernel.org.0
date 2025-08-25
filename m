Return-Path: <linux-fsdevel+bounces-59054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6726B3404C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76ADB3A79D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7F01DF985;
	Mon, 25 Aug 2025 13:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAHbwGvj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B47716DEB3
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756127007; cv=none; b=TFxuBnyo/CniZldm9XKEnnDZsrxWVcqctRyd7TFbc2zRwrrFNOPcX8X/1dvZ2Ix53vZFuXJ5BXRpvdR1F8tVFFsswiA+HhBttajXtkWQHlzoTDWKmJ9pMTt3FbkNYvw5kez2Y0Iu84Nfe3Kq3wTBf9SQ7caIaAEeZ9xgWqR+qqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756127007; c=relaxed/simple;
	bh=FMG7yrbjwfsb3+cBGz2JCd97+TKIAQQ4rzvAp451gyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRHqkbkbjNTuAbhZXuwmLUEYMUtnKGoqs5IWGXrqXjSDmxV+M3DkAKfYHPetGTn70ct1aU7hbQ5zB+cd1VCDHGKbxrm3eyvKCH4y9iGceJHjjMp8qHAimPlpr6VJR4grf2yIYkhNZI++XmXHJvptErPuC7VnkLfFbPXjD4ilJ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAHbwGvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406DBC4CEED;
	Mon, 25 Aug 2025 13:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756127007;
	bh=FMG7yrbjwfsb3+cBGz2JCd97+TKIAQQ4rzvAp451gyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qAHbwGvjTc1FsdfpFAgSvPgIJYGMUpWcxpugTyLDT5obKqzyE+y2HZwoUfMj1/K26
	 QK8vxeFKemgZgJG0d0P9zZCKLAgDR8XOZoDKW1E8ZukchesP3hVx5ae6RY+YfFRpqn
	 dmLNxer0weU59jVLS8bc+n0sa1LEJyxuaEHOzsFakOzwKMCy5P2+EdUn6+s+a+p2Ex
	 QNrCPtkzClrPkDsHL3634UUIifrejiWpkMQ1JjjNCUHGRSIZpySqTeSQJAm4eU1wza
	 7fpKqRICGvd8CCYnYRHH2iAJ0jcgqhdaFAClXbluhtIunNgAvNGda6QTJsrWBqwg1b
	 ChjI+XziBkHOQ==
Date: Mon, 25 Aug 2025 15:03:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 23/52] pivot_root(2): use __free() to deal with struct
 path in it
Message-ID: <20250825-stilbruch-rasch-0b87944ca7d0@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-23-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-23-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:26AM +0100, Al Viro wrote:
> preparations for making unlock_mount() a __cleanup();
> can't have path_put() inside mount_lock scope.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

