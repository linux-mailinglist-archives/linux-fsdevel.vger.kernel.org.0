Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FAB5EF829
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 16:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbiI2O66 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 10:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbiI2O6u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:58:50 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E437014A78B;
        Thu, 29 Sep 2022 07:58:48 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28TEwTHU008323
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 10:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664463512; bh=VVHrfOfCUXCAspdln7pBEEbuFl3EEqngl2Yk0rFX28k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=amz4/vFZQkm0igsyj+ItYvA/BSQKDV0AwbA/mk5TrlW3FvxONgvVaoK3EwkO+hhDk
         s9GQrWi6RZCPX0sjlnppwwR3YGR8UOM3SK76BK4GrBS4fmcPMdl5hSecoY1lNIGawV
         aefg2pVzy3sCnOnMo2kO42O0+hEfqD0cDcc6eOMXhiJlk1/nct7lS/zjrr0JmCfoFR
         +tCtUkCN2NOAB2QiMUaiuFIrTPvyi+nsIJLmldOqK/+x06+QkRpNnHVnWA0gWc2ejr
         oHM1ttobw+f9jT63f6HM/S1w8t/ldeJZ48Z2KJgL5KLzc6+lwhSGEgCDpQrkOi9ZXq
         sr18kLWYqKHHA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7857B15C343F; Thu, 29 Sep 2022 10:58:29 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, lczerner@redhat.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, jlayton@kernel.org,
        ebiggers@kernel.org, jack@suse.cz, david@fromorbit.com,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] ext4: don't increase iversion counter for ea_inodes
Date:   Thu, 29 Sep 2022 10:58:25 -0400
Message-Id: <166446350052.149484.6408984845570083100.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220824160349.39664-1-lczerner@redhat.com>
References: <20220824160349.39664-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 24 Aug 2022 18:03:47 +0200, Lukas Czerner wrote:
> ea_inodes are using i_version for storing part of the reference count so
> we really need to leave it alone.
> 
> The problem can be reproduced by xfstest ext4/026 when iversion is
> enabled. Fix it by not calling inode_inc_iversion() for EXT4_EA_INODE_FL
> inodes in ext4_mark_iloc_dirty().
> 
> [...]

Applied, thanks!

[1/3] ext4: don't increase iversion counter for ea_inodes
      commit: 6c7c5ade428cc65b58e4aba1925b5347970f4456
[2/3] fs: record I_DIRTY_TIME even if inode already has I_DIRTY_INODE
      commit: 625e1e67b66245b93ccae868cd4a950d257de003
[3/3] ext4: unconditionally enable the i_version counter
      commit: 59772a0cb09a7ec77362653e8be207a464fa04af

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
