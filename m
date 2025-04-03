Return-Path: <linux-fsdevel+bounces-45614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF10EA79E64
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 10:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F2097A3D7F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 08:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42756241CB7;
	Thu,  3 Apr 2025 08:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePapkwwn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6D71DE3A0;
	Thu,  3 Apr 2025 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743669795; cv=none; b=ni+CJ0M5exmRso4eW8nNHx5IvqDvfzdtPMtrjWj6Esx70gNfIeb83wpaYB9sOH3nVrfFP5sVQkDZwCKP5TGT/k+mg2UPxPjMD0ViMftWTffYW9pGIscChNUOKgFn+dyqkjDC43awYWLZiJwJRCpyO2KyHZyZP/9LkrWlc0FbAOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743669795; c=relaxed/simple;
	bh=6g8FqrKK3MZq0bJoOQoho9oSxBxGiQFuxdTwO9ziCHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4crY5te3pUG+yof5pxc8b/ADeYfCvqz4nTMaMJj5lI8XoHvAiDL0/lClVgiWpvWmj2RIuC9RuWESEVD2iC/a3PE8pz3OHQorDnkxBGHXpmLu/EJ/sb8R993kXpvmFt5PkTippaYx+YYO35qQwGpah8gpZdi0PJLEu3ttZelit0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePapkwwn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5B2C4CEE3;
	Thu,  3 Apr 2025 08:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743669795;
	bh=6g8FqrKK3MZq0bJoOQoho9oSxBxGiQFuxdTwO9ziCHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ePapkwwnli2G/7KgmQNuwT/XNXfe+RrRx7E2TOM6U/SBIDEkqJfAtLAAt+NAM1IQ6
	 G2bNMohqCdX/gTCe6PW9O8y7SAUqAIz26eIBrBcY/BXtggTB8vy3CHrOTwIJl/lo9O
	 ugCRc1zcQUVff6bfmK4jP+Ve7jvYMNnjhkaRjAuNp3uP/mbMiC9RNjmxGyIcbqgBjr
	 1nuB+ai8kpBwKLmLjT9o1lNN0+NgOnVpn0jMp7MqkV+evTNKVqui08t+vqYq5UqJjC
	 TLH3YpuUa+T5JlkHnH52j/mZCGWYhPBXcCFVa79Dg+YpkVh9qo7pHO2Bq883CwVqrI
	 7v7mPAeeR2pOQ==
Date: Thu, 3 Apr 2025 10:43:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: make generic_fillattr() tail-callable and utilize
 it in ext2/ext4
Message-ID: <20250403-fuhrpark-bargeld-3c1ae2c90bee@brauner>
References: <20250401165252.1124215-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250401165252.1124215-1-mjguzik@gmail.com>

On Tue, Apr 01, 2025 at 06:52:52PM +0200, Mateusz Guzik wrote:
> Unfortunately the other filesystems I checked make adjustments after
> their own call to generic_fillattr() and consequently can't benefit.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---

You need to resend this during -rc1 or at least when all fs trees have
been merged based on mainline.

