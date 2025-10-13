Return-Path: <linux-fsdevel+bounces-63925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B61B7BD1E28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 09:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07FBD189828A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 07:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B342EB5CB;
	Mon, 13 Oct 2025 07:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6gq+hjH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E123246778;
	Mon, 13 Oct 2025 07:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342156; cv=none; b=g0Dj9zrasJgC3zGWpf4mHC9Up99+Z5tRj35UiM0hUGy1igm0LdWFRCODPegPa9mgReYAHZcFNJv7cQ80QbBSyoUYwaiCxMFbk1uJyXPSsos338M0GXEc4P5JDYzsTj4mzO7WMrtZfywZG+tzw0oEntmFC5yNaXD46xF8fPmmR84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342156; c=relaxed/simple;
	bh=mgqubBXmcDUB0Vocd771Uy113a9CMlT/bu1FmLbtKOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fI13ZsQOwG42j5kvH/gA6BORXE46r0hIs35UkbgDF43WZTNIv/2R6Dks6I8rQgSvs1aRMBQZv/W3bDV7CVxCqbdaVxF9vmTsWs3Fjz6D0jzR9m76iyUztbrNAu4tUtRBB7Sdy5iLS573gXRw0R49B30dDVIZyIkXZEegfBVUHxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6gq+hjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233C0C4CEE7;
	Mon, 13 Oct 2025 07:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760342155;
	bh=mgqubBXmcDUB0Vocd771Uy113a9CMlT/bu1FmLbtKOo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N6gq+hjHSCsbUKZZjniwkCj7yvgxSN3jmQu09ii02JLpjVZZaG1+SqSfGTa2PeQ9x
	 R7zyxn85U6fWuqA2AB23LvwxslESlaO5wo5K7hZ/gvYDn+OVkG2vUNL9ufHlCEsvAV
	 q+hC/o+wKMQWBb5bcyxqJh1BetJEcjhid1m9y7HnLAFbp3G+xhhZ23Cnl4l4WWHD76
	 V2jEgIkBRxE3s9Xn3yq02N9b78hjJl85DrFjOxiO8abK6gSh0CQMZ79HAaVzGzOwvD
	 XLcWUDUdyi4nGwosNspIhk/cPOcSTvepUqz9oxzPF3sdkl9nM8rHgA74VUSGFn9FSG
	 Fj7T8n4JaMxlQ==
Message-ID: <65aad714-3f1d-4f4b-bb8f-6f751ff756b7@kernel.org>
Date: Mon, 13 Oct 2025 16:55:50 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] btrfs: push struct writeback_control into
 start_delalloc_inodes
To: Christoph Hellwig <hch@lst.de>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, v9fs@lists.linux.dev,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org
References: <20251013025808.4111128-1-hch@lst.de>
 <20251013025808.4111128-6-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251013025808.4111128-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/10/13 11:58, Christoph Hellwig wrote:
> In preparation for changing the filemap_fdatawrite_wbc API to not expose
> the writeback_control to the callers, push the wbc declaration next to
> the filemap_fdatawrite_wbc call and just pass thr nr_to_write value to

s/thr/the

> start_delalloc_inodes.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

...

> @@ -8831,9 +8821,10 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
>  			       &fs_info->delalloc_roots);
>  		spin_unlock(&fs_info->delalloc_root_lock);
>  
> -		ret = start_delalloc_inodes(root, &wbc, false, in_reclaim_context);
> +		ret = start_delalloc_inodes(root, nr_to_write, false,
> +				in_reclaim_context);
>  		btrfs_put_root(root);
> -		if (ret < 0 || wbc.nr_to_write <= 0)
> +		if (ret < 0 || nr <= 0)

Before this change, wbc.nr_to_write will indicate what's remaining, not what you
asked for. So I think you need a change like you did in start_delalloc_inodes(),
no ?

>  			goto out;
>  		spin_lock(&fs_info->delalloc_root_lock);
>  	}


-- 
Damien Le Moal
Western Digital Research

