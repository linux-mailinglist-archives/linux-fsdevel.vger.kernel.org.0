Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CB5785308
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 10:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbjHWItC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 04:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbjHWIs2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:48:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A624E70;
        Wed, 23 Aug 2023 01:47:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28400640C8;
        Wed, 23 Aug 2023 08:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9814C433C7;
        Wed, 23 Aug 2023 08:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692780452;
        bh=UEA7Q/8Evs+HDqRAlVEIqHK2b1cpUxwqlYYHM96iIjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gp19ZTR1PhIUm9zMfKFz+JIBJn6Z+/WRZGz++BkZRHJDR1bpdnwz2dqrY3bCuu7m7
         P+LC9uYuItjRyqdZUy4jd9JndTya5ALZqv8oZORO2ekx31AF5fDMEzZh9JECCVLv9N
         Qk7oy8qm/oe/1ODXUes1W+DJzaKpaGXeQ2OuuPkx6PSj4h9sDD2VnqVp7QADh5k0xC
         KLV6OzlIhTqekKSo1T3NS1X32QyuBZmHUL1BRhYONZ4YLSpwr7yrkHf0546h9PTQOV
         uNOGNp364k5N2usHGkdwFFglbx+UYzJ4j12JcwuClX2+SQdBHhyF8A44vfPDyIpB43
         0iej4L5I4dLMQ==
Date:   Wed, 23 Aug 2023 10:47:27 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Changhui Zhong <czhong@redhat.com>
Subject: Re: [czhong@redhat.com: [bug report] WARNING: CPU: 121 PID: 93233 at
 fs/dcache.c:365 __dentry_kill+0x214/0x278]
Message-ID: <20230823-kuppe-lassen-bc81a20dd831@brauner>
References: <ZOWFtqA2om0w5Vmz@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZOWFtqA2om0w5Vmz@fedora>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 12:06:14PM +0800, Ming Lei wrote:
> 
> Looks the issue is more related with vfs, so forward to vfs list.
> 
> ----- Forwarded message from Changhui Zhong <czhong@redhat.com> -----
> 
> Date: Wed, 23 Aug 2023 11:17:55 +0800
> From: Changhui Zhong <czhong@redhat.com>
> To: linux-scsi@vger.kernel.org
> Cc: Ming Lei <ming.lei@redhat.com>
> Subject: [bug report] WARNING: CPU: 121 PID: 93233 at fs/dcache.c:365 __dentry_kill+0x214/0x278
> 
> Hello,
> 
> triggered below warning issue with branch
> "
> Tree: mainline.kernel.org-clang
> Repository: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> @ master
> Commit Hash: 89bf6209cad66214d3774dac86b6bbf2aec6a30d
> Commit Name: v6.5-rc7-18-g89bf6209cad6
> Kernel information:
> Commit message: Merge tag 'devicetree-fixes-for-6.5-2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
> "
> for more detail，please check
> https://datawarehouse.cki-project.org/kcidb/tests/9232643
> 
> #modprobe scsi_debug virtual_gb=128
> #echo none > /sys/block/sdb/queue/scheduler
> #fio --bs=4k --ioengine=libaio --iodepth=1 --numjobs=4 --rw=randrw
> --name=sdb-libaio-randrw-4k --filename=/dev/sdb --direct=1 --size=60G
> --runtime=60

Looking at this issue it seems unlikely that this is a vfs bug.
We should see this all over the place and specifically not just on arm64.

The sequence here seems to be:

echo 4 > /proc/sys/vm/drop_caches
rmmod scsi_debug > /dev/null 3>&1

[ 3117.059778] WARNING: CPU: 121 PID: 93233 at fs/dcache.c:365 __dentry_kill+0x214/0x278 
[ 3117.067601] Modules linked in: scsi_debug nvme nvme_core nvme_common null_blk pktcdvd ipmi_watchdog ipmi_poweroff rfkill sunrpc vfat fat acpi_ipmi ipmi_ssif arm_spe_pmu igb ipmi_devintf ipmi_msghandler arm_cmn arm_dmc620_pmu cppc_cpufreq arm_dsu_pmu acpi_tad loop fuse zram xfs crct10dif_ce polyval_ce polyval_generic ghash_ce sbsa_gwdt ast onboard_usb_hub i2c_algo_bit xgene_hwmon [last unloaded: scsi_debug]

So my money is on some device that gets removed still having an
increased refcount and pinning the dentry. Immediate suspects would be:

7882541ca06d ("of/platform: increase refcount of fwnode")

but that part is complete speculation on my part.
