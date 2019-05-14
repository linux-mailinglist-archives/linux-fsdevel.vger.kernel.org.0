Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 778B21CB6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 17:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfENPKD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 11:10:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37804 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfENPKD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 11:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vg3ia/r810H9SSaaH0GiclbWcxBsBWmX3eOHv52f7hg=; b=DmxHDtquirwoRt3leeWs0jqe4p
        OBuVqen+B+T1sPmdQ/Xh/kJtVL1TYRU19cMa/+RiVhkDSyjlRsTaD8G7BLmbV/Erk3ZU9rNHcJAcz
        AzPBib/3h55XEBCNcTmML3raNdaT8gVxGKrIDuTzMFSxcwxp90UfjeuWN/JU3sNy4iFSnaGH6kbtG
        HICqbTL075Zfbakmx1maJv8+hRz1ukLMs87jNeIa2qAUbh4QZQaCfx1yAaQOHVQ0m/aqSDpXot4I5
        fRMJhaeNDyY1S2W6k7vWeIWbdl1vpuIPODlGt6g9JU+fJi9lgIGmpqCHh9KDTrw8etTDZNxt/2mqI
        qo+2U/+g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQZ3R-0000BE-Iq; Tue, 14 May 2019 15:09:22 +0000
Subject: Re: [PATCH v9 2/7] virtio-pmem: Add virtio pmem driver
To:     Pankaj Gupta <pagupta@redhat.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org,
        qemu-devel@nongnu.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Cc:     dan.j.williams@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
        jasowang@redhat.com, willy@infradead.org, rjw@rjwysocki.net,
        hch@infradead.org, lenb@kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        lcapitulino@redhat.com, kwolf@redhat.com, imammedo@redhat.com,
        jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com,
        stefanha@redhat.com, aarcange@redhat.com, david@redhat.com,
        david@fromorbit.com, cohuck@redhat.com,
        xiaoguangrong.eric@gmail.com, pbonzini@redhat.com,
        kilobyte@angband.pl, yuval.shaia@oracle.com, jstaron@google.com
References: <20190514145422.16923-1-pagupta@redhat.com>
 <20190514145422.16923-3-pagupta@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c22d42f6-ef94-0310-36f2-e9085d3464c2@infradead.org>
Date:   Tue, 14 May 2019 08:09:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514145422.16923-3-pagupta@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/14/19 7:54 AM, Pankaj Gupta wrote:
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 35897649c24f..94bad084ebab 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -42,6 +42,17 @@ config VIRTIO_PCI_LEGACY
>  
>  	  If unsure, say Y.
>  
> +config VIRTIO_PMEM
> +	tristate "Support for virtio pmem driver"
> +	depends on VIRTIO
> +	depends on LIBNVDIMM
> +	help
> +	This driver provides access to virtio-pmem devices, storage devices
> +	that are mapped into the physical address space - similar to NVDIMMs
> +	 - with a virtio-based flushing interface.
> +
> +	If unsure, say M.

<beep>
from Documentation/process/coding-style.rst:
"Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces."

> +
>  config VIRTIO_BALLOON
>  	tristate "Virtio balloon driver"
>  	depends on VIRTIO

thanks.
-- 
~Randy
