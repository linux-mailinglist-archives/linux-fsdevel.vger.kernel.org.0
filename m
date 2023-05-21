Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6E070AC05
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 04:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjEUC2Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 22:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjEUCYk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 22:24:40 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671C9E7C;
        Sat, 20 May 2023 19:22:02 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-757731a32ecso239280985a.0;
        Sat, 20 May 2023 19:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684635721; x=1687227721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vm9IhAJzNHecp9b4tA/y+gAHwfPlu+fg8WuJjNJQZrQ=;
        b=SZc6onsXCYsPwVfY6SdFjpHnWXGy8o4cA4JhYmql0wSLgSwRZpC4Bi1Cf1BdPPbpvR
         RJdVSVz1HZp9Kvboq/9qcyfMFW1zQpA1Xc9r7PvmaewJjUbXaB0WZlzD+ZQ0RlXOdh1X
         PbQObHniJgGDdWM5lvLzSvyfGUxAlmcvL+GQ5YiI+UpTU8w+4tPE/6IL1qDrt58pIayo
         auLBZ8BS/cRTuSMEG6lCwfXdOTC6lduK4XaxV70jPzyTj3QRiRMrwyTfwDfw3wvh3o9w
         cjbR+alLmw537E2sHOMNDdZA32/RUUjtSB7EtCdoWwvnIX5T2XMHEZFcsGhDPWL3rAOC
         hUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684635721; x=1687227721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vm9IhAJzNHecp9b4tA/y+gAHwfPlu+fg8WuJjNJQZrQ=;
        b=aUDT2ZeqEY+hGou4sFO3McPgMroT2UyySQqTyXqfuNxBP6FqGBw3NP4iQLgquwazok
         n2YBY2jeQPn/R1gMtHMUJ3mp1N0WJYXzGZ4BOQ/73AQAeALnWlY5dRs11dfx2KVRSgQ3
         eJOHaBkBP9OVMreD9t0Byq1VmqdpsUYKf3mw6yUvsXTttWuZwi2IGsn0VtbPa52GUKX8
         mh7ly39BfkrI+sHrSRRWu8p+HqX2qpnT/PF9IFqrIOhzkBghTAglzb6sgYn93WU3Fef6
         BniFTkwihItj51Qd7+xM0o8hWcQGGhLL6wYQ4UvKwmYo7pwyTusvOnpIP8eRumM1Krj7
         Zx6g==
X-Gm-Message-State: AC+VfDwv7pYeu71ixPe0049fEKtwxZw+ADQLoMzsX5Ke9n+gveBITa4Y
        8XQ96DEZP+aNX3gTfThIzREfqmgwZgY=
X-Google-Smtp-Source: ACHHUZ4GHQdQjqAsu7HG2FSKZmbeWzVUPVlB2dAycNaIth7PjCv/poFKq7luuYpvCdQJAuF7EaHQzg==
X-Received: by 2002:a05:6214:c43:b0:616:4b40:5ea9 with SMTP id r3-20020a0562140c4300b006164b405ea9mr12142373qvj.40.1684635721430;
        Sat, 20 May 2023 19:22:01 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id px23-20020a056214051700b0061b5ad0290asm932144qvb.67.2023.05.20.19.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 19:22:00 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 444B327C0054;
        Sat, 20 May 2023 22:22:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 20 May 2023 22:22:00 -0400
X-ME-Sender: <xms:R4BpZNWeYY4_8sakRQyA4UHM2NuL_9YdyLwdlk0lcZ8uXWLLcHwWuw>
    <xme:R4BpZNkalr7gyv1Qo9HtJEsu8zl2_XXAcg7Z2ZWV8xAhzcEWDsbr2dxSKrYwcOQjk
    PWDDPP_mnsOFQnyTg>
X-ME-Received: <xmr:R4BpZJa8dOezxREtMeCRF78V5LQ-NQPgNfP2pP4Pp8SFDb28VyJxwh8R6LMaKFdeBVsfY3gekW0zGvrh0IRKm04-_p21DMb1pP0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeikedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpedvieegvefhkeetieeuvedtvdeikedtfedvkedtheeghfelvdduteektdev
    leekteenucffohhmrghinheplhifnhdrnhgvthdpkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgv
    shhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehhe
    ehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:R4BpZAV8TqGSvT1_1uoy2rPtBhbOwCcVhFypF5ddjDF3AHz9_V_INQ>
    <xmx:R4BpZHkQtxha2IgUMyG7OlmRXlFRa6Z9T9jR3tqCoXcuR2T59Zlq0g>
    <xmx:R4BpZNdVMZ150Wz2eN6ahDL3Av152NcdMZsTyNX_KRX3-0T67G_LWw>
    <xmx:SIBpZFUNEA3afbuwVmiUyAnfSZHDN0sPwYCOmo4ts_ETMPDswgswUQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 May 2023 22:21:59 -0400 (EDT)
Date:   Sat, 20 May 2023 19:21:57 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Neil Brown <neilb@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v4 2/9] fs: add infrastructure for multigrain inode
 i_m/ctime
Message-ID: <ZGmARbuI4BC05cJi@Boquns-Mac-mini.local>
References: <20230518114742.128950-3-jlayton@kernel.org>
 <ZGkoU6Wfcst6scNk@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGkoU6Wfcst6scNk@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Cc Paul and Mark]

On Sat, May 20, 2023 at 04:06:43PM -0400, Theodore Ts'o wrote:
> On Thu, May 18, 2023 at 07:47:35AM -0400, Jeff Layton wrote:
> > Use the 31st bit of the ctime tv_nsec field to indicate that something
> > has queried the inode for the i_mtime or i_ctime. When this flag is set,
> > on the next timestamp update, the kernel can fetch a fine-grained
> > timestamp instead of the usual coarse-grained one.
> 
> TIL....  that atomic_long_fetch_or() and atomic_long_fetch_andnot()
> exist.  :-)
> 
> When I went looking for documentation about why they do or this
> particular usage pattern found in the patch, I didn't find any --- at
> least, certainly not in the Documentation in the kernel sources.  The
> closest that I fond was this LWN article written by Neil Brown from
> 2016:
> 
> 	https://lwn.net/Articles/698315/
> 
> ... and this only covered the use atomic_fetch_or(); I wasn't able to
> find anything discussing atomic_fetch_andnot().
> 
> It looks like Peter Zijlstra added some bare-bones documentation in
> 2017, in commit: 706eeb3e9c6f ("Documentation/locking/atomic: Add
> documents for new atomic_t APIs") so we do have Documentation that
> these functions *exist*, but there is nothing explaining what they do,
> or how they can be used (e.g., in this rather clever way to set and
> clear a flag in the high bits of the nsec field).
> 
> I know that it's best to report missing documentation in the form of a
> patch, but I fear I don't have the time or the expertise to really do
> this topic justice, so I'd just thought I'd just note this lack for
> now, and maybe in my copious spare time I'll try to get at least
> something that will no doubt contain errors, but might inspire some
> folks to correct the text.  (Or maybe on someone on linux-doc will
> feel inspired and get there ahead of me.  :-)
> 

Paul already started the work:

	https://lore.kernel.org/lkml/19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop/

;-)

Regards,
Boqun

> 					- Ted
