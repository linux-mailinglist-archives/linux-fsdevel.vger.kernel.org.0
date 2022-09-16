Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D855C5BA939
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 11:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiIPJS2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 05:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiIPJSE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 05:18:04 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF242A99EF;
        Fri, 16 Sep 2022 02:17:51 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b23so20639161pfp.9;
        Fri, 16 Sep 2022 02:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=RFJvLC3oyKntFrzTiQRhGZVyVO6GPmrCQg8gZcgZyFw=;
        b=Si6vfDs3bb2P2LS+f46ihWdK3HAyZdel6Ti1Rl2uXqTyVhhM+fRPVv2zmQ4d/VKab8
         E4MWbu0mTcGqAAdPVQlX+SSKfU7KNUsJrnxmoBrVPgeHoXCdIBpGm9c0rMYAv+TCkITP
         CrEQiNGzUycaWOLkBp7E1yPKzvFAgYuY/fZAO8XH1XVhBx+LMLqnJpoTapoE/PeMwBdh
         gR1mmMH6iNh/WBmaizEX2KFNP64aO1OPWnEsFQYWCLpTltBTj52KfzB4SBNaMVGNxlZc
         4uKj2M4qd/vGEsuKn8Qx6qonwZz8cdIn9MQSREeaVvRUXI8uhZafFWRTbUHEkdBASLVc
         boHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=RFJvLC3oyKntFrzTiQRhGZVyVO6GPmrCQg8gZcgZyFw=;
        b=54A3nWdRxuXxlksECDGwjlzlODPqF1IEKd8vY4oQFFAhn3dJAEkw9SRmtp9FRw5yR6
         HTq3y3IP98sxStjDVjwXHKBtkvukVQ3OFB5UbJxL22j6XKvHMAVCTtW5ZOrgeaMvBFJs
         XkzGxjEpbGcK0ABWAAgGSIWp338yAiznQIn96McKcA0XHZ744Ynym+Zdooa1pp7CMPJ9
         ILwPhaZWOTFywC/+ZqEhchIyE7Jlfp5G1X/y05GwDDq7gtERdW5PxuHikQ7qLKgZ9Zlp
         r8YxTYhRkkDmKx73Zs5yj+bEQrDqGRrN3Th1sKKWAOgOjoPrSr1/uS7+zGDV1IPKzrC0
         sM2w==
X-Gm-Message-State: ACrzQf1Vv97mG5H9HRamlmbqq5rj6UtDlAOTqAD0s5RtOFFRKSVG7XSI
        OSkBFvMspXXTI0pWhmIdPMQ=
X-Google-Smtp-Source: AMsMyM6PMf1pTSKPrEToM1vu4+OPBqOTXE35gLiVtkoVeVNAu/wJ9Awn1DLWt6lUQ0y1S1KgHHMDJw==
X-Received: by 2002:a63:77c4:0:b0:435:4224:98b6 with SMTP id s187-20020a6377c4000000b00435422498b6mr3751652pgc.94.1663319871288;
        Fri, 16 Sep 2022 02:17:51 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-32.three.co.id. [116.206.28.32])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090311c700b00174f7d10a03sm14635852plh.86.2022.09.16.02.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 02:17:50 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 5800510322A; Fri, 16 Sep 2022 16:17:48 +0700 (WIB)
Date:   Fri, 16 Sep 2022 16:17:48 +0700
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
Subject: Re: [PATCH v8 3/8] KVM: Add KVM_EXIT_MEMORY_FAULT exit
Message-ID: <YyQ/PHZHkDSgjH/v@debian.me>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-4-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y7c2sZGFbG3OyuxM"
Content-Disposition: inline
In-Reply-To: <20220915142913.2213336-4-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--y7c2sZGFbG3OyuxM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 15, 2022 at 10:29:08PM +0800, Chao Peng wrote:
> + - KVM_MEMORY_EXIT_FLAG_PRIVATE - indicates the memory error is caused by
> +   private memory access when the bit is set otherwise the memory error =
is
> +   caused by shared memory access when the bit is clear.

s/set otherwise/set. Otherwise,

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--y7c2sZGFbG3OyuxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYyQ/PAAKCRD2uYlJVVFO
o+4BAQDezOCiD0NOTihbyDi8bMxnDsZat5ohcP3Z6qp+0VEjSAD+PZb6ujbn8gYi
c4AOBSOQzNSdKZVaTt8s86rxM84+4gk=
=Ns2r
-----END PGP SIGNATURE-----

--y7c2sZGFbG3OyuxM--
