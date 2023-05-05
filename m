Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5756F8CA1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 01:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjEEXGF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 19:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjEEXGE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 19:06:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721DF198A;
        Fri,  5 May 2023 16:06:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 01FA52054E;
        Fri,  5 May 2023 23:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683327961;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NOw4/VfnmEY5ubqSJcp1uZbDM0duVp2u3lfH4C0ZAFE=;
        b=HVePZw3Rx6HtLjBOA1aCuMc3/mfJQBIH9asD3cYZcNmJrd3/Fihs9rWxzDFr2bzu7E2A16
        uFZ1TpswukB4R/PCriZr67kgVplB3i3K/beEfUsuWLKpnshNEDT5ofgN520GqDiMwWvehu
        QpXqiSrPxhpH/3ohw1rZRRWGU+pQ6vQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683327961;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NOw4/VfnmEY5ubqSJcp1uZbDM0duVp2u3lfH4C0ZAFE=;
        b=L1Zddc9wCB2qRaNJVuzk+fhCuqa25gY6O6QcYOyuNyNLHLtVf+vnvkVWUMidCxWVCx+2Il
        FjGRQxsxvCaHl/DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F53713488;
        Fri,  5 May 2023 23:06:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k2KAIdiLVWQsOgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 05 May 2023 23:06:00 +0000
Date:   Sat, 6 May 2023 01:00:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 1/2] btrfs: Introduce the virtual_fsid feature
Message-ID: <20230505230003.GU6373@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <20230504170708.787361-2-gpiccoli@igalia.com>
 <20230505131825.GN6373@twin.jikos.cz>
 <a28b9ff4-c16c-b9ba-8b4b-a00252c32857@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a28b9ff4-c16c-b9ba-8b4b-a00252c32857@igalia.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 05, 2023 at 01:18:56PM -0300, Guilherme G. Piccoli wrote:
> On 05/05/2023 10:18, David Sterba wrote:
> > [...]
> > Have you evaluated if the metadata_uuid could be used for that? It is
> > stored on the filesystem image, but could you adapt the usecase to set
> > the UUID before mount manually (in tooling)?
> > 
> > The metadata_uuid is lightweight and meant to change the appearance of
> > the fs regarding uuids, verly close to what you describe. Adding yet
> > another uuid does not seem right so I'm first asking if and in what way
> > the metadata_uuid could be extended.
> 
> Hi David, thanks for your suggestion!
> 
> It might be possible, it seems a valid suggestion. But worth notice that
> we cannot modify the FS at all. That's why I've implemented the feature
> in a way it "fakes" the fsid for the driver, as a mount option, but
> nothing changes in the FS.
> 
> The images on Deck are read-only. So, by using the metadata_uuid purely,
> can we mount 2 identical images at the same time *not modifying* the
> filesystem in any way? If it's possible, then we have only to implement
> the skip scanning idea from Qu in the other thread (or else ioclt scans
> would prevent mounting them).

Ok, I see, the device is read-only. The metadata_uuid is now set on an
unmounted filesystem and we don't have any semantics for a mount option.

If there's an equivalent mount option (let's say metadata_uuid for
compatibility) with the same semantics as if set offline, on the first
commit the metadata_uuid would be written.

The question is if this would be sane for read-only devices. You've
implemented the uuid on the metadata_uuid base but named it differently,
but this effectively means that metadata_uuid could work on read-only
devices too, but with some necessary updates to the device scanning.

From the use case perspective this should work, the virtual uuid would
basically be the metadata_uuid set and on a read-only device. The
problems start in the state transitions in the device tracking, we had
some bugs there and the code is hard to grasp. For that I'd very much
vote for using the metadata_uuid but we can provide an interface on top
of that to make it work.
