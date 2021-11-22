Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C23458FCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 14:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239211AbhKVN40 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 08:56:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45222 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229984AbhKVN4W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 08:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637589195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0246PD2XICo/e77HHQAu9cCnKYKbDQAO6t4HPdbCG7k=;
        b=KcOQPWiNb7mCsrDISiqQ72tbWYH8zuj252MRe2fEw2wIHGBWrs/rTLrlJ1rSELz1ClXEHS
        4q6FIjPcqb3N9z2+G237tRffxb7DYIkhESNJM6dJoKhRhjzbjcxpi/Khc0JlKmMWPgQy0C
        qQv382tF1vVigoVcqn0mH7cvWX7kFtw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-302-gRvtolrSOLOgasz1TEIGqg-1; Mon, 22 Nov 2021 08:53:12 -0500
X-MC-Unique: gRvtolrSOLOgasz1TEIGqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BD4E8066F5;
        Mon, 22 Nov 2021 13:53:11 +0000 (UTC)
Received: from work (unknown [10.40.194.228])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 79D4060843;
        Mon, 22 Nov 2021 13:53:09 +0000 (UTC)
Date:   Mon, 22 Nov 2021 14:53:04 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Martin Wilck <mwilck@suse.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        mwilck@suse.de, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext4: Avoid trim error on fs with small groups
Message-ID: <20211122135304.uwyqtm7cqc2fhjii@work>
References: <20211112152202.26614-1-jack@suse.cz>
 <20211115114821.swt3nqtw2pdgahsq@work>
 <20211115125141.GD23412@quack2.suse.cz>
 <59b60aae9401a043f7d7cec0f8004f2ca7d4f4db.camel@suse.com>
 <20211115145312.g4ptf22rl55jf37l@work>
 <4e4d1ac7735c38f1395db19b97025bf411982b60.camel@suse.com>
 <20211116115626.anbvho4xtb5vsoz5@work>
 <yq1y25n8lpb.fsf@ca-mkp.ca.oracle.com>
 <0a3061a3f443c86cf3b38007e85c51d94e9d7845.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a3061a3f443c86cf3b38007e85c51d94e9d7845.camel@suse.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 19, 2021 at 04:43:53PM +0100, Martin Wilck wrote:
> Hi Martin, Lukas,
> 
> On Tue, 2021-11-16 at 23:35 -0500, Martin K. Petersen wrote:
> > 
> > Lukas,
> > 
> > > My understanding always was that the request needs to be both
> > > properly
> > > aligned and of a certain minimum size (discard_granularity) to take
> > > effect.
> > > 
> > > If what you're saying is true then I feel like the documentation of
> > > discard_granularity
> > > 
> > > Documentation/ABI/testing/sysfs-block
> > > Documentation/block/queue-sysfs.rst
> > > 
> > > should change because that's not how I understand the notion of
> > > internal allocation unit. However the sentence you quoted is not
> > > entirely clear to me either so I'll leave that decision to someone
> > > who
> > > understands it better than me.
> > > 
> > > Martin could you please clarify it for us ?
> > 
> > The rationale behind exposing the discard granularity to userland was
> > to
> > facilitate mkfs.* picking allocation units that were friendly wrt. the
> > device's internal granularity. The nature of that granularity depends
> > on
> > the type of device (thin provisioned, resource provisioned, SSD, etc.).
> > 
> > Just like the other queue limits the discard granularity was meant as a
> > hint (some of that hintiness got lost as a result of conflating zeroing
> > and deallocating but that has since been resolved).
> > 
> > It is true that some devices get confused if you submit discards that
> > are smaller than their internal granularity. However, those devices are
> > typically the ones that don't actually support reporting that
> > granularity in the first place! Whereas SCSI devices generally don't
> > care. They'll happily ignore any parts of the request that are smaller
> > than whatever size they use internally.
> > 
> > One of the problems with "optimizing" away pieces that are smaller than
> > the reported granularity is when you combine devices. Say you have a
> > RAID1 of an SSD that reports 4096 bytes and one that reports 256MB. The
> > stacked device will then have a discard granularity of 256MB and thus
> > the SSD with the smaller granularity won't receive any of the discards
> > that might otherwise help it manage its media.

Thanks you Martin P. for clarifying.

> 
> I've checked btrfs and xfs, and they treat the minlen like Jan's patch
> would - the minlen is set to the device's granularity, and discarding
> smaller ranges is silently not even attempted.
> 
> So this seems to be common practice among file system implementations,
> and thus Jan's patch would make ext4 behave like the others. But I'm
> still uncertain if this behavior is ideal, and your remarks seem to
> confirm that.

Yeah I modeled my change for ext4 on the work in xfs done by Christoph
and so it kind of spread organically to other file systems.

> 
> The fstrim man page text is highly misleading. "The default value is
> zero, discarding every free block" is obviously wrong, given the
> current actual behavior of the major filesystems.

Originally there was no discard granularity optimization so it is what
it meant. And it also says "fstrim will adjust the minimum if it's
smaller than the device's minimum". So I am not sure if it's necessarily
misleading.

Still I think it should be best effort from the fs, not guarantee.

> 
> The way this is currently implemented, the user has no way to actually
> "discard every free block" to the extent supported by the device. I
> think that being able to do this would be desirable, at least in
> certain situations.
> 
> If we changed this, with the default value of 0 used by fstrim, file
> systems would attempt to free every block, which is slow and would
> likely either fail or have no effect on may devices. Maybe we should
> treat the value "0" like "automatic", i.e. adjust it the minlen to the
> device's granularity like we do now, but leave the value unchanged if
> the user explicitly sets a small non-zero value? That way "fstrim -m
> 512" could be used to force discarding every block that can be
> discarded.

Perhaps, this sounds like a reasonable solution to me.

> 
> Regards
> Martin
> 

