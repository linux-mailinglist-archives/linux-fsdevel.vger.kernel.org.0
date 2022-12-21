Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3A7652E2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Dec 2022 10:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbiLUJCs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Dec 2022 04:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbiLUJCq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:02:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19707BF47
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Dec 2022 01:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671613314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9iIYwD1s+rp4gdocvftwkwpTMI6nv2X3CbOpNxwVqmA=;
        b=Q/U2uNpFroCrr/tIxh+mg6fLor/zKdy3rldKjHfP126WCVgW/fCreqWwERcjbWvE53z3Rt
        On3BKjeAmqurUA5Cb9rX0wP8/MOFxQScY4x7Jqdx/AbGqbOCfc9GbJXry/J0TXjG1UT1oE
        VpgjO2DExDdSOgxNp+yylqera6Nr7jU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-557-Xcr_MLPkORmLyaDrYC63ng-1; Wed, 21 Dec 2022 04:01:53 -0500
X-MC-Unique: Xcr_MLPkORmLyaDrYC63ng-1
Received: by mail-wr1-f69.google.com with SMTP id t23-20020adfa2d7000000b00269092d6f8dso532391wra.20
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Dec 2022 01:01:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9iIYwD1s+rp4gdocvftwkwpTMI6nv2X3CbOpNxwVqmA=;
        b=YYDIR22UjVuD8VFTBCkG3jQZVTvvCO8Ee85HAhANfvl+cvYAySDxTs/m94DUZ17h6K
         9iBe16QtopecFXsHkIRTHMKVAcV5knCIvhsJ3i63V78UKFteB1RykESwUDM+4GwrzO3e
         sp2NOIClkPUMgnZIDDGCa7NwAclwuTv0g77EAB2xkxXA621/SmwJB0oikVASVWOyaMeU
         KCzmbbbdnIuGW1zmNNdrAUszbRJEtOwz+vvgLcNGAXR82sTXSVjulDKaGXCPVX6/cV0t
         svPSlLCIalIdolATjZOOaYqaxhH7hcYwyVt98tAPT32j5EHgnCUkRfaNbRLtBtt5Ne4V
         YvyA==
X-Gm-Message-State: AFqh2kpDb3TW+/UGxoeRIzwg+fCV++tWfCm2nXIzKf8rJvCT8WOPRDNa
        Djk2VPwLRPQa8wCZp0cbOedJKENQHiDkpS1qUjHQoJPug26k5b2mCtOhtX7M1fVMTx5T+ksimEp
        QalaVad5QB7y7aBLt1xFzaI9EJQ==
X-Received: by 2002:a7b:ca51:0:b0:3d2:7a7:5cc6 with SMTP id m17-20020a7bca51000000b003d207a75cc6mr3878748wml.18.1671613311759;
        Wed, 21 Dec 2022 01:01:51 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsFpDODvdOo0JOg/vTTOqd2Zt1dsK4GxSMtz2DQ5Uf2cga8GhvxOFQbbrezG3xKpcxKAKW9cw==
X-Received: by 2002:a7b:ca51:0:b0:3d2:7a7:5cc6 with SMTP id m17-20020a7bca51000000b003d207a75cc6mr3878729wml.18.1671613311446;
        Wed, 21 Dec 2022 01:01:51 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:7300:2cf4:73e7:69d5:9e80? (p200300cbc70673002cf473e769d59e80.dip0.t-ipconnect.de. [2003:cb:c706:7300:2cf4:73e7:69d5:9e80])
        by smtp.gmail.com with ESMTPSA id o25-20020a05600c379900b003d208eb17ecsm1546199wmr.26.2022.12.21.01.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 01:01:51 -0800 (PST)
Message-ID: <d95d59d7-308d-831c-d8bd-16d06e66e8af@redhat.com>
Date:   Wed, 21 Dec 2022 10:01:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kernel@collabora.com, peterx@redhat.com,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20221220162606.1595355-1-usama.anjum@collabora.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC] mm: implement granular soft-dirty vma support
In-Reply-To: <20221220162606.1595355-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20.12.22 17:26, Muhammad Usama Anjum wrote:
> The VM_SOFTDIRTY is used to mark a whole VMA soft-dirty. Sometimes
> soft-dirty and non-soft-dirty VMAs are merged making the non-soft-dirty
> region soft-dirty. This creates problems as the whole VMA region comes
> out to be soft-dirty while in-reality no there is no soft-dirty page.
> This can be solved by not merging the VMAs with different soft-dirty
> flags. But it has potential to cause regression as the number of VMAs
> can increase drastically.

I'm not going to look into the details of this RFC, but (1) it looks 
over-engineered and (2) is increases the size of each and every VMA in 
the system.

Let's talk about what happens when we stop merging VMAs where 
VM_SOFTDIRTY differs:

(a) Not merging VMAs when VM_SOFTDIRTY differs will only affect
     processes with active softdirty tracking (i.e., after
     CLEAR_REFS_SOFT_DIRTY). All other VMAs have VM_SOFTDIRTY set and
     will get merged. Processes without CLEAR_REFS_SOFT_DIRTY behave the
     same.

(b) After CLEAR_REFS_SOFT_DIRTY, old mappings will have VM_SOFTDIRTY set
     but new ones won't. We can't merge them. Consequently, we might not
     merge these VMAs and create more.

(c) The problem about (b) is that it will get worse every time we
     CLEAR_REFS_SOFT_DIRTY, because we're not merging the old ones that
     could get merged.


To tackle (c), we can simply try merging VMAs in clear_refs_write() when 
clearing VM_SOFTDIRTY. We're already properly holding the mmap lock in 
write mode, so it's easy to check if we can merge the modified VMA into 
the previous one or into the next one -- or if we can merge all of them 
into a single VMA.


For (b), the usual thing we care about is most probably

[!VM_SOFTDIRTY][VM_SOFTDIRTY]

No longer getting merged into a single VMA. This would imply that during 
(b), we could have doubled the #VMAs.

Of course, there are cases like

[!VM_SOFTDIRTY][VM_SOFTDIRTY][!VM_SOFTDIRTY]

where we could triple them or even a chain like

[!VM_SOFTDIRTY][VM_SOFTDIRTY][!VM_SOFTDIRTY][VM_SOFTDIRTY]...

where the #VMAs could explode. BUT, that would imply that someone has to 
do fine-grained mmap()'s over an existing mmap()'s (or into holes) and 
heavily relies on VMA merging to happen. I assume that only with 
anonymous memory this really works as expected, so I am not sure how 
likely such a pattern is in applications we care about and if we should 
really care.

My suggestion would be to

(1) Make the new merging behavior (consider VM_SOFTDIRTY or ignore
     VM_SOFTDIRTY) configurable (per process? for the system) to not
     accidentally degrade existing users of soft-dirty tracking with such
     "special" applications.
(2) Implement conditional VMA merging during CLEAR_REFS_SOFT_DIRTY: if
     we consider VM_SOFTDIRTY when making merging decisions, we want to
     try merging VMAs here after clearing VM_SOFTDIRTY.
(2) For your use case, enable the new behavior and eventually slightly
     bump up the #VMA limit in case you're dealing with "special"
     applications.

(1) would be called something like "precise_softdirty_tracking". 
Disabled is old handling, enabled is new handling. Precision here means 
that we're not over-indicating softdirty due to VMA merging.


Anything important I am missing? Are we aware of such applications for 
your use-case?

-- 
Thanks,

David / dhildenb

