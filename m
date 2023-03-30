Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D3F6D11E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 00:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjC3WGS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 18:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjC3WGM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:06:12 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F413114;
        Thu, 30 Mar 2023 15:02:55 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 87705141D2C;
        Thu, 30 Mar 2023 22:02:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a294.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id DF39414150F;
        Thu, 30 Mar 2023 22:02:53 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1680213774; a=rsa-sha256;
        cv=none;
        b=GxihehXc/ZVXJRjYYYK5nA0/9U+zrV1T1grQRFO+pYHT0JyXFo4km0cdUFCG/ZLWlaS63R
        3rRdTseinHqETPIzEpYPNN6mG6374ORYnRFIlPvc9uS8+3gFWWMOMiscnFgDNIFT868NN5
        vQrl9ZqyNBr4vHo6Yct2OKVMxPV7FHXife/Zeisg2X2IOr2seuii7Q32j81xEAjpxK8OIv
        45Iu+rJ0COusSkoikL4CcYpA6VGrF5t4Gca+1Y8Voh/x2XVpRXUgrmmNuL85BH5tN6L8lm
        37uYFScl+YC66Yg4VMwClmT0M3Qv7sTvJaW8+fCBR3mdwp3o38/D9Nw77GtTVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1680213774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=rDBoPi7u8Hdh3eFhndrLHZE31sc7ofYBzJWm4lYAkos=;
        b=vovd/zqcchTZbqeOwGNoDYRKB7K5sEtM6adMw5qdRjTTOaYQpFfbgADu/Jjiq2+P8F1M13
        aVS2XI3oDnCKsJhpRZgeQiyxAHwzG05Guq0wqWZsgeppQBjQN1KO0vMddKlJyKj7dZz/p1
        l96xpNH8v5Oe28UckKsjOao4jYdvnMvO6Gu+UkdQf0E+RgjjkbJGL/WCUZnxUwn+e7IBCP
        BQFl5M67be5D/3Sm6JabRRnN0XZCVVR/UYVoYBjWTG4WQgdCBSgmmOfTaUBs3xbFquSgVy
        8izNbt9jvBRPLyEMx0+hwCtMOQAXzZNpgTFiXJrFw2Q9wCXJgVBk1msOwqzifA==
ARC-Authentication-Results: i=1;
        rspamd-786cb55f77-d9lht;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dragan@stancevic.com
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dragan@stancevic.com
X-MailChannels-Auth-Id: dreamhost
X-Trail-Thread: 64ee653e6e8b3c6f_1680213774245_3606843821
X-MC-Loop-Signature: 1680213774245:3282326279
X-MC-Ingress-Time: 1680213774244
Received: from pdx1-sub0-mail-a294.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.217.198 (trex/6.7.2);
        Thu, 30 Mar 2023 22:02:54 +0000
Received: from [192.168.1.31] (99-160-136-52.lightspeed.nsvltn.sbcglobal.net [99.160.136.52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dragan@stancevic.com)
        by pdx1-sub0-mail-a294.dreamhost.com (Postfix) with ESMTPSA id 4PncqH3jMPzBY;
        Thu, 30 Mar 2023 15:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stancevic.com;
        s=dreamhost; t=1680213773;
        bh=rDBoPi7u8Hdh3eFhndrLHZE31sc7ofYBzJWm4lYAkos=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=hufabQvnYtZ/bTfYroVuIVnOgUVGeVrgJwwLUC/E1om/WAvr35cc2MVPdjqBlmlbH
         5iXKY9ianqKhLFUaPMRkzbgeXt8EwNwUcRC4mLwmqoNXYqzBh6nGI9GyNx/qA2awNr
         OMGjHChH9QQp0Fp0T9NUj2wkDlQkpiFBduBzH57WN9eQIR+qwdHuICnI4JzhsSYb5l
         NNUlNJcqPs/ZpDwPZZxAu1gtw5EQY+2Kfw8F401ZdAXO1jSIszliO27AhLxkOE5RS/
         G61UZpI33yPBGoDqH/1x7dwnVwFgKErOOsmWhRO+nBG/EEAENeax92Wdog1oCC0e75
         BQzOdy7sV9xVg==
Message-ID: <e4a8433a-fdca-e806-c7e9-750e81176228@stancevic.com>
Date:   Thu, 30 Mar 2023 17:02:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Content-Language: en-US
To:     Kyungsan Kim <ks0204.kim@samsung.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
        viacheslav.dubeyko@bytedance.com, nil-migration@lists.linux.dev
References: <CGME20230221014114epcas2p1687db1d75765a8f9ed0b3495eab1154d@epcas2p1.samsung.com>
 <20230221014114.64888-1-ks0204.kim@samsung.com>
From:   Dragan Stancevic <dragan@stancevic.com>
In-Reply-To: <20230221014114.64888-1-ks0204.kim@samsung.com>
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

On 2/20/23 19:41, Kyungsan Kim wrote:
> CXL is a promising technology that leads to fundamental changes in computing architecture.
> To facilitate adoption and widespread of CXL memory, we are developing a memory tiering solution, called SMDK[1][2].
> Using SMDK and CXL RAM device, our team has been working with industry and academic partners over last year.
> Also, thanks to many researcher's effort, CXL adoption stage is gradually moving forward from basic enablement to real-world composite usecases.
> At this moment, based on the researches and experiences gained working on SMDK, we would like to suggest a session at LSF/MM/BFP this year
> to propose possible Linux MM changes with a brief of SMDK.
> 
> Adam Manzanares kindly adviced me that it is preferred to discuss implementation details on given problem and consensus at LSF/MM/BFP.
> Considering the adoption stage of CXL technology, however, let me suggest a design level discussion on the two MM expansions of SMDK this year.
> When we have design consensus with participants, we want to continue follow-up discussions with additional implementation details, hopefully.
> 
>   
> 1. A new zone, ZONE_EXMEM
> We added ZONE_EXMEM to manage CXL RAM device(s), separated from ZONE_NORMAL for usual DRAM due to the three reasons below.

Hi Kyungsan-

I read through your links and I am very interested in this 
talk/discussion from the perspective of cloud/virtualization hypervisor 
loads.

The problem that I am starting to tackle is clustering of hypervisors 
over cxl.mem for high availability of virtual machines. Or live 
migration of virtual machines between hypervisors using cxl.mem [1].


So I was wondering, with regards to the ZONE_XMEM, has any thought been 
given to the shared memory across virtual hierarchies [2], where you 
have cxl.mem access over cxl switches by multiple VH connections. It 
seems to me that there might be a need for differentiation of direct 
cxl.mem and switched cxl.mem. At least from the point of view where you 
have multiple hypervisors sharing the memory over a switch. Where they 
would potentially have to synchronize state/metadata about the memory.


[1] A high-level explanation is at http://nil-migration.org
[2] Compute Express Link Specification r3.0, v1.0 8/1/22, Page 51, 
figure 1-4, black color scheme circle(3) and bars.


--
Peace can only come as a natural consequence
of universal enlightenment -Dr. Nikola Tesla
