Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C48F6E794E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 14:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjDSMGX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 08:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjDSMGW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:06:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583F21991;
        Wed, 19 Apr 2023 05:06:21 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33JBmiVs034942;
        Wed, 19 Apr 2023 12:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XxQyWGNU20y3Wnv7oBYdxQVoyeJRqhv7cvwcPncLqqk=;
 b=MaUkKBXx8iVhZnQfi2RDt8faEETMnMKAbEzNZO+lpYZA4Qzm/42cfcABcujSIwghRV0X
 3PeqNDRd4IaTppWUkLe9WhVR7DHaK67napzSWb0/fyAY5su8TJWCvhMrkWNBKYnZzWpL
 nrZow2Y7r/vmn90Ku0+11UMeCHt4krQqymOUrwysBfKhQ3gB8XVNTfmR2AisCvruWOoC
 HGrgnECisFQCMRlF+rKjlvt0AJiiXkbKhxoPOW9SAl/j9H94nYFHqgnk9sLjyUqIjTb9
 M4kh5I4Iraa1TWc6fPCqKtgixwG8fAM688OISqzSFuM22pbbenILF8ksGHq+DRGoNVxP lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q2apmt6hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 12:05:38 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33JBoDWh003607;
        Wed, 19 Apr 2023 12:05:37 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q2apmt6g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 12:05:37 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33J0WAFx000870;
        Wed, 19 Apr 2023 12:05:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3pykj6jqcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 12:05:34 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33JC5V2D45941078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 12:05:31 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4647620040;
        Wed, 19 Apr 2023 12:05:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91F6F20043;
        Wed, 19 Apr 2023 12:05:27 +0000 (GMT)
Received: from [9.171.27.132] (unknown [9.171.27.132])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 19 Apr 2023 12:05:27 +0000 (GMT)
Message-ID: <ab586b59-7d62-2ea1-a617-ffbcf91f4037@linux.ibm.com>
Date:   Wed, 19 Apr 2023 14:05:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 3/6] mm/gup: remove vmas parameter from
 get_user_pages_remote()
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1681831798.git.lstoakes@gmail.com>
 <7c6f1ae88320bf11d2f583178a3d9e653e06ac63.1681831798.git.lstoakes@gmail.com>
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <7c6f1ae88320bf11d2f583178a3d9e653e06ac63.1681831798.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YoUBdd5kWLHDb-6WjYvIk2NpjLH1WX8c
X-Proofpoint-GUID: aezbm9zbIzDKmcuHzP9oULlrIcksYyaJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_06,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=566 adultscore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304190108
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/18/23 17:49, Lorenzo Stoakes wrote:
> The only instances of get_user_pages_remote() invocations which used the
> vmas parameter were for a single page which can instead simply look up the
> VMA directly. In particular:-
> 
> - __update_ref_ctr() looked up the VMA but did nothing with it so we simply
>    remove it.
> 
> - __access_remote_vm() was already using vma_lookup() when the original
>    lookup failed so by doing the lookup directly this also de-duplicates the
>    code.
> 
> We are able to perform these VMA operations as we already hold the
> mmap_lock in order to be able to call get_user_pages_remote().
> 
> As part of this work we add get_user_page_vma_remote() which abstracts the
> VMA lookup, error handling and decrementing the page reference count should
> the VMA lookup fail.
> 
> This forms part of a broader set of patches intended to eliminate the vmas
> parameter altogether.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com> (for arm64)
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---

For the s390 part:
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

