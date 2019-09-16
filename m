Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56C19B33A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 05:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfIPDED (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Sep 2019 23:04:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50122 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfIPDED (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Sep 2019 23:04:03 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i9hIx-0004eR-M7; Mon, 16 Sep 2019 03:03:55 +0000
Date:   Mon, 16 Sep 2019 04:03:55 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     kernel test robot <lkp@intel.com>
Cc:     "zhengbin (A)" <zhengbin13@huawei.com>, jack@suse.cz,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
Subject: Re: 266a9a8b41: WARNING:possible_recursive_locking_detected
Message-ID: <20190916030355.GZ1131@ZenIV.linux.org.uk>
References: <20190914161622.GS1131@ZenIV.linux.org.uk>
 <20190916020434.tutzwipgs4f6o3di@inn2.lkp.intel.com>
 <20190916025827.GY1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916025827.GY1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 16, 2019 at 03:58:27AM +0100, Al Viro wrote:
> On Mon, Sep 16, 2019 at 10:04:34AM +0800, kernel test robot wrote:
> > FYI, we noticed the following commit (built with gcc-7):
> > 
> > commit: 266a9a8b41803281e192151ae99779a7d50fc391 ("[PATCH] Re: Possible FS race condition between iterate_dir and d_alloc_parallel")
> > url: https://github.com/0day-ci/linux/commits/Al-Viro/Re-Possible-FS-race-condition-between-iterate_dir-and-d_alloc_parallel/20190915-052109
> > 
> > 
> > in testcase: rcutorture
> > with following parameters:
> > 
> > 	runtime: 300s
> > 	test: default
> > 	torture_type: srcu
> > 
> > test-description: rcutorture is rcutorture kernel module load/unload test.
> > test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt
> > 
> > 
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> False positive; dget() on child while holding ->d_lock on parent is OK.
> We could turn that into explicit spin_lock_nested() on child + increment of
> ->d_count under that, but this is a pointless pessimization.  Not sure
> what's the best way to tell lockdep to STFU here, but in this case it
> really ought to - locking order is correct.

Perhaps lockref_get_nested(struct lockref *lockref, unsigned int subclass)?
With s/spin_lock/spin_lock_nested/ in the body...
