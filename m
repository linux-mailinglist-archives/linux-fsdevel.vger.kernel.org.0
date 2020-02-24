Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC26116AA4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 16:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbgBXPiv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 10:38:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50990 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727719AbgBXPiv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582558730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fLyonSIDC83RBTPHCM8f4o4yMY3G8tzoWeqc8LOk64E=;
        b=Zi/9lztac8zbbWNBUy+zTj1ELt6uK1iXOkRX2yw/znUkW36BxCe0xMuSCYRXqG/9GTX4b5
        7oMfU72Bh+OoxBwh14fxmwiFd2953hiKU6SpjzSDsejwmmW1dlrTposzjp6V7ATHlvvFiG
        Vr2S6CMXEMQS4cbfZnRRpgLjVfNDXuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202--esf3cAoOSmm3_PTQ-NYEw-1; Mon, 24 Feb 2020 10:38:48 -0500
X-MC-Unique: -esf3cAoOSmm3_PTQ-NYEw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EFB1800D5E;
        Mon, 24 Feb 2020 15:38:47 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6F125C1D6;
        Mon, 24 Feb 2020 15:38:44 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 571B3220A24; Mon, 24 Feb 2020 10:38:44 -0500 (EST)
Date:   Mon, 24 Feb 2020 10:38:44 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, hch@infradead.org,
        dan.j.williams@intel.com, dm-devel@redhat.com
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
Message-ID: <20200224153844.GB14651@redhat.com>
References: <20200218214841.10076-1-vgoyal@redhat.com>
 <20200218214841.10076-3-vgoyal@redhat.com>
 <x49lfoxj622.fsf@segfault.boston.devel.redhat.com>
 <20200220215707.GC10816@redhat.com>
 <x498skv3i5r.fsf@segfault.boston.devel.redhat.com>
 <20200221201759.GF25974@redhat.com>
 <20200223230330.GE10737@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223230330.GE10737@dread.disaster.area>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 24, 2020 at 10:03:30AM +1100, Dave Chinner wrote:

[..]
> > > > Hi Jeff,
> > > >
> > > > New dax zeroing interface (dax_zero_page_range()) can technically pass
> > > > a range which is less than a sector. Or which is bigger than a sector
> > > > but start and end are not aligned on sector boundaries.
> > > 
> > > Sure, but who will call it with misaligned ranges?
> > 
> > create a file foo.txt of size 4K and then truncate it.
> > 
> > "truncate -s 23 foo.txt". Filesystems try to zero the bytes from 24 to
> > 4095.
> 
> This should fail with EIO. Only full page writes should clear the
> bad page state, and partial writes should therefore fail because
> they do not guarantee the data in the filesystem block is all good.
> 
> If this zeroing was a buffered write to an address with a bad
> sector, then the writeback will fail and the user will (eventually)
> get an EIO on the file.
> 
> DAX should do the same thing, except because the zeroing is
> synchronous (i.e. done directly by the truncate syscall) we can -
> and should - return EIO immediately.
> 
> Indeed, with your code, if we then extend the file by truncating up
> back to 4k, then the range between 23 and 512 is still bad, even
> though we've successfully zeroed it and the user knows it. An
> attempt to read anywhere in this range (e.g. 10 bytes at offset 100)
> will fail with EIO, but reading 10 bytes at offset 2000 will
> succeed.

Hi Dave,

What is expected if I do "truncate -s 512 foo.txt". Say first sector (0 to
511) is poisoned and rest don't have poison. Should this fail with -EIO.

In current implementation it does not. Because all sector aligned I/O
we redirect through blkdev_issue_zeroout() and that will happly zero
out sector 2-8 without worrying about the state of sector 1. Hence user
which tries to read 10 bytes at offset 100, will still fail. This probably
should be fixed if we want to retain existing behavior.

Anyway, partial page truncate can't ensure that data in rest of the page can
be read back successfully. Memory can get poison after the write and
hence read after truncate will still fail.

Hence, all we are trying to ensure is that if a poison is known at the
time of writing partial page, then we should return error to user space.

Thanks
Vivek

