Return-Path: <linux-fsdevel+bounces-955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 179297D3F41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 20:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE5A2815D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 18:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3890D21A19;
	Mon, 23 Oct 2023 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="cMSXNwC0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4862621119
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 18:31:07 +0000 (UTC)
Received: from outbound-ip201b.ess.barracuda.com (outbound-ip201b.ess.barracuda.com [209.222.82.145])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEA8101
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 11:30:59 -0700 (PDT)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169]) by mx-outbound40-203.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Oct 2023 18:30:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQe6nQ7HOkqddKHjfmjUFUlufeECFwXBVpkgzD3d+JS3BVSWYYmc0suoyqv5a8EB5yzHKI36kZd/JlMJG9uKrVx05rUXs64VW9vJwWLCBIXAbd+6/Z8IfowzA7utohxT/KQMEK7Py0slk2BWOK7mcQa3FErCAW1FkX+ryLn+8FxwSXt8PQDI0JkieuCuh7BAvEzJ2ljuX667+d+w67I377OVchS/J5Z0yqtgCuYVtDxKoRAdsy7iuDC1VDz0o4M28XvS1ppdCfUTLnPfmglwCctDuW8pg/ARiQ/tIq9v527ofUJy4caBYjGXUVxj6pXz4TcTdGtrpWer31UvLWN0sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q47Cn2YEfxGP/qIxW6m3C0Euu4e9XBxFY8DzaUrw6Vg=;
 b=C4uvC4OJYntJrtYMG3ALJ3OWhLw6waR+x+XhoDQfyV8qXcXS6U6I6JPp6ybCJ1rIntKqgpI4TGZQ9Si0QLYgkx6J2GR7WsHAx0ACRo/tGO9LVGEkkVvQmHNvYEOlDUbT4n6HAVolV6m26dsrjFd1XuCYVcvMpCrZPi2oq8XpOZ20BRJTC+Qa3DfY2JQiOdspoaWJVDylaUwwICiuRI45RR1tZFGBZQFdEStrfCQse0z6Y7+Qml2uFSYiSnN1RV3sUBgsbIl/YvFgHH56lyygjodDkuosMzvJZUvd8dWfzutM/O6jOADsQ97aIwRD4bAcINAUCKKgclxlio/m5oll5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=chromium.org smtp.mailfrom=ddn.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ddn.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q47Cn2YEfxGP/qIxW6m3C0Euu4e9XBxFY8DzaUrw6Vg=;
 b=cMSXNwC0RGykol1YXa7XqOpxi4pRGVKoLivM62P1ve7hXwEak2cNJQLZ42qDyqHQi0RG3ugy5kwoZF8mF6iPpIBpT00og6WSlZvEdtHzG8+pkyyZjRAF7vK2ckHHeLsXserL3HWpiJ4DvbEvp3vOw2krEZ4jkGRBewRDkGZvhnk=
Received: from BN9PR03CA0440.namprd03.prod.outlook.com (2603:10b6:408:113::25)
 by SJ0PR19MB5491.namprd19.prod.outlook.com (2603:10b6:a03:422::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 18:30:39 +0000
Received: from BN8NAM04FT053.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::87) by BN9PR03CA0440.outlook.office365.com
 (2603:10b6:408:113::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 18:30:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT053.mail.protection.outlook.com (10.13.161.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.16 via Frontend Transport; Mon, 23 Oct 2023 18:30:38 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 9140C20C684B;
	Mon, 23 Oct 2023 12:31:42 -0600 (MDT)
From: Bernd Schubert <bschubert@ddn.com>
To: linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	miklos@szeredi.hu,
	dsingh@ddn.com,
	Bernd Schubert <bschubert@ddn.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	Yuan Yao <yuanyaogoog@chromium.org>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v10 0/8] fuse: full atomic open and atomic-open-revalidate
Date: Mon, 23 Oct 2023 20:30:27 +0200
Message-Id: <20231023183035.11035-1-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT053:EE_|SJ0PR19MB5491:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 284033df-925d-4b47-b04a-08dbd3f627d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LwX7IwyF2CS4CzYbUUh27e47tWVdJVAfEiSqbC2EJW+7os2kU6JKSqVRNEWGiaWcBCjcSsh7+VLDU0IwpnLm8fQ6/AwqGxUyk1W6hwp+iND6XVpu+DZ8cShkR5aJhEqGPlmaz99BEa/0tzrnCPEMtYTMpkQ7rj3+FeY6DfzrsFN6RNnXVm9g/BcAFv3Amm/Hhpy7yIB14WrTAg4nNp/ym+qio/QQySYmjBCna8HUnjUF9J3lrhCiVCIoW2och2pRXW6DF8DC6C2mNQi4E77Eyw7S8KmcSd2MxEmh4i9TCHfvh20pYkFUIV/ERDjY/akseyNXnavcropar4r2ngoP/z36WbvtKa7HuwyjsYNiNU9Pu1g0HSHflUcy1Bc5TdLoXBOPCP+yuZhOdNSPV6OEV2x3wQ+G6hTUsBjqNSmR/fztWCtiVCgF1TtiSJEICbjxsKBq+wIt71tFJRz04gvkpXD9UfyvTwYMZnB58oZTMRkUZChXeOma5cAXIdBm3X60t6VhqYzKiAChtqhkNvula0GCOeX8zAHkmBBoos2MGRZg0mslOi+UsAo3cYijObT2uaNs4YVojx2N62Ql2+uV0s+PVplC1ImAcUjH9flxP8Ksn1MWrhc5Pe2u2mlyjs57HJY6pfGrBSUrQMa7cK49xWC4XkHihhoPrWJJbCU6GbJpx7m8b9t0wDHKjNbDheMePKBvr7TD53XfnrLIUDyVMbkZYJx9rsk2Q8M8RSiqB2c9OX7dBOEDdah96FqjmsJ0gOfds7wvlJa5XqkLWkdfpg==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39850400004)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799009)(36840700001)(46966006)(336012)(6266002)(2616005)(8936002)(6666004)(83380400001)(1076003)(47076005)(5660300002)(8676002)(41300700001)(4326008)(966005)(2906002)(26005)(478600001)(36860700001)(70586007)(70206006)(316002)(6916009)(54906003)(356005)(82740400003)(81166007)(86362001)(36756003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	=?us-ascii?Q?RVaT5p+/H94cZcx5N0z8dbEW1AaEEruOaOjlFgBuu8FJmiCwbTeahD0qYEyi?=
 =?us-ascii?Q?zJ+UfAHecwja/D62IDEdSp9pYuoH/d7iKcn79GPLqyyctVEnoVnokO7zpQ29?=
 =?us-ascii?Q?elHzKgX9hAM0bz9LjZdJLFX0nA3i562N8Tdm+3Xxe1G+yC5LRXIIc9UKI8Tq?=
 =?us-ascii?Q?P2M7v7txvD6lU0sygZOXKb7xj0W7nGAAiLdBX8muIBVliz7crrC35qajFJEG?=
 =?us-ascii?Q?mK1J99E75q0VJ96CXKc7IKbLw5JpYfyPhj4kiSRgACVHSBZcfnY24reyPdT+?=
 =?us-ascii?Q?apg0z9wyFITwZh3WN0UY1q+IVBaBA6nfenSRhuVnwLmeaYwp4m5u0ms0FJY6?=
 =?us-ascii?Q?RVg84uCWsTV+dq2ML0JK+tPo3ca3/JvVXQuZURngCgq1Vx6E8pXXSDi+7WAP?=
 =?us-ascii?Q?7MsmXMrbHw3DXIgRfmox1Q83P0S3U12LPYlK7Ey1r2SeBGyG9wvoAqSiei/b?=
 =?us-ascii?Q?MZtViBNPW/r+nyM6DlRHwiZTMklEeWPUmPjUtxa3siKTiEJGqamQ/oQ7jR04?=
 =?us-ascii?Q?bV4gyC6LhENcYgbHiJq0MJQn5m3OeoCa6A7fZu7g6fh3aNKzP2taA60WOTFE?=
 =?us-ascii?Q?jARUnoDLjJnkGJVpLtjZ9XEQLQFT+3728qvsu41ltjDYQXoAkupv1afWvSfA?=
 =?us-ascii?Q?/TuxTGFw443srIQ+BqmsfiaoGLqW7B8j917GF2fUg4/RvanOoF7Ppuo3MajD?=
 =?us-ascii?Q?O2ISm+/wNaSnq3tij9QXmY5e+fM8XWLnngdQh+u4ygpH4gSsJYW8zIp3PAMS?=
 =?us-ascii?Q?HahROpHMPJQJaBudEXhG/Cexhs3l1wZpsLNioyTOEsf7/BGGVV9TOTja04mb?=
 =?us-ascii?Q?7rCdG6U3o4f8IGRIbzxFaarQmre1ZvS8JY2F1DH0ap2OafNj0KeLHPcFHmWJ?=
 =?us-ascii?Q?MNIHoQSzRBmaK2yraMh+qbKsi7OuCdgs3vDi5tzNrZwzu9SRjFQiAxHBuKwo?=
 =?us-ascii?Q?ddlHj1Jv/2gBaQBL1niNZ+wiqFRQoN8CNPP67usIYAlIwE7HA/5jLpVRZOZM?=
 =?us-ascii?Q?YuErGEly3eqZNjLR5tz5gD37Ww=3D=3D?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 18:30:38.5331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 284033df-925d-4b47-b04a-08dbd3f627d9
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM04FT053.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB5491
X-BESS-ID: 1698085844-110443-12672-250-1
X-BESS-VER: 2019.1_20231020.1656
X-BESS-Apparent-Source-IP: 104.47.56.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuYmhqZAVgZQ0CjR2MAiNTHRIM
	nCMtnYNDXJ0tTAxMjMwMDMyNgyMSVVqTYWAE+2GyxBAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.251639 [from 
	cloudscan9-231.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA085b, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

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
the vfs changes are acceptable.

v10:
    - Updates to Amirs suggestions (WARN_ONCE and graceful error code
      path instead of BUG_ON) in lookup_open
    - After discussion with Amir what patch 3 and 4 are about, change them
      into atomic-open-revalidate with (3)  and without (4) O_CREAT,
      instead of atomic-open-revalidate + optimization.
    - Fix opening of symlinks, thanks a lot Yuan for testing an reporting!
      To make reviews easier this is two fold:
          - In patch 2/8 it just falls back to create open (and expects
            server side not to hold a reference), in 8/8 the fallback and
            additional lookup is avoided (server needs to have an inode
            reference).
    - Fix smatch errors
        - lookup_open() error: uninitialized symbol 'error'.
        - atomic_revalidate_open() warn: variable dereferenced before
          check 'got_write'
        - error: 'switched_entry' dereferencing possible ERR_PTR()
    - rebase to 6.6, use ATTR_TIMEOUT()
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
Cc: Yuan Yao <yuanyaogoog@chromium.org>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org

Bernd Schubert (7):
  fuse: rename fuse_create_open
  fuse: introduce atomic open
  [RFC] Allow atomic_open() on positive dentry (w/o O_CREAT)
  fuse: Revalidate positive entries in fuse_atomic_open
  fuse: Return D_REVALIDATE_ATOMIC for cached dentries
  fuse: Avoid code duplication in atomic open
  fuse atomic open: No fallback for symlinks, just call finish_no_open

Miklos Szeredi (1):
  [RFC] Allow atomic_open() on positive dentry (O_CREAT)

 fs/fuse/dir.c             | 395 +++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h          |   6 +
 fs/namei.c                |  77 +++++++-
 include/linux/namei.h     |   7 +
 include/uapi/linux/fuse.h |   3 +
 5 files changed, 474 insertions(+), 14 deletions(-)

-- 
2.39.2


