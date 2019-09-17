Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37099B4D51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 14:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfIQMB3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 08:01:29 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42998 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfIQMB3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 08:01:29 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iACAX-0001Nk-Lm; Tue, 17 Sep 2019 12:01:17 +0000
Date:   Tue, 17 Sep 2019 13:01:17 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "zhengbin (A)" <zhengbin13@huawei.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <lkp@intel.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>, LKP <lkp@01.org>
Subject: Re: 266a9a8b41: WARNING:possible_recursive_locking_detected
Message-ID: <20190917120117.GG1131@ZenIV.linux.org.uk>
References: <20190914161622.GS1131@ZenIV.linux.org.uk>
 <20190916020434.tutzwipgs4f6o3di@inn2.lkp.intel.com>
 <20190916025827.GY1131@ZenIV.linux.org.uk>
 <20190916030355.GZ1131@ZenIV.linux.org.uk>
 <CAHk-=wii2apAb9WHCaOt8vnQjk8yXAHnMEC6im0f0YiEF4PwOA@mail.gmail.com>
 <20190916171606.GA1131@ZenIV.linux.org.uk>
 <bd707e64-9650-e9ed-a820-e2cabd02eaf8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd707e64-9650-e9ed-a820-e2cabd02eaf8@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 17, 2019 at 03:03:33PM +0800, zhengbin (A) wrote:
> 
> On 2019/9/17 1:16, Al Viro wrote:
> > On Sun, Sep 15, 2019 at 08:44:05PM -0700, Linus Torvalds wrote:
> >> On Sun, Sep 15, 2019 at 8:04 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >>> Perhaps lockref_get_nested(struct lockref *lockref, unsigned int subclass)?
> >>> With s/spin_lock/spin_lock_nested/ in the body...
> >> Sure. Under the usual CONFIG_DEBUG_LOCK_ALLOC, with the non-debug case
> >> just turning into a regular lockref_get().
> >>
> >> Sounds fine to me.
> > Done and force-pushed into vfs.git#fixes
> + if (file->f_pos > 2) {
> + p = scan_positives(cursor, &dentry->d_subdirs,
> + file->f_pos - 2, &to);
> + spin_lock(&dentry->d_lock);
> + list_move(&cursor->d_child, p);
> + spin_unlock(&dentry->d_lock);
> + } else {
> + spin_lock(&dentry->d_lock);
> + list_del_init(&cursor->d_child);
> + spin_unlock(&dentry->d_lock);
> }
> +
> + dput(to);
> dput(to) should be in if if (file->f_pos > 2)? cause we dget(to) in scan_positives

dput(NULL) is a no-op
