Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F263658FF2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 03:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfF1BwE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 21:52:04 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54352 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF1BwD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 21:52:03 -0400
Received: by linux.microsoft.com (Postfix, from userid 1029)
        id F37CB20B719F; Thu, 27 Jun 2019 18:52:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id EAF7C30056D6;
        Thu, 27 Jun 2019 18:52:02 -0700 (PDT)
Date:   Thu, 27 Jun 2019 18:52:02 -0700 (PDT)
From:   Jaskaran Singh Khurana <jaskarankhurana@linux.microsoft.com>
X-X-Sender: jaskarankhurana@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
To:     Milan Broz <gmazyland@gmail.com>
cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, jmorris@namei.org, scottsh@microsoft.com,
        ebiggers@google.com, mpatocka@redhat.com
Subject: Re: [RFC PATCH v5 1/1] Add dm verity root hash pkcs7 sig
 validation.
In-Reply-To: <568f2532-e46b-5ac7-4fc5-c96983702f2d@gmail.com>
Message-ID: <alpine.LRH.2.21.1906271850280.22562@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
References: <20190619191048.20365-1-jaskarankhurana@linux.microsoft.com> <20190619191048.20365-2-jaskarankhurana@linux.microsoft.com> <568f2532-e46b-5ac7-4fc5-c96983702f2d@gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Thu, 27 Jun 2019, Milan Broz wrote:

> Hi,
>
> I tried to test test the patch, two comments below.
>
> On 19/06/2019 21:10, Jaskaran Khurana wrote:
>> The verification is to support cases where the roothash is not secured by
>> Trusted Boot, UEFI Secureboot or similar technologies.
>> One of the use cases for this is for dm-verity volumes mounted after boot,
>> the root hash provided during the creation of the dm-verity volume has to
>> be secure and thus in-kernel validation implemented here will be used
>> before we trust the root hash and allow the block device to be created.
>>
>> The signature being provided for verification must verify the root hash and
>> must be trusted by the builtin keyring for verification to succeed.
>>
>> The hash is added as a key of type "user" and the description is passed to
>> the kernel so it can look it up and use it for verification.
>>
>> Kernel commandline parameter will indicate whether to check (only if
>> specified) or force (for all dm verity volumes) roothash signature
>> verification.
>>
>> Kernel commandline: dm_verity.verify_sig=1 or 2 for check/force root hash
>> signature validation respectively.
>
> 1) I think the switch should be just boolean - enforce signatures for all dm-verity targets
> (with default to false/off).
>
> The rest should be handled by simple logic - if the root_hash_sig_key_desc option
> is specified, the signature MUST be validated in the constructor, all errors should cause
> failure (bad reference in keyring, bad signature, etc).
>
> (Now it ignores for example bad reference to the keyring, this is quite misleading.)
>
> If a user wants to activate a dm-verity device without a signature, just remove
> optional argument referencing the signature.
> (This is not possible with dm_verity.verify_sig set to true/on.)
>
>
> 2) All DM targets must provide the same mapping table status ("dmsetup table"
> command) as initially configured.
> The output of the command should be directly usable as mapping table constructor.
>
> Your patch is missing that part, I tried to fix it, add-on patch is here
> https://git.kernel.org/pub/scm/linux/kernel/git/mbroz/linux.git/commit/?h=dm-cryptsetup&id=a26c10806f5257e255b6a436713127e762935ad3
> (feel free to fold it in your patch)
>
>
> Thanks,
> Milan
>
Hello Milan,

Thanks for testing and reviewing this. I will take care of the above 
comments change it to a boolean and for the second point merge the add-on 
patch that you shared.

Regards,
Jaskaran
