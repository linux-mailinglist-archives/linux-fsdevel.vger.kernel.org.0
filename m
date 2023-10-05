Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF587BA275
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 17:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbjJEPhy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 11:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjJEPhd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:37:33 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AA0346F3
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 07:53:29 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231005114715epoutp016559b4b10ba5ed1b3941abbf54fa8c5e~LM51RHG-x1110311103epoutp01G
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 11:47:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231005114715epoutp016559b4b10ba5ed1b3941abbf54fa8c5e~LM51RHG-x1110311103epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696506435;
        bh=Ur+4Je3z8bThcQehVDWdTpaEHCUcUOWQbzV4q7wIiCc=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=iKuYPA76nLE3s1kYHBv12H9KsYEg3qc/Y6U+dBMqeqOjaBj+f8YsB6MZ/kiMAjOCD
         Lj3sNgJpF4PuwUajl6HbnmXIIIPkdbOkdvZ08WBg2dnr4mu4t1jqGJFpJTApLo5na5
         IhFJzHAc+85S9UBK+DOsLthEDwjKvpsFQPj6U9cc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20231005114714epcas2p4275fa98619da66da774a9e4da888acab~LM50qdik-2498724987epcas2p4E;
        Thu,  5 Oct 2023 11:47:14 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.70]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4S1VCk2wKgz4x9Pv; Thu,  5 Oct
        2023 11:47:14 +0000 (GMT)
X-AuditID: b6c32a43-96bfd70000002187-f1-651ea242eab2
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C2.58.08583.242AE156; Thu,  5 Oct 2023 20:47:14 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 04/13] block: Restore write hint support
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Daejun Park <daejun7.park@samsung.com>,
        Seokhwan Kim <sukka.kim@samsung.com>,
        Yonggil Song <yonggil.song@samsung.com>,
        Jorn Lee <lunar.lee@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230920191442.3701673-5-bvanassche@acm.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231005114612epcms2p14efed0ed36c055344eec4b1f961ddf60@epcms2p1>
Date:   Thu, 05 Oct 2023 20:46:12 +0900
X-CMS-MailID: 20231005114612epcms2p14efed0ed36c055344eec4b1f961ddf60
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmha7TIrlUg30nRCxW3+1ns3h9+BOj
        xbQPP5ktTk89y2Tx8pCmxaoH4RaXn/BZrFx9lMniyfpZzBZ7b2lb7Nl7ksWi+/oONouTK16w
        WCw//o/JYlXHXEaL83+Ps1pMPX+EyUHQ4/IVb4/LZ0s9Nq3qZPPYfbOBzePj01ssHn1bVjF6
        fN4k57HpyVumAI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUX
        nwBdt8wcoA+UFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQXmBXrFibnFpXnpenmp
        JVaGBgZGpkCFCdkZ/esfsxa8ZKt4tXoZawPjWdYuRk4OCQETiV17lgDZXBxCAjsYJTqXdrB0
        MXJw8AoISvzdIQxSIyxgI7Hl2VY2EFtIQEli/cVZ7BBxPYlbD9cwgthsAjoS00/cB4uLCLhJ
        NFzdxQYyk1ngHYvEq7+7oZbxSsxof8oCYUtLbF++FayZU8BKYunFnewQcQ2JH8t6mSFsUYmb
        q9+yw9jvj81nhLBFJFrvnYWqEZR48HM3VFxS4vbcTVD1+RL/ryyHsmskth2YB2XrS1zr2Ah2
        A6+Ar8S/N29ZQf5lEVCVeDiVG6LERaJ35XKw8cwC8hLb385hBilhFtCUWL9LH8SUEFCWOHKL
        BaKCT6Lj8F92mAcbNv7Gyt4x7wkThK0mse7neqYJjMqzEOE8C8muWQi7FjAyr2IUSy0ozk1P
        TTYqMIRHbXJ+7iZGcFLWct7BeGX+P71DjEwcjIcYJTiYlUR40xtkUoV4UxIrq1KL8uOLSnNS
        iw8xmgI9OZFZSjQ5H5gX8kriDU0sDUzMzAzNjUwNzJXEee+1zk0REkhPLEnNTk0tSC2C6WPi
        4JRqYKr0Zr8rJ7pKNbPXyHhvbq2KS/Fzj/cv64SFevRFC6uWRybfXLvMwSejn5PvW21WCc8E
        tzwj99pAFrM9h+N7db5Nbr1x4N0O9sJV3fFLniY9sq1js9pSr5gksilFconGq6ctr9bEaxbb
        bsuqZdvy8N1Btj+XZQ/13cj3WtpTeSz8bXBTqfWKG6seHD970O33/jc3FnruWCpZtPj059q5
        DPv2T78iu+XOzYBT5hItp97L+WX7hEz/airg3Pl8trC4tYvv8s0pwTuetG1617bwnor98UXO
        QVOL/ye7RX3V1hdp3yee/y0iqeKXtaRyyj/Gg5P1XI1On6u98kqwLVLbhX3W1pn7uZe+LWBq
        MT/xWomlOCPRUIu5qDgRAPbgHYxTBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230920191556epcas2p39b150e6715248b625588a50b333e82e2
References: <20230920191442.3701673-5-bvanassche@acm.org>
        <20230920191442.3701673-1-bvanassche@acm.org>
        <CGME20230920191556epcas2p39b150e6715248b625588a50b333e82e2@epcms2p1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> This patch partially reverts commit c75e707fe1aa ("block: remove the
> per-bio/request write hint"). The following aspects of that commit have
> been reverted:
> - Pass the struct kiocb write hint information to struct bio.
> - Pass the struct bio write hint information to struct request.
> - Do not merge requests with different write hints.
> - Passing write hint information from the VFS layer to the block layer.
> - In F2FS, initialization of bio.bi_write_hint.
> 
> The following aspects of that commit have been dropped:
> - Debugfs support for retrieving and modifying write hints.
> - md-raid, BTRFS, ext4, gfs2 and zonefs write hint support.
> - The write_hints[] array in struct request_queue.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Daejun Park <daejun7.park@samsung.com>
