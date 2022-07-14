Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC1C575794
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jul 2022 00:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbiGNWZL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 18:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiGNWZH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 18:25:07 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D573B3B94D
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Jul 2022 15:25:05 -0700 (PDT)
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 26EMP3rw010663;
        Fri, 15 Jul 2022 07:25:03 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Fri, 15 Jul 2022 07:25:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 26EMP3Eq010659
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 15 Jul 2022 07:25:03 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <534fa596-0c29-0f1e-b292-53ad9c3dbbe3@I-love.SAKURA.ne.jp>
Date:   Fri, 15 Jul 2022 07:24:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [syzbot] possible deadlock in start_this_handle (3)
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, linux-mm@kvack.org
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, linux-fsdevel@vger.kernel.org
References: <000000000000471c2905e3c2c2c2@google.com>
 <20220714141813.yi5p4o2tiyvkao6b@quack3>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220714141813.yi5p4o2tiyvkao6b@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/07/14 23:18, Jan Kara wrote:
> Hello,
> 
> so this lockdep report looks real but is more related to OOM handling than
> to ext4 as such. The immediate problem I can see is that
> mem_cgroup_print_oom_meminfo() which is called under oom_lock calls
> memory_stat_format() which does GFP_KERNEL allocations to allocate buffers
> for dumping of MM statistics. This creates oom_lock -> fs reclaim
> dependency and because OOM can be hit (and thus oom_lock acquired) in
> practically any allocation (regardless of GFP_NOFS) this has a potential of
> creating real deadlock cycles.
> 
> So should mem_cgroup_print_oom_meminfo() be using
> memalloc_nofs_save/restore() to avoid such deadlocks? Or perhaps someone
> sees another solution? Generally allocating memory to report OOM looks a
> bit dangerous to me ;).
> 
> 								Honza

I think mem_cgroup_print_oom_meminfo() should use GFP_ATOMIC, for it will fall into
infinite loop if kmalloc(GFP_NOFS) under oom_lock reached __alloc_pages_may_oom() path.
