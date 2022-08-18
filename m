Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B73597B35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 03:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239249AbiHRBwX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 21:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbiHRBwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:52:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BB69C2F2;
        Wed, 17 Aug 2022 18:52:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3FC3B3890A;
        Thu, 18 Aug 2022 01:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660787537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MsCpnIDEIoiyaQnhIzHQLWmymVdVFy3Ho7omdhkjihc=;
        b=UZofmoijgxYszLPwVMrva7lbPHhGjLjJ2TftGHUJqgEBD9nsBBRQODZdil/+i0A5Mf03ND
        l/eJkTtmFqV/j4Xt6uu5wCKzzhZ3Aqgggru3QBQHmndvGFs5V52u6kuyT28fOYKT/pMy8e
        k95B7Pg6d6dIdLf3CxkZ7LZ2//zfVGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660787537;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MsCpnIDEIoiyaQnhIzHQLWmymVdVFy3Ho7omdhkjihc=;
        b=1sjxClkHneUeo0L1WTf1wz9otdvBOsDivd/lHqCUPNxfADJ8DrCW2VWI3O6lj9/p1aYZ1u
        thWQnIvvVdCOnCAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4247B13434;
        Thu, 18 Aug 2022 01:52:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dh8RO06b/WLQXwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 18 Aug 2022 01:52:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Dave Chinner" <david@fromorbit.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs: fix i_version handling in xfs
In-reply-to: <20220818013251.GC3600936@dread.disaster.area>
References: <20220816131736.42615-1-jlayton@kernel.org>,
 <Yvu7DHDWl4g1KsI5@magnolia>,
 <e77fd4d19815fd661dbdb04ab27e687ff7e727eb.camel@kernel.org>,
 <20220816224257.GV3600936@dread.disaster.area>,
 <166078288043.5425.8131814891435481157@noble.neil.brown.name>,
 <20220818013251.GC3600936@dread.disaster.area>
Date:   Thu, 18 Aug 2022 11:52:12 +1000
Message-id: <166078753200.5425.8997202026343224290@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 18 Aug 2022, Dave Chinner wrote:
> 
> > Maybe we should just go back to using ctime.  ctime is *exactly* what
> > NFSv4 wants, as long as its granularity is sufficient to catch every
> > single change.  Presumably XFS doesn't try to ensure this.  How hard
> > would it be to get any ctime update to add at least one nanosecond?
> > This would be enabled by a mount option, or possibly be a direct request
> > from nfsd.
> 
> We can't rely on ctime to be changed during a modification because
> O_NOCMTIME exists to enable "user invisible" modifications to be
> made. On XFS these still bump iversion, so while they are invisible
> to the user, they are still tracked by the filesystem and anything
> that wants to know if the inode data/metadata changed.
> 

O_NOCMTIME isn't mentioned in the man page, so it doesn't exist :-(

If they are "user invisible", should they then also be "NFS invisible"?
I think so.
As I understand it, the purpose of O_NOCMTIME is to allow optimisations
- do a lot of writes, then update the mtime, thus reducing latency.  I
think it is perfectly reasonable for all of that to be invisible to NFS.

NeilBrown
