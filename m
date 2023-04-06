Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E1E6DA0BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 21:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240361AbjDFTLz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 15:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240333AbjDFTLx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:11:53 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1EF19A7;
        Thu,  6 Apr 2023 12:11:50 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336IEX78008004;
        Thu, 6 Apr 2023 19:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vEyf8uTlzLbG3M0No9G1X2vAXuVVv9aUH9evS/ZvWrw=;
 b=Bus4kqwU1kIJvgwfc/0PKLY14Lwm0HepZ0w5osSN8nVhusp05sTthV32hS1yyQ1v1RHc
 LmiFY5kGNNXSa/iaU6DzwZHAhkuCdc2gmMTd49TXprKMEbijLcAxrjuYPwNJeXf4jvI4
 zNf2FanvjhgvYU5FtzKmnL2nJSh1YgpCroUxie2ZkuidsqkVUz+4IzDdcFy60ZezHiz1
 /j0grENrEhFmpITgyDLc5Q3shDyFzLyh8FuWgnwE0gXzi9dApPj07D1dJBIBjDeyjzC2
 lnLHtlV7Z/yEuh+VIFqW7QJPpoWqC6Cw12Tq8Wg+uzMW94ysNPSIxF7WaWkJm/7BPQya Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pt367h7gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 19:11:41 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 336IuqiI023672;
        Thu, 6 Apr 2023 19:11:40 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pt367h7gc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 19:11:40 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 336GPipc021879;
        Thu, 6 Apr 2023 19:11:40 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3ppc88u7kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 19:11:39 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 336JBc4j35586432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Apr 2023 19:11:39 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3D2858052;
        Thu,  6 Apr 2023 19:11:38 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C63C5805D;
        Thu,  6 Apr 2023 19:11:38 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  6 Apr 2023 19:11:37 +0000 (GMT)
Message-ID: <45a9c575-0b7e-f66a-4765-884865d14b72@linux.ibm.com>
Date:   Thu, 6 Apr 2023 15:11:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM after
 writes
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Paul Moore <paul@paul-moore.com>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        miklos@szeredi.hu, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        amir73il@gmail.com
References: <20230405171449.4064321-1-stefanb@linux.ibm.com>
 <20230406-diffamieren-langhaarig-87511897e77d@brauner>
 <CAHC9VhQsnkLzT7eTwVr-3SvUs+mcEircwztfaRtA+4ZaAh+zow@mail.gmail.com>
 <a6c6e0e4-047f-444b-3343-28b71ddae7ae@linux.ibm.com>
 <CAHC9VhQyWa1OnsOvoOzD37EmDnESfo4Rxt2eCSUgu+9U8po-CA@mail.gmail.com>
 <20230406-wasser-zwanzig-791bc0bf416c@brauner>
 <546145ecbf514c4c1a997abade5f74e65e5b1726.camel@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <546145ecbf514c4c1a997abade5f74e65e5b1726.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kk9FwcInVVDCzh3BSXFkt9Oqr4VaFYXM
X-Proofpoint-ORIG-GUID: 5J1N3rlDHm0hfPcn-Ft1YHUFAQGLyVQS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_10,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxlogscore=814 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304060163
X-Spam-Status: No, score=-2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/6/23 14:46, Jeff Layton wrote:
> On Thu, 2023-04-06 at 17:01 +0200, Christian Brauner wrote:
>> On Thu, Apr 06, 2023 at 10:36:41AM -0400, Paul Moore wrote:

> 
> Correct. As long as IMA is also measuring the upper inode then it seems
> like you shouldn't need to do anything special here.

Unfortunately IMA does not notice the changes. With the patch provided in the other email IMA works as expected.

>
> What sort of fs are you using for the upper layer?

jffs2:

/dev/mtdblock4 on /run/initramfs/ro type squashfs (ro,relatime,errors=continue)
/dev/mtdblock5 on /run/initramfs/rw type jffs2 (rw,relatime)
cow on / type overlay (rw,relatime,lowerdir=run/initramfs/ro,upperdir=run/initramfs/rw/cow,workdir=run/initramfs/rw/work)

Regards,
    Stefan





