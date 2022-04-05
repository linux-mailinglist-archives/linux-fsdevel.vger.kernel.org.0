Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DF14F4D5E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582011AbiDEXlo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457796AbiDEQuo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:50:44 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5528B103;
        Tue,  5 Apr 2022 09:48:42 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id g24so17876639lja.7;
        Tue, 05 Apr 2022 09:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=oBl1Oif8pWocDAaHECT0x6ZPp6TNIUqPxZLXnvi5UQM=;
        b=PVAavuh06x8W32/bpK86QDoufRkE/V0AxIEKwfkFjQjMfv1Ljoo1qMyJNJa2X7oFHh
         x8weufzyFbq9wfdCNuX9DlfIwBQrB0FZ3myypHAZESNj/QZd8fyQigd8B/xiOK+mqa9Q
         7x6aRz1blNZEh1Sog2F0yzgLaJvCwTz9Yc42anifb/f43AKI0UI5IPCKHVub7XUmlcU5
         3wv05uOVXOdBUgYexBCXfKLrhRSIp2WuQd1FnyAgTOI9qSXGaM58SLLVsLC3W7yPayGj
         HJ3aawHEddYLf0hVFbt2jw89Emx2rH7hbrRrHAulWEU7227DMrFLab5LdEoqkyloLvaR
         lsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oBl1Oif8pWocDAaHECT0x6ZPp6TNIUqPxZLXnvi5UQM=;
        b=hnDjWrk2FL3vDWrSG0P7274XQJ4VQTL6w8pzH5nA25JrsRm09eInQzRvMklbVh2Ylq
         G9Jf6IlAR/lJd0sahFrJJlH9rflR9bShW/VKDc+orZ/y2TewpZHd2sahOIGWADbQDT+N
         A7W7ilQB/ccNhjorg938HkWiWku7uu4Ei9xYvJlNNYgK3eqMLVXUkT3UmRs7M9ziBfIh
         imuI0ybYVPuBUrIZ/jW0ep/uQ98yE21iTYLnPnAX3eKG89wrsjK8PlPt4OASpmgw1m3n
         d5pikTp7UISAxKKyz0a9A/5AZfEFAmzI65faY78kVM1VfdU4Ng/xISVPci1rdUSRj+tW
         JWdg==
X-Gm-Message-State: AOAM5301jVZoCS6Iz/jQA0XppyWHE8PQnlet+rG+pyXPoSPEc4ZfDwBq
        uoBh57lH+VAoOZXGfSoEdLjfwb31pg9/26S3qMMYh4M6780=
X-Google-Smtp-Source: ABdhPJwJEEOLMEHKqxnfd/j1+OU9Z7fC+C4l2RYb8m+l/ywNxxbOgsCh/HlNHqiQkKlq+Md5tsRTwQojqHrlacERWVw=
X-Received: by 2002:a2e:bf08:0:b0:247:f79c:5794 with SMTP id
 c8-20020a2ebf08000000b00247f79c5794mr200346ljr.398.1649177320307; Tue, 05 Apr
 2022 09:48:40 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 5 Apr 2022 11:48:29 -0500
Message-ID: <CAH2r5muFq-4J=uedVF9qdYmFzgDDPwuYD+zrLytjUJE+APcBow@mail.gmail.com>
Subject: cross mount reflink and xfstest generic/373
To:     CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I like the patch which allows cross mount reflink (since in some cases
like SMB3 mounts, cross mount reflink can now work depending on the
volumes exported by the server) but was wondering if that means test
generic/373 is getting any changes.  In our test setup the btrfs
directories we export over SMB3.1.1 for SCRATCH and TEST were on the
partition on the server so reflink now works where test 373 expected
them to fail.  I can change our test setup to make sure SCRATCH and
TEST are different volumes or server but was wondering if any recent
changes to reflink related xfstests

commit 9f5710bbfd3031dd7ce244fa26fba896d35f5342
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Fri Feb 18 09:38:14 2022 -0500

    fs: allow cross-vfsmount reflink/dedupe



-- 
Thanks,

Steve
