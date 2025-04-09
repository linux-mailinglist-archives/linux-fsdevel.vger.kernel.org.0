Return-Path: <linux-fsdevel+bounces-46030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A23A819FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 02:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4893AEB18
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 00:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED80086337;
	Wed,  9 Apr 2025 00:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nycfs46B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3FE42AB0;
	Wed,  9 Apr 2025 00:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744159318; cv=none; b=Riv4U1RbssNGXj+bERHGbfQFHxmY2cH+EfBE/i3AqVy9dZxtUJVmPmT5Ws26i4tlmRZUAUSKGfEsFSIMAjm+Azv8O6VSj97Jars4wtUigih/gh+qlufeSfwD/cxgt8fxe5nhxtw6/2YDH3U9lRmWvRQA9v3Cl0bq/52t/dCUL5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744159318; c=relaxed/simple;
	bh=Uma3C9lzYk3Qgb36Cpb4H7tai9k/9PKyqCouIVsRh/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEFEvjV6/VVCsTyyfE7+5HZPUWcl/G/0dTQs77dD5zJBgyTYpXtncdMyU6Nx6Wd9G+l8GYcQXe1DJlxl8SFT3EOOOZ1IRFLMOcEnk743WPmjygwqr7WrG2x4y0PtXVWXnQJG78WOIDNC/0fD1oKCIz+W3mDXeAvqt5IY0QZD6lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nycfs46B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2845C4CEE5;
	Wed,  9 Apr 2025 00:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744159316;
	bh=Uma3C9lzYk3Qgb36Cpb4H7tai9k/9PKyqCouIVsRh/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nycfs46BHgyP4yQNIdyzteAOP+LEDlExGT1e7ipqvzHCgfZZkvu+kU8Zvxa5PGgID
	 a7G7bqulNrKcvOr/dX1RYGBeO53FDg8olu85tvR9k461oM/8G0IDxPs1Hybsku/Aw2
	 atcnVZNl1rQmnatCxLqQDxtH0JCnc4EfDI/sBRUQHSOgoXV6p9Evt474oryNHb2f+q
	 zqwaNQab3cC3fQDlThE8VloiYPLi9MbxCh7juHxZrYYrBzpppTxcabAbQR/N2CG9pf
	 YDsoagQn/NryQNOs3Ux1f3WtkOJLvuaB3hbNBPCKXniaNCsq6RRX+MCR5ng2d2r+1h
	 tWXuYDo93jaBw==
Date: Tue, 8 Apr 2025 17:41:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org, hch@lst.de,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v6 11/12] xfs: add xfs_compute_atomic_write_unit_max()
Message-ID: <20250409004156.GL6307@frogsfrogsfrogs>
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
 <20250408104209.1852036-12-john.g.garry@oracle.com>
 <Z_WnbfRhKR6RQsSA@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_WnbfRhKR6RQsSA@dread.disaster.area>

On Wed, Apr 09, 2025 at 08:47:09AM +1000, Dave Chinner wrote:
> On Tue, Apr 08, 2025 at 10:42:08AM +0000, John Garry wrote:
> > Now that CoW-based atomic writes are supported, update the max size of an
> > atomic write for the data device.
> > 
> > The limit of a CoW-based atomic write will be the limit of the number of
> > logitems which can fit into a single transaction.
> 
> I still think this is the wrong way to define the maximum
> size of a COW-based atomic write because it is going to change from
> filesystem to filesystem and that variability in supported maximum
> length will be exposed to userspace...
> 
> i.e. Maximum supported atomic write size really should be defined as
> a well documented fixed size (e.g. 16MB). Then the transaction
> reservations sizes needed to perform that conversion can be
> calculated directly from that maximum size and optimised directly
> for the conversion operation that atomic writes need to perform.

I'll get to this below...

> .....
> 
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index b2dd0c0bf509..42b2b7540507 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -615,6 +615,28 @@ xfs_init_mount_workqueues(
> >  	return -ENOMEM;
> >  }
> >  
> > +unsigned int
> > +xfs_atomic_write_logitems(
> > +	struct xfs_mount	*mp)
> > +{
> > +	unsigned int		efi = xfs_efi_item_overhead(1);
> > +	unsigned int		rui = xfs_rui_item_overhead(1);
> > +	unsigned int		cui = xfs_cui_item_overhead(1);
> > +	unsigned int		bui = xfs_bui_item_overhead(1);
> > +	unsigned int		logres = M_RES(mp)->tr_write.tr_logres;
> > +
> > +	/*
> > +	 * Maximum overhead to complete an atomic write ioend in software:
> > +	 * remove data fork extent + remove cow fork extent +
> > +	 * map extent into data fork
> > +	 */
> > +	unsigned int		atomic_logitems =
> > +		(bui + cui + rui + efi) + (cui + rui) + (bui + rui);
> 
> This seems wrong. Unmap from the data fork only logs a (bui + cui)
> pair, we don't log a RUI or an EFI until the transaction that
> processes the BUI or CUI actually frees an extent from the the BMBT
> or removes a block from the refcount btree.

This is tricky -- the first transaction in the chain creates a BUI and a
CUI and that's all it needs.

Then we roll to finish the BUI.  The second transaction needs space for
the BUD, an RUI, and enough space to relog the CUI (== CUI + CUD).

Then we roll again to finish the RUI.  This third transaction needs
space for the RUD and space to relog the CUI.

Roll again, fourth transaction needs space for the CUD and possibly a
new EFI.

Roll again, fifth transaction needs space for an EFD.

	const unsigned int	efi = xfs_efi_log_space(1);
	const unsigned int	efd = xfs_efd_log_space(1);
	const unsigned int	rui = xfs_rui_log_space(1);
	const unsigned int	rud = xfs_rud_log_space();
	const unsigned int	cui = xfs_cui_log_space(1);
	const unsigned int	cud = xfs_cud_log_space();
	const unsigned int	bui = xfs_bui_log_space(1);
	const unsigned int	bud = xfs_bud_log_space();

	/*
	 * Maximum overhead to complete an atomic write ioend in software:
	 * remove data fork extent + remove cow fork extent + map extent into
	 * data fork.
	 *
	 * tx0: Creates a BUI and a CUI and that's all it needs.
	 *
	 * tx1: Roll to finish the BUI.  Need space for the BUD, an RUI, and
	 * enough space to relog the CUI (== CUI + CUD).
	 *
	 * tx2: Roll again to finish the RUI.  Need space for the RUD and space
	 * to relog the CUI.
	 *
	 * tx3: Roll again, need space for the CUD and possibly a new EFI.
	 *
	 * tx4: Roll again, need space for an EFD.
	 */
	const unsigned int	tx0 = bui + cui;
	const unsigned int	tx1 = bud + rui + cui + cud;
	const unsigned int	tx2 = rud + cui + cud;
	const unsigned int	tx3 = cud + efi;
	const unsigned int	tx4 = efd;

	const unsigned int	per_intent = max3(max3(tx0, tx1, tx2), tx3, tx4);

> We also need to be able to relog all the intents and everything that
> was modified, so we effectively have at least one
> xfs_allocfree_block_count() reservation needed here as well. Even
> finishing an invalidation BUI can result in BMBT block allocation
> occurring if the operation splits an existing extent record and the
> insert of the new record causes a BMBT block split....

Agreed.

> > +
> > +	/* atomic write limits are always a power-of-2 */
> > +	return rounddown_pow_of_two(logres / (2 * atomic_logitems));
> 
> What is the magic 2 in that division?

That's handwaving the lack of a computation involving
xfs_allocfree_block_count.  A better version would be to figure out the
log space needed:

	/* Overhead to finish one step of each intent item type */
	const unsigned int	f1 = libxfs_calc_finish_efi_reservation(mp, 1);
	const unsigned int	f2 = libxfs_calc_finish_rui_reservation(mp, 1);
	const unsigned int	f3 = libxfs_calc_finish_cui_reservation(mp, 1);
	const unsigned int	f4 = libxfs_calc_finish_bui_reservation(mp, 1);

	/* We only finish one item per transaction in a chain */
	const unsigned int	step_size = max(f4, max3(f1, f2, f3));

and then you have what you need to figure out the logres needed to
support a given awu_max, or vice versa:

	if (desired_max) {
		dbprintf(
 "desired_max: %u\nstep_size: %u\nper_intent: %u\nlogres: %u\n",
				desired_max, step_size, per_intent,
				(desired_max * per_intent) + step_size);
	} else if (logres) {
		dbprintf(
 "logres: %u\nstep_size: %u\nper_intent: %u\nmax_awu: %u\n",
				logres, step_size, per_intent,
				logres >= step_size ? (logres - step_size) / per_intent : 0);
	}

I hacked this into xfs_db so that I could compute a variety of
scenarios.  Let's pretend I have a 10T filesystem with 4k fsblocks and
the default configuration.

# xfs_db /dev/mapper/moo -c logres -c "untorn_max -b $(( (16 * 1048576) / 4096 ))" -c "untorn_max -l 244216"
type 0 logres 244216 logcount 5 flags 0x4
type 1 logres 428928 logcount 5 flags 0x4
<snip>
minlogsize logres 648576 logcount 8

To emulate a 16MB untorn write, you'd need a logres of:

desired_max: 4096
step_size: 107520
per_intent: 208
logres: 959488

959488 > 648576, which would alter the minlogsize calculation.  I know
we banned tiny filesystems a few years ago, but there's still a risk in
increasing it.

For the tr_write logres that John picked, the awu_max we can emulate is:

logres: 244216
step_size: 107520
per_intent: 208
max_awu: 657

That's enough to emulate a 2MB untorn write.

Now let's try again with a realtime filesystem, because the log
reservations are absurdly huge there:

# xfs_db /dev/mapper/moo -c logres -c "untorn_max -b $(( (16 * 1048576) / 4096 ))" -c "untorn_max -l 417400"
type 0 logres 417400 logcount 5 flags 0x4
type 1 logres 772736 logcount 5 flags 0x4
<snip>
minlogsize logres 772736 logcount 5

For 16MB, you'd need a logres of:

desired_max: 4096
step_size: 107520
per_intent: 208
logres: 959488

959488 > 772736, which would alter the minlogsize calculation.

For the tr_write logres that John picked, the awu_max we can emulate is:

logres: 417400
step_size: 107520
per_intent: 208
max_awu: 1489

This is more than enough to handle a 4MB atomic write without affecting
any the other filesystem geometry.  Now I'll try a 400MB filesystem:

# xfs_db /dev/mapper/moo -c logres -c "untorn_max -b $(( (16 * 1048576) / 4096 ))" -c "untorn_max -l 142840"
type 0 logres 142840 logcount 5 flags 0x4
type 1 logres 226176 logcount 5 flags 0x4
<snip>
minlogsize logres 445824 logcount 8

desired_max: 4096
step_size: 56832
per_intent: 208
logres: 908800

Definitely still above minlogsize.

logres: 142840
step_size: 56832
per_intent: 208
max_awu: 413

We can still simulate a 1MB untorn write even on a tiny filesystem.

On a 1k fsblock 400MB filesystem:

# xfs_db /dev/mapper/moo -c logres -c "untorn_max -b $(( (16 * 1048576) / 4096 ))" -c "untorn_max -l 63352"
type 0 logres 63352 logcount 5 flags 0x4
type 1 logres 103296 logcount 5 flags 0x4
<snip>
minlogsize logres 153984 logcount 8

desired_max: 4096
step_size: 26112
per_intent: 208
logres: 878080

Again we see that we'd have to increase the min logsize to support a
16mB untorn write.

logres: 63352
step_size: 26112
per_intent: 208
max_awu: 179

But we can still emulate a 128K untorn write in software.

This is why I don't agree with adding a static 16MB limit -- we clearly
don't need it to emulate current hardware, which can commit up to 64k
atomically.  Future hardware can increase that by 64x and we'll still be
ok with using the existing tr_write transaction type.

By contrast, adding a 16MB limit would result in a much larger minimum
log size.  If we add that to struct xfs_trans_resv for all filesystems
then we run the risk of some ancient filesystem with a 12M log failing
suddenly failing to mount on a new kernel.

I don't see the point.

--D

> > +}
> 
> Also this function does not belong in xfs_super.c - that file is for
> interfacing with the VFS layer.  Calculating log reservation
> constants at mount time is done in xfs_trans_resv.c - I suspect most
> of the code in this patch should probably be moved there and run
> from xfs_trans_resv_calc()...
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

