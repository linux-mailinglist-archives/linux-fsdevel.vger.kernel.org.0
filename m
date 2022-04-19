Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3675074E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 18:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355231AbiDSQsl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 12:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241080AbiDSQpo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:45:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 354FB39692
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 09:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650386580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u4Y3eOaR2D2oLy5UgU4g9qvJhnkbfGO00HLFWR/cxQI=;
        b=QWo9NFj1eWuG+B7jxiktkcuepVLU6go26+lHOJDVm3wD84jIxPxBXiGtv7FM6OS1AGNayH
        Cw6oa9td2KMm3m3j4k/y526ZYrsv9efyHJB1EZM8/WDcLyXjWW1JCwHxUKea8krxa5Gqvo
        N5BYCSoGCmeXyW8gXOAIx+R07gfWmYw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-najQBgyjPK2iJtuUqeAHRQ-1; Tue, 19 Apr 2022 12:42:57 -0400
X-MC-Unique: najQBgyjPK2iJtuUqeAHRQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0ED983C11C6D;
        Tue, 19 Apr 2022 16:42:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8FB0C5353B;
        Tue, 19 Apr 2022 16:42:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Yl7d++G25sNXIR+p@rabbit.intern.cm-ag>
References: <Yl7d++G25sNXIR+p@rabbit.intern.cm-ag> <YlWWbpW5Foynjllo@rabbit.intern.cm-ag> <507518.1650383808@warthog.procyon.org.uk>
To:     Max Kellermann <mk@cm4all.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fscache corruption in Linux 5.17?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <509960.1650386569.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 19 Apr 2022 17:42:49 +0100
Message-ID: <509961.1650386569@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Max Kellermann <mk@cm4all.com> wrote:

> Did you read this part of my email?:

Sorry, I'm trying to deal with several things at once.

> My theory was that fscache shows a mix of old and new pages after the
> file was modified.  Does this make sense?

Okay - that makes a bit more sense.

Could the file have been modified by a third party?  If you're using NFS3
there's a problem if two clients can modify a file at the same time.  The
second write can mask the first write and the client has no way to detect =
it.
The problem is inherent to the protocol design.  The NFS2 and NFS3 protoco=
ls
don't support anything better than {ctime,mtime,filesize} - the change
attribute only becomes available with NFS4.

If an NFS file is opened for writing locally, the cache for it supposed to=
 be
invalidated and remain unused until there are no open file descriptors lef=
t
referring to it.  This is intended for handling DIO writes, but it should
serve for this also.

The following might be of use in checking if the invalidation happens loca=
lly:

echo 1 >/sys/kernel/debug/tracing/events/fscache/fscache_invalidate/enable

And then this can be used to check if it correctly identifies that it has =
an
obsolete version of the file in the cache when it binds to it:

echo 1 >/sys/kernel/debug/tracing/events/cachefiles/cachefiles_coherency/e=
nable


David

