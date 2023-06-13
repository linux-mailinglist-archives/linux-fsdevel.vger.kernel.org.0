Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FFA72DBEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 10:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240910AbjFMICk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 04:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbjFMIC0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:02:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD6110DE;
        Tue, 13 Jun 2023 01:01:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC7A66109A;
        Tue, 13 Jun 2023 08:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD1EC433EF;
        Tue, 13 Jun 2023 08:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686643273;
        bh=v8+tAI1Tiq834oS0lOuXx3xnoqrH6hm5pa17SbvxOzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bR4QkIqzShbQGknqJs8CcDr1aBX8RTtGriTrjlkzVKigdMwFnYXyWuXjKi3ZJmMv9
         PbEcnLsQkygehD6YBVfDpiJAC0itQbnAMLBgRMBB1TdiERQlXx4isNIZvjQMPy9m7f
         GCw5x9/nLwQP9k0g8QO6UK3jrzcDW4xKXaxXCjU8=
Date:   Tue, 13 Jun 2023 10:01:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Avadhut Naik <Avadhut.Naik@amd.com>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, avadnaik@amd.com,
        yazen.ghannam@amd.com, alexey.kardashevskiy@amd.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/3] Add support for Vendor Defined Error Types in
 Einj Module
Message-ID: <2023061341-anything-unlimited-cb62@gregkh>
References: <20230612215139.5132-1-Avadhut.Naik@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612215139.5132-1-Avadhut.Naik@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 09:51:36PM +0000, Avadhut Naik wrote:
> This patchset adds support for Vendor Defined Error types in the einj
> module by exporting a binary blob file in module's debugfs directory.
> Userspace tools can write OEM Defined Structures into the blob file as
> part of injecting Vendor defined errors.
> 
> The first patch refactors available_error_type_show() function to ensure
> all errors supported by the platform are output through einj module's
> available_error_type file in debugfs.
> 
> The second patch adds a write callback for binary blobs created through
> debugfs_create_blob() API.
> 
> The third adds the required support i.e. establishing the memory mapping
> and exporting it through debugfs blob file for Vendor-defined Error types.
> 
> Changes in v2:
>  - Split the v1 patch, as was recommended, to have a separate patch for
> changes in debugfs.
>  - Refactored available_error_type_show() function into a separate patch.
>  - Changed file permissions to octal format to remove checkpatch warnings.
> 
> Changes in v3:
>  - Use BIT macro for generating error masks instead of hex values since
> ACPI spec uses bit numbers.
>  - Handle the corner case of acpi_os_map_iomem() returning NULL through
> a local variable to a store the size of OEM defined data structure.
> 
> Avadhut Naik (3):
>   ACPI: APEI: EINJ: Refactor available_error_type_show()
>   fs: debugfs: Add write functionality to debugfs blobs
>   ACPI: APEI: EINJ: Add support for vendor defined error types
> 
>  drivers/acpi/apei/einj.c | 67 +++++++++++++++++++++++++++-------------
>  fs/debugfs/file.c        | 28 ++++++++++++++---
>  2 files changed, 69 insertions(+), 26 deletions(-)
> 
> -- 
> 2.34.1
> 

Why is a RFC series at v3?  What is left to be done with it to make you
confident that it can be merged?

I almost never review RFC patches as obviously the submitter doesn't
think it is good enough to be reviewed, and hundreds of other patches in
my review queue are from people who think they are ready to be merged,
so this puts your stuff always at the bottom of the list...

When submitting something with "RFC" ask what type of comments you are
looking for and why you do not think this is ready yet, otherwise we
have no idea...

thanks,

greg k-h
