Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7574512A826
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2019 14:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfLYNQU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Dec 2019 08:16:20 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:49602 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726353AbfLYNQU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Dec 2019 08:16:20 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9A3DD1D59AB17D2663EB;
        Wed, 25 Dec 2019 21:16:17 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.179) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Dec 2019
 21:16:10 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Subject: [QUESTION] question about the errno of rename the parent dir to a
 subdir of a specified directory
To:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <miaoxie@huawei.com>,
        <zhangtianci1@huawei.com>
Message-ID: <4c54c1f0-fe9a-6dea-1727-6898e8dd85ef@huawei.com>
Date:   Wed, 25 Dec 2019 21:16:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.179]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

If we rename the parent-dir to a sub-dir of a specified directory, the
rename() syscall return -EINVAL because lock_rename() in lock_rename()
checks the relations of the sorece and dest dirs. But if the 'parent'
dir is a mountpoint, the rename() syscall return -EXDEV instead because
it checks the parent dir's mountpoint of the sorece and dest dirs.

For example:
Case 1: rename() return -EINVAL
# mkdir -p parent/dir
# rename parent parent/dir/subdir parent
rename: parent: rename to parent/dir/subdir failed: Invalid argument

Case 2: rename() return -EXDEV
# mkdir parent
# mount -t tmpfs test parent
# mkdir parent/dir
# rename parent parent/dir/subdir parent
rename: parent: rename to parent/dir/subdir failed: Invalid cross-device link

In case 2, although 'parent' directory is a mountpoint, it acted as a root
dir of the "test tmpfs", so it should belongs to the same mounted fs of
'dir' directoty, so I think it shall return -EINVAL.

Is it a bug or just designed as this ?

Thanks,
Yi.

