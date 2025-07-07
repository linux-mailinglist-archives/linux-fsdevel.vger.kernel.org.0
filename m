Return-Path: <linux-fsdevel+bounces-54066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830ACAFAD6F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 09:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9CB3BCE1F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 07:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822E7289340;
	Mon,  7 Jul 2025 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjLpF7tS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8F61F4191;
	Mon,  7 Jul 2025 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751874214; cv=none; b=hMBdQnIDcZz2+EEzaFTsWCvNdGMHg57evIp8F2FOm3o1AWXBglDCRa5qVRLAaBH7EjPvNuWjriCpd/ASLwx+OzRQNcaeUEc7pD7+qLIKRL3fNEII7e4huyPFkFhAoO+OUzwMPrTao9eCh7hOOiJd7aNQmklm6nL/rfN2ER7DxAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751874214; c=relaxed/simple;
	bh=PJPYQoNE4FaYChS9k6nxkJnTKah56Ht1djjEXQDOx/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibSLqB1HE9a5GUwIB12fvIIpZ1D1M+VmEZ9Oe+1+l7TdDbdMZLXCw9RNEHlmNiNoQid0lFZmd9WbZojcH4BGzxf/smOq7BaMQyqlDJRzJ4aBJ/0xNM0TWNAQ1quUXySJuw0R8r350ijyQKEaidSlCJGWQHPFdTKadSiBOD7bK2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjLpF7tS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274CDC4CEE3;
	Mon,  7 Jul 2025 07:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751874213;
	bh=PJPYQoNE4FaYChS9k6nxkJnTKah56Ht1djjEXQDOx/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FjLpF7tSHGqigGPvGo7fwu23jSOUAkR7/B+6e3wgKHr4jN6K2MTyIUmNHNFQ0Pzne
	 Kr6535lvUYWhRV973NUYgxQjusuR5dVo+zFahebrL7NmFfsin4WJXhWUi2WXVXyc98
	 6ReXKq2M+Xeid2PoBoKvj7ilkMcKxPk0MIYQ68I0kEGPdyR/ZEzSfr+wvas2LN/FcT
	 Tna9KkPQhKJGnPw6Bu4dpXTaJrTOvcjrWbYY2PNwmqsQQaHsUIuwogTeCHbYHS7Raa
	 nRlHjJ2cp5RFeMOD7Cjes3iwJwqjqzXIUpu2nu1tdW8bkZvr7Opj7mmWXqs+J4H3UJ
	 i1CSppnUNZxhA==
Date: Mon, 7 Jul 2025 09:43:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Qu Wenruo <wqu@suse.com>, Jan Kara <jack@suse.cz>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] btrfs: restrict writes to opened btrfs devices
Message-ID: <20250707-wogen-karate-68a856159174@brauner>
References: <bf74fa9eee7917030235a8883e0a4ff53d9e0938.1751621865.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf74fa9eee7917030235a8883e0a4ff53d9e0938.1751621865.git.wqu@suse.com>

On Fri, Jul 04, 2025 at 07:08:03PM +0930, Qu Wenruo wrote:
> [WEIRD FLAG EXCLUSION]
> Commit ead622674df5 ("btrfs: Do not restrict writes to btrfs devices")
> removes the BLK_OPEN_RESTRICT_WRITES flag when opening the devices
> during mount.
> 
> However there is no filesystem except btrfs excluding this flag, which
> is weird, and lacks a proper explanation why we need such an exception.
> 
> [REASON TO EXCLUDE THAT FLAG]
> Btrfs needs to call btrfs_scan_one_device() to determine the fsid, no
> matter if we're mounting a new fs or an existing one.
> 
> But if a fs is already mounted and that BLK_OPEN_RESTRICT_WRITES is
> honored, meaning no other write open is allowed for the block device.
> 
> Then we want to mount a subvolume of the mounted fs to another mount
> point, we will call btrfs_scan_one_device() again, but it will fail due
> to the BLK_OPEN_RESTRICT_WRITES flag (no more write open allowed),
> causing only one mount point for the fs.
> 
> Thus at that time, we have to exclude the BLK_OPEN_RESTRICT_WRITES to
> allow multiple mount points for one fs.
> 
> [WHY IT'S SAFE NOW]
> The root problem is, we do not need to nor should use BLK_OPEN_WRITE for
> btrfs_scan_one_device().
> That function is only to read out the super block, no write at all, and
> BLK_OPEN_WRITE is only going to cause problems for such usage.
> 
> The root problem is fixed by patch "btrfs: always open the device
> read-only in btrfs_scan_one_device", so btrfs_scan_one_device() will
> always work no matter if the device is opened with
> BLK_OPEN_RESTRICT_WRITES.
> 
> [ENHANCEMENT]
> Just remove the btrfs_open_mode(), as the only call site can be replaced
> with regular sb_open_mode().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

Ok, very nice!
Reviewed-by: Christian Brauner <brauner@kernel.org>

