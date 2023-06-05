Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1041722D8A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 19:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbjFERWL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 13:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbjFERWH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:22:07 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63BF114
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 10:22:03 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-19f36a8ac3bso1028153fac.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jun 2023 10:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685985722; x=1688577722;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HBzAKQ8EWkIuzHq6aIJ4mqwm9+DaKYAj6ps+F/vuTI=;
        b=jh2UmAQ3NsKFC/MrynS5s4VOiwEkVYskRKYwmk2+r9IhdcNLaWSoRFhCITHNAwpw2w
         bTVPEyYGpdrWg/AfDmiWW5LMgBNHD7iPyGbjQ38kps2Kwq4XW1CMRIkFXj2etTskPemV
         GWWUMdq0FhYa5jHjFZZOn2STiHFEJMPEx6Vh9Lx2pkmbyH/bPw3UTOzEkwq9oVe+6Gvu
         mVeRryP8psvMA5OaaANvxrFw3MTbHBXsJI31FRRwpBUQKSd9aSH095es87US3bTcGYpF
         dZxTINVrQN/BTouOpqCAhoEMlsXUP3gbmYISyXWbPAshVYhvfYFI+BDRDMPBLMWzG2QA
         N1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685985722; x=1688577722;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HBzAKQ8EWkIuzHq6aIJ4mqwm9+DaKYAj6ps+F/vuTI=;
        b=V6Ul1KvuBlV/hX8qfTnOzDBNtQKZzBHtUOUSN5Ynqhd1rxu4UrhPy2Bap4zr9k6aGk
         hrW/lhItv7b8XRV85BfJwvq3MQIq0AnVpz0ZE9ZNqNQimlGP+UWE1c9LcAYOkH7Jte7I
         dY5skWMgDxfoiWiYMNhlkQvq/Fbh6D6PBr/4KVd4EhaRx8jClS00+coQaW+yFFt/e9zp
         F+LMDH1RDzRBFMeC7aWa1WyqLErBJF8jPIq7ReAyKtx3FvdyAkBTE5l/dhLlo00HkLoI
         GqIZtCHcw/0czpRjLk0s8ltyVbPKboLqXw/I24y27jDznLYhmWv6UIoy5XtgG76nbnk6
         +QWw==
X-Gm-Message-State: AC+VfDwW6XX61Cq6YsNEF7IZxTxSoVhiyYoeiJpcHABwQuQMWlCeXCG7
        Igps2UyprTUsXubMh3Jj5I/35aClJns5Eev0bYQ=
X-Google-Smtp-Source: ACHHUZ6PL62Ib5H4QB3rPGiaQRZcV0rInc/UOc81HCQF8mpjnx0vviMbWu8Zk38mJqV6Qj9LKxCzMg==
X-Received: by 2002:a05:6358:cc27:b0:127:fa1b:fb0e with SMTP id gx39-20020a056358cc2700b00127fa1bfb0emr1263873rwb.1.1685985722606;
        Mon, 05 Jun 2023 10:22:02 -0700 (PDT)
Received: from [127.0.0.1] ([2600:380:c01c:32f0:eff8:7692:bf8a:abc6])
        by smtp.gmail.com with ESMTPSA id cl9-20020a17090af68900b0025643e5da99sm7993666pjb.37.2023.06.05.10.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 10:22:01 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
In-Reply-To: <20230601094459.1350643-1-hch@lst.de>
References: <20230601094459.1350643-1-hch@lst.de>
Subject: Re: introduce bdev holder ops and a file system shutdown method v3
Message-Id: <168598572109.2504.8975232011754082233.b4-ty@kernel.dk>
Date:   Mon, 05 Jun 2023 11:22:01 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Thu, 01 Jun 2023 11:44:43 +0200, Christoph Hellwig wrote:
> this series fixes the long standing problem that we never had a good way
> to communicate block device events to the user of the block device.
> 
> It fixes this by introducing a new set of holder ops registered at
> blkdev_get_by_* time for the exclusive holder, and then wire that up
> to a shutdown super operation to report the block device remove to the
> file systems.
> 
> [...]

Applied, thanks!

[01/16] block: factor out a bd_end_claim helper from blkdev_put
        commit: 0783b1a7cbd9a02ddc35fe531b5966b674b304f0
[02/16] block: refactor bd_may_claim
        commit: ae5f855ead6b41422ca0c971ebda509c0414f8ec
[03/16] block: turn bdev_lock into a mutex
        commit: 74e6464a987b2572771ac19163e961777fd0252e
[04/16] block: consolidate the shutdown logic in blk_mark_disk_dead and del_gendisk
        commit: 66fddc25fe182fd7d28b35f4173113f3eefc7fb5
[05/16] block: avoid repeated work in blk_mark_disk_dead
        commit: a4f75764d16bed317276b05a9fe2c179ef61680d
[06/16] block: unhash the inode earlier in delete_partition
        commit: 69f90b70bdb62e1a930239d33579e04884cd0b9a
[07/16] block: delete partitions later in del_gendisk
        commit: eec1be4c30df73238b936fa9f3653773a6f8b15c
[08/16] block: remove blk_drop_partitions
        commit: 00080f7fb7a599c26523037b202fb945f3141811
[09/16] block: introduce holder ops
        commit: 0718afd47f70cf46877c39c25d06b786e1a3f36c
[10/16] block: add a mark_dead holder operation
        commit: f55e017c642051ddc01d77a89ab18f5ee71d6276
[11/16] fs: add a method to shut down the file system
        commit: 87efb39075be6a288cd7f23858f15bd01c83028a
[12/16] xfs: wire up sops->shutdown
        commit: e7caa877e5ddac63886f4a8376cb3ffbd4dfe569
[13/16] xfs: wire up the ->mark_dead holder operation for log and RT devices
        commit: 8067ca1dcdfcc2a5e0a51bff3730ad3eef0623d6
[14/16] ext4: split ext4_shutdown
        commit: 97524b454bc562f4052751f0e635a61dad78f1b2
[15/16] ext4: wire up sops->shutdown
        commit: f5db130d4443ddf63b49e195782038ebaab0bec9
[16/16] ext4: wire up the ->mark_dead holder operation for log devices
        commit: dd2e31afba9e3a3107aa202726b6199c55075f59

Best regards,
-- 
Jens Axboe



