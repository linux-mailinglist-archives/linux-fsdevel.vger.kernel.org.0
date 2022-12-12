Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A0F64978F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 02:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiLLBAZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 20:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLLBAY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 20:00:24 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E67BC33;
        Sun, 11 Dec 2022 17:00:23 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BBK2Bh3006548;
        Mon, 12 Dec 2022 00:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=xJR2nbIWi2OvOl6AvyZ2UM0XQ9Daq6jNfoBWR6S6JaQ=;
 b=ErzKdh9KAZwx7wejt8gD2q0Ma4S2ZRoQBmgb26KOhVqpRSuONMhzKAkAFCCLRdogV40w
 oXLnXX8kHz3hFgSCN7QYsW3qLKAIGwwOF/XfiiqEslESABxusAmKxJ2LwBvJ0iP+K/9+
 iI2ZEsQA01kNATXx7TEY6wcpHl3FpAaO51hboAyJLKpXtxfAYygmBS7UOXy23TVkl/eH
 Nvsa/TESnyY0ldHZVDM9ohuf1CsEAjo+RcrTXPGmkooO6GTHJVC9T5+S1EWMwiEkuqaT
 GKoY/bw8HnGh4/CWTphtRt1SYd75Gb9x2A6HrWmX+nt7MocYmId7iQ2YmECszPpkNJVh iA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3md421301h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 00:59:05 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BC0wW3u002588;
        Mon, 12 Dec 2022 00:59:04 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3md4213015-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 00:59:04 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BBNDcFA028390;
        Mon, 12 Dec 2022 00:59:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3mchr61w7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 00:59:02 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BC0x0ZH41026032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 00:59:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7879C20043;
        Mon, 12 Dec 2022 00:59:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE30C20040;
        Mon, 12 Dec 2022 00:58:59 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 12 Dec 2022 00:58:59 +0000 (GMT)
Received: from [9.192.255.228] (unknown [9.192.255.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id E900B602EF;
        Mon, 12 Dec 2022 11:58:56 +1100 (AEDT)
Message-ID: <deda857ccc949f920ae3b7eca753d41b76acceda.camel@linux.ibm.com>
Subject: Re: [PATCH 2/4] fs: define a firmware security filesystem named
 fwsecurityfs
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Nayna <nayna@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org,
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
        Stefan Berger <stefanb@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Date:   Mon, 12 Dec 2022 11:58:56 +1100
In-Reply-To: <6f2a4a5f-ab5b-8c1b-47d5-d4e6dca5fc3a@linux.vnet.ibm.com>
References: <20221106210744.603240-1-nayna@linux.ibm.com>
         <20221106210744.603240-3-nayna@linux.ibm.com> <Y2uvUFQ9S2oaefSY@kroah.com>
         <8447a726-c45d-8ebb-2a74-a4d759631e64@linux.vnet.ibm.com>
         <20221119114234.nnfxsqx4zxiku2h6@riteshh-domain>
         <d3e8df29-d9b0-5e8e-4a53-d191762fe7f2@linux.vnet.ibm.com>
         <a2752fdf-c89f-6f57-956e-ad035d32aec6@linux.vnet.ibm.com>
         <Y35C9O27J29bUDjA@kroah.com>
         <6f2a4a5f-ab5b-8c1b-47d5-d4e6dca5fc3a@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 (3.46.1-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HNXLB6tPj93LDuXtj2ObhDK_-4Cie0yq
X-Proofpoint-GUID: Fp2TTvT7JoTQaaqS3UEUpIvBegOspgGa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-10_10,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1011 bulkscore=0 mlxlogscore=732 impostorscore=0
 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212120003
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-11-23 at 13:57 -0500, Nayna wrote:
>=20
> Given there are no other exploiters for fwsecurityfs and there should
> be=20
> no platform-specific fs, would modifying sysfs now to let userspace=20
> create files cleanly be the way forward? Or, if we should strongly=20
> consider securityfs, which would result in updating securityfs to
> allow=20
> userspace creation of files and then expose variables via a more=20
> platform-specific directory /sys/kernel/security/pks? We want to pick
> the best available option and would find some hints on direction
> helpful=20
> before we develop the next patch.

Ping - it would be helpful for us to know your thoughts on this.


Andrew

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
