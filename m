Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74CB59762A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 21:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241333AbiHQTBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 15:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiHQTAz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:00:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0043265271
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660762854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBiW69nYfb0RDezsv64U04DtNtYj2TKxdgfkfUJl7Qw=;
        b=B7MrxY0RQY8FZr8SkasND8dqLZB7KJbJB+zEzoBLoqq/ITorW0V3Oc4G+HGFRih/hia+bP
        N6Y5sgA6rS7VAYuHwT3LzbWRQ5EIquMnyOzqhf7Ug9cJ+bpecG8+5V7d70o44IyzB8WVnc
        Q/xHtTcWJhnzvpj4sGiKfO1STesL8No=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-8DMa6IATPiKdWcVExtn0HA-1; Wed, 17 Aug 2022 15:00:50 -0400
X-MC-Unique: 8DMa6IATPiKdWcVExtn0HA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4845310B959E;
        Wed, 17 Aug 2022 19:00:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B659C15BBA;
        Wed, 17 Aug 2022 19:00:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <166076168742.3677624.2936950729624462101.stgit@warthog.procyon.org.uk>
References: <166076168742.3677624.2936950729624462101.stgit@warthog.procyon.org.uk>
To:     jlayton@kernel.org
Cc:     dhowells@redhat.com, Kuniyuki Iwashima <kuniyu@amazon.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] locks: Fix dropped call to ->fl_release_private()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3718462.1660762837.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 17 Aug 2022 20:00:37 +0100
Message-ID: <3718464.1660762837@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> Fixes: 4149be7bda7e ("fs/lock: Don't allocate file_lock in flock_make_lo=
ck().")
> cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> cc: Chuck Lever <chuck.lever@oracle.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/r/166075758809.3532462.1330793558877758753=
6.stgit@warthog.procyon.org.uk/ # v1

I forgot:

Signed-off-by: David Howells <dhowells@redhat.com>

