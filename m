Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B07B6F3E6F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 09:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjEBHgN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 03:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbjEBHgL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 03:36:11 -0400
X-Greylist: delayed 426 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 May 2023 00:36:09 PDT
Received: from out-33.mta1.migadu.com (out-33.mta1.migadu.com [95.215.58.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C1AA7
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 00:36:09 -0700 (PDT)
Message-ID: <5683716d-9b1d-83d6-9dd1-a7ad3d05cbb1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683012541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jzCTaX5QqHIzcnQYUNgKpxeG5oQbABeP8YtdxvhEkoY=;
        b=gaP6Wgtj5ThKgz3Q15jUn17ckxESUjroZAwDmaCbcnQZAYKcpreBRs/HxWEYBxj5bWv3lR
        Erow+92AsAesMxp00/7nt7y1JO6LEHqp1iGbK9898ZD9IXAeC1Hk5bYWF9R+vsOPgrBeYL
        doVww22+lJJmFKmnGPjO1ckPW74zdVA=
Date:   Tue, 2 May 2023 15:28:50 +0800
MIME-Version: 1.0
Content-Language: en-US
To:     "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>,
        miklos@szeredi.hu
Cc:     Antonio SJ Musumeci <trapexit@spawn.link>,
        linux-fsdevel@vger.kernel.org,
        Bernd Schubert <bernd.schubert@fastmail.fm>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Hao Xu <hao.xu@linux.dev>
Subject: [RFC] FUSE: add another flag to support shared mmap in
 FOPEN_DIRECT_IO mode
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

 From discussion with Bernd, I get that FOPEN_DIRECT_IO is designed for 
those user cases where users want strong coherency like network 
filesystems, where one server serves multiple remote clients. And thus 
shared mmap is disabled since local page cache existence breaks this 
kind of coherency.

But here our use case is one virtiofs daemon serve one guest vm, We use 
FOPEN_DIRECT_IO to reduce memory footprint not for coherency. So we 
expect shared mmap works in this case. Here I suggest/am implementing 
adding another flag to indicate this kind of cases----use 
FOPEN_DIRECT_IO not for coherency----so that shared mmap works.


Thanks,

Hao

