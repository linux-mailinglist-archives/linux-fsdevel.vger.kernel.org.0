Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7EE730E1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 06:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbjFOE1B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 00:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjFOE07 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 00:26:59 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2140198D;
        Wed, 14 Jun 2023 21:26:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 51F4467373; Thu, 15 Jun 2023 06:26:55 +0200 (CEST)
Date:   Thu, 15 Jun 2023 06:26:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH] fs: use helpers for opening kernel internal files
Message-ID: <20230615042655.GB4508@lst.de>
References: <20230614120917.2037482-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614120917.2037482-1-amir73il@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 03:09:17PM +0300, Amir Goldstein wrote:
> Overlayfs and cachefiles use vfs_open_tmpfile() to open a tmpfile
> without accounting for nr_files.
> 
> Rename this helper to kernel_tmpfile_open() to better reflect this
> helper is used for kernel internal users.
> 
> cachefiles uses open_with_fake_path() without the need for a fake path
> only to use the noaccount feature of open_with_fake_path().
> 
> Fork open_with_fake_path() to kernel_file_open() which only does the
> noaccount feature and use it in cachefiles.

Please split this into two patches, one for the
vfs_tmpfile_open rename, and one for the kernel_file_open helper.

> +EXPORT_SYMBOL(kernel_file_open);

EXPORT_SYMBOL_GPL, please.
