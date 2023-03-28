Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D088F6CB966
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 10:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjC1IaP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 04:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjC1IaM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:30:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9A03C34;
        Tue, 28 Mar 2023 01:30:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2788F6155E;
        Tue, 28 Mar 2023 08:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934D6C433EF;
        Tue, 28 Mar 2023 08:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679992207;
        bh=57O8SXNkoQuVQhQlA6YOIdV+n7nmtB7ImkM0TollDxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UH0Bpsdj7JJwhRJgS8Cizn5aCDGc3hjM1vT2wXHx2MtYLBADvs9H2TXvkp0QYcV8j
         jnVWh/MGBZQr8YKuIS0lqbasqkeI8FfVdgFAeGVPCRVFYfZhWXd9peNt0x6flQfTpD
         uvT/qMLOGo3yAIZk581lp8CImiMbvVHndk357O8OsuTr+l4PbBAgdPRtsiHYkEfomX
         aJ3vSvHaELl+PGSOmHlJhTGzKyNKleK0ve0gCWM42Ga8KSzgAY2WPr4yiHx7xcj5Ji
         /c01c0NEhe9N3M5LLEC/Gg1jXnLllIR6uA2Z6wqsB4zJDElJu+jIEVAWHtMbDvp9Y/
         uewV1EiFcSC7w==
Date:   Tue, 28 Mar 2023 10:30:02 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] nfs: use vfs setgid helper
Message-ID: <20230328083002.5yn5ggpqpe7caeuz@wittgenstein>
References: <20230313-fs-nfs-setgid-v2-1-9a59f436cfc0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230313-fs-nfs-setgid-v2-1-9a59f436cfc0@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 14, 2023 at 12:51:10PM +0100, Christian Brauner wrote:
> We've aligned setgid behavior over multiple kernel releases. The details
> can be found in the following two merge messages:
> cf619f891971 ("Merge tag 'fs.ovl.setgid.v6.2')
> 426b4ca2d6a5 ("Merge tag 'fs.setgid.v6.0')
> Consistent setgid stripping behavior is now encapsulated in the
> setattr_should_drop_sgid() helper which is used by all filesystems that
> strip setgid bits outside of vfs proper. Switch nfs to rely on this
> helper as well. Without this patch the setgid stripping tests in
> xfstests will fail.
> 
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
> Changes in v2:
> - Christoph Hellwig <hch@lst.de>:
>   * Export setattr_should_sgid() so it actually can be used by filesystems
> - Link to v1: https://lore.kernel.org/r/20230313-fs-nfs-setgid-v1-1-5b1fa599f186@kernel.org
> ---

If someone has a few cycles to give this a review it would be
appreciated. I'm happy to carry this patch or the NFS tree can.
I'm not fussed.
