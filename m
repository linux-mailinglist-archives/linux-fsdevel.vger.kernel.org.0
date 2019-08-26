Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C009C711
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 03:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfHZBnU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Aug 2019 21:43:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5653 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726406AbfHZBnT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Aug 2019 21:43:19 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 726897F4357E6411D154;
        Mon, 26 Aug 2019 09:43:17 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Mon, 26 Aug 2019
 09:43:11 +0800
Subject: Re: [Virtio-fs] [PATCH 04/19] virtio: Implement get_shm_region for
 PCI transport
To:     Vivek Goyal <vgoyal@redhat.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-nvdimm@lists.01.org>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-5-vgoyal@redhat.com>
CC:     kbuild test robot <lkp@intel.com>, <kvm@vger.kernel.org>,
        <miklos@szeredi.hu>, <virtio-fs@redhat.com>,
        Sebastien Boeuf <sebastien.boeuf@intel.com>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5D63392C.3030404@huawei.com>
Date:   Mon, 26 Aug 2019 09:43:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20190821175720.25901-5-vgoyal@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/8/22 1:57, Vivek Goyal wrote:
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> 
> On PCI the shm regions are found using capability entries;
> find a region by searching for the capability.
> 
> Cc: kvm@vger.kernel.org
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: kbuild test robot <lkp@intel.com>
> ---
>  drivers/virtio/virtio_pci_modern.c | 108 +++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_pci.h    |  11 ++-
>  2 files changed, 118 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 7abcc50838b8..1cdedd93f42a 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -443,6 +443,112 @@ static void del_vq(struct virtio_pci_vq_info *info)
>  	vring_del_virtqueue(vq);
>  }
>  
> +static int virtio_pci_find_shm_cap(struct pci_dev *dev,
> +                                   u8 required_id,
> +                                   u8 *bar, u64 *offset, u64 *len)
> +{
> +	int pos;
> +
> +        for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
> +             pos > 0;
> +             pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
> +		u8 type, cap_len, id;
> +                u32 tmp32;
> +                u64 res_offset, res_length;
> +
> +		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> +                                                         cfg_type),
> +                                     &type);
> +                if (type != VIRTIO_PCI_CAP_SHARED_MEMORY_CFG)
> +                        continue;
> +
> +		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> +                                                         cap_len),
> +                                     &cap_len);
> +		if (cap_len != sizeof(struct virtio_pci_cap64)) {
> +		        printk(KERN_ERR "%s: shm cap with bad size offset: %d size: %d\n",
> +                               __func__, pos, cap_len);
> +                        continue;
> +                }
> +
> +		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> +                                                         id),
> +                                     &id);
> +                if (id != required_id)
> +                        continue;
> +
> +                /* Type, and ID match, looks good */
> +                pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> +                                                         bar),
> +                                     bar);
> +
> +                /* Read the lower 32bit of length and offset */
> +                pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap, offset),
> +                                      &tmp32);
> +                res_offset = tmp32;
> +                pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap, length),
> +                                      &tmp32);
> +                res_length = tmp32;
> +
> +                /* and now the top half */
> +                pci_read_config_dword(dev,
> +                                      pos + offsetof(struct virtio_pci_cap64,
> +                                                     offset_hi),
> +                                      &tmp32);
> +                res_offset |= ((u64)tmp32) << 32;
> +                pci_read_config_dword(dev,
> +                                      pos + offsetof(struct virtio_pci_cap64,
> +                                                     length_hi),
> +                                      &tmp32);
> +                res_length |= ((u64)tmp32) << 32;
> +
> +                *offset = res_offset;
> +                *len = res_length;
> +
> +                return pos;
> +        }
> +        return 0;
> +}
> +
> +static bool vp_get_shm_region(struct virtio_device *vdev,
> +			      struct virtio_shm_region *region, u8 id)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	struct pci_dev *pci_dev = vp_dev->pci_dev;
> +	u8 bar;
> +	u64 offset, len;
> +	phys_addr_t phys_addr;
> +	size_t bar_len;
> +	char *bar_name;

'char *bar_name' should be cleaned up to avoid compiling warning. And I
wonder if you mix tab and blankspace for code indent? Or it's just my
email display problem?

Thanks,
Jun
