Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7272E4C5831
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Feb 2022 21:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiBZU6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Feb 2022 15:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiBZU6R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Feb 2022 15:58:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572BC45062;
        Sat, 26 Feb 2022 12:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KLo/tabVubutfy1mGMWoSKgTckAkWT3y7wjIivTyetY=; b=A8kLm3samn7S1snqeLcd31/QDr
        htS71j2p+Achh5GNVvqC4mVxn5KBxXEo+X7KV7trwMIKoNUCZUu6/uzOE9ryJfPs2+OsC8Zg7b2ma
        2id97rmFDAkNKTfGXfNoOE7t1S4J+7ET9wc9uLzAL82TMB/d6XIRrPOPupeISgvLZa4VCYAURb5ux
        1GGOk6M1H1RbU6D3jp1d/k1CvuKtAzy1cK3SZGAwtm3dHVXXkrpjbzgHg2DeqbrSCMPgoLzGPodZp
        CVVAaOGWBTO3JHARiPgotlv2N34uIIJYOf0yyoXllsdGZ8Ws2LKkDfYtcgPZ3SmL1ewVbyViag9sv
        EKmW0bSQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nO47w-008XO3-0Z; Sat, 26 Feb 2022 20:57:16 +0000
Date:   Sat, 26 Feb 2022 12:57:15 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Meng Tang <tangmeng@uniontech.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     keescook@chromium.org, yzaikin@google.com, guoren@kernel.org,
        nickhu@andestech.com, green.hu@gmail.com, deanbo422@gmail.com,
        ebiggers@kernel.org, tytso@mit.edu, wad@chromium.org,
        john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        linux-csky@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] fs/proc: Optimize arrays defined by struct
 ctl_path
Message-ID: <YhqUK6B1m2tdpOPI@bombadil.infradead.org>
References: <20220224133217.1755-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224133217.1755-1-tangmeng@uniontech.com>
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

Please include Eric and Willy (Willy because he suggested this)
on future iterations.

On Thu, Feb 24, 2022 at 09:32:16PM +0800, Meng Tang wrote:
> Previously, arrays defined by struct ctl_path is terminated

Not previousy, as it is today.

> with an empty one. When we actually only register one ctl_path,
> we've gone from 8 bytes to 16 bytes.

This doesn't real well, can you elaborate that this implies we
are adding an extra 8 bytes by requiring the termination of a
path to be empty? You can even quantify the effect of this by
building a allyesconfig kernel, measuring the size before and
then after your patches to see how many bytes are saved and
reflecting that on your commit log.

Another thing your commit log should mention is that while this
minor optimization might not be so critical before, as we start
moving sysctls out from kernel/sysctl.c to their own files we
are often then also bloating the kernel slightly when doing this.
This work prevents that.

> So, I use ARRAY_SIZE() as a boundary condition to optimize it.
> 
> Since the original __register_sysctl_paths is only used in
> fs/proc/proc_sysctl.c, in order to not change the usage of
> register_sysctl_paths, delete __register_sysctl_paths from
> include/linux/sysctl.h, change it to __register_sysctl_paths_init
> in fs/proc/proc_sysctl.c, and modify it with static.
> The register_sysctl_paths becomes __register_sysctl_paths,
> and the macro definition is used in include/linux/sysctl.h
> to expand register_sysctl_paths(path, table) to
> __register_sysctl_paths(path, ARRAY_SIZE(path), table).


Please split this up into a 2 patches, one which moves
__register_sysctl_paths() to fs/proc/proc_sysctl.c and
make it static. Doing this separately will make the other
work easier to review.

Then your second patch can use do the other stuff.

Add:

Suggested-by: Matthew Wilcox <willy@infradead.org>

> Signed-off-by: Meng Tang <tangmeng@uniontech.com>
> ---
>  fs/proc/proc_sysctl.c  | 22 +++++++++++++---------
>  include/linux/sysctl.h |  9 ++++-----
>  2 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 9ecd5c87e8dd..721a8bec63d6 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -1589,9 +1589,10 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
>  }
>  
>  /**
> - * __register_sysctl_paths - register a sysctl table hierarchy
> + * __register_sysctl_paths_init - register a sysctl table hierarchy
>   * @set: Sysctl tree to register on
>   * @path: The path to the directory the sysctl table is in.
> + * @ctl_path_num: The numbers(ARRAY_SIZE(path)) of ctl_path
>   * @table: the top-level table structure
>   *
>   * Register a sysctl table hierarchy. @table should be a filled in ctl_table
> @@ -1599,22 +1600,23 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
>   *
>   * See __register_sysctl_table for more details.
>   */
> -struct ctl_table_header *__register_sysctl_paths(
> +static struct ctl_table_header *__register_sysctl_paths_init(
>  	struct ctl_table_set *set,
> -	const struct ctl_path *path, struct ctl_table *table)
> +	const struct ctl_path *path, int ctl_path_num, struct ctl_table *table)
>  {
>  	struct ctl_table *ctl_table_arg = table;
>  	int nr_subheaders = count_subheaders(table);
>  	struct ctl_table_header *header = NULL, **subheaders, **subheader;
>  	const struct ctl_path *component;
>  	char *new_path, *pos;
> +	int i;
>  
>  	pos = new_path = kmalloc(PATH_MAX, GFP_KERNEL);
>  	if (!new_path)
>  		return NULL;
>  
>  	pos[0] = '\0';
> -	for (component = path; component->procname; component++) {
> +	for (component = path, i = 0; component->procname && i < ctl_path_num; component++, i++) {

I'd refer if the bounds check is done first, so i < ctl_path_num before
the component->procname check.

>  		pos = append_path(new_path, pos, component->procname);
>  		if (!pos)
>  			goto out;
> @@ -1663,20 +1665,22 @@ struct ctl_table_header *__register_sysctl_paths(
>  /**
>   * register_sysctl_paths - register a sysctl table hierarchy

You are changing the routine name below but not here.

  Luis
