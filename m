Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12F63DF995
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 04:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbhHDCNX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 22:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhHDCNL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 22:13:11 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6042DC06175F;
        Tue,  3 Aug 2021 19:12:59 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d17so1278262plr.12;
        Tue, 03 Aug 2021 19:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=i7/21JOa6ndS+LDgm4xtjgQFIyuj0hUBVl5kgE/wV9o=;
        b=J5N9T0CVUgyGSnCCn1nrxNA6iQCubLwXaXXYP/kFcfDfP9MNz0vB4yWPSbsPKSD00C
         JphfVS3W5Hv8SN+1q4hy/pf1e6/LlifGOUyKryHf0P3hP6jPYxEm4Mb1XkqIITaPQr4N
         EtLsfsrJLz6jZ3C/YV2t08nMAg+55QW2rfDapuCNhcNT4HxtmVQOk7KksZGaqPOTcrXf
         KNWfwYcG7mxcUyskY1e7XvooCaiNammKawCHQqJOE5x2FyyHFhHI4C70e+PI+g73pZcp
         2Yhi0jupry2LGkpVSJ21RCgLX7uAX9Dec8Rr39bBaDBQXCT77Ns9SpWFtEUzL7kYD6FX
         kLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=i7/21JOa6ndS+LDgm4xtjgQFIyuj0hUBVl5kgE/wV9o=;
        b=pl8l2uWrY4ZZB51FgYhH2IpP5lYJPFMSWtiM74sv9paWAR/B6hVSLziv9E0SGhMRgR
         tnpauLVncAI8zPT0EZQvQ9haGlvmBqV/WzKFnBNfArbGfVy/re+/giTVhVCADAw/1is0
         IzNahLsP33AyiCT1T/3yKQn1Fcsr7YdDoccpYzkOmpPvMuqE7owecYYLhjYBmGC5+YcS
         PnDH6vyJ09SrYICX2TrRxfStgJGJIGGbsu2Mdxs88oBDrK0ikzjiWo7nFrqB4lkzwlJO
         43OY0AOMqJzc4trLj5aZuo48dZDdfsX95Cx+jZNB5u9g/1/ma1+oDG/AcvmpJ79iu4Bg
         udEw==
X-Gm-Message-State: AOAM533pRbIeuRuBuIjreARkS9rO5jqHk/4WBALm8qeoAdieyJvkJTGZ
        6lJcYw1kRuzWasmbrUPsMJg=
X-Google-Smtp-Source: ABdhPJw4hmMBznYzIQFFHfUx42p3lkWi+wBFXCTWgYkjWuaMuwujk9mhh3Cl3UNrSTVWmVaZ9WbGAA==
X-Received: by 2002:a17:902:8bc4:b029:12b:8470:e29e with SMTP id r4-20020a1709028bc4b029012b8470e29emr4334561plo.2.1628043178927;
        Tue, 03 Aug 2021 19:12:58 -0700 (PDT)
Received: from [0.0.0.0] ([45.76.223.48])
        by smtp.gmail.com with ESMTPSA id d17sm510457pfn.110.2021.08.03.19.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 19:12:58 -0700 (PDT)
Subject: Re: [PATCH 0/2] Fix /proc/sys/fs/nfs/nsm_use_hostnames on big endian
 machines
To:     Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, linux-s390@vger.kernel.org,
        Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
References: <20210803105937.52052-1-thuth@redhat.com>
From:   Jia He <hejianet@gmail.com>
Message-ID: <98549025-d163-0ce4-0a9d-9da3ee945f44@gmail.com>
Date:   Wed, 4 Aug 2021 10:12:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210803105937.52052-1-thuth@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2021/8/3 18:59, Thomas Huth wrote:
> There is an endianess problem with /proc/sys/fs/nfs/nsm_use_hostnames
> (which can e.g. be seen on an s390x host) :
>
>   # modprobe lockd nsm_use_hostnames=1
>   # cat /proc/sys/fs/nfs/nsm_use_hostnames
>   16777216
>
> The nsm_use_hostnames variable is declared as "bool" which is required
> for the correct type for the module parameter. However, this does not
> work correctly with the entry in the /proc filesystem since this
> currently requires "int".
>
> Jia He already provided patches for this problem a couple of years ago,
> but apparently they felt through the cracks and never got merged. So
> here's a rebased version to finally fix this issue.
>
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1764075
>
> Jia He (2):
>    sysctl: introduce new proc handler proc_dobool
>    lockd: change the proc_handler for nsm_use_hostnames

Thanks for picking them up ;-)

---
Cheers,
Justin (Jia He)

