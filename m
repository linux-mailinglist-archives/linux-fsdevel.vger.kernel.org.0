Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0DC6F3629
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 20:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjEASqh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 14:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjEASqN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 14:46:13 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEACF1FC6;
        Mon,  1 May 2023 11:45:43 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 600378216B9;
        Mon,  1 May 2023 18:45:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a228.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9BB4C820A23;
        Mon,  1 May 2023 18:45:31 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682966731; a=rsa-sha256;
        cv=none;
        b=dnpvW2KJLbhkjnTS8+Uc33Ivl1JTEBaPf1cYPhijHW4Cb5L60BuXPw6v1PhyBHiLCR71cC
        ABjaQHxP9BXyROI4SDb3MdfcJYKQPJpyQsFBd69Z/HZzYNYZGOIzp4FH/di5v8ECEoQyS5
        WX0kZV2/IGg8omFGgrBT+ExkKbmpZYHbpvAZFJwwUoeM2/gZN0wkEzOhKPuavNIcpm2xT6
        q2LVSEI9wLzGospqFSWqgS6yssbAVX354S773wzBUCOq6YGXw9jUyv2zxsgmIqJpOrqZFX
        56Rxkl6vRNLsZzqSvwmIQCZ3GYUP+Tu679HWqCGG5KxyBgYohih59UO/Qknrfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682966731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=cQvIokD2K+NzYNjjiFicwOdl/ld8t+K11AzJBztMv5w=;
        b=EufxBkPss/2COJ8pfMlFHUNdUuvrBCUONkr3A6e1jg1yyFYd5xhJH4mLaxD7aU2h8nBR53
        V+o4nbJFB/L9D0NOGHb3DBss2q5S+4hsMLotT3uptAe9HwdWKRbArgTHwnlR3eICkokIBA
        cZJ099JOWM+YTyx0MuQ0DenQDeEalQRlp+L2x30I94J4SVbJ2DH76CcXrJ93feegrSswwa
        H3OGZjO1+/W8QGQ8P4mxPtbLUtJJb3xKWvcUy2WSs3p+u7Z030lxGrPUgLDek5jseDxGgh
        pmwbO9HuvFoYQuzfWfJIJYli8x2S58DEQTanlmIBdkXHQl8SR05YLm/CAGtRmQ==
ARC-Authentication-Results: i=1;
        rspamd-548d6c8f77-6r4d7;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cooing-Obese: 2bace05f6be69ff6_1682966732181_4019548331
X-MC-Loop-Signature: 1682966732181:3490870074
X-MC-Ingress-Time: 1682966732181
Received: from pdx1-sub0-mail-a228.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.125.42.177 (trex/6.7.2);
        Mon, 01 May 2023 18:45:32 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a228.dreamhost.com (Postfix) with ESMTPSA id 4Q9Bwk670Cz2r;
        Mon,  1 May 2023 11:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682966731;
        bh=cQvIokD2K+NzYNjjiFicwOdl/ld8t+K11AzJBztMv5w=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=M4zg8dWD7JrhTAPu66mAaTSowPpbRrHZy5vX69tq81nfwkxu5ABcZTvdEitOi/pao
         /F7Zvy8qWg1uHLSHLIy71BfECCRDVEwVkTwGKV4enAwitbWyAX7zQqIxmgy5Ekd/3X
         eBwxyFJiNCc7dhGh2bz9gA9ZTYm8wnwYJYcxvjmWmZlG9vFDjd6eLcRSIDYUNogSq+
         oVjfYOIiAkLFcvJXiR+WaIO0m3OLgmSHgWG9uIJmSrQfiv/1IAVWlVBaPb3a4MC4bW
         0zy1Hp6lJ5g/95zoBLuM69MBh/dir7fkKAaiZvBE5LBTcfUuT5xk1lKoWeUIQ/grrx
         vT+3O4+ucwzGA==
Date:   Mon, 1 May 2023 11:13:15 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, kent.overstreet@linux.dev,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, mgorman@suse.de, willy@infradead.org,
        liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
        peterz@infradead.org, juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Noralf =?utf-8?B?VHLDr8K/wr1ubmVz?= <noralf@tronnes.org>
Subject: Re: [PATCH 01/40] lib/string_helpers: Drop space in
 string_get_size's output
Message-ID: <ouuidemyregstrijempvhv357ggp4tgnv6cijhasnungsovokm@jkgvyuyw2fti>
Mail-Followup-To: Suren Baghdasaryan <surenb@google.com>, 
        akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, willy@infradead.org, 
        liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
        juri.lelli@redhat.com, ldufour@linux.ibm.com, catalin.marinas@arm.com, will@kernel.org, 
        arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
        dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, david@redhat.com, 
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org, 
        dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org, 
        paulmck@kernel.org, pasha.tatashin@soleen.com, yosryahmed@google.com, 
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
        keescook@chromium.org, ndesaulniers@google.com, gregkh@linuxfoundation.org, 
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, 
        vschneid@redhat.com, cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
        42.hyeyoo@gmail.com, glider@google.com, elver@google.com, dvyukov@google.com, 
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
        minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
        linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, cgroups@vger.kernel.org, 
        Andy Shevchenko <andy@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
        Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, 
        "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
        Noralf =?utf-8?B?VHLDr8K/wr1ubmVz?= <noralf@tronnes.org>
References: <20230501165450.15352-1-surenb@google.com>
 <20230501165450.15352-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230501165450.15352-2-surenb@google.com>
User-Agent: NeoMutt/20230407
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 01 May 2023, Suren Baghdasaryan wrote:

>From: Kent Overstreet <kent.overstreet@linux.dev>
>
>Previously, string_get_size() outputted a space between the number and
>the units, i.e.
>  9.88 MiB
>
>This changes it to
>  9.88MiB
>
>which allows it to be parsed correctly by the 'sort -h' command.

Wouldn't this break users that already parse it the current way?

Thanks,
Davidlohr
