Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAC17B3D60
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 03:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjI3BQa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 21:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjI3BQa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 21:16:30 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0831F3;
        Fri, 29 Sep 2023 18:16:27 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 763C13200916;
        Fri, 29 Sep 2023 21:16:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 29 Sep 2023 21:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1696036581; x=1696122981; bh=fFeBd2wnRQFZEpz+r8VxUNSi+h4AN2LcJPK
        4S1aXKis=; b=AsuR5BNr/3Zccy/Xb5uNgfZgXpVBovOZBwhYBQ0E4yfaaq7CpZh
        /ZQv/TbE0C6nViX/Qp/767ob3XI3jDp5fgYGH8kTpkTagAAjs9gVTpjdmtsKfsbM
        iop9rnxJsmUcFDBehPEvfSOO+7nAbOboC8ZPdwHIkrd07YZiVY7zuOkvbfYKAocI
        P3N0+NCCIBBgaNwcm4UQX7FyJxoo4ML+dmI3bXOkXI2ML+sqZ9tTjQEjJVPnXfTx
        AMoN59No0cz303+JEs9rjyOp4oTRmYj//EGMTHdBK4fAUSQ/M8U2NGQ1HCysUoV4
        BbPMZhG7Qn9NYI5QOJhA1zKppl7F4uluoQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696036581; x=1696122981; bh=fFeBd2wnRQFZEpz+r8VxUNSi+h4AN2LcJPK
        4S1aXKis=; b=MCPogdCTKEpWqzyxwXUoXwfpyQJygkdIURvYLbVFhBo218HKEjf
        46mRPT8AH0p/CC32x0nIVVSbFNni23E0H3vQ+Ot6kSkWANtJr6jEtQAuUqYgtLcV
        zF3DGMUXDxFBYmbc6NCkFD0m44M+lQmqeyC4OONy01owuyCm88YMvx/v3k+5wWgm
        lJ3SFBfiF2ZfG9iZizW5/P7d9wqytHEIkCiiytYTvmV5BJdhLvv3TkevTZysgoHo
        EjzWUhlDBT6GZf6yqku6erzlBru/OPCNrsf6LZDnEV2TrEhcEZcFOQ+Yq18HhVxI
        bxZiGfCErYvgxcYUuHWbBQYU0j9qyNYf5sA==
X-ME-Sender: <xms:5XYXZSqt9Rac8jxW6aNaM9v-7OLygZ1dbpaVg29P3K-9-UrS7sJ7-g>
    <xme:5XYXZQqT3NbNOOl1um60I64qCffg_mgDtNikXrxxbkuZemGWC_KvtDK05kirNvRjM
    wBi5afgXKAU>
X-ME-Received: <xmr:5XYXZXPvndhUvUAkT1PdKlTVQxdTm_ZBhmhwOPRugaACaszOZ5Wl239YDlx3z1RYKovsPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtdehgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    euhfeuieeijeeuveekgfeitdethefguddtleffhfelfeelhfduuedvfefhgefhheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:5XYXZR6yR90AT63M-YNM2vWNZmjMPexZPzNWbhBdZvqTJBpJQnpkJw>
    <xmx:5XYXZR6PeRUmhwDfL5Sjr77fd09GbXWtylG8xOEthefDZ1JQjSGBeA>
    <xmx:5XYXZRiA5c_8DmUr3ykCcMP0SAjJTBfgSk9AwSpN7dFwyxrR-qTIFw>
    <xmx:5XYXZQKx7obLnQZeNvwDx2rK6qugIqcZ3TgYhQndbWkEcP-tXy2UCw>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Sep 2023 21:16:14 -0400 (EDT)
Message-ID: <348596f8-e88b-2e8b-96e2-20caaf5c9d7b@themaw.net>
Date:   Sat, 30 Sep 2023 09:16:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/4] add statmount(2) syscall
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20230928130147.564503-1-mszeredi@redhat.com>
 <20230928130147.564503-4-mszeredi@redhat.com>
 <5787bac5-b368-485a-f906-44e7049d4b8f@themaw.net>
 <CAJfpegt80_Tyto3QyD48V_yzHSghqg8AC_OPHEMPkDjEYCcisQ@mail.gmail.com>
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <CAJfpegt80_Tyto3QyD48V_yzHSghqg8AC_OPHEMPkDjEYCcisQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29/9/23 17:10, Miklos Szeredi wrote:
> On Fri, 29 Sept 2023 at 02:42, Ian Kent <raven@themaw.net> wrote:
>> On 28/9/23 21:01, Miklos Szeredi wrote:
>>> +static struct vfsmount *lookup_mnt_in_ns(u64 id, struct mnt_namespace *ns)
>>> +{
>>> +     struct mount *mnt;
>>> +     struct vfsmount *res = NULL;
>>> +
>>> +     lock_ns_list(ns);
>>> +     list_for_each_entry(mnt, &ns->list, mnt_list) {
>>> +             if (!mnt_is_cursor(mnt) && id == mnt->mnt_id_unique) {
>>> +                     res = &mnt->mnt;
>>> +                     break;
>>> +             }
>>> +     }
>>> +     unlock_ns_list(ns);
>>> +     return res;
>>> +}
>> Seems like we might need to consider making (struct mnt_namespace)->list
>>
>> a hashed list.
> Yes, linear search needs to go.  A hash table is probably the easiest solution.
>
> But I'd also consider replacing ns->list with an rbtree.  Not as
> trivial as adding a system hash table and probably also slightly
> slower, but it would have some advantages:
>
>   - most space efficient (no overhead of hash buckets)
>
>   - cursor can go away (f_pos can just contain last ID)

I guess that would be ok.

Avoiding the cursor is a big plus.


An rbtree is used in kernfs and its readdir function is rather painful so

I wonder what the implications might be for other enumeration needs.


Ian

