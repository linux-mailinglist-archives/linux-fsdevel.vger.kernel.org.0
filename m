Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AFF6E2E97
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 04:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjDOCaV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 22:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjDOCaU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 22:30:20 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D30B59E7
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 19:30:19 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33F2U0FZ022878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 22:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1681525802; bh=fIevDm+uriVmTqinf5/UGrVmfcUXn89AMJ33O2jW/0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pO5utc5IA/TvCHRmAd3WESBBDZm3K+4YhryfH50LCAG4lW+OtD5yPeMywwP5oVNhh
         8inDv3KHdgx1su8yuLxqQUaBAZM1taa1kmzoThthPBtAQZIoRam7RyzBlTWnyigZQo
         q+qIuYMkfVcc/fkSXnzpt96naQ7B/TQStyjml7Zm/knlilf1uvdT8636dn3qwg+X3b
         44/ZMHWDqUK5GHCFkjOJsAp0q8CZAVf4jdqSK3L+8zCS/gD/P8QeJzaPgSfkCrHu8j
         e3FgzxOq0f0Unb2lsdGbErViwEuq3ZEcxteTrquDyB1ryL7nACwCtIX9NzbOecOLtD
         vyCbwFmSzIJLA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1E6A015C4935; Fri, 14 Apr 2023 22:30:00 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/29] Convert most of ext4 to folios
Date:   Fri, 14 Apr 2023 22:29:57 -0400
Message-Id: <168152543814.510202.15297028468620459894.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230324180129.1220691-1-willy@infradead.org>
References: <20230324180129.1220691-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Fri, 24 Mar 2023 18:01:00 +0000, Matthew Wilcox (Oracle) wrote:
> On top of next-20230321, this converts most of ext4 to use folios instead
> of pages.  It does not enable large folios although it fixes some places
> that will need to be fixed before they can be enabled for ext4.  It does
> not convert mballoc to use folios.  write_begin() and write_end() still
> take a page parameter instead of a folio.
> 
> It does convert a lot of code away from the page APIs that we're trying
> to remove.  It does remove a lot of calls to compound_head().  I'd like
> to see it land in 6.4.
> 
> [...]

Applied, thanks!

[01/29] fs: Add FGP_WRITEBEGIN
        commit: e999a5c5a19cf3b679f3d93c49ad5f5c04e4806c
[02/29] fscrypt: Add some folio helper functions
        commit: c76e14dc13bcf89f3b55fd9dcd036a453a822d79
[03/29] ext4: Convert ext4_bio_write_page() to use a folio
        commit: cd57b77197a434709aec0e7fb8b2e6ec8479aa4e
[04/29] ext4: Convert ext4_finish_bio() to use folios
        commit: bb64c08bff6a6edbd85786c92a2cb980ed99b29f
[05/29] ext4: Turn mpage_process_page() into mpage_process_folio()
        commit: 4da2f6e3c45999e904de1edcd06c8533715cc1b5
[06/29] ext4: Convert mpage_submit_page() to mpage_submit_folio()
        commit: 81a0d3e126a0bb4300d1db259d89b839124f2cff
[07/29] ext4: Convert mpage_page_done() to mpage_folio_done()
        commit: 33483b3b6ee4328f37c3dcf702ba979e6a00bf8f
[08/29] ext4: Convert ext4_bio_write_page() to ext4_bio_write_folio()
        commit: e8d6062c50acbf1aba88ca6adaa1bcda058abeab
[09/29] ext4: Convert ext4_readpage_inline() to take a folio
        commit: 3edde93e07954a8860d67be4a2165514a083b6e8
[10/29] ext4: Convert ext4_convert_inline_data_to_extent() to use a folio
        commit: 83eba701cf6e582afa92987e34abc0b0dbcb690e
[11/29] ext4: Convert ext4_try_to_write_inline_data() to use a folio
        commit: f8f8c89f59f7ab037bfca8797e2cc613a5684f21
[12/29] ext4: Convert ext4_da_convert_inline_data_to_extent() to use a folio
        commit: 4ed9b598ac30913987ab46e0069620e6e8af82f0
[13/29] ext4: Convert ext4_da_write_inline_data_begin() to use a folio
        commit: 9a9d01f081ea29a5a8afc4504b1bc48daffa5cc1
[14/29] ext4: Convert ext4_read_inline_page() to ext4_read_inline_folio()
        commit: 6b87fbe4155007c3ab8e950c72db657f6cd990c6
[15/29] ext4: Convert ext4_write_inline_data_end() to use a folio
        commit: 6b90d4130ac8ee9cf2a179a617cfced71a18d252
[16/29] ext4: Convert ext4_write_begin() to use a folio
        commit: 4d934a5e6caa6dcdd3fbee7b96fe512a455863b6
[17/29] ext4: Convert ext4_write_end() to use a folio
        commit: 64fb31367598188a0a230b81c6f4397fa71fd033
[18/29] ext4: Use a folio in ext4_journalled_write_end()
        commit: feb22b77b855a6529675b4e998970ab461c0f446
[19/29] ext4: Convert ext4_journalled_zero_new_buffers() to use a folio
        commit: 86324a21627a40f949bf787b55c45b9856523f9d
[20/29] ext4: Convert __ext4_block_zero_page_range() to use a folio
        commit: 9d3973de9a3745ea9d38bdfb953a4c4bee81ac2a
[21/29] ext4: Convert ext4_page_nomap_can_writeout to ext4_folio_nomap_can_writeout
        commit: 02e4b04c56d03a518b958783900b22f33c6643d6
[22/29] ext4: Use a folio in ext4_da_write_begin()
        commit: 0b5a254395dc6db5c38d89e606c0298ed4c9e984
[23/29] ext4: Convert ext4_mpage_readpages() to work on folios
        commit: c0be8e6f081b3e966e21f52679b2f809b7df10b8
[24/29] ext4: Convert ext4_block_write_begin() to take a folio
        commit: 86b38c273cc68ce7b50649447d8ac0ddf3228026
[25/29] ext4: Use a folio in ext4_page_mkwrite()
        commit: 9ea0e45bd2f6cbfba787360f5ba8e18deabb7671
[26/29] ext4: Use a folio iterator in __read_end_io()
        commit: f2b229a8c6c2633c35cb7446cfabea5a6f721edc
[27/29] ext4: Convert mext_page_mkuptodate() to take a folio
        commit: 3060b6ef05603cf3c05b2b746f739b0169bd75f9
[28/29] ext4: Convert pagecache_read() to use a folio
        commit: b23fb762785babc1d6194770c88432da037c8a64
[29/29] ext4: Use a folio in ext4_read_merkle_tree_page
        commit: e9ebecf266c6657de5865a02a47c0d6b2460c526

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
