Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F76740D6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 11:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjF1Jro (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 05:47:44 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:50020 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjF1J16 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:27:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C915F612A8
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 09:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39153C433C8;
        Wed, 28 Jun 2023 09:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687944477;
        bh=rwnsv21g32JXiXNswsAfY6WiuF/kxcFFNhiJt6w5NV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W8QPF17cVXIk64x3bFK8BmFHVEYVWAecEqhFNLbAia3vKgHQUEDMb5ABR/fGFm5Qz
         My6q2IpyBrChae1t1XVnspNmB24sf0niTXaRsfGhzLcztg4yi+EQaROL4weaKeEBou
         eOus+K1H7qtzIDx5FOCnXzZjvoS6PyBbcSOm8V2F03/fmgF8PV5yph3J0wMFJbTnUC
         h29mO76+sMiqjPBVeHzBsy8OIQtYDjh8TzeGY3TkQZYUW9s+G0Ph38nBU4eeqx8V80
         ttTiZYgqI+5qtSHPIaYUxgjbqzaaFE585DJQw3MCwhgKj5Bd6FMf/Ox6WF23SBAdSp
         WerYGy47T4z1g==
Date:   Wed, 28 Jun 2023 11:27:52 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Chuck Lever <cel@kernel.org>
Cc:     viro@zeniv.linux.org.uk, hughd@google.com,
        akpm@linux-foundation.org, Chuck Lever <chuck.lever@oracle.com>,
        jlayton@redhat.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] libfs: Add directory operations for stable offsets
Message-ID: <20230628-geldentwertung-weggehen-97e784bde4f4@brauner>
References: <168789864000.157531.11122232592994999253.stgit@manet.1015granger.net>
 <168789918896.157531.14644838088821804546.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <168789918896.157531.14644838088821804546.stgit@manet.1015granger.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 04:53:09PM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Create a vector of directory operations in fs/libfs.c that handles
> directory seeks and readdir via stable offsets instead of the
> current cursor-based mechanism.
> 
> For the moment these are unused.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---

Could we just drop the "stable_" prefix and just have:

// internal helpers
offset_dir_emit()
offset_get()
offset_set()
offset_dir_llseek()
find_next_offset()
I'd also collapse offset_iterate_dir() into offset_readdir().

// exported and published helpers
simple_offset_init()
simple_offset_add()
simple_offset_rename_exchange()
simple_offset_destroy()

struct offset_ctx *(*get_offset)(struct inode *inode);

const struct file_operations simple_offset_dir_operations;

>  fs/libfs.c         |  252 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |   19 ++++
>  2 files changed, 271 insertions(+)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 89cf614a3271..9940dce049e6 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -239,6 +239,258 @@ const struct inode_operations simple_dir_inode_operations = {
>  };
>  EXPORT_SYMBOL(simple_dir_inode_operations);
>  
> +static struct stable_offset_ctx *stable_ctx_get(struct inode *inode)
> +{
> +	return inode->i_op->get_so_ctx(inode);
> +}

I would suggest to get rid of this helper. It just needlessly hides that
all we do is inode->i_op->().
