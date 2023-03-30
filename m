Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC716D11FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 00:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjC3WMp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 18:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjC3WMo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:12:44 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DE6103;
        Thu, 30 Mar 2023 15:12:42 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E28485C10EC;
        Thu, 30 Mar 2023 22:03:28 +0000 (UTC)
Received: from pdx1-sub0-mail-a294.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 1DB9A5C0FBE;
        Thu, 30 Mar 2023 22:03:28 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1680213808; a=rsa-sha256;
        cv=none;
        b=XMaUq83XK1kmiBrVQCBLGELpfGgEqlBZ4POvnXd6Ic9+Js2rKrQc3JQHOgxDHzMMHdHZjX
        IXkjGVQaJmfdt7UFBG8WX29gnsttJ7DNDYXln+SwfKnnOdnqQcC8gxMEQ4SOHANZq7r47O
        nwZRfd1yzSIZ7crc/iOAg3oTcYfGePJTK5jYw/cmk6QCUHFfrkTn5aBy8BS2bzP34COw6x
        dZJ/o6ocv79eaDc/C/sd9MjPdKaqBp5ShwvUeT8XoUWKSf3YKRhdWkN4XrKjuD3Y4juYmp
        zsMdTvjxEM50ZgfD2OZ/9zrayPxlryo7esfT/43qDYioBchn9CkV0XxnYsoq1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1680213808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=yPCzU6F6owMOhqlBeNEFKP1Ymsp3uChE2AkQ2JDym7k=;
        b=NWs1za+wNjVq6VIWH/eoSppAKw8d4ZBSK6dEk/aghERKTYPh9ypBV9q+JYMxZxlLRcfqCR
        pqqfDDB6+G1pNcGuFzN6Q8qArtQdgUlbXOidp67tDHAPAvT19OIO5NxCnGFCqzIOYpkVuc
        6+CKAbMGTgNxX3DwhfVk7RhgdSttTjRl+eRS9Szq/VaYntF4iDSiJlmbjAkpTkyF5Q5N7g
        dxx1uKXLK8xskkjdpaypCGZRreoJTHrbyEFCylc9/KtYjrZ/K1ognh45NCyOgSC2j+foLq
        UNXaR+OtH7yC/vfk7eVD9Q2iF91EZBjQxSI47BxFVxI0W2IAOm+cMUCkRcRJkg==
ARC-Authentication-Results: i=1;
        rspamd-786cb55f77-rg9g4;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dragan@stancevic.com
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dragan@stancevic.com
X-MailChannels-Auth-Id: dreamhost
X-Print-Spicy: 279d1eea155a1243_1680213808495_2461694109
X-MC-Loop-Signature: 1680213808495:2329669094
X-MC-Ingress-Time: 1680213808495
Received: from pdx1-sub0-mail-a294.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.101.8.122 (trex/6.7.2);
        Thu, 30 Mar 2023 22:03:28 +0000
Received: from [192.168.1.31] (99-160-136-52.lightspeed.nsvltn.sbcglobal.net [99.160.136.52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: dragan@stancevic.com)
        by pdx1-sub0-mail-a294.dreamhost.com (Postfix) with ESMTPSA id 4Pncqx3tpMzJJ;
        Thu, 30 Mar 2023 15:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stancevic.com;
        s=dreamhost; t=1680213807;
        bh=yPCzU6F6owMOhqlBeNEFKP1Ymsp3uChE2AkQ2JDym7k=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=hk403yWltsydDPdv3hVya3gI5wErNS+3eFchygO3ZCDDhUtXuy64l4J4TN6pAIzzp
         7JjTOwoeSQ3o+vMrVSWUD5d2vfd0KpHqIOgqh5RlitqZN9ZBq0qtguqIpWoDSaRBQw
         w6dbIsv4NUDDyoY5bU1TwJ0Jaq1hZ/D7JuS35V+EC51zKC2cZFC43K6bTP0bZyLaXz
         3ybyVSQ8y1xfKIEgBlFGf1Jiv+MboNE1jDrhF2T008wRHZSmsVfRdapWu7XQVW/yaG
         CYepfy9XIhzyS+RtjxIKyBHyhPNYmNx1SsBJ8eilgHjsRZrXHu00KoarGx135BkbNq
         miT3qQaFr40Ow==
Message-ID: <362a9e19-fea5-e45a-3c22-3aa47e851aea@stancevic.com>
Date:   Thu, 30 Mar 2023 17:03:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>
Cc:     dan.j.williams@intel.com, lsf-pc@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
        viacheslav.dubeyko@bytedance.com, ying.huang@intel.com,
        nil-migration@lists.linux.dev
References: <641b7b2117d02_1b98bb294cb@dwillia2-xfh.jf.intel.com.notmuch>
 <CGME20230323105106epcas2p39ea8de619622376a4698db425c6a6fb3@epcas2p3.samsung.com>
 <20230323105105.145783-1-ks0204.kim@samsung.com>
 <ZB/yb9n6e/eNtNsf@kernel.org>
From:   Dragan Stancevic <dragan@stancevic.com>
In-Reply-To: <ZB/yb9n6e/eNtNsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/26/23 02:21, Mike Rapoport wrote:
> Hi,
> 
> [..] >> One problem we experienced was occured in the combination of 
hot-remove and kerelspace allocation usecases.
>> ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
>> ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.
>> Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.
>> In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.
>> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.
>> As you well know, among heterogeneous DRAM devices, CXL DRAM is the first PCIe basis device, which allows hot-pluggability, different RAS, and extended connectivity.
>> So, we thought it could be a graceful approach adding a new zone and separately manage the new features.
> 
> This still does not describe what are the use cases that require having
> kernel allocations on CXL.mem.
> 
> I believe it's important to start with explanation *why* it is important to
> have kernel allocations on removable devices.

Hi Mike,

not speaking for Kyungsan here, but I am starting to tackle hypervisor 
clustering and VM migration over cxl.mem [1].

And in my mind, at least one reason that I can think of having kernel 
allocations from cxl.mem devices is where you have multiple VH 
connections sharing the memory [2]. Where for example you have a user 
space application stored in cxl.mem, and then you want the metadata 
about this process/application that the kernel keeps on one hypervisor 
be "passed on" to another hypervisor. So basically the same way 
processors in a single hypervisors cooperate on memory, you extend that 
across processors that span over physical hypervisors. If that makes 
sense...


[1] A high-level explanation is at http://nil-migration.org
[2] Compute Express Link Specification r3.0, v1.0 8/1/22, Page 51, 
figure 1-4, black color scheme circle(3) and bars.

--
Peace can only come as a natural consequence
of universal enlightenment -Dr. Nikola Tesla
