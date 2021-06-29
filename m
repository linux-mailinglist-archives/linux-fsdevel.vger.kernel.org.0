Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289713B6C1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 03:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhF2BqS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 21:46:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46070 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhF2BqS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 21:46:18 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B066522591;
        Tue, 29 Jun 2021 01:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624931030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N/v6ruOskTZuNS5Lf75yej846j0Xxi6IjfLJtdl9E1M=;
        b=eoAZTuDzpADThpozHNbWzs6nZxCo4Q1CCyJG4ME5G2/j8U27KIW3aGKYer2s4yFIxZRS3r
        ODQwPvTKFBdBV3PeBKG48VEPfns3p/hCSxIu7bE6WJ76Yhb2AQh1G9MXPPdZJleC0FDRNn
        goUPup2A3r8134dfHUFluCUdj5XjcM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624931030;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N/v6ruOskTZuNS5Lf75yej846j0Xxi6IjfLJtdl9E1M=;
        b=oM/32IpeFXaHG0UD49i84X+L5ymFJlfC1AErQNZFb1DEss4Tre2xuKWH5vE/y1qoua3iim
        wRG0b/gVPvCD8xAA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id BA82A11906;
        Tue, 29 Jun 2021 01:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624931030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N/v6ruOskTZuNS5Lf75yej846j0Xxi6IjfLJtdl9E1M=;
        b=eoAZTuDzpADThpozHNbWzs6nZxCo4Q1CCyJG4ME5G2/j8U27KIW3aGKYer2s4yFIxZRS3r
        ODQwPvTKFBdBV3PeBKG48VEPfns3p/hCSxIu7bE6WJ76Yhb2AQh1G9MXPPdZJleC0FDRNn
        goUPup2A3r8134dfHUFluCUdj5XjcM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624931030;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N/v6ruOskTZuNS5Lf75yej846j0Xxi6IjfLJtdl9E1M=;
        b=oM/32IpeFXaHG0UD49i84X+L5ymFJlfC1AErQNZFb1DEss4Tre2xuKWH5vE/y1qoua3iim
        wRG0b/gVPvCD8xAA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id FFhvGtR62mANHgAALh3uQQ
        (envelope-from <neilb@suse.de>); Tue, 29 Jun 2021 01:43:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
Cc:     "Trond Myklebust" <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: automatic freeing of space on ENOSPC
In-reply-to: <20210629011200.GA14733@fieldses.org>
References: <20210628194908.GB6776@fieldses.org>,
 <9f1263b46d5c38b9590db1e2a04133a83772bc50.camel@hammerspace.com>,
 <20210629011200.GA14733@fieldses.org>
Date:   Tue, 29 Jun 2021 11:43:45 +1000
Message-id: <162493102550.7211.15170485925982544813@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 29 Jun 2021, bfields@fieldses.org wrote:
> On Tue, Jun 29, 2021 at 12:43:14AM +0000, Trond Myklebust wrote:
> > How about just setting up a notification for unlink on those files, the
> > same way we set up notifications for close with the NFSv3 filecache in
> > nfsd?
> 
> Yes, that'd probably work.  It'd be better if we didn't have to throw
> away unlinked files when the client expires, but it'd still be an
> incremental improvement over what we do now.

I wonder how important this is.  If an NFS client unlinks a file that it
has open, it will be silly_renamed, and if the client then goes silent,
it might never be removed.  So we already theoretically have a
possibilty of ENOSPC due to silent clients.  Have we heard of this
becoming a problem?
Is there reason to think that the Courteous server changes will make
this problem more likely? 

NeilBrown
