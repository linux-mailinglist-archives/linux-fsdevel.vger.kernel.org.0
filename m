Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960023BF4F8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 07:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhGHFPo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 01:15:44 -0400
Received: from verein.lst.de ([213.95.11.211]:39221 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhGHFPo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 01:15:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 60C4D68C4E; Thu,  8 Jul 2021 07:13:00 +0200 (CEST)
Date:   Thu, 8 Jul 2021 07:13:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@lst.de>, leah.rumancik@gmail.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] ext4: fix EXT4_IOC_CHECKPOINT
Message-ID: <20210708051300.GA18564@lst.de>
References: <20210707085644.3041867-1-hch@lst.de> <YOXdIZARJ0Rwtfbd@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOXdIZARJ0Rwtfbd@mit.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 07, 2021 at 12:58:09PM -0400, Theodore Ts'o wrote:
> A discard is not "dangerous"; how it behaves is simply not necessarily
> guaranteed by the standards specification.  The userspace which uses
> the ioctl simply needs to know how a particular block device might
> react when it is given a discard.

A discard itself is indeed not dangerous at all.  Using it to imply
any kind of data erasure OTOH is extremely dangerous, and that is
what this interface does.

> I'll note that there is a similar issue with "WRITE SAME" or "ZEROOUT.
> A WRITE SAME might take a fraction of a second --- or it might take
> days --- depending on how the storage device is implemented.  It is
> similarly unspecified by the various standards specification.  Hence,
> userspace needs to know something about the block device before
> deciding whether or not it would be good idea to issue a "WRITE SAME"
> operation for large number of blocks.

The same is true of discard.  There are plenty of devices where
discards are horrible slow.  There also are plenty of devices where
discard is a complete no-op.  Especially on NVMe where the discard
command (DSM deallocate) is mandatory to implement.

> This is why the API is implemented in terms of what command will be
> issued to the block device, and not what the semantic meaning is for
> that particular command.  That's up to the userspace application to
> know out of band, and we should be able to give the privileged
> application the freedom to decide which command makes the most amount
> of sense.

Stop claiming you actively misleading users with broken interfaces
freedom.

> 
> 	 	      	  	    		   - Ted
---end quoted text---
