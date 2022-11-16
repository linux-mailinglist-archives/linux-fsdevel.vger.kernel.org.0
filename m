Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B72D62B5F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 10:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiKPJFU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 04:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiKPJFQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:05:16 -0500
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A641B2BCB;
        Wed, 16 Nov 2022 01:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=From:Cc:To:Date:Message-ID;
        bh=gUmkrgDa5peUzAulyxduaOC9eq+aqOB7R+Ozro+CZPs=; b=x765iAsR3ywBrEggKYeAxJV0N8
        oZszZ6yvId1q4gCiZnXruJqL31s0kW4lL2dYA58HiS8pZIfuXVG0IRLkKPpXFi42W9racTKu5hW9A
        mjblbrUJa/QttfFfmprd0/eSuA+ErlcOIGw3/2fC4iRDXyxzUFqBDETPZZDttqeuHyp3dWxLfQ6Zx
        vq6Q8nEoeFiK8ZsSUsoq9L2o4LV148cvnOUJ2ZSZT72h9+ENpeEtHvuavv8Bxw6yS9fq6dynCQ435
        v5jc988OV6U+sEfrvMjG2lKEIWsQqmdt2IW+Ugb3q+fIm4dJ/hLbetbyvNbXEEaR9J1MjclAwH/Iy
        lI07q+pmQ9C/5w6llVCHzy73bvEQCOVXFFY7xX8qhKVkQq4Ls9HlhZx+fhfa1elZa5JHsWbbubRNh
        moBCWB6NdIwcZvG2Kzr9bwMRYIiZDMwSLvKUW62GGG/AqNpDn9aeVv42yjeZSfRO0ryiFx+ViH70Q
        /EJXI6E4U46TFb0EMOXUaJyh;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1ovEM3-008qja-G2; Wed, 16 Nov 2022 09:05:11 +0000
Message-ID: <88b441af-d6ae-4d46-aae5-0b649e76031d@samba.org>
Date:   Wed, 16 Nov 2022 10:05:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] cifs: Fix problem with encrypted RDMA data read
Content-Language: en-US, de-DE
To:     David Howells <dhowells@redhat.com>
Cc:     smfrench@gmail.com, tom@talpey.com, Long Li <longli@microsoft.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <3609b064-175c-fc18-cd1a-e177d0349c58@samba.org>
 <166855224228.1998592.2212551359609792175.stgit@warthog.procyon.org.uk>
 <2147870.1668582019@warthog.procyon.org.uk>
From:   Stefan Metzmacher <metze@samba.org>
In-Reply-To: <2147870.1668582019@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 16.11.22 um 08:00 schrieb David Howells:
> Stefan Metzmacher <metze@samba.org> wrote:
> 
>> I'm not sure I understand why this would fix anything when encryption is
>> enabled.
>>
>> Is the payload still be offloaded as plaintext? Otherwise we wouldn't have
>> use_rdma_mr...  So this rather looks like a fix for the non encrypted case.
> 
> The "inline"[*] PDUs are encrypted, but the direct RDMA data transmission is
> not.  I'm not sure if this is a bug in ksmbd.

It's a bug in the client!

> As I understand it, encrypting and decrypting the directly transferred
> data would need to be done by the NIC, not the cifs driver.

No, the encryption needs to happen above the RDMA/NIC layer.

metze
