Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBEB4E7C1A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Mar 2022 01:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiCYWN0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 18:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbiCYWNZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 18:13:25 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246CA5FE6;
        Fri, 25 Mar 2022 15:11:49 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 22PMBkTc022969
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 18:11:46 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0A05415C0038; Fri, 25 Mar 2022 18:11:46 -0400 (EDT)
Date:   Fri, 25 Mar 2022 18:11:46 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Fariya F <fariya.fatima03@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: df returns incorrect size of partition due to huge overhead
 block count in ext4 partition
Message-ID: <Yj4+IqC6FPzEOhcW@mit.edu>
References: <CACA3K+i8nZRBxeTfdy7Uq5LHAsbZEHTNati7-RRybsj_4ckUyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACA3K+i8nZRBxeTfdy7Uq5LHAsbZEHTNati7-RRybsj_4ckUyw@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 25, 2022 at 12:12:30PM +0530, Fariya F wrote:
> The output dumpe2fs returns the following
> 
>     Block count:              102400
>     Reserved block count:     5120
>     Overhead blocks:          50343939

Yeah, that value is obviously wrong; I'm not sure how it got
corrupted, but that's the cause of the your problem.

> a) Where does overhead blocks get set?

The kernel can calculate the overhead value, but it can be slow for
very large file systems.  For that reason, it is cached in the
superblock.  So if the s_overhead_clusters is zero, the kernel will
calculate the overhead value, and then update the superblock.

In newer versions of e2fsprogs, mkfs.ext4 / mke2fs will write the
overhead value into the superblock.

> b) Why is this value huge for my partition and how to correct it
> considering fsck is also not correcting this

The simpleest way is to run the following command with the file system
unmounted:

debugfs -w -R "set_super_value overhead_clusters 0" /dev/sdXX

Then the next time you mount the file system, the correct value should
get caluclated and filled in.

It's a bug that fsck isn't notcing the problem and correcting it.
I'll work on getting that fixed in a future version of e2fsprogs.

My apologies for the inconvenience.

Cheers,

					- Ted
