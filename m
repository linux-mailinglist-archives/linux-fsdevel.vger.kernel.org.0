Return-Path: <linux-fsdevel+bounces-40947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6159DA29758
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 18:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581BD18847F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 17:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E730D1FC0E9;
	Wed,  5 Feb 2025 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VY7TFiXV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F98149C7D;
	Wed,  5 Feb 2025 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738776587; cv=none; b=gqlHIv0YThVfZtYmw+WQsW8kPXkfNbnQzrEZeoAjaDoXqJQlH75m5opbD192Nw+9frI6WfunkxeAmB0qbkFlPumzAji8eCP/zOZbXeDVjVB9KkhY8dxPb296t3qgZC61kHkIH61fvJupjilkw5lBgSP8DplHVQpHZPnSwdLOQn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738776587; c=relaxed/simple;
	bh=dUvfndw7L5/UBHSSZYlyHuGQADUrKhytEvm18Ewp1nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASp2+56QLpzHAa/qCULcb6alKU+SccpX0a+ngZs5Jmut7WV89RHeBPsDGEvQNxZNrJHm+XBkZkgYdCtji3AX7c9tN+H55Ax2t+6ImTfSnqXkfi8yq8i4gyqwfEdf9L2562wuLdmHtGY+m3g0Aeq8vfZ7kyRcJRmJt81I/Pl90Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VY7TFiXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F685C4CED1;
	Wed,  5 Feb 2025 17:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738776586;
	bh=dUvfndw7L5/UBHSSZYlyHuGQADUrKhytEvm18Ewp1nI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VY7TFiXVojgpLBSrbx8y4Iy/mvJY9mLJ9IcxU4EUEdzR1vorpXPEPPSYSOTZGd74Z
	 xKakBhSJZIMOwaRoG99LBystvot71Gi885pkOu/5YU4vJlfkAJ/IHfHhlLPrS8XA/B
	 wwtqxGhsJ/WGLxgk3A6HspSqrEsh4L9YhDoQcnwKABPMrXjalFRMkC3mUXFAFvTdpx
	 wQ8SHvZe0RyZ56Et/jxNTtaZa6bp0G+0PEWfLN9WgzSrwz48hSebznaqu/11U2cJsU
	 P7KdyMZst7OAU+bfnyCBTADi9BQlpZ/FesU4wvVJY4zF4qEoUL3uNSyaG6nWVwDKz1
	 xQvCsJlhy6i7g==
Date: Wed, 5 Feb 2025 09:29:46 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, tytso@mit.edu, kees@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com,
	linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4: pass strlen() of the symlink instead of i_size to
 inode_set_cached_link()
Message-ID: <20250205172946.GD21791@frogsfrogsfrogs>
References: <20250205162819.380864-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205162819.380864-1-mjguzik@gmail.com>

On Wed, Feb 05, 2025 at 05:28:19PM +0100, Mateusz Guzik wrote:
> The call to nd_terminate_link() clamps the size to min(i_size,
> sizeof(ei->i_data) - 1), while the subsequent call to
> inode_set_cached_link() fails the possible update.
> 
> The kernel used to always strlen(), so do it now as well.
> 
> Reported-by: syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com
> Fixes: bae80473f7b0 ("ext4: use inode_set_cached_link()")
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> Per my comments in:
> https://lore.kernel.org/all/CAGudoHEv+Diti3r0x9VmF5ixgRVKk4trYnX_skVJNkQoTMaDHg@mail.gmail.com/#t
> 
> There is definitely a pre-existing bug in ext4 which the above happens
> to run into. I suspect the nd_terminate_link thing will disappear once
> that gets sorted out.
> 
> In the meantime the appropriate fix for 6.14 is to restore the original
> behavior of issuing strlen.
> 
> syzbot verified the issue is fixed:
> https://lore.kernel.org/linux-hardening/67a381a3.050a0220.50516.0077.GAE@google.com/T/#m340e6b52b9547ac85471a1da5980fe0a67c790ac

Again, this is evidence of inconsistent inode metadata, which should be
dealt with by returning EFSCORRUPTED, not arbitrarily truncating the
contents of a bad inode.

https://lore.kernel.org/linux-fsdevel/CAGudoHHeHKo6+R86pZTFSzAFRf2v=bc5LOGvbHmC0mCfkjRvgw@mail.gmail.com/T/#mf05b770926225812f8c78c58c6f3b707c7d151d8

To spell this out -- this is ext4_inode_is_fast_symlink:

int ext4_inode_is_fast_symlink(struct inode *inode)
{
	if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)) {
		int ea_blocks = EXT4_I(inode)->i_file_acl ?
				EXT4_CLUSTER_SIZE(inode->i_sb) >> 9 : 0;

		if (ext4_has_inline_data(inode))
			return 0;

		return (S_ISLNK(inode->i_mode) && inode->i_blocks - ea_blocks == 0);
	}
	return S_ISLNK(inode->i_mode) && inode->i_size &&
	       (inode->i_size < EXT4_N_BLOCKS * 4);
}

Note in the !EA_INODE and !inlinedata case, the decision is made based
on the block count of the file, without checking i_size.  The callsite
should look more like this:

		} else if (ext4_inode_is_fast_symlink(inode)) {
			if (inode->i_size == 0 ||
			    inode->i_size > sizeof(ei->i_data) - 1) {
				ret = -EFSCORRUPTED;
				ext4_error_inode(..."fast symlink doesn't fit in body??");
				goto bad_inode;
			}
			inode->i_op = &ext4_fast_symlink_inode_operations;
			nd_terminate_link(ei->i_data, inode->i_size,
				sizeof(ei->i_data) - 1);
			inode_set_cached_link(inode, (char *)ei->i_data,
					      inode->i_size);
		} else {

And, seriously, cc the ext4 list on ext4 patches please.

--D

>  fs/ext4/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 7c54ae5fcbd4..30cff983e601 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5010,7 +5010,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  			nd_terminate_link(ei->i_data, inode->i_size,
>  				sizeof(ei->i_data) - 1);
>  			inode_set_cached_link(inode, (char *)ei->i_data,
> -					      inode->i_size);
> +					      strlen((char *)ei->i_data));
>  		} else {
>  			inode->i_op = &ext4_symlink_inode_operations;
>  		}
> -- 
> 2.43.0
> 
> 

