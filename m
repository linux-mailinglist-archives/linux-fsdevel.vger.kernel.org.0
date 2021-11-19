Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4F34571EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 16:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbhKSPq5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 10:46:57 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57638 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbhKSPq5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 10:46:57 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7CED41FD38;
        Fri, 19 Nov 2021 15:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637336634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gtZBcqbP2K4Krf2vifeo40uYgJpjivHWASvF0aVhHis=;
        b=nBLjx514c327+iwS2WX9SYNRbX5qbgGC1Mqh9/nxL6mKYEVw985tmPTUp6q5DW1Ib04iAp
        L5jCzoHIn2OzZGwSNHy8VdFamLkVFuZ+ZVzuAyiL0YkGMpG0X/FeXrtBmpwF15kNxtqEwU
        waFkAm0ZawR1wSh9m1pskX5IsP7pSe8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2657313B35;
        Fri, 19 Nov 2021 15:43:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m4ItBzrGl2EHJgAAMHmgww
        (envelope-from <mwilck@suse.com>); Fri, 19 Nov 2021 15:43:54 +0000
Message-ID: <0a3061a3f443c86cf3b38007e85c51d94e9d7845.camel@suse.com>
Subject: Re: [PATCH] ext4: Avoid trim error on fs with small groups
From:   Martin Wilck <mwilck@suse.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Lukas Czerner <lczerner@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>, mwilck@suse.de,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 19 Nov 2021 16:43:53 +0100
In-Reply-To: <yq1y25n8lpb.fsf@ca-mkp.ca.oracle.com>
References: <20211112152202.26614-1-jack@suse.cz>
         <20211115114821.swt3nqtw2pdgahsq@work>
         <20211115125141.GD23412@quack2.suse.cz>
         <59b60aae9401a043f7d7cec0f8004f2ca7d4f4db.camel@suse.com>
         <20211115145312.g4ptf22rl55jf37l@work>
         <4e4d1ac7735c38f1395db19b97025bf411982b60.camel@suse.com>
         <20211116115626.anbvho4xtb5vsoz5@work>
         <yq1y25n8lpb.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Martin, Lukas,

On Tue, 2021-11-16 at 23:35 -0500, Martin K. Petersen wrote:
> 
> Lukas,
> 
> > My understanding always was that the request needs to be both
> > properly
> > aligned and of a certain minimum size (discard_granularity) to take
> > effect.
> > 
> > If what you're saying is true then I feel like the documentation of
> > discard_granularity
> > 
> > Documentation/ABI/testing/sysfs-block
> > Documentation/block/queue-sysfs.rst
> > 
> > should change because that's not how I understand the notion of
> > internal allocation unit. However the sentence you quoted is not
> > entirely clear to me either so I'll leave that decision to someone
> > who
> > understands it better than me.
> > 
> > Martin could you please clarify it for us ?
> 
> The rationale behind exposing the discard granularity to userland was
> to
> facilitate mkfs.* picking allocation units that were friendly wrt. the
> device's internal granularity. The nature of that granularity depends
> on
> the type of device (thin provisioned, resource provisioned, SSD, etc.).
> 
> Just like the other queue limits the discard granularity was meant as a
> hint (some of that hintiness got lost as a result of conflating zeroing
> and deallocating but that has since been resolved).
> 
> It is true that some devices get confused if you submit discards that
> are smaller than their internal granularity. However, those devices are
> typically the ones that don't actually support reporting that
> granularity in the first place! Whereas SCSI devices generally don't
> care. They'll happily ignore any parts of the request that are smaller
> than whatever size they use internally.
> 
> One of the problems with "optimizing" away pieces that are smaller than
> the reported granularity is when you combine devices. Say you have a
> RAID1 of an SSD that reports 4096 bytes and one that reports 256MB. The
> stacked device will then have a discard granularity of 256MB and thus
> the SSD with the smaller granularity won't receive any of the discards
> that might otherwise help it manage its media.

I've checked btrfs and xfs, and they treat the minlen like Jan's patch
would - the minlen is set to the device's granularity, and discarding
smaller ranges is silently not even attempted.

So this seems to be common practice among file system implementations,
and thus Jan's patch would make ext4 behave like the others. But I'm
still uncertain if this behavior is ideal, and your remarks seem to
confirm that.

The fstrim man page text is highly misleading. "The default value is
zero, discarding every free block" is obviously wrong, given the
current actual behavior of the major filesystems.

The way this is currently implemented, the user has no way to actually
"discard every free block" to the extent supported by the device. I
think that being able to do this would be desirable, at least in
certain situations.

If we changed this, with the default value of 0 used by fstrim, file
systems would attempt to free every block, which is slow and would
likely either fail or have no effect on may devices. Maybe we should
treat the value "0" like "automatic", i.e. adjust it the minlen to the
device's granularity like we do now, but leave the value unchanged if
the user explicitly sets a small non-zero value? That way "fstrim -m
512" could be used to force discarding every block that can be
discarded.

Regards
Martin

