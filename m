Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95537631F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 11:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjGZJ1t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 05:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjGZJ1Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:27:25 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1F74EF5
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 02:25:12 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-682a5465e9eso1486041b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 02:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690363512; x=1690968312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ajWZi1kTG9ZsFll3P13XRfH/M90QTcK5ZSE2yNZ8xrc=;
        b=EoykYoznFQB+Q5vtxB05QShZ5mT0NvRnJlxLMwwunNTfl8591g+vLdOh0Y66FvP00W
         9n0hlgikFt5QzHCVNTjyzpEBXqAAArV+q+Cm1K01NVy0IHSrK35n5O3zwednj6lniY+I
         lHQ1jmFFJSpg3k2Z+P+GCQgikrNPvPgbTGI9qOAZDGSEnVL/tQfWNeIqPW1GLJyu0wBH
         qlXRVLONIpbUkd0TKLE77yCCvwBY0CakLHpe8W1wtjqDIuElbnDx/VVqTsXQMTHeZivy
         lvXU1t2+mJ3jI7qEKSu7/Wo42EJguKi78m2V2Yy/p9vZmFrIz/eBQFUwvspw2uS2U/BG
         9EvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690363512; x=1690968312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajWZi1kTG9ZsFll3P13XRfH/M90QTcK5ZSE2yNZ8xrc=;
        b=dIsdWk+WDbtIlSYKn8no0pBuZ6hy+g1yvx1/oa8ULjMPWbBcYuqY+HTSnwrVP5cyBF
         Odj1a9XEHYxdklbxw5hZkT3kbJp6jGCFe8WGR8Omy/giyot+PVFl5OVTiFSEqfVF8448
         mEHK9ZWgJMMHgN/CocHYSj/jpUvZm87mjdiULTa+OvAxM/Ka7z+Sh6ITI773ZXc049sf
         SMAlnHIF+I66gGQaghMWyyq/Xbtr3WS86x23aeAp/5LFTj15LsEiprCKD2rhWoBIebqD
         FA3dvA/pwx2XAIYDUJFmtL//Sv6+aoFMvumZLZTyOfJNAx0Unyjn0VqehxKcO8o52XtB
         5iPw==
X-Gm-Message-State: ABy/qLbJBci5lD03S74daVafth1ya3oraZTax5SBj3Ymfz56H6yM3pj4
        6F911VxKCTNf0zK2bl4Onzn2Lg==
X-Google-Smtp-Source: APBJJlH7Lt4w+KKgSvUzSkJhF0oF8+b3ljHzveqc3Noqsk7KflIEw6xDKQ/sXRTNdo5n0Hc+oIf56w==
X-Received: by 2002:a05:6a20:729a:b0:100:b92b:e8be with SMTP id o26-20020a056a20729a00b00100b92be8bemr1785615pzk.2.1690363511718;
        Wed, 26 Jul 2023 02:25:11 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id h2-20020aa786c2000000b00682a99b01basm2004283pfo.0.2023.07.26.02.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 02:25:11 -0700 (PDT)
Message-ID: <491f5c8f-ccc6-dab8-71b3-caeedc8c4b39@bytedance.com>
Date:   Wed, 26 Jul 2023 17:24:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 17/47] rcu: dynamically allocate the rcu-lazy shrinker
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, david@fromorbit.com,
        tkhai@ya.ru, Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, djwong@kernel.org,
        Christian Brauner <brauner@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-18-zhengqi.arch@bytedance.com>
 <3A164818-56E1-4EB4-A927-1B2D23B81659@linux.dev>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <3A164818-56E1-4EB4-A927-1B2D23B81659@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/7/26 15:04, Muchun Song wrote:
> 
> 
>> On Jul 24, 2023, at 17:43, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>
>> Use new APIs to dynamically allocate the rcu-lazy shrinker.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>> kernel/rcu/tree_nocb.h | 19 +++++++++++--------
>> 1 file changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
>> index 43229d2b0c44..919f17561733 100644
>> --- a/kernel/rcu/tree_nocb.h
>> +++ b/kernel/rcu/tree_nocb.h
>> @@ -1397,12 +1397,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>> return count ? count : SHRINK_STOP;
>> }
>>
>> -static struct shrinker lazy_rcu_shrinker = {
>> -	.count_objects = lazy_rcu_shrink_count,
>> -	.scan_objects = lazy_rcu_shrink_scan,
>> -	.batch = 0,
>> -	.seeks = DEFAULT_SEEKS,
>> -};
>> +static struct shrinker *lazy_rcu_shrinker;
> 
> Seems there is no users of this variable, maybe we could drop
> this.

Yeah, will change it to a local variable. And the patch #15 is
the same.

> 
