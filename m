Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F627AABD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 10:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjIVIIs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 04:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjIVIIr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:08:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2011A5;
        Fri, 22 Sep 2023 01:08:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F92BC433C7;
        Fri, 22 Sep 2023 08:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695370121;
        bh=EFZdZuA1bgAXV5AvWlugKRnoAhOxAfKWHVnlSpBHmsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UVH7BLlMFJgfpXuwIOQyMJKeDa7uMySj42MzRYs1UY/wWNQ2tuCTY/wOvIpDlq/k/
         O35vjFv3Yg8edSeTIZQWm4omxME67E3ctvgOJgleY9P2/RG6T3SmHoHJJLFdS3ctLw
         tr+HovOZyeqp6y/RbkZWtFyISCuaGDTWGchtjioQAqmGIRSFVaTEvqbg75apFUYJEI
         MUx0sNMMPHgoBDjiaK74rvSf8gZDxPTpkO3CGVuUrCF2l0RfTu6HqfzL2Rtk7xvGnr
         tXBX2aDMNbxaUNn9fdJwLUEj27V3FxJqxpAMBw5eW10kSI/WMEeTGGifAkd5jq2JTo
         jRhhF49G7kqfw==
Date:   Fri, 22 Sep 2023 10:08:36 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Cai Xinchen <caixinchen1@huawei.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG?] fsconfig restart_syscall failed
Message-ID: <20230922-drillen-muschel-c9bd03acfe00@brauner>
References: <84e5fb5f-67c5-6d34-b93b-b307c6c9805c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84e5fb5f-67c5-6d34-b93b-b307c6c9805c@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:18:24AM +0800, Cai Xinchen wrote:
> Hello:
>   I am doing some test for kernel 6.4, util-linux version:2.39.1.
> Have you encountered similar problems? If there is a fix, please
> let me know.
> Thank you very much
> 
> --------------------------------------------------
> 
> util-linux version 2.39.1 call mount use fsopen->fsconfig->fsmount->close
> instead of mount syscall.
> 
> And use this shell test:
> 
> #!/bin/bash
> mkdir -p /tmp/cgroup/cgrouptest
> while true
> do
>         mount -t cgroup -o none,name=foo cgroup /tmp/cgroup/cgrouptest


> in mount syscall, no function will check fs->phase, and fc is recreate
> in monnt syscall. However, in fdconfig syscall, fc->phase is not initial as
> FS_CONTEXT_CREATE_PARAMS, restart_syscall will return -EBUSY. fc is created
> in fsopen syscall.

Mount api system calls aren't restartable so that doesn't work. cgroup2
doesn't have this issue, only cgroup1 has. So cgroup1_get_tree() should
probably be fixed if anyone cares.
