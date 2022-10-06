Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E635F6BCB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 18:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiJFQck (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 12:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJFQcj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 12:32:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D172B3B1A;
        Thu,  6 Oct 2022 09:32:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 948C361A22;
        Thu,  6 Oct 2022 16:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF77C433D6;
        Thu,  6 Oct 2022 16:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665073958;
        bh=EpiLhU9Vopf2fm0LDuMXBE1GSbO3K9x1KfL5hJfKdU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BfWleTUhRNqsI+maojBT7rGzIWgqvXoBiV0VQVtNdYcAwLRLn3oSWOlWEokzJwW9E
         oBChMo9X78YlxVggVl19ZnLJPpMrFCvpYDdYt64FWpe2ON7JmQUcWtD/avdUgySgm/
         dbNpGVE2oOEdXvir0obKPKdFsxNRDKP1G0vg0LtXT/fvzEeo0fXvves6BZsJxLLK/h
         +2anJgh1iHcX+D0vZ2pqy+ae58mtEqUr1bAensM/YvIkoE3ifuoj4C6TXJYkZm31Fk
         SZJX80WXRMIxoYkNMIaagConJqkM70l/K4uj9BB8vk50Oh77cJ1XRbW2IwYTc7NhR8
         GwncyKKF7SAxg==
Date:   Thu, 6 Oct 2022 09:32:37 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] f2fs: introduce F2FS_IOC_START_ATOMIC_REPLACE
Message-ID: <Yz8DJROpwCcNyxVX@magnolia>
References: <20221004171351.3678194-1-daeho43@gmail.com>
 <20221004171351.3678194-2-daeho43@gmail.com>
 <Yz6S3kP4rjm5/30N@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz6S3kP4rjm5/30N@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 06, 2022 at 01:33:34AM -0700, Christoph Hellwig wrote:
> On Tue, Oct 04, 2022 at 10:13:51AM -0700, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> > 
> > introduce a new ioctl to replace the whole content of a file atomically,
> > which means it induces truncate and content update at the same time.
> > We can start it with F2FS_IOC_START_ATOMIC_REPLACE and complete it with
> > F2FS_IOC_COMMIT_ATOMIC_WRITE. Or abort it with
> > F2FS_IOC_ABORT_ATOMIC_WRITE.
> 
> It would be great to Cc Darrick and linux-fsdevel as there have been
> attempts to do this properly at the VFS level instead of a completely
> undocumented ioctl.

It's been a while since I sent the last RFC, but yes, it's still in my
queue as part of the xfs online fsck patchserieses.

https://lore.kernel.org/linux-fsdevel/161723932606.3149451.12366114306150243052.stgit@magnolia/

More recent git branch:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=atomic-file-updates

--D
