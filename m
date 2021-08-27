Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8533FA1B5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Aug 2021 01:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbhH0XLM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 19:11:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33124 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbhH0XLL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 19:11:11 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E422B1FF4C;
        Fri, 27 Aug 2021 23:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630105820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WYbq1NneIVkLuIYGBZZdCrJ1kTQXpgMd3oOVJl3BDig=;
        b=MmbN7fxYOCZu26ad7DTGliARr83akIVsKI0v7+5Ri5atGldJWx7NLhRENUYlIWBQvbCK+6
        FQv3AvFf3fR+NWypVMWOit5l/XOQWEtcmIYlMrTJ96gAIV14TIv2Al3uiGk4XXtP0r3bqp
        JoHeSIbnPeKLwNvcIFKTB6eebJ1X8wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630105820;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WYbq1NneIVkLuIYGBZZdCrJ1kTQXpgMd3oOVJl3BDig=;
        b=ZxdYj19DO/3coBHKotZV75i5Tm9O7H6FQCwZ78geKqVS28ZeHmaxElrAGSifSdXA1Kk6OY
        ptTW5wH+heLuocDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F16E13D7D;
        Fri, 27 Aug 2021 23:10:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6rQRO9lwKWFpJgAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 27 Aug 2021 23:10:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Christoph Hellwig" <hch@lst.de>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Christoph Hellwig" <hch@lst.de>,
        "David Howells" <dhowells@redhat.com>,
        torvalds@linux-foundation.org, trond.myklebust@primarydata.com,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Don't block writes to swap-files with ETXTBSY.
In-reply-to: <20210827151644.GB19199@lst.de>
References: <162993585927.7591.10174443410031404560@noble.neil.brown.name>,
 <20210827151644.GB19199@lst.de>
Date:   Sat, 28 Aug 2021 09:10:15 +1000
Message-id: <163010581548.7591.7557563272768619093@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 28 Aug 2021, Christoph Hellwig wrote:
> On Thu, Aug 26, 2021 at 09:57:39AM +1000, NeilBrown wrote:
> > 
> > Commit dc617f29dbe5 ("vfs: don't allow writes to swap files")
> > broke swap-over-NFS as it introduced an ETXTBSY error when NFS tries to
> > swap-out using ->direct_IO().
> > 
> > There is no sound justification for this error.  File permissions are
> > sufficient to stop non-root users from writing to a swap file, and root
> > must always be cautious not to do anything dangerous.
> > 
> > These checks effectively provide a mandatory write lock on swap, and
> > mandatory locks are not supported in Linux.
> > 
> > So remove all the checks that return ETXTBSY when attempts are made to
> > write to swap.
> 
> Swap files are not just any files and do need a mandatory write lock
> as they are part of the kernel VM and writing to them will mess up
> the kernel badly.  David Howells actually has sent various patches
> to fix swap over NFS in the last weeks.
> 
> 
There are lots of different things root can do which will mess up the
kernel badly.  The backing-store can still be changed through some other
means.
Do you have a particular threat or risk scenario other than "root might
get careless"?

Yes, I've seen David's patches.  I posted this one because I think the
original patch which broke swap-over-NFS was not just unfortunate, but
wrong.  Permissions are how we protect files, not ETXTBSY.

NeilBrown
