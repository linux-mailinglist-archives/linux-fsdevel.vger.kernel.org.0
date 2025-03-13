Return-Path: <linux-fsdevel+bounces-43907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E58A5FA7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 16:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE404189B2FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 15:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4701D268FFA;
	Thu, 13 Mar 2025 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMlhzKxn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C43613AA2F;
	Thu, 13 Mar 2025 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881247; cv=none; b=Q3jlbCyTyW50vRTS3gs/YKvt6JZhrO3H4f1R8eJVTcowMpEl1tLT9uihoYxSOU29mgZz96u6Nh6G1vU2FkKDXByOOuGKhhlYw7F6v/Y07wIS6sValqJYQX7SE36YKleG8gqjVo6rKB4VDSh+2JaBgD8l2B38ZJQvLV1XMi8kBGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881247; c=relaxed/simple;
	bh=CxnWivVLQ4Dd/EZfTFOz5IGyCXEdZefIUY9yz1Sn8wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1hI1CRKXjru7wsgpr+DjAhS/VtQn2G7oVGqiTFuniCU7ajTqBSmEOpAC5WSzNzndVg/vphd93v/sXtyfX8r/7REe/OJSQG8OC2ByTBDJdwls3zJl3SVhvhE8HfKtjMSJBU1xNaZU95qIyhxcXMEljavFakXTZQmDTrxrzeOCNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMlhzKxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB496C4CEDD;
	Thu, 13 Mar 2025 15:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741881247;
	bh=CxnWivVLQ4Dd/EZfTFOz5IGyCXEdZefIUY9yz1Sn8wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FMlhzKxnDDFp+p+D6fevC/6hJa7GAGc2DzpSRvIdBaRWvKoPQcrp4qXysM7ohbIjw
	 oQFs9H4s9wve7/Y7Cdo7PTCztDorpuDUrIAxz3t8yO3mcYE3RSVETjnXAJ3HuRJXgh
	 puNxN+IowhJV1hDMd/JPvACKfenccChxY0UaEw2EL51xZ5ECNB5waXXICx5f8itmkK
	 mRdOlUemv3ne8HKgylK+BKMg4oE0EEfA465YC13osOd5kRESAXcNpG9FJzI665OBnm
	 OJm9nG/e0AtlGw26Qcr5XmFtxxqezcTaHKvHShLs4jy73HwD8JCcX23bt52Hcac2ky
	 sQ7B7pgO5u/9w==
Date: Thu, 13 Mar 2025 16:54:01 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Ruiwu Chen <rwchen404@gmail.com>, 
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] drop_caches: Allow re-enabling message after disabling
Message-ID: <znixmeryizgqkb273xidczsgdh52tw3pv4ehfyoj6m2tcxycch@xal6ntp5f5mt>
References: <20250313-jag-drop_caches_msg-v1-1-c2e4e7874b72@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-jag-drop_caches_msg-v1-1-c2e4e7874b72@kernel.org>

On Thu, Mar 13, 2025 at 04:46:36PM +0100, Joel Granados wrote:
> After writing "4" to /proc/sys/vm/drop_caches there was no way to
> re-enable the drop_caches kernel message. By removing the "or" logic for
> the stfu variable in drop_cache_sysctl_handler, it is now possible to
> toggle the message on and off by setting the 4th bit in
> /proc/sys/vm/drop_caches.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>
> ---
>  Documentation/admin-guide/sysctl/vm.rst | 2 +-
>  fs/drop_caches.c                        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index f48eaa98d22d2b575f6e913f437b0d548daac3e6..75a032f8cbfb4e05f04610cca219d154bd852789 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -266,7 +266,7 @@ used::
>  	cat (1234): drop_caches: 3
>  
>  These are informational only.  They do not mean that anything is wrong
> -with your system.  To disable them, echo 4 (bit 2) into drop_caches.
> +with your system.  To toggle them, echo 4 (bit 2) into drop_caches.
>  
>  enable_soft_offline
>  ===================
> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> index d45ef541d848a73cbd19205e0111c2cab3b73617..501b9f690445e245f88cbb31a5123b2752e2e7ce 100644
> --- a/fs/drop_caches.c
> +++ b/fs/drop_caches.c
> @@ -73,7 +73,7 @@ int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
>  				current->comm, task_pid_nr(current),
>  				sysctl_drop_caches);
>  		}
> -		stfu |= sysctl_drop_caches & 4;
> +		stfu = sysctl_drop_caches & 4;
>  	}
>  	return 0;
>  }
> 
> ---
> base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
> change-id: 20250313-jag-drop_caches_msg-c4fbfedb51f3
> 
> Best regards,
> -- 
> Joel Granados <joel.granados@kernel.org>
> 
> 
In case you are curious:
This is a V3 of what was discussed in https://lore.kernel.org/20250216100514.3948-1-rwchen404@gmail.com
My bad for forgetting to tag it V3 :(.
Best


-- 

Joel Granados

