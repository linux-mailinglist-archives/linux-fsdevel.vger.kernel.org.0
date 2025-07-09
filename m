Return-Path: <linux-fsdevel+bounces-54351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFABAFE7E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 13:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A39E3AB084
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 11:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E9D2D3A6A;
	Wed,  9 Jul 2025 11:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WuEH4qkM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DB8AD21
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 11:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060934; cv=none; b=TgGhfTU7LbkNqnpGbHkMstXSO6XtZUEfMBTstxs4IHOXeM69p1DVMWrUdfO70HXfm0R3C0D64lHLyGQbGV89MI/jrLmK6IIwVNjCz38XIouBDr2nN3CVXFQWCWmA265tvN48OKi+L0uLs/nealQDsL6R8xuGU9P+zhkYFXnJlOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060934; c=relaxed/simple;
	bh=HJz/MjLmVWjgTYOoY3b2hWMx+j9t4fSDmK2E60JWHFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeC/J0ZjT/I1tzws2SpUYhquhDg45gk06R3Ez6g+XblmT3lCWGzQWUgD98RAnUho6khcDQwvrDSlDbEqK1FfZ4W/p01fYAoV8PKOA/ULi2MAIHSCc+Lc+8U62jvPJF0Uxh+GXGK/j7muyc11BnIZwF7toxrly5bJIpMsFzH2TGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WuEH4qkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83349C4CEEF;
	Wed,  9 Jul 2025 11:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752060933;
	bh=HJz/MjLmVWjgTYOoY3b2hWMx+j9t4fSDmK2E60JWHFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WuEH4qkMrVj5L9W0xcu27sHzGMReXH9GVbKbMyVLf4rWFqh0tlNt1wtn9oMriqMtM
	 dx1k635AFB/9GlaaAoXo7Ate+We5SVIaafkyi6FTAsOTJ+3Wx1xfMVJKIIMUKaUWnS
	 vqp6EtS0edtlMJ16PRizoNDorQdR//kQN3nPWr+s=
Date: Wed, 9 Jul 2025 13:35:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHES] assorted debugfs stuff
Message-ID: <2025070908-lent-propeller-c91b@gregkh>
References: <20250702211305.GE1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702211305.GE1880847@ZenIV>

On Wed, Jul 02, 2025 at 10:13:05PM +0100, Al Viro wrote:
> 	A bit more of debugfs work; that stuff sits in
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.debugfs
> Individual patches in followups.  Please, review.
> 
> Several removals of pointless debugfs_file_{get,put}():
>       zynqmp: don't bother with debugfs_file_{get,put}() in proxied fops
>       hfi1: get rid of redundant debugfs_file_{get,put}()
>       regmap: get rid of redundant debugfs_file_{get,put}()
>       resctrl: get rid of pointless debugfs_file_{get,put}()
> Getting rid of the last remnants of debugfs_real_fops():
>       vmscan: don't bother with debugfs_real_fops()
>       netronome: don't bother with debugfs_real_fops()
>       debugfs: split short and full proxy wrappers, kill debugfs_real_fops()
> 
> Bogosities in drivers/thermal/testing:
>       fix tt_command_write():
> 1) unbalanced debugfs_file_get().  Not needed in the first place -
> file_operations are accessed only via debugfs_create_file(), so
> debugfs wrappers will take care of that itself.
> 2) kmalloc() for a buffer used only for duration of a function is not
> a problem, but for a buffer no longer than 16 bytes?
> 3) strstr() is for finding substrings; for finding a character there's
> strchr().
> 
> debugfs_get_aux() stuff:
>       debugfs_get_aux(): allow storing non-const void *
>       blk-mq-debugfs: use debugfs_aux_data()
>       lpfc: don't use file->f_path.dentry for comparisons
> If you want a home-grown switch, at least use enum for selector...

All now queued up for testing, thanks.

greg k-h

