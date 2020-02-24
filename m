Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 459CF16B33F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 22:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgBXVxt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 16:53:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45783 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727421AbgBXVxs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:53:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582581227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H4YTOFOiOnkKkiliUoZ/jqhMNCus3zHP0xUGk3kFXx8=;
        b=XYpQVvR2C6uTWntg+PdK4rRX6Xn42rCDLeHS2TuL+xdwCTQOY4zRIFABnrlBWo9wyzkydS
        5CFbpcvczsc93ptyxMtvxZSTtvgzEH7rCUYhtvGq26hrM6jJJTjD6Qia8e5M9dripW2nYs
        EkwUGzoOlOcaxnpDUCBxTaBMlclxeWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-s0mb0vPUOqKMXSwc_5rNKA-1; Mon, 24 Feb 2020 16:53:43 -0500
X-MC-Unique: s0mb0vPUOqKMXSwc_5rNKA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B71C4107ACC4;
        Mon, 24 Feb 2020 21:53:41 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A58CB8B77D;
        Mon, 24 Feb 2020 21:53:38 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Christoph Hellwig <hch@infradead.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept arbitrary offset and len
References: <20200218214841.10076-1-vgoyal@redhat.com>
        <20200218214841.10076-3-vgoyal@redhat.com>
        <x49lfoxj622.fsf@segfault.boston.devel.redhat.com>
        <20200220215707.GC10816@redhat.com>
        <x498skv3i5r.fsf@segfault.boston.devel.redhat.com>
        <20200221201759.GF25974@redhat.com>
        <20200223230330.GE10737@dread.disaster.area>
        <CAPcyv4ghusuMsAq8gSLJKh1fiKjwa8R_-ojVgjsttoPRqBd_Sg@mail.gmail.com>
        <x49blpop00m.fsf@segfault.boston.devel.redhat.com>
        <CAPcyv4gCA_oR8_8+zhAhMnqOga9GcpMX97S+x8_UD6zLEQ0Cew@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Mon, 24 Feb 2020 16:53:37 -0500
In-Reply-To: <CAPcyv4gCA_oR8_8+zhAhMnqOga9GcpMX97S+x8_UD6zLEQ0Cew@mail.gmail.com>
        (Dan Williams's message of "Mon, 24 Feb 2020 12:48:35 -0800")
Message-ID: <x49sgizodni.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

>> Let's just focus on reporting errors when we know we have them.
>
> That's the problem in my eyes. If software needs to contend with
> latent error reporting then it should always contend otherwise
> software has multiple error models to wrangle.

The only way for an application to know that the data has been written
successfully would be to issue a read after every write.  That's not a
performance hit most applications are willing to take.  And, of course,
the media can still go bad at a later time, so it only guarantees the
data is accessible immediately after having been written.

What I'm suggesting is that we should not complete a write successfully
if we know that the data will not be retrievable.  I wouldn't call this
adding an extra error model to contend with.  Applications should
already be checking for errors on write.

Does that make sense?  Are we talking past each other?

> Setting that aside we can start with just treating zeroing the same as
> the copy_from_iter() case and fail the I/O at the dax_direct_access()
> step.

OK.

> I'd rather have a separate op that filesystems can use to clear errors
> at block allocation time that can be enforced to have the correct
> alignment.

So would file systems always call that routine instead of zeroing, or
would they first check to see if there are badblocks?

-Jeff

