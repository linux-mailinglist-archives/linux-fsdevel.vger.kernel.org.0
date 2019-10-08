Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7BDCF32C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 09:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbfJHHEz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 03:04:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:1926 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729740AbfJHHEy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:04:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 00:04:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="277017670"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga001.jf.intel.com with ESMTP; 08 Oct 2019 00:04:51 -0700
Subject: Re: [PATCH] proc:fix confusing macro arg name
To:     linmiaohe <linmiaohe@huawei.com>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "cyphar@cyphar.com" <cyphar@cyphar.com>,
        "christian@brauner.io" <christian@brauner.io>
Cc:     Mingfangsen <mingfangsen@huawei.com>,
        "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <165631b964b644dfa933653def533e41@huawei.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <56474105-0df0-975b-a347-711c1c6422f2@linux.intel.com>
Date:   Tue, 8 Oct 2019 15:04:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <165631b964b644dfa933653def533e41@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/10/8 14:44, linmiaohe wrote:
> Add suitable additional cc's as Andrew Morton suggested.
> Get cc list from get_maintainer script:
> [root@localhost mm]# ./scripts/get_maintainer.pl 0001-proc-fix-confusing-macro-arg-name.patch 
> Alexey Dobriyan <adobriyan@gmail.com> (reviewer:PROC FILESYSTEM)
> linux-kernel@vger.kernel.org (open list:PROC FILESYSTEM)
> linux-fsdevel@vger.kernel.org (open list:PROC FILESYSTEM)
> 
> ------------------------------------------------------
> From: Miaohe Lin <linmiaohe@huawei.com>
> Subject: fix confusing macro arg name
> 
> state_size and ops are in the wrong position, fix it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---

Good catch!

This is interesting, I saw this interface has 50+ callers,
How did they work before? ;)

Thanks,
-Aubrey

> 
>  include/linux/proc_fs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h index a705aa2d03f9..0640be56dcbd 100644
> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -58,8 +58,8 @@ extern int remove_proc_subtree(const char *, struct proc_dir_entry *);  struct proc_dir_entry *proc_create_net_data(const char *name, umode_t mode,
>  		struct proc_dir_entry *parent, const struct seq_operations *ops,
>  		unsigned int state_size, void *data);
> -#define proc_create_net(name, mode, parent, state_size, ops) \
> -	proc_create_net_data(name, mode, parent, state_size, ops, NULL)
> +#define proc_create_net(name, mode, parent, ops, state_size) \
> +	proc_create_net_data(name, mode, parent, ops, state_size, NULL)
>  struct proc_dir_entry *proc_create_net_single(const char *name, umode_t mode,
>  		struct proc_dir_entry *parent,
>  		int (*show)(struct seq_file *, void *), void *data);
> --
> 2.21.GIT
> 
> 

