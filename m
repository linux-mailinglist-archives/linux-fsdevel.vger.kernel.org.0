Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518DE70E440
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 20:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbjEWRsK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 13:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjEWRsJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 13:48:09 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7648A10DC
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 10:47:37 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-3384a495f78so795685ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 10:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684864039; x=1687456039;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P83mAP3794Qc2rx7etTG0J7GguJCN4lGoQQUE7E+dSE=;
        b=tyOtJD0kR7qpzgP6TZz2YGZvIE22hlgwPOcC0vjn0WYZTw5f7XQauSd7ykjRZUFyuu
         8paXzMFZhGldAxCIkNg/pQ788ENJ24nBPHjMn77GDP0VyZSdhI+4aa8BfgsIeNDiCviv
         SgQCLjTyWjfy66Nsnb3MP7Jt3UYm436C6GsDSd4BGFbAvE7F12ro8mKw7aKHjt04uIx3
         42FhcrYkh6RZ5wUeK4U78CQ68YY8n+UQ12eTjno6fCdOCoQrTBCM8lI6pchKt/j8cQn/
         jneP+KYNEn0S4n9P3D29xLvzZA37NUDBcCu4dzPrQBGTAW+trW8Rl9mwPeHN1d71iYZn
         OMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684864039; x=1687456039;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P83mAP3794Qc2rx7etTG0J7GguJCN4lGoQQUE7E+dSE=;
        b=fEJRJqpuOIZ0003qZZZ7dOPm0Y9CfnpELIMdtcQjPNV5MhD7qahkIGuPskW4E1DdKf
         eL8aGRf+0xwQkzze1Mmjr81h43Kisz4gZ3QM9ZtEFJ1bfE/Hs5zFs9QNcuKzQ4HM0bVF
         NF4HGOh8dts687G7SCrhANAKWM08X6u4etRGJL8ZRbk7kCbBjbuZ/pfYAqxOxWGmWUyP
         Ml2+WYYCSxU3K7Dw4iXOLjHnWM83ZlAElv4vxFrokCxzxVFSWTfBb9oLS4K1vcazbtId
         Zhb04BN3bcWbVrcln+KXXx8muSDMwuTMJpcHUAXc9CEHW6Xv8iOROvU1S84Z3kWtnLZQ
         W61A==
X-Gm-Message-State: AC+VfDxY0SH9d0sSEaGjFbLwfKHR8gG4ZUfXndxaVUZBP7Ue3M0OI96E
        mG/zdsNEM2nbDbMvY07/A53MDg==
X-Google-Smtp-Source: ACHHUZ5OySrMNAz1XiCBBtDjl7AkkhqaS7h6N4Sd7quyROgP6/P28x+ycv20Wf9Hh2GweO/SHUqbow==
X-Received: by 2002:a6b:b20f:0:b0:774:8351:89ac with SMTP id b15-20020a6bb20f000000b00774835189acmr1448217iof.1.1684864039207;
        Tue, 23 May 2023 10:47:19 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x10-20020a6bfe0a000000b00763ae96e71bsm2790656ioh.41.2023.05.23.10.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:47:18 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <20230522135018.2742245-1-dhowells@redhat.com>
References: <20230522135018.2742245-1-dhowells@redhat.com>
Subject: Re: [PATCH v22 00/31] splice: Kill ITER_PIPE
Message-Id: <168486403802.409251.16946238913512642087.b4-ty@kernel.dk>
Date:   Tue, 23 May 2023 11:47:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Mon, 22 May 2023 14:49:47 +0100, David Howells wrote:
> I've split off splice patchset and moved the block patches to a separate
> branch (though they are dependent on this one).
> 
> This patchset kills off ITER_PIPE to avoid a race between truncate,
> iov_iter_revert() on the pipe and an as-yet incomplete DMA to a bio with
> unpinned/unref'ed pages from an O_DIRECT splice read.  This causes memory
> corruption[2].  Instead, we use filemap_splice_read(), which invokes the
> buffered file reading code and splices from the pagecache into the pipe;
> copy_splice_read(), which bulk-allocates a buffer, reads into it and then
> pushes the filled pages into the pipe; or handle it in filesystem-specific
> code.
> 
> [...]

Applied, thanks!

[01/31] splice: Fix filemap_splice_read() to use the correct inode
        commit: 5c1a3db1ad679a504d31f8d7520b8d143cff4a81
[02/31] splice: Make filemap_splice_read() check s_maxbytes
        commit: f4d4a116512e2184461016bd5a4f1b5c659ab52c
[03/31] splice: Rename direct_splice_read() to copy_splice_read()
        commit: 49bfda41ae98a5b55a4638a085202e92c2d82bb3
[04/31] splice: Clean up copy_splice_read() a bit
        commit: 005ccb384566faf30cf9a45b624944d29917a9bb
[05/31] splice: Make do_splice_to() generic and export it
        commit: d4e52f54da56fb95a0fb9c55a2fedca009ba27b2
[06/31] splice: Check for zero count in vfs_splice_read()
        commit: 1c619a3aa1b5432e9c8451d27f92682557f6e995
[07/31] splice: Make splice from an O_DIRECT fd use copy_splice_read()
        commit: 27c3a9bd19a862b051d0249c1434c27b532064fb
[08/31] splice: Make splice from a DAX file use copy_splice_read()
        commit: 1e9022b9b150fe37293e78b6a4d1ef3b6cccf4c0
[09/31] shmem: Implement splice-read
        commit: 680cf0d89c54866599dad4144b35b3b9b38da036
[10/31] overlayfs: Implement splice-read
        commit: b9c516b37fc7cc930882b59713264e16d13dc195
[11/31] coda: Implement splice-read
        commit: e0187fb3198e0822afb6d95efb64825493d831df
[12/31] tty, proc, kernfs, random: Use copy_splice_read()
        commit: 703670cb841af4c3499db72e79f70d1afd27aa24
[13/31] net: Make sock_splice_read() use copy_splice_read() by default
        commit: 7e678ad3bda2c466ff5cb074a60069e341736196
[14/31] 9p: Add splice_read wrapper
        commit: 23f9131befc8292677cd83aff12b4362c6d2b0ff
[15/31] afs: Provide a splice-read wrapper
        commit: 1210eadcfd9cc1e9c0b23c6c55c85ff1106eae63
[16/31] ceph: Provide a splice-read wrapper
        commit: ecca566b1bc58e7ba3cd0ac745a1f4567a5dd6b7
[17/31] ecryptfs: Provide a splice-read wrapper
        commit: a8b8d669b744bcf965fd2b46ddfa4c94cd8a1d3a
[18/31] ext4: Provide a splice-read wrapper
        commit: 22d3afaa35b8dfe3dedd5c1eba7c68cd1001f8a3
[19/31] f2fs: Provide a splice-read wrapper
        commit: 10f3bb0832bccf47808bdd1517bc32f2241009f0
[20/31] nfs: Provide a splice-read wrapper
        commit: 51bea4c9f43e367166ad799e0a338fef8b7d360e
[21/31] ntfs3: Provide a splice-read wrapper
        commit: e0f80cb19e7d8a5b7d0891ae4079e9cd08ce1a21
[22/31] ocfs2: Provide a splice-read wrapper
        commit: dbf9b0577f7b08a46c769a0c5cbc497e9b48d238
[23/31] orangefs: Provide a splice-read wrapper
        commit: ec1498f4199e4b276ed9a897126873dba663f1fb
[24/31] xfs: Provide a splice-read wrapper
        commit: eba8fd3970721ee4059e509b5f1db512de8486cc
[25/31] zonefs: Provide a splice-read wrapper
        commit: a73aa694dae34eba02296ecba7a2b815ed492f25
[26/31] trace: Convert trace/seq to use copy_splice_read()
        commit: 580fc3965524b2dbd0472d52392a4d78e2e865a7
[27/31] cifs: Use filemap_splice_read()
        commit: 641403a99879bb4f08698d8bb1ac1dfa752c8dd8
[28/31] splice: Use filemap_splice_read() instead of generic_file_splice_read()
        commit: 69d1253f516798fbce0a6d2b693112cc02cb46a4
[29/31] splice: Remove generic_file_splice_read()
        commit: 0e67da77774ad90fd4a28d5f852687e7562882b8
[30/31] iov_iter: Kill ITER_PIPE
        commit: 6569c1d1c210d15ac0c402aeaada217f3b197737
[31/31] splice: kdoc for filemap_splice_read() and copy_splice_read()
        commit: 4e240fcf3a7572c1743b24b4d7e1aeec4a8f56b7

Best regards,
-- 
Jens Axboe



