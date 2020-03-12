Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6682182E36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 11:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgCLKts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 06:49:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48012 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726725AbgCLKtr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584010187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sqSyeraTyEfK9Qvci1PFdu1IIkWpjyFX2BvJmt2oSYM=;
        b=JWs1gWsZpq1j9Xk9JdAGNvS/PZWfzIHhPLYnbVL1b00cyqTu32cD/NadXm9Jf5ePPbtDdq
        UEibRCgA3G3bhvqttEkpfbo7hRBNrEXK5XH+IvoM563oj0naudWY+BDGxCY9tQsTQklTal
        gLGRBxx6JRlmsRu961CGTQg2jTfnf+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-FAJb1ijuOvKH_nCRC6Xbrw-1; Thu, 12 Mar 2020 06:49:45 -0400
X-MC-Unique: FAJb1ijuOvKH_nCRC6Xbrw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1C17800D5E;
        Thu, 12 Mar 2020 10:49:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0FE38AC4D;
        Thu, 12 Mar 2020 10:49:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200312104239.GA13235@lst.de>
References: <20200312104239.GA13235@lst.de> <969260.1584004779@warthog.procyon.org.uk> <1015227.1584007677@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, mbobrowski@mbobrowski.org,
        darrick.wong@oracle.com, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Is ext4_dio_read_iter() broken? - and xfs_file_dio_aio_read()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1023936.1584010180.1@warthog.procyon.org.uk>
Date:   Thu, 12 Mar 2020 10:49:40 +0000
Message-ID: <1023937.1584010180@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> > > at the end of the function - but surely iocb should be expected to have
> > > been freed when iocb->ki_complete() was called?
> 
> The iocb is refcounted and only completed when the refcount hits zero,
> and an extra reference is held until the submission has completed.
> Take a look at iocb_put().

Ah...  This is in struct aio_kiocb and not struct kiocb - that's why I missed
it.  Thanks.

David

