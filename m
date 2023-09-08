Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517BF7986BD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 14:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239992AbjIHMHs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 08:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjIHMHr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:07:47 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EF81BC5;
        Fri,  8 Sep 2023 05:07:44 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-402c46c49f4so21012795e9.1;
        Fri, 08 Sep 2023 05:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694174862; x=1694779662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:newsgroups:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c0BAeFuaE3UP1EYT6gPTFY3nFreECTYzpkSaiTl/irI=;
        b=XnobNMxrVO9ujWqKtkXCc8YJZd6M7hNAo4hwY00IOdA1HTH+Y1Lbx+4pYoKXbw8JHj
         Ap9xd4EBzm++0oiRUH1giniwF/StgTPMszmuZJYJJCWLZFkQmhqYQ9qfgsZDWy5mQ0e7
         7X0c5InEvoo2Itbzc9edSrmA2A+2b8bUUU1lqaHyCgMLoVd/h9qh4lycIr8MHqUrHxl6
         V1yF5aB6+lvau6PMfMNuF96qQ/kdX2xkZPG/zbv6opPshzvInRE0OWA8btU85XWPJiTs
         D4TPRn2u6wGgscIUnQ9cVo6WLhrlzFPJtTWaowZKK1X9ZvYV2oaPnY9jVFH0Zt84Q/z2
         9kXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694174862; x=1694779662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:newsgroups:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c0BAeFuaE3UP1EYT6gPTFY3nFreECTYzpkSaiTl/irI=;
        b=si7MsT8Nhm11p2n6UorRWhg6Q0DfO3sECRbcqQLVFsPKgEjUlu/TwJZ5I3du+kqhbc
         m6ymkvglplSqbgzHHomnLVbY+cVIdzHhiiBBDF161n81DBaGfU/u3xa2vTB7zkF5CyIj
         fnckPLQgVJZFCRJducGOvy7XRoplEbGf9nqscpxTAuQ0XKgbVPXGX5L5Dkx5WLGgJip2
         szp4IE3uxf/usZhOlvVmuc9XwL1rSd6+OB36pgxxRd6pGLiDCrPdH4LHm3L8WSJSHtZp
         s2mLlpzzqspHIzAXX4rbIAjFlNMfg85sCYkw39GXqN3+ZwfkEI/CrImglGhcEGxgeOJ2
         yZuQ==
X-Gm-Message-State: AOJu0Yzo/r86S+vSM7PR4MlBJMrPg70MQxzZpz3PBqXK33q7EguD8RFN
        IamDOzkprssmglsQfRe9/m8=
X-Google-Smtp-Source: AGHT+IGFPze7uqlGuOkxsqG+tOAOEeIw5h1YgkB0yA7TBv3BViY4t1LSgTZsQfXKgp2HC1PCvJ8dQg==
X-Received: by 2002:a1c:7707:0:b0:401:5443:55a1 with SMTP id t7-20020a1c7707000000b00401544355a1mr1913379wmi.3.1694174862320;
        Fri, 08 Sep 2023 05:07:42 -0700 (PDT)
Received: from [10.43.17.103] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n8-20020a7bcbc8000000b003fe29f6b61bsm1816111wmi.46.2023.09.08.05.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 05:07:41 -0700 (PDT)
Message-ID: <4a0952f8-32b1-46fc-a9f2-4be58ee41ace@gmail.com>
Date:   Fri, 8 Sep 2023 14:07:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix writing to the filesystem after unmount
To:     Christian Brauner <brauner@kernel.org>,
        Zdenek Kabelac <zkabelac@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Mikulas Patocka <mpatocka@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Newsgroups: gmane.linux.file-systems,gmane.linux.kernel,gmane.linux.kernel.device-mapper.devel
References: <60f244be-803b-fa70-665e-b5cba15212e@redhat.com>
 <20230906-aufkam-bareinlage-6e7d06d58e90@brauner>
 <818a3cc0-c17b-22c0-4413-252dfb579cca@redhat.com>
 <20230907094457.vcvmixi23dk3pzqe@quack3>
 <20230907-abgrenzen-achtung-b17e9a1ad136@brauner>
 <513f337e-d254-2454-6197-82df564ed5fc@redhat.com>
 <20230908073244.wyriwwxahd3im2rw@quack3>
 <86235d7a-a7ea-49da-968e-c5810cbf4a7b@redhat.com>
 <20230908102014.xgtcf5wth2l2cwup@quack3>
 <15c62097-d58f-4e66-bdf5-e0edb1306b2f@redhat.com>
 <20230908-bergwacht-bannen-1855c8afe518@brauner>
Content-Language: en-US, cs
From:   Zdenek Kabelac <zdenek.kabelac@gmail.com>
In-Reply-To: <20230908-bergwacht-bannen-1855c8afe518@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dne 08. 09. 23 v 13:32 Christian Brauner napsal(a):
>> I'd say there are several options and we should aim towards the variant
>> which is most usable by normal users.
> 
> None of the options is sufficiently satisfying to risk intricate
> behavioral changes with unknown consequences for existing workloads as
> far as I'm concerned.
> 

I'm not convinced anyone has the 'fsfreeze' + 'unmount' as a regular workload. 
  Thus solving this unusual race case shouldn't be breaking anyones else 
existing workload.

ATM there is no good solution for this particular case.

So can you please elaborate which new risks are we going to introduce by 
fixing this resource hole ?


Zdenek
