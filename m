Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8554377E3B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 16:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343661AbjHPOeb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 10:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343694AbjHPOeU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:34:20 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2F42716
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 07:33:54 -0700 (PDT)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168]) by mx-outbound21-191.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 16 Aug 2023 14:33:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxrFSPqmbJzQ5sMeG4WgaI9kItHkzl9azfOehVHaM+umKrjMJ3HR0RYqf6ULtpyakpx4ewCs3V1/HSPM1PZ+B+UnDCiAkuN4RzyFVqrTovASgT0AKSVGKOaVtgbiDeswYHJOqCRJ6eVKkSxg2kqKm7zXmbQ8ogsWxQ/Fa2qHL1LMh1C/Xk/es6XgtcDXuBt1WewL/ypUP0wkSaZd9bd/oJYZf8c6mZ1oaxEdO2+o5+BAf6P0okGrKCGjFmtPLkJG3n4BX/Ix7iHXk2psqB6xW/FBrmuLa2tseUrM7rVGRYThoYeUkxOnjmFddV548h7nw0bbzjB7fQG0o5dkZ32i5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmEmPXCVGNyRKJseNwAauz79I6pJIrpWZA41rsMD+X4=;
 b=CvX0wkGz8l6dG1s/HrX7iOhX8jq5yF3MGu8+Ev/0pdzmpXbiIWyIVF5nHej8a+MCF/POVUkqwzYKJF0sgvSlg4MttWNbiiTD+tyKGkckM1vp1axB50hws7zl40bCFtXeBBW0uypEaNAPSm0AVeUbriJx03gC7nUUKdnnr5y3niEozLhAkTUwjOy/fDwlni+JvLdMyLHYLaoQ1kdfxpaA0oh96YgvQXNKF5RJxo11j52Nb1GSt0yiDeWRjkgOq2dVgjF67ia7EORRUg56R28e8JLMw6hh7gMSKMzQNgNaSe+mwKY2y44Z5tQ4yWj9K+i+YaoG5hkN0DRbFTJ4EbC3Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmEmPXCVGNyRKJseNwAauz79I6pJIrpWZA41rsMD+X4=;
 b=mZ9nM5onAdDck/ili6aDekXdLJcg7iq/Rzyaia1uD9W4Ld2VrmJZcg1fheAzTn92HZyHMBrU0CaYsd5UEI+OF3yHE6NBDFxTpsZOPn6RSp36gcIPJS27Feee4Jt8WEpj0fydKdZZh+MXbtLvYulzrR+8sc9niJQ1JewonuH5vks=
Received: from BN9PR03CA0570.namprd03.prod.outlook.com (2603:10b6:408:138::35)
 by CH2PR19MB3783.namprd19.prod.outlook.com (2603:10b6:610:9e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 14:33:20 +0000
Received: from BN8NAM04FT038.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::71) by BN9PR03CA0570.outlook.office365.com
 (2603:10b6:408:138::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 14:33:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT038.mail.protection.outlook.com (10.13.161.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.17 via Frontend Transport; Wed, 16 Aug 2023 14:33:19 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 77F2420C684D;
        Wed, 16 Aug 2023 08:34:25 -0600 (MDT)
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
Subject: [PATCH v8 0/6] fuse: full atomic open and atomic-open-revalidate
Date:   Wed, 16 Aug 2023 16:33:07 +0200
Message-Id: <20230816143313.2591328-1-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT038:EE_|CH2PR19MB3783:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: db3a8f1f-6da8-40ab-a252-08db9e65bcc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9f9Qu4hanzuGEeBkR78wkS49UBb6/E7DqMQN+X4LphFYTMaXUZcnlPDeJmUdHh6t7EV7wdVyi4PLJO0ffhJRLQWsnjEQphav72dVVdQEH5TzMBvxlgVFYsMHBcb0+wJtS6LIVc0gsiZD8m//t3XFyTr1hIRPOop4PmI+ZXyTzeq00YKa4brt4V75XGIWduoU/OdBiWSmy9seyjH3feMzSDaOE3T9vapkx61/MrFDamSIPYWums6EDZzOOdzaGmidar4jbg7i2plzdFqshBImQdHAnnX1W4+bMYeCMFerW/MePkilF2nUCrVDU0IgM/7Pdp1W9qKIPgwuT5IJqXXDfjKQWNs8dOBeYjgL+qg12swLdjdK3qc/ByQjxDmR/ccRfu/qAz1PqlPA4n/Qn10P7Vng9SY5YqZbRtixBwYhc9GSduXtwmM/mW5El7U924HIS7H6/Mlauw/Vsffu7DId9dj/U1wK4J5XGepJ5uneDapOxW19bPP/xdksKL6aHimXvfMmtcGnRJ2Z6jcQQRQFPwlF/F45M1/AdJWBj8NeF/JsgdK3MXMvGIAv5KMtB8t8ZpJDp0eRqa6JBiNKGJzTXTgK4iZ0dA3VRwVllk+vCApOrAVvNDLr3syQHymcIKIyTvCTy/1dFvRPY4ML49PgXlyQSmjUwe7lH+uvVNuXiMPjLKQxc5mn7JlFvpf3yiRfiA1X3cGQeWxsv7eCGxSJyIuIS4jRVBUh/0IT+XLXrfQGSJipygjOFmhmpxOWPCCjxjrPYu6L2ob6UAGtQNxsQw==
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39850400004)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(316002)(54906003)(356005)(82740400003)(6916009)(81166007)(70586007)(70206006)(966005)(36860700001)(41300700001)(5660300002)(47076005)(8676002)(4326008)(8936002)(2906002)(83380400001)(26005)(40480700001)(478600001)(336012)(6266002)(86362001)(36756003)(6666004)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?loFMzDktTlkyKxeQMOIOZEvcbvuuP5A6xDF1sgzP8xXb1uet9IOgUaviORoU?=
 =?us-ascii?Q?HlMuP6skEKLdvuHpEA2jAMOu1919l9PfjJSBaLYB5J3klIzkqEsIUmHenkQo?=
 =?us-ascii?Q?w2DUJHVYRlmYPWqo9nMRQcYiVgn9H4sGabeSBPFoXYarhmQuFfLnzvT4Bsa/?=
 =?us-ascii?Q?qtx4Z6BEJjt2FaW3SX/L+89J+n4Xtc5Bw0vguwmcdS19bjFtD5/97fMPOmit?=
 =?us-ascii?Q?kjtKQaV7J0spjX94tKGTg26O+FA0ziy/fGe7LK/bb5ULi1xbLG9qAu9b+tFy?=
 =?us-ascii?Q?tEykr8qh3eADtgZaILKSGFcyBRiF+7O17GWGfwIVzOnX+LK6YP/djpFSS9CC?=
 =?us-ascii?Q?m3CUEPQDwBv5mlEtkAmTSjb+Lr1wGfSBopJ6cUEd5xEYJZDHVZyzqrf4zxCk?=
 =?us-ascii?Q?LWq/F1ElkUKLsFkh2Umhpggk2GQ6/M2M+UMpKQPQwBjTQtOTMnEzrcTHif0s?=
 =?us-ascii?Q?X7qUET/peb20EBHvNsHGi/LpkHwuy32KFhKkze5sPdMKsIGH9rM9innJVSj/?=
 =?us-ascii?Q?jIrCWi73Mlks+AIPYgn5pYGzVtP7J0IdTU/gyjmkBqh7AHdIgORPbD98HPHs?=
 =?us-ascii?Q?8cxpPLkKtxXiHxBnnmBMUfE+cwj8OfUHOxK78TqcTSmhaVjrB/GbbqQnQiAe?=
 =?us-ascii?Q?50IaoVf1tTqXhMrJUnfNgStrdPnG8TVXeeFLj1D3pjtluJkK9D8LhRk+LW3G?=
 =?us-ascii?Q?kiWsTW5TPDUKvSACQYpnBoHVVUgMU2bgRh+wOlt8Afx9Ui2RsUV0cwjd9Trn?=
 =?us-ascii?Q?DC2L6iocf9vJybqC9XfSyFXuChc7jDle/z+xxb6BqSS/fXt/D7IPleCZ1lLB?=
 =?us-ascii?Q?O39NL831G8cQv7/g3h2tOpbtPcUNGm4Zz4jZ0erE7vg+pOoJZbIFtpp5mE1c?=
 =?us-ascii?Q?1xvg4BpZ6yjFf+FbnFwAWHQBrxZVf3Ek9cn8veskEnFy2s+kTg7OATB+87qb?=
 =?us-ascii?Q?V/yXCH2/2ZEWt5Ji+aXLgFmjelIuzJb9B1WGSAZp5YNicFQM6euprkFJ8Xss?=
 =?us-ascii?Q?J3CGsIcld6he8uMZ4+KlW8aBzg=3D=3D?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:33:19.7277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db3a8f1f-6da8-40ab-a252-08db9e65bcc0
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT038.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3783
X-BESS-ID: 1692196407-105567-24272-1026-1
X-BESS-VER: 2019.1_20230807.1901
X-BESS-Apparent-Source-IP: 104.47.58.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqaWxpZAVgZQMNk4JcnQzNjC0D
        zR0NgiNSUtyczS3CItJdkw0TDV1MhUqTYWALERpsNBAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250184 [from 
        cloudscan19-195.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA085b, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

v8: - Another slight indentation fix in _fuse_atomic_open
    - Fix compilation error in patch 4 (fuse atomic revalidate)
    - Remove LOOKUP_ATOMIC_REVALIDATE
    - Switch from DCACHE_ATOMIC_OPEN flag to return value and
      and introduce an enum for d_revalidate return values.
    - checkpatch fixes

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

