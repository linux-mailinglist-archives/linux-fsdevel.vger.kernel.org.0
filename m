Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F24172B6A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 06:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbjFLEha (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 00:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjFLEg6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 00:36:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2DE10FC;
        Sun, 11 Jun 2023 21:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=taNZd+wknRm8sNoxbdnQwzLPV0YoYQAxXF14nZfT6iQ=; b=Nw4G6ra/U58UNAQY8QGT1FKgKn
        ZMLIQoK7hQOqV6wDirZebuFovQxDtyqrIsPKSZ1BVxe+iAUz875wMYiJ5xmF8DNX/PmIzO1XOSQh2
        v8lBQk4rgkc5/SfyQGEjDvA0D0T3hW32mOz0kIgUphkyk0n1R+Z4F1AWWleneBt+YCmbIp6CfKrnh
        TCeGI84VoPz6Oe5Mibh4HrjDJdHcgrolPLbDpXeHwL91fR+DJly2nGTM+5xlciksLjdWHUGpzLn7F
        udxluUpadnqqlB3KAbq2vfMic93JM/07eVGzj/lcnf8uEUIuPd5VkhJ+aqaLzAIY37zyYWNxkUwp6
        RQqr48dA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8ZHz-002XyQ-34;
        Mon, 12 Jun 2023 04:36:23 +0000
Date:   Sun, 11 Jun 2023 21:36:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 2/3] fs: introduce f_real_path() helper
Message-ID: <ZIagx5ObeBDeXmni@infradead.org>
References: <20230611132732.1502040-1-amir73il@gmail.com>
 <20230611132732.1502040-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230611132732.1502040-3-amir73il@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 11, 2023 at 04:27:31PM +0300, Amir Goldstein wrote:
> Overlayfs knows the real path of underlying dentries.  Add an optional
> struct vfsmount out argument to ->d_real(), so callers could compose the
> real path.
> 
> Add a helper f_real_path() that uses this new interface to return the
> real path of f_inode, for overlayfs internal files whose f_path if a
> "fake" overlayfs path and f_inode is the underlying real inode.

I really don't like this ->d_real nagic.  Most callers of it
really can't ever be on overlayfs.  So I'd suggest we do an audit
of the callers of file_dentry and drop all the pointless ones
first, and improve the documentation on when to use it.
