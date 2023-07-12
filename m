Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7273E75129C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 23:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjGLV0P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 17:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjGLV0N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:26:13 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7CE1991
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 14:26:12 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-193.bstnma.fios.verizon.net [173.48.82.193])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36CLPva0018858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 17:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1689197159; bh=RwWQLMaX2MoBOl5ry57wnXU6qCPKEzTD7QWyoGJjf6M=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=JXBTYpBZR/xRt+J1w2Upg2lBNAb/N/0JTRg1zn2jcwInGczg2J6abjd0oYvOVhbXR
         XfgiwFUicXcNZUtGq0MDEBA0SheA8lEGnyAnbQIAcGaKk2pFRQD2FxoE2XTslF8441
         nrhyKDolLWXMfs1OIxICAvmzVdjWVrhYjMCb7oHzsAL6soluidgB90f72OIMQrSyLH
         8xjVOX/9T+ICZSqObGj8K1iuL1S0FaV9pnZRWTkiRd863frMtzDWv/ddCTMwILmz7B
         RNaup0laRbdrSO4apL9kVnINzs54NnCW3/MEJMb+HMFUWSXPW0g4uFllj6dXv5KJ3Q
         ZALvjxzKZUykg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1180915C0280; Wed, 12 Jul 2023 17:25:57 -0400 (EDT)
Date:   Wed, 12 Jul 2023 17:25:57 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     brauner@kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix decoding of raw_inode timestamps
Message-ID: <20230712212557.GE3432379@mit.edu>
References: <20230712150251.163790-1-jlayton@kernel.org>
 <20230712175258.GB3677745@mit.edu>
 <4c29c4e8f88509b2f8e8c08197dba8cfeb07c045.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c29c4e8f88509b2f8e8c08197dba8cfeb07c045.camel@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 12, 2023 at 02:09:59PM -0400, Jeff Layton wrote:
> 
> No, I haven't. I'm running fstests on it now. Is there a quickstart for
> running those tests?

At the top level kernel sources:

./tools/testing/kunit/kunit.py  run --kunitconfig ./fs/ext4/.kunitconfig

You should get:

[17:23:09] Starting KUnit Kernel (1/1)...
[17:23:09] ============================================================
[17:23:09] =============== ext4_inode_test (1 subtest) ================
[17:23:09] ============= inode_test_xtimestamp_decoding  ==============
[17:23:09] [PASSED] 1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits
[17:23:09] [PASSED] 1969-12-31 Upper bound of 32bit < 0 timestamp, no extra bits
[17:23:09] [PASSED] 1970-01-01 Lower bound of 32bit >=0 timestamp, no extra bits
[17:23:09] [PASSED] 2038-01-19 Upper bound of 32bit >=0 timestamp, no extra bits
[17:23:09] [PASSED] 2038-01-19 Lower bound of 32bit <0 timestamp, lo extra sec bit on
[17:23:09] [PASSED] 2106-02-07 Upper bound of 32bit <0 timestamp, lo extra sec bit on
[17:23:09] [PASSED] 2106-02-07 Lower bound of 32bit >=0 timestamp, lo extra sec bit on
[17:23:09] [PASSED] 2174-02-25 Upper bound of 32bit >=0 timestamp, lo extra sec bit on
[17:23:09] [PASSED] 2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit on
[17:23:09] [PASSED] 2242-03-16 Upper bound of 32bit <0 timestamp, hi extra sec bit on
[17:23:09] [PASSED] 2242-03-16 Lower bound of 32bit >=0 timestamp, hi extra sec bit on
[17:23:09] [PASSED] 2310-04-04 Upper bound of 32bit >=0 timestamp, hi extra sec bit on
[17:23:09] [PASSED] 2310-04-04 Upper bound of 32bit>=0 timestamp, hi extra sec bit 1. 1 ns
[17:23:09] [PASSED] 2378-04-22 Lower bound of 32bit>= timestamp. Extra sec bits 1. Max ns
[17:23:09] [PASSED] 2378-04-22 Lower bound of 32bit >=0 timestamp. All extra sec bits on
[17:23:09] [PASSED] 2446-05-10 Upper bound of 32bit >=0 timestamp. All extra sec bits on
[17:23:09] ========= [PASSED] inode_test_xtimestamp_decoding ==========
[17:23:09] ================= [PASSED] ext4_inode_test =================
[17:23:09] ============================================================
[17:23:09] Testing complete. Ran 16 tests: passed: 16
[17:23:09] Elapsed time: 1.943s total, 0.001s configuring, 1.777s building, 0.123s running

	   	   	 	       	      		   - Ted
