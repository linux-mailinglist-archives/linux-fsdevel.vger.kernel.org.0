Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7196BE718
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 11:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjCQKnx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 06:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCQKnv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:43:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7234E2A159;
        Fri, 17 Mar 2023 03:43:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9CFA71FE4D;
        Fri, 17 Mar 2023 10:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679049802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=o1Bd/gf90WdisSwwS/vFbHpVvxBLf3xzgu2g/b2rdJA=;
        b=nDlQKhaTyEX6T/6m1aUPTpA7kEN4gZDpFVzA2Xek9so2Gjl37yELlyf78dr+gSnyQDIPls
        +ITc+PBcjFhipCvdNptK6MpNJ/54M06O2XW0ZbbK9yQqCdYYbgiJ7RBSV5oFKlZLKrW3iU
        +qko/YhJplWnjW+rexyd0Rr+TwoN0O4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679049802;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=o1Bd/gf90WdisSwwS/vFbHpVvxBLf3xzgu2g/b2rdJA=;
        b=t2IaQyu/bJ56hVfwE52wAmc7HMN68khnpeQkGLYb8NvcxiZvPTdRrN+pRorI5dSunTqIdc
        6nUQX7yRR9/ZAIBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 483221346F;
        Fri, 17 Mar 2023 10:43:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BHjpEEpEFGRgdwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 17 Mar 2023 10:43:22 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        rcu@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-doc@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mike Rapoport <rppt@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 0/6] remove SLOB and allow kfree() with kmem_cache_alloc()
Date:   Fri, 17 Mar 2023 11:43:01 +0100
Message-Id: <20230317104307.29328-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Also in git:
https://git.kernel.org/vbabka/h/slab-remove-slob-v2r1

Changes since v1:
https://lore.kernel.org/all/20230310103210.22372-1-vbabka@suse.cz/
- skbuff patch removed from the series as recommended by net folks
- fix up comments in fs/proc/page.c (Hyeonggon)
- removed an extra line in mm/Makefile that I missed (Mike)
- tweak the Documentation wording (Mike)
- added Acks/Reviews - thanks!

The SLOB allocator was deprecated in 6.2 so I think we can start
exposing the complete removal in for-next (already included as of today)
and aim at 6.4 if there are no complaints.

Besides code cleanup, the main immediate benefit will be allowing
kfree() family of function to work on kmem_cache_alloc() objects (Patch
6), which was incompatible with SLOB.

This includes kfree_rcu() so I've updated the comment there to remove
the mention of potential future addition of kmem_cache_free_rcu() as
there should be no need for that now.

Otherwise it's all straightforward removal. After this series, 'git
grep slob' or 'git grep SLOB' will have relevant hits in non-mm code:
- tomoyo - patch submitted and carried there, doesn't need to wait for
  this series
- skbuff - patch to cleanup now-unnecessary #ifdefs will be posted to
  netdev after this is merged, as requested, to avoid conflicts
- ftrace ring_buffer - patch to remove obsolete comment was submitted

The rest of 'git grep SLOB' hits are false positives, or intentional
(CREDITS, and mm/Kconfig SLUB_TINY description to help those that will
happen to migrate later).

Vlastimil Babka (6):
  mm/slob: remove CONFIG_SLOB
  mm, page_flags: remove PG_slob_free
  mm, pagemap: remove SLOB and SLQB from comments and documentation
  mm/slab: remove CONFIG_SLOB code from slab common code
  mm/slob: remove slob.c
  mm/slab: document kfree() as allowed for kmem_cache_alloc() objects

 Documentation/admin-guide/mm/pagemap.rst     |   6 +-
 Documentation/core-api/memory-allocation.rst |  17 +-
 fs/proc/page.c                               |   9 +-
 include/linux/page-flags.h                   |   4 -
 include/linux/rcupdate.h                     |   6 +-
 include/linux/slab.h                         |  39 -
 init/Kconfig                                 |   2 +-
 kernel/configs/tiny.config                   |   1 -
 mm/Kconfig                                   |  22 -
 mm/Makefile                                  |   2 -
 mm/slab.h                                    |  61 --
 mm/slab_common.c                             |   7 +-
 mm/slob.c                                    | 757 -------------------
 tools/mm/page-types.c                        |   6 +-
 14 files changed, 27 insertions(+), 912 deletions(-)
 delete mode 100644 mm/slob.c

-- 
2.39.2

