Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B6F3D98E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 00:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhG1W3l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 18:29:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54174 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbhG1W3k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 18:29:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0125E1FFFE;
        Wed, 28 Jul 2021 22:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627511377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ONYWa9+/N3Daet5V4T3LbuLAO+s160OxeGegXg/uZC8=;
        b=HdXPnXDbuAyCwvlfakRU4iCHikkfTzJOXkcl+wqNwAi/zwtmFucKkP+FqtYgf485n1sDE0
        53bmzOldk2ZAn9Ksu4mcqXcp3h3aEji6WvHpUhsw3syHNXXtvuHcr4/SvtoBFI1ZB1Vg35
        Q8NFJk3CnTpT2LMP80PpXiDDk4sPEvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627511377;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ONYWa9+/N3Daet5V4T3LbuLAO+s160OxeGegXg/uZC8=;
        b=C7+gzVlLPOZ/5SMbsZDavKFsyx7pOiksMoEOMSspyKDpzJEiCOjOW6/OWZnebmijzpch/w
        VJEAqNP5clmTBlBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15BBD13BC4;
        Wed, 28 Jul 2021 22:29:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ho9aMU3aAWEUXgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 28 Jul 2021 22:29:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 09/11] nfsd: Allow filehandle lookup to cross internal
 mount points.
In-reply-to: <20210728191539.GB3152@fieldses.org>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <162742546556.32498.16708762469227881912.stgit@noble.brown>,
 <20210728191539.GB3152@fieldses.org>
Date:   Thu, 29 Jul 2021 08:29:31 +1000
Message-id: <162751137120.21659.13367329474467230018@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 29 Jul 2021, J. Bruce Fields wrote:
> On Wed, Jul 28, 2021 at 08:37:45AM +1000, NeilBrown wrote:
> > Enhance nfsd to detect internal mounts and to cross them without
> > requiring a new export.
> 
> Why don't we want a new export?
> 
> (Honest question, it's not obvious to me what the best behavior is.)

Because a new export means asking user-space to determine if the mount
is exported and to provide a filehandle-prefix for it.  A large part of
the point of this it to avoid using a different filehandle-prefix.

I haven't yet thought deeply about how the 'crossmnt' flag (for v3)
should affect crossing these internal mounts.  My current feeling is
that it shouldn't as it really is just one big filesystem being
exported, which happens to internally have different inode-number
spaces. 
Unfortuantely this technically violates the RFC as the fsid is not meant
to change when you do a LOOKUP ...

NeilBrown

