Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81D7E5C204
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 19:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfGARdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 13:33:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53792 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbfGARdB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:33:01 -0400
Received: by linux.microsoft.com (Postfix, from userid 1029)
        id 2FEB720BCFC5; Mon,  1 Jul 2019 10:33:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id 2922E3011494;
        Mon,  1 Jul 2019 10:33:00 -0700 (PDT)
Date:   Mon, 1 Jul 2019 10:33:00 -0700 (PDT)
From:   Jaskaran Singh Khurana <jaskarankhurana@linux.microsoft.com>
X-X-Sender: jaskarankhurana@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
To:     Milan Broz <gmazyland@gmail.com>
cc:     James Morris <jmorris@namei.org>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, scottsh@microsoft.com, mpatocka@redhat.com
Subject: Re: [RFC PATCH v5 0/1] Add dm verity root hash pkcs7 sig
 validation.
In-Reply-To: <749ddf56-3cb6-42c8-9ccc-71e09558400f@gmail.com>
Message-ID: <alpine.LRH.2.21.1907011029100.31396@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
References: <20190619191048.20365-1-jaskarankhurana@linux.microsoft.com> <20190628040041.GB673@sol.localdomain> <alpine.LRH.2.21.1906282040490.15624@namei.org> <749ddf56-3cb6-42c8-9ccc-71e09558400f@gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hello Milan,
On Mon, 1 Jul 2019, Milan Broz wrote:

> On 29/06/2019 06:01, James Morris wrote:
>> On Thu, 27 Jun 2019, Eric Biggers wrote:
>>
>>> I don't understand your justification for this feature.
>>>
>>> If userspace has already been pwned severely enough for the attacker to be
>>> executing arbitrary code with CAP_SYS_ADMIN (which is what the device mapper
>>> ioctls need), what good are restrictions on loading more binaries from disk?
>>>
>>> Please explain your security model.
>>
>> Let's say the system has a policy where all code must be signed with a
>> valid key, and that one mechanism for enforcing this is via signed
>> dm-verity volumes. Validating the signature within the kernel provides
>> stronger assurance than userspace validation. The kernel validates and
>> executes the code, using kernel-resident keys, and does not need to rely
>> on validation which has occurred across a trust boundary.
>
> Yes, but as it is implemented in this patch, a certificate is provided as
> a binary blob by the (super)user that activates the dm-verity device.
>
> Actually, I can put there anything that looks like a correct signature (self-signed
> or so), and dm-verity code is happy because the root hash is now signed.
>
> Maybe could this concept be extended to support in-kernel compiled certificates?
>
> I like the idea of signed root hash, but the truth is that if you have access
> to device activation, it brings nothing, you can just put any cert in the keyring
> and use it.
>
> Milan
>

The signature needs to be trusted by the .builtin_trusted_keys which is
a read-only list of keys that were compiled into the kernel. The 
verify_pkcs7_signature verifies trust against the builtin keyring so I 
think what you are suggesting is covered here.

Regards,
Jaskaran.
