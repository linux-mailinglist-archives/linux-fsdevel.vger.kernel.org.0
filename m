Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230A279457B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 23:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244898AbjIFVzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 17:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjIFVzp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:55:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CA3172E;
        Wed,  6 Sep 2023 14:55:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6218C433C7;
        Wed,  6 Sep 2023 21:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694037341;
        bh=S0dSiLl5xZTuBxsoFaJ1P9nZl7K0AtLwTDW92i1gWBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eeg9aV/XP/zUpseBnf6ghy/nfRZUKrDg/rqvQ5fd4UjnA4GBuC4a/oiy76DLWaTw6
         EKUUmFqsbtxq3Tf5rcQE5pBuRKzXr5nZ+Le0cKgBBHKLyenyZenAe1fAekmD1jJoU8
         TMedl4hjXfN1is7pZXWOcedyV1UwRE6JhZzfrfdJtaWzNWm/4DIKuj2lZd/07h/dnn
         Pc7knmX3vyEncAmtqtkqaDwBUuYxC8uhwEr59leMAO82AQCsJTVFcgJ/y6EDXPwM0R
         PvR2jBN0obLqnFPeIaFDCvPGWoajvpDxT9TTgCfPzIB3iofb3s2LuUGMPOay57ghXV
         CxhdJhuUBVB0g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BFF75403F4; Wed,  6 Sep 2023 18:55:38 -0300 (-03)
Date:   Wed, 6 Sep 2023 18:55:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs
Message-ID: <ZPj1WuwKKnvVEZnl@kernel.org>
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
 <CAHk-=wjUX287gJCKDXUY02Wpot1n0VkjQk-PmDOmrsrEfwPfPg@mail.gmail.com>
 <CAHk-=whaiVhuO7W1tb8Yb-CuUHWn7bBnJ3bM7bvcQiEQwv_WrQ@mail.gmail.com>
 <CAHk-=wi6EAPRzYttb+qnZJuzinUnH9xXy-a1Y5kvx5Qs=6xDew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wi6EAPRzYttb+qnZJuzinUnH9xXy-a1Y5kvx5Qs=6xDew@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Em Wed, Sep 06, 2023 at 01:20:59PM -0700, Linus Torvalds escreveu:
> On Wed, 6 Sept 2023 at 13:02, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > And guess what happens when you have (unsigned char)-1? It does *not*
> > cast back to -1.
> 
> Side note: again, this may be one of those "it works in practice",
> because if we have -fshort-enums, I think 'enum
> btree_node_locked_type' in turn ends up being represented as a 'signed
> char', because that's the smallest simple type that can fit all those
> values.
 
> I don't think gcc ever uses less than that (ie while a six_lock_type
> could fit in two bits, it's still going to be considered at least a
> 8-bit value in practice).

There are some cases where people stuff the enum into a bitfield, but
no, no simple type.

⬢[acme@toolbox perf-tools-next]$ pahole | grep -w enum | grep :
	enum btrfs_rsv_type        type:8;               /*    28:16  4 */
	enum btrfs_delayed_item_type type:8;             /*   100: 0  4 */
	enum kernel_pkey_operation op:8;                 /*    40: 0  4 */
	enum integrity_status      ima_file_status:4;    /*    96: 0  4 */
	enum integrity_status      ima_mmap_status:4;    /*    96: 4  4 */
	enum integrity_status      ima_bprm_status:4;    /*    96: 8  4 */
	enum integrity_status      ima_read_status:4;    /*    96:12  4 */
	enum integrity_status      ima_creds_status:4;   /*    96:16  4 */
	enum integrity_status      evm_status:4;         /*    96:20  4 */
	enum fs_context_purpose    purpose:8;            /*   152: 0  4 */
	enum fs_context_phase      phase:8;              /*   152: 8  4 */
	enum fs_value_type         type:8;               /*     8: 0  4 */
	enum sgx_page_type         type:16;              /*     8: 8  4 */
	enum nf_hook_ops_type      hook_ops_type:8;      /*    24: 8  4 */
		enum resctrl_event_id evtid:8;         /*     0:10  4 */
		enum _cache_type   type:5;             /*     0: 0  4 */
⬢[acme@toolbox perf-tools-next]$ pahole _cache_type
enum _cache_type {
	CTYPE_NULL    = 0,
	CTYPE_DATA    = 1,
	CTYPE_INST    = 2,
	CTYPE_UNIFIED = 3,
};

⬢[acme@toolbox perf-tools-next]$ pahole integrity_status
enum integrity_status {
	INTEGRITY_PASS           = 0,
	INTEGRITY_PASS_IMMUTABLE = 1,
	INTEGRITY_FAIL           = 2,
	INTEGRITY_FAIL_IMMUTABLE = 3,
	INTEGRITY_NOLABEL        = 4,
	INTEGRITY_NOXATTRS       = 5,
	INTEGRITY_UNKNOWN        = 6,
};

⬢[acme@toolbox perf-tools-next]
> 
> So we may have 'enum six_lock_type' essentially being 'unsigned char',
> and when the code does
> 
>     mark_btree_node_locked(trans, path, 0, BTREE_NODE_UNLOCKED);
> 
> that BTREE_NODE_UNLOCKED value might actually be 255.
> 
> And then when it's cast to 'enum btree_node_locked_type' in the inline
> function, the 255 will be cast to 'signed char', and we'll end up
> compatible with '(enum btree_node_locked_type)-1' again.
> 
> So it's one of those things that are seriously wrong to do, but might
> generate the expected code anyway.
> 
> Unless the compiler adds any other sanity checks, like UBSAN or
> something, that actually uses the exact range of the enums.
> 
> It could happen even without UBSAN, if the compiler ends up going "I
> can see that the original value came from a 'enum six_lock_type', so I
> know the original value can't be signed, so any comparison with
> BTREE_NODE_UNLOCKED can never be true.
> 
> But again, I suspect that in practice this all just happens to work.
> That doesn't make it right.
> 
>                Linus

-- 

- Arnaldo
