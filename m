Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 778FD114BDA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 06:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfLFFJc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 00:09:32 -0500
Received: from mail.phunq.net ([66.183.183.73]:50290 "EHLO phunq.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfLFFJc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 00:09:32 -0500
Received: from [172.16.1.14]
        by phunq.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.92.3)
        (envelope-from <daniel@phunq.net>)
        id 1id5rt-000825-1z; Thu, 05 Dec 2019 21:09:29 -0800
Subject: Re: [RFC] Thing 1: Shardmap for Ext4
To:     Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
 <20191127142508.GB5143@mit.edu>
 <c3636a43-6ae9-25d4-9483-34770b6929d0@phunq.net>
 <20191128022817.GE22921@mit.edu>
 <3b5f28e5-2b88-47bb-1b32-5c2fed989f0b@phunq.net>
 <20191130175046.GA6655@mit.edu>
 <76ddbdba-55ba-3426-2e29-0fa17db9b6d8@phunq.net>
 <23F33101-065E-445A-AE5C-D05E35E2B78B@dilger.ca>
 <20191204234106.GC5641@mit.edu> <20191206011640.GQ2695@dread.disaster.area>
From:   Daniel Phillips <daniel@phunq.net>
Message-ID: <1dd1f9f6-89a4-e73a-d7b9-94a12412876c@phunq.net>
Date:   Thu, 5 Dec 2019 21:09:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191206011640.GQ2695@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-12-05 5:16 p.m., Dave Chinner wrote:
> On Wed, Dec 04, 2019 at 06:41:06PM -0500, Theodore Y. Ts'o wrote:
>> On Wed, Dec 04, 2019 at 11:31:50AM -0700, Andreas Dilger wrote:
>>> One important use case that we have for Lustre that is not yet in the
>>> upstream ext4[*] is the ability to do parallel directory operations.
>>> This means we can create, lookup, and/or unlink entries in the same
>>> directory concurrently, to increase parallelism for large directories.
>>>
>>> [*] we've tried to submit the pdirops patch a couple of times, but the
>>> main blocker is that the VFS has a single directory mutex and couldn't
>>> use the added functionality without significant VFS changes.
>>> Patch at https://git.whamcloud.com/?p=fs/lustre-release.git;f=ldiskfs/kernel_patches/patches/rhel8/ext4-pdirop.patch;hb=HEAD
>>>
>>
>> The XFS folks recently added support for parallel directory operations
>> into the VFS, for the benefit of XFS has this feature.
> 
> The use of shared i_rwsem locking on the directory inode during
> lookup/pathwalk allows for concurrent lookup/readdir operations on
> a single directory. However, the parent dir i_rwsem is still held
> exclusive for directory modifications like create, unlink, etc.
> 
> IOWs, the VFS doesn't allow for concurrent directory modification
> right now, and that's going to be the limiting factor no matter what
> you do with internal filesystem locking.

On a scale of 0 to 10, how hard do you think that would be to relax
in VFS, given the restriction of no concurrent inter-directory moves?
