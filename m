Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F57672895A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 22:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjFHU0g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 16:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjFHU0c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 16:26:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB4E2D68;
        Thu,  8 Jun 2023 13:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jUnLmUq/BI2X8kB58CgdSSW6s0Exo/WOw6rtJANLsGg=; b=KKf0TL37JdBzVrDBmFljUXd4zo
        HHcuDZGn5vPSYLlvTAQF/OJt27OptP+R1hmY0mVeux3qEVqJJD5b+Cn95khCsRd744hUjlPaEMANF
        S4X/bYGdDKu9ge9lvqTGiOZQdn2AgCS0AqdKK8iLRde2kZ1kb4z+sGj5SMQadPYPschqdN/m08XU5
        7uSJg9obVdHL3UjP+x0HJNW+eprd8kajYU2XJ00cbs7VqvKdY7366BBAHyGnxXA02SydNpfE2N4ub
        TLT0vK7nxAuV0RBd7833NMuo+EeX/WKFOF5qAWZX94ByMmrAeiR+cmAt7dlLsApNi4WwPODdkteaT
        NVN2/R4A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q7MD5-00AXn7-2h;
        Thu, 08 Jun 2023 20:26:19 +0000
Date:   Thu, 8 Jun 2023 13:26:19 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     hch@infradead.org, sandeen@sandeen.net, song@kernel.org,
        rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
        bvanassche@acm.org, ebiederm@xmission.com, mchehab@kernel.org,
        keescook@chromium.org, p.raghav@samsung.com, da.gomez@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <ZII5awqVCr9IUWtH@bombadil.infradead.org>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-4-mcgrof@kernel.org>
 <20230522234200.GC11598@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522234200.GC11598@frogsfrogsfrogs>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 04:42:00PM -0700, Darrick J. Wong wrote:
> How about this as an alternative patch?

I'm all for it, this is low hanging fruit and I try to get back to it
as no one else does, so I'm glad someone else is looking and trying too!

Hopefully dropping patch 1 and 2 would help with this.

Comments below.

> From: Darrick J. Wong <djwong@kernel.org>
> Subject: fs: distinguish between user initiated freeze and kernel initiated freeze
> 
> Userspace can freeze a filesystem using the FIFREEZE ioctl or by
> suspending the block device; this state persists until userspace thaws
> the filesystem with the FITHAW ioctl or resuming the block device.
> Since commit 18e9e5104fcd ("Introduce freeze_super and thaw_super for
> the fsfreeze ioctl") we only allow the first freeze command to succeed.
> 
> The kernel may decide that it is necessary to freeze a filesystem for
> its own internal purposes, such as suspends in progress, filesystem fsck
> activities, or quiescing a device prior to removal.  Userspace thaw
> commands must never break a kernel freeze, and kernel thaw commands
> shouldn't undo userspace's freeze command.
> 
> Introduce a couple of freeze holder flags and wire it into the
> sb_writers state.  One kernel and one userspace freeze are allowed to
> coexist at the same time; the filesystem will not thaw until both are
> lifted.

This mix-match stuff is also important to document so we can get
userspace to understand what is allowed and we get a sense of direction
written / documented. Without this trying to navigate around this is
all implied. We may need to adjust things with time for thing we may
not have considered.

> -int freeze_super(struct super_block *sb)
> +static int __freeze_super(struct super_block *sb, unsigned short who)
>  {
> +	struct sb_writers *sbw = &sb->s_writers;
>  	int ret;
>  
>  	atomic_inc(&sb->s_active);
>  	down_write(&sb->s_umount);
> +
> +	if (sbw->frozen == SB_FREEZE_COMPLETE) {
> +		switch (who) {

<-- snip -->

> +		case FREEZE_HOLDER_USERSPACE:
> +			if (sbw->freeze_holders & FREEZE_HOLDER_USERSPACE) {
> +				/*
> +				 * Userspace freeze already in effect; tell
> +				 * the caller we're busy.
> +				 */
> +				deactivate_locked_super(sb);
> +				return -EBUSY;

I'm thinking some userspace might find this OK so thought maybe
something like -EALREADY would be better, to then allow userspace
to decide, however, since userspace would not control the thaw it
seems like risky business to support that.

Anyway, I'm all for any alternative!

  Luis
