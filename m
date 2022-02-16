Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7278E4B8972
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 14:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbiBPNT3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 08:19:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbiBPNSt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:18:49 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E672AC923
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Feb 2022 05:18:17 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j9-20020a05600c190900b0037bff8a24ebso3710873wmq.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Feb 2022 05:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=algolia.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PlNi9ciElPwEs1LJoEB8xZkE+EnHB0mIZHsYC5NhAsY=;
        b=w0jBpzaR5vaPbYOcj2spBHJfOMj3nwWNKsycXYvill3tWXFQ4LXr+vaDsKxJLBa9Ev
         MdZYWVsdfvgjdAXBoJdyOPeH0kafRB9UvrpwMIucZ4/rjHH/BVKe4kuVFw8Pf8OFEJLo
         P5EU0NQTIwXw7KDM4xH/9O9Uxes+q5KPbRKtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PlNi9ciElPwEs1LJoEB8xZkE+EnHB0mIZHsYC5NhAsY=;
        b=uNabOMdGe8L68ESm6Cao27GcoRvKhYxWVNzJ53lKU8OKYC5GVv67mqcQ1b//tXY7ME
         +nxIFFEjnyuZ0IaCtJ1CD9k6M8G/4MDG0Of+GlHhW5Wqeqnhjpy0iYxX7HzhuNZeGRLA
         SXKlHIBzCubJPSibDngAHJqBsYT5KuirwBJ3LfDGhAiTp+3YvF0n2CK4NqsD1l+wqCKC
         cJqzgCo7w7CsFPmGcpv+3fc0CS1juMwAvxlUUBohEMq3USmoyUCkOf8zI4m2+OA09zZC
         y/H6/mNLSm4FMPdD1q7ke/YCVQph3lsoIvggoXEQDUuf+w34uuVhMHzKe4yEB2ga9DBu
         G8lw==
X-Gm-Message-State: AOAM533Et0PWzkaQ9pZDCTgFYXO748jvBHjiQXWZm1+BC/FET+Bq9Xak
        NbDJp8IvZS5FfwFEBhLafUY5vA==
X-Google-Smtp-Source: ABdhPJy0vRrYV6duj8pGGxIELNPUfCUwW0eEI7uQbDouSdpL6nweY9x4I6bCFDU/V85DPITDc0BgTw==
X-Received: by 2002:a05:600c:20c7:b0:37b:b739:8177 with SMTP id y7-20020a05600c20c700b0037bb7398177mr1605527wmm.121.1645017495859;
        Wed, 16 Feb 2022 05:18:15 -0800 (PST)
Received: from xavier-xps ([2a01:e0a:830:d971:752e:e19b:a691:2171])
        by smtp.gmail.com with ESMTPSA id x7sm28339793wro.21.2022.02.16.05.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 05:18:15 -0800 (PST)
Date:   Wed, 16 Feb 2022 14:18:14 +0100
From:   Xavier Roche <xavier.roche@algolia.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: race between vfs_rename and do_linkat (mv and link)
Message-ID: <20220216131814.GA2463301@xavier-xps>
References: <20220214210708.GA2167841@xavier-xps>
 <CAJfpegvVKWHhhXwOi9jDUOJi2BnYSDxZQrp1_RRrpVjjZ3Rs2w@mail.gmail.com>
 <YguspMvu6M6NJ1hL@zeniv-ca.linux.org.uk>
 <YgvPbljmJXsR7ESt@zeniv-ca.linux.org.uk>
 <YgvSB6CKAhF5IXFj@casper.infradead.org>
 <YgvS1XOJMn5CjQyw@zeniv-ca.linux.org.uk>
 <CAJfpegv03YpTPiDnLwbaewQX_KZws5nutays+vso2BVJ1v1+TA@mail.gmail.com>
 <YgzRwhavapo69CAn@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgzRwhavapo69CAn@miu.piliscsaba.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 16, 2022 at 11:28:18AM +0100, Miklos Szeredi wrote:
> Something like this:
> diff --git a/fs/namei.c b/fs/namei.c
> index 3f1829b3ab5b..dd6908cee49d 100644

Tested-by: Xavier Roche <xavier.roche@algolia.com>

I confirm this completely fixes at least the specific race. Tested on a
unpatched and then patched 5.16.5, with the trivial bash test, and then
with a C++ torture test.

Before:
-------

$ time ./linkbug
Failed after 4 with No such file or directory

real	0m0,004s
user	0m0,000s
sys	0m0,004s

After:
------

(no error after ten minutes of running the program)

Torture test program:
---------------------

/* Linux rename vs. linkat race condition.
 * Rationale: both (1) moving a file to a target and (2) linking the target to a file in parallel leads to a race
 * on Linux kernel.
 * Sample file courtesy of Xavier Grand at Algolia
 * g++ -pthread linkbug.c -o linkbug
 */

#include <thread>
#include <unistd.h>
#include <assert.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <iostream>
#include <string.h>

static const char* producedDir = "/tmp";
static const char* producedFile = "/tmp/file.txt";
static const char* producedTmpFile = "/tmp/file.txt.tmp";
static const char* producedThreadDir = "/tmp/tmp";
static const char* producedThreadFile = "/tmp/file.txt.tmp.2";

bool createFile(const char* path)
{
    const int fdOut = open(path,
                           O_WRONLY | O_CREAT | O_TRUNC | O_EXCL | O_CLOEXEC,
                           S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH);
    assert(fdOut != -1);
    assert(write(fdOut, "Foo", 4) == 4);
    assert(close(fdOut) == 0);
    return true;
}

void func()
{
    int nbSuccess = 0;
    // Loop producedThread a hardlink of the file
    while (true) {
        if (link(producedFile, producedThreadFile) != 0) {
            std::cout << "Failed after " << nbSuccess << " with " << strerror(errno) << std::endl;
            exit(EXIT_FAILURE);
        } else {
            nbSuccess++;
        }
        assert(unlink(producedThreadFile) == 0);
    }
}

int main()
{
    // Setup env
    unlink(producedTmpFile);
    unlink(producedFile);
    unlink(producedThreadFile);
    createFile(producedFile);
    mkdir(producedThreadDir, 0777);

    // Async thread doing a hardlink and moving it
    std::thread t(func);
    // Loop creating a .tmp and moving it
    while (true) {
        assert(createFile(producedTmpFile));
        assert(rename(producedTmpFile, producedFile) == 0);
    }
    return 0;
}
