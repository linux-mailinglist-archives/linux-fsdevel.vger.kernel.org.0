Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186895BA925
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 11:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiIPJOq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 05:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiIPJOj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 05:14:39 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1F6FD13;
        Fri, 16 Sep 2022 02:14:34 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t65so19814556pgt.2;
        Fri, 16 Sep 2022 02:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=9HbJp1JFOjaCOMdfyVv+S5Btdn1/AdqiEXlLTZXJGsw=;
        b=FhXk6bHLd2b2R99Ls/aHceAb/stM1+/U366ItM+cIq6+4cGyeSSS3oIj0C0fleVnRb
         1Oy5YydiCifwONXQ7wSQiUYRXoH7Mx1foLkqZPWh8dP8iXIDDqQ5t6pLwxs6+plCZvlg
         Nn+HEf/pJUaZbke7TTPzTTPkGpt085qGFfZNtCQRSNX3ALv7oZte2z1tpOrDZga6rULp
         UhUnt0L+EsaXnKH93vJFxK9Cqsv5+shWxVZ8+qcd1oF52gRR3xHbwA1NrpOFdZedwuRe
         un8jpB+sJR4QedlqDa4uSBkp9rex0MViA2EldTkEAnstjD1ZJKcVVfl3WtUvxl6d6Cxc
         Ghxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=9HbJp1JFOjaCOMdfyVv+S5Btdn1/AdqiEXlLTZXJGsw=;
        b=J0JRfvX69bvz2Pbhp1Qr1oMRkNujqrt9gDE/TiWJEOMTWZJXFOLCDpqblfhbJkyHi2
         qML8bMZhbD0PeX4ubS5fsuQL/F3OQw2C8+scEklJ/Hx0Nibe8ENDgJIK9+U18q4yiw/N
         4k1TXWCVVK2/zn5vZjPcYzosWm8h0PnPrNoFDK3I3ZAzsfx0UhzFt7q6TMERRXJuJZ7L
         1ICk1QSm1DTK6I6h/RlyxuObTiJ9uTnP8/1mVxpzFN/8aQ474G5ZzWi/sxeohjdXGrLN
         KWVyy2onEcStzWtrJQBVg8+45V6XqYRRQL1KDuBWULCKQBHAYqu1X1zYEJ35TV2tYZks
         aQ/A==
X-Gm-Message-State: ACrzQf3e61PNjadJTgrfOW+F1dz4U3jlV1/TmaVAyueqiVHoCE8GXfJK
        NuuQlOxxhKs4rednY6CqWrM=
X-Google-Smtp-Source: AMsMyM5/dJZc/QkfgAbO54iWH2nmTge0XbEgPmG5RCUUzNqq/hIVySC1GzK1Hf1d9uWZroqXUsDRFw==
X-Received: by 2002:a65:6e82:0:b0:41a:9b73:f0e6 with SMTP id bm2-20020a656e82000000b0041a9b73f0e6mr3808278pgb.371.1663319673424;
        Fri, 16 Sep 2022 02:14:33 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-32.three.co.id. [116.206.28.32])
        by smtp.gmail.com with ESMTPSA id c81-20020a621c54000000b0052d4cb47339sm13931057pfc.151.2022.09.16.02.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 02:14:32 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 719B010322A; Fri, 16 Sep 2022 16:14:29 +0700 (WIB)
Date:   Fri, 16 Sep 2022 16:14:29 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v8 2/8] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <YyQ+dQT9/V5e62/u@debian.me>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-3-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r2iCa8Nng+AYARyi"
Content-Disposition: inline
In-Reply-To: <20220915142913.2213336-3-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--r2iCa8Nng+AYARyi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 15, 2022 at 10:29:07PM +0800, Chao Peng wrote:
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index abd7c32126ce..c1fac1e9f820 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -1319,7 +1319,7 @@ yet and must be cleared on entry.
>  :Capability: KVM_CAP_USER_MEMORY
>  :Architectures: all
>  :Type: vm ioctl
> -:Parameters: struct kvm_userspace_memory_region (in)
> +:Parameters: struct kvm_userspace_memory_region(_ext) (in)
>  :Returns: 0 on success, -1 on error
> =20
>  ::
> @@ -1332,9 +1332,18 @@ yet and must be cleared on entry.
>  	__u64 userspace_addr; /* start of the userspace allocated memory */
>    };
> =20
> +  struct kvm_userspace_memory_region_ext {
> +	struct kvm_userspace_memory_region region;
> +	__u64 private_offset;
> +	__u32 private_fd;
> +	__u32 pad1;
> +	__u64 pad2[14];
> +  };
> +
>    /* for kvm_memory_region::flags */
>    #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
>    #define KVM_MEM_READONLY	(1UL << 1)
> +  #define KVM_MEM_PRIVATE		(1UL << 2)
> =20
>  This ioctl allows the user to create, modify or delete a guest physical
>  memory slot.  Bits 0-15 of "slot" specify the slot id and this value
> @@ -1365,12 +1374,27 @@ It is recommended that the lower 21 bits of guest=
_phys_addr and userspace_addr
>  be identical.  This allows large pages in the guest to be backed by large
>  pages in the host.
> =20
> -The flags field supports two flags: KVM_MEM_LOG_DIRTY_PAGES and
> -KVM_MEM_READONLY.  The former can be set to instruct KVM to keep track of
> -writes to memory within the slot.  See KVM_GET_DIRTY_LOG ioctl to know h=
ow to
> -use it.  The latter can be set, if KVM_CAP_READONLY_MEM capability allow=
s it,
> -to make a new slot read-only.  In this case, writes to this memory will =
be
> -posted to userspace as KVM_EXIT_MMIO exits.
> +kvm_userspace_memory_region_ext includes all the kvm_userspace_memory_re=
gion
> +fields. It also includes additional fields for some specific features. S=
ee
> +below description of flags field for more information. It's recommended =
to use
> +kvm_userspace_memory_region_ext in new userspace code.

Better say "kvm_userspace_memory_region_ext includes all fields of
kvm_userspace_memory_region struct, while also adds additional fields ..."

> +
> +The flags field supports below flags:

s/below/following/

> +
> +- KVM_MEM_LOG_DIRTY_PAGES can be set to instruct KVM to keep track of wr=
ites to
> +  memory within the slot.  See KVM_GET_DIRTY_LOG ioctl to know how to us=
e it.
> +

Better say "... For more details, see KVM_GET_DIRTY_LOG."

> +- KVM_MEM_READONLY can be set, if KVM_CAP_READONLY_MEM capability allows=
 it, to
> +  make a new slot read-only.  In this case, writes to this memory will b=
e posted
> +  to userspace as KVM_EXIT_MMIO exits.
> +

Better say "if KVM_CAP_READONLY_MEM allows, KVM_MEM_READONLY makes a new
slot read-only ..."

> +- KVM_MEM_PRIVATE can be set to indicate a new slot has private memory b=
acked by
> +  a file descirptor(fd) and the content of the private memory is invisib=
le to
> +  userspace. In this case, userspace should use private_fd/private_offse=
t in
> +  kvm_userspace_memory_region_ext to instruct KVM to provide private mem=
ory to
> +  guest. Userspace should guarantee not to map the same pfn indicated by
> +  private_fd/private_offset to different gfns with multiple memslots. Fa=
iled to
> +  do this may result undefined behavior.
> =20

For the lists above,
s/can be set/

Thanks.=20

--=20
An old man doll... just what I always wanted! - Clara

--r2iCa8Nng+AYARyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYyQ+bwAKCRD2uYlJVVFO
o23ZAQDRE9CoC5C+vDIubVjEpXEJsigvh2LH13HdQDeX1z+k1AD/X1CQT1z1G/wL
BTUE4CCJxYH87fBebOmUE0OMZL/c8go=
=sF4e
-----END PGP SIGNATURE-----

--r2iCa8Nng+AYARyi--
