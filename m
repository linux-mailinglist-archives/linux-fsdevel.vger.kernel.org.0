Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88E6782D49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 17:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbjHUPau (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 11:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjHUPau (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:30:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD30D9
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 08:30:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74CF661561
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 15:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1178BC433C8;
        Mon, 21 Aug 2023 15:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692631847;
        bh=LCwlhjnN/lD8Sn7IYVqUebx7BKKWnVX5q30n58x2FQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AZdZSd1eBCXHHAfHd8mZWDZdJrOyg32onB/lgtzIHFWvpLyAXK6n+HIkf/R4FPb0Q
         5OJxUcJvYhDsUW4g0qeehPv+6fccZhglMmaNHFyc4ZS1R7JBOFB7GuYIT8uaFsinnr
         oj35Nvygi/qcrfkAV99z5hJMw5zpZvuPp//SAukMLcHUNjSlqcU2y2QcNXmA3AMG8x
         9V2V+Dpt86lMf8SMkzslUc1Drs3lK25GJY7Lkn8d1NaZ/Q+CENf6/f2IEtV+M5l2Ut
         GyjZaH8yhtfD9kQ0nTu/7zic1dWeim7SxVI98vim8VsQo5fcBXDqKw945g/CmwjV92
         OUlmp5WcdQMuA==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] kiocb_{start,end}_write() helpers
Date:   Mon, 21 Aug 2023 17:30:37 +0200
Message-Id: <20230821-zyklisch-seenotrettung-949a7d330b1b@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817141337.1025891-1-amir73il@gmail.com>
References: <20230817141337.1025891-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1937; i=brauner@kernel.org; h=from:subject:message-id; bh=LCwlhjnN/lD8Sn7IYVqUebx7BKKWnVX5q30n58x2FQk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ8bpacdrY0bt2FO4/XWhvYnq8/p3v5vcqK2wda0+QKlm6Y UKTZ21HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARQWNGhg/+VrfTV8jOLDq65I7BzW lCPJc+XT3NncYxI2LZjukpjCqMDP1861Sjpfon7Okp6/x0q6La4OfKnpl3t+z35Hw0PX1DKAsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 17 Aug 2023 17:13:30 +0300, Amir Goldstein wrote:
> Christian,
> 
> This is an attempt to consolidate the open coded lockdep fooling in
> all those async io submitters into a single helper.
> The idea to do that consolidation was suggested by Jan.
> 
> This re-factoring is part of a larger vfs cleanup I am doing for
> fanotify permission events.  The complete series is not ready for
> prime time yet, but this one patch is independent and I would love
> to get it reviewed/merged a head of the rest.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/7] io_uring: rename kiocb_end_write() local helper
      https://git.kernel.org/vfs/vfs/c/790c4d42a7c0
[2/7] fs: add kerneldoc to file_{start,end}_write() helpers
      https://git.kernel.org/vfs/vfs/c/7e6aa5e65f14
[3/7] fs: create kiocb_{start,end}_write() helpers
      https://git.kernel.org/vfs/vfs/c/e15f778bb179
[4/7] io_uring: use kiocb_{start,end}_write() helpers
      https://git.kernel.org/vfs/vfs/c/a2aafea26bd5
[5/7] aio: use kiocb_{start,end}_write() helpers
      https://git.kernel.org/vfs/vfs/c/b91bf89f2435
[6/7] ovl: use kiocb_{start,end}_write() helpers
      https://git.kernel.org/vfs/vfs/c/6c2366036a05
[7/7] cachefiles: use kiocb_{start,end}_write() helpers
      https://git.kernel.org/vfs/vfs/c/e7905aa6226c
