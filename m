Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 422095A54D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 21:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfF1TpM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 15:45:12 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60050 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfF1TpM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 15:45:12 -0400
Received: by linux.microsoft.com (Postfix, from userid 1029)
        id 5A4D22007696; Fri, 28 Jun 2019 12:45:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id 4A08C301032E;
        Fri, 28 Jun 2019 12:45:11 -0700 (PDT)
Date:   Fri, 28 Jun 2019 12:45:11 -0700 (PDT)
From:   Jaskaran Singh Khurana <jaskarankhurana@linux.microsoft.com>
X-X-Sender: jaskarankhurana@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
To:     Eric Biggers <ebiggers@kernel.org>
cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, jmorris@namei.org, scottsh@microsoft.com,
        mpatocka@redhat.com, gmazyland@gmail.com
Subject: Re: [RFC PATCH v5 0/1] Add dm verity root hash pkcs7 sig
 validation.
In-Reply-To: <20190628040041.GB673@sol.localdomain>
Message-ID: <alpine.LRH.2.21.1906281242110.2789@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
References: <20190619191048.20365-1-jaskarankhurana@linux.microsoft.com> <20190628040041.GB673@sol.localdomain>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hello Eric,
On Thu, 27 Jun 2019, Eric Biggers wrote:

> On Wed, Jun 19, 2019 at 12:10:47PM -0700, Jaskaran Khurana wrote:
>> This patch set adds in-kernel pkcs7 signature checking for the roothash of
>> the dm-verity hash tree.
>> The verification is to support cases where the roothash is not secured by
>> Trusted Boot, UEFI Secureboot or similar technologies.
>> One of the use cases for this is for dm-verity volumes mounted after boot,
>> the root hash provided during the creation of the dm-verity volume has to
>> be secure and thus in-kernel validation implemented here will be used
>> before we trust the root hash and allow the block device to be created.
>>
>> Why we are doing validation in the Kernel?
>>
>> The reason is to still be secure in cases where the attacker is able to
>> compromise the user mode application in which case the user mode validation
>> could not have been trusted.
>> The root hash signature validation in the kernel along with existing
>> dm-verity implementation gives a higher level of confidence in the
>> executable code or the protected data. Before allowing the creation of
>> the device mapper block device the kernel code will check that the detached
>> pkcs7 signature passed to it validates the roothash and the signature is
>> trusted by builtin keys set at kernel creation. The kernel should be
>> secured using Verified boot, UEFI Secure Boot or similar technologies so we
>> can trust it.
>>
>> What about attacker mounting non dm-verity volumes to run executable
>> code?
>>
>> This verification can be used to have a security architecture where a LSM
>> can enforce this verification for all the volumes and by doing this it can
>> ensure that all executable code runs from signed and trusted dm-verity
>> volumes.
>>
>> Further patches will be posted that build on this and enforce this
>> verification based on policy for all the volumes on the system.
>>
>
> I don't understand your justification for this feature.
>
> If userspace has already been pwned severely enough for the attacker to be
> executing arbitrary code with CAP_SYS_ADMIN (which is what the device mapper
> ioctls need), what good are restrictions on loading more binaries from disk?
>
> Please explain your security model.
>
> - Eric
>

In a datacenter like environment, this will protect the system from below 
attacks:

1.Prevents attacker from deploying scripts that run arbitrary executables on the system.
2.Prevents physically present malicious admin to run arbitrary code on the
   machine.

Regards,
Jaskaran
