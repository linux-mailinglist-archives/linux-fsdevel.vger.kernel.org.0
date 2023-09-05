Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799FE792EC2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 21:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbjIETT7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 15:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjIETTx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:19:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EB41BE;
        Tue,  5 Sep 2023 12:19:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B6EA51FF11;
        Tue,  5 Sep 2023 16:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693932639;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mV5q3bCfqIU2bieJ+aC5Rbi5OO82o6cF5zowkscv/5w=;
        b=KOZMtlKv/UXIf9swCGne/UIkYncl66ozaD98HhO2kaslzj5qvIlH6hJoU4FlUV7AhLfAPI
        fheX0u44nrdki+PfK1Nc9eekR41Z2ADABIQaWC3RcjIYoRYNkdaaG2vS17kLJJ7xOQ4ScZ
        RmuwG9G4XoicJtvmdgfwRDyyeToggGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693932639;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mV5q3bCfqIU2bieJ+aC5Rbi5OO82o6cF5zowkscv/5w=;
        b=Dl1ITXZHlebT1nYY9VOGAKQB6ogReSrEMEMNQXt8DU6NrPUNUCI6Q6h7fqx6Yvdn0wyM0z
        qVsi9NONZq7Hw9DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E70413911;
        Tue,  5 Sep 2023 16:50:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Yx4mFl9c92TNJgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 05 Sep 2023 16:50:39 +0000
Date:   Tue, 5 Sep 2023 18:43:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Anand Jain <anand.jain@oracle.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, david@fromorbit.com, kreijack@libero.it,
        johns@valvesoftware.com, ludovico.denittis@collabora.com,
        quwenruo.btrfs@gmx.com, wqu@suse.com, vivek@collabora.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH V3 0/2] Supporting same fsid mounting through the
 single-dev compat_ro feature
Message-ID: <20230905164359.GE14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230831001544.3379273-1-gpiccoli@igalia.com>
 <fee2dcd5-065d-1e60-5871-4a606405a683@oracle.com>
 <80140c50-1fbe-1631-1473-087a13fd034f@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80140c50-1fbe-1631-1473-087a13fd034f@igalia.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 04, 2023 at 10:29:52PM -0300, Guilherme G. Piccoli wrote:
> On 04/09/2023 03:36, Anand Jain wrote:
> > [...]
> > We need some manual tests as well to understand how this feature
> > will behave in a multi-pathed device, especially in SAN and iSCSI
> > environments.

I don't know how good the multipath support is on btrfs, it's kind of a
specific use case, requires a specialized hardware and emulation in VM
requires iSCSI hacks which is tedious to setup on itself. So I do not
insist on supporting the single-dev from the beginning, we usually
start with a more restricted version and then extend the support
eventually.

> > I have noticed that Ubuntu has two different device
> > paths for the root device during boot. It should be validated
> > as the root file system using some popular OS distributions.
> 
> Hi Anand, thanks for you suggestions! I just tried on Ubuntu 22.04.3 and
> it worked flawlessly. After manually enabling the single-dev feature
> through btrfstune, when booted into the distro kernel (6.2.x) it mounts
> as RO (as expected, since this is a compat_ro feature). When switched to
> a supporting kernel (6.5 + this patch), it mounts normally -
> udev/systemd are capable of identifying the underlying device based on
> UUID, and it mounts as SINGLE_DEV.
> 
> About the iSCSI / multipath cases, they are/should be unsupported. Is
> multi-path a feature of btrfs? I think we should prevent users from
> using single-dev along with other features of btrfs that doesn't make
> sense, like we're doing here with devices removal/replace and of course,
> with the metadata_uuid feature.
> 
> Now if multipath is not supported from btrfs, my understanding is that
> users should not tune single-dev, as it doesn't make sense, but at the
> same time it's not on scope here to test such scenario. In other words,
> I'm happy to test a case that you suggest, but no matter how many
> non-btrfs features/cases we test, we're not in control of what users can
> do in the wild.

We at least should know how some feature/hardware combinations behave
and add protections against using them together if there are known
problems. In the case of multipath I'd like to see somebody tests it but
as said above for the initial implementation it does not need to support
it.
