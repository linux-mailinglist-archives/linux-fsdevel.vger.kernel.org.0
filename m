Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A160F511F35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 20:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244364AbiD0RvF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 13:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiD0RvE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:51:04 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4019443C3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 10:47:52 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 3D57115F939;
        Thu, 28 Apr 2022 02:47:52 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 23RHlpCM005775
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 02:47:52 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 23RHloo7016719
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 02:47:50 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 23RHloCn016718;
        Thu, 28 Apr 2022 02:47:50 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Chung-Chiang Cheng <cccheng@synology.com>
Cc:     linux-fsdevel@vger.kernel.org, kernel@cccheng.net,
        shepjeng@gmail.com
Subject: Re: [PATCH v4 1/3] fat: split fat_truncate_time() into separate
 functions
References: <20220423032348.1475539-1-cccheng@synology.com>
Date:   Thu, 28 Apr 2022 02:47:50 +0900
In-Reply-To: <20220423032348.1475539-1-cccheng@synology.com> (Chung-Chiang
        Cheng's message of "Sat, 23 Apr 2022 11:23:46 +0800")
Message-ID: <877d7axvsp.fsf@mail.parknet.co.jp>
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

> +/*
> + * truncate atime to 24 hour granularity (00:00:00 in local timezone)
> + */
> +void fat_truncate_atime(struct msdos_sb_info *sbi, struct timespec64 *ts,
> +			struct timespec64 *atime)

[...]

> +void fat_truncate_crtime(struct msdos_sb_info *sbi, struct timespec64 *ts,
> +			 struct timespec64 *crtime)

[...]

> +void fat_truncate_mtime(struct msdos_sb_info *sbi, struct timespec64 *ts,
> +			struct timespec64 *mtime)

Small stuff and not strong opinion though, those are better to return
timespec64, instead of taking pointer? Because we can

	mtime = ctime = fat_truncate_mtime(sbi, &ts);

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
