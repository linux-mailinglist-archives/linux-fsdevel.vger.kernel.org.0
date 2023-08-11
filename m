Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6E6778C92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 13:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbjHKLA4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 07:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbjHKLAt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:00:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945DA1704
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 04:00:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 030C165047
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 11:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41195C433C8;
        Fri, 11 Aug 2023 11:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691751647;
        bh=pquqTiNtyapvxvGJ5Cb6d1ymD8+JCygJyZyKVnKO18Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b7LZy3eRjrFAsVz9BJ2/3jM2ewd0yXUnnQyb6GUADTmwJv2tNpua9PEws+1IAtt6W
         ism5HggLXK0dKzp6o+YtYODoXMfrxXgsyPk/RwTpZur+Y+52CLEujMQoBV3Lff1Fn6
         UnJ1/B+7QeqsYJttKyEUTKLRLARrrTTep1dh38urUnwbzHI5AHIpRnJf1WRNuJA3v9
         c5BG6v1qO40nIj1ZDkzVThpu4aNhENCJTiA5WsA92L81KCMKGrbPK5ypKcQIdOKjX0
         jA5sLNZqDD/yUVdDYwYcLucQJ0zPxZYKrDpavYhv82R7JuykqFG63yMjvheKi+CpN7
         6UJ7p2tu9Ry7Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleksandr Tymoshenko <ovt@google.com>,
        Carlos Maiolino <cem@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>, Daniel Xu <dxu@dxuuu.xyz>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: (subset) [PATCH vfs.tmpfs v2 4/5] tmpfs: trivial support for direct IO
Date:   Fri, 11 Aug 2023 13:00:33 +0200
Message-Id: <20230811-halde-gesiegt-cea0d6a56411@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6f2742-6f1f-cae9-7c5b-ed20fc53215@google.com>
References: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com> <7c12819-9b94-d56-ff88-35623aa34180@google.com> <6f2742-6f1f-cae9-7c5b-ed20fc53215@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349; i=brauner@kernel.org; h=from:subject:message-id; bh=pquqTiNtyapvxvGJ5Cb6d1ymD8+JCygJyZyKVnKO18Y=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRcEzk/JTpXwu5DzbXms7tXWBa0zJklvuyfwUR1i0LHbwVt 3x7s7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIZ0lGhkP6j/aZufH83rzeWOr4Yh npjUU1n8+KcIpt3GR6dGnjvq0M/+vfObsKndz0+On8SC55Hb6/bh2Tb9XpMvc285w+x3Ivhx0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 10 Aug 2023 23:27:07 -0700, Hugh Dickins wrote:
> Depending upon your philosophical viewpoint, either tmpfs always does
> direct IO, or it cannot ever do direct IO; but whichever, if tmpfs is to
> stand in for a more sophisticated filesystem, it can be helpful for tmpfs
> to support O_DIRECT.  So, give tmpfs a shmem_file_open() method, to set
> the FMODE_CAN_ODIRECT flag: then unchanged shmem_file_read_iter() and new
> shmem_file_write_iter() do the work (without any shmem_direct_IO() stub).
> 
> [...]

I've dropped the previous version and applied this one. Thank!

---

Applied to the vfs.tmpfs branch of the vfs/vfs.git tree.
Patches in the vfs.tmpfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.tmpfs

[4/5] tmpfs: trivial support for direct IO
      https://git.kernel.org/vfs/vfs/c/6b55d273ec5b
