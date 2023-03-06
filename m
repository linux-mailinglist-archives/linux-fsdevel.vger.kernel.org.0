Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1596AC8A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 17:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjCFQs1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 11:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjCFQsM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:48:12 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B244C6E2;
        Mon,  6 Mar 2023 08:47:43 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326FGtLP007103;
        Mon, 6 Mar 2023 16:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Prg32a8lypSzsuzKaLaRGI/598mjJ01sZ+3Tf2eA04o=;
 b=WPr+37PUtw4EvxFS7nTnqlOPXddkNrZMARg2cCBjv+yiMR2WfOss6zzbv1bYsJnVCenW
 BU4sx6jUyt3DXUD8jkpJuWbVVt7g5QNSBSC9IOZ1VMt8H8vD5ldvSkYDy2G0fg0STPv9
 xW3RtaCVeTv4aHOFHk+jETz1WHqTtS5RQorDmzejdEiLaMGKf1EjdO3QmMLF1lxuOLWh
 AW4/Zyeq8pXVWsTzjokRodmszy6ZXGXY766K0qWUHyO0HqZxHS7Balh/w9LAKnNtDAhb
 kZcU9KoxOM0VOQfaqIJ07lrYkBAWcub0yD6ldShft3RctU3l4oO3Rb+Z0PHRuix23DDN wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4ysdt79x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 16:46:05 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 326Eb8kJ004998;
        Mon, 6 Mar 2023 16:46:05 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4ysdt79d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 16:46:05 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 326GNp3Z010183;
        Mon, 6 Mar 2023 16:46:03 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3p419e67k6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 16:46:03 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326Gk2dm46465464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 16:46:02 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B814F5805E;
        Mon,  6 Mar 2023 16:46:02 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E82A5805A;
        Mon,  6 Mar 2023 16:46:01 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Mar 2023 16:46:01 +0000 (GMT)
Message-ID: <c3360cee-b6c8-2ea3-a9e3-e6fbba198b57@linux.ibm.com>
Date:   Mon, 6 Mar 2023 11:46:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 01/28] ima: Align ima_inode_post_setattr() definition with
 LSM infrastructure
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
 <20230303181842.1087717-2-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230303181842.1087717-2-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Hjw8-b5VOVH_KkdYeH9FjpUbzxLar_WK
X-Proofpoint-GUID: dPhapGl98lRGn8zDeRdkzVYryXO4oXcc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_10,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=956 suspectscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303060142
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/3/23 13:18, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Change ima_inode_post_setattr() definition, so that it can be registered as
> implementation of the inode_post_setattr hook.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
