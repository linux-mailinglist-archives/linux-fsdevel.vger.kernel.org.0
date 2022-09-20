Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1BF5BD989
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 03:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiITBlk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 21:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiITBlB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 21:41:01 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C1953D12
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 18:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9ADs7WKByt/8t6Wd2JAkDoyai7/xQkE8TgWp9LPdyfM=; b=gX7pC+d6LmUBa1/BKDnarzeii+
        Pz/BQWg5d55Sga9KhDl9YYYr3hALghgiXFEyKz94FoFBxf19gEPJza1UyP3OAF68uHpcoY7EpDTam
        Wdso2ro6m7Ps9meYU/6wPutJEuuipoB8aXFzh66hp2fibUncClK/rBmFK1dWqJufmmTxR5qPJsHO8
        K+fFO/uvELZhS3yP5LBgIrYGbgWPTw8+TGBgO0Z02tTXEsLHU0XNYbrXko8Lc9T//mqz4AbbvkeC1
        CIxquljUEk5UdJwVJMFbBRIGn6MpuPFcq4owdTi1vB5meXkNZa0JHRTlVWTtw8NQ8P9UCAGsWBo4C
        h8qHoxYw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oaSFU-001RDa-1a;
        Tue, 20 Sep 2022 01:40:32 +0000
Date:   Tue, 20 Sep 2022 02:40:32 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v2 6/8] vfs: move open right after ->tmpfile()
Message-ID: <YykaEI5BQ9nem3eW@ZenIV>
References: <20220919141031.1834447-1-mszeredi@redhat.com>
 <20220919141031.1834447-7-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919141031.1834447-7-mszeredi@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 19, 2022 at 04:10:29PM +0200, Miklos Szeredi wrote:

> -	child = d_alloc(dentry, &slash_name);
> +	child = d_alloc(parentpath->dentry, &slash_name);
>  	if (unlikely(!child))
>  		goto out_err;
> +	file->f_path.mnt = parentpath->mnt;
> +	file->f_path.dentry = child;
>  	mode = vfs_prepare_mode(mnt_userns, dir, mode, mode, mode);
>  	error = dir->i_op->tmpfile(mnt_userns, dir, child, mode);
> +	error = finish_open_simple(file, error);
> +	dput(child);
> +	if (error)
> +		goto out_err;
> +	error = may_open(mnt_userns, &file->f_path, 0, file->f_flags);
>  	if (error)
>  		goto out_err;
>  	error = -ENOENT;
>  	inode = child->d_inode;
>  	if (unlikely(!inode))
>  		goto out_err;

Ugh...  First of all, goto out_err leading to immediate return error;
is obfuscation for no good reason.  What's more, how the hell can
we get a negative dentry here?  The only thing that makes this check
valid is that after successful open child is pinned as file->f_path.dentry -
otherwise dput() above might have very well freed it.  And if we ever
end up with a negative dentry in file->f_path.dentry of an opened
file, we are really screwed...
