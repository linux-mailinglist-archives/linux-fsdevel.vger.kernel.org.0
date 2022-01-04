Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D969D4866E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 16:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240600AbiAFPpq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 10:45:46 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47144 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240568AbiAFPpp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:45:45 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E4CE11F385;
        Thu,  6 Jan 2022 15:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641483944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HHf6b5SDnLgteW06CWv4rzYUGvWGdL/4iQeG7WDh2xk=;
        b=dF7ti5OI5x7CFCcsDY2CFlaj5P0OBMvDb7AeL2pC9j+pHENqt9V7knnV5t5Acve4Z2/jny
        8RdoYnfyouqAuDMyxN5Y+qnS77IvKoRh0zzq9j0EOvtpVsDrCC/kFyU5Dag2G06XctIOtf
        ddvMT8dxu1vQ52GP+A4wsYidsyo0WeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641483944;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HHf6b5SDnLgteW06CWv4rzYUGvWGdL/4iQeG7WDh2xk=;
        b=SsIkIDX3b4OhxGb9k4nYQtpIVViYNpVZL7yikzdfCOiAbmdQM8jc5oCnkGd+YBbX4s/Y/g
        oOVeQWuyucn6msCw==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D6506A3B83;
        Thu,  6 Jan 2022 15:45:44 +0000 (UTC)
Received: by localhost (Postfix, from userid 1000)
        id 994A4A05E8; Tue,  4 Jan 2022 15:55:11 +0100 (CET)
Date:   Tue, 4 Jan 2022 15:55:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Martin Wilck <mwilck@suse.com>, Jan Kara <jack@suse.cz>,
        Ted Tso <tytso@mit.edu>, mwilck@suse.de,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext4: Avoid trim error on fs with small groups
Message-ID: <20220104145511.u4sfkid4ltgrqlqg@quack3.lan>
References: <20211115125141.GD23412@quack2.suse.cz>
 <59b60aae9401a043f7d7cec0f8004f2ca7d4f4db.camel@suse.com>
 <20211115145312.g4ptf22rl55jf37l@work>
 <4e4d1ac7735c38f1395db19b97025bf411982b60.camel@suse.com>
 <20211116115626.anbvho4xtb5vsoz5@work>
 <yq1y25n8lpb.fsf@ca-mkp.ca.oracle.com>
 <0a3061a3f443c86cf3b38007e85c51d94e9d7845.camel@suse.com>
 <20211122135304.uwyqtm7cqc2fhjii@work>
 <ad5272b5b63acf64a47b707d95ecc288d113d637.camel@suse.com>
 <20220103185940.z5dnjj2shquz7yvg@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220103185940.z5dnjj2shquz7yvg@work>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 03-01-22 19:59:40, Lukas Czerner wrote:
> On Mon, Jan 03, 2022 at 04:34:40PM +0100, Martin Wilck wrote:
> > On Mon, 2021-11-22 at 14:53 +0100, Lukas Czerner wrote:
> > > On Fri, Nov 19, 2021 at 04:43:53PM +0100, Martin Wilck wrote:
> > > > Hi Martin, Lukas,
> > > > 
> > > > On Tue, 2021-11-16 at 23:35 -0500, Martin K. Petersen wrote:
> > > > 
> > > 
> > > Thanks you Martin P. for clarifying.
> > > 
> > > > 
> > > > I've checked btrfs and xfs, and they treat the minlen like Jan's
> > > > patch
> > > > would - the minlen is set to the device's granularity, and
> > > > discarding
> > > > smaller ranges is silently not even attempted.
> > > > 
> > > > So this seems to be common practice among file system
> > > > implementations,
> > > > and thus Jan's patch would make ext4 behave like the others. But
> > > > I'm
> > > > still uncertain if this behavior is ideal, and your remarks seem to
> > > > confirm that.
> > > 
> > > Yeah I modeled my change for ext4 on the work in xfs done by
> > > Christoph
> > > and so it kind of spread organically to other file systems.
> > 
> > Ok. I still believe that it's not ideal this way, but this logic is
> > only applied in corner cases AFAICS, so it doesn't really hurt.
> > 
> > I'm fine with Jan's patch for the time being.
> > 
> > > 
> > > > 
> > > > The fstrim man page text is highly misleading. "The default value
> > > > is
> > > > zero, discarding every free block" is obviously wrong, given the
> > > > current actual behavior of the major filesystems.
> > > 
> > > Originally there was no discard granularity optimization so it is
> > > what
> > > it meant. 
> > 
> > Not quite. That man page text is from 2019, commit ce3d198d7 ("fstrim:
> > document kernel return minlen explicitly"). At that time,
> > discard_granularity had existed for 10 years already.
> 
> Not really, the sentence you're pointing out above was there from the
> beginning. Commit ce3d198d7 didn't change that.
> 
> > 
> > 
> > > And it also says "fstrim will adjust the minimum if it's
> > > smaller than the device's minimum". So I am not sure if it's
> > > necessarily
> > > misleading.
> > 
> > It is misleading, because it's not fstrim that adjusts anything, but
> > the file system code in the kernel.
> 
> This makes absolutely no difference from the user POV. Enough nitpicking,
> feel free to cc me if you decide to send a patch.

So I think the conclusion is that we go with my original patch? Just I
should update it to return computed minlen back to the user, correct?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
