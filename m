Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CE76F868F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 18:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjEEQVr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 12:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjEEQVp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 12:21:45 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFA718153;
        Fri,  5 May 2023 09:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gkUXea03h8uWKVqa2VzCFOvae4v3EIKrcaZmVU3B9iU=; b=PbzGZyzh83Kr0tzoBrEskvjODr
        sjy37g9grXQBFZg5doPrJ3Li1Sa0pNzshjZESFvDBJsaTLnG0tVCLymddHnfJMlm3io3hKUqKa/C3
        1GTw4Ttz8eUIujWs2IUvxW2YRV/wvd67ZJXeEZ9WDzIn61qmw8dMn6rbNPS2625Tr8uxuBr7m1Ep9
        +L5AbL6Kr7wk7hAXtNeZgVWFZEA5Ct+JcWskIbfg1TZz4qwQJ4sshiRzlVOk0+/j4k5f+ZJWXx5mo
        tLVbWJlRMxOUGb3YqrMYRHI6qWoxSdq9VyC1hA0MOnhGJwUSlB78PaBmXHT8B7q8cYaZ0KkyjNFvZ
        x3M4U3RQ==;
Received: from [177.189.3.64] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1puyBg-001xcm-U8; Fri, 05 May 2023 18:21:41 +0200
Message-ID: <45616a57-a7c4-104e-c488-9250b5bd8e9e@igalia.com>
Date:   Fri, 5 May 2023 13:21:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/2] Supporting same fsid filesystems mounting on btrfs
Content-Language: en-US
To:     kreijack@inwind.it
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <5056b834-077c-d1bb-4c46-3213bf6da74b@libero.it>
 <1818142b-ec3a-323d-7a8d-0b93c33756fc@igalia.com>
 <e42e2e38-2c79-c14e-a06b-65d94c37e3db@inwind.it>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <e42e2e38-2c79-c14e-a06b-65d94c37e3db@inwind.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/05/2023 18:09, Goffredo Baroncelli wrote:
> [...]
>> Is there any missing step from my side, or mounting both devices is
>> really a limitation when using the forget option?
>>
> 
>  From my limited BTRFS internal knowledge, I think that your patches
> takes the correct approach: using the "metadata_uuid" code to allow
> two filesystems with the same uuid to exist at the same time.
> 
> [...] 
>> How btrfs would know it is a case for single-device filesystem? In other
>> words: how would we distinguish between the cases we want to auto-forget
>> before mounting, and the cases in which this behavior is undesired?
> 
> If I remember correctly in the super-block there is the number of disks
> that compose the filesystem. If the count is 1, it should be safe to
> forget-before-mount the filesystem (or to not store in the cache
> after a scan)

Thanks Goffredo, for the clarifications =)
