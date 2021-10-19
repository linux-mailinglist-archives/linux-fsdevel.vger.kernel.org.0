Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AEC433B75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 18:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbhJSQDE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 12:03:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232913AbhJSQDD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634659250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+/pkobYQmFSVPtB7/1zAAgkGIOuOGumz0nqsWSm3uLo=;
        b=jMplC40vZdm6TXltESiaZ20NdkurOHXwrnhG/taNv3uoHC/443cUy69orPDxPL3yanotWZ
        hZeRJ4JH0BFvtXf6bCizxJx8kd+kQBJDacfWJrN0LkBKQNc/558udtiMcuK+xHZR3Ufwd4
        9wXUSsy+A96QkuLENbdKvsBLCG/5ZPs=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-3p4Dzoh_O_mlCesOPEKJUw-1; Tue, 19 Oct 2021 12:00:49 -0400
X-MC-Unique: 3p4Dzoh_O_mlCesOPEKJUw-1
Received: by mail-io1-f69.google.com with SMTP id a1-20020a5d9801000000b005de11aa60b8so5378831iol.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Oct 2021 09:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+/pkobYQmFSVPtB7/1zAAgkGIOuOGumz0nqsWSm3uLo=;
        b=u0WDx1rjGTF067g58LtRIlp7g9ZSgb/lmr+fPai1wptCRB6+iTLbsYhVCq1U+S/4sW
         Od0hfrBr/WkTi9z3vlSMO9T65A0qzh7L/BVhVY22FP2FNM8pq8llmVGaA7ynVubOIAw/
         lv0f+UwoTu7SLoCOdTlPi2HjYzNb3IdWDMePlzVw40vI+k+yBeSUansB2AzvoGEWSS9A
         MzKYn4Vnz089xKn/jZQ5BWQ5yTIuwfii2ziYohwp8t58fP/Unnr9Ox9vLj73n8H5Q12Q
         9mVpIu18U9e99zgmPyb9bGCBU7zI4FpwN2gj+geE9G02hdTi2nTAHGOjcLv4Z9j5iESZ
         H4Jw==
X-Gm-Message-State: AOAM533q5NpKMCM/mQqwRKalq9VL/09mBEdCsmZPSfeGDObA++cRYa7z
        97FDwaoIKQGKLVuvgDfTcZ/TWJz+RO6cxjCzBJvxlSiZYKTdVmWIClIpYL6qW2Muyoqsn2LqeNQ
        FZQ7MLwtGN19doCX03k0KBDePFA==
X-Received: by 2002:a92:ad07:: with SMTP id w7mr964698ilh.162.1634659248222;
        Tue, 19 Oct 2021 09:00:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAZfB7m5Nwi7iGOdqLp7ZjGTVP9iLTlfNdmkJjBBh89jyJbqtVZTUIyhlFM83/SHsC93WNcw==
X-Received: by 2002:a92:ad07:: with SMTP id w7mr964668ilh.162.1634659248043;
        Tue, 19 Oct 2021 09:00:48 -0700 (PDT)
Received: from [172.16.0.19] ([205.214.171.149])
        by smtp.gmail.com with ESMTPSA id i18sm9324101ila.32.2021.10.19.09.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 09:00:47 -0700 (PDT)
Message-ID: <d28b1ea4-6834-816e-a01a-f1bd0862e84e@redhat.com>
Date:   Tue, 19 Oct 2021 11:00:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v8 00/17] gfs2: Fix mmap + page fault deadlocks
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20211019134204.3382645-1-agruenba@redhat.com>
 <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com>
From:   Bob Peterson <rpeterso@redhat.com>
In-Reply-To: <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/19/21 10:40 AM, Linus Torvalds wrote:
> On Tue, Oct 19, 2021 at 3:42 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>>
>>  From my point of view, the following questions remain:
>>
>>   * I hope these patches will be merged for v5.16, but what process
>>     should I follow for that?  The patch queue contains mm and iomap
>>     changes, so a pull request from the gfs2 tree would be unusual.
> 
> Oh, I'd much rather get these as one pull request from the author and
> from the person that actually ended up testing this.

Hi Linus,

FWIW, I've been working with Andreas on this and have tested it quite
extensively, although only with gfs2. I've tested it with numerous
scenarios, both stand-alone (xfstests as well as several other test
programs I have in my collection) and in a cluster with some very heavy
duty cluster coherency tests. My testing is nearly complete, but not
quite.

Regards,

Bob Peterson
GFS2 File System

