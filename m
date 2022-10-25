Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCB160C66F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 10:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiJYIaR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 04:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiJYIaP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:30:15 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3441A813
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 01:30:13 -0700 (PDT)
Received: from [10.155.150.56] (unknown [213.29.99.90])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 696E942309;
        Tue, 25 Oct 2022 08:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1666686611;
        bh=IpGCaXSnEHGcfdf+6ZgfW2n51gWKuMgsS/Acim3Bbvg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=n1GodjfMY4WSDK4Qn0sV5HYDDpbDkpNDF2830wlGR1/nTgVBdX2xVCvczjHzBJJpq
         ONGvbSQc+AtRjpWILms7rrOILs2L//VOv5xKvm1Zyt3OmBd/M3DtEaREJ9+YFIIzGx
         e4oTjOkwPqs6BaDnI5MFFz9wVV1YhDxVxwLolc04at0ywz5CPDFj2trhhv0Xm6L3I1
         tDpS2b2iBE963wP5JJZDNOCnvpPXx9ylnO2wGKkBVD5sfE9zWwtJSnXjFJoGhZJIP0
         s2UXcqQXhTBxwiesCXkRyOmO1W25/ATxnaBCFZmVokZFfJuZ8Pr53lClI8lLeFDBhS
         Pbg0GjSsFDP7A==
Message-ID: <bd085a0c-543a-c67d-b1a3-c9ee891893eb@canonical.com>
Date:   Tue, 25 Oct 2022 01:30:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [apparmor] [PATCH 4/8] apparmor: use type safe idmapping helpers
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     Seth Forshee <sforshee@kernel.org>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org, apparmor@lists.ubuntu.com,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20221024111249.477648-1-brauner@kernel.org>
 <20221024111249.477648-5-brauner@kernel.org>
 <5ae36c94-18dd-2f7a-b5f4-3c2122415dc7@canonical.com>
 <20221025074427.jjfx4sa2kl7w5ua5@wittgenstein>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20221025074427.jjfx4sa2kl7w5ua5@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/25/22 00:44, Christian Brauner wrote:
> On Tue, Oct 25, 2022 at 12:16:02AM -0700, John Johansen wrote:
>> On 10/24/22 04:12, Christian Brauner wrote:
>>> We already ported most parts and filesystems over for v6.0 to the new
>>> vfs{g,u}id_t type and associated helpers for v6.0. Convert the remaining
>>> places so we can remove all the old helpers.
>>> This is a non-functional change.
>>>
>>> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
>>
>> Acked-by: John Johansen <john.johansen@canonical.com>
> 
> Would you mind if I carry this patch together with the other conversion
> patches in my tree? This would make the whole conversion a lot simpler
> because we're removing a bunch of old helpers at the end.

Not at all. I almost asked which tree you wanted it in, and then got
distracted and when I came back to it ...

