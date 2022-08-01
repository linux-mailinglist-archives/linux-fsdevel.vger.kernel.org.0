Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1630A586D97
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 17:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiHAPU3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 11:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbiHAPUW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:20:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D7A6541;
        Mon,  1 Aug 2022 08:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659367217;
        bh=UovwDaLyuTgPejCzTK254N9IC9/vqRLIfV2J6pi3cos=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=gDZ6ap1GhRW3wDRPzYWXITLNEYJSxGMUzAMNiH8T/AbLtQzF38Zrcifu+D92uD+FE
         N60nsyQ6KS0v++CMaVCslO6pEopN1sk0ii7QufidIA8s8KN8kdbPEvq1NiroP27YV2
         zPQl1cI6nEyzl70MD/jSjzS6rWhZ/+QqdKFHXr6I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100.fritz.box ([92.116.150.19]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUj2-1nQyrD17Zq-00rWmA; Mon, 01
 Aug 2022 17:20:17 +0200
From:   Helge Deller <deller@gmx.de>
To:     linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] x86/fault: Dump command line of faulting process to syslog
Date:   Mon,  1 Aug 2022 17:20:16 +0200
Message-Id: <20220801152016.36498-4-deller@gmx.de>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220801152016.36498-1-deller@gmx.de>
References: <20220801152016.36498-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KxWWu6d4Mf/HNZfb1iWzcFG+92jgDSJNUGRPzZjgSQlUKy2+Tkm
 BjxgNCup3o7EzTK7JqLhVfq4Sgenz2XfBiGqB6kKOHAgDJ7dkSfUVDWhXcJ59ogtQVDLxXe
 giv3v+nVJB6hw1OWd9TurCZK3OEUUW4kMzAke+wax9s4dZN7+WX1VTiHzqUFL0XWg7sYG0v
 d47uwu4Ar5S0FjSFZmWpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e6dDOJQOd/E=:ae8KEjXxSSY8z7qEgqLoRT
 9Oy2SV3hu8ax6rhtx6rqY9L7/Xd/gnUXV+n76xOskY6c+RzHFw/jVm9AxVZ7d8mEPHornlUYb
 +v7b1p/MH9pPNVRs+T/t4NRR7brQy9mBMpYs8nKzmJIj/2gldv7eYw7urPxQJilWTTwsLyA26
 15mgvYsmTMEmIYWXbizskHtDNlGclsV/qgVLjp6OdT9jcCU3bzgg42PI5huC6uDgYGWyoGDB7
 kJBAYGInO6igzVfF1VN95K6p5pZiERslxpQxA+x9XQ1IrUVqBkCybdM2cwMleR1pPZm93OAan
 5Zi07HzQa1r8qab5AIwDg2+dxtHhzUtA6m7qXdzgxdXt3Gh1sdktHzsFp5pFWRNNsFTqMryIL
 xtF0apeRQXn6X+/2hYO+//FTbFZSFiZoN3LXAYCPQ9cZwH7NshZWbaftWA3E9th/e13RlCgZ2
 D5mK9t3cxIT1lFVH2HDoQtr2U9w5lfDAsGz2M3MBatiHQ9h5eostzwsarBapZsTL8JCCydbFw
 4qKhqqQqnP4PeW7B5a/TctuEvvYLpQbr+1PGV/m3RC026MTC0ZG7B65PdKwUPqy+nHwkU2twg
 4j3d/G75e/Qg17DGNCKh3woIdkIz91MhTwma08hHjC66t2+IW+iKQYMeHqmJRHOKa4yfzlGEW
 yC7VJVhbzPqEXOo4qM5XLWOApLu07oDYyxeBjopY7bJLR9b52PsA4evrRq8SvWS5ic7ByzgFU
 942EZgn6tZrmsGg/jxZs7n/sNV2Ob/jmm/V64WWdiISheNFqK9dXwVS9wN8DdWs2ChsXn4Jxk
 vkP5J3b4ZkfBKmUAfX8nrdUuYOXPtqDGCLgCY5BI1JpAJ9vL965TGxfnTbWFSftqpTIHPHPfh
 BwpAF4P9y6A7MNtsmz6/wAXPpZ9/FFcyuI+IbmvSiBQhCJzMYZWeK8safXiSVDmuFTv0Nh+Gj
 6T+CAVea0kodv1I2hQmk/AAHfGlkqERRTB+1XrErpLXLHfHvfaA/eYToJ4eetZ5Uspl/XfEfR
 bL7lxciRIK4V1uzdtfkGTyGqZNmtkzjcpVyiu6Ucbhu3AqtzEYEmBjjrMNWrf5dENlCjFZvkp
 EKFfMI98Ru/W6uO47qC6L/w3kLEhugldjNtJRcfg2OA2Rj4a7DZM+wzHQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a process segfaults, include the command line of the faulting process
in the syslog.

In the example below, the "crash" program (which simply writes zero to add=
ress 0)
was called with the parameters "this is a test":

 crash[2326]: segfault at 0 ip 0000561a7969c12e sp 00007ffe97a05630 error =
6 in crash[561a7969c000+1000]
 crash[2326] cmdline: ./crash this is a test
 Code: 68 ff ff ff c6 05 19 2f 00 00 01 5d c3 0f 1f 80 00 00 00 00 c3 0f 1=
f 80 00 00 00 00 e9 7b ff ff ff 55 48 89 e5 b8 00 00 00 00 <c7> 00 01 00 0=
0 00 b8 00 00 00 00 5d c3 0f 1f 44 00 00 41 57 4c 8d

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 arch/x86/mm/fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index fad8faa29d04..d4e21c402e29 100644
=2D-- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -784,6 +784,8 @@ show_signal_msg(struct pt_regs *regs, unsigned long er=
ror_code,

 	printk(KERN_CONT "\n");

+	dump_stack_print_cmdline(loglvl);
+
 	show_opcodes(regs, loglvl);
 }

=2D-
2.37.1

