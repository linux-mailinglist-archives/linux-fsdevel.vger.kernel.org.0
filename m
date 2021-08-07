Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632C33E348F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Aug 2021 12:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhHGKGi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Aug 2021 06:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhHGKG2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:06:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A967BC0613CF;
        Sat,  7 Aug 2021 03:06:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m12so14349532wru.12;
        Sat, 07 Aug 2021 03:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ut8/KNFRFcQqrLccjjc1Iq2etNteCks1XWkqaFKEZy0=;
        b=usi62ZFLaki5oyxywr3g0oprkNmlVIlS1H1gE73a/Z4cuFIRtTU9jPCg5K3BcJ6mK0
         5Y6EA1+EBznKCDRZbgGFvuxOL/gpT0tgkca3LLsox4bvCYDZhRpT7+r/8mGNqAXON6Ij
         65BxU2JbSzwid15FD3gCSajZ7mZhMDc9Te2VYBYMvgbEKBf9v+RbAUBpCZn0XUHdSLD5
         Lm9NoMxxBG1nbjmTXcQlZzgwK5wUKxeg5U0msxD5/e0GMpgBTrSsi8bLrcwRsM+ikBz/
         zpPiYNBdPHv0k3vj4DuO55jt8aTHz4R+ah0fNHJubybGTLdUgtiTZ/BXt48upN2hmnEy
         Unmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ut8/KNFRFcQqrLccjjc1Iq2etNteCks1XWkqaFKEZy0=;
        b=Ro0U4/AMp1vsKCUTxmFBMa+6f87pB/W2yxhSk4InteCjIoQxJCnuuqg4XOSCfazLYZ
         8WUqQ2AGG+pgZp1olOXDLhk8ZK2SfYUyNDeA7QGxUD/heXCahDhWz+9ba/2xKHah7dgK
         Wt+Jil3VbuxD14yogA5BiNB2epwqNr7Bo5s1cHCpOaJuv71FDJQK/0KibnupKyN+81+k
         S3VhC6GKolnw5NpCYXZuiordi2XRCVYyldhXdyaIlxVxSUvKQ/PMbL2zUeFQoLVFPRLv
         IYYqJPWgTbmfrF0yOjaPq88kWD5KoJljgcvsSeTeEsb0VuesOrPLi/wU7fSbX5grP6d3
         q2xw==
X-Gm-Message-State: AOAM533Q+dvCFH4ByDzoh9Ta7h/vF2/6HeJrTNsBC4ZgTMk8QgaG9L/u
        6LkE0/WITL5z8IkKKMjQkh0dvUw/egs=
X-Google-Smtp-Source: ABdhPJx7/Of4aEYxyifIy6jnxnLfkit5KMnvUSb3piLbfc6HaMxZ9HglfAqpPChs3qGvX7PpMH7qHw==
X-Received: by 2002:a05:6000:1106:: with SMTP id z6mr15440031wrw.296.1628330767119;
        Sat, 07 Aug 2021 03:06:07 -0700 (PDT)
Received: from [192.168.8.197] ([85.255.237.206])
        by smtp.gmail.com with ESMTPSA id w14sm1425505wrt.23.2021.08.07.03.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Aug 2021 03:06:06 -0700 (PDT)
Subject: Re: [PATCH] fs: optimise generic_write_check_limits()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <dc92d8ac746eaa95e5c22ca5e366b824c210a3f4.1628248828.git.asml.silence@gmail.com>
 <YQ04/NFn8b6cykPQ@casper.infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <a01568b8-a10c-c260-a0fe-3161a8075dba@gmail.com>
Date:   Sat, 7 Aug 2021 11:05:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQ04/NFn8b6cykPQ@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/6/21 2:28 PM, Matthew Wilcox wrote:
> On Fri, Aug 06, 2021 at 12:22:10PM +0100, Pavel Begunkov wrote:
>> Even though ->s_maxbytes is used by generic_write_check_limits() only in
>> case of O_LARGEFILE, the value is loaded unconditionally, which is heavy
>> and takes 4 indirect loads. Optimise it by not touching ->s_maxbytes,
>> if it's not going to be used.
> 
> Is this "optimisation" actually worth anything?  Look at how
> force_o_largefile() is used.  I would suggest that on the vast majority
> of machines, O_LARGEFILE is always set.

Makes sense to leave it alone then, thanks

-- 
Pavel Begunkov
