Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D61632D0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 20:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiKUTfR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 14:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiKUTfO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:35:14 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E06CB9F7;
        Mon, 21 Nov 2022 11:35:11 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALJ0A1I011420;
        Mon, 21 Nov 2022 19:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XMHX4r6tWaG5HyFsSipFN4RQm3o8bUhS5ONbNFz1Ozw=;
 b=IGIVHLPbMkPs/3cWttBg0CqOuwscPUTK973cpDih5m6gAcuTg/Z8p52E13Sg0PJQjBAv
 OLo9mh99wtquF7xr9fdxHv5Kat1PTuTmNI43P8zeZO0NMG2m2EgtLyllRSgfPTAezCVW
 7TvKI8+/MaHcytFy7SeE1Y1AUn+h8HvbQJ3FOtfS0owj6UPgiRWme2riextJ4AJOMW8A
 FB7/TeDVWr+7ENjxjez4iclu5uh+PDEP0MDW3Qy93ofGhZoID0dIhxEe9GZ5IMIve+u4
 C2kK7NYadT48Y7JSPABP6YpYQDPgX+HYhKYNpwf7oAE4NX7kbvJ46IxumNoC46RdkQCf Rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0d3g3r04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 19:34:49 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ALJOXHE016414;
        Mon, 21 Nov 2022 19:34:49 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0d3g3qyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 19:34:49 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ALJLD0K019431;
        Mon, 21 Nov 2022 19:34:47 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01wdc.us.ibm.com with ESMTP id 3kxps97c3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 19:34:47 +0000
Received: from smtpav06.wdc07v.mail.ibm.com ([9.208.128.115])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ALJYkh67602782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 19:34:47 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 535EA58054;
        Mon, 21 Nov 2022 19:34:46 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6E0458056;
        Mon, 21 Nov 2022 19:34:44 +0000 (GMT)
Received: from [9.163.61.172] (unknown [9.163.61.172])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 21 Nov 2022 19:34:44 +0000 (GMT)
Message-ID: <84ddfea2-c2b7-6e84-718d-739ff00e957e@linux.vnet.ibm.com>
Date:   Mon, 21 Nov 2022 14:34:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/4] fs: define a firmware security filesystem named
 fwsecurityfs
Content-Language: en-US
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>, linux-efi@vger.kernel.org,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, Dov Murik <dovmurik@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-fsdevel@vger.kernel.org,
        George Wilson <gcwilson@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Stefan Berger <stefanb@linux.ibm.com>
References: <20221106210744.603240-1-nayna@linux.ibm.com>
 <20221106210744.603240-3-nayna@linux.ibm.com> <Y2uvUFQ9S2oaefSY@kroah.com>
 <8447a726-c45d-8ebb-2a74-a4d759631e64@linux.vnet.ibm.com>
 <Y2zLRw/TzV/sWgqO@kroah.com>
 <44191f02-7360-bca3-be8f-7809c1562e68@linux.vnet.ibm.com>
 <Y3anQukokMcQr+iE@kroah.com>
 <d615180d-6fe5-d977-da6a-e88fd8bf5345@linux.vnet.ibm.com>
 <Y3pSF2MRIXd6aH14@kroah.com>
 <88111914afc6204b2a3fb82ded5d9bfb6420bca6.camel@HansenPartnership.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
In-Reply-To: <88111914afc6204b2a3fb82ded5d9bfb6420bca6.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5qwyL1VGEDwEbovNCVAiJnFzbjnzziHD
X-Proofpoint-GUID: wyCxSb4iOI18wGF1voQk7RF8fnGsXigr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_16,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=743 clxscore=1011
 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211210147
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 11/20/22 22:14, James Bottomley wrote:
> On Sun, 2022-11-20 at 17:13 +0100, Greg Kroah-Hartman wrote:
>> On Sat, Nov 19, 2022 at 01:20:09AM -0500, Nayna wrote:
>>> On 11/17/22 16:27, Greg Kroah-Hartman wrote:
>>>> On Mon, Nov 14, 2022 at 06:03:43PM -0500, Nayna wrote:
>>>>> On 11/10/22 04:58, Greg Kroah-Hartman wrote:
> [...]
>>>
[...]
>>> You are correct. There's no namespace for these.
>> So again, I do not understand.  Do you want to use filesystem
>> namespaces, or do you not?
> Since this seems to go back to my email quoted again, let me repeat:
> the question isn't if this patch is namespaced; I think you've agreed
> several times it isn't.  The question is if the exposed properties
> would ever need to be namespaced.  This is a subtle and complex
> question which isn't at all explored by the above interchange.
>
>> How again can you not use sysfs or securityfs due to namespaces?
>> What is missing?
> I already explained in the email that sysfs contains APIs like
> simple_pin_... which are completely inimical to namespacing.  Currently
> securityfs contains them as well, so in that regard they're both no
> better than each other.  The point I was making is that securityfs is
> getting namespaced by the IMA namespace rework (which is pretty complex
> due to having to replace the simple_pin_... APIs), so when (perhaps if)
> the IMA namespace is accepted, securityfs will make a good home for
> quantities that need namespacing.  That's not to say you can't
> namespace things in sysfs, you can, in the same way that you can get a
> round peg into a square hole if you bang hard enough.
>
> So perhaps we could get back to the original question of whether these
> quantities would ever be namespaced ... or, conversely, whether they
> would never need namespacing.

To clarify, I brought up in the discussion about namespacing 
considerations because I was asked about them. However, I determined 
there were none because firmware object interactions are invariant 
across namespaces.  I don't see this changing in the future given that 
the firmware objects have no notion of namespacing.

Thanks & Regards,

     - Nayna

