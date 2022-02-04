Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0683E4A9E8E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 19:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377321AbiBDSDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 13:03:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20883 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241744AbiBDSDb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:03:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643997810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o7XcRwxCW7bpdO1D8PIhj5dP5XyhvAOmpO56rjcmtyk=;
        b=ek8i5S//lB8sLIKDcxlUmhq09/7wtQr7Zl1rCuFQ0yme/q+AhZYoePJKTzjEweQaLVabjQ
        7DpuBpgm6alexr27PopfmB/49x2ywCYzRjLSXP7DcA7twmi+mOjbiBGzVsznBt8Wo/wJUJ
        Ma7zibfKVT4RAWuafaTHOWPXFTH6C1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-gShzDbcuMjW3KS_PkIIQDQ-1; Fri, 04 Feb 2022 13:03:27 -0500
X-MC-Unique: gShzDbcuMjW3KS_PkIIQDQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22018814245;
        Fri,  4 Feb 2022 18:03:26 +0000 (UTC)
Received: from localhost (unknown [10.64.242.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20D457E22F;
        Fri,  4 Feb 2022 18:03:25 +0000 (UTC)
Date:   Sat, 05 Feb 2022 03:03:24 +0900 (JST)
Message-Id: <20220205.030324.1280110384368183671.yamato@redhat.com>
To:     matorola@gmail.com
Cc:     zeha@debian.org, kzak@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.38-rc1
From:   Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <20220202.232106.1642450897216370276.yamato@redhat.com>
References: <20220131192337.lzpofr4pz3lhgtl3@zeha.at>
        <CADxRZqwq=XmXZnnENU+vD7_2oC_VtqhG40P-xg=QAzKchT-3Ng@mail.gmail.com>
        <20220202.232106.1642450897216370276.yamato@redhat.com>
Organization: Red Hat Japan, Inc.
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

As I commented on GitHub, I made a pull request for fixing this issue.
I found a bug in the test case, not in lsfd itself.

https://github.com/util-linux/util-linux/pull/1595
https://github.com/util-linux/util-linux/pull/1595/commits/abd93fcecfbb1a1fac7032fac9d2903c5d2d3a38

Masatake YAMATO

From: Masatake YAMATO <yamato@redhat.com>
Subject: Re: [ANNOUNCE] util-linux v2.38-rc1
Date: Wed, 02 Feb 2022 23:21:06 +0900 (JST)

> Hi,
> 
> thank you for testing lsfd.
> 
> Could you tell me what kind of file system for /etc/passwd do you use for testing?
> When trying to reproduce the bug, could you applying the following change?
> 
> 
> diff --git a/tests/ts/lsfd/lsfd-functions.bash b/tests/ts/lsfd/lsfd-functions.bash
> index 597e48cf4..a81647ccb 100644
> --- a/tests/ts/lsfd/lsfd-functions.bash
> +++ b/tests/ts/lsfd/lsfd-functions.bash
> @@ -43,6 +43,13 @@ function lsfd_compare_dev {
>      # if we use findmnt.
>      local FINDMNT_MNTID_DEV=$("${FINDMNT}" --raw -n -o ID,MAJ:MIN | grep "^${MNTID}")
>      echo 'FINDMNT[RUN]:' $?
> -    [ "${MNTID} ${DEV}" == "${FINDMNT_MNTID_DEV}" ]
> -    echo 'DEV[STR]:' $?
> +    if [ "${MNTID} ${DEV}" == "${FINDMNT_MNTID_DEV}" ]; then
> +	echo 'DEV[STR]:' 0
> +    else
> +	echo 'DEV[STR]:' 1
> +	echo 'MNTID:' "${MNTID}"
> +	echo 'DEV:' "${DEV}"
> +	echo 'MNTID DEV:' "${MNTID} ${DEV}"
> +	echo 'FINDMNT_MNTID_DEV:' "${FINDMNT_MNTID_DEV}"
> +    fi
>  }
> 
> 
> Masatake YAMATO
> 
> From: Anatoly Pugachev <matorola@gmail.com>
> Subject: Re: [ANNOUNCE] util-linux v2.38-rc1
> Date: Wed, 2 Feb 2022 12:57:47 +0300
> 
>> On Tue, Feb 1, 2022 at 11:48 PM Chris Hofstaedtler <zeha@debian.org> wrote:
>>>
>>> Hello,
>>>
>>> * Karel Zak <kzak@redhat.com> [220131 16:15]:
>>> >
>>> > The util-linux release v2.38-rc1 is available at
>>> >
>>> >   http://www.kernel.org/pub/linux/utils/util-linux/v2.38/
>>> >
>>> > Feedback and bug reports, as always, are welcomed.
>>>
>>> Thanks.
>>>
>>> Some lsfd tests appear to fail in a Debian sbuild build environment,
>>> in that they differ in the expected/actual values of DEV[STR] (see
>>> below). I did not find time to investigate this closer, but thought
>>> it would be best to report it sooner than later.
>>>
>>> Best,
>>> Chris
>>>
>>> ---snip---
>>>
>>>          lsfd: read-only regular file         ... FAILED (lsfd/mkfds-ro-regular-file)
>>> ========= script: /<<PKGBUILDDIR>>/tests/ts/lsfd/mkfds-ro-regular-file =================
>>> ================= OUTPUT =====================
>>>      1  ABC         3  r--  REG /etc/passwd   1
>>>      2  COMMAND,ASSOC,MODE,TYPE,NAME,POS: 0
>>>      3  PID[RUN]: 0
>>>      4  PID[STR]: 0
>>>      5  INODE[RUN]: 0
>>>      6  INODE[STR]: 0
>>>      7  UID[RUN]: 0
>>>      8  UID[STR]: 0
>>>      9  USER[RUN]: 0
>>>     10  USER[STR]: 0
>>>     11  SIZE[RUN]: 0
>>>     12  SIZE[STR]: 0
>>>     13  MNTID[RUN]: 0
>>>     14  DEV[RUN]: 0
>>>     15  FINDMNT[RUN]: 0
>>>     16  DEV[STR]: 1
>>> ================= EXPECTED ===================
>>>      1  ABC         3  r--  REG /etc/passwd   1
>>>      2  COMMAND,ASSOC,MODE,TYPE,NAME,POS: 0
>>>      3  PID[RUN]: 0
>>>      4  PID[STR]: 0
>>>      5  INODE[RUN]: 0
>>>      6  INODE[STR]: 0
>>>      7  UID[RUN]: 0
>>>      8  UID[STR]: 0
>>>      9  USER[RUN]: 0
>>>     10  USER[STR]: 0
>>>     11  SIZE[RUN]: 0
>>>     12  SIZE[STR]: 0
>>>     13  MNTID[RUN]: 0
>>>     14  DEV[RUN]: 0
>>>     15  FINDMNT[RUN]: 0
>>>     16  DEV[STR]: 0
>>> ================= O/E diff ===================
>>> --- /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file    2022-01-31 19:12:43.802603811 +0000
>>> +++ /<<PKGBUILDDIR>>/tests/expected/lsfd/mkfds-ro-regular-file  2022-01-31 14:57:47.000000000 +0000
>>> @@ -13,4 +13,4 @@
>>>  MNTID[RUN]: 0
>>>  DEV[RUN]: 0
>>>  FINDMNT[RUN]: 0
>>> -DEV[STR]: 1
>>> +DEV[STR]: 0
>>> ==============================================
>> 
>> Chris,
>> 
>> i had this error on my test system
>> 
>> https://github.com/util-linux/util-linux/issues/1511
>> 
>> but i can't reliably reproduce it now (on my current kernel 5.17.0-rc2
>> and on debian kernel 5.15.0-3-sparc64-smp )
>> Tested with the following command line (for current git util-linux sources):
>> $ for i in {1..100}; do tests/run.sh lsfd; done  | grep FAILED
>> 
>> ^^ no failed output
>> 
>> I can reopen the issue above, so we could try to reproduce it.
>> 
> 

