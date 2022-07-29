Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E954758539F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jul 2022 18:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237803AbiG2QkK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jul 2022 12:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237801AbiG2Qjx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jul 2022 12:39:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C69388F29
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Jul 2022 09:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659112774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nUesyg820kD2LFrMitU8S/o3Hhtfxx5YxguzdMKG/aE=;
        b=RJVaTK6XXC56DeQ9es43OhJL8DuV4gdsXbmgqHNy1/68iy/wb9nZZOLWBDC3BpEmw5/cYc
        Cn4as1CdibgWWVJ5cjr/D9AFtEl7yCeW9xsKHDvLCem8rHg4ncuhxWlgFPiT84vH5BdBPC
        Hwo4abSfJss9XDJPzUaP5PUdwtB7hEI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-Dgi74NMONO67_x_iJEqXMQ-1; Fri, 29 Jul 2022 12:39:32 -0400
X-MC-Unique: Dgi74NMONO67_x_iJEqXMQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FFBF85A584;
        Fri, 29 Jul 2022 16:39:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6330492C3B;
        Fri, 29 Jul 2022 16:39:31 +0000 (UTC)
Subject: [PATCH 0/2] afs: Fix ref-put functions
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Marc Dionne <marc.dionne@auristor.com>, dhowells@redhat.com,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 29 Jul 2022 17:39:31 +0100
Message-ID: <165911277121.3745403.18238096564862303683.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a pair of patches: the first converts afs to use refcount_t instead
of atomic_t for its refcounts; the second fixes a number of afs ref-putting
functions to make sure they don't access the target object after the
decrement unless the refcount was reduced to 0.

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

David

---
David Howells (2):
      afs: Use refcount_t rather than atomic_t
      afs: Fix access after dec in put functions


 fs/afs/cell.c              | 61 ++++++++++++++++++--------------------
 fs/afs/cmservice.c         |  4 +--
 fs/afs/internal.h          | 16 +++++-----
 fs/afs/proc.c              |  6 ++--
 fs/afs/rxrpc.c             | 31 ++++++++++---------
 fs/afs/server.c            | 46 +++++++++++++++++-----------
 fs/afs/vl_list.c           | 19 ++++--------
 fs/afs/volume.c            | 21 ++++++++-----
 include/trace/events/afs.h | 36 +++++++++++-----------
 9 files changed, 124 insertions(+), 116 deletions(-)


