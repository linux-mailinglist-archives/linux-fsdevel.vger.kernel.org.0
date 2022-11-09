Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AB862343E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 21:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiKIULR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 15:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiKIULQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:11:16 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0713DEBB;
        Wed,  9 Nov 2022 12:11:14 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9Ivbm8003378;
        Wed, 9 Nov 2022 20:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=GezlASEUNaP1kWWGVWgY0gmLLeKBx9UhABHYYKuFy1A=;
 b=pL2/CKfDa3HcsTHmt9s+YKUqB5q6Egkaj76opKJxQ/iKAdBX0Yr7Q++Yhlp4fgMHhGDK
 sF9eW407rknG2mJyec2ncnyt/HhwwXupCXYHk99iw+S06IMNvhN0g03WnXLxlcPoa2eJ
 Ko9GIFKhRraYxDoPCpqoHkxAS6tvFyj5srUP6BxIpWBdsebwXbTN1A6OHZPqLqZ88q1I
 4ss+5Ju5c6Q6EdefePKhGxW6Y2G44plK9EUMalYpcyMbsh8cP1a5Y9UngIPPpUt+8VVp
 BLHDtOUaDajgt+isE2YaUNxvoli6oziI/aHsdLxyRXH3xIkIVARVIRmAtuybPnT+YFVW uA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3krfgux4r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 20:10:43 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A9Jukwr016004;
        Wed, 9 Nov 2022 20:10:42 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3krfgux4qs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 20:10:42 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A9K55II002688;
        Wed, 9 Nov 2022 20:10:41 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 3kngpjftd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 20:10:41 +0000
Received: from smtpav02.wdc07v.mail.ibm.com ([9.208.128.114])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A9KAdSd6881830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Nov 2022 20:10:40 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DB3E5805E;
        Wed,  9 Nov 2022 20:10:39 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFEFF58067;
        Wed,  9 Nov 2022 20:10:37 +0000 (GMT)
Received: from [9.211.78.124] (unknown [9.211.78.124])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  9 Nov 2022 20:10:37 +0000 (GMT)
Message-ID: <8447a726-c45d-8ebb-2a74-a4d759631e64@linux.vnet.ibm.com>
Date:   Wed, 9 Nov 2022 15:10:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/4] fs: define a firmware security filesystem named
 fwsecurityfs
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nayna Jain <nayna@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-efi@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, Dov Murik <dovmurik@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Russell Currey <ruscur@russell.cc>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>
References: <20221106210744.603240-1-nayna@linux.ibm.com>
 <20221106210744.603240-3-nayna@linux.ibm.com> <Y2uvUFQ9S2oaefSY@kroah.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
In-Reply-To: <Y2uvUFQ9S2oaefSY@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ETJ3mcIjDcmC9bU0wwhiQ_UGoUKvS5YV
X-Proofpoint-ORIG-GUID: _BJV8Qpgg8H5VffXdwMwQalF4Eu_YbE3
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1011 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211090151
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 11/9/22 08:46, Greg Kroah-Hartman wrote:
> On Sun, Nov 06, 2022 at 04:07:42PM -0500, Nayna Jain wrote:
>> securityfs is meant for Linux security subsystems to expose policies/logs
>> or any other information. However, there are various firmware security
>> features which expose their variables for user management via the kernel.
>> There is currently no single place to expose these variables. Different
>> platforms use sysfs/platform specific filesystem(efivarfs)/securityfs
>> interface as they find it appropriate. Thus, there is a gap in kernel
>> interfaces to expose variables for security features.
>>
>> Define a firmware security filesystem (fwsecurityfs) to be used by
>> security features enabled by the firmware. These variables are platform
>> specific. This filesystem provides platforms a way to implement their
>>   own underlying semantics by defining own inode and file operations.
>>
>> Similar to securityfs, the firmware security filesystem is recommended
>> to be exposed on a well known mount point /sys/firmware/security.
>> Platforms can define their own directory or file structure under this path.
>>
>> Example:
>>
>> # mount -t fwsecurityfs fwsecurityfs /sys/firmware/security
> Why not juset use securityfs in /sys/security/firmware/ instead?  Then
> you don't have to create a new filesystem and convince userspace to
> mount it in a specific location?

 From man 5 sysfs page:

/sys/firmware: This subdirectory contains interfaces for viewing and 
manipulating firmware-specific objects and attributes.

/sys/kernel: This subdirectory contains various files and subdirectories 
that provide information about the running kernel.

The security variables which are being exposed via fwsecurityfs are 
managed by firmware, stored in firmware managed space and also often 
consumed by firmware for enabling various security features.

 From git commit b67dbf9d4c1987c370fd18fdc4cf9d8aaea604c2, the purpose 
of securityfs(/sys/kernel/security) is to provide a common place for all 
kernel LSMs. The idea of
fwsecurityfs(/sys/firmware/security) is to similarly provide a common 
place for all firmware security objects.

/sys/firmware already exists. The patch now defines a new /security 
directory in it for firmware security features. Using 
/sys/kernel/security would mean scattering firmware objects in multiple 
places and confusing the purpose of /sys/kernel and /sys/firmware.

Even though fwsecurityfs code is based on securityfs, since the two 
filesystems expose different types of objects and have different 
requirements, there are distinctions:

1. fwsecurityfs lets users create files in userspace, securityfs only 
allows kernel subsystems to create files.

2. firmware and kernel objects may have different requirements. For 
example, consideration of namespacing. As per my understanding, 
namespacing is applied to kernel resources and not firmware resources. 
That's why it makes sense to add support for namespacing in securityfs, 
but we concluded that fwsecurityfs currently doesn't need it. Another 
but similar example of it is: TPM space, which is exposed from hardware. 
For containers, the TPM would be made as virtual/software TPM. Similarly 
for firmware space for containers, it would have to be something 
virtualized/software version of it.

3. firmware objects are persistent and read at boot time by interaction 
with firmware, unlike kernel objects which are not persistent.

For a more detailed explanation refer to the LSS-NA 2022 "PowerVM 
Platform Keystore - Securing Linux Credentials Locally" talk and 
slides[1]. The link to previously posted RFC version is [2].

[1] 
https://static.sched.com/hosted_files/lssna2022/25/NaynaJain_PowerVM_PlatformKeyStore_SecuringLinuxCredentialsLocally.pdf
[2] https://lore.kernel.org/linuxppc-dev/YrQqPhi4+jHZ1WJc@kroah.com/

Thanks & Regards,

      - Nayna

>
> thanks,
>
> greg k-h
