Return-Path: <linux-fsdevel+bounces-60892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF67B52944
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 08:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4336801CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 06:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2A0235072;
	Thu, 11 Sep 2025 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="liA0bLaX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E80239E81
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 06:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757573584; cv=none; b=D+WPJyMWEAAxktGew47NYAzuNPsr3K3+rYWPeYA8CJX3DMuLszJbE1EIF2XAEG3dlwSwCELmRtSERwY7VEqXhZ22NOtteMUJZqnOtKfESaWe9jj4vxXRhJhD7fQP8kpe59NUmOWGktAsl+VOqF+Xl/GuuGpd3fH6Mtz5qDckSIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757573584; c=relaxed/simple;
	bh=MosfAOPXggOaMXmK1NE1OB2KAznkuBaD9gE8puz8LQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNjxngR8VLHdgFgGJlvCrxsF84TdyJL0MeUIrSqlk1GwYQ1XycSdMSJvvpLukCEnQwgA3sqU5xFD5vbShwHa+hs7AMEWqliUYT1KWld++k9oQgXJjzGTRiPUzkHt7gk5IsFlKBMRGl4dH5XcpbSeXCKnIxVNoIGXACb4i5c0+VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=liA0bLaX; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7726c7ff7e5so338808b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 23:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1757573581; x=1758178381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GmZdHMjW2ierOJlMW2a8YzsyJfuW1roryoxn9+9Fw3c=;
        b=liA0bLaX+joYazF+rBZL5B5lAGkvvl6Flwzx7mbFtKhxg4nhURdpf9BXcSj72R2fDH
         EG7cCWYeuHH7xp2s4XEwqPF+ol+Npt+llfkGNBN2OW6dqMxN2Ei8DbTj+dKJg3pVmo1q
         SxWOSGK6wgVJhPwjDELYH2WZ9EBV+JO9GUIedMSKs4FmmQx+csm3dB6BcIA3C4ehYiKt
         ynTmysU3oVBh9ITHWs31RgRocOAn9BdN61hht8XwMMdp7QEArWp8pAq/oHbT50HAIJOQ
         cILKNzanuM7rMoX6T1VcLOfosUPwjPCsRtlrTb0sylGxi/i26xnomE3tpR85MYmi46Lo
         /Klw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757573581; x=1758178381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmZdHMjW2ierOJlMW2a8YzsyJfuW1roryoxn9+9Fw3c=;
        b=eGrQWfJM+3rnUyEXCkZW4rfr7y/zedQAsvDtVlFdgNYIEwh/QwRAwEkTMC8Cwe1iD5
         nmIVgMMtusHflc7ZPINnwIkWu6Vc5iUm3y6Rb47O40jwOw/GCWQwAu8gh5XIRf0Ygaqr
         Od+vzwzs3MYOEQpIZblm8nYhGp93sVHG2140+whcT0p6zbCD9sqyLmPAxZGlv+3iRgF1
         8DtmcTbs2SE7Fwd4hXfYkh3SJZVxFs3VBOFVw7+DeGSqIwdl6Kk2PN+U3wIpi06sgJOp
         lOhI2CuGv/J7oc+pi5GDyp8nhzkUqSi6KPweZtGqsqFsYwX8nkQkCBuwCc6tx9GHASLk
         zRgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3XvthDdxGrCzJfbW6qJukXCrM6Rlwwd0x5odIL2LuOE5zn54bD8eiPySzZPTeCAeqQqtX4O8RpA67SDJA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2OSr9laSUJ8+u4vcHehY9MA6ZacIQ9t2v2tYgC6Els7u5guNd
	YqQI+PY7WYvOhV4g48atLjJnd+8+BFwppZ2UTi80ed6gHBIKfbD48VUPKGNxDGoxbN8=
X-Gm-Gg: ASbGncsVUbaEVROLdLbZaAXaLn/u8XJxcRRz9LRDfocZ5vvucXLTpo5ElIUUyZ6t27r
	9BABFYS9WBF5Ldi3R7Vlytjwf7SkXQeDX7dNfXdv41/NdBg+kVzuKcvBG2uqmet4r2goJqWVQr9
	ShYhntb/CQXKZHAg49rjhrE/tyhkGTPcL/D3Rh2+ZavCPrUmDaoIBIXbpE2mCJRrOO57evA3Hpw
	4VYHQxv4sE1Y7dn5RSx2FWDv0XqZzoIKiacS8vcD7bQFXkb8Ee00oTHH1/tQooEn4CyC3UokwGt
	sW48v069xWvN1uYZpq9ZcevWOKUcqej80hbiHhLXKea4/mvujZK32izDtDtjhdcF3lfBfLLpNjJ
	cABiqEW0OH+19JvZB9xcLty415zLzgM1bXZeYTfQxBQ7T0QHPioOPZQvs/aFjqiR5PQVC8uBkHV
	vIXlslrq97
X-Google-Smtp-Source: AGHT+IGasaLzOYam5A1QsgyXdSjCVIvWR7XOAwof9JLu91tc4jZXAZZcaQdzlfPlVrkI/CXhO/i++w==
X-Received: by 2002:a05:6a21:6d9f:b0:248:4d59:93dd with SMTP id adf61e73a8af0-2534640cda7mr22645053637.52.1757573581062;
        Wed, 10 Sep 2025 23:53:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a387b5c5sm835488a12.34.2025.09.10.23.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 23:53:00 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uwbAv-00000000RJK-3hpp;
	Thu, 11 Sep 2025 16:52:57 +1000
Date: Thu, 11 Sep 2025 16:52:57 +1000
From: Dave Chinner <david@fromorbit.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ocfs2-devel@lists.linux.dev
Subject: Re: [PATCH v3 2/4] fs: hide ->i_state handling behind accessors
Message-ID: <aMJxydmz_azN7Kce@dread.disaster.area>
References: <20250911045557.1552002-1-mjguzik@gmail.com>
 <20250911045557.1552002-3-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911045557.1552002-3-mjguzik@gmail.com>

On Thu, Sep 11, 2025 at 06:55:55AM +0200, Mateusz Guzik wrote:
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

So why did you choose these specific wrapper functions?

Some commentary on why you choose this specific API would be very
useful here.

> ---
>  block/bdev.c                     |   4 +-
>  drivers/dax/super.c              |   2 +-
>  fs/buffer.c                      |   4 +-
>  fs/crypto/keyring.c              |   2 +-
>  fs/crypto/keysetup.c             |   2 +-
>  fs/dcache.c                      |   8 +-
>  fs/drop_caches.c                 |   2 +-
>  fs/fs-writeback.c                | 123 ++++++++++++++++---------------
>  fs/inode.c                       | 103 +++++++++++++-------------
>  fs/libfs.c                       |   6 +-
>  fs/namei.c                       |   8 +-
>  fs/notify/fsnotify.c             |   2 +-
>  fs/pipe.c                        |   2 +-
>  fs/quota/dquot.c                 |   2 +-
>  fs/sync.c                        |   2 +-
>  include/linux/backing-dev.h      |   5 +-
>  include/linux/fs.h               |  55 +++++++++++++-
>  include/linux/writeback.h        |   4 +-
>  include/trace/events/writeback.h |   8 +-
>  mm/backing-dev.c                 |   2 +-
>  security/landlock/fs.c           |   2 +-
>  21 files changed, 198 insertions(+), 150 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index b77ddd12dc06..77f04042ac67 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -67,7 +67,7 @@ static void bdev_write_inode(struct block_device *bdev)
>  	int ret;
>  
>  	spin_lock(&inode->i_lock);
> -	while (inode->i_state & I_DIRTY) {
> +	while (inode_state_read(inode) & I_DIRTY) {
>  		spin_unlock(&inode->i_lock);
>  		ret = write_inode_now(inode, true);
>  		if (ret)

This isn't an improvement.

It makes the code harder to read, and now I have to go look at the
implementation of a set of helper functions to determine if that's
the right helper to use for the context the code is operating in.

What would be an improvement is making all the state flags disappear
behind the same flag APIs as other high level objects that
filesystems interface with. e.g. folio flags use
folio_test.../folio_set.../folio_clear...

Looking wider, at least XFS, ext4 and btrfs use these same
set/test/clear flag APIs for feature and mount option flags. XFS
also uses them for oeprational state in mount, journal and per-ag
structures, etc. It's a pretty common pattern.

Using it for the inode state flags would lead to code like this:

	spin_lock(&inode->i_lock);
	while (inode_test_dirty(inode)) {
	.....

That's far cleaner and easier to understand and use than an API that
explicitly encodes the locking context of the specific access being
made in the helper names.

IOWs, the above I_DIRTY flag ends up with a set of wrappers that
look like:

bool inode_test_dirty_unlocked(struct inode *inode)
{
	return inode->i_state & I_DIRTY;
}

bool inode_test_dirty(struct inode *inode)
{
	lockdep_assert_held(&inode->i_lock);
	return inode_test_dirty_unlocked(inode);
}

void inode_set_dirty(struct inode *inode)
{
	lockdep_assert_held(&inode->i_lock);
	inode->i_state |= I_DIRTY;
}

void inode_clear_dirty(struct inode *inode)
{
	lockdep_assert_held(&inode->i_lock);
	inode->i_state &= ~I_DIRTY;
}

With this, almost no callers need to know about the I_DIRTY flag -
direct use of it is a red flag and/or an exceptional case.  It's
self documenting that it is an exceptional case, and it better have
a comment explaining why it is safe....

This also gives us the necessary lockdep checks to ensure the right
locks are held when modifications are being made.

And best of all, the wrappers can be generated by macros; they don't
need to be directly coded and maintained.

Yes, we have compound state checks, but like page-flags.h we can
manually implement those few special cases such as this one:

> @@ -1265,7 +1265,7 @@ void sync_bdevs(bool wait)
>  		struct block_device *bdev;
>  
>  		spin_lock(&inode->i_lock);
> -		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW) ||
> +		if (inode_state_read(inode) & (I_FREEING|I_WILL_FREE|I_NEW) ||

-		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW) ||
+		if (inode_test_new_or_freeing(inode)) ||

bool inode_test_new_or_freeing(struct inode *inode)
{
	lockdep_assert_held(&inode->i_lock);
	return inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW);
}

Or if we want to avoid directly using flags in these wrappers,
we write them like this:

bool inode_test_new_or_freeing(struct inode *inode)
{
	return inode_test_freeing(inode) ||
		inode_test_will_free(inode) ||
		inode_test_new(inode);
}

Writing the compound wrappers this way then allows future
improvements such as changing the state flags to atomic bitops so
we can remove all the dependencies on holding inode->i_lock to
manipulate state flags safely.

Hence I think moving the state flags behind an API similar to folio
state flags makes the code easier to read and use correctly, whilst
also providing the checking that the correct locks are held at the
correct times. It also makes it  easier to further improve the
implementation in future because all the users of the API are
completely isolated from the implmentation....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

