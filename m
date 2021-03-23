Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F0234613F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 15:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhCWORy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 10:17:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27194 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232261AbhCWOQq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616509000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ecY1CzrvE1DPEu+sD2G/cZP9TNuYSjbK9W1EHfXolDw=;
        b=M7GAMfXqr8B5H/LhUTF2IlgI+Ty2EAIOXMsz+rQsA+w+BlCZOkYmua11woYOwci+xObPSf
        zm1XP9zdpRm+On8hSALX33cp2PaapPmJssPEQ8aeQndtqVfAhEOCDaKJAnPEF+Ps4jXRs0
        1aRrg+MGnnIUgR+L7vrLVv+5Ktg37BM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-exvroquTOx2NCDRTMVZpiw-1; Tue, 23 Mar 2021 10:16:39 -0400
X-MC-Unique: exvroquTOx2NCDRTMVZpiw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C2855B365;
        Tue, 23 Mar 2021 14:16:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E189C10016FD;
        Tue, 23 Mar 2021 14:16:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210323135116.GF1719932@casper.infradead.org>
References: <20210323135116.GF1719932@casper.infradead.org> <1885296.1616410586@warthog.procyon.org.uk> <20210321105309.GG3420@casper.infradead.org> <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk> <161539528910.286939.1252328699383291173.stgit@warthog.procyon.org.uk> <2499407.1616505440@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/28] mm: Add an unlock function for PG_private_2/PG_fscache
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2503809.1616508988.1@warthog.procyon.org.uk>
Date:   Tue, 23 Mar 2021 14:16:28 +0000
Message-ID: <2503810.1616508988@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Mar 23, 2021 at 01:17:20PM +0000, David Howells wrote:
> > +++ b/fs/afs/write.c
> > @@ -846,7 +846,7 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
> >  	 */
> >  #ifdef CONFIG_AFS_FSCACHE
> >  	if (PageFsCache(page) &&
> > -	    wait_on_page_bit_killable(page, PG_fscache) < 0)
> > +	    wait_on_page_fscache_killable(page) < 0)
> >  		return VM_FAULT_RETRY;
> >  #endif
> >  
> > @@ -861,7 +861,8 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
> >  	 * details the portion of the page we need to write back and we might
> >  	 * need to redirty the page if there's a problem.
> >  	 */
> > -	wait_on_page_writeback(page);
> > +	if (wait_on_page_writeback_killable(page) < 0)
> > +		return VM_FAULT_RETRY | VM_FAULT_LOCKED;
> 
> You forgot to unlock the page.

Do I need to?  Doesn't VM_FAULT_LOCKED indicate that to the caller?  Or is it
impermissible to do it like that?

> Also, if you're waiting killably here, do you need to wait before you get
> the page lock?  Ditto for waiting on fscache -- do you want to do that
> before or after you get the page lock?

I'm waiting both before and after.  If I wait before, write() can go and
trample over the page between PG_writeback/PG_fscache being cleared and us
getting the lock here.  Probably I should only be waiting after locking the
page.

> Also, I never quite understood why you needed to wait for fscache
> writes to finish before allowing the page to be dirtied.  Is this a
> wait_for_stable_page() kind of situation, where the cache might be
> calculating a checksum on it?  Because as far as I can tell, once the
> page is dirty in RAM, the contents of the on-disk cache are irrelevant ...
> unless they're part of a RAID 5 checksum kind of situation.

Um.  I do want to add disconnected operation in the future and cache
encryption, but, as things currently stand, it isn't necessary because the
cache object is marked "in use" and will be discarded on rebinding after a
power loss or crash if it's still marked when it's opened again.

Also, the thought has occurred to me that I can make use of reflink copy to
handle the caching of local modifications to cached files, in which case I'd
rather have a clean copy to link from.

David

