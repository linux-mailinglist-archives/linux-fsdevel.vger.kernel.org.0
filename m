Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAC5512AA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 06:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242734AbiD1Es1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 00:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241924AbiD1EsY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 00:48:24 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFCF674D8;
        Wed, 27 Apr 2022 21:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PKck+ahOM9JYfjxEvY1h8doWdu47MA0NkSVDcynutLE=; b=etijgdrfsUmnOgdRbR9BCXfDkx
        S+h4q9WlUjltQhgk6O7EQeJOAVVKvDnhlta2vXI8f+7GTcZkijOQhrhRD3NGEmXxCad3PHAHtNuyz
        msCVuWH6fLTq2oh16p6CQ71pfB26kDT8aMgdnYJtkGIKZh6Se+frROc2qT26tUyuU44SHgHPgrqRE
        fojw5QHR1mO2rp27+CS7Zj9hg2viCrDd2aclUt0qLM5JVrcJqpHPTSTpiYSUZkn2ffmfTSe/Zl/VS
        HEnIGbL8IVeiaXMivZ2zxKGtoMjKDqJ4IhdrFWdG6ao8T43jj/Iun9mbn+nDYwVqrn9SM3vtg25gh
        /CDdvpSA==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njw1Z-00A80A-Jq; Thu, 28 Apr 2022 04:45:05 +0000
Date:   Thu, 28 Apr 2022 04:45:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Yang Xu <xuyang2018.jy@fujitsu.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        ceph-devel <ceph-devel@vger.kernel.org>
Subject: Re: [PATCH v8 3/4] fs: move S_ISGID stripping into the vfs
Message-ID: <Ymob0U33QNeJEeFs@zeniv-ca.linux.org.uk>
References: <1650971490-4532-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650971490-4532-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220426103846.tzz66f2qxcxykws3@wittgenstein>
 <CAOQ4uxhRMp4tM9nP+0yPHJyzPs6B2vtX6z51tBHWxE6V+UZREw@mail.gmail.com>
 <CAJfpegu5uJiHgHmLcuSJ6+cQfOPB2aOBovHr4W5j_LU+reJsCw@mail.gmail.com>
 <20220426145349.zxmahoq2app2lhip@wittgenstein>
 <20220427092201.wvsdjbnc7b4dttaw@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427092201.wvsdjbnc7b4dttaw@wittgenstein>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 27, 2022 at 11:22:01AM +0200, Christian Brauner wrote:

> +static inline umode_t vfs_prepare_mode(struct user_namespace *mnt_userns,
> +				       const struct inode *dir, umode_t mode,
> +				       umode_t mask_perms, umode_t type)
> +{
> +	/*
> +	 * S_ISGID stripping depends on the mode of the new file so make sure
> +	 * that the caller gives us this information and splat if we miss it.
> +	 */
> +	WARN_ON_ONCE((mode & S_IFMT) == 0);

<blink>

First of all, what happens if you call mknod("/tmp/blah", 0, 0)?  And the only
thing about type bits we care about is "is it a directory" - the sensitive
stuff is in the low 12 bits...  What is that check about?

> +	mode = mode_strip_sgid(mnt_userns, dir, mode);
> +	mode = mode_strip_umask(dir, mode);
> +
> +	/*
> +	 * Apply the vfs mandated allowed permission mask and set the type of
> +	 * file to be created before we call into the filesystem.
> +	 */
> +	mode &= (mask_perms & ~S_IFMT);
> +	mode |= (type & S_IFMT);
> +
> +	return mode;
