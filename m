Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46FB5306A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 01:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbiEVXEu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 19:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiEVXEt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 19:04:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F02724588;
        Sun, 22 May 2022 16:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8NenhAfYIMRmvTFmjGJtXIi8zEG3PIr7S+ROeDiY8Zw=; b=EHRCIlG9uIsnmzJjCasjyT1TGQ
        366OoMh/4UUIiKf0OCJq65pZmJNHH7Uyv8cj+fwNOfmJWBPHkoLfcM27Yw4RYIxcm1mIAqncfa1hl
        +iLB0/F+9Y4KsZMZ/Oc+CJa7znjapRnJnrZgeyywx26vK6kZBF4zDUpYEWWc9Gq9z9dE2av/a07/2
        7eDdu5wUOAstdtTKPKIU3n+jt37mBPc4eq+h/EAytcRp7X/1Xkko8p+3pNBFVXZ95x0d6HOO8vP68
        K00E3haO6DD/82A0PpoBs9j4iHHEd52FcNsbYx/tZPOQR1d90k9YgPtVdtnr5ixykWq9p/UJ2XVJL
        WOrwVp9g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsuct-00FfAN-3p; Sun, 22 May 2022 23:04:43 +0000
Date:   Mon, 23 May 2022 00:04:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Christoph Hellwig <hch@infradead.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fs/proc/base.c: fix incorrect fmode_t casts
Message-ID: <YorBiz6QA0JBVta/@casper.infradead.org>
References: <31a6874c-1cb8-e081-f1ca-ef1a81f9dda0@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31a6874c-1cb8-e081-f1ca-ef1a81f9dda0@openvz.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 22, 2022 at 03:08:42PM +0300, Vasily Averin wrote:
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index c1031843cc6a..4e4edf9db5f0 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2237,13 +2237,13 @@ static struct dentry *
>  proc_map_files_instantiate(struct dentry *dentry,
>  			   struct task_struct *task, const void *ptr)
>  {
> -	fmode_t mode = (fmode_t)(unsigned long)ptr;
> +	const fmode_t *mode = ptr;

Why not ...

	fmode_t mode = *(fmode_t *)ptr;

and then you don't need

> -				    ((mode & FMODE_READ ) ? S_IRUSR : 0) |
> -				    ((mode & FMODE_WRITE) ? S_IWUSR : 0));
> +				    ((*mode & FMODE_READ ) ? S_IRUSR : 0) |
> +				    ((*mode & FMODE_WRITE) ? S_IWUSR : 0));
