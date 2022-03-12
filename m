Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517524D6C3C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 04:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiCLDZ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 22:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiCLDZz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 22:25:55 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D6C108554;
        Fri, 11 Mar 2022 19:24:50 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSsMc-00A6DH-Dc; Sat, 12 Mar 2022 03:24:18 +0000
Date:   Sat, 12 Mar 2022 03:24:18 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Meng Tang <tangmeng@uniontech.com>
Cc:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        ebiederm@xmission.com, willy@infradead.org, nixiaoming@huawei.com,
        nizhen@uniontech.com, zhanglianjie@uniontech.com,
        sujiaxun@uniontech.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] fs/proc: optimize exactly register one ctl_table
Message-ID: <YiwSYvuAkntr4A/V@zeniv-ca.linux.org.uk>
References: <20220303070847.28684-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303070847.28684-1-tangmeng@uniontech.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 03, 2022 at 03:08:46PM +0800, Meng Tang wrote:

> +#define REGISTER_SINGLE_ONE (register_single_one ? true : false)

????

> +static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header,
> +	bool register_single_one)

> +	err = insert_links(header, REGISTER_SINGLE_ONE);

> +	erase_header(header, REGISTER_SINGLE_ONE);
> +	put_links(header, REGISTER_SINGLE_ONE);


>  static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table *table,
> -	struct ctl_table_root *link_root)
> +	struct ctl_table_root *link_root, bool register_single_one)

> +	init_header(links, dir->header.root, dir->header.set, node, link_table,
> +		    REGISTER_SINGLE_ONE);

> -static int insert_links(struct ctl_table_header *head)
> +static int insert_links(struct ctl_table_header *head, bool register_single_one)
>  {
>  	struct ctl_table_set *root_set = &sysctl_table_root.default_set;
>  	struct ctl_dir *core_parent = NULL;
> @@ -1248,13 +1278,13 @@ static int insert_links(struct ctl_table_header *head)
>  	if (IS_ERR(core_parent))
>  		return 0;
>  
> -	if (get_links(core_parent, head->ctl_table, head->root))
> +	if (get_links(core_parent, head->ctl_table, head->root, REGISTER_SINGLE_ONE))

> -	links = new_links(core_parent, head->ctl_table, head->root);
> +	links = new_links(core_parent, head->ctl_table, head->root, REGISTER_SINGLE_ONE);

> +	if (get_links(core_parent, head->ctl_table, head->root, REGISTER_SINGLE_ONE)) {

> +	err = insert_header(core_parent, links, REGISTER_SINGLE_ONE);

> -struct ctl_table_header *__register_sysctl_table(
> +struct ctl_table_header *__register_sysctl_tables(
>  	struct ctl_table_set *set,
> -	const char *path, struct ctl_table *table)
> +	const char *path, struct ctl_table *table, bool register_single_one)

> +	init_header(header, root, set, node, table, REGISTER_SINGLE_ONE);
> +	if (sysctl_check_table(path, table, REGISTER_SINGLE_ONE))

> +	if (insert_header(dir, header, REGISTER_SINGLE_ONE))

>  static int register_leaf_sysctl_tables(const char *path, char *pos,
>  	struct ctl_table_header ***subheader, struct ctl_table_set *set,
> -	struct ctl_table *table)
> +	struct ctl_table *table, bool register_single_one)

> +		header = __register_sysctl_tables(set, path, files, REGISTER_SINGLE_ONE);


Could you explain what is that REGISTER_SINGLE_ONE macro for?  Looks like
some very odd kind of cargo-culting...  I might be missing something subtle
here, but I'm honestly at loss as to what could that possibly be.  If nothing
else, why would one ever want boolean_expression ? true : false instead of
boolean_expression?  Especially since in all cases you are passing that
as a bool argument...
