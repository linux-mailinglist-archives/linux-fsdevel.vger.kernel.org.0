Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC206B200C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 10:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjCIJbY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 04:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjCIJbY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:31:24 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DD7231F1;
        Thu,  9 Mar 2023 01:31:22 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B43EA68BEB; Thu,  9 Mar 2023 10:31:19 +0100 (CET)
Date:   Thu, 9 Mar 2023 10:31:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/34] btrfs: add a btrfs_inode pointer to struct
 btrfs_bio
Message-ID: <20230309093119.GB23816@lst.de>
References: <20230121065031.1139353-1-hch@lst.de> <20230121065031.1139353-4-hch@lst.de> <88b2fae1-8d95-2172-7bc4-c5dfc4ff7410@gmx.com> <20230307144106.GA19477@lst.de> <96f5c29c-1b25-66af-1ba1-731ae39d912d@gmx.com> <5aff53ea-0666-d4d6-3bf1-07b3674a405a@gmx.com> <20230308142817.GA14929@lst.de> <9c59ce30-f217-568e-a3a0-f5a8fd1ac107@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c59ce30-f217-568e-a3a0-f5a8fd1ac107@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 09, 2023 at 08:08:34AM +0800, Qu Wenruo wrote:
> My current one is a new btrfs_submit_scrub_read() helper, getting rid of 
> features I don't need and slightly modify the endio functions to avoid any 
> checks if no bbio->inode. AKA, most of your idea.
>
> So that would be mostly fine.

This looks mostly ok to me.  I suspect in the longer run all metadata
I/O might be able to use this helper as well.

> But for RAID56, the bioc has to live long enough for raid56 work to finish, 
> thus has to go btrfs_raid56_end_io() and rely on the extra bbio->end_io().

The bioc lifetimes for RAID56 are a bit odd and one of the things I'd
love to eventually look into, but іt's not very high on the priority list
right now.
