Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565F872B6B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 06:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbjFLEqO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 00:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbjFLEpt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 00:45:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC49CE3;
        Sun, 11 Jun 2023 21:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MRQfyaryecE5DjoaDy2pXUSA4KRcvXkmj5TgNNEuQww=; b=Otg83G+5lvSCFg+IOdnV06pNnV
        6/iT9OTZWdYhyqz1E+jcFI6HmsG+K7YIZYV5EJSoi+MCnsTzQQfGAq974llBvqcXNwM/UCS5QKKt6
        f6s8Mob0EPyrCU0tnQcj4d4JwogKfVlHwbs7VI4iWut2OFVu18rA4CQFYa8UWsKZ/lXpwSRbjc7hp
        yObeFxRaltAe4i5AmvDRnxtkGZKnfHTrn3wgh5LaMHTdHkRAZMq7S/PWwZ2NOIUhuDEF3z90k0xka
        cdRfPMGKy4tgxzJ0FOYOfx4Wa5woBu8FoaHUCcXuarau8xscspE6W0Euqgc8y+BQtdH/SQ04mSmHN
        6u0tgQ1A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8ZR3-002ZEu-37;
        Mon, 12 Jun 2023 04:45:45 +0000
Date:   Sun, 11 Jun 2023 21:45:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v3 1/2] fs: use fake_file container for internal files
 with fake f_path
Message-ID: <ZIai+UWrU9o2UVcJ@infradead.org>
References: <20230611194706.1583818-1-amir73il@gmail.com>
 <20230611194706.1583818-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230611194706.1583818-2-amir73il@gmail.com>
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

On Sun, Jun 11, 2023 at 10:47:05PM +0300, Amir Goldstein wrote:
> Overlayfs and cachefiles use open_with_fake_path() to allocate internal
> files, where overlayfs also puts a "fake" path in f_path - a path which
> is not on the same fs as f_inode.

But cachefs doesn't, so this needs a better explanation / documentation.

> Allocate a container struct file_fake for those internal files, that
> is used to hold the fake path along with an optional real path.

The idea looks sensible, but fake a is a really weird term here.
I know open_with_fake_path also uses it, but we really need to
come up with a better name, and also good documentation of the
concept here.

> +/* Returns the real_path field that could be empty */
> +struct path *__f_real_path(struct file *f)
> +{
> +	struct file_fake *ff = file_fake(f);
> +
> +	if (f->f_mode & FMODE_FAKE_PATH)
> +		return &ff->real_path;
> +	else
> +		return &f->f_path;
> +}

two of the three callers always have FMODE_FAKE_PATH set, so please
just drop this helper and open code it in the three callers.

> +
> +/* Returns the real_path if not empty or f_path */
> +const struct path *f_real_path(struct file *f)
> +{
> +	const struct path *path = __f_real_path(f);
> +
> +	return path->dentry ? path : &f->f_path;
> +}
> +EXPORT_SYMBOL(f_real_path);

This is only needed by the few places like nfsd or btrfs send
that directlycall fsnotify and should at very least be
EXPORT_SYMBOL_GPL.  But I suspect with all the exta code, fsnotify_file
really should move out of line and have an EXORT_SYMBOL_GPL instead.

> +
> +const struct path *f_fake_path(struct file *f)
> +{
> +	return &f->f_path;
> +}
> +EXPORT_SYMBOL(f_fake_path);

.. and this helper is completely pointless.

> +extern struct file *alloc_empty_file(int flags, const struct cred *cred);
> +extern struct file *alloc_empty_file_fake(int flags, const struct cred *cred);
> +extern struct path *__f_real_path(struct file *f);

Please drop all the pointless externs while you're at it.
