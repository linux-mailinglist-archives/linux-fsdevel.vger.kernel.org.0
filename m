Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832C17A8BBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 20:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjITSaT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 14:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjITSaS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:30:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C32CAB;
        Wed, 20 Sep 2023 11:30:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 108C21F74D;
        Wed, 20 Sep 2023 18:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695234611;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=klCdvAoQqw5fKeWWaiEa3V2ej9IyszbbovzKNcrrpGs=;
        b=eEJSUy773LqlbzfGsfIRGWG60o8sD4C55LpMZlA8RNlYwunTntnGedcjnJMC362ZUwtnqa
        qic2P02VC1crRXhWP7x2JW++DLYpTYpFMZrqU/u5HYnJHAnhJh0zbxPjYpXppioR39FCTn
        jDlms2UtyOE8gAFQ0/qMf6JMVJrhoB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695234611;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=klCdvAoQqw5fKeWWaiEa3V2ej9IyszbbovzKNcrrpGs=;
        b=90NrKe1vsD5LWMmOMNoBAMgtm8CE9jxuyJlifINKsC8WnC9qTMaA1+nxVczRMH24XqI/ER
        f5YILkX7I1i+tBBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A86F61333E;
        Wed, 20 Sep 2023 18:30:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gWkEKDI6C2UKJAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 20 Sep 2023 18:30:10 +0000
Date:   Wed, 20 Sep 2023 20:23:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        dsterba@suse.cz, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
Subject: Re: [PATCH v4 2/2] btrfs: Introduce the temp-fsid feature
Message-ID: <20230920182336.GF2268@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230913224402.3940543-1-gpiccoli@igalia.com>
 <20230913224402.3940543-3-gpiccoli@igalia.com>
 <f976c005-29fe-4f7e-e1d2-5262d638761a@oracle.com>
 <b71f8c4b-1e70-605c-8903-ab1d16c1ef73@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b71f8c4b-1e70-605c-8903-ab1d16c1ef73@igalia.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 09:03:49AM -0300, Guilherme G. Piccoli wrote:
> On 19/09/2023 08:06, Anand Jain wrote:
> > [...]
> >> +	while (dup_fsid) {
> >> +		dup_fsid = false;
> >> +		generate_random_uuid(vfsid);
> >> +
> >> +		list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
> >> +			if (!memcmp(vfsid, fs_devices->fsid, BTRFS_FSID_SIZE) ||
> >> +			    !memcmp(vfsid, fs_devices->metadata_uuid,
> >> +				    BTRFS_FSID_SIZE))
> >> +				dup_fsid = true;
> >> +		}
> > 		
> > 
> > I've noticed this section of the code a few times, but I don't believe
> > I've mentioned it before. We've been using generate_random_guid() and
> > generate_random_uuid() without checking for UUID clashes. Why extra
> > uuid clash check here?
> 
> Hi Anand, what would happen if the UUID clashes here? Imagine we have
> another device with the same uuid (incredibly small chance, but...), I
> guess this would break in the subsequent path of fs_devices addition,
> hence I added this check, which is really cheap. We need to generate a
> really unique uuid here as the temp one.
> 
> Do you see any con in having this check? I'd say we should maybe even
> check in the other places the code is generating a random uuid but not
> checking for duplicity currently...

The duplicate uuid is unlikely so the loop would run once but making
sure it's not duplicate does not hurt so let's keep it.
