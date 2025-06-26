Return-Path: <linux-fsdevel+bounces-53070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033CEAE99F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 11:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F506A29DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 09:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FF929E11B;
	Thu, 26 Jun 2025 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBQ3HrRE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8E3214818;
	Thu, 26 Jun 2025 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750930155; cv=none; b=bXhIFuiRjy7wnKq77ioQW5Q3s0F4+uZfuRlA0PUqMN2NbnW4aKPwnb9UmTzpFWbA7a7E6O1PIqRld5Klwsm76rvsagEBDHYtVSSVWqqnliSOcIL5sgskiGve6YMSS0tkdrveg2bVY/iresurKQrBzLxtjO0i1wNqPKFpcmuXGDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750930155; c=relaxed/simple;
	bh=PD5+lWiwUKUoVzp1c8CPPO5V2Tfa57IqQuGDY4SHcv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bi+DqXrMfNH+Ssa65Pq3Qxo/NRJmILxmunlYHT5Crd919QTbQ0QNszbWfPxle5QXW8UpmQ6CqIhcDneTNi43OZe+5mfTfCyS0t0kjzBOet5e3EBUAPptmhpH4DSd+ZChSDg3b58aaouy/UpOJmbnXf63kb4rIu1GrTh5LqotWKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBQ3HrRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14279C4CEEB;
	Thu, 26 Jun 2025 09:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750930154;
	bh=PD5+lWiwUKUoVzp1c8CPPO5V2Tfa57IqQuGDY4SHcv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XBQ3HrRE1tTGcH50yD1mkGb+xUJGIWZWWnxrqfyobfsw0Ozau4VhhprA7fq/Jz+Z7
	 Magv9LBwcjJFK2fvyekJezlE/wdebKgBw7u1eZ8DuQtaN1w5sRIl+ZIM/pIqYI6lC/
	 mpmZGQoyrctNBIMK/A6VkmcfmUnPmBj6lkWILerQV1DVAEXElC86dkmSZFwG4q8IxL
	 d1T9BAl//vAmPLPCMkiy+xv891ApiU/8xCXW5HSH30sNT9xyo20aXD+xldNJqPwu0a
	 LbQqyUWLu8kZXYfTO7+RDKEHqYxQg3KNkqaKroBI2Xxj97bSQuA58EJEa63H02Tyn6
	 zegpw8H5rLuxg==
Date: Thu, 26 Jun 2025 11:29:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz
Subject: Re: [PATCH 1/6] fs: add a new remove_bdev() super operations callback
Message-ID: <20250626-bekriegen-mitbekommen-997feffba3c4@brauner>
References: <cover.1750895337.git.wqu@suse.com>
 <c8853ae1710df330e600a02efe629a3b196dde88.1750895337.git.wqu@suse.com>
 <20250626-schildern-flutlicht-36fa57d43570@brauner>
 <e8709e52-5a64-470e-922f-c026190fcd91@suse.com>
 <20250626-fazit-neubau-ef77346c5d8b@brauner>
 <fd3d7d4a-ebad-4ec2-8a9b-4bf783034a05@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd3d7d4a-ebad-4ec2-8a9b-4bf783034a05@suse.com>

On Thu, Jun 26, 2025 at 06:48:29PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/6/26 18:40, Christian Brauner 写道:
> > On Thu, Jun 26, 2025 at 06:14:03PM +0930, Qu Wenruo wrote:
> > > 
> > > 
> > > 在 2025/6/26 18:08, Christian Brauner 写道:
> > > > On Thu, Jun 26, 2025 at 09:23:42AM +0930, Qu Wenruo wrote:
> > > > > The new remove_bdev() call back is mostly for multi-device filesystems
> > > > > to handle device removal.
> > > > > 
> > > > > Some multi-devices filesystems like btrfs can have the ability to handle
> > > > > device lose according to the setup (e.g. all chunks have extra mirrors),
> > > > > thus losing a block device will not interrupt the normal operations.
> > > > > 
> > > > > Btrfs will soon implement this call back by:
> > > > > 
> > > > > - Automatically degrade the fs if read-write operations can be
> > > > >     maintained
> > > > > 
> > > > > - Shutdown the fs if read-write operations can not be maintained
> > > > > 
> > > > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > > > ---
> > > > >    fs/super.c         |  4 +++-
> > > > >    include/linux/fs.h | 18 ++++++++++++++++++
> > > > >    2 files changed, 21 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/fs/super.c b/fs/super.c
> > > > > index 80418ca8e215..07845d2f9ec4 100644
> > > > > --- a/fs/super.c
> > > > > +++ b/fs/super.c
> > > > > @@ -1463,7 +1463,9 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
> > > > >    		sync_filesystem(sb);
> > > > >    	shrink_dcache_sb(sb);
> > > > >    	evict_inodes(sb);
> > > > > -	if (sb->s_op->shutdown)
> > > > > +	if (sb->s_op->remove_bdev)
> > > > > +		sb->s_op->remove_bdev(sb, bdev, surprise);
> > > > > +	else if (sb->s_op->shutdown)
> > > > >    		sb->s_op->shutdown(sb);
> > > > 
> > > > This makes ->remove_bdev() and ->shutdown() mutually exclusive. I really
> > > > really dislike this pattern. It introduces the possibility that a
> > > > filesystem accidently implement both variants and assumes both are
> > > > somehow called. That can be solved by an assert at superblock initation
> > > > time but it's still nasty.
> > > > 
> > > > The other thing is that this just reeks of being the wrong api. We
> > > > should absolutely aim for the methods to not be mutually exclusive. I
> > > > hate that with a passion. That's just an ugly api and I want to have as
> > > > little of that as possible in our code.
> > > 
> > > So what do you really want?
> > > 
> > > The original path to expand the shutdown() callback is rejected, and now the
> > > new callback is also rejected.
> > > 
> > > I guess the only thing left is to rename shutdown() to remove_bdev(), add
> > > the new parameters and keep existing fses doing what they do (aka,
> > > shutdown)?
> > 
> > Yes. My original understanding had been that ->remove_bdev() would be
> > called in a different codepath than ->shutdown() and they would be
> > complimentary. So sorry for the back and forth here. If that's not the
> > case I don't see any point in having two distinct methods.
> 
> That's fine, just want to do a final confirmation that everyone is fine with
> such change:
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b085f161ed22..c11b9219863b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2367,7 +2367,8 @@ struct super_operations {
>                                   struct shrink_control *);
>         long (*free_cached_objects)(struct super_block *,
>                                     struct shrink_control *);
> -       void (*shutdown)(struct super_block *sb);
> +       void (*remove_bdev)(struct super_block *sb, struct block_device
> *bdev,
> +                           bool surprise);
>  };

This looks good to me!

