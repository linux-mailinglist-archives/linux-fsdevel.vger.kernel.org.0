Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF736E1ADA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 05:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjDNDeK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 23:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjDNDeE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 23:34:04 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D6A30FA;
        Thu, 13 Apr 2023 20:34:03 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 9815C501E67;
        Fri, 14 Apr 2023 03:27:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id F3304501DD3;
        Fri, 14 Apr 2023 03:27:20 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1681442841; a=rsa-sha256;
        cv=none;
        b=aLYTobt89cI8jjAp1guUouiR0WtNxd9bZwF5N1GyFLasNytN4GfGNrtNONIzLzgh+FhM+P
        QTzWq2uUZs2BjktGkfprmUCZHxOBHJjtmRSn0FJzxeS4/zh2RFxZIbmukyGfq9PV1eIFZP
        G/gE73RVXBQor5/c//UhHqPxtcJ+HVy6lKL2Nar0qmwavhCcrlg0iImnRJfeyTEjejBWgj
        0cVMo5Y0FF8QmrvyHSIKWxb+TcOWNvsxa/BS96jx9GpKtg01TH94DfIB4vYw2CGmqbvIZE
        RWZJtaHDi+I6GcDMYNfj+FA4bSgg8knmJM5ZJGSCVmSO1b//QQuy8pophHvhZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1681442841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=FThEB5rx1CmZDbeaRmPeZu6YcPOHSHQi0j3F5edbnoQ=;
        b=dDLw11ltNqCt9qDHR7yodbKWA/GaZvkjP+Ksswu2Ytl9ArGLbdEwCFMgGbcHhEnKwAVPy4
        W346lhJPu9yR5n6AwPge+aUrvPJEGT+wFC5NdfzOF1Cp6mha9aswJ6AN/rEZcQjVxijGpJ
        JWsc8h5nNYQ2wEQdKZDnRkHCnMl/ZOLv1FdBQTUunTFicWMXqXeaZ70ACQdrhj8flrWScV
        YUlahTE2/BYQybuYLJ9I4ubSHAnucSvg1fycZUAxoe27LKizL68vLLJp1GYBZMgnjlZRPM
        8OwGfTGZ71dBV8okWHbntygLCfFYiyXhJ9wpFHhNnpXS67K07BWTu0eLh0KylA==
ARC-Authentication-Results: i=1;
        rspamd-548d6c8f77-4kznw;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dragan@stancevic.com
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dragan@stancevic.com
X-MailChannels-Auth-Id: dreamhost
X-Share-Towering: 2619d92b38461706_1681442841422_2092118245
X-MC-Loop-Signature: 1681442841422:3568380269
X-MC-Ingress-Time: 1681442841422
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.125.42.185 (trex/6.7.2);
        Fri, 14 Apr 2023 03:27:21 +0000
Received: from [192.168.1.31] (99-160-136-52.lightspeed.nsvltn.sbcglobal.net [99.160.136.52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: dragan@stancevic.com)
        by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4PyMMC489qz29;
        Thu, 13 Apr 2023 20:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stancevic.com;
        s=dreamhost; t=1681442840;
        bh=FThEB5rx1CmZDbeaRmPeZu6YcPOHSHQi0j3F5edbnoQ=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=vhwHM4NczR6ICPelvWMlkJsD/Z6+WmJ4mpjkWHpnpsG9LwaF7BsdLSmqi3X8VR0PD
         Qs3zsKe83peWKKv+IwiQ2m8xx0leg+Ir62/X9iH1P8zINu4aRMrwntR8PLLfGhInTN
         vVXR615SOr94Qb7gOp2GdOveOrp7v/Isf3Ks8V6Z+5xk5W/kGv8fALkgar2/GVpheT
         l0Sl+f8e8zAq/QCH2sn5ScEF5z2RoEKFkOBY81k8XUf3n/vHTR5ovq3OgT6LQdaJdI
         oUxlU5UA61u+HccLjgr2jgvXP34AWSiMhe/0UxcnlElRrBDQBhIsC09F2ARS4rnHQq
         YH2pQDxxDZZ0w==
Message-ID: <14f90e3f-f438-01b5-8f25-05b0f1cf2148@stancevic.com>
Date:   Thu, 13 Apr 2023 22:27:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [LSF/MM/BPF TOPIC] BoF VM live migration over CXL memory
Content-Language: en-US
To:     Kyungsan Kim <ks0204.kim@samsung.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
 <CGME20230410030532epcas2p49eae675396bf81658c1a3401796da1d4@epcas2p4.samsung.com>
 <20230410030532.427842-1-ks0204.kim@samsung.com>
From:   Dragan Stancevic <dragan@stancevic.com>
In-Reply-To: <20230410030532.427842-1-ks0204.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kyungsan-


On 4/9/23 22:05, Kyungsan Kim wrote:
>> Hi folks-
>>
>> if it's not too late for the schedule...
>>
>> I am starting to tackle VM live migration and hypervisor clustering over
>> switched CXL memory[1][2], intended for cloud virtualization types of loads.
>>
>> I'd be interested in doing a small BoF session with some slides and get
>> into a discussion/brainstorming with other people that deal with VM/LM
>> cloud loads. Among other things to discuss would be page migrations over
>> switched CXL memory, shared in-memory ABI to allow VM hand-off between
>> hypervisors, etc...
>>
>> A few of us discussed some of this under the ZONE_XMEM thread, but I
>> figured it might be better to start a separate thread.
>>
>> If there is interested, thank you.
> 
> I would like join the discussion as well.
> Let me kindly suggest it would be more great if it includes the data flow of VM/hypervisor as background and kernel interaction expected.

Thank you for the suggestion, have you had a chance to check out 
http://nil-migration.org/ I have a high-level data flow between 
hypervisors, both for VM migration and hypervisor clustering. If that is 
not enough, I can definitely throw more things together. Let me know, 
thank you



>>
>>
>> [1]. High-level overview available at http://nil-migration.org/
>> [2]. Based on CXL spec 3.0
>>
>> --
>> Peace can only come as a natural consequence
>> of universal enlightenment -Dr. Nikola Tesla
> 

-- 
--
Peace can only come as a natural consequence
of universal enlightenment -Dr. Nikola Tesla

