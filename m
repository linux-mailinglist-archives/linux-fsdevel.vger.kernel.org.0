Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C069F30AD3D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 17:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhBAQ6K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 11:58:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8474 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231751AbhBAQ6C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:58:02 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 111GglEJ113096;
        Mon, 1 Feb 2021 11:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=wT7a/liLBSfcD7N/UPbkV3RD/KslWeh4NLQG5EPJ7nQ=;
 b=kXkBzChwTSaNHsMVY+LTYccolmWv+mZ3ZGn7eEUUvVLxfBBPI8zUta1XvW7g70uLasS9
 d0kJKgQu1dnLNQXDFjIopZmB9sTHhJDP3oPSyrFyYZArItFkrYbc0fnPmsfx4LaO19/B
 gS3Uixq/pAGwHT/prSDU8KzbQN5/ynJ+Ukn891aJzwdQslDSjiXbXsHV4bYfJjVJ8WEF
 At5mCisx5yq+hfISjZTWjkCnERXf9VUD7yAJaJeyECDFSM3fRjdUzxLOBdyJJ3y9Vl6d
 Qu5S+5LmA7rR1AuPmGiirOyAgBqXBXMd37MobQIK9K4Qmw9U2wP/9xPBaN10moKzV8Pu Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36en3vs16b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 11:56:31 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 111GgxhQ114162;
        Mon, 1 Feb 2021 11:56:30 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36en3vs155-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 11:56:30 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 111GfuSI009246;
        Mon, 1 Feb 2021 16:56:28 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03dal.us.ibm.com with ESMTP id 36eheka7ga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 16:56:28 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 111GuRjN23003516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Feb 2021 16:56:27 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 692A278063;
        Mon,  1 Feb 2021 16:56:27 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CD187806B;
        Mon,  1 Feb 2021 16:56:20 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.85.153.205])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  1 Feb 2021 16:56:20 +0000 (GMT)
Message-ID: <6de6b9f9c2d28eecc494e7db6ffbedc262317e11.camel@linux.ibm.com>
Subject: Re: [PATCH v16 07/11] secretmem: use PMD-size pages to amortize
 direct map fragmentation
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Date:   Mon, 01 Feb 2021 08:56:19 -0800
In-Reply-To: <YBPF8ETGBHUzxaZR@dhcp22.suse.cz>
References: <20210121122723.3446-1-rppt@kernel.org>
         <20210121122723.3446-8-rppt@kernel.org>
         <20210126114657.GL827@dhcp22.suse.cz>
         <303f348d-e494-e386-d1f5-14505b5da254@redhat.com>
         <20210126120823.GM827@dhcp22.suse.cz> <20210128092259.GB242749@kernel.org>
         <YBK1kqL7JA7NePBQ@dhcp22.suse.cz>
         <73738cda43236b5ac2714e228af362b67a712f5d.camel@linux.ibm.com>
         <YBPF8ETGBHUzxaZR@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_06:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxlogscore=818 impostorscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010084
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-01-29 at 09:23 +0100, Michal Hocko wrote:
> On Thu 28-01-21 13:05:02, James Bottomley wrote:
> > Obviously the API choice could be revisited
> > but do you have anything to add over the previous discussion, or is
> > this just to get your access control?
> 
> Well, access control is certainly one thing which I still believe is
> missing. But if there is a general agreement that the direct map
> manipulation is not that critical then this will become much less of
> a problem of course.

The secret memory is a scarce resource but it's not a facility that
should only be available to some users.

> It all boils down whether secret memory is a scarce resource. With
> the existing implementation it really is. It is effectivelly
> repeating same design errors as hugetlb did. And look now, we have a
> subtle and convoluted reservation code to track mmap requests and we
> have a cgroup controller to, guess what, have at least some control
> over distribution if the preallocated pool. See where am I coming
> from?

I'm fairly sure rlimit is the correct way to control this.  The
subtlety in both rlimit and memcg tracking comes from deciding to
account under an existing category rather than having our own new one. 
People don't like new stuff in accounting because it requires
modifications to everything in userspace.  Accounting under and
existing limit keeps userspace the same but leads to endless arguments
about which limit it should be under.  It took us several patch set
iterations to get to a fragile consensus on this which you're now
disrupting for reasons you're not making clear.

> If the secret memory is more in line with mlock without any imposed
> limit (other than available memory) in the end then, sure, using the
> same access control as mlock sounds reasonable. Btw. if this is
> really just a more restrictive mlock then is there any reason to not
> hook this into the existing mlock infrastructure (e.g.
> MCL_EXCLUSIVE)? Implications would be that direct map would be
> handled on instantiation/tear down paths, migration would deal with
> the same (if possible). Other than that it would be mlock like.

In the very first patch set we proposed a mmap flag to do this.  Under
detailed probing it emerged that this suffers from several design
problems: the KVM people want VMM to be able to remove the secret
memory range from the process; there may be situations where sharing is
useful and some people want to be able to seal the operations.  All of
this ended up convincing everyone that a file descriptor based approach
was better than a mmap one.

James


