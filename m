Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FDC72F670
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 09:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243403AbjFNHfm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 03:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243417AbjFNHfh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:35:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D9D10E9;
        Wed, 14 Jun 2023 00:35:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FDD962613;
        Wed, 14 Jun 2023 07:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4DFC433C8;
        Wed, 14 Jun 2023 07:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686728134;
        bh=kQ44VJLr/FHwQrB/2L3l6jXV4zJt9Y1vtnE4iZmuCmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ayNynNAcYUqOAm+33UVGdlyyyn+7fJqwY4kbwPhO0VbRebTMPcdZf13v2khKa+s9f
         A0XAZmDuhBJlFzG1XylPPRaRYt2B9SICo3m+9mzb4OI0qqL/LJ83uZSP1O7COKNRDb
         kk+jr83YHwQ7i0qP9hZaUj59rVo354buA/dSg7EKOXmNqEVSeRMRoNtizlG4YWbOAh
         AIKWRSeiKPuDuA9GceQIFygHZcOUEEIU6L7kW/d4xKX+U+6HKWxLO/ddRGQVoD5EjN
         0JrzDlvjvn6OgTQGyRW9BL7NJvukli6226acmrfuMaSbhESp60fy3z5rlLsnf9hLtb
         cQ+BVhC9E1w7w==
Date:   Wed, 14 Jun 2023 09:35:29 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, Ted Tso <tytso@mit.edu>,
        yebin <yebin@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <20230614-galopp-aussuchen-1c95be0709f0@brauner>
References: <20230612161614.10302-1-jack@suse.cz>
 <ZIf6RrbeyZVXBRhm@infradead.org>
 <20230613205614.atlrwst55bpqjzxf@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230613205614.atlrwst55bpqjzxf@quack3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 10:56:14PM +0200, Jan Kara wrote:
> On Mon 12-06-23 22:10:30, Christoph Hellwig wrote:
> > > +config BLK_DEV_WRITE_HARDENING
> > > +	bool "Do not allow writing to mounted devices"
> > > +	help
> > > +	When a block device is mounted, writing to its buffer cache very likely
> > > +	going to cause filesystem corruption. It is also rather easy to crash
> > > +	the kernel in this way since the filesystem has no practical way of
> > > +	detecting these writes to buffer cache and verifying its metadata
> > > +	integrity. Select this option to disallow writing to mounted devices.
> > > +	This should be mostly fine but some filesystems (e.g. ext4) rely on
> > > +	the ability of filesystem tools to write to mounted filesystems to
> > > +	set e.g. UUID or run fsck on the root filesystem in some setups.
> > 
> > I'm not sure a config option is really the right thing.
> > 
> > I'd much prefer a BLK_OPEN_ flag to prohibit any other writer.
> > Except for etN and maybe fat all file systems can set that
> > unconditionally.  And for those file systems that have historically
> > allowed writes to mounted file systems they can find a local way
> > to decide on when and when not to set it.
> 
> Well, as I've mentioned in the changelog there are old setups (without

Before going into the details: Let's please take syzbot out of the
picture as a justification or required reviewer for this patch. This is
a complete distraction imho. If the patch has the side effect that it
somehow makes for less noisy syzbot reports then so be it but it's
really not why this patch is a good idea.

For userspace this patch is immediately useful and a security mechanism
that everyone familiar with block device/filesystem attack surfaces will
want to make use of. And we should encourage this be the default
whenever possible imho. That's all the justification that we need.

> initrd) that run fsck on root filesystem mounted read-only and fsck
> programs tend to open the device with O_RDWR. These would be broken by this
> change (for the filesystems that would use BLK_OPEN_ flag). Similarly some
> boot loaders can write to first sectors of the root partition while the
> filesystem is mounted. So I don't think controlling the behavior by the
> in-kernel user that is having the bdev exclusively open really works. It
> seems to be more a property of the system setup than a property of the
> in-kernel bdev user. Am I mistaken?
> 
> So I think kconfig option or sysfs tunable (maybe a per-device one?) will
> be more appropriate choice? With default behavior configurable by kernel
> parameter? And once set to write-protect on mount, do we allow flipping it
> back? Both have advantages and disadvantages so the tunable might be
> tri-state in the end (no protection, write-protect but can be turned off,
> write-protect that cannot be turned off)? But maybe I'm overcomplicating
> this so please share your thoughts :)

A simple bool Kconfig overridable by kernel command line option is what
we want. Fundamental security relevant properties such as this should
never be runtime configurable. They should be boot and build time
configurable and then they should be off limits.
