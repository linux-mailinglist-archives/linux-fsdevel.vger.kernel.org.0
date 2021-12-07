Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD1D46C021
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 16:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbhLGQC7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 11:02:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60923 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239374AbhLGQB6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 11:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638892708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cENh/xagH7pgMMHcefD1qFMKA7XmnAIJ+YbaNvx2rZg=;
        b=eeIkCgui/9FXL8GwszA6L/hI9S3ugEXONL49c2oDbjhaP2Sh0mmhSvIcuX/Z8kczAqcv/p
        Y0qQkkMirTr8Vbn3LrnyEschZ4xtOz2QnGcWbO+KY6y6/gpZSgPN4XCdzZUzc91Oy16dpP
        Q6mG/5CXYw9PYKvPp7v4OKHSBu88DU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-9sUBnP-_PHikOr6hdg5eng-1; Tue, 07 Dec 2021 10:58:25 -0500
X-MC-Unique: 9sUBnP-_PHikOr6hdg5eng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFF70874980;
        Tue,  7 Dec 2021 15:58:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0A825C22B;
        Tue,  7 Dec 2021 15:58:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210922110420.GA21576@quack2.suse.cz>
References: <20210922110420.GA21576@quack2.suse.cz> <3439799.1632261329@warthog.procyon.org.uk>
To:     Jan Kara <jack@suse.cz>
Cc:     dhowells@redhat.com, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: The new invalidate_lock seems to cause a potential deadlock with fscache
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1610854.1638892701.1@warthog.procyon.org.uk>
Date:   Tue, 07 Dec 2021 15:58:21 +0000
Message-ID: <1610855.1638892701@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara <jack@suse.cz> wrote:

> We have filesystems F1 & F2, where F1 is the network fs and F2 is the cache
> fs.
> 
> Thread 1	Thread 2		Thread 3	Thread 4
> 		write (F2)
> 		  sb_start_write() (F2)
> 		  prepares write
> 		  copy_from_user()
> ...
> 		Thread 2 continues
> 		    fault()

cachefilesd is only doing I/O to/from kernel resident pages.  It shouldn't
fault there.  I'm not sure it's even going to call copy_from_user() since
it'll be using ITER_XARRAY.

David

