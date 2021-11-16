Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB37A453188
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 12:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbhKPL7i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 06:59:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57089 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235497AbhKPL7e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:59:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637063797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=39q5UvO20+ragowCuiWUsqvbWoWPCmmn1g4P+luKXQA=;
        b=YnUzWCVF7F4FU7eOZAGAH+Pr2i+rR/OKEWPIkyX1OWLGllVc6o1jxdRQn9tw2M+2wlWa41
        SilgHt4yIc90rGN2BLx6m1a2U24+lUGTterdlnT8ukhuMc5AM4zqD6LQscWURdqy151QcL
        K010psL7FeXvwzf6oWSKU6WezWKFAcg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-EaDsUAcLMdSGxo6S_OaIMw-1; Tue, 16 Nov 2021 06:56:33 -0500
X-MC-Unique: EaDsUAcLMdSGxo6S_OaIMw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24850802C94;
        Tue, 16 Nov 2021 11:56:32 +0000 (UTC)
Received: from work (unknown [10.40.195.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 868B05DEFA;
        Tue, 16 Nov 2021 11:56:30 +0000 (UTC)
Date:   Tue, 16 Nov 2021 12:56:26 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Martin Wilck <mwilck@suse.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>, mwilck@suse.de,
        martin.petersen@oracle.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext4: Avoid trim error on fs with small groups
Message-ID: <20211116115626.anbvho4xtb5vsoz5@work>
References: <20211112152202.26614-1-jack@suse.cz>
 <20211115114821.swt3nqtw2pdgahsq@work>
 <20211115125141.GD23412@quack2.suse.cz>
 <59b60aae9401a043f7d7cec0f8004f2ca7d4f4db.camel@suse.com>
 <20211115145312.g4ptf22rl55jf37l@work>
 <4e4d1ac7735c38f1395db19b97025bf411982b60.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e4d1ac7735c38f1395db19b97025bf411982b60.camel@suse.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 15, 2021 at 04:10:12PM +0100, Martin Wilck wrote:
> On Mon, 2021-11-15 at 15:53 +0100, Lukas Czerner wrote:
> > On Mon, Nov 15, 2021 at 03:22:02PM +0100, Martin Wilck wrote:
> > > On Mon, 2021-11-15 at 13:51 +0100, Jan Kara wrote:
> > > > [Added Martin to CC who originally found the problem]
> > > > 
> > > > On Mon 15-11-21 12:48:21, Lukas Czerner wrote:
> > > > > On Fri, Nov 12, 2021 at 04:22:02PM +0100, Jan Kara wrote:
> > > > > > A user reported FITRIM ioctl failing for him on ext4 on some
> > > > > > devices
> > > > > > without apparent reason.  After some debugging we've found
> > > > > > out
> > > > > > that
> > > > > > these devices (being LVM volumes) report rather large discard
> > > > > > granularity of 42MB and the filesystem had 1k blocksize and
> > > > > > thus
> > > > > > group
> > > > > > size of 8MB. Because ext4 FITRIM implementation puts discard
> > > > > > granularity into minlen, ext4_trim_fs() declared the trim
> > > > > > request
> > > > > > as
> > > > > > invalid. However just silently doing nothing seems to be a
> > > > > > more
> > > > > > appropriate reaction to such combination of parameters since
> > > > > > user
> > > > > > did
> > > > > > not specify anything wrong.
> > > > > 
> > > > > Hi Jan,
> > > > > 
> > > > > I agree that it's better to silently do nothing rather than
> > > > > returning
> > > > > -ENOTSUPP in this case and the patch looks mostly fine.
> > > > > 
> > > > > However currently we return the adjusted minlen back to the
> > > > > user
> > > > > and it
> > > > > is also stated in the fstrim man page. I think it's worth
> > > > > keeping
> > > > > that
> > > > > behavior.
> > > > 
> > > > OK.
> > > > 
> > > > > When I think about it, it would probably be worth updating
> > > > > fstrim
> > > > > to
> > > > > notify the user that the minlen changed, I can send a patch for
> > > > > that.
> > > > 
> > > > I've added Martin to this conversation because he is of the
> > > > opinion
> > > > that
> > > > the filesystem actually should not increase the minlen based on
> > > > discard
> > > > granularity at all. It should leave this to the lower layers or
> > > > userspace.
> > > > Honestly I don't have strong opinion either way so I wanted to
> > > > throw
> > > > Martin's opinion into the mix as a possibility. Also maybe you
> > > > remember
> > > > whether the motivation of the original commit 5c2ed62fd447 was
> > > > motivated by
> > > > some real world experience or just theoretical concerns?
> > > > 
> > > >                                                                 H
> > > > onza
> > > 
> > > Thanks for notifying me, Jan. FTR, below's my argument, quoted from
> > > bugzilla:
> > > 
> > > Whether or not the discard *can* be carried out, and whether it
> > > makes
> > > sense to do so on any given device, is not the file system's
> > > business.
> > > It's up to the block layer and the device itself. And whether or
> > > not
> > > blocks *should* be discarded isn't the filesystem's business,
> > > either;
> > > it's the decision of user space (*).
> > > 
> > > I find it strange that file system code starts reasoning whether
> > > block
> > > IO commands are "likely" to succeed or fail. IMO the only valid
> > > reason
> > > for the filesystem to intervene would be if the result of the
> > > FITRIM
> > > would be a suboptimal block allocation, causing performance
> > > deterioration for future filesystem I/O. I don't see that that's
> > > the
> > > case here. 
> > 
> > It is not a matter of probability, or chance as you seem to imply.
> > The
> > discard granularity indicates the internal allocation unit and if the
> > discard request is smaller than that it will do nothing. So from my
> > POV
> > it's just an optimization to avoid sending such pointless requests.
> > 
> > Am I wrong in thinking that such discard requests are useless ?
> 
> Please have a look at __blkdev_issue_discard():
> https://elixir.bootlin.com/linux/latest/source/block/blk-lib.c#L26
> 
> Unless I'm misreading the code, it does very well pass REQ_OP_DISCARD
> bios to the device which don't meet the granularity or alignment
> requirements. It tries to align as well as possible, but the first and
> last bio submitted don't necessarily match the granularity.
> 
> For SCSI at least, unmap granularity is mainly a means for
> optimization: "An unmap request with a number of logical blocks that is
> not a multiple of this value may result in unmap operations on fewer
> LBAs than requested" (SBC5, §6.6.4). So, devices _may_ ignore such
> requests, but that's not necessarily the case.

My understanding always was that the request needs to be both properly
aligned and of a certain minimum size (discard_granularity) to take
effect.

If what you're saying is true then I feel like the documentation of
discard_granularity

Documentation/ABI/testing/sysfs-block
Documentation/block/queue-sysfs.rst

should change because that's not how I understand the notion of internal
allocation unit. However the sentence you quoted is not entirely clear
to me either so I'll leave that decision to someone who understands it
better than me.

Martin could you please clarify it for us ?

Adding Martin Petersen to cc and somehow we're off the list so add
fsdevel as well.

Thanks!
-Lukas

> 
> Another point is that only the block layer has full information about
> the alignment, which depends on partition start sectors. I believe the
> block layer should be the authority to decide whether or not the
> request is valid for the device.
> 
> Regards,
> Martin
> 

