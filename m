Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A495A4D3CA2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 23:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbiCIWKX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 17:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbiCIWKW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:10:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CF5E1201B7
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 14:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646863762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4qDmg2fffNWU1syoN14+7jtGn5Y7/b0UyTVYlsya390=;
        b=Jj6wDYPjm3jZLULYto8hLUBrhk4Z7x9z0Khbcw6rvAoD9EnGeKWgPWbMMcPSUb5S2/kky3
        5F+9zdaIEpmNZC/pW4fZriCoWvZ5MfEHXDgtWvMDJ40IbAOp4Z7ZhOTuYhZi194L1vxYc/
        VshvSlgnRdSNYmiis/x03Z1O36SQWVY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-GvQmizKXPhiPEd9CfK-jyg-1; Wed, 09 Mar 2022 17:09:17 -0500
X-MC-Unique: GvQmizKXPhiPEd9CfK-jyg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 625391006AA6;
        Wed,  9 Mar 2022 22:09:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 318CC709F1;
        Wed,  9 Mar 2022 22:08:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <9d69be49081bccff44260e4c6e0049c63d6d04a1.camel@redhat.com>
References: <9d69be49081bccff44260e4c6e0049c63d6d04a1.camel@redhat.com> <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk> <164678214287.1200972.16734134007649832160.stgit@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/19] netfs: Add a function to consolidate beginning a read
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1840691.1646863738.1@warthog.procyon.org.uk>
Date:   Wed, 09 Mar 2022 22:08:58 +0000
Message-ID: <1840692.1646863738@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@redhat.com> wrote:

> > +	rreq->work.func = netfs_rreq_work;
> > +
> 
> ^^^
> This seems like it should be an INIT_WORK call. I assume you're moving
> this here this because you intend to use netfs_alloc_request for writes
> too?

Interesting question.  INIT_WORK() was called in netfs_alloc_request(), so the
lockdep state has already been initialised and may even have been used already
(say, for instance, we do an RMW cycle buffering in the same request struct).

David

