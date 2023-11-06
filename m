Return-Path: <linux-fsdevel+bounces-2161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BA77E2D22
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 20:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1B1280A0D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 19:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77F22D05E;
	Mon,  6 Nov 2023 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QXZgfynS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6261828DCF
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 19:44:24 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACC6125;
	Mon,  6 Nov 2023 11:44:21 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6JeLZJ023059;
	Mon, 6 Nov 2023 19:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=6lQnPtAuDs1yRDYUZNA0X4oNLITc1jI3WcvtpB0zAlw=;
 b=QXZgfynS6iAtYhsOyd7HmwwL/ddVN705GW9VN8pEFsZLU3jV4Uzslx7Cb3oCvSSvZyH5
 cQrsDuh0dotyKURYNbxGre3Zri4Ez1mzG6Wt5i0paCLjw73g8tqhrj2xxA6KDLqdDjDd
 Qs9Q2lxax5KtmL0gVuA/1nsIyHAZ+WYwyFLrmaV5yXBqVUW/1WpsDNT8CmuKLqydWT79
 Y1GmsEzfBuQaVGO+JVIfHpgLTOQYGa/7bQmyagmJf62mTxhIyl5yEsEgfdh3GtQyOVPs
 Vi3OoLFY8fdfQqI4e49flyGn0rJeINgkGU6M1/B8ZSkbgslnDqDXoOD9Fc4CvfSjBLXf 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u76gkg3ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Nov 2023 19:44:15 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A6JeX4K023381;
	Mon, 6 Nov 2023 19:44:15 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u76gkg3dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Nov 2023 19:44:14 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6HPkZT028230;
	Mon, 6 Nov 2023 19:44:14 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u62gjuaqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Nov 2023 19:44:14 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A6JiDQE20644526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Nov 2023 19:44:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D26358067;
	Mon,  6 Nov 2023 19:44:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9A6D58056;
	Mon,  6 Nov 2023 19:44:12 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  6 Nov 2023 19:44:12 +0000 (GMT)
Message-ID: <e6b66098-77d6-46e9-b013-986ad86ba26b@linux.ibm.com>
Date: Mon, 6 Nov 2023 14:44:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: Pass AT_GETATTR_NOSEC flag to getattr interface
 function
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, amir73il@gmail.com,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
        Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231002125733.1251467-1-stefanb@linux.vnet.ibm.com>
 <20231010-erhaben-kurznachrichten-d91432c937ee@brauner>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231010-erhaben-kurznachrichten-d91432c937ee@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gSqzhJehY9bxuE4KRXjUZVNnUI4SZ_11
X-Proofpoint-GUID: fPkaI9lKmqP-HtzBlQ-ahemvBEgOQOBg
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 clxscore=1011 spamscore=0 malwarescore=0 mlxlogscore=836 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060162



On 10/10/23 04:35, Christian Brauner wrote:
> On Mon, 02 Oct 2023 08:57:33 -0400, Stefan Berger wrote:
>> When vfs_getattr_nosec() calls a filesystem's getattr interface function
>> then the 'nosec' should propagate into this function so that
>> vfs_getattr_nosec() can again be called from the filesystem's gettattr
>> rather than vfs_getattr(). The latter would add unnecessary security
>> checks that the initial vfs_getattr_nosec() call wanted to avoid.
>> Therefore, introduce the getattr flag GETATTR_NOSEC and allow to pass
>> with the new getattr_flags parameter to the getattr interface function.
>> In overlayfs and ecryptfs use this flag to determine which one of the
>> two functions to call.
>>
>> [...]
> 
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.

Did something happen to this patch? I do not see it in your branch nor 
the linux-next one nor Linus's tree.



> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.fixes
> 
> [1/1] fs: Pass AT_GETATTR_NOSEC flag to getattr interface function
>        https://git.kernel.org/vfs/vfs/c/6ea042691c74

