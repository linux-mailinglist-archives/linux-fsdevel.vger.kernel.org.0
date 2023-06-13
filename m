Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA93972DF3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 12:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241202AbjFMKXB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 06:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241682AbjFMKWk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:22:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F1E1FCB;
        Tue, 13 Jun 2023 03:22:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3DC060CA5;
        Tue, 13 Jun 2023 10:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DC1C433D2;
        Tue, 13 Jun 2023 10:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686651728;
        bh=pelskQAIf0QXMoPlaEmAMxMPm+r2Wg28oItNo0pusac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tnk4gb9cVZdUkGo5tfNoNWA8VBC1XjEm8bEKOCHKqLCcYJcPFv4xIMCmOYVLG9g5B
         wU+GjLmg1cmwxV9e4fhSUnvGc2q47IVvIJi8pRIY1bevbSGv416t6T/qektEu0MkWF
         9fmqou012AsozmmXKE43gdV9yV182l4gyyJkUxZQ=
Date:   Tue, 13 Jun 2023 12:22:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexey Kardashevskiy <aik@amd.com>
Cc:     Avadhut Naik <Avadhut.Naik@amd.com>, rafael@kernel.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, avadnaik@amd.com,
        yazen.ghannam@amd.com, alexey.kardashevskiy@amd.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/3] fs: debugfs: Add write functionality to
 debugfs blobs
Message-ID: <2023061329-splinter-rundown-a61a@gregkh>
References: <20230612215139.5132-1-Avadhut.Naik@amd.com>
 <20230612215139.5132-3-Avadhut.Naik@amd.com>
 <2023061334-surplus-eclair-197a@gregkh>
 <1d55a83a-b36a-4319-16bc-c1aa72e361b5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d55a83a-b36a-4319-16bc-c1aa72e361b5@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 08:05:41PM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 13/6/23 17:59, Greg KH wrote:
> > On Mon, Jun 12, 2023 at 09:51:38PM +0000, Avadhut Naik wrote:
> > >   /**
> > > - * debugfs_create_blob - create a debugfs file that is used to read a binary blob
> > > + * debugfs_create_blob - create a debugfs file that is used to read and write
> > > + * a binary blob
> > >    * @name: a pointer to a string containing the name of the file to create.
> > > - * @mode: the read permission that the file should have (other permissions are
> > > - *	  masked out)
> > > + * @mode: the permission that the file should have
> > >    * @parent: a pointer to the parent dentry for this file.  This should be a
> > >    *          directory dentry if set.  If this parameter is %NULL, then the
> > >    *          file will be created in the root of the debugfs filesystem.
> > > @@ -992,7 +1010,7 @@ static const struct file_operations fops_blob = {
> > >    *
> > >    * This function creates a file in debugfs with the given name that exports
> > >    * @blob->data as a binary blob. If the @mode variable is so set it can be
> > > - * read from. Writing is not supported.
> > > + * read from and written to.
> > >    *
> > >    * This function will return a pointer to a dentry if it succeeds.  This
> > >    * pointer must be passed to the debugfs_remove() function when the file is
> > > @@ -1007,7 +1025,7 @@ struct dentry *debugfs_create_blob(const char *name, umode_t mode,
> > >   				   struct dentry *parent,
> > >   				   struct debugfs_blob_wrapper *blob)
> > >   {
> > > -	return debugfs_create_file_unsafe(name, mode & 0444, parent, blob, &fops_blob);
> > > +	return debugfs_create_file_unsafe(name, mode, parent, blob, &fops_blob);
> > 
> > Have you audited all calls to this function to verify that you haven't
> > just turned on write access to some debugfs files?
> 
> I just did, it is one of S_IRUGO/S_IRUSR/0444/0400/(S_IFREG | 0444). So we
> are quite safe here. Except (S_IFREG | 0444) in
> drivers/platform/chrome/cros_ec_debugfs.c which seems wrong as debugfs files
> are not regular files.
> 
> > Why not rename this to debugfs_create_blob_wo() and then make a new
> > debugfs_create_blob_rw() call to ensure that it all is ok?
> 
> It is already taking the mode for this purpose. imho just
> cros_ec_create_panicinfo()'s debugfs_create_blob("panicinfo", S_IFREG |
> 0444,...) needs fixing.

Yes, well it's taking the mode, but silently modifying it :)

Ok, thanks for the audit, respin this with that fix and then I don't
have a problem with it (other than binary debugfs files fill me with
dread, what could go wrong...)

thanks,

greg k-h
