Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FF17A8AAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 19:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjITRf0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 13:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjITRfW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:35:22 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5103BD7
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 10:35:09 -0700 (PDT)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109]) by mx-outbound17-239.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 20 Sep 2023 17:34:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJiTcbDdt+xc29Uv69wjYgcKAubCt67VdKzZXc8oFJrCDKqDPWO0DBDwhtAKHYJJZTRi/orlGPJlCAp/UyhOeba75Cq/P5pewUf1HUlIEz0ND4eV8dwmAtl5BsCbxLxj24DlAVJZqOLTqoEpPtV5RftwSCuPu3rQAq8G5dC7TdyERsA9rkK3cQjhqhXOg+jN38Zj3zhYhPrWmDkwhbn4zGYhCI1TOFLj+IsbURqt2mJeV7XJn807niXDmlKbnSt2E1y9f6Ub06A4pIVaXhZyl3spYxad1xCEiqHk1WCFIpR8lTW81oujWlZlRWrsnzc8DrMVD7/tjRytympfHyu02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDXCJI0IZ5a6vS72LPIoeYLNaHXNsgIP1RTdWfIaUMU=;
 b=GckL4s2T1QEqjTmJ0Bvf6ywk0Fznrxv6q1bEimWcjtfF2bJhldbixgbd8avRfOy6cIjpZo68q8wJ47Ie0189pf8lraCrHwJRGoXqzprfYiyP+bRSTldCZT5gtC88JKbaVvO9hV8qcSAasvSxI1Q4Pqt7eWkYyyTwwPFkRtQc4XbPCGcDej0kZ/PMQp0tf7uLHZVqj/kD91OGbwEQqpGrSBM79HhFz2EdXfx5r9yvS627iKRXXWQMCmPt5fxyZfyPVh1Fd3WN6MxQ+VsjIr6iTpckEfFRX951GDWLgq1t/bc0WcEBQCdUc41AMBJ4+X3ue/vJLcRhgFVVwPEQaRmvXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDXCJI0IZ5a6vS72LPIoeYLNaHXNsgIP1RTdWfIaUMU=;
 b=SCgoVoIzmWp5nUHxKZ38PhDkuxcd/n3AYfRZELz/AZF0BNS1jWcVJt+dTyHvK4bnnrVPp86JKNCpiP5dA8S4YGDrmKmUadDrc3jcXKAjAzOZs54VWB38zIVSC1hA2Y123cFKOWD5sgYMhSkg6Fv9yBMbPoPZUKm1TxuPU4juQKA=
Received: from MW4PR03CA0286.namprd03.prod.outlook.com (2603:10b6:303:b5::21)
 by SJ2PR19MB7385.namprd19.prod.outlook.com (2603:10b6:a03:4c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 17:34:49 +0000
Received: from MW2NAM04FT043.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::ee) by MW4PR03CA0286.outlook.office365.com
 (2603:10b6:303:b5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 17:34:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT043.mail.protection.outlook.com (10.13.31.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20 via Frontend Transport; Wed, 20 Sep 2023 17:34:49 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 587EF20C684B;
        Wed, 20 Sep 2023 11:35:54 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Horst Birthelmer <hbirthelmer@ddn.com>
Subject: [PATCH v9 0/7] fuse: full atomic open and atomic-open-revalidate
Date:   Wed, 20 Sep 2023 19:34:38 +0200
Message-Id: <20230920173445.3943581-1-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT043:EE_|SJ2PR19MB7385:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 93798041-ed6c-4703-0f56-08dbb9ffe3cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VoS8T1zYTAMfLYyqaFcZEYHpSYV7gsCNAUdnuaQYuDzYKzgP2IpdvIFYHXxaghTneswgG9cRJwZs+AW9GWuug357Cs53l/h3mNBO+VnAJiaDlCXp8OS0cTKHcMWhm3TbRFOlFTk86waFNY+p99i3RFzdovWqtnSA6rnkROB98Q6izrXZQbX2rAN7rpojpaKPIPGG30tRbpbaYz1WUwcdTi7uoWS8pop+rdPDNAFPaPk1BNXik02w2Mh5wbne8dU1BbeTRV8GgXRZzovP32YLCXMCZFwAQ9pnRYerflTVcVs7bm0i+m0Z8L1WisimiGPDoDCaSiArFBtI3QkJh3AcWPXA1XLEGZrrWUmFqaMpsYrQaZdHQf9pelejlsu5XuADQhxesk0qxHrbYuAMNgYl/GqPfckcRIlOr7rU+ayjP7x95r2189iIxOPclR55HXfCHVd0eRt4svc6Unice3ffqOSNjDjYLARV1QwI34F5so7Est8Zt6Nwu026zrxk/Y9OFV2LlN2nQIsp8UC1OsYVM1eehkR9oAHlG7rqCtIWWloCAJcmL5seliVtxuhhiqCIEaQem4kXQDdtvNZwrecLIX15W/nRH2C/aruujt/+RCPoifW9KEaByFzcfdkA2MKmoIqSI2raJr2IkAqhBthtwl5FqG3ZjWjAcUzxzQk0JvHqurkItFtWceS1xUraaym53H/cHLELm4h1vf8YIZaCqvlp0htfydnhR9n+ULtXJ0US06zO179otE5q3yW2zsVo5MQWfaETpKbff5ZYtij1ew==
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39850400004)(396003)(376002)(346002)(136003)(82310400011)(186009)(451199024)(1800799009)(36840700001)(46966006)(2906002)(83380400001)(86362001)(6666004)(36756003)(1076003)(2616005)(966005)(478600001)(6266002)(336012)(40480700001)(26005)(8676002)(36860700001)(8936002)(4326008)(47076005)(70586007)(5660300002)(41300700001)(316002)(81166007)(356005)(82740400003)(54906003)(6916009)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/rJv18FBun9gypFG1dDso2zf5ZxPoG9LeKAui5l1pS5Tambo4sN3ZPzJclzc?=
 =?us-ascii?Q?TWNQ3imYdmH/sA3zo3lrLXuLkvFmlwf+FgZrmKN5/W7MS8Pcput80wfGWWx7?=
 =?us-ascii?Q?KESUNRJMke710lF3bI9cJNN9X3ogFk+ZlkspckPSlUIRR/Y8s0d/k7+C84Ko?=
 =?us-ascii?Q?DcwCuXqk76xn9evkppFUubAOXMbg8kaNnLi/H3N3/bbkTVeArqQyo4cb0vu0?=
 =?us-ascii?Q?FgpxhtlZrl096sEnD9UTIy7BVZTWy+UgqVATOXaO8aw+ZePpGBs+RmeBcHHn?=
 =?us-ascii?Q?4vU/yFxMfuLUJeO54boWfDqtL/2rqNNOY5DWV0mmts3VlvtVr2ddUa/wEBMt?=
 =?us-ascii?Q?1lHzZyu2jG+Un3KMfqh2Jb0v130wHRWSrxd8dhWDz4Ewkr9fBGPvCWFxk1ac?=
 =?us-ascii?Q?k3ufRdSBpG6/zTHms7lG1220DvCKEh4JaXw/e17rJb5oKUXrPUVKiPpkYrgJ?=
 =?us-ascii?Q?G1jPLB0eIM8X4LISfWQFYaoRTaDBuwRFAcZhcTcF+w801NPan/xch/dUtnzi?=
 =?us-ascii?Q?QjI2Y9i3pwZg83JEkMFDYE3yDu53Jdt29QsLgK5NlLJaydyhQLFOTFKhubQn?=
 =?us-ascii?Q?JhtjUZ/l7oREBZBqseb1t/acKN976eY2uJ6FYokXSUJulI/0ruN5v4k5/IZB?=
 =?us-ascii?Q?cIGvaVWPUmJ4NaTqhv5U8VtllaxD4SPTxAelZliaNvKe7cGtrFFvzixhdzwa?=
 =?us-ascii?Q?POu8//XCIkdM1xiGcquZ1ZAv4EIc5pJqKzRDDMRblx14jmP9t3yCBq1kEdsD?=
 =?us-ascii?Q?YxxCXBzOR/s3gUFH8WfAMkbKBIXDlWNH8GdocYsJDPnXq2tzvhsAwhDceHy3?=
 =?us-ascii?Q?spwTc6o0Y7wtSXWJbK3akdsh2Yc11CCs7LqyA8PkHSpO0aZAb03vcexxrWHC?=
 =?us-ascii?Q?lmCSJJK7HDhRcUSvtE/bly1puP5PkjyX2doqWnYI2a/vt2qHUSZ9uT5oXPb9?=
 =?us-ascii?Q?7wRK6KTug9LD/X6VmJ9eqg=3D=3D?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 17:34:49.1720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93798041-ed6c-4703-0f56-08dbb9ffe3cc
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT043.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR19MB7385
X-BESS-ID: 1695231294-104591-25643-296-1
X-BESS-VER: 2019.1_20230913.1749
X-BESS-Apparent-Source-IP: 104.47.58.109
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmZGZgZAVgZQMMUkycTcIMXAxN
        jEKCXZwsjAwiQtMcnINCnVPMXYwDJNqTYWAPIbIB9BAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250962 [from 
        cloudscan11-248.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA085b, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

v9:
    - Followed Miklos suggestion and added another patch to further
      optimize atomic revalidate/open, which avoids dentry
      acquire/release and also avoids double call into ->d_revalidate
    - Updates following Miklos' review
    - Dropped a temporary comment in patch 2/7 (accidental leftover)

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

Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: Horst Birthelmer <hbirthelmer@ddn.com>
Cc: linux-fsdevel@vger.kernel.org

Bernd Schubert (6):
  fuse: rename fuse_create_open
  fuse: introduce atomic open
  vfs: Optimize atomic_open() on positive dentry
  fuse: Revalidate positive entries in fuse_atomic_open
  fuse: Return D_REVALIDATE_ATOMIC for cached dentries
  fuse: Avoid code duplication in atomic open

Miklos Szeredi (1):
  [RFC] Allow atomic_open() on positive dentry

 fs/fuse/dir.c             | 390 +++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h          |   6 +
 fs/namei.c                |  66 ++++++-
 include/linux/namei.h     |   7 +
 include/uapi/linux/fuse.h |   3 +
 5 files changed, 461 insertions(+), 11 deletions(-)

-- 
2.39.2

