Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F84055EC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 04:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfFZCeY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 22:34:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53852 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfFZCeW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 22:34:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q2TYh8026692;
        Wed, 26 Jun 2019 02:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=fawPQY/UISfSH6DvrztcWabWXm47TtXieQJWSELxOKQ=;
 b=G/aYnUXEphMoz0tS57JlzzJidDTnCP3JwQDBotgjzdUejbyDPYJP0ww7UIoJ9qziXtze
 V8WfKNQm07ANAuCm8B36a/SSrlnF4iTQcfj6+NLwHRqJVTP47OZew3gQAlm23ALl0Umk
 xq3Im7dO6UOb8iISWt8zfUFMNhrviliNGlkVCg5a0cfeb27h0Drq5G4rl1p6MZONDA9T
 LOJ0700Z6AtHwS+rK56pnb/hADrt/VxtC4zKanyLYIE10jvKJ1zJCdEbZq2d2Ps/KjeI
 pOTljCBSvtHNdPtMRfVj73W2qgv94B8p+0UE9rS1oOhD12Oac8PGEIcskWt9iHiUUTuy 2A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2t9c9pqjk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 02:33:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q2Wj2o020612;
        Wed, 26 Jun 2019 02:33:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 2t9p6uh2eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Jun 2019 02:33:07 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5Q2X7If021156;
        Wed, 26 Jun 2019 02:33:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2t9p6uh2ec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 02:33:07 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5Q2X6O7021146;
        Wed, 26 Jun 2019 02:33:06 GMT
Received: from localhost (/10.159.230.235) by default (Oracle Beehive Gateway
 v4.0) with ESMTP ; Tue, 25 Jun 2019 19:32:55 -0700
USER-AGENT: StGit/0.17.1-dirty
MIME-Version: 1.0
Message-ID: <156151637248.2283603.8458727861336380714.stgit@magnolia>
Date:   Tue, 25 Jun 2019 19:32:52 -0700 (PDT)
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
        darrick.wong@oracle.com, ard.biesheuvel@linaro.org,
        josef@toxicpanda.com, hch@infradead.org, clm@fb.com,
        adilger.kernel@dilger.ca, viro@zeniv.linux.org.uk, jack@suse.com,
        dsterba@suse.com, jaegeuk@kernel.org, jk@ozlabs.org
Cc:     reiserfs-devel@vger.kernel.org, linux-efi@vger.kernel.org,
        devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH v5 0/5] vfs: make immutable files actually immutable
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260027
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

The chattr(1) manpage has this to say about the immutable bit that
system administrators can set on files:

"A file with the 'i' attribute cannot be modified: it cannot be deleted
or renamed, no link can be created to this file, most of the file's
metadata can not be modified, and the file can not be opened in write
mode."

Given the clause about how the file 'cannot be modified', it is
surprising that programs holding writable file descriptors can continue
to write to and truncate files after the immutable flag has been set,
but they cannot call other things such as utimes, fallocate, unlink,
link, setxattr, or reflink.

Since the immutable flag is only settable by administrators, resolve
this inconsistent behavior in favor of the documented behavior -- once
the flag is set, the file cannot be modified, period.  We presume that
administrators must be trusted to know what they're doing, and that
cutting off programs with writable fds will probably break them.

Therefore, add immutability checks to the relevant VFS functions, then
refactor the SETFLAGS and FSSETXATTR implementations to use common
argument checking functions so that we can then force pagefaults on all
the file data when setting immutability.

Note that various distro manpages points out the inconsistent behavior
of the various Linux filesystems w.r.t. immutable.  This fixes all that.

I also discovered that userspace programs can write and create writable
memory mappings to active swap files.  This is extremely bad because
this allows anyone with write privileges to corrupt system memory.  The
final patch in this series closes off that hole, at least for swap
files.

If you're going to start using this mess, you probably ought to just
pull from my git trees, which are linked below.

This has been lightly tested with fstests.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=immutable-files

fstests git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=immutable-files
