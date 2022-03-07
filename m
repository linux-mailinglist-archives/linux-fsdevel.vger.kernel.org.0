Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0159A4CFB4E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 11:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239808AbiCGKe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 05:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242978AbiCGKcq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:32:46 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A10954B4;
        Mon,  7 Mar 2022 02:04:31 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id k9-20020a056830242900b005ad25f8ebfdso12548566ots.7;
        Mon, 07 Mar 2022 02:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eFINug5CEkg/2CdNeLAUX19KPmO0ycgYSIVhZEmafEA=;
        b=YnBdJ49/EVrKDag+lDqSSFbAnRYBSHHjHZCWwFqVdHl+kyXwaVqUKvUnCuiLIheB8z
         Ey8ogH3aGIBTahdO60MBpT8Wh0F9QnxrNrZZ2fVIL4v1cIv0PltapaknvXTQK6sT26GH
         Z7CxcWiIn+jXqC8AvNUdPZ4RiZwr6X9boBd5OTTyeNRudQV+wkTQaSx6RX2EyhXWo971
         3QlhdEeCX/eVc8WikfbIGpBJ6+cKisa2q/D/aHeVmpNPpeVS9wD3HGJ5drZH7UFAcPu7
         FiQZev26Ri7c4RRYDlj+x8BerC95lz0oCu02KYmV6Pvny3F+4IPM6730N7QDkDEuV/Mg
         zwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eFINug5CEkg/2CdNeLAUX19KPmO0ycgYSIVhZEmafEA=;
        b=yjKaCjhIcVRXwf4GS8mscfDYIuVXruKBgIHUADHdz0yPa+2AaRZmU6ihkQYTqG/zfZ
         +5PQ4sOrCvUj+ooBL5CZTivj/46L8FdpihpiZgCQ4DeLX3pnhCrTh22zyxT/vhNwM4oN
         jHhBMKaXlhyE1pww9TKmbrd2XkdXy3JgiYobY66jzBbNlKUkr/vmTmvl3lWQBca9kx3O
         iFu0SKhZYfSkOgyS4gCxPMruUNbl68LJDdlLfFK5ggMyDQsNLgrNQSOJU4Derr6rRKxr
         d1/hbLjCgfnpzPe8LkhLcm2MoyxbPNVfHM4tm9cj0TJdsmgg9na/XzdPDuAJB3M1DO3+
         cXtg==
X-Gm-Message-State: AOAM530lQa122wo//JQPJvsniEiaLBQ8sppOs8YJOLERBjXqlRKXaSKU
        R7W/THTiE4r65dP15lcRxdbETgaeiiXAaeK6BzuOLilXmX8=
X-Google-Smtp-Source: ABdhPJx4qz4BdpRtlQ5ORwOeZtTPXA9Q+my9KHbaCDRdZuwZnWooI3Y/1gLahKqTF3jgeV0y2piBqLKA17SuBObh5AE=
X-Received: by 2002:a05:6830:1db0:b0:5af:22a6:e97d with SMTP id
 z16-20020a0568301db000b005af22a6e97dmr5360074oti.288.1646647457616; Mon, 07
 Mar 2022 02:04:17 -0800 (PST)
MIME-Version: 1.0
References: <20220305160424.1040102-1-amir73il@gmail.com> <YiQ2Gi8umX9LQBWr@mit.edu>
 <20220307001420.GQ3927073@dread.disaster.area>
In-Reply-To: <20220307001420.GQ3927073@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 7 Mar 2022 12:04:06 +0200
Message-ID: <CAOQ4uxhtm0pwC5SUX9t0cL-+eTTuGgNs26U_H7rvT7p6V1+wgQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] Generic per-sb io stats
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 7, 2022 at 2:14 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Sat, Mar 05, 2022 at 11:18:34PM -0500, Theodore Ts'o wrote:
> > On Sat, Mar 05, 2022 at 06:04:15PM +0200, Amir Goldstein wrote:
> > >
> > > Dave Chinner asked why the io stats should not be enabled for all
> > > filesystems.  That change seems too bold for me so instead, I included
> > > an extra patch to auto-enable per-sb io stats for blockdev filesystems.
> >
> > Perhaps something to consider is allowing users to be able to enable
> > or disable I/O stats on per mount basis?
> >
> > Consider if a potential future user of this feature has servers with
> > one or two 256-core AMD Epyc chip, and suppose that they have a
> > several thousand iSCSI mounted file systems containing various
> > software packages for use by Kubernetes jobs.  (Or even several
> > thousand mounted overlay file systems.....)
> >
> > The size of the percpu counter is going to be *big* on a large CPU
> > count machine, and the iostats structure has 5 of these per-cpu
> > counters, so if you have one for every single mounted file system,
> > even if the CPU slowdown isn't significant, the non-swappable kernel
> > memory overhead might be quite large.
>
> A percpu counter on a 256 core machine is ~1kB. Adding 5kB to the
> struct superblock isn't a bit deal for a machine of this size, even
> if you have thousands of superblocks - we're talking a few
> *megabytes* of extra memory in a machine that would typically have
> hundreds of GB of RAM. Seriously, the memory overhead of the per-cpu
> counters is noise compared to the memory footprint of, say, the
> stacks needing to be allocated for every background worker thread
> the filesystem needs.
>
> Yeah, I know, we have ~175 per-cpu stats counters per XFS superblock
> (we already cover the 4 counters Amir is proposing to add as generic
> SB counters), and we have half a dozen dedicated worker threads per
> mount. Yet systems still function just fine when there are thousands
> of XFS filesystems and thousands of CPUs.
>
> Seriously, a small handful of per-cpu counters that capture
> information for all superblocks is not a big deal. Small systems
> will have relatively litte overhead, large systems have the memory
> to handle it.
>
> > So maybe a VFS-level mount option, say, "iostats" and "noiostats", and
> > some kind of global option indicating whether the default should be
> > iostats being enabled or disabled?  Bonus points if iostats can be
> > enabled or disabled after the initial mount via remount operation.
>
> Can we please just avoid mount options for stuff like this? It'll
> just never get tested unless it defaults to on, and then almost
> no-one will ever turn it off because why would you bother tweaking
> something that has not noticable impact but can give useful insights
> the workload that is running?
>
> I don't care one way or another here because this is essentially
> duplicating something we've had in XFS for 20+ years. What I want to
> avoid is blowing out the test matrix even further. Adding optional
> features has a cost in terms of testing time, so if it's a feature
> that is only rarely going to be turned on then we shouldn't add it
> at all. If it's only rearely going to be turned off, OTOH, then we
> should just make it ubiquitous and available for everything so it's
> always tested.
>
> Hence, AFAICT, the only real option for yes/no support is the
> Kconfig option. If the kernel builder turns it on, it is on for
> everything, otherwise it is off for everything.
>

I agree with this sentiment and I also share Ted's concerns
that we may be overlooking some aspect, so my preference would
be that Miklos takes the sb_iostats infra patches through his tree
to enable iostats for fuse/overlayfs (I argued in the commit message
why I think they deserve a special treatment).

Regarding the last patch -
Ted, would you be more comfortable if it came with yet another
Kconfig (e.g. FS_IOSTATS_DEFAULT)? Or perhaps with a /proc/sys/fs/
fail safety off switch (like protected_symlinks)?
That gives more options to distros.

Thanks,
Amir.
