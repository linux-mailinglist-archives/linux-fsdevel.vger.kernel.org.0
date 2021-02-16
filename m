Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F14031CE5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 17:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhBPQqu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 11:46:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14584 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229699AbhBPQqt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:46:49 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11GGcjPe025880;
        Tue, 16 Feb 2021 11:44:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=Q5aHAR7pPlj/atdytcBPZccatqTpy1qm0hvpI6B2Sf0=;
 b=aSu0QIsUki902qrNU04AQuAffNS2rmmkgsvzPX/SqRGj503dHwb0uANR9/3BdjdcUOTr
 a5u+ik+W33ZCsmtUxgwWVAHgOiZ8625M6a9uJEkw5M0bu2XcLPXd+ZZsxLUXrIenOu/d
 IJMvDOwpYRE2a0EWmrznneVzszNnlWCT+VonA6hJOlSqIE/ENo5L4A6mG3mzNFTH5W3W
 vYfcPIlcyeuiYpY+PitOIUSYlhf7/ijhbppqWPgF2sgzNwq3Tdj1awqDTi3lk7pFWD+x
 7YUipYk80l508mrZJAmUo4t0geEsdokwhvGGU4dlOtVmuxjC7/TzSbCC36zPfRgAJOZ1 WQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36rhb68s0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Feb 2021 11:44:29 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11GGd9Qa029758;
        Tue, 16 Feb 2021 11:44:25 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36rhb68rud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Feb 2021 11:44:24 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11GGflQF029695;
        Tue, 16 Feb 2021 16:44:16 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04wdc.us.ibm.com with ESMTP id 36p6d8ypak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Feb 2021 16:44:16 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11GGiFGX8716868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 16:44:15 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F8AE78060;
        Tue, 16 Feb 2021 16:44:15 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EE9578063;
        Tue, 16 Feb 2021 16:44:05 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.85.199.127])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 16 Feb 2021 16:44:05 +0000 (GMT)
Message-ID: <000cfaa0a9a09f07c5e50e573393cda301d650c9.camel@linux.ibm.com>
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
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
Date:   Tue, 16 Feb 2021 08:44:04 -0800
In-Reply-To: <dfd7db5c-a8c7-0676-59f8-70aa6bcaabe7@redhat.com>
References: <20210214091954.GM242749@kernel.org>
         <052DACE9-986B-424C-AF8E-D6A4277DE635@redhat.com>
         <244f86cba227fa49ca30cd595c4e5538fe2f7c2b.camel@linux.ibm.com>
         <YCo7TqUnBdgJGkwN@dhcp22.suse.cz>
         <be1d821d3f0aec24ad13ca7126b4359822212eb0.camel@linux.ibm.com>
         <YCrJjYmr7A2nO6lA@dhcp22.suse.cz>
         <12c3890b233c8ec8e3967352001a7b72a8e0bfd0.camel@linux.ibm.com>
         <dfd7db5c-a8c7-0676-59f8-70aa6bcaabe7@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-16_07:2021-02-16,2021-02-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=398 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102160146
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-02-16 at 17:34 +0100, David Hildenbrand wrote:
> On 16.02.21 17:25, James Bottomley wrote:
> > On Mon, 2021-02-15 at 20:20 +0100, Michal Hocko wrote:
> > [...]
> > > > >    What kind of flags are we talking about and why would that
> > > > > be a problem with memfd_create interface? Could you be more
> > > > > specific please?
> > > > 
> > > > You mean what were the ioctl flags in the patch series linked
> > > > above? They were SECRETMEM_EXCLUSIVE and SECRETMEM_UNCACHED in
> > > > patch 3/5.
> > > 
> > > OK I see. How many potential modes are we talking about? A few or
> > > potentially many?
> >   
> > Well I initially thought there were two (uncached or not) until you
> > came up with the migratable or non-migratable, which affects the
> > security properties.  But now there's also potential for hardware
> > backing, like mktme,  described by flags as well.  I suppose you
> > could also use RDT to restrict which cache the data goes into: say
> > L1 but not L2 on to lessen the impact of fully uncached (although
> > the big thrust of uncached was to blunt hyperthread side
> > channels).  So there is potential for quite a large expansion even
> > though I'd be willing to bet that a lot of the modes people have
> > thought about turn out not to be very effective in the field.
> 
> Thanks for the insight. I remember that even the "uncached" parts
> was effectively nacked by x86 maintainers (I might be wrong).

It wasn't liked by x86 maintainers, no.  Plus there's no
architecturally standard mechanism for making a page uncached and, as
the arm people pointed out, sometimes no way of ensuring it's never
cached.

>  For the other parts, the question is what we actually want to let
> user space configure.
> 
> Being able to specify "Very secure" "maximum secure" "average
> secure"  all doesn't really make sense to me.

Well, it doesn't to me either unless the user feels a cost/benefit, so
if max cost $100 per invocation and average cost nothing, most people
would chose average unless they had a very good reason not to.  In your
migratable model, if we had separate limits for non-migratable and
migratable, with non-migratable being set low to prevent exhaustion,
max secure becomes a highly scarce resource, whereas average secure is
abundant then having the choice might make sense.

>  The discussion regarding migratability only really popped up because
> this is a user-visible thing and not being able to migrate can be a
> real problem (fragmentation, ZONE_MOVABLE, ...).

I think the biggest use will potentially come from hardware
acceleration.  If it becomes simple to add say encryption to a secret
page with no cost, then no flag needed.  However, if we only have a
limited number of keys so once we run out no more encrypted memory then
it becomes a costly resource and users might want a choice of being
backed by encryption or not.

James


