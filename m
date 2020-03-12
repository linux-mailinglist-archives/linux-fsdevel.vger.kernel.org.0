Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52287182D09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 11:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgCLKIE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 06:08:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36232 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726044AbgCLKIE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584007683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UREMN3SChoR23ul+gfDOcGQfVoGjOsof5Gn863j6Nd4=;
        b=MzglNq44XB+zf0N2ytutSrPUdnmFugYfapsjgHVrpIEzAgUZxOJjwLDMUCEbVkwqanL09Y
        RIZzan8dPHqwMFrHScgLDBqzdtIAcVnzItvqkxjI7vhM0Q37Qrl3XCpeWI7tj9R3bS4FCY
        cHGQmCJqDq+//hGEDsGZZvsPYGC4Jdo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-HwXjt_E_PU-qSYhRePSKpw-1; Thu, 12 Mar 2020 06:08:01 -0400
X-MC-Unique: HwXjt_E_PU-qSYhRePSKpw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBA34189D6D3;
        Thu, 12 Mar 2020 10:07:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E57D3277AD;
        Thu, 12 Mar 2020 10:07:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <969260.1584004779@warthog.procyon.org.uk>
References: <969260.1584004779@warthog.procyon.org.uk>
To:     mbobrowski@mbobrowski.org, darrick.wong@oracle.com
Cc:     dhowells@redhat.com, jack@suse.cz, hch@lst.de,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Is ext4_dio_read_iter() broken? - and xfs_file_dio_aio_read()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1015226.1584007677.1@warthog.procyon.org.uk>
Date:   Thu, 12 Mar 2020 10:07:57 +0000
Message-ID: <1015227.1584007677@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> Is ext4_dio_read_iter() broken?  It calls:
> 
> 	file_accessed(iocb->ki_filp);
> 
> at the end of the function - but surely iocb should be expected to have been
> freed when iocb->ki_complete() was called?

I think it's actually worse than that.  You also can't call
inode_unlock_shared(inode) because you no longer own a ref on the inode since
->ki_complete() is expected to call fput() on iocb->ki_filp.

Yes, you own a shared lock on it, but unless somewhere along the
fput-dput-iput chain the inode lock is taken exclusively, the inode can be
freed whilst you're still holding the lock.

Oh - and ext4_dax_read_iter() is also similarly broken.

And xfs_file_dio_aio_read() appears to be broken as it touches the inode after
calling iomap_dio_rw() to unlock it.

David

