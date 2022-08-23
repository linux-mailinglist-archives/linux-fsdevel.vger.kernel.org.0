Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EB659E78B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 18:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244223AbiHWQic (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 12:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245035AbiHWQh5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DBC4D163
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 06:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661260044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5XBOIH3pNVedUwFsOXAIjq4Jvv7g7DjLTpjlFUvS39Y=;
        b=O+blAGgx/R5Ch+ujuIWLmDuViB5Xci0R8U7J3qBtmjhfCTU57FQ35iTv4CNQJgwfMy33uF
        dOoQKvhxIrlW3RA48kgEgj9WHLctR8EP8CWBvW/hfXrQt1DKPAF3fdCPXtpIkIMjOTP+xQ
        pKAVLz+o95Y4EwPeoqQlKrLyR09IF/M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-tNCRk7prMsyJhm6rhXGLfg-1; Tue, 23 Aug 2022 09:07:23 -0400
X-MC-Unique: tNCRk7prMsyJhm6rhXGLfg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3EAE80A0BC;
        Tue, 23 Aug 2022 13:07:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84A1DC15BB3;
        Tue, 23 Aug 2022 13:07:21 +0000 (UTC)
Subject: [PATCH 0/5] smb3: Fix missing locks and invalidation in fallocate
From:   David Howells <dhowells@redhat.com>
To:     sfrench@samba.org, linux-cifs@vger.kernel.org
Cc:     lsahlber@redhat.com, jlayton@kernel.org, dchinner@redhat.com,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, samba-technical@lists.samba.org
Date:   Tue, 23 Aug 2022 14:07:20 +0100
Message-ID: <166126004083.548536.11195647088995116235.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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


Here are some patches to fix locking and invalidation in the smb3/cifs
fallocate, in particular in zero_range, punch_hole, collapse_range and
insert_range.

Those four operations were, for the most part, missing calls to inode_lock(),
filemap_invalidate_lock() and truncate_pagecache_range(), the last of which
was causing generic/031 to show data corruption.

David
---
David Howells (4):
      smb3: Move the flush out of smb2_copychunk_range() into its callers
      smb3: missing inode locks in zero range
      smb3: missing inode locks in punch hole
      smb3: fix temporary data corruption in insert range

Steve French (1):
      smb3: fix temporary data corruption in collapse range


 fs/cifs/cifsfs.c  |   2 +
 fs/cifs/smb2ops.c | 131 ++++++++++++++++++++++++++--------------------
 2 files changed, 75 insertions(+), 58 deletions(-)


