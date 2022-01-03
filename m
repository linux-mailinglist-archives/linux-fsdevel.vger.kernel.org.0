Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A40148374E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 19:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbiACS7v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 13:59:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235930AbiACS7u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 13:59:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641236389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D7IfqB4zPCzQSoJV/s4pB72Hc3OW2Ee/G74o39d7npI=;
        b=QNWHRGNKO+28Khkm29EmEGiHw7oN1wjo8OcK6pDhK36ytj14lBPfwQXJF1wZoHv0IuO5ty
        i8UTHVvwW+C1OqY8rOhXtoNsbG8TPM7NCLYdKzoUhl0dXM/2zcGymZl3kLZQb+fNATuFXL
        fT2+7LzRM6DUNZLRlbaPnGhKKWfF+2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-exIbtul3OU-AAqtCE1CqWQ-1; Mon, 03 Jan 2022 13:59:46 -0500
X-MC-Unique: exIbtul3OU-AAqtCE1CqWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E6DE801962;
        Mon,  3 Jan 2022 18:59:45 +0000 (UTC)
Received: from work (unknown [10.40.194.183])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E35B010A3BC3;
        Mon,  3 Jan 2022 18:59:43 +0000 (UTC)
Date:   Mon, 3 Jan 2022 19:59:40 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Martin Wilck <mwilck@suse.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>, mwilck@suse.de,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext4: Avoid trim error on fs with small groups
Message-ID: <20220103185940.z5dnjj2shquz7yvg@work>
References: <20211115114821.swt3nqtw2pdgahsq@work>
 <20211115125141.GD23412@quack2.suse.cz>
 <59b60aae9401a043f7d7cec0f8004f2ca7d4f4db.camel@suse.com>
 <20211115145312.g4ptf22rl55jf37l@work>
 <4e4d1ac7735c38f1395db19b97025bf411982b60.camel@suse.com>
 <20211116115626.anbvho4xtb5vsoz5@work>
 <yq1y25n8lpb.fsf@ca-mkp.ca.oracle.com>
 <0a3061a3f443c86cf3b38007e85c51d94e9d7845.camel@suse.com>
 <20211122135304.uwyqtm7cqc2fhjii@work>
 <ad5272b5b63acf64a47b707d95ecc288d113d637.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad5272b5b63acf64a47b707d95ecc288d113d637.camel@suse.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 03, 2022 at 04:34:40PM +0100, Martin Wilck wrote:
> On Mon, 2021-11-22 at 14:53 +0100, Lukas Czerner wrote:
> > On Fri, Nov 19, 2021 at 04:43:53PM +0100, Martin Wilck wrote:
> > > Hi Martin, Lukas,
> > > 
> > > On Tue, 2021-11-16 at 23:35 -0500, Martin K. Petersen wrote:
> > > 
> > 
> > Thanks you Martin P. for clarifying.
> > 
> > > 
> > > I've checked btrfs and xfs, and they treat the minlen like Jan's
> > > patch
> > > would - the minlen is set to the device's granularity, and
> > > discarding
> > > smaller ranges is silently not even attempted.
> > > 
> > > So this seems to be common practice among file system
> > > implementations,
> > > and thus Jan's patch would make ext4 behave like the others. But
> > > I'm
> > > still uncertain if this behavior is ideal, and your remarks seem to
> > > confirm that.
> > 
> > Yeah I modeled my change for ext4 on the work in xfs done by
> > Christoph
> > and so it kind of spread organically to other file systems.
> 
> Ok. I still believe that it's not ideal this way, but this logic is
> only applied in corner cases AFAICS, so it doesn't really hurt.
> 
> I'm fine with Jan's patch for the time being.
> 
> > 
> > > 
> > > The fstrim man page text is highly misleading. "The default value
> > > is
> > > zero, discarding every free block" is obviously wrong, given the
> > > current actual behavior of the major filesystems.
> > 
> > Originally there was no discard granularity optimization so it is
> > what
> > it meant. 
> 
> Not quite. That man page text is from 2019, commit ce3d198d7 ("fstrim:
> document kernel return minlen explicitly"). At that time,
> discard_granularity had existed for 10 years already.

Not really, the sentence you're pointing out above was there from the
beginning. Commit ce3d198d7 didn't change that.

> 
> 
> > And it also says "fstrim will adjust the minimum if it's
> > smaller than the device's minimum". So I am not sure if it's
> > necessarily
> > misleading.
> 
> It is misleading, because it's not fstrim that adjusts anything, but
> the file system code in the kernel.

This makes absolutely no difference from the user POV. Enough nitpicking,
feel free to cc me if you decide to send a patch.

Thanks!
-Lukas

