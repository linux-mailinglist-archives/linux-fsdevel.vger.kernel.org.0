Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF412324B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 20:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgG2Sce (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 14:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2Scd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 14:32:33 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB49C0619D2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2020 11:32:33 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id s16so18395455qtn.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2020 11:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=sbuGzfAXEu90/mb1KxvRVFNTEav+wJBHiGDp7KYLn/o=;
        b=d5pNoGKhhZSJ1U2hnE2QgpyNRXyWdy5CzWssvK8e5m9UCWTFT3DivPdKlbrS8Lhroy
         Q+Ory2dwx+5FMcg7WGADmy37Sw80SSCn2qGAfb13yHemobrCV+gw8VUpmnCGBjL4n05s
         t9vW7n0M+ALckESz1KTapB8in/rEyUPPlhWZAQWW9L7UaLdOC/j006FGs35FQyfELq0l
         sNyJUc3f1oWkgh26+VHo9fdtS3+R0gHjhwfo7g1dxsI9NCuf7/+gW7AmKLSVcVYQVnkv
         wDCBysP/09LebzKqgezyGw9u5rd3sTnRHKdxfCgJxbKw+AikBNsNeN0ymqK+7U+NzQvO
         UW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=sbuGzfAXEu90/mb1KxvRVFNTEav+wJBHiGDp7KYLn/o=;
        b=gB9MEW1RWWizkQscINDpdyKu2e7o8iX0x52suV4RBwkZ7s6wAOOWyDjbdvaB4L5L2o
         GDnWzRYIdXMsqhON+Vwk6wHXfrOOESuNkSSPj/w68Bhu77sr+eSD5YYVKAD7DsA4JksL
         efEhKERyvvZVuOqvov2ofNV2TyhDUcCJJhofRjAL7R6OUe+f3eJIufCFHXbeWDPsVVI3
         vF0Fef2Z3lba7vAhVtLyyPQ0JveYVU3lNQO5MtF8sCOpl0xEn/kU1HlY0vDj9g84Hm1J
         xliCLnt0jFGpH6tFcg1ZWN2r80xGOwKtlOLwQaelAFr8UVbqpZUCQc3jAn4sNhMtyPqU
         pfPA==
X-Gm-Message-State: AOAM531sIq4S6ayquqLNOEUPT+Q7eNyDLYXyiYTDC7Xpq/o1LLW6WYj3
        xX0rKPkTgbsb+YPngbAVMYGhjQ==
X-Google-Smtp-Source: ABdhPJzHnA3jlgx2Rkac90wfpWBQn+sE/m+x3vbkFuM/Hnpj8NhLqOoQ2DkMPjs2yAkNTunRkmfKaQ==
X-Received: by 2002:ac8:478f:: with SMTP id k15mr32939604qtq.287.1596047552340;
        Wed, 29 Jul 2020 11:32:32 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e1::10a7? ([2620:10d:c091:480::1:2ed9])
        by smtp.gmail.com with ESMTPSA id l64sm2118053qkc.21.2020.07.29.11.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 11:32:31 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Subject: Inverted mount options completely broken (iversion,relatime)
Message-ID: <0b154b9b-728f-7d57-d4c5-ec25fc9dfdf3@toxicpanda.com>
Date:   Wed, 29 Jul 2020 14:32:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Eric reported a problem to me where we were clearing SB_I_VERSION on remount of 
a btrfs file system.  After digging through I discovered it's because we expect 
the proper flags that we want to be passed in via the mount() syscall, and 
because we didn't have "iversion" in our show_options entry the mount binary 
(form util-linux) wasn't setting MS_I_VERSION for the remount, and thus the VFS 
was clearing SB_I_VERSION from our s_flags.

No big deal, I'll fix show_mount.  Except Eric then noticed that mount -o 
noiversion didn't do anything, we still get iversion set.  That's because btrfs 
just defaults to having SB_I_VERSION set.  Furthermore -o noiversion doesn't get 
sent into mount, it's handled by the mount binary itself, and it does this by 
not having MS_I_VERSION set in the mount flags.

This happens as well for -o relatime, it's the default and so if you do mount -o 
norelatime it won't do anything, you still get relatime behavior.  The only time 
this changes is if you do mount -o remount,norelatime.

So my question is, what do we do here?  I know Christoph has the strong opinion 
that we just don't expose I_VERSION at all, which frankly I'm ok with.  However 
more what I'm asking is what do we do with these weird inverted flags that we 
all just kind of ignore on mount?  The current setup is just broken if we want 
to allow overriding the defaults at mount time.  Are we ok with it just being 
broken?  Are we ok with things like mount -o noiversion not working because the 
file system has decided that I_VERSION (or relatime) is the default, and we're 
going to ignore what the user asks for unless we're remounting?  Thanks,

Josef
