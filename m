Return-Path: <linux-fsdevel+bounces-1104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7527D5554
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 17:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B71F7B211DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D611A34CCE;
	Tue, 24 Oct 2023 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jov+A1Iq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F11A328BD
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 15:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9497CC433C7;
	Tue, 24 Oct 2023 15:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698160662;
	bh=Yeh+DhQziDSTNQ0Nd3bkiHLiqQBkmoQwrieAjh5C9qM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jov+A1Iq/OXLdgTE0Rb9L2QE1aCaqoZ6E9Rt10jn+Aj32ELWt7dHh7eqekqoguLjj
	 s2CtEDg5qIv9dfCCwQPKMaFF5b+byiNx3ECkgPso02dtNTYfCN+Upysk+RmY5gPKbo
	 PLCQyuRBBNEe5UYlkm6kZZ2Q0SqOxuC2Lxzyn3PvqhrAKU70VSYAMRx3rb2u491O06
	 tXuzTzXqQxQplF4esR3W/0Fz6bJFHLgWy8w7Jgb7alHWkdTPAr+/CHtHu7D/kpSJbc
	 W/4BELnZw69NOJWmmgKBNSxMjzQnxmNKeHuVYgieBYzqh34o/4WjMmB64VIojQSDmY
	 esulGBL5DrBSA==
Date: Tue, 24 Oct 2023 08:17:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] porting: document block device freeze and thaw
 changes
Message-ID: <20231024151742.GG11424@frogsfrogsfrogs>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
 <20231024-vfs-super-freeze-v2-9-599c19f4faac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024-vfs-super-freeze-v2-9-599c19f4faac@kernel.org>

On Tue, Oct 24, 2023 at 03:01:15PM +0200, Christian Brauner wrote:
> Link: https://lore.kernel.org/r/20230927-vfs-super-freeze-v1-7-ecc36d9ab4d9@kernel.org
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  Documentation/filesystems/porting.rst | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
> index d69f59700a23..78fc854c9e41 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1052,3 +1052,15 @@ kill_anon_super(), or kill_block_super() helpers.
>  
>  Lock ordering has been changed so that s_umount ranks above open_mutex again.
>  All places where s_umount was taken under open_mutex have been fixed up.
> +
> +---
> +
> +**recommended**
> +
> +Block device freezing and thawing have been moved to holder operations.
> +
> +Before this change, get_active_super() would only be able to find the
> +superblock of the main block device, i.e., the one stored in sb->s_bdev. Block
> +device freezing now works for any block device owned by a given superblock, not
> +just the main block device. The get_active_super() helper is gone, so are
> +bd_fsfreeze_sb, and bd_fsfreeze_mutex.
> 
> -- 
> 2.34.1
> 

