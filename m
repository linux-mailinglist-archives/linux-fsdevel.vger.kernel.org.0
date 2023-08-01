Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A464076B8F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 17:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbjHAPqQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 11:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbjHAPqP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:46:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719DC1AA
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 08:46:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 765476732D; Tue,  1 Aug 2023 17:46:08 +0200 (CEST)
Date:   Tue, 1 Aug 2023 17:46:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] fs: add FSCONFIG_CMD_CREATE_EXCL
Message-ID: <20230801154607.GD12035@lst.de>
References: <20230801-vfs-super-exclusive-v1-0-1a587e56c9f3@kernel.org> <20230801-vfs-super-exclusive-v1-3-1a587e56c9f3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801-vfs-super-exclusive-v1-3-1a587e56c9f3@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	/* require the new mount api */
> +	if (exclusive && (fc->ops == &legacy_fs_context_ops))

No need for the inner braces.

> +		return -EOPNOTSUPP;
> +
>  	fc->phase = FS_CONTEXT_CREATING;
> +	fc->exclusive = exclusive;
>  
>  	ret = vfs_get_tree(fc);
> -	if (ret)
> +	if (ret) {
> +		fc->exclusive = false;

What's the point in clearing the flag on error?

> +	case FSCONFIG_CMD_CREATE_EXCL:
> +		fallthrough;
>  	case FSCONFIG_CMD_CREATE:
> -		ret = vfs_cmd_create(fc);
> +		ret = vfs_cmd_create(fc, cmd == FSCONFIG_CMD_CREATE_EXCL);
>  		if (ret)
>  			break;
>  		return 0;

Nitpick, but I always find it cleaner to do something like:

	case FSCONFIG_CMD_CREATE_EXCL:
		ret = vfs_cmd_create(fc, true)
		break;
 	case FSCONFIG_CMD_CREATE:
		ret = vfs_cmd_create(fc, false);

but that might just be preference.

