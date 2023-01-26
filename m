Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFBB67D6EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjAZU5m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjAZU5l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:57:41 -0500
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DB734C08;
        Thu, 26 Jan 2023 12:57:37 -0800 (PST)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1pL9JN-0001D5-1b;
        Thu, 26 Jan 2023 15:57:33 -0500
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        kernel-team@meta.com, linux-fsdevel@vger.kernel.org,
        gscrivan@redhat.com
Subject: [PATCH 0/2] ipc,namespace: fix free vs allocation race
Date:   Thu, 26 Jan 2023 15:57:19 -0500
Message-Id: <20230126205721.582612-1-riel@surriel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The IPC namespace code frees ipc_namespace structures asynchronously,
via a work queue item. This results in ipc_namespace structures being
freed very slowly, and the allocation path getting false failures
since the to-be-freed ipc_namespace structures have not been freed
yet.

Fix that by having the allocator wait when there are ipc_namespace
structures pending to be freed.

Also speed up the freeing of ipc_namespace structures. We had some
discussions about this last year, and ended up trying out various
"nicer" ideas that did not work, so I went back to the original,
with Al Viro's suggestion for a helper function:

https://lore.kernel.org/all/Yg8StKzTWh+7FLuA@zeniv-ca.linux.org.uk/

This series fixes both the false allocation failures, and the slow
freeing of ipc_namespace structures.


