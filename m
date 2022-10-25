Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E836D60C5BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 09:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiJYHqu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 03:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbiJYHqo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:46:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5149B15A97B;
        Tue, 25 Oct 2022 00:46:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E22E2617BF;
        Tue, 25 Oct 2022 07:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7E1C433C1;
        Tue, 25 Oct 2022 07:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666684002;
        bh=mak9uub/bsAptzNwPAI1j0Nfo9SEKld+eF2iwdIf1oQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i679rmWdAezDoM0w/EDNxl4SGIi8QH1kOnHDS1YXZB7PFGer5rDF4j+3A8ULJGpGs
         oLybdrpMdYsOWA3Lk6Onc4JviUQ6Dlb/w8AFNm4lvCw6oJkzBlmz9UqlM0UE4TAg2a
         TWtAXsXAWEP9voRLTmlpwuwLlUGTMwVbKN/lKJfcLnfiKZmafgihD2bM3DkLk0PLDP
         gFD6At8eO+jMsxieXAYYdVyXLfrFhfyPYt7EKcOEAdZMHmKG3E8c53e+cXKWaE7+3K
         SsBsQEftGS/KTI2Ewxb6r0APJkHpLbh0OuzJECbfxrEeNJL7D36PVpgQjq+LT/OOxN
         BVfkKM63tLdDQ==
Date:   Tue, 25 Oct 2022 09:46:37 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH 1/1] squashfs: enable idmapped mounts
Message-ID: <20221025074637.v6c243giy7itbimp@wittgenstein>
References: <20221024191552.55951-1-michael.weiss@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221024191552.55951-1-michael.weiss@aisec.fraunhofer.de>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 24, 2022 at 09:15:52PM +0200, Michael Weiß wrote:
> For squashfs all needed functionality for idmapped mounts is already
> implemented by the generic handlers in the VFS. Thus, it is sufficient
> to just enable the corresponding FS_ALLOW_IDMAP flag to support
> idmapped mounts.
> 
> We use this for unprivileged (user namespaced) containers based on
> squashfs images as rootfs in GyroidOS.
> 
> A simple test using the mount-idmapped tool executed as user with
> uid=1000 looks as follows:
> 
> $ mkdir test
> $ echo "test" > test/test_file
> $ mksquashfs test/ fs.img
> $ sudo mkdir /mnt/test
> $ sudo mkdir /mnt/mapped
> $ sudo mount fs.img -o loop /mnt/test/
> $ sudo ./mount-idmapped --map-mount b:1000:2000:1 /mnt/test/ /mnt/mapped/
> 
> $ mount | tail -n2
> fs.img on /mnt/test type squashfs (ro,relatime,errors=continue)
> fs.img on /mnt/mapped type squashfs (ro,relatime,idmapped,errors=continue)
> 
> $ ls -lan /mnt/test/
> total 5
> drwxr-xr-x 2 1000 1000   32 Okt 24 13:36 .
> drwxr-xr-x 6    0    0 4096 Okt 24 13:38 ..
> -rw-r--r-- 1 1000 1000    5 Okt 24 13:36 test_file
> 
> $ ls -lan /mnt/mapped/
> total 5
> drwxr-xr-x 2 2000 2000   32 Okt 24 13:36 .
> drwxr-xr-x 6    0    0 4096 Okt 24 13:38 ..
> -rw-r--r-- 1 2000 2000    5 Okt 24 13:36 test_file
> 
> Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
> ---

This should indeed be all that is needed. Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
