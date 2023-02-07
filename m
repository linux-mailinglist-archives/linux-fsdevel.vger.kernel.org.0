Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB64768DA1C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 15:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjBGOGv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 09:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjBGOGo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:06:44 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D059917151;
        Tue,  7 Feb 2023 06:06:34 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id k13so6260887wrh.8;
        Tue, 07 Feb 2023 06:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0sdZVMpxLQYROM5yifl2YJyh+klsD8t0iYVl1iZx9P4=;
        b=qqodbHl5kkWMu1RmvfP4zql9Gjli1SOz8Bn+aMeEvDzrnO5/+Q3nIKoZxXHCT2pGQR
         7taM7WW5t54715vQFxGMlBrf+SlUUZC0Wf8zsqDpfbgyj88O4WTqvTU5WCQmZsWrjYdK
         yw3sBSWop7NvuTquE8m9dHHJaHFuLLgD7oDdLCgJ6plCzd+dWiHPciJffeoRE7BiIS2y
         cOLOddKZFEIY3iTIgZgLcBuFphWQmxrK1PAJgplQTaIbDgMGath6S1EZE0+CGf3iTFe5
         zAVK6xV/JnnNGXUMu/0x+slXeBmrg8AmTLvmgfvdqEeXjMMltHRuPA+DK85b/8deBuLM
         o8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sdZVMpxLQYROM5yifl2YJyh+klsD8t0iYVl1iZx9P4=;
        b=ydnYTx32d29d8shGzF0TneEY5bsEuBSl9A56+55zP911eJ/131Jm6c4geUXeoHTUcJ
         0QLHdVvAQp8zjYySOWcf5OX17hF7T4XL/2Ju4xRbU/EnWolQRDnQjHjfZDUdqI+c6hYZ
         hgj5IXLPuA2jE9piiUvTbyGREPwpT9HjSY5YxBnkhyBoiv/bUq03ol1qbOM047tdo6jw
         e5u4SEZq0mpndxLF8SCsp0n1ZXigld1iJ3vp73Dbv8ABrO7SXWHmuijwIBTKSwdxNvhl
         1rp3kkf6dItlgV1DOlvhXREfN7bu1i9y86h6iUaqdhf35GLliUR4YjucM6uBBJcsuJo7
         Ne1g==
X-Gm-Message-State: AO0yUKWtVEukvif2GdrmSwyPRANwNMbcGvMhTb9cxlmtyEMuQasv/1Dp
        b4q2dODTh2G40ZMY7CXTXUKXxs47/kMfklS0
X-Google-Smtp-Source: AK7set9CfjRzJQwmhtlCvU40DPPmcLvdnyfqCkEbDanUlZsKsYhLiui8MEyLulquIL1L6bxXj4VK2Q==
X-Received: by 2002:adf:ce11:0:b0:2c0:227d:ca35 with SMTP id p17-20020adfce11000000b002c0227dca35mr3005641wrn.54.1675778793075;
        Tue, 07 Feb 2023 06:06:33 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600002ab00b002bfb5ebf8cfsm11961691wry.21.2023.02.07.06.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 06:06:32 -0800 (PST)
Date:   Tue, 7 Feb 2023 17:06:29 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maobibo <maobibo@loongson.cn>,
        Matthew Wilcox <willy@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: block: sleeping in atomic warnings
Message-ID: <Y+Ja5SRs886CEz7a@kadam>
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
 <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
 <Y+EjmnRqpLuBFPX1@bombadil.infradead.org>
 <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are static checker warnings from Smatch.  The line numbers are
based on next-20230203.  To reproduce these warnings then you need to
have the latest Smatch from git and you need to rebuild the cross
function probably four times.  I have reviewed these.  The first few
seem like real issues.  I can't make heads or tails out of the
__blk_mq_run_hw_queue() warning.  I suspect that the last warning is a
false positive.  I remember I reported some a while back but never
heard back.  https://lore.kernel.org/all/YNx1r8Jr3+t4bch%2F@mwanda/

regards,
dan carpenter

block/blk-crypto-profile.c:382 __blk_crypto_evict_key() warn: sleeping in atomic context
block/blk-crypto-profile.c:390 __blk_crypto_evict_key() warn: sleeping in atomic context
put_super() <- disables preempt
__iterate_supers() <- disables preempt
iterate_supers() <- disables preempt
iterate_supers_type() <- disables preempt
get_super() <- disables preempt
user_get_super() <- disables preempt
-> __put_super()
   -> fscrypt_destroy_keyring()
      -> fscrypt_put_master_key_activeref()
         -> fscrypt_destroy_prepared_key()
            -> fscrypt_destroy_inline_crypt_key()
               -> blk_crypto_evict_key()
blk_crypto_evict_key() <duplicate>
-> blk_crypto_fallback_evict_key()
                  -> __blk_crypto_evict_key()

block/blk-mq.c:206 blk_freeze_queue() warn: sleeping in atomic context
rexmit_timer() <- disables preempt
-> aoedev_downdev()
   -> blk_mq_freeze_queue()
      -> blk_freeze_queue()

block/blk-mq.c:4083 blk_mq_destroy_queue() warn: sleeping in atomic context
nvme_fc_match_disconn_ls() <- disables preempt
-> nvme_fc_ctrl_put()
   -> nvme_fc_ctrl_free()
      -> nvme_remove_admin_tag_set()
nvme_fc_ctrl_free() <duplicate>
-> nvme_remove_io_tag_set()
         -> blk_mq_destroy_queue()

block/blk-mq.c:2174 __blk_mq_run_hw_queue() warn: sleeping in atomic context
__blk_mq_run_hw_queue() <duplicate>
-> blk_mq_sched_dispatch_requests()
   -> __blk_mq_sched_dispatch_requests()
      -> blk_mq_do_dispatch_sched()
blk_mq_do_dispatch_sched() <duplicate>
-> __blk_mq_do_dispatch_sched()
   -> blk_mq_dispatch_hctx_list()
__blk_mq_do_dispatch_sched() <duplicate>
__blk_mq_sched_dispatch_requests() <duplicate>
-> blk_mq_do_dispatch_ctx()
__blk_mq_sched_dispatch_requests() <duplicate>
      -> blk_mq_dispatch_rq_list()
__blk_mq_do_dispatch_sched() <duplicate>
blk_mq_do_dispatch_ctx() <duplicate>
-> blk_mq_delay_run_hw_queues()
         -> blk_mq_delay_run_hw_queue()
sg_remove_sfp_usercontext() <- disables preempt
-> sg_finish_rem_req()
dd_insert_requests() <- disables preempt
-> dd_insert_request()
   -> blk_mq_free_requests()
mspro_block_complete_req() <- disables preempt
mspro_queue_rq() <- disables preempt
-> mspro_block_issue_req()
mspro_block_complete_req() <- disables preempt <duplicate>
aoe_flush_iocq_by_index() <- disables preempt
rexmit_timer() <- disables preempt
-> aoedev_downdev()
   -> aoe_failip()
aoedev_downdev() <duplicate>
-> downdev_frame()
      -> aoe_failbuf()
         -> aoe_end_buf()
aoe_failip() <duplicate>
            -> aoe_end_request()
               -> __blk_mq_end_request()
                  -> blk_mq_free_request()
                     -> __blk_mq_free_request()
                        -> blk_mq_sched_restart()
                           -> __blk_mq_sched_restart()
blk_mq_sched_dispatch_requests() <duplicate>
blk_mq_dispatch_rq_list() <duplicate>
rexmit_timer() <- disables preempt <duplicate>
aoe_end_request() <duplicate>
bfq_finish_requeue_request() <- disables preempt
-> bfq_completed_request()
bfq_idle_slice_timer_body() <- disables preempt
bfq_pd_offline() <- disables preempt
-> bfq_put_async_queues()
   -> __bfq_put_async_bfqq()
bfq_bio_merge() <- disables preempt
bfq_insert_request() <- disables preempt
-> bfq_init_rq()
   -> bfq_bic_update_cgroup()
      -> __bfq_bic_change_cgroup()
         -> bfq_sync_bfqq_move()
bfq_pd_offline() <- disables preempt <duplicate>
-> bfq_reparent_active_queues()
   -> bfq_reparent_leaf_entity()
            -> bfq_bfqq_move()
               -> bfq_schedule_dispatch()
nvme_fc_match_disconn_ls() <- disables preempt
-> nvme_fc_ctrl_put()
   -> nvme_fc_ctrl_free()
      -> nvme_unquiesce_admin_queue()
         -> blk_mq_unquiesce_queue()
                  -> blk_mq_run_hw_queues()
virtblk_done() <- disables preempt
virtblk_poll() <- disables preempt
-> blk_mq_start_stopped_hw_queues()
   -> blk_mq_start_stopped_hw_queue()
                              -> blk_mq_run_hw_queue()
                                 -> __blk_mq_delay_run_hw_queue()
                                    -> __blk_mq_run_hw_queue()

block/blk-wbt.c:843 wbt_init() warn: sleeping in atomic context
ioc_qos_write() <- disables preempt
-> wbt_enable_default()
   -> wbt_init()

