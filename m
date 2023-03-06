Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9CE6ACBE2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 19:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjCFSG2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 13:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjCFSG0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:06:26 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02146E6BC;
        Mon,  6 Mar 2023 10:06:03 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326GroIH030264;
        Mon, 6 Mar 2023 16:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7111ExDqw3P//EMbR4+2vARpnzHDbCGEjmz+aQfoJbQ=;
 b=M/8OE0EL2VXIzQLGAwSDJGwxBhS+TXGW56e4fx41AFb++bgFfQKnpIZNXEj+++obMaPp
 MZq8hylyOaclj2YJ4ZeMoOFDIvyXxr1yQsn9xjj9TAWvgftvJ4ghG/XvIodyJsvgLhMl
 fNczaCh0y9xytTFNxro4Hr+qqiXoVMTKtu5Yr422WksUxVuUT+GxGoSt90iFfiVibhj7
 /42w0rqaPRrw7/EapYz3sxTlJ6UAYxfjxTVb3DlYARY/6drJpe/+WsIrWBWreLiCIVa8
 UssmS6J8QY0+yhooT5f58vLAT2dYiosvOFtDi7+7jTFfkI6oi67Oy99onQyqw0EjskzF yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p513ery5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 16:57:50 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 326GroTk030262;
        Mon, 6 Mar 2023 16:57:49 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p513ery59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 16:57:49 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 326G8WMV015335;
        Mon, 6 Mar 2023 16:57:48 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3p4199htbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 16:57:48 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326Gvkmm8782446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 16:57:46 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A79475805A;
        Mon,  6 Mar 2023 16:57:46 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBDAB5805C;
        Mon,  6 Mar 2023 16:57:44 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Mar 2023 16:57:44 +0000 (GMT)
Message-ID: <c85a9f16-ea8f-5cbe-a9d0-df9f30fe8a8f@linux.ibm.com>
Date:   Mon, 6 Mar 2023 11:57:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 05/28] ima: Align ima_inode_setxattr() definition with LSM
 infrastructure
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, chuck.lever@oracle.com,
        jlayton@kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
 <20230303181842.1087717-6-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230303181842.1087717-6-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cDErfaT3_jGCF3NShUajj7ziN33cPs6R
X-Proofpoint-GUID: kJvphBLBuSgdr4-2XOtckKaP0BfQVtmK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_09,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 mlxlogscore=944 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060142
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/3/23 13:18, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Change ima_inode_setxattr() definition, so that it can be registered as
> implementation of the inode_setxattr hook.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
