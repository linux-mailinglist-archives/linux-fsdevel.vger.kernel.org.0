Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81055E684E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 18:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiIVQWj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 12:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiIVQWh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:22:37 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F04E21D0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 09:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MkAsVTMPcRcdN6qrEBs5M3wD7pXb/PYAELyqhBUcHS0=; b=UtczgxZEA7oNGRftlHlQuNmj9y
        yGFKp4xbfojkKYdNd3VHqzY+AVPWFBJlDM650k9OlFAjpsCQGRgg3FIuxXGBX27+JSEotkActaRQD
        2XwgYMmzovAJjGflzoi7ViHQJG/yiIqDmysu0C0s/s0lrV71M7I3W2pXQAZ3+ixOzY/ZNmnkOvRWW
        OeaNOfjgLfvHiF3k/LDhA+aTMuJlXSIZbEtYrxCmEgBCS3HfOzoGef86CMtOnxj1cuIQWUmfXlkRH
        yN1pbYATWwWomMgLKh0o0iu3q2izrLaRFl0xHHeO0j7D3arm1TIY7hTJJFtQmoPA/TrxWuirrrDdK
        xNbxaUnQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1obOy9-002SrT-0v;
        Thu, 22 Sep 2022 16:22:33 +0000
Date:   Thu, 22 Sep 2022 17:22:33 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v4 04/10] cachefiles: only pass inode to
 *mark_inode_inuse() helpers
Message-ID: <YyyLyY3TUG6IaU3Y@ZenIV>
References: <20220922084442.2401223-1-mszeredi@redhat.com>
 <20220922084442.2401223-5-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922084442.2401223-5-mszeredi@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 10:44:36AM +0200, Miklos Szeredi wrote:
> @@ -78,7 +70,7 @@ void cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
>  	struct inode *inode = file_inode(file);
	              ^^^^^^^^^^^^^^^^^^^^^^^^
>  
>  	if (inode) {
	    ^^^^^
> -		cachefiles_do_unmark_inode_in_use(object, file->f_path.dentry);
> +		cachefiles_do_unmark_inode_in_use(object, file_inode(file));
		                                          ^^^^^^^^^^^^^^^^
>  
>  		if (!test_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags)) {
>  			atomic_long_add(inode->i_blocks, &cache->b_released);

> @@ -225,7 +220,7 @@ void cachefiles_put_directory(struct dentry *dir)

>  		inode_lock(dir->d_inode);
> -		__cachefiles_unmark_inode_in_use(NULL, dir);
> +		__cachefiles_unmark_inode_in_use(NULL, d_inode(dir));
>  		inode_unlock(dir->d_inode);

Sequence seems identical to cachefiles_do_unmark_inode_in_use(NULL, dir->d_inode)...

Incidentally, this

void cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
                                    struct file *file)
{
        struct cachefiles_cache *cache = object->volume->cache;
        struct inode *inode = file_inode(file);

        if (inode) {

is, er, excessively defensive prog^W^W^Wobfuscation for no reason -
file_inode(file) is never NULL for any opened file.  While we are
at it, one of the callers of that puppy also looks interesting:

        cachefiles_unmark_inode_in_use(object, object->file);
        if (object->file) {
                fput(object->file);
                object->file = NULL;
        }

file_inode(NULL) is not NULL, it's an oops...  Fortunately, the
only caller of that one is
        if (object->file) {
                cachefiles_begin_secure(cache, &saved_cred);
                cachefiles_clean_up_object(object, cache);

I would rather leave unobfuscating that to a separate patch,
if not a separate series, but since you are touching
cachefiles_unmark_inode_in_use() anyway, might as well
get rid of if (inode) in there - it's equivalent to if (true).
