Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C0C5BD96B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 03:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiITBdS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 21:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiITBdR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 21:33:17 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF7D520B8
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 18:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2DV7jDS18yJXQET/q5wqOjDqJ8GrZxF5kDVdZc9a4UA=; b=VUM5n3DgzC0BlrdjM6dg8i6IeK
        TthKATX6uaMVp5k7xCRLTwCelRzHbT1ddW7LLGWDebOjE+Ccyn9ecur/Y83xze8fX1MMEtsPgZkBC
        NetAYIpFgVVOAh5HvYQxj3XmFhYXBkDYH50xCVO+ESN2IJVDxN7iGlSKfDwEV8A//VQcgMyaYFHcT
        Q3F+OTvwPZNjzi45Z9FWbxfGMmlzZkFNO6TM/ZEVOW2LAgIfmKt4+3zbdm8TZZ309fZ8Hzf78jsuk
        N3Kr4sb6go5SMY0iyvabGpbirmSJ140K9f2ZNCg2OI/h0UP9h47+P98YsUb81gAW0yToGf9mATjap
        eXjG7DOQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oaS8P-001R5o-2o;
        Tue, 20 Sep 2022 01:33:13 +0000
Date:   Tue, 20 Sep 2022 02:33:13 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v2 4/8] ovl: use tmpfile_open() helper
Message-ID: <YykYWVpNvNm8BzWv@ZenIV>
References: <20220919141031.1834447-1-mszeredi@redhat.com>
 <20220919141031.1834447-5-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919141031.1834447-5-mszeredi@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,URIBL_ABUSE_SURBL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 19, 2022 at 04:10:27PM +0200, Miklos Szeredi wrote:
> If tmpfile is used for copy up, then use this helper to create the tmpfile
> and open it at the same time.  This will later allow filesystems such as
> fuse to do this operation atomically.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/overlayfs/copy_up.c   | 49 ++++++++++++++++++++++------------------
>  fs/overlayfs/overlayfs.h | 12 ++++++----
>  fs/overlayfs/super.c     | 10 ++++----
>  3 files changed, 40 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index fdde6c56cc3d..ac087b48b5da 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -194,16 +194,16 @@ static int ovl_copy_fileattr(struct inode *inode, struct path *old,
>  }
>  
>  static int ovl_copy_up_data(struct ovl_fs *ofs, struct path *old,
> -			    struct path *new, loff_t len)
> +			    struct path *new, struct file *new_file, loff_t len)
>  {

Ugh...  Lift opening into both callers and get rid of struct path *new,
please.  Would be much easier to follow that way...

> -	err = ovl_copy_up_inode(c, temp);
> +	err = ovl_copy_up_inode(c, temp, NULL);

FWIW, I would consider passing a struct file * in all cases, with O_PATH
for non-regular ones...

> -	temp = ovl_do_tmpfile(ofs, ofs->workdir, S_IFREG | 0);
> -	ofs->tmpfile = !IS_ERR(temp);
> +	tmpfile = ovl_do_tmpfile(ofs, ofs->workdir, S_IFREG | 0);
> +	ofs->tmpfile = !IS_ERR(tmpfile);
>  	if (ofs->tmpfile)
> -		dput(temp);
> +		fput(tmpfile);

	Careful - that part essentially checks if we have a working
->tmpfile(), but we rely upon more than just having it - we want
dentry-based setxattr() and friends to work after O_TMPFILE.
Are we making that a requirement for ->tmpfile()?  I.e. that
after O_TMPFILE open notify_change() et.al. on its dentry
will work *without* corresponding struct file.  In particular,
fuse seems to check for ATTR_FILE...
