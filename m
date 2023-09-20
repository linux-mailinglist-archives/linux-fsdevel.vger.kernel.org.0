Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DB67A8BF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 20:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjITSoi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 14:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjITSoh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:44:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110FBC6;
        Wed, 20 Sep 2023 11:44:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C3F7B20230;
        Wed, 20 Sep 2023 18:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695235470;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tKT8c/3acjJrOvUQeGU9v6Ru7yer0O1cXpd+F+TkYaM=;
        b=M7VZxtMlHMUzaa3iaNygukEmUylneWcpodxBt4qFsunCwOYVHK7uZKiQrTcn3cLQjVXtny
        ixc/vaSkRbTgyxz738LXG9xsR7HQqb5BEwzFpCpzP9oevnTRNJ2ow42bvZrSxkFN0IEQhf
        qCCfZjgRqPXvC2WmNTIB3EO1Aqn8RUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695235470;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tKT8c/3acjJrOvUQeGU9v6Ru7yer0O1cXpd+F+TkYaM=;
        b=ajOHa+oZWix+85sWIznZpzLq0RvbQVf2WOocKmE1XDmhv9Iodcx/9qluriVOCl5oNNgzWb
        lTdQsq00JoN0IjAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57FAC1333E;
        Wed, 20 Sep 2023 18:44:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MUyTFI49C2XFKgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 20 Sep 2023 18:44:30 +0000
Date:   Wed, 20 Sep 2023 20:37:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
Subject: Re: [PATCH v4 2/2] btrfs: Introduce the temp-fsid feature
Message-ID: <20230920183756.GG2268@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230913224402.3940543-1-gpiccoli@igalia.com>
 <20230913224402.3940543-3-gpiccoli@igalia.com>
 <20230918215250.GQ2747@twin.jikos.cz>
 <cff46339-62ff-aecc-2766-2f0b1a901a35@igalia.com>
 <a5572d9e-4028-b3ca-da34-e9f5da95bc34@oracle.com>
 <9ee57635-81bf-3307-27ac-8cb7a4fa02f6@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ee57635-81bf-3307-27ac-8cb7a4fa02f6@igalia.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 09:16:02AM -0300, Guilherme G. Piccoli wrote:
> On 19/09/2023 02:01, Anand Jain wrote:
> > [...]
> > This must successfully pass the remaining Btrfs fstests test cases with
> > the MKFS_OPTION="-O temp-fsid" configuration option, or it should call
> > not run for the incompatible feature.
> 
> I kinda disagree here - this feature is not compatible with anything
> else, so I don't think it's fair to expect mounting with temp-fsid will
> just pass all other tests, specially for things like (the real)
> metadata_uuid or extra devices, like device removal...

Yeah, fstests are not in general ready for enabling some feature from
the outside (mkfs, or mount options). Some of them work as long as
they're orthogonal but some tests need to detect that and skip. In this
case all multidevice tests would fail.

For test coverage there should be at lest one test that verifies known
set of compatible features or usecases we care about in comibnation with
the temp-fsid.

> > I have observed that the following test case is failing with this patch:
> > 
> >   $ mkfs.btrfs -fq /dev/sdb1 :0
> >   $ btrfstune --convert-to-temp-fsid /dev/sdb1 :0
> >   $ mount /dev/sdb1 /btrfs :0
> > 
> > Mount /dev/sdb1 again at a different mount point and look for the copied
> > file 'messages':
> > 
> >   $ cp /var/log/messages /btrfs :0
> > 
> >   $ mount /dev/sdb1 /btrfs1 :0
> >   $ ls -l /btrfs1 :0
> >   total 0   <-- empty
> > 
> > The copied file is missing because we consider each mount as a new fsid.
> > This means subvolume mounts are also not working. Some operating systems
> > mount $HOME as a subvolume, so those won't work either.
> > 
> > To resolve this, we can use devt to match in the device list and find
> > the matching fs_devices or NULL.
> 
> Ugh, this one is ugly. Thanks for noticing that, I think this needs
> fixing indeed.
> 
> I've tried here, mounted the same temp-fsid btrfs device in 2 different
> mount points, and wrote two different files on each. The mount A can
> only see the file A, mount B can only see file B. Then after unmouting
> both, I cannot mount anymore with errors in ctree, so it got corrupted.
> 
> The way I think we could resolve this is by forbidding mounting a
> temp-fsid twice - after the random uuid generation, we could check for
> all fs_devices present and if any of it has the same metadata_uuid, we
> check if it's the same dev_t and bail.
> 
> The purpose of the feature is for having the same filesystem in
> different devices able to mount at the same time, but on different mount
> points. WDYT?

The subvolume mount is a common use case and I hope it continues to
work. Currently it does not seem so as said above, for correctness we
may need to prevent it. We might find more and this should be known or
fixed before final release.
