Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BA831CDFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 17:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhBPQ1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 11:27:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39438 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229916AbhBPQ1S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:27:18 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11GG5JmK126031;
        Tue, 16 Feb 2021 11:25:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=h2KZ1bvu1a9qVnwXD9zg+LWh/Rpqhdqvt0dMmFR40Sk=;
 b=m33wPuJK690vXBjqVMCMqh9RCEidFwXzGuc2ShVqK9ersX2esMtvNyQCFx/Q3Bw7IXy5
 3H+yqHjRJQxOGb/IR8R2/bRHknptt5nSYNHzbKQH9bsc+Ftv2Oyo9LoHi/5lxnBak7DN
 RP4vf6Y1B1fAYubYAPOmMQKENehcPRSRuXwVmPQFs7nLBYt3N92YUtUSAZJw+AForp1r
 qJ0veYMYH/UT4iGBQtO16zKZq94xmdD+30mJ+piXiJ8dcny/n4PG25w0I1NefNpJIN75
 vK3JtaXAHMd3Cap9soRecjBnYmKFSZNxcmhBX3TJ4Fe7IAfBWnRymDy/SCrt1At9Y/HL jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36rh8xgnbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Feb 2021 11:25:53 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11GG5sHt127555;
        Tue, 16 Feb 2021 11:25:52 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36rh8xgnar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Feb 2021 11:25:52 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11GGHgYA030474;
        Tue, 16 Feb 2021 16:25:50 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03wdc.us.ibm.com with ESMTP id 36p6d8yha7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Feb 2021 16:25:50 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11GGPn4a11338136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 16:25:49 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92C8778063;
        Tue, 16 Feb 2021 16:25:49 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B00A17805C;
        Tue, 16 Feb 2021 16:25:40 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.85.199.127])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 16 Feb 2021 16:25:40 +0000 (GMT)
Message-ID: <12c3890b233c8ec8e3967352001a7b72a8e0bfd0.camel@linux.ibm.com>
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
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
Date:   Tue, 16 Feb 2021 08:25:39 -0800
In-Reply-To: <YCrJjYmr7A2nO6lA@dhcp22.suse.cz>
References: <20210214091954.GM242749@kernel.org>
         <052DACE9-986B-424C-AF8E-D6A4277DE635@redhat.com>
         <244f86cba227fa49ca30cd595c4e5538fe2f7c2b.camel@linux.ibm.com>
         <YCo7TqUnBdgJGkwN@dhcp22.suse.cz>
         <be1d821d3f0aec24ad13ca7126b4359822212eb0.camel@linux.ibm.com>
         <YCrJjYmr7A2nO6lA@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-16_06:2021-02-16,2021-02-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=752
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102160141
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-02-15 at 20:20 +0100, Michal Hocko wrote:
[...]
> > >   What kind of flags are we talking about and why would that be a
> > > problem with memfd_create interface? Could you be more specific
> > > please?
> > 
> > You mean what were the ioctl flags in the patch series linked
> > above? They were SECRETMEM_EXCLUSIVE and SECRETMEM_UNCACHED in
> > patch 3/5. 
> 
> OK I see. How many potential modes are we talking about? A few or
> potentially many?
 
Well I initially thought there were two (uncached or not) until you
came up with the migratable or non-migratable, which affects the
security properties.  But now there's also potential for hardware
backing, like mktme,  described by flags as well.  I suppose you could
also use RDT to restrict which cache the data goes into: say L1 but not
L2 on to lessen the impact of fully uncached (although the big thrust
of uncached was to blunt hyperthread side channels).  So there is
potential for quite a large expansion even though I'd be willing to bet
that a lot of the modes people have thought about turn out not to be
very effective in the field.

James


