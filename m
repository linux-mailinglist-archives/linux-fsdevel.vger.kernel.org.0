Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194EF4DB8FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 20:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352544AbiCPTop (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 15:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350714AbiCPToo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 15:44:44 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B2931DD3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Mar 2022 12:43:29 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o6-20020a17090a9f8600b001c6562049d9so3454335pjp.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Mar 2022 12:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5Lsesd4geEy+OxiAxv5CZvVix7krp+znGCLh0h58LQQ=;
        b=A5Y8YgUHZ4q/v2ppXjlqk2V0UvHW6eaS3oI540GowPw4Rg4rkzk8n83CQWwCN4PwLH
         sGQ7yJrlAHCaXecCaveWol/CvAT1+ym0IzR6rtjcdwNinDCEQ8iUvL6zISggcXA+/PDd
         jOwmupDT1DHOqVXDRBaphTKyHnf9L9QSFDlkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Lsesd4geEy+OxiAxv5CZvVix7krp+znGCLh0h58LQQ=;
        b=kUcO87vQtOkfbWVpo1VYqimOMkJqZAgsDIccRpM2URBJe3qFSIitcfXgpkR2lPtXhg
         9cCk5ZGGoQwsCglAHpWnGJlIE61HKVP+UW6uQioZkZtLjJWP59PlRnsXJAZ4F4LOYdY+
         SF8tpAM4dxswfijYZYopJ9h5jYVArTnRQPXfZFT1DDJcaoNWNMHY4ApCsowucbzSaCtW
         QqdtdizpXdOkLRszG/S03QNjZSQugLJ8AxJ5lVKdFYWtxKZLIynmUy662InFcldA2wOI
         xMpG3d1BJhqF83KAVU2PMemCD/cCDNMauHgSdzb/UA4Oag9UNYeMAeOmpX03pwjM6KHa
         P1bg==
X-Gm-Message-State: AOAM533VbEqnPgvk+KrKn560AKAE5taJcQfoRhJind9Nu9qtzoqK0G9c
        0ipfeSJZb3dIMSiyh4EV/ai3MA==
X-Google-Smtp-Source: ABdhPJwTsiisig0ooC5KbKK43+q6Y3t0K+1gFx5q5/eUAq1cLeCUs1jegAMND9IuFBl7oow0IG0FQw==
X-Received: by 2002:a17:902:d511:b0:153:a664:bb3b with SMTP id b17-20020a170902d51100b00153a664bb3bmr1195795plg.147.1647459808663;
        Wed, 16 Mar 2022 12:43:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 18-20020a17090a001200b001c6320f8581sm3418064pja.31.2022.03.16.12.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 12:43:28 -0700 (PDT)
Date:   Wed, 16 Mar 2022 12:43:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH 1/3] x86: Separate out x86_regset for 32 and 64 bit
Message-ID: <202203161242.E778E35E8@keescook>
References: <20220315201706.7576-1-rick.p.edgecombe@intel.com>
 <20220315201706.7576-2-rick.p.edgecombe@intel.com>
 <202203151340.7447F75BDC@keescook>
 <fe7ce2ae1011b240e3a6ee8b0425ff3e2c675b6d.camel@intel.com>
 <202203151948.E5076F4BB@keescook>
 <b5f9ce3c70d202834e0a76ed30966e2c81eb28dc.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5f9ce3c70d202834e0a76ed30966e2c81eb28dc.camel@intel.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 16, 2022 at 07:06:48PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2022-03-15 at 19:48 -0700, Kees Cook wrote:
> > On Tue, Mar 15, 2022 at 09:53:13PM +0000, Edgecombe, Rick P wrote:
> > > On Tue, 2022-03-15 at 13:41 -0700, Kees Cook wrote:
> > > > Have you verified there's no binary difference in machine code
> > > > output?
> > > 
> > > There actually was a different in the binaries. I investigated a
> > > bit,
> > > and it seemed at least part of it was due to the line numbers
> > > changing
> > > the WARN_ON()s. But otherwise, I assumed some compiler optimization
> > > must have been bumped.
> > 
> > Right, you can ignore all the debugging line number changes.
> > "diffoscope" should help see the difference by section. As long as
> > the
> > actual object code isn't changing, you should be good.
> 
> What I did originally was objdump -D ptrace.o and diff that. Then I
> slowly reduced changes to see what was generating the difference. When
> I maintained the line numbers from the original version, and simply
> converted the enum to defines, it still generated slightly different
> code in places that didn't seem to connected to the changes. So I
> figured the compiler was doing something, and relied on checking that
> the actual constants didn't change in value.
> 
> This morning I tried again to figure out what was causing the
> difference. If I strip debug symbols, remove the BUILD_BUG_ON()s and
> reformat the enums such that the line numbers are the same below the
> enums then the objdump output is identical.
> 
> I think what is happening in this debug stripped test, is that in the
> call's to put_user(), it calls might_fault(), which has a __LINE__.
> 
> But even adding a comment to the base file has surprisingly wide
> effects. It caused the __bug_table section table to get code generated
> with different instructions, not just line numbers constants changing.
> 
> So I think there should be no functional change, but the binaries are
> not identical.

Right, that's fine: the instructions should be the same, just with
various different offsets.

-- 
Kees Cook
