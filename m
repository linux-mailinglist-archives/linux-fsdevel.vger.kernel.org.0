Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34AD3885BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 05:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353166AbhESDxf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 23:53:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33438 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238952AbhESDxd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 23:53:33 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14J3nalJ109545;
        Tue, 18 May 2021 23:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=RlHfyF6dV/ifSJEeZYS/RGJAYSImyxyDQ/6v4PYpUoQ=;
 b=RolvZNraQHV2P0qsntUMNydBlx0dyrhruAkYByqI3crIFJt30it3eMD9y1NI97YJlLBF
 lH6DuJL3/LDNdT9+XfECdNwXjT3ppXYd4fzdkztzifbZoyO1eST/M0EN/sWWCnsKPUuA
 H6yUOj/umX7XGfYGvS5ibBulsfPSz6SKd8vVmhFI43jBnRDxp7LT4KPHLt7J2Q5Dau17
 Cj6dF9IeuEdgqvHSFSWg1ukib6+/mHvqyFOXu1iQeX1CR2TyC88aG4iZ1bHXIXD9lr5e
 CzzvuZ7mMm9lvzxy43rUPcYtNcdwRbty82Q4G5bZScNpaeZL0p5CKCQtoBAQKkQrMsFM OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38mu4300f1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 May 2021 23:51:02 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14J3p11q115720;
        Tue, 18 May 2021 23:51:01 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38mu4300et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 May 2021 23:51:01 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14J3h0dU007850;
        Wed, 19 May 2021 03:51:00 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma05wdc.us.ibm.com with ESMTP id 38j7tb3hye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 03:51:00 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14J3oxaK24117734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 03:50:59 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C57627805E;
        Wed, 19 May 2021 03:50:59 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B91F78060;
        Wed, 19 May 2021 03:50:52 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.80.208.94])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 19 May 2021 03:50:52 +0000 (GMT)
Message-ID: <d6b31cd039bf717bc4ea496c2aff1f7cb9c62bfc.camel@linux.ibm.com>
Subject: Re: [PATCH v19 6/8] PM: hibernate: disable when there are active
 secretmem users
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
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
        Yury Norov <yury.norov@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-riscv@lists.infradead.org, X86 ML <x86@kernel.org>
Date:   Tue, 18 May 2021 20:50:51 -0700
In-Reply-To: <CAPcyv4hwZ2e-xzsySOjaJXDSXRKctsoGA5zW-enTn2Y9ezWPVw@mail.gmail.com>
References: <20210513184734.29317-1-rppt@kernel.org>
         <20210513184734.29317-7-rppt@kernel.org>
         <20210518102424.GD82842@C02TD0UTHF1T.local>
         <d99864e677cec4ed83e52c4417c58bbe5fd728b1.camel@linux.ibm.com>
         <CAPcyv4hwZ2e-xzsySOjaJXDSXRKctsoGA5zW-enTn2Y9ezWPVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VqtaOLO0XUQJCbKk9fXnTog4s3XC3y7U
X-Proofpoint-GUID: TEWD-gwpPRN_Ns5w2NX9HRb7MXu4tE3d
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_01:2021-05-18,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190024
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-05-18 at 18:49 -0700, Dan Williams wrote:
> On Tue, May 18, 2021 at 6:33 PM James Bottomley <jejb@linux.ibm.com>
> wrote:
> > On Tue, 2021-05-18 at 11:24 +0100, Mark Rutland wrote:
> > > On Thu, May 13, 2021 at 09:47:32PM +0300, Mike Rapoport wrote:
> > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > 
> > > > It is unsafe to allow saving of secretmem areas to the
> > > > hibernation snapshot as they would be visible after the resume
> > > > and this essentially will defeat the purpose of secret memory
> > > > mappings.
> > > > 
> > > > Prevent hibernation whenever there are active secret memory
> > > > users.
> > > 
> > > Have we thought about how this is going to work in practice, e.g.
> > > on mobile systems? It seems to me that there are a variety of
> > > common applications which might want to use this which people
> > > don't expect to inhibit hibernate (e.g. authentication agents,
> > > web browsers).
> > 
> > If mobile systems require hibernate, then the choice is to disable
> > this functionality or implement a secure hibernation store.   I
> > also thought most mobile hibernation was basically equivalent to
> > S3, in which case there's no actual writing of ram into storage, in
> > which case there's no security barrier and likely the inhibition
> > needs to be made a bit more specific to the suspend to disk case?
> > 
> > > Are we happy to say that any userspace application can
> > > incidentally inhibit hibernate?
> > 
> > Well, yes, for the laptop use case because we don't want suspend to
> > disk to be able to compromise the secret area.  You can disable
> > this for mobile if you like, or work out how to implement hibernate
> > securely if you're really suspending to disk.
> 
> Forgive me if this was already asked and answered. Why not document
> that secretmem is ephemeral in the case of hibernate and push the
> problem to userspace to disable hibernation? In other words
> hibernation causes applications to need to reload their secretmem, it
> will be destroyed on the way down and SIGBUS afterwards. That at
> least gives a system the flexibility to either sacrifice hibernate
> for secretmem (with a userspace controlled policy), or sacrifice
> secretmem using processes for hibernate.

Well, realistically, there are many possibilities for embedded if it
wants to use secret memory.  However, not really having much of an
interest in the use cases, it's not really for Mike or me to be acting
as armchair fly half.  I think the best we can do is demonstrate the
system for our use cases and let embedded kick the tyres for theirs if
they care, and if not they can disable the feature.

James


