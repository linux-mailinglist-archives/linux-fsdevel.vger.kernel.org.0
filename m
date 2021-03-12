Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E57533894E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 10:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhCLJ4B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 04:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbhCLJzp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:55:45 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78003C061574;
        Fri, 12 Mar 2021 01:55:45 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lKeW0-00F7m8-Gm; Fri, 12 Mar 2021 10:55:28 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Cc:     Jessica Yu <jeyu@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/6] um: fix up CONFIG_GCOV support
Date:   Fri, 12 Mar 2021 10:55:20 +0100
Message-Id: <20210312095526.197739-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CONFIG_GCOV is fairly useful for ARCH=um (e.g. with kunit, though
my main use case is a bit different) since it writes coverage data
directly out like a normal userspace binary. Theoretically, that
is.

Unfortunately, it's broken in multiple ways today:

 1) it doesn't like, due to 'mangle_path' in seq_file, and the only
    solution to that seems to be to rename our symbol, but that's
    not so bad, and "mangle_path" sounds very generic anyway, which
    it isn't quite

 2) gcov requires exit handlers to write out the data, and those are
    never called for modules, config CONSTRUCTORS exists for init
    handlers, so add CONFIG_MODULE_DESTRUCTORS here that we can then
    select in ARCH=um

 3) As mentioned above, gcov requires init/exit handlers, but they
    aren't linked into binary properly, that's easy to fix.

 4) gcda files are then written, so .gitignore them

 5) it's not always useful to create coverage data for the *entire*
    kernel, so I've split off CONFIG_GCOV_BASE from CONFIG_GCOV to
    allow option in only in some places, which of course requires
    adding the necessary "subdir-cflags" or "CFLAGS_obj" changes in
    the places where it's desired, as local patches.


None of these changes (hopefully) seem too controversional, biggest
are the module changes but obviously they compile to nothing if the
architecture doesn't WANT_MODULE_DESTRUCTORS.

Any thoughts on how to merge this? The seq_file/.gitignore changes
are independent at least code-wise, though of course it only works
with the seq_file changes (.gitignore doesn't matter, of course),
while the module changes are a requirement for the later ARCH=um
patches since the Kconfig symbol has to exist.

Perhaps I can just get ACKs on all the patches and then they can go
through the UML tree?

Thanks,
johannes


