Return-Path: <linux-fsdevel+bounces-45086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F72A7181F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 15:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E223BA96D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 14:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C501F09B6;
	Wed, 26 Mar 2025 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXBzmOFU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9282918EB0;
	Wed, 26 Mar 2025 14:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742998173; cv=none; b=Lv4CZz1f0Boty050vk+LzngbJfHXJ9kQODKDuvhJ6VP4tlId10+DVh4fqXeYbRJ9g7R1rMP1qBUis1QnfosQkakcMsasOivJOluqxGsHIO83c+dO72Nr/UchA0cYRmtCK/6Ltr+zF8xIt1OyBA50xi18mDQBZ09PZjiEb0cNYJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742998173; c=relaxed/simple;
	bh=FSOumSpVRhnq8fGHRsWzvox4kopjt7In8JRuzp6ndFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEtJbUgpRChcHUc8EebtktiLqW7PMjaSHgXkKVI7RDY8IUVV2aLjWPxU0fmr9Ef/J15hNQtghlvUs+JXrhhAx6MnLnJngSMo1FcV8xAgNVZN9uqNRNTEPMa4dHJ+EviHv0FPa8kxl9d4oalmsgdkdhvoPDFw6SnzjG8qWdgsc0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXBzmOFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7301C4CEE2;
	Wed, 26 Mar 2025 14:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742998173;
	bh=FSOumSpVRhnq8fGHRsWzvox4kopjt7In8JRuzp6ndFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BXBzmOFUR3LEoBqvb4sSfmlEaTxaSZjaMhi68DJCV0IX0NCxCH8QstXwUY0pQ6kjr
	 P/Fw2CeJ87thzb+X+1z7JH+IH5qnxbKb3lCPO5CcVn5f/Tz5Vy/RpNIm/DkKZs1sF4
	 wa7mEc+Jx6JegU+CmQ88tEp8SLQ3dUQgEEfga0ORbTL3M4rMGz3zkmtaHhVYrT08ET
	 zXSVHjQC5U3RoKVv4mhHbIvbzX5XJ6g0iIFov+Ugw75W2kbE+t6b4G2VtJpm7lh58b
	 13IYrXCle8F9A+EXghbWtbIqg6iMauisWdg+Gw2+TOir3L57JesT6aQLbVKnqRAsHe
	 I2uQ0SjxySMzA==
Date: Wed, 26 Mar 2025 15:09:30 +0100
From: Christian Brauner <brauner@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Luis Chamberlain <mcgrof@kernel.org>
Cc: jack@suse.cz, hch@infradead.org, david@fromorbit.com, 
	rafael@kernel.org, djwong@kernel.org, pavel@kernel.org, song@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 3/6] fs: add automatic kernel fs freeze / thaw and remove
 kthread freezing
Message-ID: <20250326-hochnehmen-hiebe-99baf5409aa2@brauner>
References: <20250326112220.1988619-1-mcgrof@kernel.org>
 <20250326112220.1988619-4-mcgrof@kernel.org>
 <827c1ff030dd3b208e7a14be63160703b67e7031.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <827c1ff030dd3b208e7a14be63160703b67e7031.camel@HansenPartnership.com>

On Wed, Mar 26, 2025 at 07:53:10AM -0400, James Bottomley wrote:
> On Wed, 2025-03-26 at 04:22 -0700, Luis Chamberlain wrote:
> > Add support to automatically handle freezing and thawing filesystems
> > during the kernel's suspend/resume cycle.
> > 
> > This is needed so that we properly really stop IO in flight without
> > races after userspace has been frozen. Without this we rely on
> > kthread freezing and its semantics are loose and error prone.
> > For instance, even though a kthread may use try_to_freeze() and end
> > up being frozen we have no way of being sure that everything that
> > has been spawned asynchronously from it (such as timers) have also
> > been stopped as well.
> > 
> > A long term advantage of also adding filesystem freeze / thawing
> > supporting during suspend / hibernation is that long term we may
> > be able to eventually drop the kernel's thread freezing completely
> > as it was originally added to stop disk IO in flight as we hibernate
> > or suspend.
> > 
> > This does not remove the superfluous freezer calls on all
> > filesystems.
> > Each filesystem must remove all the kthread freezer stuff and peg
> > the fs_type flags as supporting auto-freezing with the FS_AUTOFREEZE
> > flag.
> > 
> > Subsequent patches remove the kthread freezer usage from each
> > filesystem, one at a time to make all this work bisectable.
> > Once all filesystems remove the usage of the kthread freezer we
> > can remove the FS_AUTOFREEZE flag.
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  fs/super.c             | 50
> > ++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/fs.h     | 14 ++++++++++++
> >  kernel/power/process.c | 15 ++++++++++++-
> >  3 files changed, 78 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/super.c b/fs/super.c
> > index 9995546cf159..7428f0b2251c 100644
> > --- a/fs/super.c
> > +++ b/fs/super.c
> > @@ -2279,3 +2279,53 @@ int sb_init_dio_done_wq(struct super_block
> > *sb)
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(sb_init_dio_done_wq);
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static bool super_should_freeze(struct super_block *sb)
> > +{
> > +	if (!(sb->s_type->fs_flags & FS_AUTOFREEZE))
> > +		return false;
> > +	/*
> > +	 * We don't freeze virtual filesystems, we skip those
> > filesystems with
> > +	 * no backing device.
> > +	 */
> > +	if (sb->s_bdi == &noop_backing_dev_info)
> > +		return false;
> 
> 
> This logic won't work for me because efivarfs is a pseudofilesystem and
> will have a noop bdi (or simply a null s_bdev, which is easier to check
> for).  I was thinking of allowing freeze/thaw to continue for a s_bdev
> == NULL filesystem if it provided a freeze or thaw callback, which will
> cover efivarfs.

Filesystem freezing isn't dependent on backing devices. I'm not sure
where that impression comes from. The FS_AUTOFREEZE shouldn't be
necessary once all filesystems have been fixed up (which I guess this is
about). The logic should just be similar to what we do for the freeze
ioctl.

IOW, we skip filesystems without any freeze method. That excludes any fs
that isn't prepared to be frozen:

The easiest way is very likely to give efivarfs a ->freeze_super() and
->thaw_super() method since it likely doesn't all of the fanciness that
freeze_super() adds.

Then we have two approaches:

(1) Change the iterator to take a reference while holding the super_lock() and
    then calling a helper to freeze the fs.
(2) Pass the information that s_umount is held down to the freeze methods.

For example (2) would be something like:

diff --git a/include/linux/fs.h b/include/linux/fs.h
index be3ad155ec9f..7ad515ad6934 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2272,6 +2272,7 @@ enum freeze_holder {
        FREEZE_HOLDER_KERNEL    = (1U << 0),
        FREEZE_HOLDER_USERSPACE = (1U << 1),
        FREEZE_MAY_NEST         = (1U << 2),
+       FREEZE_SUPER_LOCKED     = (1U << 3),
 };

 struct super_operations {

static int freeze_super_locked(struct file *filp)
{
	/* If filesystem doesn't support freeze feature, return. */
	if (sb->s_op->freeze_fs == NULL && sb->s_op->freeze_super == NULL)
		return 0;

	if (sb->s_op->freeze_super)
		return sb->s_op->freeze_super(sb, FREEZE_HOLDER_KERNEL | FREEZE_SUPER_LOCKED);
	return freeze_super(sb, FREEZE_HOLDER_KERNEL | FREEZE_SUPER_LOCKED);
}

Why do you care about efivarfs taking part in system suspend though?

> 
> > +
> > +	return true;
> > +}
> > +
> > +int fs_suspend_freeze_sb(struct super_block *sb, void *priv)
> > +{
> > +	int error = 0;
> > +
> > +	if (!super_should_freeze(sb))
> > +		goto out;
> > +
> > +	pr_info("%s (%s): freezing\n", sb->s_type->name, sb->s_id);
> > +
> > +	error = freeze_super(sb, false);
> 
> This is actually not wholly correct now.  If the fs provides a sb-
> >freeze() method, you should use that instead of freeze_super() ... see
> how fs_bdev_freeze() is doing it.

> 
> Additionally, the first thing freeze_super() does is take the
> superblock lock exclusively.  Since you've already taken it exclusively
> in your iterate super, how does this not deadlock?

It will deadlock.

