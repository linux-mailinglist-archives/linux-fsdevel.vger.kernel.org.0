Return-Path: <linux-fsdevel+bounces-39047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36111A0BA5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 15:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBB41881843
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 14:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F0423A105;
	Mon, 13 Jan 2025 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVMQPjIC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9853B23A0EC
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779882; cv=none; b=nrH/SsbA1btE4SdDqpbWAvMo6Re91iqnJ0p9bwD+HROMxXXWiVbXJ1/ksaDy2Vie0CIOAeR7Cd/8ZSq2vkmEYn9BisfxmfiUAPO1hEj97DTdZtrAaPGAIPlki1dg9s0u/tWIyIYwcZyytk9m+I97b3uzkvLFDX1alFDubnNGrWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779882; c=relaxed/simple;
	bh=ehsW4sZ4w7KL03QvmuaXjIA/lL4QW4GeLUlMmqS1oKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t03G1Pt9zXXtNxeFdTWirFoFlPJaBn8JP/6UpR8OI+f+Yt5zidRzjoCO7+x26OE6VfNUBPc7h2Fc6hF9g5rPVwKVPN70v0H5Rw7j/WXwXymyo8Fq9YdKEty6Q6KlWREvHCBw8aWAEMx98NduroOEGncryKpQwSQGWGPfCqUbPDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVMQPjIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601C4C4CED6;
	Mon, 13 Jan 2025 14:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736779882;
	bh=ehsW4sZ4w7KL03QvmuaXjIA/lL4QW4GeLUlMmqS1oKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eVMQPjICGScCEd4S5BmTMFgTRXfgvdeYHAvM9+4hHaS4wpKVIaL0UnpNC2zzPknXx
	 CLyTgvPngNkAOGU+Y4D4LhedMwzuBR+BPUI8Op7/W2Q8sOO38h8SXxZ8QXXBbqSYr0
	 A1uJalQ3GWrYyHKkvwlrDmtkmO67i7n1Y9K1twPTeoMMVZR+tnpapWHJrkgvK74VML
	 OppYwfDz/8j3dF78dYwkx/RUIM8zN/rvOEQ19Nk64VaLUQJuDTRPD9yGs+Z7eRWStr
	 L9+57//UsYd1MRyqvyayJgQ9E5aCA09ymXNBHGV/KbewV2vnPOrlQszB5ga398nOu6
	 lNROon2No9i0w==
Date: Mon, 13 Jan 2025 15:51:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 03/21] debugfs: get rid of dynamically allocation
 proxy_ops
Message-ID: <20250113-bedrucken-abbaden-ef2c23406924@brauner>
References: <20250112080545.GX1977892@ZenIV>
 <20250112080705.141166-1-viro@zeniv.linux.org.uk>
 <20250112080705.141166-3-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250112080705.141166-3-viro@zeniv.linux.org.uk>

On Sun, Jan 12, 2025 at 08:06:47AM +0000, Al Viro wrote:
> All it takes is having full_proxy_open() collect the information
> about available methods and store it in debugfs_fsdata.
> 
> Wrappers are called only after full_proxy_open() has succeeded
> calling debugfs_get_file(), so they are guaranteed to have
> ->d_fsdata already pointing to debugfs_fsdata.
> 
> As the result, they can check if method is absent and bugger off
> early, without any atomic operations, etc. - same effect as what
> we'd have from NULL method.  Which makes the entire proxy_fops
> contents unconditional, making it completely pointless - we can
> just put those methods (unconditionally) into
> debugfs_full_proxy_file_operations and forget about dynamic
> allocation, replace_fops, etc.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

