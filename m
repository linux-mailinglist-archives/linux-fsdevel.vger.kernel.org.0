Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B473F6B1216
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 20:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjCHTfl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 14:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCHTfk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:35:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF49C60D62;
        Wed,  8 Mar 2023 11:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2QbddD5xduC1xSLvUGdJZJ/ndrX2mu9hny7kJ+ioXjA=; b=KhzIhWrnkpPrgWPp+Ye4kUuYtv
        V9NFlwAvM4cQVeypfNXxBMaFj4XFkRMBmI9nSfdw2abRFSSOb1XfAUTHPh8xgDP5X8MFdDQkGzOTk
        LrtK7F1ebzv6c4iD/HF15JnnwZN42i9Cya6rxUNHX0ZmkJcK6b8IlKmO1PJKN3mjSVHxWQx2jPeCA
        6bHMaenJmeHyOXqKgL9cP3QVT4t0dcnggLULB/nMb7PqAyh6FERljFJoBeWYxdwXO9MgrWxaZxhwm
        0liV8xqaEopRbxeQ5/cwMA7p50HpCfUCuLJvjXdZhPtzQn3kR55v10nMFZ6NwOSJuEZwoIcOb6oPh
        xlZIzZNw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZzZU-006Yh8-D4; Wed, 08 Mar 2023 19:35:32 +0000
Date:   Wed, 8 Mar 2023 11:35:32 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Keith Busch <kbusch@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <ZAjjhNV2L3e/G2CX@bombadil.infradead.org>
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <ZAJqjM6qLrraFrrn@bombadil.infradead.org>
 <c9f6544d-1731-4a73-a926-0e85ae9da9df@suse.de>
 <ZAN2HYXDI+hIsf6W@casper.infradead.org>
 <edac909b-98e5-cb6d-bb80-2f6a20a15029@suse.de>
 <ZAOF3p+vqA6pd7px@casper.infradead.org>
 <0b70deae-9fc7-ca33-5737-85d7532b3d33@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b70deae-9fc7-ca33-5737-85d7532b3d33@suse.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 05, 2023 at 12:22:15PM +0100, Hannes Reinecke wrote:
> One can view zones as really large LBAs.
> 
> Indeed it might be suboptimal from the OS point of view.
> But from the device point of view it won't.
> And, in fact, with devices becoming faster and faster the question is
> whether sticking with relatively small sectors won't become a limiting
> factor eventually.
> 
> My point being that zones are just there because the I/O stack can only deal
> with sectors up to 4k. If the I/O stack would be capable of dealing
> with larger LBAs one could identify a zone with an LBA, and the entire issue
> of append-only and sequential writes would be moot.
> Even the entire concept of zones becomes irrelevant as the OS would
> trivially only write entire zones.
> 
> What I was saying is that 256M is not set in stone. It's just a compromise
> vendors used. Even if in the course of development we arrive
> at a lower number of max LBA we can handle (say, 2MB) I am pretty
> sure vendors will be quite interested in that.

So I'm re-reading this again and I see what you're suggesting now Hannes.
                                                                                
You are not not suggesting that the reason why we may want larger block
sizes is due to zone storage support.  But rather, you are suggesting
that *if* we support larger block sizes, they effectively could be used
as a replacement for smaller zone sizes.  Your comments about 256 MiB
zones is just a target max assumption for existing known zones.

So in that sense, you seem to suggest that users of smaller zone sizes
could potentially look at using instead larger block sizes, as there
would be no other new "feature" other than existing efforts to ensure
higher folio support are in place and / buffer heads addressed.

But this misses the gains of zone storage on the FTL. The strong semantics
of sequential writes and a write pointer differ for how an existing storage
controller may deal with writing to *one* block. You are not forbidden to
just modify a bit in non-zone storage, behind the scenes for instance the
FTL would do whatever it thinks it has to, very likely a read-modify-write
and it may just splash the write into one fresh block for you, so the
write appears to happen in a flash but in reality it used a bit of the
over provisioning blocks. But with zone storage you have a considerable
reduction over over provisioning, which we don't get for with simple larger
block size support for non zone drives.

  Luis
