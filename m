Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6F776B8E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 17:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbjHAPnk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 11:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjHAPnj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:43:39 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C99BA1
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 08:43:38 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4E26A6732D; Tue,  1 Aug 2023 17:43:34 +0200 (CEST)
Date:   Tue, 1 Aug 2023 17:43:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] fs: add vfs_cmd_create()
Message-ID: <20230801154333.GC12035@lst.de>
References: <20230801-vfs-super-exclusive-v1-0-1a587e56c9f3@kernel.org> <20230801-vfs-super-exclusive-v1-2-1a587e56c9f3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801-vfs-super-exclusive-v1-2-1a587e56c9f3@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 03:09:01PM +0200, Christian Brauner wrote:
> Split the steps to create a superblock into a tiny helper. This will
> make the next patch easier to follow.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/fsopen.c | 45 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/fsopen.c b/fs/fsopen.c
> index fc9d2d9fd234..af2ff05dcee5 100644
> --- a/fs/fsopen.c
> +++ b/fs/fsopen.c
> @@ -209,6 +209,36 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags
>  	return ret;
>  }
>  
> +static int vfs_cmd_create(struct fs_context *fc)
> +{
> +	struct super_block *sb;
> +	int ret;
> +
> +	if (fc->phase != FS_CONTEXT_CREATE_PARAMS)
> +		return -EBUSY;
> +
> +	if (!mount_capable(fc))
> +		return -EPERM;
> +
> +	fc->phase = FS_CONTEXT_CREATING;
> +
> +	ret = vfs_get_tree(fc);
> +	if (ret)
> +		return ret;

The error handling here now fails to set FS_CONTEXT_FAILED.

Also at a very minimum I'd also want a helper for the reconfigure
case to mirror this one.  But I think the whole sys_fsconfig and
vfs_fsconfig_locked combination is a complete and utter mess and
should be split into one top-level handler by cmd with a bunch of
shared helper instead of this spaghetti code.

