Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0AAB1B69E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2019 15:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbfEMNDq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 May 2019 09:03:46 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32935 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728743AbfEMNDq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 May 2019 09:03:46 -0400
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 134B4B112C6D8409069F;
        Mon, 13 May 2019 14:03:44 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.36) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 13 May
 2019 14:03:33 +0100
Subject: Re: [PATCH v2 3/3] initramfs: introduce do_readxattrs()
To:     Jann Horn <jannh@google.com>
CC:     <viro@zeniv.linux.org.uk>, <linux-security-module@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <initramfs@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zohar@linux.vnet.ibm.com>,
        <silviu.vlasceanu@huawei.com>, <dmitry.kasatkin@huawei.com>,
        <takondra@cisco.com>, <kamensky@cisco.com>, <hpa@zytor.com>,
        <arnd@arndb.de>, <rob@landley.net>, <james.w.mcmechan@gmail.com>
References: <20190509112420.15671-1-roberto.sassu@huawei.com>
 <20190509112420.15671-4-roberto.sassu@huawei.com>
 <20190510213340.GE253532@google.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <bc72d312-07ce-51a3-4554-358d074f9c7d@huawei.com>
Date:   Mon, 13 May 2019 15:03:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190510213340.GE253532@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/10/2019 11:33 PM, Jann Horn wrote:
> On Thu, May 09, 2019 at 01:24:20PM +0200, Roberto Sassu wrote:
>> This patch adds support for an alternative method to add xattrs to files in
>> the rootfs filesystem. Instead of extracting them directly from the ram
>> disk image, they are extracted from a regular file called .xattr-list, that
>> can be added by any ram disk generator available today.
> [...]
>> +struct path_hdr {
>> +	char p_size[10]; /* total size including p_size field */
>> +	char p_data[];  /* <path>\0<xattrs> */
>> +};
>> +
>> +static int __init do_readxattrs(void)
>> +{
>> +	struct path_hdr hdr;
>> +	char str[sizeof(hdr.p_size) + 1];
>> +	unsigned long file_entry_size;
>> +	size_t size, name_buf_size, total_size;
>> +	struct kstat st;
>> +	int ret, fd;
>> +
>> +	ret = vfs_lstat(XATTR_LIST_FILENAME, &st);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	total_size = st.size;
>> +
>> +	fd = ksys_open(XATTR_LIST_FILENAME, O_RDONLY, 0);
>> +	if (fd < 0)
>> +		return fd;
>> +
>> +	while (total_size) {
>> +		size = ksys_read(fd, (char *)&hdr, sizeof(hdr));
> [...]
>> +	ksys_close(fd);
>> +
>> +	if (ret < 0)
>> +		error("Unable to parse xattrs");
>> +
>> +	return ret;
>> +}
> 
> Please use something like filp_open()+kernel_read()+fput() instead of
> ksys_open()+ksys_read()+ksys_close(). I understand that some of the init
> code needs to use the syscall wrappers because no equivalent VFS
> functions are available, but please use the VFS functions when that's
> easy to do.

Ok. Thanks for the suggestion.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
