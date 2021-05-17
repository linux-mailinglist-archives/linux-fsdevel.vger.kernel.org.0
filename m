Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE49386BE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 23:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237435AbhEQVF5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 17:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbhEQVF5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 17:05:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA8EC061573;
        Mon, 17 May 2021 14:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=ql13rlKLv4OPAWCH9i8KAWhh1VDhSbcB2pzitfM5u+k=; b=JZW+yzAiS/5wQMvnvrEPcAVuWJ
        B/G0SX7UMYQUzccP9r9+yabgBrKUAUdHNIsresSjUTW8sxjq7kTtE/0SOfRgY5adz023UOVOdT0pm
        qe9anbFwqN3rN+X9mlCH/3e+8aJij0zys0CGAtm+vxdcp+0aD/jSB/uYILGrZmMxkTvy9U9hbbhCJ
        gd93tZeb6WEmvjTtSVZJ2kOeM76rHcHctx1IHrmp42ddtLq/c4jQ32Ybxy3gPXBv6I5J8eMVTNS8a
        kBgBBiskKF+uIxZRhux2Zcxz7HROQPnuNkFPK6AUCFMBoxjYRguokrZ7zbQUmleCXS5TiSG1CRBNE
        eLPCCXig==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1likPm-00E9PR-M6; Mon, 17 May 2021 21:04:38 +0000
Subject: Re: Fwd: [EXTERNAL] Re: ioctl.c:undefined reference to
 `__get_user_bad'
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <202105110829.MHq04tJz-lkp@intel.com>
 <a022694d-426a-0415-83de-4cc5cd9d1d38@infradead.org>
 <MN2PR21MB15184963469FEC9B13433964E42D9@MN2PR21MB1518.namprd21.prod.outlook.com>
 <CAH2r5mswqB9DT21YnSXMSAiU0YwFUNu0ni6f=cW+aLz4ssA8rw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d3e24342-4f30-6a2f-3617-a917539eac94@infradead.org>
Date:   Mon, 17 May 2021 14:04:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAH2r5mswqB9DT21YnSXMSAiU0YwFUNu0ni6f=cW+aLz4ssA8rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/17/21 10:13 AM, Steve French wrote:
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>    arm-linux-gnueabi-ld: fs/cifs/ioctl.o: in function `cifs_dump_full_key':
>>>> ioctl.c:(.text+0x44): undefined reference to `__get_user_bad'
>>
> 
> <snip>
> 
>> # CONFIG_MMU is not set
>>
>> and arch/arm/include/asm/uaccess.h does not implement get_user(size 8 bytes)
>> for the non-MMU case:
> 
> I see another place in fs/cifs/ioctl.c where we already had been doing
> a get_user() into a u64 - any idea what you are supposed to do
> instead?  Any example code where people have worked around this.

Hi Steve,

This change in cifs_dump_full_key() makes it build OK:

-       if (get_user(suid, (__u64 __user *)arg))
+       if (get_user(suid, (unsigned int __user *)arg))


That is what the other call uses:

		case FS_IOC_SETFLAGS:
			cifs_dbg(VFS, "cifs ioctl FS_IOC_SETFLAGS:\n");
			if (pSMBFile == NULL)
				break;
			tcon = tlink_tcon(pSMBFile->tlink);
			caps = le64_to_cpu(tcon->fsUnixInfo.Capability);

			if (get_user(ExtAttrBits, (int __user *)arg)) {
				rc = -EFAULT;
				break;
			}

However, my reading/understanding is that the one immediately above
is incorrect, as is the -/+ patch above it, since get_user() gets its
data size (1, 2, 4, 8) from the type of the pointer that is passed to it.
For 8 bytes (64 bits), 'int' is not sufficient, so IMO the get_user()
call that builds:
			if (get_user(ExtAttrBits, (int __user *)arg)) {
is a bug. It should be:
			if (get_user(ExtAttrBits, (__u64 __user *)arg)) {
and if I make that latter change in the source file, the build says:

arm-linux-gnueabi-ld: fs/cifs/ioctl.o: in function `cifs_dump_full_key':
ioctl.c:(.text+0x14): undefined reference to `__get_user_bad'
arm-linux-gnueabi-ld: fs/cifs/ioctl.o: in function `cifs_ioctl':
ioctl.c:(.text+0x1f2): undefined reference to `__get_user_bad'

so now both of them fail on the get_user() of 8 bytes.

Hope that clarifies things.  It tells me that arm no-MMU still
needs support for get_user() of size 8 bytes.

-- 
~Randy

