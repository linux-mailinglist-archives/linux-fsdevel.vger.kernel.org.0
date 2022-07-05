Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D529D566522
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 10:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiGEIgA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 04:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiGEIf7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:35:59 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84E22AFD;
        Tue,  5 Jul 2022 01:35:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8F68468AA6; Tue,  5 Jul 2022 10:35:55 +0200 (CEST)
Date:   Tue, 5 Jul 2022 10:35:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, agk@redhat.com, song@kernel.org,
        djwong@kernel.org, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, javier@javigon.com,
        johannes.thumshirn@wdc.com, bvanassche@acm.org,
        dongli.zhang@oracle.com, ming.lei@redhat.com, willy@infradead.org,
        jefflexu@linux.alibaba.com, josef@toxicpanda.com, clm@fb.com,
        dsterba@suse.com, jack@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, jlayton@kernel.org, idryomov@gmail.com,
        danil.kipnis@cloud.ionos.com, ebiggers@google.com,
        jinpu.wang@cloud.ionos.com
Subject: Re: [PATCH 4/6] nvmet: add Verify emulation support for bdev-ns
Message-ID: <20220705083555.GC19123@lst.de>
References: <20220630091406.19624-1-kch@nvidia.com> <20220630091406.19624-5-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630091406.19624-5-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 30, 2022 at 02:14:04AM -0700, Chaitanya Kulkarni wrote:
> Not all devices can support verify requests which can be mapped to
> the controller specific command. This patch adds a way to emulate
> REQ_OP_VERIFY for NVMeOF block device namespace. We add a new
> workqueue to offload the emulation.

How is this an "emulation"?

Also why do we need the workqueue offloads?  I can't see any good
reason to not just simply submit the bio asynchronously like all the
other bios submitted by the block device backend.
