Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4247F4CCB41
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 02:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237540AbiCDBWM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 20:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbiCDBWK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 20:22:10 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E33A17B0F9;
        Thu,  3 Mar 2022 17:21:22 -0800 (PST)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K8ql5442CzBrJg;
        Fri,  4 Mar 2022 09:19:29 +0800 (CST)
Received: from [10.67.110.83] (10.67.110.83) by canpemm500006.china.huawei.com
 (7.192.105.130) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 4 Mar
 2022 09:21:20 +0800
Subject: Re: [PATCH v4 1/2] fs/proc: optimize exactly register one ctl_table
To:     Meng Tang <tangmeng@uniontech.com>, <mcgrof@kernel.org>,
        <keescook@chromium.org>, <yzaikin@google.com>,
        <ebiederm@xmission.com>, <willy@infradead.org>
CC:     <nizhen@uniontech.com>, <zhanglianjie@uniontech.com>,
        <sujiaxun@uniontech.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20220303070847.28684-1-tangmeng@uniontech.com>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <624f92f0-c2a1-c7d9-a4ed-6d72c48d3ab3@huawei.com>
Date:   Fri, 4 Mar 2022 09:21:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20220303070847.28684-1-tangmeng@uniontech.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.83]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/3/3 15:08, Meng Tang wrote:
> Sysctls are being moved out of kernel/sysctl.c and out to
> their own respective subsystems / users to help with easier
> maintance and avoid merge conflicts. But when we move just
> one entry and to its own new file the last entry for this
> new file must be empty, so we are essentialy bloating the
> kernel one extra empty entry per each newly moved sysctl.
> 
> To help with this, this adds support for registering just
> one ctl_table, therefore not bloating the kernel when we
> move a single ctl_table to its own file.
> 
> Since the process of registering just one single table is the
> same as that of registering an array table, so the code is
> similar to registering an array table. The difference between
> registering just one table and registering an array table is
> that we no longer traversal through pointers when registering
> a single table. These lead to that we have to add a complete
> implementation process for register just one ctl_table, so we
> have to add so much code.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Meng Tang <tangmeng@uniontech.com>
> ---
>   fs/proc/proc_sysctl.c  | 159 +++++++++++++++++++++++++++++------------
>   include/linux/sysctl.h |   9 ++-
>   2 files changed, 121 insertions(+), 47 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 6c87c99f0856..e06d2094457a 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -19,6 +19,8 @@
>   #include <linux/kmemleak.h>
>   #include "internal.h"
>   
> +#define REGISTER_SINGLE_ONE (register_single_one ? true : false)
> +
>   static const struct dentry_operations proc_sys_dentry_operations;
>   static const struct file_operations proc_sys_file_operations;
>   static const struct inode_operations proc_sys_inode_operations;
> @@ -100,8 +102,8 @@ static DEFINE_SPINLOCK(sysctl_lock);
>   static void drop_sysctl_table(struct ctl_table_header *header);
>   static int sysctl_follow_link(struct ctl_table_header **phead,
>   	struct ctl_table **pentry);
> -static int insert_links(struct ctl_table_header *head);
> -static void put_links(struct ctl_table_header *header);
> +static int insert_links(struct ctl_table_header *head, bool register_single_one);
> +static void put_links(struct ctl_table_header *header, bool register_single_one);
>   
>   static void sysctl_print_dir(struct ctl_dir *dir)
>   {
> @@ -200,7 +202,7 @@ static void erase_entry(struct ctl_table_header *head, struct ctl_table *entry)
>   
>   static void init_header(struct ctl_table_header *head,
>   	struct ctl_table_root *root, struct ctl_table_set *set,
> -	struct ctl_node *node, struct ctl_table *table)
> +	struct ctl_node *node, struct ctl_table *table, bool register_single_one)
>   {
>   	head->ctl_table = table;
>   	head->ctl_table_arg = table;
> @@ -215,19 +217,26 @@ static void init_header(struct ctl_table_header *head,
>   	INIT_HLIST_HEAD(&head->inodes);
>   	if (node) {
>   		struct ctl_table *entry;
> -		for (entry = table; entry->procname; entry++, node++)
> +		for (entry = table; entry->procname; entry++, node++) {
>   			node->header = head;
> +			if (register_single_one)
The scalability is reduced.
If you add a file interface in the future, you need to make at least two 
code changes.

Instead of having each consumer keep the current table size in mind, you 
can obtain the table size by ARRAY_SIZE() in the API interface.

For example,

+ #define register_sysctl_init(path, table) 
__register_sysctl_init(path, table, ARRAY_SIZE(table))
...
-		for (entry = table; entry->procname; entry++, node++)
+		for (entry = table; entry->procname && num > 0; entry++, node++, num--) {


Xiaoming Ni
thanks
