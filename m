Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3938B6AE29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2019 20:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387949AbfGPSIq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 14:08:46 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40352 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbfGPSIq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:08:46 -0400
Received: by linux.microsoft.com (Postfix, from userid 1029)
        id EE9A620B7185; Tue, 16 Jul 2019 11:08:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id CFA0830114FD;
        Tue, 16 Jul 2019 11:08:44 -0700 (PDT)
Date:   Tue, 16 Jul 2019 11:08:44 -0700 (PDT)
From:   Jaskaran Singh Khurana <jaskarankhurana@linux.microsoft.com>
X-X-Sender: jaskarankhurana@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
To:     Milan Broz <gmazyland@gmail.com>
cc:     ebiggers@google.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, jmorris@namei.org,
        Scott Shell <SCOTTSH@microsoft.com>,
        Nazmus Sakib <mdsakib@microsoft.com>, mpatocka@redhat.com
Subject: Re: [RFC PATCH v6 0/1] Add dm verity root hash pkcs7 sig
 validation.
In-Reply-To: <395efa90-65d8-d832-3e2b-2b8ee3794688@gmail.com>
Message-ID: <alpine.LRH.2.21.1907161035490.121213@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
References: <20190701181958.6493-1-jaskarankhurana@linux.microsoft.com> <MN2PR21MB12008A962D4DD8662B3614508AF20@MN2PR21MB1200.namprd21.prod.outlook.com> <alpine.LRH.2.21.1907121025510.66082@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
 <395efa90-65d8-d832-3e2b-2b8ee3794688@gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hello Milan,
On Tue, 16 Jul 2019, Milan Broz wrote:

> On 12/07/2019 19:33, Jaskaran Singh Khurana wrote:
>>
>> Hello Milan,
>>
>>> Changes in v6:
>>>
>>> Address comments from Milan Broz and Eric Biggers on v5.
>>>
>>> -Keep the verification code under config DM_VERITY_VERIFY_ROOTHASH_SIG.
>>>
>>> -Change the command line parameter to requires_signatures(bool) which will
>>> force root hash to be signed and trusted if specified.
>>>
>>> -Fix the signature not being present in verity_status. Merged the
>>> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fmbroz%2Flinux.git%2Fcommit%2F%3Fh%3Ddm-cryptsetup%26id%3Da26c10806f5257e255b6a436713127e762935ad3&amp;data=02%7C01%7CJaskaran.Khurana%40microsoft.com%7C18f92445e46940aeebb008d6fe50c610%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636976020210890638&amp;sdata=aY0V9%2FBz2RHryIvoftGKUGnyPp9Fsc1JY4FZbHfW4hg%3D&amp;reserved=0
>>> made by Milan Broz and tested it.
>>>
>>>
>>
>> Could you please provide feedback on this v6 version.
>
> Hi,
>
> I am ok with the v6 patch; I think Mike will return to it in 5.4 reviews.
>

Thanks for the help and also for reviewing this patch. Could you please 
add Reviewed-by/Tested-by tag to the patch.

> But the documentation is very brief. I spent quite a long time to configure the system properly.
> I think you should add more description (at least to patch header) how to use this feature in combination with system keyring.
>

I will add more documentation to the patch header describing the steps 
required for setup.

> Do I understand correctly that these steps need to be done?
>
> - user configures a certificate and adds it in kernel builtin keyring (I used CONFIG_SYSTEM_TRUSTED_KEYS option).
> - the dm-verity device root hash is signed directly by a key of this cert
> - the signature is uploaded to the user keyring
> - reference to signature in keyring is added as an optional dm-verity table parameter root_hash_sig_key_desc
> - optionally, require_signatures dm-verity module is set to enforce signatures.
>
> For reference, below is the bash script I used (with unpatched veritysetup to generate working DM table), is the expected workflow here?

The steps and workflow is correct. I will send the cryptsetup changes for 
review.

>
> #!/bin/bash
>
> NAME=test
> DEV=/dev/sdc
> DEV_HASH=/dev/sdd
> ROOT_HASH=778fccab393842688c9af89cfd0c5cde69377cbe21ed439109ec856f2aa8a423
> SIGN=sign.txt
> SIGN_NAME=verity:$NAME
>
> # get unsigned device-mapper table using unpatched veritysetup
> veritysetup open $DEV $NAME $DEV_HASH $ROOT_HASH
> TABLE=$(dmsetup table $NAME)
> veritysetup close $NAME
>
> # Generate self-signed CA key, must be in .config as CONFIG_SYSTEM_TRUSTED_KEYS="path/ca.pem"
> #openssl req -x509 -newkey rsa:1024 -keyout ca_key.pem -out ca.pem -nodes -days 365 -set_serial 01 -subj /CN=example.com
>
> # sign root hash directly by CA cert
> echo -n $ROOT_HASH | openssl smime -sign -nocerts -noattr -binary -inkey ca_key.pem -signer ca.pem -outform der -out $SIGN
>
> # load signature to keyring
> keyctl padd user $SIGN_NAME @u <$SIGN
>
> # add device-mapper table, now with sighed root hash optional argument
> dmsetup create -r $NAME --table "$TABLE 2 root_hash_sig_key_desc $SIGN_NAME"
> dmsetup table $NAME
>
> # cleanup
> dmsetup remove $NAME
> keyctl clear @u
>
>

Thanks for testing the changes and all the guidance here.

> Milan
>
Regards,
Jaskaran.
