Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB69536C9BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 18:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238777AbhD0Qta (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 12:49:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47454 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237539AbhD0QtF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:49:05 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13RGXXVQ072052;
        Tue, 27 Apr 2021 12:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=sK/kfEPDNAy/W73TYtW08cQTH0f6vXPcMHahw7XFPGQ=;
 b=q9hf4jtJPWAD4PwYjyX+inldY407WIvN5ME0pnurEhWmSwcj+ytMEF7yXyBr2w6lvSOt
 ep+Owe6YYqXXYOeNbYQ+c/Hb+RLWFUi41JcvEivBwAwHM4JyD+6FBikcIFQBqaZfFCDJ
 TgSmF+zEejm8QRTTs1cekLzdxo1Bj1ZH9H5jSvXlwgtcPMHq7bldgmt0vMVAnzz1/Sjx
 NL6syw7nG4p7SFrZyOtBr9SIm1nENh40sGwGS259Xi2vCMaH4qDpO3wjQbLfoh2z6V7b
 /tBYLIGUK5aOn3Sjfh5AsJZiDzDz3U4LMd/v67E67gFTLzl/e9KORD6IhQtiLTsQp5b9 NA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 386muqubkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 12:48:09 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13RGXe8k072967;
        Tue, 27 Apr 2021 12:48:09 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 386muqubk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 12:48:08 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13RGidOK023537;
        Tue, 27 Apr 2021 16:48:07 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 384ay8rtjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 16:48:06 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13RGm3Ec30933496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Apr 2021 16:48:03 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C29EC42045;
        Tue, 27 Apr 2021 16:48:03 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E86414203F;
        Tue, 27 Apr 2021 16:48:01 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.36.231])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Apr 2021 16:48:01 +0000 (GMT)
Message-ID: <2c4baf092a11eadfc589ca2a314bcbf689284b0a.camel@linux.ibm.com>
Subject: Re: [PATCH v4 04/11] ima: Move ima_reset_appraise_flags() call to
 post hooks
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "mjg59@google.com" <mjg59@google.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 27 Apr 2021 12:48:00 -0400
In-Reply-To: <3354e1a0-bca2-2cb9-6e82-7209b9106008@schaufler-ca.com>
References: <20210305151923.29039-1-roberto.sassu@huawei.com>
         <20210305151923.29039-5-roberto.sassu@huawei.com>
         <c3bb1069-c732-d3cf-0dde-7a83b3f31871@schaufler-ca.com>
         <93858a47a29831ca782c8388faaa43c8ffc3f5cd.camel@linux.ibm.com>
         <7a39600c24a740838dca24c20af92c1a@huawei.com>
         <d047d1347e7104162e0e36eb57ade6bba914ea2d.camel@linux.ibm.com>
         <d783e2703248463f9af68e155ee65c38@huawei.com>
         <3354e1a0-bca2-2cb9-6e82-7209b9106008@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UQxgqS5tfaz7u6xEhw6-mov5dXxGuI3Q
X-Proofpoint-ORIG-GUID: BhALz2mzO1A0UFYjsNFOhf10bxTXbPKE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-27_10:2021-04-27,2021-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104270112
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Casey,

On Tue, 2021-04-27 at 09:39 -0700, Casey Schaufler wrote:
> >> That ship sailed when "security=" was deprecated in favor of "lsm="
> >> support, which dynamically enables/disables LSMs at runtime.
> 
> security= is still supported and works the same as ever. lsm= is
> more powerful than security= but also harder to use.

I understand that it still exists, but the documentation says it's been
deprecated.
From Documentation/admin-guide/kernel-parameters.txt:

        security=  [SECURITY] Choose a legacy "major" security module to
                        enable at boot. This has been deprecated by the
                        "lsm=" parameter.

Mimi

