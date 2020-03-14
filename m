Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 775081858C5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 03:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgCOCXJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Mar 2020 22:23:09 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41383 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbgCOCXJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:23:09 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 10950ab98b3957dd; Sat, 14 Mar 2020 11:23:06 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Colin King <colin.king@canonical.com>
Cc:     Len Brown <lenb@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ACPI: sysfs: copy ACPI data using io memory copying
Date:   Sat, 14 Mar 2020 11:23:05 +0100
Message-ID: <2440284.4js2fAD822@kreacher>
In-Reply-To: <20200312111345.1057569-1-colin.king@canonical.com>
References: <20200312111345.1057569-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday, March 12, 2020 12:13:45 PM CET Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Reading ACPI data on ARM64 at a non-aligned offset from
> /sys/firmware/acpi/tables/data/BERT will cause a splat because
> the data is I/O memory mapped and being read with just a memcpy.
> Fix this by introducing an I/O variant of memory_read_from_buffer
> and using I/O memory mapped copies instead.
> 
> Fixes the following splat:
> 
> [  439.789355] Unable to handle kernel paging request at virtual address ffff800041ac0007
> [  439.797275] Mem abort info:
> [  439.800078]   ESR = 0x96000021
> [  439.803131]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  439.808437]   SET = 0, FnV = 0
> [  439.811486]   EA = 0, S1PTW = 0
> [  439.814621] Data abort info:
> [  439.817489]   ISV = 0, ISS = 0x00000021
> [  439.821319]   CM = 0, WnR = 0
> [  439.824282] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000817fc000
> [  439.830979] [ffff800041ac0007] pgd=000000bffcfff003, pud=0000009f27cee003, pmd=000000bf4b993003, pte=0068000080280703
> [  439.841584] Internal error: Oops: 96000021 [#1] SMP
> [  439.846449] Modules linked in: nls_iso8859_1 dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua ipmi_ssif input_leds joydev ipmi_devintf ipmi_msghandler thunderx2_pmu sch_fq_codel ip_tables x_tables autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor xor_neon raid6_pq libcrc32c raid1 raid0 multipath linear i2c_smbus ast i2c_algo_bit crct10dif_ce drm_vram_helper uas ttm ghash_ce drm_kms_helper sha2_ce syscopyarea sha256_arm64 qede sysfillrect mpt3sas sha1_ce sysimgblt fb_sys_fops raid_class qed drm scsi_transport_sas usb_storage ahci crc8 gpio_xlp i2c_xlp9xx hid_generic usbhid hid aes_neon_bs aes_neon_blk aes_ce_blk crypto_simd cryptd aes_ce_cipher
> [  439.908474] CPU: 2 PID: 3926 Comm: a.out Not tainted 5.4.0-14-generic #17-Ubuntu
> [  439.915855] Hardware name: To be filled by O.E.M. Saber/Saber, BIOS 0ACKL027 07/01/2019
> [  439.923844] pstate: 80400009 (Nzcv daif +PAN -UAO)
> [  439.928625] pc : __memcpy+0x90/0x180
> [  439.932192] lr : memory_read_from_buffer+0x64/0x88
> [  439.936968] sp : ffff8000350dbc70
> [  439.940270] x29: ffff8000350dbc70 x28: ffff009e9c444b00
> [  439.945568] x27: 0000000000000000 x26: 0000000000000000
> [  439.950866] x25: 0000000056000000 x24: ffff800041ac0000
> [  439.956164] x23: ffff009ea163f980 x22: 0000000000000007
> [  439.961462] x21: ffff8000350dbce8 x20: 000000000000000e
> [  439.966760] x19: 0000000000000007 x18: ffff8000112f64a8
> [  439.972058] x17: 0000000000000000 x16: 0000000000000000
> [  439.977355] x15: 0000000080280000 x14: ffff800041aed000
> [  439.982653] x13: ffff009ee9fa2840 x12: ffff800041ad1000
> [  439.987951] x11: ffff8000115e1360 x10: ffff8000115e1360
> [  439.993248] x9 : 0000000000010000 x8 : ffff800011ad2658
> [  439.998546] x7 : ffff800041ac0000 x6 : ffff009ea163f980
> [  440.003844] x5 : 0140000000000000 x4 : 0000000000010000
> [  440.009141] x3 : ffff800041ac0000 x2 : 0000000000000007
> [  440.014439] x1 : ffff800041ac0007 x0 : ffff009ea163f980
> [  440.019737] Call trace:
> [  440.022173]  __memcpy+0x90/0x180
> [  440.025392]  acpi_data_show+0x54/0x80
> [  440.029044]  sysfs_kf_bin_read+0x6c/0xa8
> [  440.032954]  kernfs_file_direct_read+0x90/0x2d0
> [  440.037470]  kernfs_fop_read+0x68/0x78
> [  440.041210]  __vfs_read+0x48/0x90
> [  440.044511]  vfs_read+0xd0/0x1a0
> [  440.047726]  ksys_read+0x78/0x100
> [  440.051028]  __arm64_sys_read+0x24/0x30
> [  440.054852]  el0_svc_common.constprop.0+0xdc/0x1d8
> [  440.059629]  el0_svc_handler+0x34/0xa0
> [  440.063366]  el0_svc+0x10/0x14
> [  440.066411] Code: 36180062 f8408423 f80084c3 36100062 (b8404423)
> [  440.072492] ---[ end trace 45fb374e8d2d800e ]---
> 
> A simple reproducer is as follows:
> 
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <stdio.h>
> #include <string.h>
> 
> int main(void)
> {
>         int fd;
>         char buffer[7];
>         ssize_t n;
> 
>         fd = open("/sys/firmware/acpi/tables/data/BERT", O_RDONLY);
>         if (fd < 0) {
>                 perror("open failed");
>                 return -1;
>         }
>         do {
>                 n = read(fd, buffer, sizeof(buffer));
>         } while (n > 0);
> 
>         return 0;
> }
> 
> BugLink: https://bugs.launchpad.net/bugs/1866772
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/acpi/sysfs.c   |  2 +-
>  fs/libfs.c             | 33 +++++++++++++++++++++++++++++++++
>  include/linux/string.h |  2 ++
>  3 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index c60d2c6d31d6..fb9e216cb8c0 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -446,7 +446,7 @@ static ssize_t acpi_data_show(struct file *filp, struct kobject *kobj,
>  	base = acpi_os_map_memory(data_attr->addr, data_attr->attr.size);
>  	if (!base)
>  		return -ENOMEM;
> -	rc = memory_read_from_buffer(buf, count, &offset, base,
> +	rc = memory_read_from_io_buffer(buf, count, &offset, base,
>  				     data_attr->attr.size);
>  	acpi_os_unmap_memory(base, data_attr->attr.size);
>  
> diff --git a/fs/libfs.c b/fs/libfs.c
> index c686bd9caac6..3e112c51ce7b 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -800,6 +800,39 @@ ssize_t memory_read_from_buffer(void *to, size_t count, loff_t *ppos,
>  }
>  EXPORT_SYMBOL(memory_read_from_buffer);
>  
> +/**
> + * memory_read_from_io_buffer - copy data from a io memory mapped buffer
> + * @to: the kernel space buffer to read to
> + * @count: the maximum number of bytes to read
> + * @ppos: the current position in the buffer
> + * @from: the buffer to read from
> + * @available: the size of the buffer
> + *
> + * The memory_read_from_buffer() function reads up to @count bytes from the
> + * io memory mappy buffer @from at offset @ppos into the kernel space address
> + * starting at @to.
> + *
> + * On success, the number of bytes read is returned and the offset @ppos is
> + * advanced by this number, or negative value is returned on error.
> + **/
> +ssize_t memory_read_from_io_buffer(void *to, size_t count, loff_t *ppos,
> +				   const void *from, size_t available)
> +{
> +	loff_t pos = *ppos;
> +
> +	if (pos < 0)
> +		return -EINVAL;
> +	if (pos >= available)
> +		return 0;
> +	if (count > available - pos)
> +		count = available - pos;
> +	memcpy_fromio(to, from + pos, count);
> +	*ppos = pos + count;
> +
> +	return count;
> +}
> +EXPORT_SYMBOL(memory_read_from_io_buffer);
> +
>  /*
>   * Transaction based IO.
>   * The file expects a single write which triggers the transaction, and then
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 6dfbb2efa815..0c6ec2aa3909 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -216,6 +216,8 @@ int bprintf(u32 *bin_buf, size_t size, const char *fmt, ...) __printf(3, 4);
>  
>  extern ssize_t memory_read_from_buffer(void *to, size_t count, loff_t *ppos,
>  				       const void *from, size_t available);
> +extern ssize_t memory_read_from_io_buffer(void *to, size_t count, loff_t *ppos,
> +					  const void *from, size_t available);
>  
>  int ptr_to_hashval(const void *ptr, unsigned long *hashval_out);
>  
> 

Applied as 5.7 material, thanks!




