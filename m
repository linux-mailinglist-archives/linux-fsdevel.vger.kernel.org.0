Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C7972DBE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 10:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240920AbjFMIAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 04:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240924AbjFMIAV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:00:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A5D270E;
        Tue, 13 Jun 2023 00:59:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D6EF6325C;
        Tue, 13 Jun 2023 07:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634F6C433EF;
        Tue, 13 Jun 2023 07:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686643177;
        bh=q5quCZvUQGmqD8Ns5weWChZ5I+yTQoplfjbTAIFRrCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ws9TG3LoZc/UvWWoUbv6usy39ghWuR9Jd+eiYmnoKj0ppee0hmo526Bp9GVT6FP0L
         aUVKcWkq/5YJ9hRflhG0pbaTdwnQYjINY7789y/dQSIsc/CnGgQTZ4eGQG14259+HZ
         XrJh7/8XHX1kKlI3H7rPx1NtgD3yoIv4xSSwWw30=
Date:   Tue, 13 Jun 2023 09:59:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Avadhut Naik <Avadhut.Naik@amd.com>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, avadnaik@amd.com,
        yazen.ghannam@amd.com, alexey.kardashevskiy@amd.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/3] fs: debugfs: Add write functionality to
 debugfs blobs
Message-ID: <2023061334-surplus-eclair-197a@gregkh>
References: <20230612215139.5132-1-Avadhut.Naik@amd.com>
 <20230612215139.5132-3-Avadhut.Naik@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612215139.5132-3-Avadhut.Naik@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 09:51:38PM +0000, Avadhut Naik wrote:
>  /**
> - * debugfs_create_blob - create a debugfs file that is used to read a binary blob
> + * debugfs_create_blob - create a debugfs file that is used to read and write
> + * a binary blob
>   * @name: a pointer to a string containing the name of the file to create.
> - * @mode: the read permission that the file should have (other permissions are
> - *	  masked out)
> + * @mode: the permission that the file should have
>   * @parent: a pointer to the parent dentry for this file.  This should be a
>   *          directory dentry if set.  If this parameter is %NULL, then the
>   *          file will be created in the root of the debugfs filesystem.
> @@ -992,7 +1010,7 @@ static const struct file_operations fops_blob = {
>   *
>   * This function creates a file in debugfs with the given name that exports
>   * @blob->data as a binary blob. If the @mode variable is so set it can be
> - * read from. Writing is not supported.
> + * read from and written to.
>   *
>   * This function will return a pointer to a dentry if it succeeds.  This
>   * pointer must be passed to the debugfs_remove() function when the file is
> @@ -1007,7 +1025,7 @@ struct dentry *debugfs_create_blob(const char *name, umode_t mode,
>  				   struct dentry *parent,
>  				   struct debugfs_blob_wrapper *blob)
>  {
> -	return debugfs_create_file_unsafe(name, mode & 0444, parent, blob, &fops_blob);
> +	return debugfs_create_file_unsafe(name, mode, parent, blob, &fops_blob);

Have you audited all calls to this function to verify that you haven't
just turned on write access to some debugfs files?

Why not rename this to debugfs_create_blob_wo() and then make a new
debugfs_create_blob_rw() call to ensure that it all is ok?

thanks,

greg k-h
