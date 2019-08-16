Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE00D8FCD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 09:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfHPH4z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 03:56:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56350 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfHPH4z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 03:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GEPIsFY3MHoaNhLioxPLyJi2z1sMO/PprZt8vSpbDEQ=; b=AnEO7386lwca0tpCaiid+/awa
        LviN3wlPS91Ux8deRubi2XrAacSo46tqMRzuTjuRGvzOY2pQfhLhLMjFUhRsgzwa7YD5nWGo4tJAz
        LSq0gAWUPkxMZFyE3Kf4MT5lrk5JGeXv+iLdtqqxb4Dg6ufnwKNLCCu+KnVSTDz1laR/ODmqzBIbp
        qFSRC77MebL7+PBYf4Kmk7/ITXY38y6IwSLIRQOH0/XrPj+KnfUHFz3FRN1IO6BWyuI344cmSnIiJ
        pFK/abchm4j5dU7UlFCAo1eoYO3aoFTnmhv42q6wojnFx+bJwBkCjNx1uJJvgpEDGkxKhEdVqKKhL
        eSuTKHsQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hyX6U-0007LH-AT; Fri, 16 Aug 2019 07:56:54 +0000
Date:   Fri, 16 Aug 2019 00:56:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13] fs: Add VirtualBox guest shared folder (vboxsf)
 support
Message-ID: <20190816075654.GA15363@infradead.org>
References: <20190815131253.237921-1-hdegoede@redhat.com>
 <20190815131253.237921-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815131253.237921-2-hdegoede@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A couple minor comments.  Otherwise we should be fine, things aren't
going to get much better for such a messed up protocol design.

> +			return dir_emit(ctx, d_name, strlen(d_name),
> +					fake_ino, d_type);
> +		} else {
> +			return dir_emit(ctx,
> +					info->name.string.utf8,
> +					info->name.length,
> +					fake_ino, d_type);
> +		}
> +	}

Nitpick: no need for an else after a return.

> +static int vboxsf_file_release(struct inode *inode, struct file *file)
> +{
> +	struct vboxsf_inode *sf_i = VBOXSF_I(inode);
> +	struct vboxsf_handle *sf_handle = file->private_data;
> +
> +	filemap_write_and_wait(inode->i_mapping);

Normal Linux semantics don't include writing back data on close, so
if you are doing this to follow other things like NFS CTO semantics
it should have a comment explaining that.

> +
> +	mutex_lock(&sf_i->handle_list_mutex);
> +	list_del(&sf_handle->head);
> +	mutex_unlock(&sf_i->handle_list_mutex);
> +
> +	kref_put(&sf_handle->refcount, vboxsf_handle_release);
> +	file->private_data = NULL;

There is no need to zero ->private_data on release, the file gets
freed and never reused.

> + * Ideally we would wrap generic_file_read_iter with a function which also
> + * does this check, to reduce the chance of us missing writes happening on the
> + * host side after open(). But the vboxsf stat call to the host only works on
> + * filenames, so that would require caching the filename in our
> + * file->private_data and there is no guarantee that filename will still
> + * be valid at read_iter time. So this would be in no way bulletproof.

Well, you can usually generate a file name from file->f_path.dentry.
The only odd case is opened by unliked files.  NFS has a special hack
for those called sillyrename (you can grep for that).  How similar to
normal posix semantics are expected from this fs?

> +
> +	mutex_lock(&sf_i->handle_list_mutex);
> +	list_for_each_entry(h, &sf_i->handle_list, head) {
> +		if (h->access_flags == SHFL_CF_ACCESS_WRITE ||
> +		    h->access_flags == SHFL_CF_ACCESS_READWRITE) {
> +			kref_get(&h->refcount);

Does this need a kref_get_unless_zero to deal with races during list
removal?

