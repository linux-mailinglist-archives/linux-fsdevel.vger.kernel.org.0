Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A44964FC0F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Dec 2022 20:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiLQTS6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Dec 2022 14:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLQTS5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Dec 2022 14:18:57 -0500
Received: from ms11p00im-qufo17291601.me.com (ms11p00im-qufo17291601.me.com [17.58.38.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E85010054
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Dec 2022 11:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1671303163;
        bh=cQvKWX9oxZ8qf4HKTzFAJpzwOKnJig3zefwHcLSTHTo=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=cpqpUkL5+Nrd7bTaRYhHCYRnPHrGByhDcGgVfwqSdUJ6UBp7ziBdODf+y1gx6elYH
         fSJKRskBSQtAOnk+a2dhKRfwzxc8aE799KMF3f9BRZJBbHDB5a5tY9ZT0OJIoMtg0P
         jUquAFMO7yXEK7HTEYVCQJQBRiuLKTnsoQEUcuKQLqGz9u7HCbQ2aVasHDqKEcWGjl
         H74s/7MEq2xSjES8h7t5uQ2prJPXAWdYXzGnZ1yX74dwejugvSfPuBRvs3EyRzNrSj
         Plu7pof4mO0gXOavSTQsXiht6LB47lkZjMBdT6ZUyFRetXTFnvvR+vcg2CrbPkXYLP
         j8mZ6A4Y51EjQ==
Received: from thundercleese.localdomain (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
        by ms11p00im-qufo17291601.me.com (Postfix) with ESMTPSA id B9AAF3A050B;
        Sat, 17 Dec 2022 18:52:38 +0000 (UTC)
From:   Eric Van Hensbergen <evanhensbergen@icloud.com>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com,
        Eric Van Hensbergen <evanhensbergen@icloud.com>
Subject: [PATCH] Improve 9p performance for read operations 
Date:   Sat, 17 Dec 2022 18:52:04 +0000
Message-Id: <20221217185210.1431478-1-evanhensbergen@icloud.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: M3HM9CylG59iES4mWdLXbl-B15ehdZXk
X-Proofpoint-ORIG-GUID: M3HM9CylG59iES4mWdLXbl-B15ehdZXk
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 adultscore=0
 mlxlogscore=677 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2212170174
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series adds a number of features to improve read/write 
performance in the 9p filesystem.  Mostly it is focused on fixing
readahead caching to help utilize the recently increased MSIZE
limits, but there are also some fixes for writeback caches in the
presence of readahead and/or mmap operations.

Altogether, these show roughly 10x speed increases on simple
file transfer.  Future patch sets will improve writeback cache
behavior and directory caching.

These patches are also available on github:
https://github.com/v9fs/linux/tree/ericvh/9p-next-121722

Tested against qemu, cpu, and diod with fsx, dbench, and
some simple benchmarks.

Signed-off-by: Eric Van Hensbergen <evanhensbergen@icloud.com>


