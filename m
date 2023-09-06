Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417E4794633
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 00:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242693AbjIFWcf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 18:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjIFWcf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 18:32:35 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4377719B5
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 15:32:31 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68cc6619317so312662b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Sep 2023 15:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694039551; x=1694644351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o/k7hYeMZYA4xOeMZOOFc4OyLOk3B8IVSt9fjlT6iwA=;
        b=rrJwusX8lNem28f1nZeNJ75HDof7E07svuE3AMewUJPutwuv6gyRVYNtLHfAInMylJ
         fPnS7pm3Gzh6+OMYA7STxtsRRJGofQWYpXyCzQSHOO05I3tOt++9Wub5DmcEnc/aPBWX
         GFL7y0Adhae0FAUiatrCKf563QvQCsYeEntrTkxXHDcwAc8/AyA7YWhW9E+fR1IvPqwq
         zknDDxJXohB7DRiyy7BA3BlzGsunv7C+eg1+Bdp/x6hnVlh0yCTp1rSSP6yNmPCn2Zkz
         BDXL5Q75IiXQJo2pvL4CkPwLaAHYRiIE37mBF5Ft42SOmvU1Crsy5uj0WRj6f5V5wLz4
         tX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694039551; x=1694644351;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/k7hYeMZYA4xOeMZOOFc4OyLOk3B8IVSt9fjlT6iwA=;
        b=fUmNQl1v3jn7YrJ2ZHJT5XUwKEKTu074trazNgz2Bk/VzVVJIC9O/V0lzP5ikJLYB/
         B2GGjexs149qoF+T0tiyCVYhFvrVN1t+xmeQyCeoa5Ur4Nk5ROpoYw71Oo39CoJE8U8U
         jGWCqnAEDMuVzf+ZtOKZm1z518yQdZ3h45Fxz7flbEoQHijga42ptVPaCVtYswk1COJv
         GOLLyjDFxEEocxggWp1puf86mJrNP14PyNs1goTtcLsxFbGMHi+eYQ+jxtHq+jQf5zZo
         cvC09R5haoFvBILBqc0/p+hL+iKXdFAaySpZxxxM1nR93NsPzDZM5/XbiyHxg2U1iiVZ
         nvaA==
X-Gm-Message-State: AOJu0Ywj2K+CGX4tE32xGJprwwzIym3n3IsJt4yq8+Azvt1KOXp3y9Yq
        7+/TnX2e64fxWP/lbtfxB1S3UWKOCO4=
X-Google-Smtp-Source: AGHT+IEppSgTf+7k+4PfOZ0zOr8Vp72urJPadBO5RQ3WAxTOZllIpNyAieAN3ADE8WlCGmG4WH2lOw==
X-Received: by 2002:a05:6a00:23cd:b0:68a:5395:7ab1 with SMTP id g13-20020a056a0023cd00b0068a53957ab1mr18961993pfc.11.1694039550556;
        Wed, 06 Sep 2023 15:32:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c19-20020aa78c13000000b0068c023b6a80sm11657851pfd.148.2023.09.06.15.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 15:32:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
Date:   Wed, 6 Sep 2023 15:32:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
References: <ZO9NK0FchtYjOuIH@infradead.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
In-Reply-To: <ZO9NK0FchtYjOuIH@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/30/23 07:07, Christoph Hellwig wrote:
> Hi all,
> 
> we have a lot of on-disk file system drivers in Linux, which I consider
> a good thing as it allows a lot of interoperability.  At the same time
> maintaining them is a burden, and there is a lot expectation on how
> they are maintained.
> 
> Part 1: untrusted file systems
> 
> There has been a lot of syzbot fuzzing using generated file system
> images, which I again consider a very good thing as syzbot is good
> a finding bugs.  Unfortunately it also finds a lot of bugs that no
> one is interested in fixing.   The reason for that is that file system
> maintainers only consider a tiny subset of the file system drivers,
> and for some of them a subset of the format options to be trusted vs
> untrusted input.  It thus is not just a waste of time for syzbot itself,
> but even more so for the maintainers to report fuzzing bugs in other
> implementations.
> 
> What can we do to only mark certain file systems (and format options)
> as trusted on untrusted input and remove a lot of the current tension
> and make everyone work more efficiently?  Note that this isn't even
> getting into really trusted on-disk formats, which is a security
> discussion on it's own, but just into formats where the maintainers
> are interested in dealing with fuzzed images.
> 
> Part 2: unmaintained file systems
> 
> A lot of our file system drivers are either de facto or formally
> unmaintained.  If we want to move the kernel forward by finishing
> API transitions (new mount API, buffer_head removal for the I/O path,
> ->writepage removal, etc) these file systems need to change as well
> and need some kind of testing.  The easiest way forward would be
> to remove everything that is not fully maintained, but that would
> remove a lot of useful features.
> 
> E.g. the hfsplus driver is unmaintained despite collecting odd fixes.
> It collects odd fixes because it is really useful for interoperating
> with MacOS and it would be a pity to remove it.  At the same time
> it is impossible to test changes to hfsplus sanely as there is no
> mkfs.hfsplus or fsck.hfsplus available for Linux.  We used to have
> one that was ported from the open source Darwin code drops, and
> I managed to get xfstests to run on hfsplus with them, but this
> old version doesn't compile on any modern Linux distribution and
> new versions of the code aren't trivially portable to Linux.
> 
> Do we have volunteers with old enough distros that we can list as
> testers for this code?  Do we have any other way to proceed?
> 
> If we don't, are we just going to untested API changes to these
> code bases, or keep the old APIs around forever?
> 

In this context, it might be worthwhile trying to determine if and when
to call a file system broken.

Case in point: After this e-mail, I tried playing with a few file systems.
The most interesting exercise was with ntfsv3.
Create it, mount it, copy a few files onto it, remove some of them, repeat.
A script doing that only takes a few seconds to corrupt the file system.
Trying to unmount it with the current upstream typically results in
a backtrace and/or crash.

Does that warrant marking it as BROKEN ? If not, what does ?

Guenter

