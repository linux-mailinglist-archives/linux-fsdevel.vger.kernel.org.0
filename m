Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6697170BD8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 23:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgBZWsx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 17:48:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35927 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727841AbgBZWsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582757331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bl2QkrJDLwbDu4ZSTOfPGGOcOZ8+qVxS2i6Atb12Bik=;
        b=Zu9jWQOybxnD3GGQHgBkX+sZ8dv//qg8E43QOP6NhAbyhSxW7gHSwJJFY5lSsvGBNGtqBH
        PpsgSMzSBNWb/rhuRTv9+SL7yggPfYssx86aHKOHtQ+bLEz8L/j9HNBG0J2MWnWgB6IQTj
        3N8c/EFa8kkbDD8nDcTsMZ7kU5IwsVs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-6ZcBhl4UPxmgSKsb3ltaFg-1; Wed, 26 Feb 2020 17:48:43 -0500
X-MC-Unique: 6ZcBhl4UPxmgSKsb3ltaFg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1AD0107ACC4;
        Wed, 26 Feb 2020 22:48:40 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A9F695D9CD;
        Wed, 26 Feb 2020 22:48:39 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V4 00/13] Enable per-file/per-directory DAX operations V4
References: <20200221004134.30599-1-ira.weiny@intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Wed, 26 Feb 2020 17:48:38 -0500
In-Reply-To: <20200221004134.30599-1-ira.weiny@intel.com> (ira weiny's message
        of "Thu, 20 Feb 2020 16:41:21 -0800")
Message-ID: <x49pne13qyh.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Ira,

ira.weiny@intel.com writes:

> From: Ira Weiny <ira.weiny@intel.com>
>
> https://github.com/weiny2/linux-kernel/pull/new/dax-file-state-change-v4
>
> Changes from V3: 
> https://lore.kernel.org/lkml/20200208193445.27421-1-ira.weiny@intel.com/
>
> 	* Remove global locking...  :-D
> 	* put back per inode locking and remove pre-mature optimizations
> 	* Fix issues with Directories having IS_DAX() set
> 	* Fix kernel crash issues reported by Jeff
> 	* Add some clean up patches
> 	* Consolidate diflags to iflags functions
> 	* Update/add documentation
> 	* Reorder/rename patches quite a bit

I left out patches 1 and 2, but applied the rest and tested.  This
passes xfs tests in the following configurations:
1) MKFS_OPTIONS="-m reflink=0" MOUNT_OPTIONS="-o dax"
2) MKFS_OPTIONS="-m reflink=0"
   but with the added configuration step of setting the dax attribute on
   the mounted test directory.

I also tested to ensure that reflink fails when a file has the dax
attribute set.  I've got more testing to do, but figured I'd at least
let you know I've been looking at it.

Thanks!
Jeff

