Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46ABF6FF3E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 16:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238025AbjEKOTk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 10:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbjEKOTj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 10:19:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4848D170D
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 07:19:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D936464DAA
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 14:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDC6C433D2;
        Thu, 11 May 2023 14:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683814777;
        bh=gMDqbyelQilrRr1ZuhjNaq/qFVTSG19OVE3VHKbDpgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QZBoVKdNYwQdwHRUHN2CvtNX7/ocqPC27Q5Vs0cZ+AoGJQtVD+DIewNQxIropgiiC
         g1HBwFKBOT5Sz7TDnrs9UlfVWwwe32y1IMsnR6aSTFsg5upVFbDIPYfg0RI0yXkpgZ
         lqbKzHw+ZLZzgXSBIViMgFzeCbtXnET6qn0BoRPjASxKszjgrpVZqTPlo61PqP7rqz
         eNUYW6Ponec9PCzuO7glTXC+BdX92xLJyOij4kxAeIqRMbaufw4rQkXch2OXEdDuEi
         l9HbBXtsNeFAfi/1mCMSvgGNQt5zcQKHNEJMhCn3oK9kgfCw8gjzEtckDf7PCmoMg7
         jIjm9qTvrLfuQ==
Date:   Thu, 11 May 2023 07:19:36 -0700
From:   Seth Forshee <sforshee@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] fs: allow to mount beneath top mount
Message-ID: <ZFz5eI9WoWzMvXS3@do-x1extreme>
References: <20230202-fs-move-mount-replace-v4-0-98f3d80d7eaa@kernel.org>
 <20230202-fs-move-mount-replace-v4-4-98f3d80d7eaa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202-fs-move-mount-replace-v4-4-98f3d80d7eaa@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 03, 2023 at 01:18:42PM +0200, Christian Brauner wrote:
> +/**
> + * do_lock_mount - lock mount and mountpoint
> + * @path:    target path
> + * @beneath: whether the intention is to mount beneath @path
> + *
> + * Follow the mount stack on @path until the top mount @mnt is found. If
> + * the initial @path->{mnt,dentry} is a mountpoint lookup the first
> + * mount stacked on top of it. Then simply follow @{mnt,mnt->mnt_root}
> + * until nothing is stacked on top of it anymore.
> + *
> + * Acquire the inode_lock() on the top mount's ->mnt_root to protect
> + * against concurrent removal of the new mountpoint from another mount
> + * namespace.
> + *
> + * If @beneath is requested, acquire inode_lock() on @mnt's mountpoint
> + * @mp on @mnt->mnt_parent must be acquired. This protects against a

Redundant use of "acquire" here.

