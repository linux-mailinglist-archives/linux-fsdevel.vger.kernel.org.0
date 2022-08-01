Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC2258704D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 20:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbiHASSd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 14:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiHASSa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 14:18:30 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BFA286D7;
        Mon,  1 Aug 2022 11:18:29 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id b25so9008669qka.11;
        Mon, 01 Aug 2022 11:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=feedback-id:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aZNeN9+MdPNWv/80FGv0B2+b6ix8m0rC1xLUVxAPEro=;
        b=P+THs3+hpOJj+W+aciYujyHr6zELzS0hhs6oUwu7apuyILX9I22KmTnSiZ+EoKbo6y
         MrDFUl9QJ+IAUqsyUINEvFrHVhBHYQtKLtpTojRJ7TSLBXblJKGmz2HRQZhl6jlWtIjg
         ev+zL5tQIQ7FKMEqw7M5vMM2y73ETVKbs5xzAPxgwPjuieIDNWM27gOPu1WQVrwA5Mat
         O9YZ9ZNfr+Eel8VT8ihN3PRWAZddYhwTY5co1a5tiv5QKCCva4JQApbxgqMx19PhLinG
         HMoLWVKxFNY/JYqeoot8eQt42VsUNerx+EP7tnJlqX4a6wTgUQ+2iBzYQbaGfGkwIrxN
         oSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:feedback-id:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=aZNeN9+MdPNWv/80FGv0B2+b6ix8m0rC1xLUVxAPEro=;
        b=1K/gQcKiv5lSPsmgVdPHGYhFts5LAHQfW8X9j7/2lhDf1xVKsDTESbx4dkLfrTw6FH
         CUTWB2s3sgEzM+plPU5gCNQP+RnBBK/IFDprQWSlomVTbbJgv121QxV+dRtQcK/9l8ke
         eiBrsuH4U/x0F70K4lHDkLkJhkFRHrBnF7OCGRgPiAgasL8us+JofGcqVCdllf6b1J0Z
         zw6w790MiM6Brbja8CpKW2zldy+gEYbLdFtMdqmsZ4dFC1QEkHPXNQa6d2ae9O74rxb6
         Qc0HDrneh3pi7gas6GYtjz2SzvgU1Uu3saBRvMdCncf2477Cl+vPyO6Y+g6D8CQVDCEs
         SmbQ==
X-Gm-Message-State: AJIora+ZyB1JS0yyMMO7WsLzus9AoY9FVz1ZdJkdvBjrLUAzhn6xfWDz
        mkt3j2JCV901Bk0iPcbfFjM=
X-Google-Smtp-Source: AGRyM1tRvPLYzYlohmH7aiLSI1DvpK62DzmPttb0nhGWKoIwXgQ23iQSZDvpMI4HO1DM0fZcVrhnwg==
X-Received: by 2002:a37:42d6:0:b0:6b5:7da4:4cb2 with SMTP id p205-20020a3742d6000000b006b57da44cb2mr12620716qka.588.1659377908976;
        Mon, 01 Aug 2022 11:18:28 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id ay18-20020a05620a179200b006a8b6848556sm8886496qkb.7.2022.08.01.11.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 11:18:28 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id A8D3F27C0077;
        Mon,  1 Aug 2022 14:18:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 01 Aug 2022 14:18:27 -0400
X-ME-Sender: <xms:8hjoYp1SpVnlRtrnWMRO_i-sF_HV9DN58SB9aRhkF50_ClRrqaT-rg>
    <xme:8hjoYgFXT0o6WjWaVW9V2lrSEpUW2_bidKKqRisd7bQvQZiLTTXSXto5JckDxw1VZ
    DbbNtWMOGBRSnBq0g>
X-ME-Received: <xmr:8hjoYp5JP_aDk1qu-zjLTeASNgMnmfxOB_4MRZjTE5WSJNU8dBvQUTlY_Em5PA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvfedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:8hjoYm24oduREDGW2mEXN2905tyI-qkBaHL5rLwcvq9FNK1QhOX7bw>
    <xmx:8hjoYsE4TZbicSoAxF7bVBtrfdrToeaJXqqhPuQmlfPUPyiN1fL7LA>
    <xmx:8hjoYn8ssZDOZKOE5LXOQTBT5X-4Rf1vjinlAfFNWxTMDeqVgq-zSw>
    <xmx:8xjoYq8p2z0yqg5-tTjNLHaZc7ATswj9i3xC2EjsiMvq-R7-K7K4lA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Aug 2022 14:18:26 -0400 (EDT)
Date:   Mon, 1 Aug 2022 11:17:28 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] introduce test_bit_acquire and use it in
 wait_on_bit
Message-ID: <YugYuBzIkr+gN5Vi@boqun-archlinux>
References: <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com>
 <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
 <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311639360.21350@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wjA8HBrVqAqAetUvwNr=hcvhfnO7oMrOAd4V8bbSqokNA@mail.gmail.com>
 <alpine.LRH.2.02.2208010640260.22006@file01.intranet.prod.int.rdu2.redhat.com>
 <20220801155421.GB26280@willie-the-truck>
 <alpine.LRH.2.02.2208011206430.31960@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2208011206430.31960@file01.intranet.prod.int.rdu2.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 01, 2022 at 12:12:47PM -0400, Mikulas Patocka wrote:
> 
> 
> On Mon, 1 Aug 2022, Will Deacon wrote:
> 
> > On Mon, Aug 01, 2022 at 06:42:15AM -0400, Mikulas Patocka wrote:
> > 
> > > Index: linux-2.6/arch/x86/include/asm/bitops.h
> > > ===================================================================
> > > --- linux-2.6.orig/arch/x86/include/asm/bitops.h	2022-08-01 12:27:43.000000000 +0200
> > > +++ linux-2.6/arch/x86/include/asm/bitops.h	2022-08-01 12:27:43.000000000 +0200
> > > @@ -203,8 +203,10 @@ arch_test_and_change_bit(long nr, volati
> > >  
> > >  static __always_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
> > >  {
> > > -	return ((1UL << (nr & (BITS_PER_LONG-1))) &
> > > +	bool r = ((1UL << (nr & (BITS_PER_LONG-1))) &
> > >  		(addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
> > > +	barrier();
> > > +	return r;
> > 
> > Hmm, I find it a bit weird to have a barrier() here given that 'addr' is
> > volatile and we don't need a barrier() like this in the definition of
> > READ_ONCE(), for example.
> 
> gcc doesn't reorder two volatile accesses, but it can reorder non-volatile
> accesses around volatile accesses.
> 
> The purpose of the compiler barrier is to make sure that the non-volatile 
> accesses that follow test_bit are not reordered by the compiler before the 
> volatile access to addr.
> 

Better to have a constant_test_bit_acquire()? I don't think all
test_bit() call sites need the ordering?

Regards,
Boqun

> > > Index: linux-2.6/include/linux/wait_bit.h
> > > ===================================================================
> > > --- linux-2.6.orig/include/linux/wait_bit.h	2022-08-01 12:27:43.000000000 +0200
> > > +++ linux-2.6/include/linux/wait_bit.h	2022-08-01 12:27:43.000000000 +0200
> > > @@ -71,7 +71,7 @@ static inline int
> > >  wait_on_bit(unsigned long *word, int bit, unsigned mode)
> > >  {
> > >  	might_sleep();
> > > -	if (!test_bit(bit, word))
> > > +	if (!test_bit_acquire(bit, word))
> > >  		return 0;
> > >  	return out_of_line_wait_on_bit(word, bit,
> > >  				       bit_wait,
> > 
> > Yet another approach here would be to leave test_bit as-is and add a call to
> > smp_acquire__after_ctrl_dep() since that exists already -- I don't have
> > strong opinions about it, but it saves you having to add another stub to
> > x86.
> 
> It would be the same as my previous patch with smp_rmb() that Linus didn't 
> like. But I think smp_rmb (or smp_acquire__after_ctrl_dep) would be 
> correct here.
> 
> > Will
> 
> Mikulas
> 
