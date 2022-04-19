Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F7A5072C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 18:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354562AbiDSQT6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 12:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354589AbiDSQTz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:19:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 241583A704
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 09:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650385028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PO0lkHhNnHSLPXRmDoWyTMQsiXU6Zlx9XTP8wRAHmNo=;
        b=XoeOWXwF5lR4anKgUwDmDJY2eXqituq4GgI7bQAw7wNVZXaucIwwCY+VF+C1NcDiZ/tDnZ
        4t202Lx4/QozPauvcC+YXsc2NgEbvvJfwPUsDsyk+7/UKV2TpF1SagaEZ5S4bMBT4JBfxO
        6PGv2jbDZHx1NrRbbl3DuGT1MAwUwMY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-5h8vPog6NF299PWYomx4gw-1; Tue, 19 Apr 2022 12:17:04 -0400
X-MC-Unique: 5h8vPog6NF299PWYomx4gw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39AA13C11A0F;
        Tue, 19 Apr 2022 16:17:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 718A4403374;
        Tue, 19 Apr 2022 16:17:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Yl7EyMLnqqDv63yW@rabbit.intern.cm-ag>
References: <Yl7EyMLnqqDv63yW@rabbit.intern.cm-ag> <YlWWbpW5Foynjllo@rabbit.intern.cm-ag> <454834.1650373340@warthog.procyon.org.uk>
To:     Max Kellermann <mk@cm4all.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fscache corruption in Linux 5.17?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <508602.1650385022.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 19 Apr 2022 17:17:02 +0100
Message-ID: <508603.1650385022@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Max Kellermann <mk@cm4all.com> wrote:

> At least one web server is still in this broken state right now.  So
> if you need anything from that server, tell me, and I'll get it.

Can you turn on:

echo 65536 >/sys/kernel/debug/tracing/buffer_size_kb
echo 1 >/sys/kernel/debug/tracing/events/cachefiles/cachefiles_read/enable
echo 1 >/sys/kernel/debug/tracing/events/cachefiles/cachefiles_write/enabl=
e
echo 1 >/sys/kernel/debug/tracing/events/cachefiles/cachefiles_trunc/enabl=
e
echo 1 >/sys/kernel/debug/tracing/events/cachefiles/cachefiles_io_error/en=
able
echo 1 >/sys/kernel/debug/tracing/events/cachefiles/cachefiles_vfs_error/e=
nable

Then try and trigger the bug if you can.  The trace can be viewed with:

cat /sys/kernel/debug/tracing/trace | less

The problem very likely happens on write rather than read.  If you know of=
 a
file that's corrupt, turn on the tracing above and read that file.  Then l=
ook
in the trace buffer and you should see the corresponding lines and they sh=
ould
have the backing inode in them, marked "B=3Diiii" where "iiii" is the inod=
e
number of the file in hex.  You should be able to examine the backing file=
 by
finding it with something like:

	find /var/cache/fscache -inum $((0xiiii))

and see if you can see the corruption in there.  Note that there may be bl=
ocks
of zeroes corresponding to unfetched file blocks.

Also, what filesystem is backing your cachefiles cache?  It could be usefu=
l to
dump the extent list of the file.  You should be able to do this with
"filefrag -e".

As to why this happens, a write that's misaligned by 31 bytes should cause=
 DIO
to a disk to fail - so it shouldn't be possible to write that.  However, I=
'm
doing fallocate and truncate on the file to shape it so that DIO will work=
 on
it, so it's possible that there's a bug there.  The cachefiles_trunc trace
lines may help catch that.

David

