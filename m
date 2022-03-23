Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7B64E4C94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 07:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241822AbiCWGN0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 02:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbiCWGNZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:13:25 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA1C7006C;
        Tue, 22 Mar 2022 23:11:57 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BDD7968AFE; Wed, 23 Mar 2022 07:11:54 +0100 (CET)
Date:   Wed, 23 Mar 2022 07:11:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 24/40] btrfs: remove btrfs_end_io_wq
Message-ID: <20220323061154.GH24302@lst.de>
References: <20220322155606.1267165-1-hch@lst.de> <20220322155606.1267165-25-hch@lst.de> <1c79e3ba-b9eb-d0df-748a-438abe705384@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c79e3ba-b9eb-d0df-748a-438abe705384@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 08:57:03AM +0800, Qu Wenruo wrote:
>
>
> On 2022/3/22 23:55, Christoph Hellwig wrote:
>> Avoid the extra allocation for all read bios by embedding a btrfs_work
>> and I/O end type into the btrfs_bio structure.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> Do we really need to bump the size of btrfs_bio furthermore?
>
> Especially btrfs_bio is allocated for each 64K stripe...

One of the async submission or completion contexts is allocated for
almost every btrfs_bio.  So overall this reduceѕ the memory usage
(at least together with the rest of the series).
