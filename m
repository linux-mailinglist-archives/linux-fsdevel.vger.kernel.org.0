Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C4F314230
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 22:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbhBHVrI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 16:47:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35745 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236994AbhBHVqN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 16:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612820687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4aepynJlknVRj6NFbhX2n2ebQXb/zj5Dsa2tNMP+Ofs=;
        b=fEKYPjaIb/sgSLB0pw8f9nt8g+Fc33U7I0gLsSdU8vgyV6mHtzXLSAjTxdGDakDrpdGyOk
        GGs1g7YoWaY6gNdraGlk+l93AQugGxz9iin0FpPRIe99QWWxqhOVBu6bfIJb6xV1I1IqVu
        2wkcC+DkQXYiBNWLcdkeB0Yalws7Hsg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-aGX0hJ-hMyCM8-QKKi0ozw-1; Mon, 08 Feb 2021 16:44:45 -0500
X-MC-Unique: aGX0hJ-hMyCM8-QKKi0ozw-1
Received: by mail-lf1-f72.google.com with SMTP id a15so4433553lfo.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Feb 2021 13:44:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=4aepynJlknVRj6NFbhX2n2ebQXb/zj5Dsa2tNMP+Ofs=;
        b=P3w/PnUcD+1M8TzXXIF+RVXpoCMAaiY+qWEZysHNO2BZo+CEAO1fYBzrlJdNg+K4G/
         8Z0jvh+xPv8vgV5yqLHZaX9vb81K3VgOKwrCmiXHDCUiMGbJgUwvcRFIBPj6xXbI9Wdt
         Rb2dFSCU6O/90iPZjm70kVu1niEawZKZv6rKVYpqM1A+5xe7+Icxb2H0hAdYuyuKfSRI
         +e+Nox431IDkXwjGqx0q2Cg7GAtbeGlSVQ2/4fu/1Smaz9n3F8sLIGiyMiZGdRhMX4ie
         s1TBqnh1PsNB1UGiQC8/SW2fOFpbmAw8H4bbxUGpHYnRoPAI8Htjc7vd9U9eMwukAGrn
         wadg==
X-Gm-Message-State: AOAM533tntjBSWApsEQn6rLhCetUAVxxHwdaQqAW8d8+dqE/XeU5AU1X
        W1lHRuBPwngzimqQRf+ycbOIufQq7AWPvDkCMcRsJTUFoc6XCZseqpR2yt6cc6vJcW9UaKCWaw3
        NScGgMg+/Euntix78C8quBUCAPw==
X-Received: by 2002:ac2:484b:: with SMTP id 11mr11144594lfy.605.1612820683682;
        Mon, 08 Feb 2021 13:44:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYU+ahfuGJ3mGlPDTjZ5sBTd5prIK5bha/7jxkj2wK46UMNjmdy8O20OWQnrZzKp7lrPlvQQ==
X-Received: by 2002:a5d:4ac5:: with SMTP id y5mr589823wrs.345.1612820285413;
        Mon, 08 Feb 2021 13:38:05 -0800 (PST)
Received: from [192.168.3.108] (p5b0c696d.dip0.t-ipconnect.de. [91.12.105.109])
        by smtp.gmail.com with ESMTPSA id w15sm30039179wrp.15.2021.02.08.13.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 13:38:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v17 00/10] mm: introduce memfd_secret system call to create "secret" memory areas
Date:   Mon, 8 Feb 2021 22:38:03 +0100
Message-Id: <1F6A73CF-158A-4261-AA6C-1F5C77F4F326@redhat.com>
References: <20210208211326.GV242749@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
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
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
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
        x86@kernel.org
In-Reply-To: <20210208211326.GV242749@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
X-Mailer: iPhone Mail (18D52)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> Am 08.02.2021 um 22:13 schrieb Mike Rapoport <rppt@kernel.org>:
>=20
> =EF=BB=BFOn Mon, Feb 08, 2021 at 10:27:18AM +0100, David Hildenbrand wrote=
:
>> On 08.02.21 09:49, Mike Rapoport wrote:
>>=20
>> Some questions (and request to document the answers) as we now allow to h=
ave
>> unmovable allocations all over the place and I don't see a single comment=

>> regarding that in the cover letter:
>>=20
>> 1. How will the issue of plenty of unmovable allocations for user space b=
e
>> tackled in the future?
>>=20
>> 2. How has this issue been documented? E.g., interaction with ZONE_MOVABL=
E
>> and CMA, alloc_conig_range()/alloc_contig_pages?.
>=20
> Secretmem sets the mappings gfp mask to GFP_HIGHUSER, so it does not
> allocate movable pages at the first place.

That is not the point. Secretmem cannot go on CMA / ZONE_MOVABLE memory and b=
ehaves like long-term pinnings in that sense. This is a real issue when usin=
g a lot of sectremem.

Please have a look at what Pavel documents regarding long term pinnings and Z=
ONE_MOVABLE in his patches currently on the list.=

