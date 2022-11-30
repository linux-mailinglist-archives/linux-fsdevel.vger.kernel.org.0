Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CF763D0E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 09:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbiK3Ilu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 03:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiK3Ilt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:41:49 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0768929CA4;
        Wed, 30 Nov 2022 00:41:48 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id mv18so15101635pjb.0;
        Wed, 30 Nov 2022 00:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bClHHbBrNItVLT5DDquRBOoDnrUpgqSvIIymdz67XbA=;
        b=NZrOB5RgqscSru55svi/ZKjfdzqWbOne67Tfu8bqHX955TBLyuKMqIGaHH/XBd8dAz
         uUS2+d6mPbQdYR6NJoR9gbuO9kvfyIRDdTrM3xNG1drH6GNoo/J5zpd2N29hk5DEZjgT
         EPHUHPifO+vGT8CX8hcqw6wcG7CoK9RK9gbVKT26pSuLFj3HmqBLvECPl9QXv1EyaIUB
         9ybI+54269YSGi7ljWpvTlAfNLGroy9eK4RtyNP6iIbGkG8GjfCoAgEhy7Ypy03YOpzm
         htf6AdnEqzz3CR9eM4wbEDoVDZr/ys5w8T550YoJmSkD4mx9UaKD4QHvwkORPqAq+Dxx
         gBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bClHHbBrNItVLT5DDquRBOoDnrUpgqSvIIymdz67XbA=;
        b=Oq+QyJ/T9hAdxrN/jKZOvKEwYf4Se9Es4wN9HrK8gNOvzCwBsEg4BzGeiSRpJNBS9y
         /DVXYxCY7zWEQDopfc35f8o5eSqo29XUSh5foLWwaJJWCUy8fLz4Wc72McU3ibIuN0vt
         Mu3np+u8viIJ6WYQpzF0PMqGfvCc83bg/MHBv4S4E7NAtDNcd9HGbly4AgNDTCLLV+3n
         Fk7O75emwkuzYR/D1puFgW6GU2yQVA2H3wVxfmJjBAf7qed/GV+UX4nB9LZiYXwTV9rS
         H5kl5hgWwemkBizU3PJQSnqplKWprVyj8w/CjOjS2gCUl3KH1wr1kwjMwyP4MqyKAN5B
         o8xQ==
X-Gm-Message-State: ANoB5pkBSwyicTC/U+r1D1Ro6lpSbBOvn7w2Fe0xXIK6CzbvdLZs6PQT
        08qvDxjmoPfhP5jht0i3DwY=
X-Google-Smtp-Source: AA0mqf6Vb17rCV6Meg7pI5D8DKJb2nuwYFBlEbNIxw4WL6YgvAsugpHi/F06JEXCyveu7kiKRErAvA==
X-Received: by 2002:a17:90a:4c:b0:218:b187:d7da with SMTP id 12-20020a17090a004c00b00218b187d7damr48639485pjb.68.1669797707580;
        Wed, 30 Nov 2022 00:41:47 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-19.three.co.id. [180.214.232.19])
        by smtp.gmail.com with ESMTPSA id d12-20020a17090a2a4c00b0021952b5e9bcsm2512980pjg.53.2022.11.30.00.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 00:41:47 -0800 (PST)
Message-ID: <fd28321c-5f00-ba94-daed-2b8da2292c1f@gmail.com>
Date:   Wed, 30 Nov 2022 15:41:37 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] mm: memcontrol: protect the memory in cgroup from being
 oom killed
Content-Language: en-US
To:     chengkaitao <pilgrimtao@gmail.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, songmuchun@bytedance.com
Cc:     cgel.zte@gmail.com, ran.xiaokai@zte.com.cn,
        viro@zeniv.linux.org.uk, zhengqi.arch@bytedance.com,
        ebiederm@xmission.com, Liam.Howlett@Oracle.com,
        chengzhihao1@huawei.com, haolee.swjtu@gmail.com, yuzhao@google.com,
        willy@infradead.org, vasily.averin@linux.dev, vbabka@suse.cz,
        surenb@google.com, sfr@canb.auug.org.au, mcgrof@kernel.org,
        sujiaxun@uniontech.com, feng.tang@intel.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20221130070158.44221-1-chengkaitao@didiglobal.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221130070158.44221-1-chengkaitao@didiglobal.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/30/22 14:01, chengkaitao wrote:
> From: chengkaitao <pilgrimtao@gmail.com>
> 

Yikes! Another patch from ZTE guys.

I'm suspicious to patches sent from them due to bad reputation with
kernel development community. First, they sent all patches via
cgel.zte@gmail.com (listed in Cc) but Greg can't sure these are really
sent from them ([1] & [2]). Then they tried to workaround by sending
from their personal Gmail accounts, again with same response from him
[3]. And finally they sent spoofed emails (as he pointed out in [4]) -
they pretend to send from ZTE domain but actually sent from their
different domain (see raw message and look for X-Google-Original-From:
header.

I was about to review documentation part of this patch, but due to
concerns above, I have to write this reply instead. So I'm not going
to review, sorry for inconvenience.

PS: Adding Greg to Cc: list.

[1]: https://lore.kernel.org/lkml/Yw94xsOp6gvdS0UF@kroah.com/
[2]: https://lore.kernel.org/lkml/Yylv5hbSBejJ58nt@kroah.com/
[3]: https://lore.kernel.org/lkml/Y1EVnZS9BalesrC1@kroah.com/
[4]: https://lore.kernel.org/lkml/Y3NrBvIV7lH2GrWz@kroah.com/

-- 
An old man doll... just what I always wanted! - Clara

