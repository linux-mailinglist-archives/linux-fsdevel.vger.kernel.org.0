Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C37515BA1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Apr 2022 11:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382371AbiD3JFN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Apr 2022 05:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356402AbiD3JFJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Apr 2022 05:05:09 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64F763F8BC
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Apr 2022 02:01:41 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id C1F8A15F93A;
        Sat, 30 Apr 2022 18:01:39 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 23U91cNw100927
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 30 Apr 2022 18:01:39 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 23U91cLG182116
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 30 Apr 2022 18:01:38 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 23U91cx5182115;
        Sat, 30 Apr 2022 18:01:38 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Chung-Chiang Cheng <cccheng@synology.com>
Cc:     linux-fsdevel@vger.kernel.org, kernel@cccheng.net,
        shepjeng@gmail.com
Subject: Re: [PATCH v5 3/3] fat: report creation time in statx
References: <20220430044127.2384398-1-cccheng@synology.com>
        <20220430044127.2384398-3-cccheng@synology.com>
Date:   Sat, 30 Apr 2022 18:01:38 +0900
In-Reply-To: <20220430044127.2384398-3-cccheng@synology.com> (Chung-Chiang
        Cheng's message of "Sat, 30 Apr 2022 12:41:27 +0800")
Message-ID: <87sfpv3pxp.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Chung-Chiang Cheng <cccheng@synology.com> writes:

> creation time is no longer mixed with change time. Add an in-memory
> field for it, and report it in statx if supported.
>
> fat_truncate_crtime() is also removed. Because crtime comes from only
> the following two cases and won't be changed afterward.
>
> (1) vfat_lookup
> (2) vfat_create/vfat_mkdir -> vfat_add_entry -> vfat_build_slots
>
> They are all in {cdate:16, ctime:16, ctime_cs:8} format, which ensures
> crtime will be kept at the correct granularity (10 ms). The remaining
> timestamps may be copied from the vfs inode, so we need to truncate them
> to fit FAT's format. But crtime doesn't need to do that.

Hm, maybe right.  I'm not checking fully though, then we can remove
fat_truncate_time() in vfat_create/mkdir()?

(Actually msdos too though, the state of timestamps for msdos is
strange, mean on-disk and in-core timestamps are not sync. So not
including for now)

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
