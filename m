Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67CF6FEF08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 11:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbjEKJoo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 05:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjEKJom (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 05:44:42 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3802D57
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 02:44:39 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3064099f9b6so5405723f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 02:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683798278; x=1686390278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=meG0oRo/vN27fxl4oLhvET+2U2v046u31Qy4LE2bZL4=;
        b=SiOAPH6tN/FsFoQjvqQJYheNFQtrSKVH9elPawxzfEJTrZYVrKDTZs8jAu58j/8LIb
         VFiD8XuiIjN8Ak3ptgdG2Swedu1FYws3r5+qlcgTZtI2uFVKV4CQJxOUtI5/YaMmwhSN
         MwnyA4wA/u99be1/3qyVesaxKwIdoTRRkMkdNLRee6iJtxqpVKln98ybkekJDEE924KN
         /T9/1Ykx1cc2f9EIDT8Sgd3gkx2jp0Vpp4urqi08YjM0bBR7t0P5MuvQLnLxvhDpc1WQ
         f97u6ZImmDWLrseLJuZ/7W2lSuIPK+hTVvz8p4Me6zixCm/aV+ODM3y6VpU8wkoF0C4n
         lpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683798278; x=1686390278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meG0oRo/vN27fxl4oLhvET+2U2v046u31Qy4LE2bZL4=;
        b=HkpYCylk7MaaIj6zLapvyhr5r3dsf/EceholhaQB61rPv2M8bRkiEgN8D/+vgeVBVl
         vKoBm/Ua0JJMrub6dfMywjOuhyjjk48OnrFwMwwFGZZuK52Q3OayXZagc0SXlDZAVH2q
         h3Yk+9Xx7DOUDZ/2A1+uJVAl0k1xcxY0lMaQXnjO0wZ6IpFpECo8NSkEuOpB6TrbByCg
         txUHTFuGl3TfquXatUox7kVUNVsS/x2mlyn8QlYxHggDvrmdwpVNiddGmmzjwiFObhlm
         qyMozzfTcf4Hw6JHS4ieV8CiOJhsSxgBl8NbUd9ywu0ZiEAS5ia+AxK9wwlxX/ceobbl
         Df2w==
X-Gm-Message-State: AC+VfDz1XEDwUTBG7mKKWYPvDFnkUoFBst2eshnCPUQrSL8zwQmTWM3S
        BQ+gRBWdxPFWJk2f+bQt4HLwSA==
X-Google-Smtp-Source: ACHHUZ6gnTqxwbuDJzdAPJeg4AcDeGam/c5xOoqaVRBn9RYBRv3jLgslNaRy45dMXghJ2aqhXXahWg==
X-Received: by 2002:a5d:4151:0:b0:2ce:d84d:388f with SMTP id c17-20020a5d4151000000b002ced84d388fmr15567990wrq.40.1683798278341;
        Thu, 11 May 2023 02:44:38 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p6-20020adfe606000000b002e5f6f8fc4fsm19969768wrm.100.2023.05.11.02.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 02:44:35 -0700 (PDT)
Date:   Thu, 11 May 2023 12:44:32 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH] filemap: Handle error return from __filemap_get_folio()
Message-ID: <c29d169d-b560-40da-8f0f-4d21d6193070@kili.mountain>
References: <20230506160415.2992089-1-willy@infradead.org>
 <CAHk-=winrN4jsysShx0kWKVzmSMu7Pp3nz_6+aps9CP+v-qHWQ@mail.gmail.com>
 <CAHk-=winai-5i6E1oMk7hXPfbP+SCssk5+TOLCJ3koaDrn7Bzg@mail.gmail.com>
 <CAHk-=wiZ0GaAdqyke-egjBRaqP-QdLcX=8gNk7m6Hx7rXjcXVQ@mail.gmail.com>
 <CAHk-=whfNqsZVjy1EWAA=h7D0K2o4D8MSdnK8Qytj2BBhhFrSQ@mail.gmail.com>
 <CAHk-=wjzs7jHyp_SmT6h1Hnwu39Vuc0DuUxndwf2kL3zhyiCcw@mail.gmail.com>
 <20230506104122.e9ab27f59fd3d8294cb1356d@linux-foundation.org>
 <7bd22265-f46c-4347-a856-eecd1429dcce@kili.mountain>
 <d98acf2e-04bd-4824-81e4-64e91a26537c@kili.mountain>
 <CAHk-=whD=py2eMXFNOEQyDUobAXBJ3O0eFAG6yjC=EN4iZrhKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Cjk7ib2uiyLsi2F2"
Content-Disposition: inline
In-Reply-To: <CAHk-=whD=py2eMXFNOEQyDUobAXBJ3O0eFAG6yjC=EN4iZrhKw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Cjk7ib2uiyLsi2F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Tue, May 09, 2023 at 10:37:12AM -0700, Linus Torvalds wrote:
> In fs/btrfs/extent_io.c, we have
> 
>     while (index <= end_index) {
>         folio = filemap_get_folio(mapping, index);
>         filemap_dirty_folio(mapping, folio);
> 

I have re-worked the Smatch check for warnings about dereferencing
error pointer so now it warns about that:

fs/btrfs/extent_io.c:224 extent_range_redirty_for_io() error: 'folio' dereferencing possible ERR_PTR()

I've also made a list of functions which don't necessarily need to be
checked so it's easy to silence false positives now.
https://github.com/error27/smatch/blob/master/check_err_ptr_deref.c

regards,
dan carpenter



--Cjk7ib2uiyLsi2F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=err-list

block/partitions/core.c:578 blk_add_partition() error: 'part' dereferencing possible ERR_PTR()
drivers/base/firmware_loader/main.c:820 fw_log_firmware_info() error: 'alg' dereferencing possible ERR_PTR()
drivers/cpufreq/imx6q-cpufreq.c:483 imx6q_cpufreq_probe() error: 'opp' dereferencing possible ERR_PTR()
drivers/cpufreq/imx6q-cpufreq.c:486 imx6q_cpufreq_probe() error: 'opp' dereferencing possible ERR_PTR()
drivers/crypto/caam/caamalg_qi2.c:1289 aead_encrypt_done() error: 'req_ctx' dereferencing possible ERR_PTR()
drivers/crypto/caam/caamalg_qi2.c:1310 aead_decrypt_done() error: 'req_ctx' dereferencing possible ERR_PTR()
drivers/crypto/caam/caamalg_qi2.c:1398 skcipher_encrypt_done() error: 'req_ctx' dereferencing possible ERR_PTR()
drivers/crypto/caam/caamalg_qi2.c:1436 skcipher_decrypt_done() error: 'req_ctx' dereferencing possible ERR_PTR()
drivers/crypto/sa2ul.c:1056 sa_aes_dma_in_callback() error: 'mdptr' dereferencing possible ERR_PTR()
drivers/crypto/sa2ul.c:1275 sa_run() error: 'mdptr' dereferencing possible ERR_PTR()
drivers/crypto/sa2ul.c:1372 sa_sha_dma_in_callback() error: 'mdptr' dereferencing possible ERR_PTR()
drivers/crypto/sa2ul.c:1711 sa_aead_dma_in_callback() error: 'mdptr' dereferencing possible ERR_PTR()
drivers/crypto/sa2ul.c:1714 sa_aead_dma_in_callback() error: 'mdptr' dereferencing possible ERR_PTR()
drivers/crypto/sa2ul.c:1721 sa_aead_dma_in_callback() error: 'mdptr' dereferencing possible ERR_PTR()
drivers/devfreq/mtk-cci-devfreq.c:388 mtk_ccifreq_probe() error: 'drv->sram_reg' dereferencing possible ERR_PTR()
drivers/gpio/gpiolib.c:332 gpio_name_to_desc() error: 'desc' dereferencing possible ERR_PTR()
drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c:265 komeda_component_get_avail_scaler() error: 'pipe_st' dereferencing possible ERR_PTR()
drivers/gpu/drm/exynos/exynos_hdmi.c:1864 hdmi_bind() error: 'crtc' dereferencing possible ERR_PTR()
drivers/gpu/drm/imx/lcdc/imx-lcdc.c:408 imx_lcdc_probe() error: 'lcdc' dereferencing possible ERR_PTR()
drivers/gpu/drm/kmb/kmb_drv.c:578 kmb_probe() error: 'kmb->kmb_dsi' dereferencing possible ERR_PTR()
drivers/gpu/drm/msm/adreno/a5xx_gpu.c:103 a5xx_submit_in_rb() error: 'ptr' dereferencing possible ERR_PTR()
drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c:107 pingpong_tearcheck_disable() error: 'mixer' dereferencing possible ERR_PTR()
drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c:28 pingpong_tearcheck_setup() error: 'mixer' dereferencing possible ERR_PTR()
drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c:81 pingpong_tearcheck_enable() error: 'mixer' dereferencing possible ERR_PTR()
drivers/gpu/drm/sun4i/sun4i_backend.c:493 sun4i_backend_atomic_check() error: 'plane_state' dereferencing possible ERR_PTR()
drivers/gpu/drm/tegra/nvdec.c:284 nvdec_load_falcon_firmware() error: 'nvdec->falcon.firmware.virt' dereferencing possible ERR_PTR()
drivers/gpu/drm/tests/drm_client_modeset_test.c:71 drm_client_modeset_test_init() error: 'priv->drm' dereferencing possible ERR_PTR()
drivers/gpu/drm/tests/drm_managed_test.c:44 drm_test_managed_run_action() error: 'drm' dereferencing possible ERR_PTR()
drivers/gpu/drm/tests/drm_managed_test.c:47 drm_test_managed_run_action() error: 'drm' dereferencing possible ERR_PTR()
drivers/gpu/drm/tests/drm_managed_test.c:50 drm_test_managed_run_action() error: 'drm' dereferencing possible ERR_PTR()
drivers/gpu/drm/tests/drm_probe_helper_test.c:52 drm_probe_helper_test_init() error: 'priv->drm' dereferencing possible ERR_PTR()
drivers/gpu/drm/vc4/tests/vc4_mock.c:173 __mock_device() error: 'vc4' dereferencing possible ERR_PTR()
drivers/gpu/drm/vc4/tests/vc4_mock.c:174 __mock_device() error: 'vc4' dereferencing possible ERR_PTR()
drivers/gpu/drm/vc4/tests/vc4_mock.c:176 __mock_device() error: 'vc4' dereferencing possible ERR_PTR()
drivers/gpu/drm/vc4/tests/vc4_mock.c:177 __mock_device() error: 'vc4' dereferencing possible ERR_PTR()
drivers/iio/adc/ad7949.c:387 ad7949_spi_probe() error: 'ad7949_adc->vref' dereferencing possible ERR_PTR()
drivers/infiniband/core/uverbs_std_types_counters.c:110 ib_uverbs_handler_UVERBS_METHOD_COUNTERS_READ() error: 'uattr' dereferencing possible ERR_PTR()
drivers/iommu/apple-dart.c:879 apple_dart_device_group() error: 'group' dereferencing possible ERR_PTR()
drivers/iommu/arm/arm-smmu/arm-smmu-impl.c:226 arm_smmu_impl_init() error: 'smmu' dereferencing possible ERR_PTR()
drivers/md/bcache/btree.c:1510 btree_gc_rewrite_node() error: 'n' dereferencing possible ERR_PTR()
drivers/md/bcache/btree.c:1515 btree_gc_rewrite_node() error: 'n' dereferencing possible ERR_PTR()
drivers/media/i2c/tc358746.c:434 tc358746_apply_misc_config() error: 'fmt' dereferencing possible ERR_PTR()
drivers/media/i2c/tc358746.c:790 tc358746_set_fmt() error: 'fmt' dereferencing possible ERR_PTR()
drivers/media/i2c/tc358746.c:918 tc358746_link_validate() error: 'fmt' dereferencing possible ERR_PTR()
drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c:381 vdec_h264_slice_decode() error: 'dec_params' dereferencing possible ERR_PTR()
drivers/media/platform/st/stm32/stm32-dcmi.c:1035 dcmi_try_fmt() error: 'state' dereferencing possible ERR_PTR()
drivers/media/platform/st/stm32/stm32-dcmi.c:1196 dcmi_set_sensor_format() error: 'state' dereferencing possible ERR_PTR()
drivers/mmc/host/sdhci.c:4758 sdhci_setup_host() error: 'mmc->supply.vqmmc' dereferencing possible ERR_PTR()
drivers/mtd/ubi/fastmap.c:356 process_pool_aeb() error: 'av' dereferencing possible ERR_PTR()
drivers/mtd/ubi/vtbl.c:595 init_volumes() error: 'av' dereferencing possible ERR_PTR()
drivers/mtd/ubi/vtbl.c:745 check_attaching_info() error: 'av' dereferencing possible ERR_PTR()
drivers/mtd/ubi/vtbl.c:762 check_attaching_info() error: 'av' dereferencing possible ERR_PTR()
drivers/mtd/ubi/vtbl.c:765 check_attaching_info() error: 'av' dereferencing possible ERR_PTR()
drivers/mtd/ubi/vtbl.c:820 ubi_read_volume_table() error: 'av' dereferencing possible ERR_PTR()
drivers/net/ethernet/broadcom/bcmsysport.c:2343 bcm_sysport_map_queues() error: 'dp' dereferencing possible ERR_PTR()
drivers/net/ethernet/broadcom/bcmsysport.c:2395 bcm_sysport_unmap_queues() error: 'dp' dereferencing possible ERR_PTR()
drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c:204 cn10k_alloc_leaf_profile() error: 'rsp' dereferencing possible ERR_PTR()
drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:1756 otx2_get_max_mtu() error: 'rsp' dereferencing possible ERR_PTR()
drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c:321 otx2_config_priority_flow_ctrl() error: 'rsp' dereferencing possible ERR_PTR()
drivers/net/ethernet/marvell/octeontx2/nic/otx2_dmac_flt.c:204 otx2_dmacflt_update() error: 'rsp' dereferencing possible ERR_PTR()
drivers/net/ethernet/marvell/octeontx2/nic/otx2_dmac_flt.c:31 otx2_dmacflt_do_add() error: 'rsp' dereferencing possible ERR_PTR()
drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c:1070 otx2_set_fecparam() error: 'rsp' dereferencing possible ERR_PTR()
drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c:333 otx2_get_pauseparam() error: 'rsp' dereferencing possible ERR_PTR()
drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:125 otx2_alloc_mcam_entries() error: 'rsp' dereferencing possible ERR_PTR()
drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:203 otx2_mcam_entry_init() error: 'rsp' dereferencing possible ERR_PTR()
drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:238 otx2_mcam_entry_init() error: 'frsp' dereferencing possible ERR_PTR()
drivers/net/ethernet/mediatek/mtk_eth_soc.c:3198 mtk_device_event() error: 'dp' dereferencing possible ERR_PTR()
drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:1082 esw_add_fdb_peer_miss_rules() error: 'vport' dereferencing possible ERR_PTR()
drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:1094 esw_add_fdb_peer_miss_rules() error: 'vport' dereferencing possible ERR_PTR()
drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:1124 esw_add_fdb_peer_miss_rules() error: 'vport' dereferencing possible ERR_PTR()
drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:1129 esw_add_fdb_peer_miss_rules() error: 'vport' dereferencing possible ERR_PTR()
drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:1152 esw_del_fdb_peer_miss_rules() error: 'vport' dereferencing possible ERR_PTR()
drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:1157 esw_del_fdb_peer_miss_rules() error: 'vport' dereferencing possible ERR_PTR()
drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:2606 esw_unset_master_egress_rule() error: 'vport' dereferencing possible ERR_PTR()
drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:3388 esw_offloads_devlink_ns_eq_netdev_ns() error: 'esw' dereferencing possible ERR_PTR()
drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v0.c:1683 dr_ste_v0_build_src_gvmi_qpn_tag() error: 'vport_cap' dereferencing possible ERR_PTR()
drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v1.c:2014 dr_ste_v1_build_src_gvmi_qpn_tag() error: 'vport_cap' dereferencing possible ERR_PTR()
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:8506 __mlxsw_sp_port_vlan_router_join() error: 'fid' dereferencing possible ERR_PTR()
drivers/net/ethernet/sfc/mae.c:606 efx_mae_lookup_mport() error: 'm' dereferencing possible ERR_PTR()
drivers/net/ethernet/sfc/tc.c:454 efx_tc_flower_record_encap_match() error: 'old' dereferencing possible ERR_PTR()
drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:5405 stmmac_rx() error: 'skb' dereferencing possible ERR_PTR()
drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:5417 stmmac_rx() error: 'skb' dereferencing possible ERR_PTR()
drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:5435 stmmac_rx() error: 'skb' dereferencing possible ERR_PTR()
drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c:1003 brcmf_chip_recognition() error: 'core' dereferencing possible ERR_PTR()
drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c:1006 brcmf_chip_recognition() error: 'core' dereferencing possible ERR_PTR()
drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c:1009 brcmf_chip_recognition() error: 'core' dereferencing possible ERR_PTR()
drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c:1012 brcmf_chip_recognition() error: 'core' dereferencing possible ERR_PTR()
drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c:1015 brcmf_chip_recognition() error: 'core' dereferencing possible ERR_PTR()
drivers/nfc/pn533/pn533.c:1422 pn533_autopoll_complete() error: 'resp' dereferencing possible ERR_PTR()
drivers/nfc/pn533/pn533.c:1519 pn533_poll_complete() error: 'resp' dereferencing possible ERR_PTR()
drivers/nfc/pn533/pn533.c:1524 pn533_poll_complete() error: 'resp' dereferencing possible ERR_PTR()
drivers/phy/sunplus/phy-sunplus-usb2.c:92 update_disc_vol() error: 'cell' dereferencing possible ERR_PTR()
drivers/phy/tegra/xusb.c:703 tegra_xusb_setup_usb_role_switch() error: 'lane' dereferencing possible ERR_PTR()
drivers/platform/surface/surface3_power.c:552 mshw0011_probe() error: 'data->poll_task' dereferencing possible ERR_PTR()
drivers/regulator/core.c:5604 regulator_register() error: 'init_data' dereferencing possible ERR_PTR()
drivers/scsi/qla4xxx/ql4_os.c:6941 qla4xxx_sess_conn_setup() error: 'ep' dereferencing possible ERR_PTR()
drivers/soc/qcom/icc-bwmon.c:691 bwmon_intr_thread() error: 'target_opp' dereferencing possible ERR_PTR()
drivers/soc/qcom/socinfo.c:750 socinfo_debugfs_init() error: 'versions' dereferencing possible ERR_PTR()
drivers/thermal/rcar_thermal.c:498 rcar_thermal_probe() error: 'priv->zone' dereferencing possible ERR_PTR()
drivers/tty/serial/max310x.c:1621 max310x_i2c_probe() error: 'port_client' dereferencing possible ERR_PTR()
drivers/usb/gadget/function/uvc_v4l2.c:124 find_format_by_pix() error: 'fmtdesc' dereferencing possible ERR_PTR()
drivers/usb/gadget/function/uvc_v4l2.c:378 uvc_v4l2_enum_format() error: 'fmtdesc' dereferencing possible ERR_PTR()
drivers/usb/host/ehci-sched.c:1358 reserve_release_iso_bandwidth() error: 'tt' dereferencing possible ERR_PTR()
drivers/usb/host/ehci-sched.c:261 reserve_release_intr_bandwidth() error: 'tt' dereferencing possible ERR_PTR()
drivers/usb/host/max3421-hcd.c:1914 max3421_probe() error: 'max3421_hcd->spi_thread' dereferencing possible ERR_PTR()
drivers/video/fbdev/omap2/omapfb/displays/connector-analog-tv.c:220 tvc_probe() error: 'ddata->in' dereferencing possible ERR_PTR()
fs/btrfs/extent_io.c:224 extent_range_redirty_for_io() error: 'folio' dereferencing possible ERR_PTR()
fs/cifs/connect.c:2725 cifs_match_super() error: 'tlink' dereferencing possible ERR_PTR()
fs/hfs/brec.c:160 hfs_brec_insert() error: 'fd->bnode' dereferencing possible ERR_PTR()
fs/hfs/brec.c:437 hfs_brec_update_parent() error: 'fd->bnode' dereferencing possible ERR_PTR()
fs/hfsplus/brec.c:160 hfsplus_brec_insert() error: 'fd->bnode' dereferencing possible ERR_PTR()
fs/hfsplus/brec.c:441 hfs_brec_update_parent() error: 'fd->bnode' dereferencing possible ERR_PTR()
fs/ksmbd/smbacl.c:1296 smb_check_perm_dacl() error: 'posix_acls' dereferencing possible ERR_PTR()
fs/ksmbd/vfs.c:1323 ksmbd_vfs_make_xattr_posix_acl() error: 'posix_acls' dereferencing possible ERR_PTR()
fs/ksmbd/vfs.c:1830 ksmbd_vfs_inherit_posix_acl() error: 'acls' dereferencing possible ERR_PTR()
fs/namei.c:2898 path_pts() error: 'path->dentry' dereferencing possible ERR_PTR()
fs/nfs/blocklayout/rpc_pipefs.c:152 nfs4blocklayout_register_sb() error: 'dir' dereferencing possible ERR_PTR()
fs/nfs/cache_lib.c:122 nfs_cache_register_sb() error: 'dir' dereferencing possible ERR_PTR()
fs/nfsd/nfs4recover.c:942 nfsd4_cld_register_sb() error: 'dir' dereferencing possible ERR_PTR()
fs/nfs/nfs4proc.c:3086 _nfs4_open_and_get_state() error: 'dentry' dereferencing possible ERR_PTR()
fs/nfs/nfs4proc.c:3096 _nfs4_open_and_get_state() error: 'dentry' dereferencing possible ERR_PTR()
fs/proc/base.c:2091 proc_fill_cache() error: 'child' dereferencing possible ERR_PTR()
ipc/shm.c:1681 do_shmat() error: 'shp' dereferencing possible ERR_PTR()
kernel/cpu.c:618 finish_cpu() error: 'idle' dereferencing possible ERR_PTR()
kernel/trace/ring_buffer.c:3971 ring_buffer_write() error: 'event' dereferencing possible ERR_PTR()
kernel/trace/trace_events.c:3959 event_test_stuff() error: 'test_thread' dereferencing possible ERR_PTR()
lib/kunit/string-stream-test.c:25 string_stream_test_not_empty_after_add() error: 'stream' dereferencing possible ERR_PTR()
lib/kunit/string-stream-test.c:35 string_stream_test_get_string() error: 'stream' dereferencing possible ERR_PTR()
net/core/filter.c:10998 ____sk_select_reuseport() error: 'selected_sk' dereferencing possible ERR_PTR()
net/smc/smc_ib.c:215 smc_ib_find_route() error: 'neigh' dereferencing possible ERR_PTR()
net/sunrpc/clnt.c:135 rpc_setup_pipedir_sb() error: 'dir' dereferencing possible ERR_PTR()
net/sunrpc/rpc_pipe.c:1312 rpc_gssd_dummy_populate() error: 'gssd_dentry' dereferencing possible ERR_PTR()
net/sunrpc/rpc_pipe.c:1327 rpc_gssd_dummy_populate() error: 'clnt_dentry' dereferencing possible ERR_PTR()
net/sunrpc/rpc_pipe.c:641 __rpc_lookup_create_exclusive() error: 'dentry' dereferencing possible ERR_PTR()
net/sunrpc/rpc_pipe.c:666 __rpc_depopulate() error: 'dentry' dereferencing possible ERR_PTR()
security/keys/trusted-keys/trusted_tee.c:112 trusted_tee_seal() error: 'reg_shm_out' dereferencing possible ERR_PTR()
security/keys/trusted-keys/trusted_tee.c:171 trusted_tee_unseal() error: 'reg_shm_out' dereferencing possible ERR_PTR()
security/keys/trusted-keys/trusted_tpm2.c:75 tpm2_key_encode() error: 'work' dereferencing possible ERR_PTR()

--Cjk7ib2uiyLsi2F2--
