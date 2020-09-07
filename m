Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA7826003B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 18:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbgIGQqK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 12:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731120AbgIGQqE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:46:04 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1808C061573
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2020 09:46:03 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 5so8264226pgl.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2020 09:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g+ZwBs/eKS475TohZrpwjq9jwyfp0fqCgZEKHc2jZv4=;
        b=LxhFUJmQp0wPK9979sXpXqJO2RL9oLGBBZ/SbCfnOQVK7O9ePZ/9GthPaBNWsbU33M
         YT7hFWA1AyXr0FkYOEYntkrEJQUgpZT/84sQ0pgfW9IugaUz+b39ZKjbAD+mJwaVWKpS
         eyDXuD8TtjTMNAiRs7dZ7C7Fk280Ikn8V4MRcmg89IIF5FGwfsmbmVc4q/GMj0rMCfsB
         h07/V2Zw2ol9S5hrAKiBFwdkvhK2My8p4xh1xjzulhZJC8ptuFFSZ6F3YnerTskkAJRb
         YnF1LI0ZUs3QFohQOa+q2zAFR9kUUxTC3dPvpDPy0MVItCC7uKUsFuurQuRzZDWoQmYV
         DPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g+ZwBs/eKS475TohZrpwjq9jwyfp0fqCgZEKHc2jZv4=;
        b=O4t1pUKf1lwvU+vdOw/twjuEh1SyvC2fz+al7TXUrHQDCtxSzUfR+T0HkL74eFB+J7
         ALLnuEqBnkj85rFV0dAPQaFsjjpy6cR7E9zAQh0gVuOCBjWLZaGPgHnRiDp+V0N0JpsD
         K/DAYmcoptd1J+6fmrAleTWr9BHTCW0ILRvzwxVAbNITnFnvoILtljb6pSakeojYYlHl
         SecCJVRqWU8xVp4K82RHYWHfMKCtREdAyvXdHWU3RzhBTTdSlnMbrSu1BY7d6J0afE+5
         jGJylH2aOmaJxcuvWFNmDTt7fhHV28h1yOWNLliWDn7lGF1LNZ3DWKUtIlQ3FdmRknJC
         ifGw==
X-Gm-Message-State: AOAM5335Rm4ZCyUSV0jV6C64BTxVjohnOt7OKHJDcbcGB+8j+uMWmleF
        RRNoAvkKpuxYwQKIGmPOpW0W5+gNh5I1AI/Y
X-Google-Smtp-Source: ABdhPJzBN/q1TR9Fhihv0JY545Kt6j4m6xqSO0AlECqpYQ11Ul+NxTf7dGAL3bkjEpHGgC+S9uIaaA==
X-Received: by 2002:a63:fc41:: with SMTP id r1mr17031068pgk.179.1599497163138;
        Mon, 07 Sep 2020 09:46:03 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b20sm16718430pfb.198.2020.09.07.09.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 09:46:02 -0700 (PDT)
Subject: Re: [PATCH v3] fs: Remove duplicated flag O_NDELAY occurring twice in
 VALID_OPEN_FLAGS
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <20200906223949.62771-1-kw@linux.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <01eef19a-a5f0-dbad-3091-dba05abb16c8@kernel.dk>
Date:   Mon, 7 Sep 2020 10:46:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200906223949.62771-1-kw@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/6/20 4:39 PM, Krzysztof Wilczyński wrote:
> The O_NDELAY flag occurs twice in the VALID_OPEN_FLAGS definition, this
> change removes the duplicate.  There is no change to the functionality.
> 
> Note, that the flags O_NONBLOCK and O_NDELAY are not duplicates, as
> values of these flags are platform dependent, and on platforms like
> Sparc O_NONBLOCK and O_NDELAY are not the same.
> 
> This has been done that way to maintain the ABI compatibility with
> Solaris since the Sparc port was first introduced.
> 
> This change resolves the following Coccinelle warning:
> 
>   include/linux/fcntl.h:11:13-21: duplicated argument to & or |

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

