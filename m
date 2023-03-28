Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B9F6CB540
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 06:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjC1EAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 00:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjC1EAx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 00:00:53 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA69BC7;
        Mon, 27 Mar 2023 21:00:51 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 0E2A13200319;
        Tue, 28 Mar 2023 00:00:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 28 Mar 2023 00:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-transfer-encoding:content-type
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1679976050; x=1680062450; bh=YFsPFLauCP
        2npAFrNKe9MFZyh5jEPM6xMMf0mm2s/GE=; b=GK8iFkd3jMCVykpBSWQcF5wTWD
        O+MbKI68pAa5puHLovUD42GpZasIzZfLKVXW7/LYB3MvmNWBB2Pmpx5OiXhikzss
        8dZ17Ifzpg3vl6R2lNV+UjPvGn2EpVjwXFeF1PownZiCMvkF9JwWgAwpzWDpaxdn
        /6Xuc4mOWlpMZqAJlO/vsDFu4cLQ33lDcZh//9FEiaoSTN4JECW7CclmBS2Mc9lK
        G8AyzwRvCpR7/Z795p69vp/wF+M/8WZ80OpCkC9E3LMzpqfDVLcedD6lK3ieIEPD
        BDBsu2nmjoEYXxxY05mR4FO1iNRxlI88KTPsbjSmzE1EtkVHR5megQ05C/IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679976050; x=1680062450; bh=YFsPFLauCP2npAFrNKe9MFZyh5jEPM6xMMf
        0mm2s/GE=; b=G0d6H0eVM3KSvqw8J3H5dETBzF0Ly9fkQ2APsClCiOA3Xl+cEfB
        xxzVNAcV0yrP2xWkbp3rd5oabhsZ8zrrdigT0PObwDvGoHMA4N+Gddrafa8ve0AD
        vzUHyBGMKe1FqRb42qd1e5m0t64j6Be6bC+ZbQFsjoqV1gmw8Ab38QEv1A3E7Qm3
        Xun2015gd5Nmy9lpXCkdr0t8Oq9U13sit1v7he8Ab2901qvX9eHt+NqdRX1ff83w
        AhhWIUc88llQ3myjBzXuQKD0sz7uwdNOmCEaZSBEpdwgSpPBxzqPQP3KMwaQITVp
        iG0nz6EGv3Fyiaomxxs4cig7VkIXIBvnN/g==
X-ME-Sender: <xms:cmYiZKJsIeFr9nLVwBf2fSKTIkRboSIzNqRU7-oWqDe0jyb5C-WCZw>
    <xme:cmYiZCLpIsyTE7maLWV_qp3vTuz_WBF_nb_gzgHa5pdk6diy56kra8pdE2EoIJb0i
    xz_Vd5qSDNq3jAGw-0>
X-ME-Received: <xmr:cmYiZKsnCqdbNHNTKgIf0smJDhAjNFu_aq_lrQ8vrIW1tAm--x0xxRjR18UUcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehfedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjfhfkgggtgfesthhqmhdttddtjeenucfhrhhomheplfhoshhh
    ucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeegkeeggfegjedtvdehgfdtvdekueetveetfedvveetueetffek
    ieekledthfeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhg
X-ME-Proxy: <xmx:cmYiZPbxfV9uEDlW7iCKIW0MSD4wobJUvMJGn0793eZXpWpYZl4Dqg>
    <xmx:cmYiZBbODm_WUpD5KGCD_4cukRwTaS7G6vWcDwy06LuD2uw7uzhTGA>
    <xmx:cmYiZLAfpCcgkueIjdKkt-Y9R4rkz_3judhT_y6LkHXxz57C1ErXHA>
    <xmx:cmYiZAX3liZTeAJ0xBBfnxS3h4Th4xxDXtB45-bokVgYX7yyrlV28g>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Mar 2023 00:00:48 -0400 (EDT)
Date:   Tue, 28 Mar 2023 13:00:30 +0900
From:   Josh Triplett <josh@joshtriplett.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Christian Brauner <brauner@kernel.org>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] do_open(): Fix O_DIRECTORY | O_CREAT behavior
In-Reply-To: <CAHk-=wgLimhZ8px+BxTvkonBGHr9oFcjrk4tmE2-_mmd3vBGdg@mail.gmail.com>
References: <20230320071442.172228-1-pedro.falcato@gmail.com> <20230320115153.7n5cq4wl2hmcbndf@wittgenstein> <CAHk-=wjifBVf3ub0WWBXYg7JAao6V8coCdouseaButR0gi5xmg@mail.gmail.com> <ZCJN0aaVPFouMkxp@localhost> <CAHk-=wgLimhZ8px+BxTvkonBGHr9oFcjrk4tmE2-_mmd3vBGdg@mail.gmail.com>
Message-ID: <1CBD903C-C417-42F4-9515-551041BF6CEF@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On March 28, 2023 12:32:59 PM GMT+09:00, Linus Torvalds <torvalds@linux-fou=
ndation=2Eorg> wrote:
>Ok, just to play along - maybe you can make it slightly less
>nonsensical by throwing O_PATH into the mix, and now an empty
>directory file descriptor at least has *some* use=2E

That's the case I was thinking of: create a directory, then use exclusivel=
y *at system calls, never anything path-based=2E (I was using "atomic" loos=
ely; not concerned about races here, just convenience=2E)

>Now your code would not only be specific to Linux, it would be
>specific to some very new version of Linux, and do something
>completely different on older versions=2E

I'm extremely not concerned with depending on current Linux=2E But that sa=
id=2E=2E=2E

>Because those older versions will do random things, ranging from
>"always return an error" to "create a regular file - not a directory -
>and then return an error anyway" and finally "create a regular file -
>not a directory - and return that resulting fd"=2E

=2E=2E=2E Right, open has the un-extendable semantics, hence O_TMPFILE=2E =
Fair enough=2E Nevermind then=2E

As is often the case for multi-operation syscalls, I'm better off just usi=
ng io_uring for a mkdir-then-open=2E

