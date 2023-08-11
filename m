Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5CA779729
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 20:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbjHKSjF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 14:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbjHKSjC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:39:02 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3572E30EA
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 11:39:02 -0700 (PDT)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105]) by mx-outbound43-55.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 11 Aug 2023 18:38:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMQU2NQK0aNh9CUVdbrxIUSrz/LHFJvxuqZ0/qZ2wSXbWzWu+ndPl3p75hRHrni2VyEOELA+rzS3i51sVL/T3WW554LgSsC84OU3OvdRw0hLO73A0wV81UrP89y6dDGk7siOCoGsZGhZjsQLG56ZCn4hHeP8Zsaau0DSMqvzyXoMLhKJ7x7vlc32SUzNwZ2gxiJudq2BW+HsFLYDXn3zNxExj3v8tYWrRfb5cKdgZXIak+CCym6S+x0d+gXCzBUuxOLgmBnyq/qFaOfMst3e2wxIGo8jtdHdwcoFtlCUB5OSQyTGFMhC3eO8WLs70tHUmFGXzWeYseG2Uu3fEBnL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGdsoJ3n6PbGM/Esm39ZA7alBivylYH/cbNcUNxU/b8=;
 b=jicPrqXNeByNxQRecJoB4qeywl+wU27+rXeb7lRSKJvPnYepnHa6HtT9Gho2xyls7GezYLdFVsb9g772EchfDtw3rOXrY3scDGQeZfHeUbW2EbNjA82B3vzWj7r9ATratPP/L6Kx7UOwp/JkeIYH3wPJ43DEqi3B47pO21Yh6LO2RwdYPMGI0HfMyDCpnDOyjscuvoNIsg6S2Im0sGbaurR0iVLjcY/Qta7yGt/B2YJoIKJZEUntsbgDp6dIqav0rONJx8guhOZiJfKU7x1SpXYwGna+COEM4U0xbzDjsBBo0hUfbfS0PWx1SlUi9/apc5j0wz5Gc7rGZqtix5mQww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGdsoJ3n6PbGM/Esm39ZA7alBivylYH/cbNcUNxU/b8=;
 b=dkpzl2ZvJjT4SWG70v9IsYIfJP3HFDe3LT92YHYVWx11mhsAW4nwgiTvLmz0s1ZqV4hntKwXCd+UHuYH/JDRCehxMb4iEYWvQNaAR7SMZuQE5aRvOvcR7ywYFq3TDAkDHMdn93bWd4Q228En7BekEKK0bj6eSa8aC93CNUijaNo=
Received: from DS7PR03CA0005.namprd03.prod.outlook.com (2603:10b6:5:3b8::10)
 by SJ2PR19MB8094.namprd19.prod.outlook.com (2603:10b6:a03:536::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 18:38:17 +0000
Received: from DM6NAM04FT057.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::38) by DS7PR03CA0005.outlook.office365.com
 (2603:10b6:5:3b8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 18:38:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT057.mail.protection.outlook.com (10.13.159.101) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.19 via Frontend Transport; Fri, 11 Aug 2023 18:38:17 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 8AD7020C684B;
        Fri, 11 Aug 2023 12:39:22 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, fuse-devel@lists.sourceforge.net,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dharmendra Singh <dsingh@ddn.com>,
        Horst Birthelmer <hbirthelmer@ddn.com>
Subject: [PATCH v7 0/6] fuse: full atomic open and atomic-open-revalidate
Date:   Fri, 11 Aug 2023 20:37:46 +0200
Message-Id: <20230811183752.2506418-1-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM04FT057:EE_|SJ2PR19MB8094:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 88f3ed2e-72e0-47d0-9185-08db9a9a213e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qo80ek4rQ/2ufKcv0F1e8l378MbSwcChLhwL/nzZntoFflbbaE13tP2RG0Bae8RmtAuWj2zSZqZTXTrTXEWZXElECOdYBfwVnozD8ngZoTGITl0Z9zpHZbAg7jPqTWB0GRF9UDZi0gvo0BoRMNltlV7H4p1jlqqrW7BpirvRY2Z+8tkIv4SCPc4SW7ZJjCChdMHn+jspBykZvdveDGcodhdsk6j609EO1uaANMBInuwNZAmyzwDJyfs6sAi2GHQEwmLXSm6OHbay1K6EpEtc43luaRdp83V+1NrS0pyPjDb0EQHBSike7ec53u/ralVieqX6m1I1GryamFN8wZZGx7PiLbSFGOuWhJ6xQLnAuJwGxojInQGSm9SSlZvkC4dkMP3Qssp6/YOBby2uB9lZOFbzY5s9Cc2WN1z576xls/9Zosfoy73JKjdearHdgoxWFWzo/wL1o9Z1Pa6Aya91LVpb4KgZL9hC6/GmRraMdgTOg0iCL/TH2Aa++3vv4P9r10mhWFtDtgubUa/qizWj7gIRX7pPDqs+sPVkuZG9A8c/ZAXdHRRxEgmzJhKg3Vmr1RBMP0dYhyZ+rwDmVfkNwadhbW4lCew0pgr5vqha9PkZjRsmdJdGqB7Ob+pxsC5BmUPvoPHImUU7elcMtZdFVJrt/Nh/7CiWTfWS2sGchnGeJaOmk4jU7Y5w7yRiKWBiyGpLdRKDqpJaifTEdug0cmtc7rU0JX0KiQ35YINFguNPnDzQfnDSta9eGGBSoGlmIR3MI/LVuKdf34Dm9gMzkA==
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(346002)(396003)(136003)(376002)(82310400008)(186006)(1800799006)(451199021)(36840700001)(46966006)(6266002)(336012)(966005)(26005)(2616005)(1076003)(2906002)(36860700001)(83380400001)(47076005)(8676002)(6916009)(8936002)(4326008)(41300700001)(70586007)(5660300002)(70206006)(316002)(6666004)(478600001)(54906003)(36756003)(40480700001)(81166007)(82740400003)(356005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?DNpG5XdncF/IPqzsPcN1buqrPiGPSuYwH1CM8a6lBfmx8p8sIgdpIet01Bqr?=
 =?us-ascii?Q?SY+gaCWpYj7WfCaC914OmacR0QVrsFoHlOdT8mjojk82A+n70iPLWCf7F7dQ?=
 =?us-ascii?Q?QZxp73IO5phNAEAE0jWataCTpbZ3tYelYM+NTbjx6xZUNofKfAkffo8eUU4k?=
 =?us-ascii?Q?zLQfG6oHTL0hYyvzvUHWKd/RnIBS37VJMFee+2wzjcpJAbdHAYTNVoort8/f?=
 =?us-ascii?Q?Y05iapBxZHMf2dYc+NLZ73FH6eo0ZgArujf+bPkjdkZiYFzQtrbPCiJXlgza?=
 =?us-ascii?Q?8VmtsQMjLuHGWy0dz7O+6C5mBLxJwqUEx0XqkQKkjj1SHTjWKmi766eTUDSS?=
 =?us-ascii?Q?W/0gjCYQSsRtvx68B67lIn+QqVH1CpPa8k71qvwwvF1tO7lK0elvJfidE17l?=
 =?us-ascii?Q?qEiTIuqWO8BzvC0DH+Fh9hLO1YbXVuG/rRovIXo70+h7bt+2zaFWkCO5Ly6U?=
 =?us-ascii?Q?Nnyx9SGUA4muf/1nKmT13gt4sz3jW8Nkhb/aBfhP9IMq4xOSeWKPVPgHDU+E?=
 =?us-ascii?Q?8KNKnisKTf0PEsHSplgKBsBN1zKdF2E1PFFYgegbZQNrAEXzT3mmWSLRSrOu?=
 =?us-ascii?Q?wYclH7pdbRrgdLDnbjuxTYVECY6C4Z6zXSmhDgmcpp8jt8WsiHZbNC+wvb7E?=
 =?us-ascii?Q?+w3GDXd9XkoGxevFMHkaWTCNCbF/1/1nxFk6MicegvC0RIE7P2GhONlRcHtl?=
 =?us-ascii?Q?dzosqDKeBkBcO3taakNP+fVFFrvPlxykUEHcgJP6OEKeApUhoQGbUbqS3wy2?=
 =?us-ascii?Q?0iFuEM5jqID9fnoEZhjV0FctVSCT461SHe7fzg6+3wRXbLC6xh/8p6BVHzPg?=
 =?us-ascii?Q?N6nRDfY3unusszoyTfTLHDpbptysCAj4dQvKQ/BUMxth0g9RvX8hh5+Aezsh?=
 =?us-ascii?Q?lmAViPC4Pf9dRynRW7iD3tQKfeaT6XXp/LVxZPaH3Z4kny5LpO9YmSC9oTbs?=
 =?us-ascii?Q?9yGpkveeH5kKzmrPpSMJj2QPnvgIkmoRpfURoXXv8i0uH9n5GAhMmf3l7LxC?=
 =?us-ascii?Q?JrwdSv/9kaTw3ntPk5EAfVM4BQ=3D=3D?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 18:38:17.5665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f3ed2e-72e0-47d0-9185-08db9a9a213e
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM04FT057.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR19MB8094
X-BESS-ID: 1691779101-111063-12354-5445-1
X-BESS-VER: 2019.1_20230807.1901
X-BESS-Apparent-Source-IP: 104.47.70.105
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqZmxsZAVgZQ0NI01cw0zTjRIC
        U5LS3ZJMnc3NDI3DjZ3CDFLNnAyNRCqTYWAJf1h/tBAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250079 [from 
        cloudscan9-205.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA085b, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In FUSE, as of now, uncached lookups are expensive over the wire.
E.g additional latencies and stressing (meta data) servers from
thousands of clients. With atomic-open lookup before open
can be avoided.

Here is the link to performance numbers
https://lore.kernel.org/linux-fsdevel/20220322121212.5087-1-dharamhans87@gmail.com/

Here is the libfuse pull request
https://github.com/libfuse/libfuse/pull/813

The patches are passing passthrough_hp xfstests (libfuse part applied),
although we had to introduce umount retries into xfstests, as recent
kernels/xfstests fail umount in some tests with
EBUSY - independent of atomic open. (Although outstanding for v7)

I'm especially interested in Al's and Christians opinion about the
atomic open dentry revalidation in v7. If the vfs changes are 
acceptable, would it be possible to also look at the other patches
and their vfs/dcache interaction? I __hope__ I got it right and I hope
the vfs can be accepted.

v7: - Indentation and style fixes for _fuse_atomic_open.
    - Remodel atomic open to avoid races with parallel lookup, similar
      to NFS commit c94c09535c4debcc439f55b5b6d9ebe57bd4665a and what
      is done in _nfs4_open_and_get_state()
      A WARN_ONCE() and fallback is added to ensure operation is on
      negative dentries only.
    - Error handling is done via the fallback fuse_create_open()
      to reduce complexity and code duplication.
    - Remove entry cache invalidation on ENOENT in the atomic-open
      patch, as atomic-open so far operates on negative dentries only.
    - Remove fuse_advise_use_readdirplus() in _fuse_atomic_open
      (Thanks Miklos)
    - Add forgotten free_ext_value() (Thanks Miklos).
    - Declare struct fuse_inode per condition as the value needs to
      be retrieved anyway per condition.
    - Added atomic open-revalidation and required vfs changes
    - Added myself (Bernd) as Co-developed-by to Dharmendras patches, as
      I did substantial modifications.
    - More as reminder for myself, so far these tests below are
      done manually or with custom scripts, I think we need xfstests
      for these.

        With updated libfuse /scratch/dest is mounted by:
        passthrough_hp -o allow_other --foreground --debug-fuse /scratch/source /scratch/dest

        1) Test atomic open (file create) and negative dentry open

            rm -f /scratch/source/file # ensure file does not exist
            mount /scratch/dest  # overlay of /scratch source
            echo a > /scratch/dest/file # non-existing file
            umount and mount /scratch/test (clear cache)
            cat /scratch/dest/file
            rm -f /scratch/dest/file

        2) Test dir open

            mkdir /scratch/source/dir
            mount /scratch/dest  # overlay of /scratch source
            cat /scratch/source/dir
            rmdir /scratch/source/dir

        3)  Test revalidate without file change

            mount /scratch/dest
            echo "a" > /scratch/dest/file
            echo "b" >> /scratch/dest/file
            echo "c" >> /scratch/dest/file
            cat /scratch/dest/file
            rm -f /scratch/dest/file

        4)  Test revalidate by underlying file change

            mount /scratch/dest
            echo "a" > /scratch/dest/file
            cat /scratch/dest/file
            rm -f /scratch/source/file # unknown to dest mount
            str="b"
            echo "${str}" > /scratch/source/file
            reval=$(cat /scratch/dest/file)
            if [ "$str" != "reval" ]; then
                echo "String mismatch after revalidation"
                exit 1
            fi
            rm -f /scratch/dest/file

        5) Test revalidate by underlying file change, but with
           O_CREATE included. Tests dentry creation by the atomic
           revalidate

            mount /scratch/dest
            echo "a" >> /scratch/dest/file
            rm -f /scratch/source/file
            echo "b" > /scratch/source/file

            # revalidate includes O_CREATE
            echo "c" >> /scratch/dest/file

        6) Repeat above tests, but with additional "--nocache"
           passthrough_hp option

v6: Addressed Miklos comments and rewrote atomic open into its own
    function. Also dropped for now is the revalidate optimization, we
    have the code/patch, but it needs more testing. Also easier to
    first agree on atomic open and then to land the next optimization.

v5: Addressed comments

v3: Addressed comments

v4: Addressed all comments and refactored the code into 3 separate patches
    respectively for Atomic create, Atomic open, optimizing lookup in
    d_revalidate().

v3: handle review comments

v2: fixed a memory leak in <fuse_atomic_open_common>


Bernd Schubert (5):
  fuse: rename fuse_create_open
  fuse: introduce atomic open
  fuse: Revalidate positive entries in fuse_atomic_open
  fuse: revalidate Set DCACHE_ATOMIC_OPEN for cached dentries
  fuse: Avoid code duplication in atomic open

Miklos Szeredi (1):
  [RFC] Allow atomic_open() on positive dentry

 fs/fuse/dir.c             | 398 +++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h          |   6 +
 fs/namei.c                |  17 +-
 include/linux/dcache.h    |   6 +
 include/linux/namei.h     |   1 +
 include/uapi/linux/fuse.h |   3 +
 6 files changed, 422 insertions(+), 9 deletions(-)

Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: Horst Birthelmer <hbirthelmer@ddn.com>
Cc: linux-fsdevel@vger.kernel.org

-- 
2.34.1

