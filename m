Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8299E161F00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 03:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgBRCfk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 21:35:40 -0500
Received: from mga11.intel.com ([192.55.52.93]:62720 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgBRCfk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 21:35:40 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 18:35:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,454,1574150400"; 
   d="scan'208";a="223996330"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga007.jf.intel.com with ESMTP; 17 Feb 2020 18:35:36 -0800
Date:   Mon, 17 Feb 2020 18:35:36 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 00/12] Enable per-file/directory DAX operations V3
Message-ID: <20200218023535.GA14509@iweiny-DESK2.sc.intel.com>
References: <20200213190156.GA22854@iweiny-DESK2.sc.intel.com>
 <20200213190513.GB22854@iweiny-DESK2.sc.intel.com>
 <20200213195839.GG6870@magnolia>
 <20200213232923.GC22854@iweiny-DESK2.sc.intel.com>
 <CAPcyv4hkWoC+xCqicH1DWzmU2DcpY0at_A6HaBsrdLbZ6qzWow@mail.gmail.com>
 <20200214200607.GA18593@iweiny-DESK2.sc.intel.com>
 <x4936bcdfso.fsf@segfault.boston.devel.redhat.com>
 <20200214215759.GA20548@iweiny-DESK2.sc.intel.com>
 <x49y2t4bz8t.fsf@segfault.boston.devel.redhat.com>
 <x49tv3sbwu5.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49tv3sbwu5.fsf@segfault.boston.devel.redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 14, 2020 at 05:58:10PM -0500, Jeff Moyer wrote:
> Hi, Ira,
> 
> Jeff Moyer <jmoyer@redhat.com> writes:
> 
> > I'll try to get some testing in on this series, now.
> 
> This series panics in xfstests generic/013, when run like so:
> 
> MKFS_OPTIONS="-m reflink=0" MOUNT_OPTIONS="-o dax" ./check -g auto
> 
> I'd dig in further, but it's late on a Friday.  You understand.  :)

Yep...  and a long weekend if you are in the US...  I ran the test with V4 and
got the panic below.

Is this similar to what you see?  If so I'll work on it in V4.  FWIW with '-o
dax' specified I don't see how fsstress is causing an issue with my patch set.
Does fsstress attempt to change dax states?  I don't see that in the test but
I'm not real familiar with generic/013 and fsstress.

If my disassembly of read_pages is correct it looks like readpage is null which
makes sense because all files should be IS_DAX() == true due to the mount option...

But tracing code indicates that the patch:

	fs: remove unneeded IS_DAX() check

... may be the culprit and the following fix may work...

diff --git a/mm/filemap.c b/mm/filemap.c
index 3a7863ba51b9..7eaf74a2a39b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2257,7 +2257,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
        if (!count)
                goto out; /* skip atime */
 
-       if (iocb->ki_flags & IOCB_DIRECT) {
+       if (iocb->ki_flags & IOCB_DIRECT || IS_DAX(inode)) {
                struct file *file = iocb->ki_filp;
                struct address_space *mapping = file->f_mapping;
                struct inode *inode = mapping->host;

And of course now my server is not responding so I can't reboot to test it...
:-(

I'll continue tomorrow after I go press the power button on the machine since
IPMI has decided not to work...  :-(

Ira

[ 1204.461801] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 1204.472375] #PF: supervisor instruction fetch in kernel mode
[ 1204.481440] #PF: error_code(0x0010) - not-present page
[ 1204.489920] PGD 80000003c273d067 P4D 80000003c273d067 PUD 36a73b067 PMD 0 
[ 1204.500396] Oops: 0010 [#1] SMP KASAN PTI
[ 1204.507617] CPU: 6 PID: 15714 Comm: fsstress Not tainted 5.5.0-next-20200207+ #1
[ 1204.518632] Hardware name: Intel Corporation SandyBridge Platform/00, BIOS SE5C600.86B.02.04.0003.102320141138 10/23/2014
[ 1204.533715] RIP: 0010:0x0
[ 1204.539444] Code: Bad RIP value.
[ 1204.545813] RSP: 0018:ffff88837dedf528 EFLAGS: 00010246
[ 1204.554454] RAX: 0000000000000000 RBX: ffffea000cb6ae08 RCX: ffffffff813765fc
[ 1204.565223] RDX: dffffc0000000000 RSI: ffffea000cb6ae00 RDI: ffff8887b032a800
[ 1204.575943] RBP: ffff88837dedf618 R08: fffff9400196d5c1 R09: fffff9400196d5c1
[ 1204.586657] R10: fffff9400196d5c0 R11: ffffea000cb6ae07 R12: ffffea000cb6ae00
[ 1204.597362] R13: ffffffffa0ac3da0 R14: 0000000000000000 R15: ffff888342a14040
[ 1204.608061] FS:  00007fc47c0a8b80(0000) GS:ffff8883c7100000(0000) knlGS:0000000000000000
[ 1204.619869] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1204.629010] CR2: ffffffffffffffd6 CR3: 0000000325892002 CR4: 00000000000606e0
[ 1204.639695] Call Trace:
[ 1204.645128]  read_pages+0x23d/0x2f0
[ 1204.651691]  ? read_cache_pages+0x2b0/0x2b0
[ 1204.659030]  ? policy_node+0x56/0x60
[ 1204.665675]  __do_page_cache_readahead+0x28b/0x2b0
[ 1204.673641]  ? read_pages+0x2f0/0x2f0
[ 1204.680286]  ondemand_readahead+0x2bf/0x5d0
[ 1204.687561]  generic_file_buffered_read+0x992/0x1170
[ 1204.695703]  ? read_cache_page_gfp+0x20/0x20
[ 1204.703052]  ? down_read_nested+0x10b/0x2d0
[ 1204.710266]  ? downgrade_write+0x270/0x270
[ 1204.717399]  ? lock_acquire+0x101/0x200
[ 1204.724171]  ? generic_file_splice_read+0x20d/0x350
[ 1204.732067]  ? generic_file_read_iter+0x3b/0x220
[ 1204.739736]  ? xfs_file_buffered_aio_read+0x87/0x1d0 [xfs]
[ 1204.748351]  xfs_file_buffered_aio_read+0x92/0x1d0 [xfs]
[ 1204.756759]  xfs_file_read_iter+0x120/0x1f0 [xfs]
[ 1204.764420]  generic_file_splice_read+0x239/0x350
[ 1204.772072]  ? pipe_to_user+0x80/0x80
[ 1204.778476]  splice_direct_to_actor+0x1d8/0x460
[ 1204.785831]  ? pipe_to_sendpage+0x1a0/0x1a0
[ 1204.792769]  ? do_splice_to+0xc0/0xc0
[ 1204.799144]  ? selinux_file_permission+0x1d2/0x210
[ 1204.806734]  do_splice_direct+0x10c/0x170
[ 1204.813393]  ? splice_direct_to_actor+0x460/0x460
[ 1204.820830]  ? debug_lockdep_rcu_enabled+0x23/0x60
[ 1204.828349]  ? __sb_start_write+0x12c/0x1f0
[ 1204.835177]  vfs_copy_file_range+0x309/0x5c0
[ 1204.842085]  ? __x64_sys_sendfile+0x160/0x160
[ 1204.849039]  ? from_kgid+0xa0/0xa0
[ 1204.854879]  ? _copy_to_user+0x6a/0x80
[ 1204.861067]  ? cp_new_stat+0x271/0x2c0
[ 1204.867238]  ? __ia32_sys_lstat+0x30/0x30
[ 1204.873672]  ? down_read_non_owner+0x2e0/0x2e0
[ 1204.880579]  __x64_sys_copy_file_range+0x17a/0x310
[ 1204.887844]  ? __ia32_sys_copy_file_range+0x320/0x320
[ 1204.895369]  ? lockdep_hardirqs_off+0x1a/0x140
[ 1204.902142]  do_syscall_64+0x78/0x300
[ 1204.908056]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1204.915507] RIP: 0033:0x7fc47c1a1d6d
[ 1204.921283] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d eb 80 0c 00 f7 d8 64 89 01 48
[ 1204.946109] RSP: 002b:00007ffd9cc4cc08 EFLAGS: 00000202 ORIG_RAX: 0000000000000146
[ 1204.956531] RAX: ffffffffffffffda RBX: 0000000000000047 RCX: 00007fc47c1a1d6d
[ 1204.966477] RDX: 0000000000000004 RSI: 00007ffd9cc4cc40 RDI: 0000000000000003
[ 1204.976394] RBP: 000000000061a35e R08: 000000000000f15b R09: 0000000000000000
[ 1204.986279] R10: 00007ffd9cc4cc48 R11: 0000000000000202 R12: 0000000000000003
[ 1204.996142] R13: 000000000000f15b R14: 00000000000326f7 R15: 0000000000159373
[ 1205.005983] Modules linked in: vfat fat isofs rfkill ib_isert
iscsi_target_mod ib_srpt target_core_mod ib_srp scsi_transport_srp opa_vnic
rpcrdma sunrpc rdma_ucm ib_iser ib_umad rdma_cm ib_ipoib iw_cm dax_pmem_compat
libiscsi iTCO_wdt device_dax nd_pmem ib_cm dax_pmem_core nd_btt
iTCO_vendor_support scsi_transport_iscsi snd_hda_codec_realtek
snd_hda_codec_generic ledtrig_audio sb_edac x86_pkg_temp_thermal
intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
snd_hda_intel hfi1 snd_intel_dspcfg snd_hda_codec snd_hda_core aesni_intel
snd_hwdep crypto_simd snd_pcm rdmavt snd_timer nd_e820 ib_uverbs cryptd
libnvdimm snd ib_core soundcore glue_helper ipmi_si mei_me ipmi_devintf pcspkr
mei i2c_i801 ipmi_msghandler lpc_ich mfd_core ioatdma wmi acpi_cpufreq
sch_fq_codel xfs libcrc32c mlx4_en sr_mod cdrom sd_mod t10_pi mgag200
drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm_vram_helper
drm_ttm_helper ahci ttm crc32c_intel libahci mlx4_core isci igb libsas drm
[ 1205.006047]  dca scsi_transport_sas firewire_ohci i2c_algo_bit firewire_core
crc_itu_t libata i2c_core dm_mod [last unloaded: mlx4_ib]
[ 1205.140277] CR2: 0000000000000000
[ 1205.146689] ---[ end trace cf133ac3f2876827 ]---

> 
> Cheers,
> Jeff
> 
