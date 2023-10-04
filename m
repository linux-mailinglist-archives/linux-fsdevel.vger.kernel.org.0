Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDBA7B7F99
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 14:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242490AbjJDMqh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 08:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242491AbjJDMqe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:46:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87281BD
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 05:46:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3428D1F74C;
        Wed,  4 Oct 2023 12:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696423589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=BsF3UVfl/y6P+aPwJrRdOfdTj+gYUjFPOJgjlOhpAZg=;
        b=vXeHv9qGyT8I7aTXp06t/B9dAyii79ISLcyLxiLWa3y0cMUkJgx0z8mCXpYvFzJkt9LCoj
        sj5QMlmDjONJPqmJ0tnQmZ2QLU2IIPvge638t1VZtV04FIMuSE8fMV97jMXHxeDPFkzeki
        L2eL1hcERscCEnkGxlCa1Q2gTN//DNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696423589;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=BsF3UVfl/y6P+aPwJrRdOfdTj+gYUjFPOJgjlOhpAZg=;
        b=tBYCb8DjuvBtW+7I7Rn4A1wqVSvZeV/OGL+6W121Kwhgc4UB4cdOa7ncqGu9BGCARJIXlY
        4JvQcOwj8saXCDBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D57513A2E;
        Wed,  4 Oct 2023 12:46:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7f8EBqVeHWXWPAAAMHmgww
        (envelope-from <chrubis@suse.cz>); Wed, 04 Oct 2023 12:46:29 +0000
From:   Cyril Hrubis <chrubis@suse.cz>
To:     ltp@lists.linux.it
Cc:     Matthew Wilcox <willy@infradead.org>, amir73il@gmail.com,
        mszeredi@redhat.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/3] Add tst_iterate_fd()
Date:   Wed,  4 Oct 2023 14:47:09 +0200
Message-ID: <20231004124712.3833-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 - adds tst_iterate_fd() functionality
 - make use of tst_iterate_fd() in readahead01
 - add accept03 test which uses tst_iterate_fd()

This is a prototype for how the functionality to iterate over different
file descriptors should look like it converts one tests and adds
another. There is plenty of other syscalls that can use this kind of
testing, e.g. all fooat() syscalls where we can pass invalid dir_fd, the
plan is to add these if/once we agree on the API.

Cyril Hrubis (3):
  lib: Add tst_fd_iterate()
  syscalls/readahead01: Make use of tst_fd_iterate()
  syscalls: accept: Add tst_fd_iterate() test

 include/tst_fd.h                              |  39 ++++++
 include/tst_test.h                            |   1 +
 lib/tst_fd.c                                  | 116 ++++++++++++++++++
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/accept/.gitignore   |   1 +
 testcases/kernel/syscalls/accept/accept01.c   |   8 --
 testcases/kernel/syscalls/accept/accept03.c   |  46 +++++++
 .../kernel/syscalls/readahead/readahead01.c   |  46 +++----
 8 files changed, 224 insertions(+), 34 deletions(-)
 create mode 100644 include/tst_fd.h
 create mode 100644 lib/tst_fd.c
 create mode 100644 testcases/kernel/syscalls/accept/accept03.c

-- 
2.41.0

