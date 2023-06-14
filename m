Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2073872FF02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 14:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244716AbjFNMsZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 08:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbjFNMsZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:48:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE94198;
        Wed, 14 Jun 2023 05:48:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8037061B40;
        Wed, 14 Jun 2023 12:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C617CC433C0;
        Wed, 14 Jun 2023 12:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686746902;
        bh=7JGKsXcFVMSHRI5qP+Wpxgaa2pzqQ2u9vLOy783OFeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gu7ClsTn9lkvZrb2UxTpQHN+vllaAgSQb+HmuexzTCAvf2Zcd6VHWF2iqmTtz7vJe
         QwmW/uCDGqQSz33w2qM9HW6jJ7UyO0gbXVmJll7az+SKJuIduAadythkj0jHey/csN
         1TQr138d9Tof+VFe5YXpiYqsn2bYQHAoOAy8wQMWzTy/wh4KCHYK8NqM1cO/8N0EUt
         /57lmDWfmHrRRwcYiYE0dFkNRnnZgLhbvvzYvxo61A6oNKU1kqcOuybU0uzs3pL/fZ
         AtNHfY/snepcIKbo4Wz9iOmJS0vt7gtPZZpR2XfO7rGVKkMdUOBn25ch8i8FpZd0OV
         mfG/nunJ0p1mA==
Date:   Wed, 14 Jun 2023 14:48:17 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, yebin <yebin@huaweicloud.com>,
        linux-fsdevel@vger.kernel.org,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <20230614-witzbold-liedtexte-ea9a6420606a@brauner>
References: <20230612161614.10302-1-jack@suse.cz>
 <ZIf6RrbeyZVXBRhm@infradead.org>
 <CACT4Y+ZsN3wemvGLVyNWj9zjykGwcHoy581w7GuAHGpAj1YLxg@mail.gmail.com>
 <ZIlphqM9cpruwU6m@infradead.org>
 <20230614-anstalt-gepfercht-affd490e6544@brauner>
 <20230614103654.ydiosiv6ptljwd7i@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230614103654.ydiosiv6ptljwd7i@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 12:36:54PM +0200, Jan Kara wrote:
> On Wed 14-06-23 10:18:16, Christian Brauner wrote:
> > On Wed, Jun 14, 2023 at 12:17:26AM -0700, Christoph Hellwig wrote:
> > > On Tue, Jun 13, 2023 at 08:09:14AM +0200, Dmitry Vyukov wrote:
> > > > I don't question there are use cases for the flag, but there are use
> > > > cases for the config as well.
> > > > 
> > > > Some distros may want a guarantee that this does not happen as it
> > > > compromises lockdown and kernel integrity (on par with unsigned module
> > > > loading).
> > > > For fuzzing systems it also may be hard to ensure fine-grained
> > > > argument constraints, it's much easier and more reliable to prohibit
> > > > it on config level.
> > > 
> > > I'm fine with a config option enforcing write blocking for any
> > > BLK_OPEN_EXCL open.  Maybe the way to it is to:
> > > 
> > >  a) have an option to prevent any writes to exclusive openers, including
> > >     a run-time version to enable it
> > 
> > I really would wish we don't make this runtime configurable. Build time
> > and boot time yes but toggling it at runtime makes this already a lot
> > less interesting.
> 
> I see your point from security POV. But if you are say a desktop (or even
> server) user you may need to say resize your LVM or add partition to your
> disk or install grub2 into boot sector of your partition. In all these
> cases you need write access to a block device that is exclusively claimed
> by someone else. Do you mandate reboot in permissive mode for all these
> cases? Realistically that means such users just won't bother with the
> feature and leave it disabled all the time. I'm OK with such outcome but I
> wanted to point out this "no protection change after boot" policy noticably
> restricts number of systems where this is applicable.

You're asking the hard/right questions.

Installing the boot loader into a boot sector seems like an archaic
scenario. With UEFI this isn't necessary and systems that do want this
they should turn the Kconfig off or boot with it turned off.

I'm trying to understand the partition and lvm resize issue. I've
chatted a bit about this and it seems that in this protected mode we
should ensure that we cannot write to the main block device's sectors
that are mapped to a partition block device. If you write to the main
block device of a partitioned device one should only be able to modify
the footer and header but nothing where you have a partition block
device on. That should mean you can resize an LVM partition afaict.

I've been told that the partition block devices and the main block
devices have different buffer caches. But that means you cannot mix
accesses to them because writes to one will not show up on the other
unless caches are flushed on both devices all the time.

So it'd be neat if the writes to the whole block device would simply be
not allowed at all to areas which are also exposed as partition block
devices.
