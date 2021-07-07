Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006933BECAC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 18:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhGGRBF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 13:01:05 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50852 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230376AbhGGRBE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 13:01:04 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 167Gw96L029559
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jul 2021 12:58:10 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CA98E15C3CC6; Wed,  7 Jul 2021 12:58:09 -0400 (EDT)
Date:   Wed, 7 Jul 2021 12:58:09 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@lst.de>
Cc:     leah.rumancik@gmail.com, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH] ext4: fix EXT4_IOC_CHECKPOINT
Message-ID: <YOXdIZARJ0Rwtfbd@mit.edu>
References: <20210707085644.3041867-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707085644.3041867-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 07, 2021 at 10:56:44AM +0200, Christoph Hellwig wrote:
> Issuing a discard for any kind of "contention deletion SLO" is highly
> dangerous as discard as defined by Linux (as well the underlying NVMe,
> SCSI, ATA, eMMC and virtio primitivies) are defined to not guarantee
> erasing of data but just allow optional and nondeterministic reclamation
> of space.  Instead issuing write zeroes is the only think to perform
> such an operation.  Remove the highly dangerous and misleading discard
> mode for EXT4_IOC_CHECKPOINT and only support the write zeroes based
> on, and clean up the resulting mess including the dry run mode.

A discard is not "dangerous"; how it behaves is simply not necessarily
guaranteed by the standards specification.  The userspace which uses
the ioctl simply needs to know how a particular block device might
react when it is given a discard.

I'll note that there is a similar issue with "WRITE SAME" or "ZEROOUT.
A WRITE SAME might take a fraction of a second --- or it might take
days --- depending on how the storage device is implemented.  It is
similarly unspecified by the various standards specification.  Hence,
userspace needs to know something about the block device before
deciding whether or not it would be good idea to issue a "WRITE SAME"
operation for large number of blocks.

This is why the API is implemented in terms of what command will be
issued to the block device, and not what the semantic meaning is for
that particular command.  That's up to the userspace application to
know out of band, and we should be able to give the privileged
application the freedom to decide which command makes the most amount
of sense.

	 	      	  	    		   - Ted
