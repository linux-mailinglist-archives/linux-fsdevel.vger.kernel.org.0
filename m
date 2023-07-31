Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F067696D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 14:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjGaMzL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 08:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjGaMzK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:55:10 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498A5E63
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 05:55:09 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686c06b806cso3063672b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 05:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690808109; x=1691412909;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygLOL6I5xrfNmKzP4Fot99+KrkBVpcn2MT2F/EVhYwo=;
        b=drtlXK+U4pKZC3tnZRn8nvmwGNTQMJZnIghAHY3cX3MJr9FjRTijWYSl7UadGOd0xp
         Csf2/x+gp25aqJRbt1ct0AIKgJ3Sc+hx4H/7OTa5HT0pLI+UfEu3Rq//XR/AvoEU5M/t
         RVdAZ2AhIhNGM/zQEARGArjmIegrvNxiiCOe42kySBULao2cCvRRhv6QPRc1n3RTncj+
         5Jj/UVEScl3JJ2PfDp5agjSxzS+11m9pOhsGIiTCB9ewHLzigDiSD6V3g7r1ov33Lzb2
         s08cvODvKLMNpzpoRQBoqb1BkF4FNMA9R3wuhVmFHJJhpMJHXbrnIxAMJQNMZgBvERLN
         UY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690808109; x=1691412909;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ygLOL6I5xrfNmKzP4Fot99+KrkBVpcn2MT2F/EVhYwo=;
        b=GJ1igHX/VoibuwEJ31mG4Cd3YPcfHMKkrRJ9cu+YlVKhbBNaweWgyPOXonlQCO2s34
         oDc0TnvKPKh389l96Z8z1E600Di9Lu8gvVfaI1D2TTQ93QUoUPTKJzz+QXfednGmJidB
         WMr7O6Sd+rBaqCIJXuog2dcaL1+p4KnZqNe32LpiYCcSjQWqes2NRCFncteXtJldG8wM
         OtG9GvBDpb9bJdV5Bs5off0R4WJ8bHKqS1MB+CcxR5XYgWjNTjPSf/uZ+2cKb72ricnc
         AZV0jUubaxkBj3iqlcUPggWniYHjnIRKjgNGSATlOtr73LHr4qieRpmBa3qK2prLpBG5
         MWNA==
X-Gm-Message-State: ABy/qLYwj6/ZdOWD6vsftp/e7hHoP0/z2eGtq3PZAPc8HfR/fyRX9M0M
        hcjrM/87DYg4VJ5GtaSH4sJ/yQ==
X-Google-Smtp-Source: APBJJlHXBmWra7k9TETazqpngIX2G2bpFY8wuRQhwH/AU5jAmgkvG9aVECpJrACS4F6FeVffXdxcag==
X-Received: by 2002:a05:6a20:a104:b0:118:e70:6f7d with SMTP id q4-20020a056a20a10400b001180e706f7dmr10214985pzk.10.1690808108779;
        Mon, 31 Jul 2023 05:55:08 -0700 (PDT)
Received: from [10.90.34.137] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id q20-20020a62ae14000000b00672ea40b8a9sm7739030pff.170.2023.07.31.05.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 05:55:08 -0700 (PDT)
Message-ID: <763e286d-8621-0dcc-bb9b-99eb053bc148@bytedance.com>
Date:   Mon, 31 Jul 2023 20:55:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.1
Subject: Re: [PATCH 10/11] MAINTAINERS: Add co-maintainer for maple tree
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-11-zhangpeng.00@bytedance.com>
 <20230726163955.r47vbkgjrcbg6iwv@revolver>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        npiggin@gmail.com, mathieu.desnoyers@efficios.com,
        peterz@infradead.org, michael.christie@oracle.com,
        surenb@google.com, willy@infradead.org, akpm@linux-foundation.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        linux-doc@vger.kernel.org, corbet@lwn.net, avagin@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230726163955.r47vbkgjrcbg6iwv@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/7/27 00:39, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230726 04:10]:
>> Add myself as co-maintainer for maple tree. I would like to assist
>> Liam R. Howlett in maintaining maple tree. I will continue to contribute
>> to the development of maple tree in the future.
> 
> Sorry, but no.
> 
> I appreciate the patches, bug fixes, and code review but there is no
> need for another maintainer for the tree at this time.
So can I add a reviewer here? This is convenient for me to review the
code and know the problems reported from the community. Usually I can't
receive maple tree issues reported by the community. It has no effect on
your maintenance of it.
> 
> Thank you,
> Liam
> 
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ddc71b815791..8cfedd492509 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -12526,6 +12526,7 @@ F:	net/mctp/
>>   
>>   MAPLE TREE
>>   M:	Liam R. Howlett <Liam.Howlett@oracle.com>
>> +M:	Peng Zhang <zhangpeng.00@bytedance.com>
>>   L:	linux-mm@kvack.org
>>   S:	Supported
>>   F:	Documentation/core-api/maple_tree.rst
>> -- 
>> 2.20.1
>>
