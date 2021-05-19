Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F23388476
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 03:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhESBf3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 21:35:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231689AbhESBf2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 21:35:28 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14J14LBp095740;
        Tue, 18 May 2021 21:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=TSIcUKlJKuIIr978ibfL+W5lJZ618kXPKibv8DMD+8w=;
 b=C5kj5m8CJg96NebcO1bm9othMtFMyAinaRQ504k8x6EXkUmEb9ZuvrPGOZqTQNQ0g0Xv
 Mwn2vhUdbL+JkHCIikF/YPjf1uZT134MQZakQfw76N/Z0HZ6QpRptSxKwdG86sVWFTw/
 3RDtLRiN5QDTGArFs0km0FVBKuxuVztvCuLdDVpEicvxcjGJyXAvTVyUMWP8r87Vq6G7
 EyP+NjO2d3VB3bKNejrXwFxI/D1BQIpE0p3WDQ8roRlLOjydlA13sRNVW+eYVbv2FYGj
 hIsjYjGbtCiZgQ8tJt139+MQ42d5SDmhyG7xo0cGdRGo+gzO2f6qTHbo5VMFSnuzR14M Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38mqycs8de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 May 2021 21:32:43 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14J14MOc095896;
        Tue, 18 May 2021 21:32:42 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38mqycs8d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 May 2021 21:32:42 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14J1QwAw010620;
        Wed, 19 May 2021 01:32:41 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02dal.us.ibm.com with ESMTP id 38j5x9j6ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 01:32:41 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14J1Weni11076004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 01:32:40 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66A827805E;
        Wed, 19 May 2021 01:32:40 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BA5378066;
        Wed, 19 May 2021 01:32:30 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.80.208.94])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 19 May 2021 01:32:30 +0000 (GMT)
Message-ID: <d99864e677cec4ed83e52c4417c58bbe5fd728b1.camel@linux.ibm.com>
Subject: Re: [PATCH v19 6/8] PM: hibernate: disable when there are active
 secretmem users
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Date:   Tue, 18 May 2021 18:32:29 -0700
In-Reply-To: <20210518102424.GD82842@C02TD0UTHF1T.local>
References: <20210513184734.29317-1-rppt@kernel.org>
         <20210513184734.29317-7-rppt@kernel.org>
         <20210518102424.GD82842@C02TD0UTHF1T.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LznGIJm2lBQ6APrvvyeFq2Y4fBjyOunI
X-Proofpoint-ORIG-GUID: 7e9L0ZhoY0K9faClVgEt7JR6P8qAFxb2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-18_11:2021-05-18,2021-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 mlxlogscore=792 adultscore=0 phishscore=0 spamscore=0
 mlxscore=0 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105190004
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-05-18 at 11:24 +0100, Mark Rutland wrote:
> On Thu, May 13, 2021 at 09:47:32PM +0300, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > It is unsafe to allow saving of secretmem areas to the hibernation
> > snapshot as they would be visible after the resume and this
> > essentially will defeat the purpose of secret memory mappings.
> > 
> > Prevent hibernation whenever there are active secret memory users.
> 
> Have we thought about how this is going to work in practice, e.g. on
> mobile systems? It seems to me that there are a variety of common
> applications which might want to use this which people don't expect
> to inhibit hibernate (e.g. authentication agents, web browsers).

If mobile systems require hibernate, then the choice is to disable this
functionality or implement a secure hibernation store.   I also thought
most mobile hibernation was basically equivalent to S3, in which case
there's no actual writing of ram into storage, in which case there's no
security barrier and likely the inhibition needs to be made a bit more
specific to the suspend to disk case?

> Are we happy to say that any userspace application can incidentally
> inhibit hibernate?

Well, yes, for the laptop use case because we don't want suspend to
disk to be able to compromise the secret area.  You can disable this
for mobile if you like, or work out how to implement hibernate securely
if you're really suspending to disk.

James


