Return-Path: <linux-fsdevel+bounces-10300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C21A849A17
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F64B1F2576D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530F01BC40;
	Mon,  5 Feb 2024 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ6Fsvwj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B8E1BC31;
	Mon,  5 Feb 2024 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136012; cv=none; b=tNvu5k2tkl5lA2SRmNiHwpkk0SDxcLURR25lTMc5hCo5u6NP/rWQFvx1NmNmPeORVHUpLsAwwQK8he8/Di2bijK86ZldfLyIhStN7eWuN1hAaaw+asSSu4Ar8il4l9UlHr402TvdMBDz1C2uIwhTSGJy7zp/RLQi+lADzGULG3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136012; c=relaxed/simple;
	bh=7BZmaz1GszLR/QxTb7qMga3lJ9FApfiPjyAvCswSlgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ni5VTSn8W0PFMKRGARa8kwsuWaaZrmPmVXkVim1TEkGGnWamSifmytxydohPSek6tszUf01wWo2MWgxagFkpSLirQtb5E0BxsSAY4f6JubmGbwMEh8bm0JIWaCu5BpNSQTFWayvPKWJstejBcwyfzyLxbPLJV3dAXnqgmXAryBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ6Fsvwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E65FC433F1;
	Mon,  5 Feb 2024 12:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707136012;
	bh=7BZmaz1GszLR/QxTb7qMga3lJ9FApfiPjyAvCswSlgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZ6FsvwjZGapDW0ZT7QSYjGfreF87GYEhbekDrkcIo0rgGw9t53yZhy9zmwXKmUPJ
	 Ff0oUtOa1Fzhv7mY4gwDmnPErporU+e4EEkFlo1MzxZ7DbxyX6Hi8PmxqpkAKlzbCP
	 cXlHEvHbXaVfIgy0NkIb3RpswY+hKUjvoatQugfWuUDkaxcfScfJM1CKn/vTY82E57
	 ETSraKeTDS9msLlLZXmnfx6jxoYobMLjvQCGOAQbCuQlGhUQHZ49rX45YlBEFIQl1Q
	 gTNzWwSPP/bzhyynhicq5la0KVL1ozz1sQqIqRpnqQf4us540CJnlHz62ZM3KNuvKY
	 bosz5Rp5eZWlw==
Date: Mon, 5 Feb 2024 13:26:47 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH 03/13] affs: free affs_sb_info with kfree_rcu()
Message-ID: <20240205-minus-ambivalent-48a4649275c7@brauner>
References: <20240204021436.GH2087318@ZenIV>
 <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
 <20240204021739.1157830-3-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240204021739.1157830-3-viro@zeniv.linux.org.uk>

On Sun, Feb 04, 2024 at 02:17:29AM +0000, Al Viro wrote:
> one of the flags in it is used by ->d_hash()/->d_compare()
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

