Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D874B4528DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 04:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237364AbhKPEBW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 23:01:22 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:27212 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237195AbhKPEBM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 23:01:12 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HtXL76Jrcz8tvq;
        Tue, 16 Nov 2021 11:56:31 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 16 Nov 2021 11:58:14 +0800
Received: from use12-sp2.huawei.com (10.67.189.20) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 16 Nov 2021 11:58:14 +0800
From:   Jubin Zhong <zhongjubin@huawei.com>
To:     <hch@infradead.org>
CC:     <kechengsong@huawei.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
        <wangfangpeng1@huawei.com>, <zhongjubin@huawei.com>
Subject: Re: [PATCH] fs: Fix truncate never updates m/ctime
Date:   Tue, 16 Nov 2021 11:58:10 +0800
Message-ID: <1637035090-52547-1-git-send-email-zhongjubin@huawei.com>
X-Mailer: git-send-email 1.8.5.6
In-Reply-To: <YZKfr5ZIvNBmKDQI@infradead.org>
References: <YZKfr5ZIvNBmKDQI@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.20]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Mon, Nov 15, 2021 at 07:00:18PM +0800, Jubin Zhong wrote:
>> From: zhongjubin <zhongjubin@huawei.com>
>> 
>> Syscall truncate() never updates m/ctime even if the file size is
>> changed. However, this is incorrect according to man file:
>> 
>>   truncate (2):
>>   If  the  size  changed, then the st_ctime and st_mtime fields
>>   (respectively, time of last status change and time of last modification;
>>   see stat(2)) for the file are updated, and the set-user-ID and
>>   set-group-ID mode bits may be cleared.
>> 
>> Check file size before do_truncate() to fix this.
>
> Please try to actually reproduce your alleged "bug".  And maybe also
> look at the actual setattr implementations.  Hint: The XFS one even
> has extensive comments.

Thanks for your advice. I found this problem on yaffs2 in the beginning,
ftruncate() always works fine but truncate() does not. Now I have done 
a few more tests and the following are the results:

Test Environmont:
	kernel: Linux Kernel v5.16
	hardware: QEMU emulator version 3.1.0
	arch: vexpress-v2p-ca9

Teset Results:
	filesystems     m/ctime updated by truncate?
	jffs2           fail
	yaffs2          fail
	ubifs           success
	ext2            success
	ext4            success
	tmpfs           success
	xfs             success

Test Steps:
	1. cd /path/to/mnt/point
	2. dd if=/dev/zero of=test bs=1M count=1
	3. stat test
	4. /bin/my_truncate -s 1024 test
	5. stat test
	6. compare m/ctime of step 5 with step 3

Program source:
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <unistd.h>
	#include <sys/types.h>
	int main(int argc, char **argv)
	{
		int ret;
		char file_name[128] = {0};
		
		if (argc < 4 || argv == NULL || argv[1] == NULL || argv[2] == NULL || argv[3] == NULL) {
			return -1;
		}
		
		if (strcmp(argv[1], "-s")) {
			return -1;
		}
		
		if (realpath(argv[3], file_name) == NULL) {
			printf("truncate: input file name %s err.\n", argv[3]);
			return -1;
		}
		
		off_t size = (off_t)strtol(argv[2], 0, 0);
		ret = truncate(file_name, size);
		if (ret) {
			printf("truncate return err %d\n", ret);
		}   
		return ret;
	}   

I work on embedded devices so concern about jffs2/yaffs2/ubifs the most. 
If there are any errors in my test program please let me know.

Thanks.
