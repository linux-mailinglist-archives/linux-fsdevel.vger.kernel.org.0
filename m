Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF856B2818
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 16:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjCIPCo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 10:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjCIPCD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:02:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858F1ED6AF;
        Thu,  9 Mar 2023 06:58:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A881DB81BF6;
        Thu,  9 Mar 2023 14:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AD1C4339B;
        Thu,  9 Mar 2023 14:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678373926;
        bh=Fy0PF86k2flygl/jQKs8YcT3wCcxTvDaDOd0+8NdcO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GkWzvRMehyETFrkEcTAfT0uE2WbV9L213ExoUmXZQQ91gdUEpJ3gg/nYrV07IyA65
         VKEcUkToUjEJs3VEaeMQAlAqLpecmigMbaBrAYwuUNoDxcKPyiuLuTnLck40w2C+fk
         ij1/NUAXURRALcEOmYjejuxgLeV6yM0JAKZY7fcFsqU1f2n5XXr7QLQmN2GeGVq7pI
         gpgdYGj5csLnBzSr85iWtWqt93nxtnPS2X9qxekurHfW7D1vVi6IkPOfG/oD+1JNt+
         vJ/iIqn0PbsgN5WA+HE3caFzXrp7joz+12zp8dh/ZvZF/PgWyBZkmA+Fs7XwUIQ5Z+
         cr7IRPS+GC0sg==
Date:   Thu, 9 Mar 2023 15:58:38 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        viro@zeniv.linux.org.uk, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] fs: add i_blockmask()
Message-ID: <20230309145838.pgkkkhp4ahvqdkv5@wittgenstein>
References: <20230309124035.15820-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230309124035.15820-1-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 09, 2023 at 08:40:31PM +0800, Yangtao Li wrote:
> Introduce i_blockmask() to simplify code, which replace
> (i_blocksize(node) - 1). Like done in commit
> 93407472a21b("fs: add i_blocksize()").
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---

Looks good but did you forget to convert fs/remap_range.c by any chance?

static int generic_remap_check_len(struct inode *inode_in,
                                   struct inode *inode_out,
                                   loff_t pos_out,
                                   loff_t *len,
                                   unsigned int remap_flags)
{
        u64 blkmask = i_blocksize(inode_in) - 1;
