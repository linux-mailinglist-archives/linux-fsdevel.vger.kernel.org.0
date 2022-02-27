Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5234C5F0E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 22:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiB0V12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 16:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiB0V11 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 16:27:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA87E6CA5B;
        Sun, 27 Feb 2022 13:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AwZYG8gzsPNsUer/BsR+iyHMlqDjbi/zLW3YNJEjVOI=; b=e1kruyOL57MLfiaB54wleGnBfU
        vpLPfH8tGl3MzRowDQPucBYcoA4AnkJH2SOChTcwMG4UhvvoLWrYXHrijK2NG4RW+Fzgjo1a3nGoa
        gl/ENCKaOdWgiulNc64rbMCHvkY5MSy1o+UqSxnLxL4+VojgX46NbrAqaGhN3NnlOdylCaa18+2u1
        5I8DT4j+kw2QQMzWDnBR4jg3s7l9GbZV61/sTqeq2Sb7U0c4giOWdCpoAL78NFnx8ZIJ4/jLn9mba
        YFdgjW1u2I7/wJT/ayEMqbgZWvnLVw323z0VdwwjtOVQjdt37AD2Va3PjcRJvQVMzWYapVL18UZLX
        1bHN1x6g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOR3h-00AEap-OW; Sun, 27 Feb 2022 21:26:25 +0000
Date:   Sun, 27 Feb 2022 13:26:25 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Meng Tang <tangmeng@uniontech.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        nizhen@uniontech.com, zhanglianjie@uniontech.com,
        sujiaxun@uniontech.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mcgrof@kernel.org
Subject: Re: [PATCH] fs/proc: optimize exactly register one ctl_table
Message-ID: <YhvsgZesRNQmfkIB@bombadil.infradead.org>
References: <20220224093201.12440-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224093201.12440-1-tangmeng@uniontech.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 24, 2022 at 05:32:01PM +0800, Meng Tang wrote:
> Currently, sysctl is being moved to its own file. But ctl_table
> is quite large(64 bytes per entry) and every array is terminated
> with an empty one. This leads to thar when register exactly one
> ctl_table, we've gone from 64 bytes to 128 bytes.

How about:

Sysctls are being moved out of kernel/sysctl.c and out to
their own respective subsystems / users to help with easier
maintance and avoid merge conflicts. But when we move just
one entry and to its own new file the last entry for this
new file must be empty, so we are essentialy bloating the
kernel one extra empty entry per each newly moved sysctl.

> So, it is obviously the right thing that we need to fix.
>
> In order to avoid compatibility problems, and to be compatible
> with array terminated with an empty one and register exactly one
> ctl_table, add the register_one variable in the ctl_table
> structure to fix it.

How about:

To help with this, this adds support for registering just 
one ctl_table, therefore not bloating the kernel when we
move a single ctl_table to its own file.

> When we register exactly one table, we only need to add
> "table->register = true" to avoid gone from 64 bytes to 128 bytes.

Hmm, let me think about this....

> Signed-off-by: Meng Tang <tangmeng@uniontech.com>
> ---
>  fs/proc/proc_sysctl.c  | 58 +++++++++++++++++++++++++++++++++++++++---
>  include/linux/sysctl.h |  1 +
>  2 files changed, 56 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 7d9cfc730bd4..9ecd5c87e8dd 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -215,16 +215,24 @@ static void init_header(struct ctl_table_header *head,
>  	INIT_HLIST_HEAD(&head->inodes);
>  	if (node) {
>  		struct ctl_table *entry;
> -		for (entry = table; entry->procname; entry++, node++)
> +		for (entry = table; entry->procname; entry++, node++) {
>  			node->header = head;
> +
> +			if (entry->register_one)
> +				break;
> +		}
>  	}
>  }

Sure..

>  static void erase_header(struct ctl_table_header *head)
>  {
>  	struct ctl_table *entry;
> -	for (entry = head->ctl_table; entry->procname; entry++)
> +	for (entry = head->ctl_table; entry->procname; entry++) {
>  		erase_entry(head, entry);
> +
> +		if (entry->register_one)
> +			break;
> +	}
>  }


Sure..

>  
>  static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
> @@ -252,6 +260,9 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
>  		err = insert_entry(header, entry);
>  		if (err)
>  			goto fail;
> +
> +		if (entry->register_one)
> +			break;
>  	}
>  	return 0;
>  fail:
> @@ -1159,6 +1170,9 @@ static int sysctl_check_table(const char *path, struct ctl_table *table)
>  		if ((table->mode & (S_IRUGO|S_IWUGO)) != table->mode)
>  			err |= sysctl_err(path, table, "bogus .mode 0%o",
>  				table->mode);
> +
> +		if (table->register_one)
> +			break;

sure..

>  	}
>  	return err;
>  }
> @@ -1177,6 +1191,9 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table
>  	for (entry = table; entry->procname; entry++) {
>  		nr_entries++;
>  		name_bytes += strlen(entry->procname) + 1;
> +
> +		if (entry->register_one)
> +			break;

sure..
>  	}
>  
>  	links = kzalloc(sizeof(struct ctl_table_header) +
> @@ -1199,6 +1216,9 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table
>  		link->mode = S_IFLNK|S_IRWXUGO;
>  		link->data = link_root;
>  		link_name += len;
> +
> +		if (entry->register_one)
> +			break;
>  	}
>  	init_header(links, dir->header.root, dir->header.set, node, link_table);
>  	links->nreg = nr_entries;
> @@ -1218,6 +1238,15 @@ static bool get_links(struct ctl_dir *dir,
>  		link = find_entry(&head, dir, procname, strlen(procname));
>  		if (!link)
>  			return false;
> +
> +		if (entry->register_one) {
> +			if (S_ISDIR(link->mode) && S_ISDIR(entry->mode))
> +				break;
> +			if (S_ISLNK(link->mode) && (link->data == link_root))
> +				break;
> +			return false;
> +		}
> +
>  		if (S_ISDIR(link->mode) && S_ISDIR(entry->mode))
>  			continue;
>  		if (S_ISLNK(link->mode) && (link->data == link_root))
> @@ -1230,6 +1259,8 @@ static bool get_links(struct ctl_dir *dir,
>  		const char *procname = entry->procname;
>  		link = find_entry(&head, dir, procname, strlen(procname));
>  		head->nreg++;
> +		if (entry->register_one)
> +			break;

Etc...
>  	}
>  	return true;
>  }
> @@ -1295,6 +1326,8 @@ static int insert_links(struct ctl_table_header *head)
>   *
>   * mode - the file permissions for the /proc/sys file
>   *
> + * register_one - set to true when exactly register one ctl_table
> + *
>   * child - must be %NULL.
>   *
>   * proc_handler - the text handler routine (described below)
> @@ -1329,9 +1362,13 @@ struct ctl_table_header *__register_sysctl_table(
>  	struct ctl_node *node;
>  	int nr_entries = 0;
>  
> -	for (entry = table; entry->procname; entry++)
> +	for (entry = table; entry->procname; entry++) {
>  		nr_entries++;
>  
> +		if (entry->register_one)
> +			break;
> +	}
> +
>  	header = kzalloc(sizeof(struct ctl_table_header) +
>  			 sizeof(struct ctl_node)*nr_entries, GFP_KERNEL);
>  	if (!header)
> @@ -1461,6 +1498,9 @@ static int count_subheaders(struct ctl_table *table)
>  			nr_subheaders += count_subheaders(entry->child);
>  		else
>  			has_files = 1;
> +
> +		if (entry->register_one)
> +			break;
>  	}
>  	return nr_subheaders + has_files;
>  }
> @@ -1480,6 +1520,9 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
>  			nr_dirs++;
>  		else
>  			nr_files++;
> +
> +		if (entry->register_one)
> +			break;
>  	}
>  
>  	files = table;
> @@ -1497,6 +1540,9 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
>  				continue;
>  			*new = *entry;
>  			new++;
> +
> +			if (entry->register_one)
> +				break;
>  		}
>  	}
>  
> @@ -1532,6 +1578,9 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
>  		pos[0] = '\0';
>  		if (err)
>  			goto out;
> +
> +		if (entry->register_one)
> +			break;
>  	}
>  	err = 0;
>  out:
> @@ -1686,6 +1735,9 @@ static void put_links(struct ctl_table_header *header)
>  			sysctl_print_dir(parent);
>  			pr_cont("%s\n", name);
>  		}
> +
> +		if (entry->register_one)
> +			break;
>  	}
>  }
>  
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 6353d6db69b2..889c995d8a08 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -134,6 +134,7 @@ struct ctl_table {
>  	void *data;
>  	int maxlen;
>  	umode_t mode;
> +	bool register_one;		/* Exactly register one ctl_table*/
>  	struct ctl_table *child;	/* Deprecated */
>  	proc_handler *proc_handler;	/* Callback for text formatting */
>  	struct ctl_table_poll *poll;

This effort is trying to save space. But now you are adding a new bool
for every single struct ctl_table.... So doesn't the math work out
against us if you do a build size comparison?

Can you just instead add a new helper which deals with one entry?
Perhaps then make the other caller which loops use that? That way
we don't bloat the kernel with an extra bool per ctl_table?

Or can you add a new parameter which specififes the size of the array?

Please provide vmlinux size comparisons before and after on allyesconfig
builds.

  Luis
