Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCE822B3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 07:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbfETFlP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 01:41:15 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:33339 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725613AbfETFlP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 01:41:15 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5EE8240D7;
        Mon, 20 May 2019 01:41:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 20 May 2019 01:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=0r/Sn1Y0gO0Oyf6yW
        SFKUDRK3ejus11HRZy7eGnGflw=; b=rdmJSE8h9XyUOGAIv/XSalLdgxvzqP7Zs
        qzNQ2b2J62DI0tLAstwp0mU/KAivM79ira4ir6eU9aE1T0v4V1+hZBza6J95Yrr6
        fch2eFMr84W3Q66XoiUTtficSc0IsxQdA/QOVd7meKJfNJwMhX+792bI5YbhuPvT
        aoMO/SDU7qc0THRuY+RFStolsfmr6bFC00L+Pm05Jbcwz34Mct9+6CTRAb36AQ8L
        e9FPLLGDtJMm1RXv3AGn9YVMZ4Y6tsVYlnqbCVHdP80DZrTJQ9/0ZIFsO0uODSHT
        nlkU5Mu+Wc/F+vHpy18HLHzP31r0fhvG0TCCRiGwxKURtYYBK/t8Q==
X-ME-Sender: <xms:9T3iXHLIt4vNmKYs0VNUf3XtYk2meotQ7mfiDUh6Jkd9d_B7QRoqIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddtjedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucffoh
    hmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdegrdduieelrdduheeirddvtdef
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:9T3iXCxHOeLs0Brh--rNvBlGvfP0gl1TFmfFykbobJzlrDeYdfnxqg>
    <xmx:9T3iXK4hgcnMZ3pVD3MYg7ejVQfn5Pevh06iZr3mDZzvk1OJ1kGLlg>
    <xmx:9T3iXKsQxmRfae1PKOqtD62SZIgSspcMsEg-nosXpSyaO7Lt8I7Lhg>
    <xmx:-T3iXARXSH-QbhMw9vVJXU1BmnRC9M8sTH4QG1AEFtiGYLH8faRhUg>
Received: from eros.localdomain (124-169-156-203.dyn.iinet.net.au [124.169.156.203])
        by mail.messagingengine.com (Postfix) with ESMTPA id 05EF080061;
        Mon, 20 May 2019 01:41:02 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>, Theodore Ts'o <tytso@mit.edu>,
        Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 00/16] Slab Movable Objects (SMO)
Date:   Mon, 20 May 2019 15:40:01 +1000
Message-Id: <20190520054017.32299-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Another iteration of the SMO patch set, updates to this version are
restricted to the XArray patches (#9 and #10 and tested with module
implemented in #11).

Applies on top of Linus' tree (tag: v5.2-rc1).

This is a patch set implementing movable objects within the SLUB
allocator.  This is work based on Christopher Lameter's patch set:

 https://lore.kernel.org/patchwork/project/lkml/list/?series=377335

The original code logic is from that set and implemented by Christopher.
Clean up, refactoring, documentation, and additional features by myself.
Responsibility for any bugs remaining falls solely with myself.

I am intending on sending a non-RFC version soon after this one (if
XArray stuff is ok).  If anyone has any objects with SMO in general
please yell at me now.

Changes to this version:

Patch XArray to use a separate slab cache.  Currently the radix tree and
XArray use the same slab cache.  Radix tree nodes can not be moved but
XArray nodes can.

Matthew,

Does this fit in ok with your plans for the XArray and radix tree?  I
don't really like the function names used here or the init function name
(xarray_slabcache_init()).  If there is a better way to do this please
mercilessly correct me :)


Thanks for looking at this,
Tobin.


Tobin C. Harding (16):
  slub: Add isolate() and migrate() methods
  tools/vm/slabinfo: Add support for -C and -M options
  slub: Sort slab cache list
  slub: Slab defrag core
  tools/vm/slabinfo: Add remote node defrag ratio output
  tools/vm/slabinfo: Add defrag_used_ratio output
  tools/testing/slab: Add object migration test module
  tools/testing/slab: Add object migration test suite
  lib: Separate radix_tree_node and xa_node slab cache
  xarray: Implement migration function for xa_node objects
  tools/testing/slab: Add XArray movable objects tests
  slub: Enable moving objects to/from specific nodes
  slub: Enable balancing slabs across nodes
  dcache: Provide a dentry constructor
  dcache: Implement partial shrink via Slab Movable Objects
  dcache: Add CONFIG_DCACHE_SMO

 Documentation/ABI/testing/sysfs-kernel-slab |  14 +
 fs/dcache.c                                 | 110 ++-
 include/linux/slab.h                        |  71 ++
 include/linux/slub_def.h                    |  10 +
 include/linux/xarray.h                      |   3 +
 init/main.c                                 |   2 +
 lib/radix-tree.c                            |   2 +-
 lib/xarray.c                                | 109 ++-
 mm/Kconfig                                  |  14 +
 mm/slab_common.c                            |   2 +-
 mm/slub.c                                   | 819 ++++++++++++++++++--
 tools/testing/slab/Makefile                 |  10 +
 tools/testing/slab/slub_defrag.c            | 567 ++++++++++++++
 tools/testing/slab/slub_defrag.py           | 451 +++++++++++
 tools/testing/slab/slub_defrag_xarray.c     | 211 +++++
 tools/vm/slabinfo.c                         |  51 +-
 16 files changed, 2343 insertions(+), 103 deletions(-)
 create mode 100644 tools/testing/slab/Makefile
 create mode 100644 tools/testing/slab/slub_defrag.c
 create mode 100755 tools/testing/slab/slub_defrag.py
 create mode 100644 tools/testing/slab/slub_defrag_xarray.c

-- 
2.21.0

