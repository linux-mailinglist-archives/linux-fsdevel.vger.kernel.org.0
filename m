Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193BF650584
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Dec 2022 00:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiLRXWm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Dec 2022 18:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLRXWl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Dec 2022 18:22:41 -0500
Received: from ms11p00im-qufo17281301.me.com (ms11p00im-qufo17281301.me.com [17.58.38.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E390EB7C2
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Dec 2022 15:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1671405758;
        bh=JmrAaG8n6wlsJeq35GHNyFYu48X5e3mJuVGT5tcjLUU=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=UTlhkqKyTc1y1312R52C3sNENOuaqc0VX3x2dr/4+oqkfDXtGB243pjhxO5hMhYV0
         NLqMuYK5WK7Sh/w2sx8C4JlfLRalyrhqCOflS4Qbne+oCq6RIETEfhtJk2zlRKuSYZ
         E2yAlIiDIZ14SJkjEwQ8hvokwpXM5L1Ci1qOSTmq1OQbcdSxsENFtzZsPxWQa/0Y8B
         nSmE1kHpBAytkJWC/1hX2REWjj+P0tczNwLY+J9/zF8p3RgLill9bz9d53PG/ZXvtQ
         OsZrwA5/tXO7gIyQA4v1fFXUgvOipHkodoYz0GWa2Ir+rGfPhw1M43UQYhvW4j7+GP
         HHaU8Ja6ltXCQ==
Received: from thundercleese.localdomain (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
        by ms11p00im-qufo17281301.me.com (Postfix) with ESMTPSA id A5DC5CC03C2;
        Sun, 18 Dec 2022 23:22:37 +0000 (UTC)
From:   Eric Van Hensbergen <evanhensbergen@icloud.com>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com,
        Eric Van Hensbergen <evanhensbergen@icloud.com>
Subject: [PATCH v2 00/10] Performance fixes for 9p filesystem  
Date:   Sun, 18 Dec 2022 23:22:07 +0000
Message-Id: <20221218232217.1713283-1-evanhensbergen@icloud.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221217183142.1425132-1-evanhensbergen@icloud.com>
References: <20221217183142.1425132-1-evanhensbergen@icloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: M_YhFlaQCGW3-w-aAqmMT-TC2sbluUfm
X-Proofpoint-GUID: M_YhFlaQCGW3-w-aAqmMT-TC2sbluUfm
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=975 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2212180222
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the second version of a patch series which adds a number
of features to improve read/write performance in the 9p filesystem.
Mostly it focuses on fixing caching to help utilize the recently
increased MSIZE limits and also fixes some problematic behavior
within the writeback code.

Altogether, these show roughly 10x speed increases on simple
file transfers.  Future patch sets will improve cache consistency
and directory caching.

These patches are also available on github:
https://github.com/v9fs/linux/tree/ericvh/9p-next

Tested against qemu, cpu, and diod with fsx, dbench, and some
simple benchmarks.

Signed-off-by: Eric Van Hensbergen <evanhensbergen@icloud.com>


