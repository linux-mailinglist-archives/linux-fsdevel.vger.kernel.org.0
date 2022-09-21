Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AEA5BF923
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 10:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiIUI1H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 04:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiIUI0j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:26:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9FE7B7BF
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 01:26:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5A56626F2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 08:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B877C433C1;
        Wed, 21 Sep 2022 08:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663748778;
        bh=MbYznOHaflfi2Yxlw/LH7MPbUv63RjoI7eMJ3wYH0FM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s41uyK83rdfgA7Z6gsboNZiOPNu1QidpJCJWcGqmicez9Da5MMe7zwprEEX3cUhzo
         XE1KoXqTEVs2rkVZmHArGC4kw52j2qBGOoDwXpJ0OZREWGo+H2hhRqQqpGHLMkbrKO
         8Pg1MhOoy61iGEbBP8AnXMvJcVhUbUDvngd1BqDjd1MSc1qKzPfKorq243ICu8PQg3
         QZdUSsmqgsoEkDUcyAqqA82grxE4V/IahqfyBWvzoYlTQU+EnY3lulBzzBsT1NySqU
         ciuuugTetIeVusKU3EW5wlOKTPw3s5ieLOy1Qcr/PswiGOlyT2HwU/aBJHUUAyzGkN
         wSmY5V0JUIRJg==
Date:   Wed, 21 Sep 2022 10:26:12 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v3 4/9] cachefiles: use tmpfile_open() helper
Message-ID: <20220921082612.n5z43657f6t3z37s@wittgenstein>
References: <20220920193632.2215598-1-mszeredi@redhat.com>
 <20220920193632.2215598-5-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920193632.2215598-5-mszeredi@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 20, 2022 at 09:36:27PM +0200, Miklos Szeredi wrote:
> Use the tmpfile_open() helper instead of doing tmpfile creation and opening
> separately.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/cachefiles/namei.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index d3a5884fe5c9..44f575328af4 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -451,18 +451,19 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
>  	const struct cred *saved_cred;
>  	struct dentry *fan = volume->fanout[(u8)object->cookie->key_hash];
>  	struct file *file;
> -	struct path path;
> +	struct path path = { .mnt = cache->mnt, .dentry = fan };
>  	uint64_t ni_size;
>  	long ret;

Maybe we shouldn't use struct path to first refer to the parent path and
then to the tmp path to avoid any potential confusion and instead rely
on a compount initializer for the tmpfile_open() call (__not tested__)?:

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 44f575328af4..979b2f173ac3 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -451,7 +451,7 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
        const struct cred *saved_cred;
        struct dentry *fan = volume->fanout[(u8)object->cookie->key_hash];
        struct file *file;
-       struct path path = { .mnt = cache->mnt, .dentry = fan };
+       struct path path;
        uint64_t ni_size;
        long ret;

@@ -460,8 +460,10 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)

        ret = cachefiles_inject_write_error();
        if (ret == 0) {
-               file = tmpfile_open(&init_user_ns, &path, S_IFREG,
-                                   O_RDWR | O_LARGEFILE | O_DIRECT,
+               file = tmpfile_open(&init_user_ns,
+                                   &{const struct path} {.mnt = cache->mnt,
+                                                         .dentry = fan},
+                                   S_IFREG, O_RDWR | O_LARGEFILE | O_DIRECT,
                                    cache->cache_cred);
                ret = PTR_ERR_OR_ZERO(file);
        }
@@ -472,7 +474,9 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
                        cachefiles_io_error_obj(object, "Failed to create tmpfile");
                goto err;
        }
-       /* From now path refers to the tmpfile */
+
+       /* prepare tmp path */
+       path.mnt = cache->mnt;
        path.dentry = file->f_path.dentry;

        trace_cachefiles_tmpfile(object, d_backing_inode(path.dentry));
