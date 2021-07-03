Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645773BA6D8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jul 2021 05:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhGCDHn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 23:07:43 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:10241 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhGCDHm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 23:07:42 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GGxWP1Z0qz1BSYn;
        Sat,  3 Jul 2021 10:59:45 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 3 Jul 2021 11:05:07 +0800
Subject: Re: [powerpc][5.13.0-next-20210701] Kernel crash while running
 ltp(chdir01) tests
To:     Theodore Ts'o <tytso@mit.edu>
CC:     Jan Kara <jack@suse.cz>, <linuxppc-dev@lists.ozlabs.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <26ACA75D-E13D-405B-9BFC-691B5FB64243@linux.vnet.ibm.com>
 <bf1c5b38-92f1-65db-e210-a97a199718ba@linux.dev>
 <4cc87ab3-aaa6-ed87-b690-5e5b99de8380@huawei.com>
 <03f734bd-f36e-f55b-0448-485b8a0d5b75@huawei.com> <YN86yl5kgVaRixxQ@mit.edu>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <36778615-86fd-9a19-9bc9-f93a6f2d5817@huawei.com>
Date:   Sat, 3 Jul 2021 11:05:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <YN86yl5kgVaRixxQ@mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/7/3 0:11, Theodore Ts'o wrote:
> On Fri, Jul 02, 2021 at 09:52:13PM +0800, Zhang Yi wrote:
>>
>> Sorry about not catching this problem, this fix is not format corrected,
>> if you think this fix is OK, I can send a patch after test.
> 
> The issue I see with your approach, which removes the
> jbd2_journal_unregister_shrinker() call from jbd2_destsroy_journal(),
> is that means that *all* callers of jbd2_destroy_journal now have to
> be responsible for calling jbd2_journal_unregister_shrinker() --- and
> there a number of call sites to jbd2_journal_unregister_shrinker():
> 
> fs/ext4/super.c:		err = jbd2_journal_destroy(sbi->s_journal);
> fs/ext4/super.c:		jbd2_journal_destroy(sbi->s_journal);
> fs/ext4/super.c:	jbd2_journal_destroy(journal);
> fs/ext4/super.c:		jbd2_journal_destroy(journal);
> fs/ext4/super.c:	jbd2_journal_destroy(journal);
> fs/ocfs2/journal.c:	if (!jbd2_journal_destroy(journal->j_journal) && !status) {
> fs/ocfs2/journal.c:		jbd2_journal_destroy(journal);
> fs/ocfs2/journal.c:	jbd2_journal_destroy(journal);
> 

Originally, I want to add this shrinker as a optional feature for jbd2 because
only ext4 use it now and I'm not sure does ocfs2 needs this feature. So I export
jbd2_journal_[un]register_shrinker(), ext4 could invoke them individually.

If with my fix, there is no responsible for calling
jbd2_journal_unregister_shrinker() before every jbd2_journal_destroy(). There
are only two places that need to do this, one is the error path after
ext4_load_journal() because we have already register the shrinker, other one
is in ext4_put_super() before the final release of the journal.
jbd2_journal_unregister_shrinker() and jbd2_journal_destroy() do not have
the strong dependence.

And one more thing we to could do is rename the 'j_jh_shrink_count' to something
like 'j_checkpoint_jh_count' because we always init it no matter we register the
shrinker or not later.

> So it probably makes more sense to keep jbd2_journal_unregister_shrinker()
> in jbd2_destroy_journal(), since arguably the fact that we are using a
> shrinker is an internal implementation detail, and the users of jbd2
> ideally shouldn't need to be expected to know they have unregister
> jbd2's shirnkers.
> 
> Similarly, perhaps we should be moving jbd2_journal_register_shirnker()
> into jbd2_journal_init_common().  We can un-export the register and
> unshrink register functions, and declare them as static functions internal
> to fs/jbd2/journal.c.
> 

Yeah, it's make sense and It's sound good to me if the shrinker doesn't have
side effects on osfs2.

Thanks,
Yi.
