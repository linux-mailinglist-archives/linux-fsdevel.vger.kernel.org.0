Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771E0483449
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 16:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbiACPen (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 10:34:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48424 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiACPem (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:34:42 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CE49C1F386;
        Mon,  3 Jan 2022 15:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641224081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oAyNsVFt7bVr7gCrB5/8iHXsWlY0nBTExzlSITo8HMs=;
        b=iciOmgltFZJ/2mkVUxI2wYfcLn0qCZOlSHWgbLRqdx3+uCda1/1HmIQGWoot8iaCj3VwVo
        x1HyDT4JdaruUN3WEN0mpQCq4fHwBMVHA/r+W/v0mXzn0TJutebSNOSHLGdU1d1ynHPtAo
        TjG8EzjPUTH1nMXys40H0oVujaHHBFU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82ACA13AED;
        Mon,  3 Jan 2022 15:34:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dDfFHZEX02FbdgAAMHmgww
        (envelope-from <mwilck@suse.com>); Mon, 03 Jan 2022 15:34:41 +0000
Message-ID: <ad5272b5b63acf64a47b707d95ecc288d113d637.camel@suse.com>
Subject: Re: [PATCH] ext4: Avoid trim error on fs with small groups
From:   Martin Wilck <mwilck@suse.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        mwilck@suse.de, linux-fsdevel@vger.kernel.org
Date:   Mon, 03 Jan 2022 16:34:40 +0100
In-Reply-To: <20211122135304.uwyqtm7cqc2fhjii@work>
References: <20211112152202.26614-1-jack@suse.cz>
         <20211115114821.swt3nqtw2pdgahsq@work>
         <20211115125141.GD23412@quack2.suse.cz>
         <59b60aae9401a043f7d7cec0f8004f2ca7d4f4db.camel@suse.com>
         <20211115145312.g4ptf22rl55jf37l@work>
         <4e4d1ac7735c38f1395db19b97025bf411982b60.camel@suse.com>
         <20211116115626.anbvho4xtb5vsoz5@work>
         <yq1y25n8lpb.fsf@ca-mkp.ca.oracle.com>
         <0a3061a3f443c86cf3b38007e85c51d94e9d7845.camel@suse.com>
         <20211122135304.uwyqtm7cqc2fhjii@work>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-11-22 at 14:53 +0100, Lukas Czerner wrote:
> On Fri, Nov 19, 2021 at 04:43:53PM +0100, Martin Wilck wrote:
> > Hi Martin, Lukas,
> > 
> > On Tue, 2021-11-16 at 23:35 -0500, Martin K. Petersen wrote:
> > 
> 
> Thanks you Martin P. for clarifying.
> 
> > 
> > I've checked btrfs and xfs, and they treat the minlen like Jan's
> > patch
> > would - the minlen is set to the device's granularity, and
> > discarding
> > smaller ranges is silently not even attempted.
> > 
> > So this seems to be common practice among file system
> > implementations,
> > and thus Jan's patch would make ext4 behave like the others. But
> > I'm
> > still uncertain if this behavior is ideal, and your remarks seem to
> > confirm that.
> 
> Yeah I modeled my change for ext4 on the work in xfs done by
> Christoph
> and so it kind of spread organically to other file systems.

Ok. I still believe that it's not ideal this way, but this logic is
only applied in corner cases AFAICS, so it doesn't really hurt.

I'm fine with Jan's patch for the time being.

> 
> > 
> > The fstrim man page text is highly misleading. "The default value
> > is
> > zero, discarding every free block" is obviously wrong, given the
> > current actual behavior of the major filesystems.
> 
> Originally there was no discard granularity optimization so it is
> what
> it meant. 

Not quite. That man page text is from 2019, commit ce3d198d7 ("fstrim:
document kernel return minlen explicitly"). At that time,
discard_granularity had existed for 10 years already.


> And it also says "fstrim will adjust the minimum if it's
> smaller than the device's minimum". So I am not sure if it's
> necessarily
> misleading.

It is misleading, because it's not fstrim that adjusts anything, but
the file system code in the kernel.

> 
> Still I think it should be best effort from the fs, not guarantee.
> 
> > 
> > The way this is currently implemented, the user has no way to
> > actually
> > "discard every free block" to the extent supported by the device. I
> > think that being able to do this would be desirable, at least in
> > certain situations.
> > 
> > If we changed this, with the default value of 0 used by fstrim,
> > file
> > systems would attempt to free every block, which is slow and would
> > likely either fail or have no effect on may devices. Maybe we
> > should
> > treat the value "0" like "automatic", i.e. adjust it the minlen to
> > the
> > device's granularity like we do now, but leave the value unchanged
> > if
> > the user explicitly sets a small non-zero value? That way "fstrim -
> > m
> > 512" could be used to force discarding every block that can be
> > discarded.
> 
> Perhaps, this sounds like a reasonable solution to me.

This could be implemented in a second step, then.

Thanks,
Martin



