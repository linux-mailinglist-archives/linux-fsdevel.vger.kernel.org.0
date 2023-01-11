Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABF2665804
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 10:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjAKJsV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 04:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbjAKJre (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:47:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32642192AF
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jan 2023 01:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673430274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wiP+ZFnGGkh1MiQTCARjLEk6aqI2ytHljt2h0Oi6JYo=;
        b=dJQOVA7M04bsRfyXucBZdUZzyX9pVhLhpIz3JNay9oVPzHltxU0l/PFnU0MyP5GNIJlNZi
        gO2oU0Y4pl8wKjkBv8ZDBugUUnLgMHzlsoVHSnaOxKDql/HeiZkRCcTzeqhNnfJOimwPHN
        yp4RFsBDPhNHlM8+e91w3GQxH+8t/WE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-eCOgJBKgNr-X-GjcO5D0ZQ-1; Wed, 11 Jan 2023 04:44:30 -0500
X-MC-Unique: eCOgJBKgNr-X-GjcO5D0ZQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DF223802B83;
        Wed, 11 Jan 2023 09:44:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEF4E40C2064;
        Wed, 11 Jan 2023 09:44:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230110104501.11722-1-jlayton@kernel.org>
References: <20230110104501.11722-1-jlayton@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: remove locks_inode
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2265540.1673430268.1@warthog.procyon.org.uk>
Date:   Wed, 11 Jan 2023 09:44:28 +0000
Message-ID: <2265541.1673430268@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> locks_inode was turned into a wrapper around file_inode in de2a4a501e71
> (Partially revert "locks: fix file locking on overlayfs"). Finish
> replacing locks_inode invocations everywhere with file_inode.
> 
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: David Howells <dhowells@redhat.com>

