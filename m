Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E285182D72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 11:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgCLK0U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 06:26:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20758 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726310AbgCLK0U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584008779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mOBS2wli+ub8UNg/a0qe1B6uGroDbB2RmIKqhZCROdo=;
        b=N16BGhWSowpR9+KhhiEOua05ybl4WeD8bC5LDzPJAM4KRkbz6LGi43srWXJNO7t5GJ4eQw
        WYf56snqYF8vCMpbVh9sCx6dqStijmMI7sxui0DjkvhKP7b/PLfyvh3LuNPLRJcGjHmtuk
        hY3mawBc7gof1ONBT/INPt5NIuwfmsY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-DhXxdGWqOnSZkj73jKhAyg-1; Thu, 12 Mar 2020 06:26:15 -0400
X-MC-Unique: DhXxdGWqOnSZkj73jKhAyg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FBEDDB62;
        Thu, 12 Mar 2020 10:26:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 508BD10013A1;
        Thu, 12 Mar 2020 10:26:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1015227.1584007677@warthog.procyon.org.uk>
References: <1015227.1584007677@warthog.procyon.org.uk> <969260.1584004779@warthog.procyon.org.uk>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     dhowells@redhat.com, mbobrowski@mbobrowski.org,
        darrick.wong@oracle.com, jack@suse.cz, hch@lst.de,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: btrfs may be broken too - Re: Is ext4_dio_read_iter() broken?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1016627.1584008770.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 12 Mar 2020 10:26:10 +0000
Message-ID: <1016628.1584008770@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> > Is ext4_dio_read_iter() broken?  It calls:
> > =

> > 	file_accessed(iocb->ki_filp);
> > =

> > at the end of the function - but surely iocb should be expected to hav=
e been
> > freed when iocb->ki_complete() was called?
> =

> I think it's actually worse than that.  You also can't call
> inode_unlock_shared(inode) because you no longer own a ref on the inode =
since
> ->ki_complete() is expected to call fput() on iocb->ki_filp.
> =

> Yes, you own a shared lock on it, but unless somewhere along the
> fput-dput-iput chain the inode lock is taken exclusively, the inode can =
be
> freed whilst you're still holding the lock.
> =

> Oh - and ext4_dax_read_iter() is also similarly broken.
> =

> And xfs_file_dio_aio_read() appears to be broken as it touches the inode=
 after
> calling iomap_dio_rw() to unlock it.

Seems btrfs_file_write_iter() is also broken:

	if (iocb->ki_flags & IOCB_DIRECT) {
		num_written =3D __btrfs_direct_write(iocb, from);
	} else {
		num_written =3D btrfs_buffered_write(iocb, from);
		if (num_written > 0)
			iocb->ki_pos =3D pos + num_written;
		if (clean_page)
			pagecache_isize_extended(inode, oldsize,
						i_size_read(inode));
	}

	inode_unlock(inode);

But if __btrfs_direct_write() returned -EIOCBQUEUED then inode may have be=
en
deallocated by the point it's calling inode_unlock().  Holding the lock is=
 not
a preventative measure that I can see.

David

