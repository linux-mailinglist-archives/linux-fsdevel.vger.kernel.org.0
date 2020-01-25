Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 719B31492E6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2020 03:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbgAYCLX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 21:11:23 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18992 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387700AbgAYCLX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 21:11:23 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e2ba39a0000>; Fri, 24 Jan 2020 18:10:34 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 24 Jan 2020 18:11:21 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 24 Jan 2020 18:11:21 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 25 Jan
 2020 02:11:21 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 25 Jan 2020 02:11:20 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e2ba3c70000>; Fri, 24 Jan 2020 18:11:19 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 3/3] selftests/vm: run_vmtests: invoke gup_benchmark with basic FOLL_PIN coverage
Date:   Fri, 24 Jan 2020 18:11:15 -0800
Message-ID: <20200125021115.731629-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200125021115.731629-1-jhubbard@nvidia.com>
References: <20200125021115.731629-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579918234; bh=Q/jtf1QAQWUBdGa6x5cGwrQgIxtlzXz53YFDTgazJkU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=YRayoKwVWfcKD4eUMaQmPaMUzOn3k3p53WvmOC3mD8kcC9tG8ipSm3QY2AYmfpimP
         G30FLgFM/n8OFc+ELkRXdpg4CVFeF4Db+7MZ8t+9rCJYTGgkgE7nkM+uQmNjjIESKv
         K++LFcD1w8MRIanajdKRRI6TRSxoHU4sw5YS8BYyv3WuVM2X9HxdOMBb6tEUyA5q25
         jIAaxS4VBkm7t15cy3eXQOGQyDQnb1Tj43T/DYGXJO24+gEkKxLy/uqWKL+yETfOcX
         WELUvnoev8o4RAccDfka/sHfmg4DNthyYgpypJHix4p2C+hZDPiuNCZ+i461MllWUg
         UFQJXN1SdQh6A==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It's good to have basic unit test coverage of the new FOLL_PIN
behavior. Fortunately, the gup_benchmark unit test is extremely
fast (a few milliseconds), so adding it the the run_vmtests suite
is going to cause no noticeable change in running time.

So, add two new invocations to run_vmtests:

1) Run gup_benchmark with normal get_user_pages().

2) Run gup_benchmark with pin_user_pages(). This is much like
the first call, except that it sets FOLL_PIN.

Running these two in quick succession also provide a visual
comparison of the running times, which is convenient.

The new invocations are fairly early in the run_vmtests script,
because with test suites, it's usually preferable to put the
shorter, faster tests first, all other things being equal.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/vm/run_vmtests | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftes=
ts/vm/run_vmtests
index a692ea828317..df6a6bf3f238 100755
--- a/tools/testing/selftests/vm/run_vmtests
+++ b/tools/testing/selftests/vm/run_vmtests
@@ -112,6 +112,28 @@ echo "NOTE: The above hugetlb tests provide minimal co=
verage.  Use"
 echo "      https://github.com/libhugetlbfs/libhugetlbfs.git for"
 echo "      hugetlb regression testing."
=20
+echo "--------------------------------------------"
+echo "running 'gup_benchmark -U' (normal/slow gup)"
+echo "--------------------------------------------"
+./gup_benchmark -U
+if [ $? -ne 0 ]; then
+	echo "[FAIL]"
+	exitcode=3D1
+else
+	echo "[PASS]"
+fi
+
+echo "------------------------------------------"
+echo "running gup_benchmark -b (pin_user_pages)"
+echo "------------------------------------------"
+./gup_benchmark -b
+if [ $? -ne 0 ]; then
+	echo "[FAIL]"
+	exitcode=3D1
+else
+	echo "[PASS]"
+fi
+
 echo "-------------------"
 echo "running userfaultfd"
 echo "-------------------"
--=20
2.25.0

