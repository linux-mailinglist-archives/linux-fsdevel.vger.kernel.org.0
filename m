Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9AE4478CF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 04:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbhKHDTz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 22:19:55 -0500
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:50818 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236662AbhKHDTy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 22:19:54 -0500
Received: from omf05.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id C956E18224D78;
        Mon,  8 Nov 2021 03:17:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id B9277B2794;
        Mon,  8 Nov 2021 03:17:08 +0000 (UTC)
Message-ID: <3b7c6fa1183d4567403382ae8ba439dcea4b7e02.camel@perches.com>
Subject: Re: [PATCH] fs: direct-io: use DIV_ROUND_UP helper macro for
 calculations
From:   Joe Perches <joe@perches.com>
To:     Wu Bo <wubo40@huawei.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com
Date:   Sun, 07 Nov 2021 19:17:07 -0800
In-Reply-To: <1636341011-6494-1-git-send-email-wubo40@huawei.com>
References: <1636341011-6494-1-git-send-email-wubo40@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.44
X-Stat-Signature: ndw9pmcxgpcfbqt7uqy5qzw839woauma
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: B9277B2794
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19tLtLHbtr+2ZitL8DuJErcokB8g3oR6L4=
X-HE-Tag: 1636341428-874963
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-11-08 at 11:10 +0800, Wu Bo wrote:
> Replace open coded divisor calculations with the DIV_ROUND_UP kernel
> macro for better readability.

A cocci file to convert these would be:

$ cat dru.cocci
@@
expression e1;
expression e2;
@@

-	(e1 + e2 - 1) / e1
+	DIV_ROUND_UP(e2, e1)

@@
expression e1;
expression e2;
@@

-	(e1 + e2 - 1) / e2
+	DIV_ROUND_UP(e1, e2)
$

If you are interested, there are definitely a few more opportunities
to use this DIV_ROUND_UP macro in the kernel:

$ git grep -P -n '\(\s*([\w\.\>\[\]\-]+)\s*\+\s*([\w\.\>\[\]\-]+)\s*-\s*1\s*\)\s*/\s*(?:\1|\2)\b'
arch/alpha/boot/tools/objstrip.c:260:	mem_size = ((mem_size + pad - 1) / pad) * pad;
arch/arm/mach-omap1/clock.c:371:	div = (p_rate + rate - 1) / rate;
arch/powerpc/kvm/book3s_hv_rm_mmu.c:109:	npages = (psize + PAGE_SIZE - 1) / PAGE_SIZE;
arch/powerpc/platforms/powermac/nvram.c:600:		nvram_mult = (s1 + NVRAM_SIZE - 1) / NVRAM_SIZE;
arch/powerpc/platforms/powernv/pci-ioda-tce.c:311:	entries_shift = (entries_shift + levels - 1) / levels;
arch/powerpc/platforms/powernv/pci-ioda.c:1854:	entries_shift = (entries_shift + levels - 1) / levels;
arch/powerpc/xmon/xmon.c:1957:	nflush = (nflush + L1_CACHE_BYTES - 1) / L1_CACHE_BYTES;
arch/sh/boot/romimage/mmcif-sh7724.c:71:	                      (no_bytes + SH_MMCIF_BBS - 1) / SH_MMCIF_BBS,
arch/um/os-Linux/process.c:250:	vec = calloc(1, (len + UM_KERN_PAGE_SIZE - 1) / UM_KERN_PAGE_SIZE);
arch/um/os-Linux/process.c:264:	for (i = 0; i < ((len + UM_KERN_PAGE_SIZE - 1) / UM_KERN_PAGE_SIZE); i++) {
arch/x86/boot/genimage.sh:129:		t=$((t + ((s+cluster-1)/cluster)*cluster))
block/blk-mq.h:364:	depth = max((bt->sb.depth + users - 1) / users, 4U);
crypto/jitterentropy.c:344:	for (i = 0; ((DATA_SIZE_BITS + bits - 1) / bits) > i; i++) {
crypto/tcrypt.c:117:	int np = (buflen + PAGE_SIZE - 1)/PAGE_SIZE;
drivers/block/null_blk/main.c:1468:		index = raw_smp_processor_id() / ((nr_cpu_ids + nullb->nr_queues - 1) / nullb->nr_queues);
drivers/block/xen-blkback/common.h:67:	((MAX_INDIRECT_SEGMENTS + SEGS_PER_INDIRECT_FRAME - 1)/SEGS_PER_INDIRECT_FRAME)
drivers/char/agp/generic.c:248:	scratch_pages = (page_count + ENTRIES_PER_PAGE - 1) / ENTRIES_PER_PAGE;
drivers/char/agp/generic.c:1165:	pages = (page_count + ENTRIES_PER_PAGE - 1) / ENTRIES_PER_PAGE;
drivers/crypto/caam/desc_constr.h:118:	u32 pdb_len = (pdb_bytes + CAAM_CMD_SZ - 1) / CAAM_CMD_SZ;
drivers/crypto/caam/desc_constr.h:132:	u32 pdb_len = (pdb_bytes + CAAM_CMD_SZ - 1) / CAAM_CMD_SZ;
drivers/crypto/caam/desc_constr.h:170:				(len + CAAM_CMD_SZ - 1) / CAAM_CMD_SZ);
drivers/dma/ppc4xx/adma.c:797:	slot_cnt = *slots_per_op = (src_cnt + XOR_MAX_OPS - 1)/XOR_MAX_OPS;
drivers/dma/ppc4xx/adma.c:881:	return (addr_count + XOR_MAX_OPS - 1) / XOR_MAX_OPS;
drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c:534:		(write_size + payload_size - 1) / payload_size;
drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c:537:		(read_size + payload_size - 1) / payload_size;
drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c:80:	unsigned int det_size_segments = (det_buffer_size_in_kbyte + DCN31_CRB_SEGMENT_SIZE_KB - 1) / DCN31_CRB_SEGMENT_SIZE_KB;
drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c:114:	unsigned int compbuf_size_segments = (compbuf_size_kb + DCN31_CRB_SEGMENT_SIZE_KB - 1) / DCN31_CRB_SEGMENT_SIZE_KB;
drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c:355:	l = (ax + wx - 1) / wx;
drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c:379:	l = (ax + wx - 1) / wx;
drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c:550:	l = (ax + wx - 1) / wx;
drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c:795:	L = (ax + wx - 1) / wx;
drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c:845:	L = (ax + wx - 1) / wx;
drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c:79:	return (val + factor - 1) / factor * factor;
drivers/gpu/drm/drm_scatter.c:103:	pages = (request->size + PAGE_SIZE - 1) / PAGE_SIZE;
drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.c:124:	high_pl = (max_vco_f + target_vco_f - 1) / target_vco_f;
drivers/gpu/drm/radeon/r100.c:2123:	hblocks = (h + block_height - 1) / block_height;
drivers/gpu/drm/radeon/r100.c:2124:	wblocks = (w + block_width - 1) / block_width;
drivers/gpu/drm/radeon/rv6xx_dpm.c:422:	return (unscaled_count + count_per_unit - 1) / count_per_unit;
drivers/gpu/drm/radeon/trinity_dpm.c:847:	val = (p + tp - 1) / tp;
drivers/gpu/drm/radeon/trinity_dpm.c:991:	ni = (p + tp - 1) / tp;
drivers/gpu/drm/savage/savage_bci.c:396:		    (n + SAVAGE_DMA_PAGE_SIZE - 1) / SAVAGE_DMA_PAGE_SIZE;
drivers/infiniband/hw/bnxt_re/qplib_fp.c:1814:				pkt_num = (data_len + qp->mtu - 1) / qp->mtu;
drivers/infiniband/hw/bnxt_re/qplib_fp.c:1836:			pkt_num = (data_len + qp->mtu - 1) / qp->mtu;
drivers/infiniband/hw/bnxt_re/qplib_fp.c:1855:			pkt_num = (data_len + qp->mtu - 1) / qp->mtu;
drivers/infiniband/hw/hns/hns_roce_hem.c:1137:				total += (r->count + step - 1) / step;
drivers/infiniband/hw/mthca/mthca_allocator.c:231:		npages     = (size + PAGE_SIZE - 1) / PAGE_SIZE;
drivers/infiniband/hw/mthca/mthca_allocator.c:296:		for (i = 0; i < (size + PAGE_SIZE - 1) / PAGE_SIZE; ++i)
drivers/infiniband/hw/qib/qib_iba7322.c:1323:	u32 regcnt = (piobcnt + BITS_PER_LONG - 1) / BITS_PER_LONG;
drivers/infiniband/sw/rdmavt/mr.c:100:	m = (count + RVT_SEGSZ - 1) / RVT_SEGSZ;
drivers/infiniband/sw/rdmavt/mr.c:244:	m = (count + RVT_SEGSZ - 1) / RVT_SEGSZ;
drivers/infiniband/sw/rxe/rxe_mr.c:128:	num_map = (num_buf + RXE_BUF_PER_MAP - 1) / RXE_BUF_PER_MAP;
drivers/md/dm-integrity.c:1792:					s = sector - ((r + ic->tag_size - 1) / ic->tag_size);
drivers/md/raid1-10.c:4:#define RESYNC_PAGES ((RESYNC_BLOCK_SIZE + PAGE_SIZE-1) / PAGE_SIZE)
drivers/md/raid5.c:499:	nr_pages = (disks + cnt - 1) / cnt;
drivers/media/common/cx2341x.c:431:		params->video_gop_size = b * ((gop + b - 1) / b);
drivers/media/common/cx2341x.c:440:		params->video_gop_size = b * ((gop + b - 1) / b);
drivers/media/common/cx2341x.c:1332:		gop = b * ((gop + b - 1) / b);
drivers/media/common/saa7146/saa7146_core.c:166:	int pages = (length+PAGE_SIZE-1)/PAGE_SIZE;
drivers/media/i2c/ccs/ccs-core.c:1426:	 * w = (x + a - 1) / a
drivers/media/pci/ivtv/ivtv-irq.c:197:		bytes_needed = s->buf_size * ((bytes_needed + s->buf_size - 1) / s->buf_size);
drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c:772:	width_lcu_num = (width + lcu_size - 1) / lcu_size;
drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c:773:	height_lcu_num = (height + lcu_size - 1) / lcu_size;
drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c:980:			((width + SYSTEM_LAL_TILE10 - 1) / SYSTEM_LAL_TILE10) *
drivers/media/test-drivers/vivid/vivid-radio-rx.c:205:		freq = spacing * ((freq + spacing - 1) / spacing) - spacing;
drivers/media/test-drivers/vivid/vivid-radio-rx.c:209:			freq = spacing * ((high + spacing - 1) / spacing) - spacing;
drivers/memory/mvebu-devbus.c:101:	*ticks = (time_ps + devbus->tick_ps - 1) / devbus->tick_ps;
drivers/memory/omap-gpmc.c:347:	return (time_ps + tick_ps - 1) / tick_ps;
drivers/memory/omap-gpmc.c:1488:	temp = (temp + div - 1) / div;
drivers/mtd/tests/stresstest.c:104:	len = ((len + pgsize - 1) / pgsize) * pgsize;
drivers/net/arcnet/rfc1201.c:495:		out->numsegs = (out->dataleft + maxsegsize - 1) / maxsegsize;
drivers/net/dsa/sja1105/sja1105_ptp.h:21: * is in fact precisely the floor value of "(a + b - 1) / b", which is
drivers/net/ethernet/atheros/atl1e/atl1e_main.c:1787:		seg_num = (buf_len + MAX_TX_BUF_LEN - 1) / MAX_TX_BUF_LEN;
drivers/net/ethernet/hisilicon/hns/hns_enet.c:252:	buf_num = (size + BD_MAX_SEND_SIZE - 1) / BD_MAX_SEND_SIZE;
drivers/net/ethernet/hisilicon/hns/hns_enet.c:258:		buf_num += (size + BD_MAX_SEND_SIZE - 1) / BD_MAX_SEND_SIZE;
drivers/net/ethernet/hisilicon/hns/hns_enet.c:262:		buf_num = (skb->len + BD_MAX_SEND_SIZE - 1) / BD_MAX_SEND_SIZE;
drivers/net/ethernet/hisilicon/hns/hns_enet.c:288:	frag_buf_num = (size + BD_MAX_SEND_SIZE - 1) / BD_MAX_SEND_SIZE;
drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:1296:		(num_sqbs + hw->stack_pg_ptrs - 1) / hw->stack_pg_ptrs;
drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:1354:		(num_ptrs + hw->stack_pg_ptrs - 1) / hw->stack_pg_ptrs;
drivers/net/vmxnet3/vmxnet3_drv.c:2916:		adapter->rx_buf_per_pkt = 1 + (sz + PAGE_SIZE - 1) / PAGE_SIZE;
drivers/net/vmxnet3/vmxnet3_drv.c:2925:	ring0_size = (ring0_size + sz - 1) / sz * sz;
drivers/net/vmxnet3/vmxnet3_drv.c:2929:	ring1_size = (ring1_size + sz - 1) / sz * sz;
drivers/net/vmxnet3/vmxnet3_ethtool.c:648:	new_rx_ring_size = (param->rx_pending + sz - 1) / sz * sz;
drivers/net/wireless/ath/ath9k/xmit.c:1079:	nsymbols = (nbits + nsymbits - 1) / nsymbits;
drivers/net/wireless/broadcom/b43/phy_lp.c:2562:	if ((tmp4 + tmp3 - 1) / tmp3 > 60) {
drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c:671:		dur = (mac_len + rate - 1) / rate;
drivers/net/wireless/intel/ipw2x00/ipw2200.c:3234:		nr = (chunk_len + CB_MAX_LENGTH - 1) / CB_MAX_LENGTH;
drivers/net/wireless/marvell/mwifiex/sdio.c:2307:	buf_block_len = (pkt_len + blk_size - 1) / blk_size;
drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:4206:	val8 = ((30000 + NAV_UPPER_UNIT - 1) / NAV_UPPER_UNIT);
drivers/net/wireless/realtek/rtlwifi/wifi.h:2902:	(__value) : (((__value + __aligment - 1) / __aligment) * __aligment))
drivers/net/wireless/ti/wl12xx/main.c:1291:	return (align_len + blk_size - 1) / blk_size + spare_blks;
drivers/net/wireless/ti/wl18xx/main.c:1069:	return (len + blk_size - 1) / blk_size + spare_blks;
drivers/pinctrl/bcm/pinctrl-iproc-gpio.c:836:	chip->num_banks = (ngpios + NGPIOS_PER_BANK - 1) / NGPIOS_PER_BANK;
drivers/ps3/ps3av.c:191:	timeout = (timeout + POLLING_INTERVAL - 1) / POLLING_INTERVAL;
drivers/scsi/aic94xx/aic94xx_hwi.c:378:	seq->num_escbs = (edbs+ASD_EDBS_PER_SCB-1)/ASD_EDBS_PER_SCB;
drivers/scsi/aic94xx/aic94xx_seq.c:212:	int pages =  (size + LSEQ_CODEPAGE_SIZE - 1) / LSEQ_CODEPAGE_SIZE;
drivers/scsi/aic94xx/aic94xx_seq.c:276:	const int pages = (size + MAX_DMA_OVLY_COUNT - 1) / MAX_DMA_OVLY_COUNT;
drivers/scsi/be2iscsi/be_main.h:149:	((x < PAGE_SIZE) ? 1 :  ((x + PAGE_SIZE - 1) / PAGE_SIZE))
drivers/scsi/bnx2fc/bnx2fc_hwi.c:649:		num_rq = (frame_len + BNX2FC_RQ_BUF_SZ - 1) / BNX2FC_RQ_BUF_SZ;
drivers/scsi/cxgbi/libcxgbi.c:2089:	num_pdu = (count + max_pdu_len - 1) / max_pdu_len;
drivers/scsi/lpfc/lpfc_init.c:8272:	longs = (LPFC_SLI4_FCF_TBL_INDX_MAX + BITS_PER_LONG - 1)/BITS_PER_LONG;
drivers/scsi/lpfc/lpfc_sli.c:7162:		longs = (count + BITS_PER_LONG - 1) / BITS_PER_LONG;
drivers/scsi/lpfc/lpfc_sli.c:7190:		longs = (count + BITS_PER_LONG - 1) / BITS_PER_LONG;
drivers/scsi/lpfc/lpfc_sli.c:7217:		longs = (count + BITS_PER_LONG - 1) / BITS_PER_LONG;
drivers/scsi/lpfc/lpfc_sli.c:7246:		longs = (count + BITS_PER_LONG - 1) / BITS_PER_LONG;
drivers/scsi/ncr53c8xx.c:3779:	else				np->minsync = (period + 40 - 1) / 40;
drivers/scsi/sym53c8xx_2/sym_hipd.c:734:	else				np->minsync = (period + 40 - 1) / 40;
drivers/spi/spi-coldfire-qspi.c:134:	return clamp((MCFQSPI_BUSCLK + speed_hz - 1) / speed_hz, 2u, 255u);
drivers/spi/spi-omap2-mcspi.c:915:		div = (OMAP2_MCSPI_MAX_FREQ + speed_hz - 1) / speed_hz;
drivers/staging/r8188eu/include/basic_types.h:121:	(__value) : (((__value + __aligment - 1) / __aligment) * __aligment))
drivers/staging/rtl8723bs/include/basic_types.h:191:#define N_BYTE_ALIGMENT(__Value, __Aligment) ((__Aligment == 1) ? (__Value) : (((__Value + __Aligment - 1) / __Aligment) * __Aligment))
drivers/target/iscsi/cxgbit/cxgbit_target.c:409:		num_pdu = (data_length + mrdsl - 1) / mrdsl;
drivers/usb/dwc2/hcd_ddma.c:85:	       (qh->host_interval + 8 - 1) / 8 : qh->host_interval;
drivers/usb/dwc2/hcd_ddma.c:284:		inc = (8 + qh->host_interval - 1) / qh->host_interval;
drivers/usb/host/oxu210hp-hcd.c:922:	n_blocks = (len + BUFFER_SIZE - 1) / BUFFER_SIZE;
drivers/video/fbdev/matrox/matroxfb_g450.c:308:	r->regs[0x09] = (outd->burst + pixclock - 1) / pixclock;	/* burst length */
drivers/video/fbdev/omap/hwa742.c:633:	return (ps + bus_tick - 1) / bus_tick * bus_tick;
drivers/video/fbdev/omap/lcdc.c:443:	*pck_div = (lck + pck - 1) / pck;
drivers/video/fbdev/omap/sossi.c:115:	return (clk_period + ps - 1) / clk_period;
fs/afs/dir.c:313:	nr_pages = (i_size + PAGE_SIZE - 1) / PAGE_SIZE;
fs/cachefiles/io.c:325:	if (cachefiles_has_space(cache, 0, (subreq->len + PAGE_SIZE - 1) / PAGE_SIZE) == 0)
fs/cifs/smbdirect.c:2058:				nvecs = (buflen+max_iov_size-1)/max_iov_size;
fs/cifs/smbdirect.c:2111:		nvecs = (buflen + max_iov_size - 1) / max_iov_size;
fs/direct-io.c:197:		sdio->tail = (ret + PAGE_SIZE - 1) / PAGE_SIZE;
fs/ext4/fast_commit.c:1166:	fc_bufs_before = (sbi->s_fc_bytes + bsize - 1) / bsize;
fs/ext4/fast_commit.c:1173:	nblks = (sbi->s_fc_bytes + bsize - 1) / bsize - fc_bufs_before;
fs/nfs/nfs4renewd.c:124:			__func__, (timeout + HZ - 1) / HZ);
fs/ocfs2/cluster/heartbeat.c:1689:	reg->hr_num_pages = (reg->hr_blocks + spp - 1) / spp;
fs/xfs/libxfs/xfs_attr_remote.c:56:		return (attrlen + buflen - 1) / buflen;
fs/xfs/libxfs/xfs_bmap.c:87:	maxblocks = (maxleafents + minleafrecs - 1) / minleafrecs;
fs/xfs/libxfs/xfs_bmap.c:92:			maxblocks = (maxblocks + minnoderecs - 1) / minnoderecs;
fs/xfs/libxfs/xfs_symlink_remote.c:32:	return (pathlen + buflen - 1) / buflen;
fs/xfs/xfs_log_cil.c:470:		split_res = (len + iclog_space - 1) / iclog_space;
include/linux/mpi.h:53:	return mpi_alloc((nbits + BITS_PER_MPI_LIMB - 1) / BITS_PER_MPI_LIMB);
include/linux/sunrpc/svc.h:182:#define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE \
kernel/debug/kdb/kdb_main.c:1718:		z = (z + num - 1) / num;
kernel/rcu/rcu.h:305:			levelspread[i] = (cprv + ccur - 1) / ccur;
kernel/rcu/rcutorture.c:2258:	sd4 = (sd + fwd_progress_div - 1) / fwd_progress_div;
kernel/time/posix-cpu-timers.c:159:		tp->tv_nsec = ((NSEC_PER_SEC + HZ - 1) / HZ);
kernel/watch_queue.c:261:	bmsize = (nr_notes + BITS_PER_LONG - 1) / BITS_PER_LONG;
lib/mpi/ec.c:197:#define LIMB_SIZE_25519 ((256+BITS_PER_MPI_LIMB-1)/BITS_PER_MPI_LIMB)
lib/mpi/ec.c:303:#define LIMB_SIZE_448 ((448+BITS_PER_MPI_LIMB-1)/BITS_PER_MPI_LIMB)
lib/mpi/mpicoder.c:143:	nlimbs = (nbytes+BYTES_PER_MPI_LIMB-1) / BYTES_PER_MPI_LIMB;
lib/zlib_deflate/deflate.c:259:    s->hash_shift =  ((s->hash_bits+MIN_MATCH-1)/MIN_MATCH);
net/ipv4/tcp_input.c:1053:		tp->reordering = min_t(u32, (metric + mss - 1) / mss,
net/sunrpc/auth_gss/gss_krb5_crypto.c:670:	nblocks = (nbytes + blocksize - 1) / blocksize;
net/sunrpc/auth_gss/gss_krb5_crypto.c:753:	nblocks = (subbuf.len + blocksize - 1) / blocksize;
sound/isa/sb/emu8000_pcm.c:239:				     (1000000 + HZ - 1) / HZ, UINT_MAX);
sound/soc/sh/rcar/core.c:1579:					(io->converted_rate + k_up - 1) / k_up;
sound/soc/sh/rcar/core.c:1581:					(io->converted_rate + k_up - 1) / k_up;
sound/soc/ti/davinci-mcasp.c:872:		max_active_serializers = (channels + slots - 1) / slots;
sound/soc/ti/davinci-mcasp.c:1017:		active_serializers = (channels + total_slots - 1) / total_slots;
tools/bpf/bpftool/gen.c:184:		align_off = (off + align - 1) / align * align;
tools/io_uring/io_uring-bench.c:140:	return (DEPTH + s->nr_files - 1) / s->nr_files;
tools/lib/bpf/linker.c:1115:	dst_align_sz = (dst->sec_sz + dst_align - 1) / dst_align * dst_align;
tools/lib/subcmd/help.c:119:	rows = (cmds->cnt + cols - 1) / cols;
tools/testing/selftests/bpf/prog_tests/core_reloc.c:804:	return (sz + page_size - 1) / page_size * page_size;
tools/testing/selftests/bpf/prog_tests/mmap.c:13:	return (sz + page_size - 1) / page_size * page_size;
tools/testing/selftests/net/forwarding/sch_red.sh:202:		local pkts=$(((diff + PKTSZ - 1) / PKTSZ))
tools/vm/page-types.c:943:			size, (size + page_size - 1) / page_size);


