Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1436AC8E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 18:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjCFRAi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 12:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCFRAg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:00:36 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31E329E19;
        Mon,  6 Mar 2023 09:00:14 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326Grm70031139;
        Mon, 6 Mar 2023 16:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=1WlxBw4xTvuZLMmzSdTNLosvZcE6Ev/bFvq4Znx6N/A=;
 b=Ci9LecJ+CncafqY1cSuWFIWcg3eBpkaeALnQEtCUaLsqz9DY7jneoGf3wITrg3tao9go
 cXb+uE+Zfjfb38TqCLAl6/kIpc2xJNj0bV9STmYgAFFDcTSjOj4Jp5hz9ZuLfmFv9j1O
 h+k4kPG/ly46evvxa/iC7hxZFK2PGrwPjBMIsRnjj3ZfxB9XjIEOljtDunuvDbcaAVIg
 ixgxQXAKJ0Up+Ui9Zgd/b7lpDzSuCuB53Z9Ypv6cbKhNoXV/8sV5A/JTh2KTq6GBahbF
 VcGP0ErhBNbe/pmXpqUKD0fK3rfx7J9tBh5UuiSemziKFr/Bgd4WhApLrZAHPO2/KUBb gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4yhr2fqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 16:58:31 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 326Groog031328;
        Mon, 6 Mar 2023 16:58:30 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4yhr2fq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 16:58:30 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 326FwjwX017270;
        Mon, 6 Mar 2023 16:58:30 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3p41ak9t00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 16:58:29 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326GwSs67340588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 16:58:28 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8331F5805C;
        Mon,  6 Mar 2023 16:58:28 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AF8D5805A;
        Mon,  6 Mar 2023 16:58:26 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Mar 2023 16:58:26 +0000 (GMT)
Message-ID: <fa9dd649-f05c-28e0-319c-4f39d133ce99@linux.ibm.com>
Date:   Mon, 6 Mar 2023 11:58:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 06/28] ima: Align ima_inode_removexattr() definition with
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
 <20230303181842.1087717-7-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230303181842.1087717-7-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Uk2RN-YvQchHdbgogWV3Dtv5yWwucACu
X-Proofpoint-ORIG-GUID: T6ZUq5OEUIdD21z9_M2lOdRjOYV-WsIf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_10,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 mlxlogscore=944 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060146
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
> Change ima_inode_removexattr() definition, so that it can be registered as
> implementation of the inode_removexattr hook.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
