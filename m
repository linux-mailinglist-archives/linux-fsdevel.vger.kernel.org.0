Return-Path: <linux-fsdevel+bounces-71260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 009B7CBB5EA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 03:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E570E300D4A0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 02:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA5F2D29D6;
	Sun, 14 Dec 2025 02:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Djc2CE/3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AE5155A5D;
	Sun, 14 Dec 2025 02:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765677703; cv=none; b=g0Ran+hDAzkEUStq6E5jPReGNePFdEpxzIOjwddvPYo0hpPVy3EyBCsyvXo6meozfwP0Erqsa+Edo3C/I+2L8XoajM9/A12ffS8flU37/oNDmAOBw8RbiXBSe/PTyN7vroxXb/B/QSTLWjO+HkyzJhMSvz8w66PBYiBpnGEI7iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765677703; c=relaxed/simple;
	bh=Fntz3N6a+yCAHVlhe5sPHCt93FGF0GGV0+eMEQvLpVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EARmKX8rqsFLYqdhlOa0Zq0JyNTirBtODk2eB7qGnjtnKxCql1++a2Jy9OG//9XYi290dkv30cxwQbaflmJVoXfJ66ChvwCcJGTh8k+IqIAXpuYDgi6MNhJMeTGhd8ehvQPlVlljVxXY+n9u7AAD7QiwWIXAKLM3pcxU+BLT6w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Djc2CE/3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RZncDv56SSpPSHUKAMFKDJBm5cqzsvZg+ctZP4rGIT0=; b=Djc2CE/3OX9aSwLomy3jOUmDog
	19f710WRYxXoUiGlzHjGoMjJaRrFd3SMjCOw/axKi1XZza1MoIiSOPN5naQxkzAtqjgWH4V1f48bh
	z1EhQWHiurQ+zSY5iq0W59ojItR7BiQHcyHJcf85xWiipoyNG+Me/zQX/lizLUf1DK6Helfn+NUGf
	DwacBZH8Tc/2w4Pd3jbinCRq6wxswOWphnATKJND2uFe2Ow75r1MxO4Lu4kBvid8S0mMS0qWBdTiV
	z9P/sgxknqYc/+Ek9PTZcCwgtzavR+U5s8R7TtQb+XXEMkuqKbEVQZ4ywSiB9db4cYd5/LmL8u7DR
	cDMif4Nw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vUbR6-000000010D2-1t2X;
	Sun, 14 Dec 2025 02:02:12 +0000
Date: Sun, 14 Dec 2025 02:02:12 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ahmet Eray Karadag <eraykrdg1@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	syzbot+1c70732df5fd4f0e4fbb@syzkaller.appspotmail.com
Subject: Re: [PATCH] adfs: fix memory leak in sb->s_fs_info
Message-ID: <20251214020212.GJ1712166@ZenIV>
References: <20251213233621.151496-2-eraykrdg1@gmail.com>
 <20251214013249.GI1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214013249.GI1712166@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Dec 14, 2025 at 01:32:49AM +0000, Al Viro wrote:

> Question: if that thing is leaking all the time, why hadn't that been caught
> earlier?
> 
> Question: does it really leak all the time?  How would one check that?
> 
> Question: if it does not leak in each and every case, presumably the damn thing
> does get freed at some point; where would that be?
> 
> Question: would we, by any chance, run into a double-free with that "fix"?
> 
> 
> Please, do yourself a favour and find answers to the questions above.
> They are fairly trivial and it is the kind of exercise one has to do every
> time when dealing with something of that sort.

<spoiler alert>



A trivial experiment would be to mount a valid image, unmount it and see
if anything has leaked.  Finding a valid image is not hard - the second
hit when googling for "ADFS image acorn" is a github-hosted project
and right in there there's a directory called "ADFS Test Images", with
expected contents.  Whether it's legitimate or not, mounting it in a kernel
that runs under unpriveleged qemu ought to be safe enough.

And no, it doesn't leak on mount + umount

Looking for places where it could be freed in normal operation is also
not terribly hard - looking for kfree() in fs/adfs/super.c catches three
hits:

1) in adfs_put_super() we see
	struct adfs_sb_info *asb = ADFS_SB(sb);
	adfs_free_map(sb);
	kfree_rcu(asb, rcu);

2) in the end of adfs_fill_super() there's
error:
        sb->s_fs_info = NULL;
        kfree(asb);
        return ret;

3) in adfs_free_fc() we have
        struct adfs_context *asb = fc->s_fs_info;
        kfree(asb);

#2 and #3 are obviously irrelevant for the case of normal mount + umount -
adfs_fill_super() has already run at mount time (and did not hit error:)
and so did adfs_free_fc().

So we have #1 to look into.  adfs_put_super() is never called directly and
it's only reached as a member of struct super_operations adfs_sops -
something called 'put_super'.  Where would that method be called?

grep and you shall find it:
void generic_shutdown_super(struct super_block *sb)
{
        const struct super_operations *sop = sb->s_op;
 
        if (sb->s_root) {
		...
                if (sop->put_super)
                        sop->put_super(sb);

So it is called by generic_shutdown_super() in case if ->s_root had not
been NULL.  Looking for callers of generic_shutdown_super() immediately
catches
void kill_block_super(struct super_block *sb)
{
        struct block_device *bdev = sb->s_bdev;
 
        generic_shutdown_super(sb);
        if (bdev) {
                sync_blockdev(bdev);
                bdev_fput(sb->s_bdev_file);
        }
}
so it is called by adfs ->kill_sb() - both the current mainline and with
that patch.

IOW, there's our double-free.  For extra fun, it's not just kfree() + kfree(),
it's kfree_rcu() + kfree().

