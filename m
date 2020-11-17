Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693C82B5AD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 09:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgKQIPn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 03:15:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10180 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726231AbgKQIPm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:15:42 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AH814dC114847;
        Tue, 17 Nov 2020 03:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=MgojLclnAYOswLAieBVjfNC24dXThJ4NVpQsLaiik5E=;
 b=TGntiDlqS5lLNk5h6JaZN5NtNqD0A8LpOmFHhCVhG38uFwhja5GddMUMiv7qGT9usE9W
 07e7ujB4TtqYLdFU84qQH65osmUcr+EbKNL+fglujKsIZmHHh/8KblhrK8MsG9kpFBDo
 oJ4qjWE2KkyO1iI7Ce+/M88paMXfe92YLAlnjfNaZhSYRIfa0pV3MBX//HAQfB7nTij8
 rEafhv65TCkPC9pAllxgYAFRNvsBEt8lq/LbWcpgSjlLi5svy48hmtv8wIojuKKR8TTu
 NHHldFeV4404DH4jbHYf9DM2Ph5nUFNE+ictyxBT0Yvavza3Pv9Y+GpU0siCR2/Ut4Qj uA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34v8t3ka3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 03:15:07 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AH83VgO126987;
        Tue, 17 Nov 2020 03:15:06 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34v8t3ka2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 03:15:06 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AH8Ckxo019666;
        Tue, 17 Nov 2020 08:15:04 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 34t6v8auuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 08:15:04 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AH8F2J7000742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 08:15:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 435C9A4054;
        Tue, 17 Nov 2020 08:15:02 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4CD2A405B;
        Tue, 17 Nov 2020 08:14:59 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.171.34.138])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 17 Nov 2020 08:14:59 +0000 (GMT)
Date:   Tue, 17 Nov 2020 10:14:57 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>, Meelis Roos <mroos@linux.ee>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH v2 00/13] arch, mm: deprecate DISCONTIGMEM
Message-ID: <20201117081457.GA370809@linux.ibm.com>
References: <20201101170454.9567-1-rppt@kernel.org>
 <43c53597-6267-bdc2-a975-0aab5daa0d37@physik.fu-berlin.de>
 <20201117062316.GB370813@kernel.org>
 <d34f431a-288d-82a9-2632-85e8e695df12@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d34f431a-288d-82a9-2632-85e8e695df12@physik.fu-berlin.de>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_02:2020-11-13,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=1 malwarescore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 mlxlogscore=997
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170054
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Adrian,

On Tue, Nov 17, 2020 at 09:07:25AM +0100, John Paul Adrian Glaubitz wrote:
> Hi Mike!
> 
> On 11/17/20 7:23 AM, Mike Rapoport wrote:
> > There were minor differences only for m68k between the versions. I've
> > verified them on ARAnyM but if you have a real machine a run there would
> > be nice.
> 
> I do have a real machine (Amiga 68060) but it's currently not set up (but it
> will be in the near future). So I'm not sure if I can test the change within
> a short time frame.
>
> I will certainly report back when I run into issues on real hardware.

I hope there won't be any :)

-- 
Sincerely yours,
Mike.
