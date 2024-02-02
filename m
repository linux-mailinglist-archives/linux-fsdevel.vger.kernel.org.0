Return-Path: <linux-fsdevel+bounces-10059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7367A847632
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 18:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981201C21D6F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 17:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF50C14AD00;
	Fri,  2 Feb 2024 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KGFFvCv8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E927171A5;
	Fri,  2 Feb 2024 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895264; cv=none; b=LW3zVeS6foCxDmQg1dlcMsYEUt44GdxtpRgvUdNZAR9/jU2UDfNET148ODp790pk/s52sIOa/7XPM1lIP3EiS2AyCJzxaMDfVB9MuyPhWJiCgO4mC0QHudmkjU/V0Mq7H7teUPn6Et4GfYp8oUCn+xisWCYJTqflogeaLmvkr+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895264; c=relaxed/simple;
	bh=mmCqcKOCbWJ4h+yUWXwuD5cmWRJj1dmw2SKtIEtVGtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLoHHMpy2M7+CiI0WKpFMrE5Bhkia7Btp6mCa29VhKUcqYZQDe5ZnmPb6clToTUyDbmff6AiewU8QbtDSaUbopUOarXPZFx6XuSvHDhIg3hy44QLcFv2K8mvnghv0rzD2mWNHaQWVvGcqCOeSPzsCvsM1WIDYjQBW2BXxvI+i4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KGFFvCv8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 412HNPbl001201;
	Fri, 2 Feb 2024 17:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=S2RHjfRY3vGG1Dg4oiNVOa89gb5fmXyKeMJtxwroD7Q=;
 b=KGFFvCv8ZdBnKREn3znfi7xiWDqOKru2JsJm+afgjIA/C/m69OHF4VxOd837oIDZRs13
 h0Jv3SgyiIHkgYocKoAL89jUo0A86e+NoYZesu5Wu0JUxVuXBHR9ms6j7i9XmP3hnzYj
 KnHTqZ7x9v3ykag8lzSo47ctaWGPIX2x9Mg+7YgKpKP5HglRuhCw9EY0+2SpX0x/T+Op
 2AmOiVfEvtRHSJpVvmy7bCOjxqru1miL01aDZvD3ibcMM9xU1WcSGCiy5Lr7UZ8dc/9V
 83B54FC+0moX272HuuaPURP5YgGTOybDPxDHN6rWkifncbUEYbuV58/fHh2KsRSGO2G/ sg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w119t63km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 17:34:19 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 412HNbuC002307;
	Fri, 2 Feb 2024 17:34:18 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w119t63ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 17:34:18 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 412Gqhkc010862;
	Fri, 2 Feb 2024 17:34:17 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwecm4ecx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 17:34:17 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 412HYGkU66716044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Feb 2024 17:34:16 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7987F5805E;
	Fri,  2 Feb 2024 17:34:16 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0B9458050;
	Fri,  2 Feb 2024 17:34:15 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Feb 2024 17:34:15 +0000 (GMT)
Message-ID: <063577b8-3d7f-4a7f-8ed7-332601c98122@linux.ibm.com>
Date: Fri, 2 Feb 2024 12:34:15 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fs: remove the inode argument to ->d_real() method
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>, Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner
 <brauner@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>, linux-unionfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20240202110132.1584111-1-amir73il@gmail.com>
 <20240202110132.1584111-3-amir73il@gmail.com>
 <20240202160509.GZ2087318@ZenIV> <20240202161601.GA976131@ZenIV>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240202161601.GA976131@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3OgVUjc4BWTHlSnBNd0jYiA3T2Q797EN
X-Proofpoint-GUID: Rs7Boa3vJrPq7t1RDcKj9QF3CE4YeUY_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_11,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=865 impostorscore=0 spamscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402020126



On 2/2/24 11:16, Al Viro wrote:
> On Fri, Feb 02, 2024 at 04:05:09PM +0000, Al Viro wrote:
> 
>> Use After Free.  Really.  And "untrusted" in the function name does not
>> refer to "it might be pointing to unmapped page" - it's just "don't
>> expect anything from the characters you might find there, including
>> the presence of NUL".
> 
> Argh...  s/including/beyond the/ - sorry.  Messed up rewriting the
> sentence.
> 
> "Untrusted" refers to the lack of whitespaces, control characters, '"',
> etc.  What audit_log_untrustedstring(ab, string) expects is
> 	* string pointing to readable memory object
> 	* the object remaining unchanged through the call
> 	* NUL existing somewhere in that object.
> 
> All of those assertions can be violated once the object string
> used to point to has been passed to kmem_cache_free().  Which is what
> can very well happen to filename pointer in this case.

I suppose this would provide a stable name?

diff --git a/security/integrity/ima/ima_api.c 
b/security/integrity/ima/ima_api.c
index 597ea0c4d72f..48ae6911139b 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -244,7 +244,6 @@ int ima_collect_measurement(struct 
integrity_iint_cache *iint,
         const char *audit_cause = "failed";
         struct inode *inode = file_inode(file);
         struct inode *real_inode = d_real_inode(file_dentry(file));
-       const char *filename = file->f_path.dentry->d_name.name;
         struct ima_max_digest_data hash;
         struct kstat stat;
         int result = 0;
@@ -313,11 +312,17 @@ int ima_collect_measurement(struct 
integrity_iint_cache *iint,
                 iint->flags |= IMA_COLLECTED;
  out:
         if (result) {
+               struct qstr *qstr = &file->f_path.dentry->d_name;
+               char buf[NAME_MAX + 1];
+
                 if (file->f_flags & O_DIRECT)
                         audit_cause = "failed(directio)";

+               memcpy(buf, qstr->name, qstr->len);
+               buf[qstr->len] = 0;
+
                 integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
-                                   filename, "collect_data", audit_cause,
+                                   buf, "collect_data", audit_cause,
                                     result, 0);
         }
         return result;


Regards,
    Stefan

