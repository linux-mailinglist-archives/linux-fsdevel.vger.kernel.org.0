Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6877F6CD40E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 10:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjC2IJU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 04:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjC2IJS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:09:18 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B641FFC
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 01:08:55 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso17834859pjb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 01:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680077335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVRpG2dAr/nWYNSNRqghl5EEZFHlwrwTvwCgPASuUmU=;
        b=fjjwB2zFeG+SwWg0X1rPzwBGeccQqbojBL/azxEx/VC8yg0Qm5Sb+t0NfVOmibaucZ
         xCgCSTAIberX+90M1I05lsnIAWZKnB9rzQvEI+zmLP7W6dQiMeldn5j/30ESU917A/WM
         M2GmpY7IWQv5hQ/xwVyvv5I7gclcVvyIFEgTQzrHMxoWyew0bdrXRzjjgHy4jT+Wb9xQ
         jhWoxfiaJE+omv3VTH98A/tO9knUn3mdNKnpogad+NtkOsQmhW0NzBJWE4hOwd3sZ1G2
         hxIXxoA+eJranOTs/dIbHJr/Ou4JCMK7MpqYQkOj3ZMsr7b/0+6HdBldsI8pWLe8CIwl
         rgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680077335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mVRpG2dAr/nWYNSNRqghl5EEZFHlwrwTvwCgPASuUmU=;
        b=pf3FtBO/Yg488cpKXk5H+m7MMQ57B8vEqPRAXUhLFfrbmQ/D0mm5QFvk61W3Ttv+c/
         t2eGgfa2j2r0CaXaUjnILtySeA+4vhBIBgFq0Y/cTv4HSuNrAPFFUMXxD34BUL2p3FFl
         RwG4/OvZ81PAdUqXapgj9Qt4PDvSO+o393o8Hc1r/aEV7tzuBKG8mm3VrwhQ8MOMLZlP
         /pnePmjz9uc8ei6fSY8kFKvtEgaDso2QMsiDSZBpVvORGDixqBbod626+gDzJHgvzx7g
         VN2CLgrq8v5lauxJ74QDkf0ki78x+oz9dgAPqknO5hbwL3W5dwPOHbRYHyK7Awgwtp5v
         q5Ag==
X-Gm-Message-State: AAQBX9fohnwEsu59TnlW32sDV1BD+JZTHIptyIYCC43b4QwgO3SFloHt
        mwxQQNqh/jbusl/53PPv31W1EQ==
X-Google-Smtp-Source: AKy350YkuPVOI4SkoYUmjVLLsU+g0OQwvsA0hoKkKc7WLUm0Sa5StE4Ydf+KVToEOuvk5LGwIcWN8g==
X-Received: by 2002:a17:90b:3ece:b0:23f:6edd:41da with SMTP id rm14-20020a17090b3ece00b0023f6edd41damr20304030pjb.29.1680077335048;
        Wed, 29 Mar 2023 01:08:55 -0700 (PDT)
Received: from [10.3.144.50] ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id b15-20020a17090ae38f00b002369e16b276sm859568pjz.32.2023.03.29.01.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:08:54 -0700 (PDT)
Message-ID: <2a39ced1-05f1-d696-1905-4ff5199fa41b@bytedance.com>
Date:   Wed, 29 Mar 2023 16:08:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [External] Re: [PATCH V4 4/5] cachefiles: narrow the scope of
 triggering EPOLLIN events in ondemand mode
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>, zhujia.zj@bytedance.com
References: <20230111052515.53941-5-zhujia.zj@bytedance.com>
 <20230111052515.53941-1-zhujia.zj@bytedance.com>
 <133078.1680013145@warthog.procyon.org.uk>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <133078.1680013145@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/3/28 22:19, David Howells 写道:
> Jia Zhu <zhujia.zj@bytedance.com> wrote:
> 
>> +		if (!xa_empty(xa)) {
>> +			xa_lock(xa);
>> +			xa_for_each_marked(xa, index, req, CACHEFILES_REQ_NEW) {
>> +				if (!cachefiles_ondemand_is_reopening_read(req)) {
>> +					mask |= EPOLLIN;
>> +					break;
>> +				}
>> +			}
>> +			xa_unlock(xa);
>> +		}
> 
> I wonder if there's a more efficient way to do this.  I guess it depends on
> how many reqs you expect to get in a queue.  It might be worth taking the
> rcu_read_lock before calling xa_lock() and holding it over the whole loop.
> 
Thanks for the advice, will use rcu_read_lock（unlock） to replace it.
> David
> 
