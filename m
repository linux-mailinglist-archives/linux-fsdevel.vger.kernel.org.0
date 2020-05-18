Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81F41D7FCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 19:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgERRNm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 13:13:42 -0400
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:44514 "EHLO
        2.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgERRNm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 13:13:42 -0400
X-Greylist: delayed 4201 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 May 2020 13:13:41 EDT
Received: from player798.ha.ovh.net (unknown [10.110.208.89])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id 42ED8168533
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 17:58:01 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player798.ha.ovh.net (Postfix) with ESMTPSA id 29568129663CE;
        Mon, 18 May 2020 15:57:55 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-97G00222661789-8dca-4ca8-b9c0-ddda35ef7b93,684EF6CDF7F8D64881578A2CD861565D4C1A1A2F) smtp.auth=steve@sk2.org
From:   Stephen Kitt <steve@sk2.org>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] sysctl: const-ify ngroups_max
Date:   Mon, 18 May 2020 17:57:27 +0200
Message-Id: <20200518155727.10514-1-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12720698623947722133
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddthedgleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ngroups_max is a read-only sysctl entry, reflecting NGROUPS_MAX. Make
it const, in the same way as cap_last_cap.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
This is split out from 2f4c33063ad7 ("docs: sysctl/kernel: document
ngroups_max") which conflicted with f461d2dcd511 ("sysctl: avoid forward
declarations").

 kernel/sysctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 349cab382081..cc1fcba9d4d2 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -133,7 +133,7 @@ static unsigned long dirty_bytes_min = 2 * PAGE_SIZE;
 static int maxolduid = 65535;
 static int minolduid;
 
-static int ngroups_max = NGROUPS_MAX;
+static const int ngroups_max = NGROUPS_MAX;
 static const int cap_last_cap = CAP_LAST_CAP;
 
 /*
@@ -2232,7 +2232,7 @@ static struct ctl_table kern_table[] = {
 #endif
 	{
 		.procname	= "ngroups_max",
-		.data		= &ngroups_max,
+		.data		= (void *)&ngroups_max,
 		.maxlen		= sizeof (int),
 		.mode		= 0444,
 		.proc_handler	= proc_dointvec,

base-commit: bdecf38f228bcca73b31ada98b5b7ba1215eb9c9
-- 
2.20.1

