Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E47573682
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 14:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbiGMMlU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 08:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiGMMlT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:41:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 162E6F5D5E
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 05:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657716077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LS1cGduFHkLensQZ/wI39hm/DOVx8J/NtfvPKQcEI7Q=;
        b=fvH4KdxcMwrEVbv75bFX+6ETJKUDLrrvnsR5yESsgscCtXezATkkLjK0INAHQ8AVwpBw4+
        xfH1LwMJUQEpZ3NcliWrJKW6giz0IWzx0n5lSGIGUCMtx1e7iX1iyDWMzLvpT3wP65DH4m
        643bqvSPFSe+FLwTSWkVyy4mllN0zgc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-fTRg6V5aO1ericb-sTfM_Q-1; Wed, 13 Jul 2022 08:41:16 -0400
X-MC-Unique: fTRg6V5aO1ericb-sTfM_Q-1
Received: by mail-qv1-f71.google.com with SMTP id oo28-20020a056214451c00b004732e817c96so3708578qvb.22
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 05:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LS1cGduFHkLensQZ/wI39hm/DOVx8J/NtfvPKQcEI7Q=;
        b=F0RsIfTogxX5xfkf91NxEfOWUF4zXg45HUb1tcj8tXUUUFVV6tdUyNQ9QN19pwRoYm
         mBZJirHUowCMBvh2xuqPBCri6nNTXANcSrjTSDWjZt9KqesdetOu6B/xz3vWgD2m6U36
         3Jgsr9tgu0zVaxxAfe4kDfqAngWyI4LG5O7iBYArFMih9kMwlAMkvYU0evwPzz1VJ6ws
         x2SigBa1uTDWS2oEjATPAERgAoFvdeuY/3Xr0jg3KRzZcYNWkWeQPhJ37SHhZ1HZAyYP
         t9PbOFuFyyvwkvMnuvy/O8jsZHIzlR5fUYl3cPsR5zGJkYrV1QBd3l9qXHdkPPbSl9w1
         dShQ==
X-Gm-Message-State: AJIora+qSCgw/42WZN+mW6aiqIbWc8xqn+GerCsHXCSuJep3V4wIfyUe
        DLYsWs0xkyWdOk1cqvpZ2j933SiNtY37/2hgCtqWKT9Pj7Os0DCqEZ4gM7/uLVLLC5ih9u4krpc
        N7gxUVX3eEekq4BdnByqxJugqmA==
X-Received: by 2002:a05:6214:c4d:b0:472:ff2d:eef7 with SMTP id r13-20020a0562140c4d00b00472ff2deef7mr2632218qvj.84.1657716075573;
        Wed, 13 Jul 2022 05:41:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u3DTRPLkCbq/8jyJX61/NXMSbT2xkWfUJI/wsHhoOoZ/VZSruy1BQJ2xLvMwxq01ZjBQJYcA==
X-Received: by 2002:a05:6214:c4d:b0:472:ff2d:eef7 with SMTP id r13-20020a0562140c4d00b00472ff2deef7mr2632204qvj.84.1657716075352;
        Wed, 13 Jul 2022 05:41:15 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id w20-20020a05620a0e9400b006b5b1d632bbsm2013058qkm.99.2022.07.13.05.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 05:41:14 -0700 (PDT)
Date:   Wed, 13 Jul 2022 08:41:11 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH v4] proc: Fix a dentry lock race between release_task and
 lookup
Message-ID: <Ys69Z4DlGhHvMDwK@bfoster>
References: <20220601062332.232439-1-chengzhihao1@huawei.com>
 <Ys2CPO4FodMlAqRR@bfoster>
 <f64637ac-9c9e-06c4-bbea-4af5c24878bf@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f64637ac-9c9e-06c4-bbea-4af5c24878bf@huawei.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 13, 2022 at 03:24:50PM +0800, Zhihao Cheng wrote:
> 在 2022/7/12 22:16, Brian Foster 写道:
> > On Wed, Jun 01, 2022 at 02:23:32PM +0800, Zhihao Cheng wrote:
> > > Commit 7bc3e6e55acf06 ("proc: Use a list of inodes to flush from proc")
> > > moved proc_flush_task() behind __exit_signal(). Then, process systemd
> > > can take long period high cpu usage during releasing task in following
> > > concurrent processes:
> > > 
> > >    systemd                                 ps
> > > kernel_waitid                 stat(/proc/tgid)
> > >    do_wait                       filename_lookup
> > >      wait_consider_task            lookup_fast
> > >        release_task
> > >          __exit_signal
> > >            __unhash_process
> > >              detach_pid
> > >                __change_pid // remove task->pid_links
> > >                                       d_revalidate -> pid_revalidate  // 0
> > >                                       d_invalidate(/proc/tgid)
> > >                                         shrink_dcache_parent(/proc/tgid)
> > >                                           d_walk(/proc/tgid)
> > >                                             spin_lock_nested(/proc/tgid/fd)
> > >                                             // iterating opened fd
> > >          proc_flush_pid                                    |
> > >             d_invalidate (/proc/tgid/fd)                   |
> > >                shrink_dcache_parent(/proc/tgid/fd)         |
> > >                  shrink_dentry_list(subdirs)               ↓
> > >                    shrink_lock_dentry(/proc/tgid/fd) --> race on dentry lock
> > > 
> > 
> > Curious... can this same sort of thing happen with /proc/<tgid>/task if
> > that dir similarly has a lot of dentries?
> > 
> 
> Yes. It could happend too. There will be many dentries under
> /proc/<tgid>/task when there are many tasks under same thread group.
> 
> We must put /proc/<tgid>/task into pid->inodes, because we have to handle
> single thread exiting situation: Any one of threads should invalidate its
> /proc/<tgid>/task/<pid> dentry before begin released. You may refer to the
> function proc_flush_task_mnt() before commit 7bc3e6e55acf06 ("proc: Use a
> list of inodes to flush from proc").
> 

Ah, I see. So historically when the (thread) task goes away, we look up
the tgid and then the associated /proc/<tgid>/task/<pid> dentry to zap
it. Thanks for the pointer..

Brian

> > ...
> > > Fixes: 7bc3e6e55acf06 ("proc: Use a list of inodes to flush from proc")
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216054
> > > Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> > > Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > > ---
> > >   v1->v2: Add new helper proc_pid_make_base_inode that performs the extra
> > > 	 work of adding to the pid->list.
> > >   v2->v3: Add performance regression in commit message.
> > >   v3->v4: Make proc_pid_make_base_inode() static
> > >   fs/proc/base.c | 34 ++++++++++++++++++++++++++--------
> > >   1 file changed, 26 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > > index c1031843cc6a..d884933950fd 100644
> > > --- a/fs/proc/base.c
> > > +++ b/fs/proc/base.c
> > ...
> > > @@ -1931,6 +1926,27 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
> > >   	return NULL;
> > >   }
> > > +static struct inode *proc_pid_make_base_inode(struct super_block *sb,
> > > +				struct task_struct *task, umode_t mode)
> > > +{
> > > +	struct inode *inode;
> > > +	struct proc_inode *ei;
> > > +	struct pid *pid;
> > > +
> > > +	inode = proc_pid_make_inode(sb, task, mode);
> > > +	if (!inode)
> > > +		return NULL;
> > > +
> > > +	/* Let proc_flush_pid find this directory inode */
> > > +	ei = PROC_I(inode);
> > > +	pid = ei->pid;
> > > +	spin_lock(&pid->lock);
> > > +	hlist_add_head_rcu(&ei->sibling_inodes, &pid->inodes);
> > > +	spin_unlock(&pid->lock);
> > > +
> > > +	return inode;
> > > +}
> > > +
> > 
> > Somewhat related to the question above.. it would be nice if this
> > wrapper had a line or two comment above it that explained when it should
> > or shouldn't be used over the underlying function (for example, why or
> > why not include /proc/<tgid>/task?). Otherwise the patch overall seems
> > reasonable to me..
> > 
> 
> Thanks for advice, I will add some notes in v5.
> > Brian
> > 
> > >   int pid_getattr(struct user_namespace *mnt_userns, const struct path *path,
> > >   		struct kstat *stat, u32 request_mask, unsigned int query_flags)
> > >   {
> > > @@ -3350,7 +3366,8 @@ static struct dentry *proc_pid_instantiate(struct dentry * dentry,
> > >   {
> > >   	struct inode *inode;
> > > -	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
> > > +	inode = proc_pid_make_base_inode(dentry->d_sb, task,
> > > +					 S_IFDIR | S_IRUGO | S_IXUGO);
> > >   	if (!inode)
> > >   		return ERR_PTR(-ENOENT);
> > > @@ -3649,7 +3666,8 @@ static struct dentry *proc_task_instantiate(struct dentry *dentry,
> > >   	struct task_struct *task, const void *ptr)
> > >   {
> > >   	struct inode *inode;
> > > -	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
> > > +	inode = proc_pid_make_base_inode(dentry->d_sb, task,
> > > +					 S_IFDIR | S_IRUGO | S_IXUGO);
> > >   	if (!inode)
> > >   		return ERR_PTR(-ENOENT);
> > > -- 
> > > 2.31.1
> > > 
> > 
> > .
> > 
> 

