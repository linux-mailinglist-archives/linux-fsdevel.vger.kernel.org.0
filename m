Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71864E4C79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 07:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241933AbiCWGFs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 02:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241932AbiCWGFr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:05:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF26E6E8E8;
        Tue, 22 Mar 2022 23:04:17 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2DC4068AFE; Wed, 23 Mar 2022 07:04:15 +0100 (CET)
Date:   Wed, 23 Mar 2022 07:04:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/40] btrfs: fix direct I/O writes for split bios on
 zoned devices
Message-ID: <20220323060415.GB24302@lst.de>
References: <20220322155606.1267165-1-hch@lst.de> <20220322155606.1267165-4-hch@lst.de> <e7b7aed3-a231-3413-9500-5a98db72454a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7b7aed3-a231-3413-9500-5a98db72454a@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 08:00:48AM +0800, Qu Wenruo wrote:
>> When a bio is split in btrfs_submit_direct, dip->file_offset contains
>> the file offset for the first bio.  But this means the start value used
>> in btrfs_end_dio_bio to record the write location for zone devices is
>> icorrect for subsequent bios.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> Maybe better to be folded with previous patch?

Well, it fixes a separate issue.
