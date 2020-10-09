Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1995287FFF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 03:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgJIB1E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 21:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgJIB1E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 21:27:04 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E45EC0613D2;
        Thu,  8 Oct 2020 18:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=NKIVi7UDSjzyuQHI4U0wkqsnOFGai0rKDuXG5nOZQaM=; b=HJlq7KfnGEXmjvlyXYCq913cdh
        YyzOI1cnpPhh/QwDqNwOqQcf6KVCJCgWUsjxXTcqd6MYPuCkzXPggeAqUX/e5ToflzM4L81qNZ1Cm
        Su8RyK3vIgoldru4H5/tVI4SWGglbZr8zrfGLMHKUWLjhVmNKKlkeP4lWJTVNf1Y17Mla5PM2Lp2+
        BEv+7kfVR8MeGDmE5WnTw+b7B6Dotic6voRhXHi3MciDyqHmPbOweoNWLDq6yatS3C0WXCJGkguD1
        1nB3FqKBUTNKmP0zBRiqmGFXDcRaVzOREOza1trWfJx93sllSU3U9sBYNbmxGR3vsgccrF9f+jT1T
        njIwCylg==;
Received: from [2601:1c0:6280:3f0::507c]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQhBC-00069w-LS; Fri, 09 Oct 2020 01:26:42 +0000
Subject: Re: [PATCH 35/35] Add documentation for dmemfs
To:     yulei.kernel@gmail.com, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, viro@zeniv.linux.org.uk,
        pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
 <4d1bc80e93134fb0f5691db5c4bb8bcbc1e716dd.1602093760.git.yuleixzhang@tencent.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7f4f18b4-130e-ce51-3149-8a1ad348dc2a@infradead.org>
Date:   Thu, 8 Oct 2020 18:26:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <4d1bc80e93134fb0f5691db5c4bb8bcbc1e716dd.1602093760.git.yuleixzhang@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/8/20 12:54 AM, yulei.kernel@gmail.com wrote:
> From: Yulei Zhang <yuleixzhang@tencent.com>
> 
> Introduce dmemfs.rst to document the basic usage of dmemfs.
> 

Please add dmemfs as an entry in Documentation/filesystems/index.rst also.

> Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
> ---
>  Documentation/filesystems/dmemfs.rst | 59 ++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/filesystems/dmemfs.rst
> 
> diff --git a/Documentation/filesystems/dmemfs.rst b/Documentation/filesystems/dmemfs.rst
> new file mode 100644
> index 000000000000..cbb4cc1ed31d
> --- /dev/null
> +++ b/Documentation/filesystems/dmemfs.rst
> @@ -0,0 +1,57 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================================
> +The Direct Memory Filesystem - DMEMFS
> +=====================================
> +
> +
> +.. Table of contents
> +
> +   - Overview
> +   - Compilation
> +   - Usage
> +
> +Overview
> +========
> +
> +Dmemfs (Direct Memory filesystem) is device memory or reserved
> +memory based filesystem. This kind of memory is special as it
> +is not managed by kernel and it is without 'struct page'. Therefore
> +it can save extra memory from the host system for various usage,

                                                             usages,

> +especially for guest virtual machines.
> +
> +It uses a kernel boot parameter ``dmem=`` to reserve the system
> +memory when the host system boots up, the details can be checked

                                     up. The details

> +in /Documentation/admin-guide/kernel-parameters.txt.
> +
> +Compilation
> +===========
> +
> +The filesystem should be enabled by turning on the kernel configuration
> +options::
> +
> +        CONFIG_DMEM_FS          - Direct Memory filesystem support
> +        CONFIG_DMEM             - Allow reservation of memory for dmem

Hm, is there a good reason for having both of these options?
Is one of them usable without the other one?
If not, there should only be one Kconfig option for DMEMFS.

> +
> +
> +Additionally, the following can be turned on to aid debugging::
> +
> +        CONFIG_DMEM_DEBUG_FS    - Enable debug information for dmem
> +
> +Usage
> +========
> +
> +Dmemfs supports mapping ``4K``, ``2M`` and ``1G`` size of pages to
> +the userspace, for example ::
> +
> +    # mount -t dmemfs none -o pagesize=4K /mnt/
> +
> +The it can create the backing storage with 4G size ::

   Then

> +
> +    # truncate /mnt/dmemfs-uuid --size 4G
> +
> +To use as backing storage for virtual machine starts with qemu, just need
> +to specify the memory-backed-file in the qemu command line like this ::
> +
> +    # -object memory-backend-file,id=ram-node0,mem-path=/mnt/dmemfs-uuid \
> +        share=yes,size=4G,host-nodes=0,policy=preferred -numa node,nodeid=0,memdev=ram-node0
> 


-- 
~Randy

