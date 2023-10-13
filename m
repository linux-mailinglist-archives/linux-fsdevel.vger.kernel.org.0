Return-Path: <linux-fsdevel+bounces-259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5A77C86FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 15:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 765CEB20976
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 13:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AE315EA9;
	Fri, 13 Oct 2023 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OxANyJk+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E357C14ABD
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 13:38:04 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1003BE;
	Fri, 13 Oct 2023 06:38:00 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DDbN5L018833;
	Fri, 13 Oct 2023 13:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=rzqqzFfrVVc/iGXmW0POZziVWECxUs/ziKW6j8GDCk0=;
 b=OxANyJk+PCGIbw2DLYRO+HNlTvPgxm80YEXWTNcki0ZdW2TgSTo2LpLDFuEGqYAr+xli
 yF0cX4gneTpU6psBcKnzUphm/mi91MekfAwDw2VSTPZ0kTH2CQlGzCH4FPdtAhcG1hOq
 jZs9FFaG09bw4wGR9sWJ+48PrLrgI/7/CeJx7n7ssj+FCeJF9zvnJA488QWxZCNB4Tpt
 s3CvOlXhiJohJ9CCs8hFk4RCgmZn+sv4bNPz7iWaxiZTfg/R0ncFMIUMB+iH1KgU7C2i
 IHLq9Z0LXIqSy9UF/QkYioLLZrCwlWPREgCMMyaSY842qpGp6oKf/W1uFHGZoebrdZ4X QA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tq6xfr052-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Oct 2023 13:37:26 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39DDbPOW018973;
	Fri, 13 Oct 2023 13:37:26 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tq6xfr04g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Oct 2023 13:37:25 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39DBGHJj026147;
	Fri, 13 Oct 2023 13:37:24 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tpt54v6e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Oct 2023 13:37:24 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39DDbNDs24969896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Oct 2023 13:37:24 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0AD45805D;
	Fri, 13 Oct 2023 13:37:23 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D20458043;
	Fri, 13 Oct 2023 13:37:22 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.129.99])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Oct 2023 13:37:22 +0000 (GMT)
Message-ID: <ed79187830c7e83b4f8b34c21cedf8faf7091e2a.camel@linux.ibm.com>
Subject: Re: [PATCH v3 20/25] security: Introduce key_post_create_or_update
 hook
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Fri, 13 Oct 2023 09:37:21 -0400
In-Reply-To: <20230904134049.1802006-1-roberto.sassu@huaweicloud.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
	 <20230904134049.1802006-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BVyYqrm1v8QhLufB4QUhCUGKTn4yctly
X-Proofpoint-ORIG-GUID: SYAVxHrUWAjK37ZZbcdVXadJltIrcA2Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_04,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 mlxlogscore=882 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-09-04 at 15:40 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>


> LSMs can benefit from this hook to make their decision on the new or
> successfully updated key content.

Without a good example, writing examples is hard.  As this is a void
function, what decision?  Please try and rephrase appropriately.

-- 
thanks,

Mimi



