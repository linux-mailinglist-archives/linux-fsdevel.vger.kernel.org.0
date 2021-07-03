Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20C03BA6EC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jul 2021 05:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhGCDjo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 23:39:44 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9449 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhGCDjn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 23:39:43 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GGyGv3vK7zZp4d;
        Sat,  3 Jul 2021 11:33:59 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 3 Jul 2021 11:37:07 +0800
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
 <YN+PIKV010a+j88S@mit.edu>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <9b81eb4e-9adb-991f-31be-f5ef0092c4b3@huawei.com>
Date:   Sat, 3 Jul 2021 11:37:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <YN+PIKV010a+j88S@mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/7/3 6:11, Theodore Ts'o wrote:
> On Fri, Jul 02, 2021 at 12:11:54PM -0400, Theodore Ts'o wrote:
>> So it probably makes more sense to keep jbd2_journal_unregister_shrinker()
>> in jbd2_destroy_journal(), since arguably the fact that we are using a
>> shrinker is an internal implementation detail, and the users of jbd2
>> ideally shouldn't need to be expected to know they have unregister
>> jbd2's shirnkers.
>>
>> Similarly, perhaps we should be moving jbd2_journal_register_shirnker()
>> into jbd2_journal_init_common().  We can un-export the register and
>> unshrink register functions, and declare them as static functions internal
>> to fs/jbd2/journal.c.
>>
>> What do you think?
> 
> Like this...
> 
> commit 8f9e16badb8fda3391e03146a47c93e76680efaf
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Fri Jul 2 18:05:03 2021 -0400
> 
>     ext4: fix doubled call to jbd2_journal_unregister_shrinker()
>     
>     On Power and ARM platforms this was causing kernel crash when
>     unmounting the file system, due to a percpu_counter getting destroyed
>     twice.
>     
>     Fix this by cleaning how the jbd2 shrinker is initialized and
>     uninitiazed by making it solely the responsibility of
>     fs/jbd2/journal.c.
>     
>     Fixes: 4ba3fcdde7e3 ("jbd2,ext4: add a shrinker to release checkpointed buffers")
>     Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
>     Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index b8ff0399e171..dfa09a277b56 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1184,7 +1184,6 @@ static void ext4_put_super(struct super_block *sb)
>  	ext4_unregister_sysfs(sb);
>  
>  	if (sbi->s_journal) {
> -		jbd2_journal_unregister_shrinker(sbi->s_journal);
>  		aborted = is_journal_aborted(sbi->s_journal);
>  		err = jbd2_journal_destroy(sbi->s_journal);
>  		sbi->s_journal = NULL;
> @@ -5176,7 +5175,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  	sbi->s_ea_block_cache = NULL;
>  
>  	if (sbi->s_journal) {
> -		jbd2_journal_unregister_shrinker(sbi->s_journal);
>  		jbd2_journal_destroy(sbi->s_journal);
>  		sbi->s_journal = NULL;
>  	}
> @@ -5502,12 +5500,6 @@ static int ext4_load_journal(struct super_block *sb,
>  		ext4_commit_super(sb);
>  	}
>  
> -	err = jbd2_journal_register_shrinker(journal);
> -	if (err) {
> -		EXT4_SB(sb)->s_journal = NULL;
> -		goto err_out;
> -	}
> -
>  	return 0;
>  
>  err_out:
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 152880c298ca..2595703aca51 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -99,6 +99,8 @@ EXPORT_SYMBOL(jbd2_journal_begin_ordered_truncate);
>  EXPORT_SYMBOL(jbd2_inode_cache);
>  
>  static int jbd2_journal_create_slab(size_t slab_size);
> +static int jbd2_journal_register_shrinker(journal_t *journal);
> +static void jbd2_journal_unregister_shrinker(journal_t *journal);
>  
>  #ifdef CONFIG_JBD2_DEBUG
>  void __jbd2_debug(int level, const char *file, const char *func,
> @@ -2043,7 +2045,8 @@ int jbd2_journal_load(journal_t *journal)
>  		goto recovery_error;
>  
>  	journal->j_flags |= JBD2_LOADED;
> -	return 0;
> +
> +	return jbd2_journal_register_shrinker(journal);
>  

I check the ocfs2 code, if we register shrinker here, __ocfs2_recovery_thread()->
ocfs2_recover_node() seems will register and unregister a lot of unnecessary
shrinkers. It depends on the lifetime of the shrinker and the journal, because of
the jbd2_journal_destroy() destroy everything, it not a simple undo of
jbd2_load_journal(), so it's not easy to add shrinker properly. But it doesn't
seems like a real problem, just curious.

Thanks,
Yi.

>  recovery_error:
>  	printk(KERN_WARNING "JBD2: recovery failed\n");
> @@ -2099,7 +2102,7 @@ static unsigned long jbd2_journal_shrink_count(struct shrinker *shrink,
>   * Init a percpu counter to record the checkpointed buffers on the checkpoint
>   * list and register a shrinker to release their journal_head.
>   */
> -int jbd2_journal_register_shrinker(journal_t *journal)
> +static int jbd2_journal_register_shrinker(journal_t *journal)
>  {
>  	int err;
>  
> @@ -2122,7 +2125,6 @@ int jbd2_journal_register_shrinker(journal_t *journal)
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL(jbd2_journal_register_shrinker);
>  
>  /**
>   * jbd2_journal_unregister_shrinker()
> @@ -2130,12 +2132,13 @@ EXPORT_SYMBOL(jbd2_journal_register_shrinker);
>   *
>   * Unregister the checkpointed buffer shrinker and destroy the percpu counter.
>   */
> -void jbd2_journal_unregister_shrinker(journal_t *journal)
> +static void jbd2_journal_unregister_shrinker(journal_t *journal)
>  {
> -	percpu_counter_destroy(&journal->j_jh_shrink_count);
> -	unregister_shrinker(&journal->j_shrinker);
> +	if (journal->j_shrinker.flags & SHRINKER_REGISTERED) {
> +		percpu_counter_destroy(&journal->j_jh_shrink_count);
> +		unregister_shrinker(&journal->j_shrinker);
> +	}
>  }
> -EXPORT_SYMBOL(jbd2_journal_unregister_shrinker);
>  
>  /**
>   * jbd2_journal_destroy() - Release a journal_t structure.
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 6cc035321562..632afbe4b18f 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1556,8 +1556,6 @@ extern int	   jbd2_journal_set_features
>  		   (journal_t *, unsigned long, unsigned long, unsigned long);
>  extern void	   jbd2_journal_clear_features
>  		   (journal_t *, unsigned long, unsigned long, unsigned long);
> -extern int	   jbd2_journal_register_shrinker(journal_t *journal);
> -extern void	   jbd2_journal_unregister_shrinker(journal_t *journal);
>  extern int	   jbd2_journal_load       (journal_t *journal);
>  extern int	   jbd2_journal_destroy    (journal_t *);
>  extern int	   jbd2_journal_recover    (journal_t *journal);
> .
> 
