Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0E56FF0BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 13:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbjEKL5z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 07:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjEKL5y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 07:57:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2524213;
        Thu, 11 May 2023 04:57:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 070AA1FDE3;
        Thu, 11 May 2023 11:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683806271;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zEvzVIuxLSgJ//1ZdDUJrWHUqYRNDp1OQ9meoWxDfeU=;
        b=Z4tguJ7n3flXSF5S74zLeXnIJBLBJrcUMpL9Z1ha0BxZhhLOXyo5UTwmC12YO8lr2MHQ8c
        lQfPALvOGBiYSesCb1klkJpKLBN6ECA+BJWNjFo2XXBEz2sbtqFP73zM/qawx7TOK2wzCy
        vpDglk49OID+lFo9dMdHqwSWG7agxqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683806271;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zEvzVIuxLSgJ//1ZdDUJrWHUqYRNDp1OQ9meoWxDfeU=;
        b=WRnpdFTMRx/gww8OFpDT9f7RKfYDNNa/Axjl56s2lQ9ArtQ207Lr4Ui+3wtoAbd3XFoWag
        MLNlN1wQcSnd0nDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9AC11134B2;
        Thu, 11 May 2023 11:57:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EmWVJD7YXGQqcQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 11 May 2023 11:57:50 +0000
Date:   Thu, 11 May 2023 13:51:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Anand Jain <anand.jain@oracle.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        nborisov@suse.com
Subject: Re: [PATCH 1/2] btrfs: Introduce the virtual_fsid feature
Message-ID: <20230511115150.GX32559@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <20230504170708.787361-2-gpiccoli@igalia.com>
 <2892ff0d-9225-07b7-03e4-a3c96d0bff59@gmx.com>
 <20230505133810.GO6373@twin.jikos.cz>
 <9839c86a-10e9-9c3c-0ddb-fc8011717221@oracle.com>
 <7eaf251e-2369-1a07-a81f-87e4da8b6780@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eaf251e-2369-1a07-a81f-87e4da8b6780@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 08, 2023 at 07:50:55PM +0800, Qu Wenruo wrote:
> On 2023/5/8 19:27, Anand Jain wrote:
> > On 05/05/2023 21:38, David Sterba wrote:
> >> On Fri, May 05, 2023 at 03:21:35PM +0800, Qu Wenruo wrote:
> >>> On 2023/5/5 01:07, Guilherme G. Piccoli wrote:
> >> This is actually a good point, we can do that already. As a conterpart
> >> to 5f58d783fd7823 ("btrfs: free device in btrfs_close_devices for a
> >> single device filesystem") that drops single device from the list,
> >> single fs devices wouldn't be added to the list but some checks could be
> >> still done like superblock validation for eventual error reporting.
> >
> > Something similar occurred to me earlier. However, even for a single
> > device, we need to perform the scan because there may be an unfinished
> > replace target from a previous reboot, or a sprout Btrfs filesystem may
> > have a single seed device. If we were to make an exception for replace
> > targets and seed devices, it would only complicate the scan logic, which
> > goes against our attempt to simplify it.
> 
> If we go SINGLE_DEV compat_ro flags, then no such problem at all, we can
> easily reject any multi-dev features from such SINGLE_DEV fs.

With the scanning complications that Anand mentions the compat_ro flag
might make more sense, with all the limitations but allowing a safe use
of the duplicated UUIDs.

The flag would have to be set at mkfs time or by btrfsune on an
unmounted filesystem. Doing that on a mounted filesystem is possible too
but brings problems with updating the state of scanned device,
potentially ongoing operations like dev-replace and more.
