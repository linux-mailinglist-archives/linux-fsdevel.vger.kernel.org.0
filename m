Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF23ED915B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 14:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393226AbfJPMrU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 08:47:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35552 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388855AbfJPMrU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:47:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id p30so14251363pgl.2;
        Wed, 16 Oct 2019 05:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rq3f4eSp8CIkVoHGSORWyEkMMIc3Sw4eQTsm9V9rf2g=;
        b=au50oT2NSPX7rC67A9Rgrd7RefLKrT2LB3kY/ByGZbTSuOf5ad2TOwoVDqAN9UIVyk
         mdXYIX73xCfCXSvyeyNmB+qAi28C52kNVnGyLTLJUQuZJx+Y0vSZngxrLqvAsTF8/SmD
         laMin8995YinlrUPOFqtbpLd5GglFMs1r9D8BwsC6cBdnnqY1coX6J+8kSqgSNXZ8qfd
         xdHPuDQQdFT9yRERBzgPuB5PzfDQM+MjSlcx+yr0PeWVb3diXN8ur55yCe+FynczCmAg
         ePWqc0/tWRasdYkj65C2f64x5k3PduW7tN8Iu3h4BEiib0KHyjLK8TGekRjicZcJm7lm
         0LXg==
X-Gm-Message-State: APjAAAUNF3aJGOwkcE8v4qrrvwlaabpkl1TQdtRmihe8LpRfMblmbPFZ
        R5wDvYJm4hjo9vr6F6h6ktc=
X-Google-Smtp-Source: APXvYqxXeJUjiiG3waBwmyhci4T1gcY8YNpB2uTrlbsBKl/glHPqm2PbQTCIMDpRZuX/+szbuVY8Kg==
X-Received: by 2002:a62:86c5:: with SMTP id x188mr45003130pfd.228.1571230037854;
        Wed, 16 Oct 2019 05:47:17 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id y138sm28615611pfb.174.2019.10.16.05.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 05:47:16 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id F3CBB40251; Wed, 16 Oct 2019 12:47:15 +0000 (UTC)
Date:   Wed, 16 Oct 2019 12:47:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     linux-kselftest@vger.kernel.org, brendanhiggins@google.com,
        skhan@linuxfoundation.org, keescook@chromium.org,
        yzaikin@google.com, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, catalin.marinas@arm.com,
        joe.lawrence@redhat.com, penguin-kernel@i-love.sakura.ne.jp,
        schowdary@nvidia.com, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com, changbin.du@intel.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 linux-kselftest-test 0/3] kunit: support building
 core/tests as modules
Message-ID: <20191016124715.GG16384@42.do-not-panic.com>
References: <1570546546-549-1-git-send-email-alan.maguire@oracle.com>
 <20191014092051.GZ16384@42.do-not-panic.com>
 <alpine.LRH.2.20.1910141452470.6620@dhcp-10-175-191-179.vpn.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.1910141452470.6620@dhcp-10-175-191-179.vpn.oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 14, 2019 at 03:02:03PM +0100, Alan Maguire wrote:
> 
> 
> On Mon, 14 Oct 2019, Luis Chamberlain wrote:
> 
> > On Tue, Oct 08, 2019 at 03:55:43PM +0100, Alan Maguire wrote:
> > > The current kunit execution model is to provide base kunit functionality
> > > and tests built-in to the kernel.  The aim of this series is to allow
> > > building kunit itself and tests as modules.  This in turn allows a
> > > simple form of selective execution; load the module you wish to test.
> > > In doing so, kunit itself (if also built as a module) will be loaded as
> > > an implicit dependency.
> > > 
> > > Because this requires a core API modification - if a module delivers
> > > multiple suites, they must be declared with the kunit_test_suites()
> > > macro - we're proposing this patch as a candidate to be applied to the
> > > test tree before too many kunit consumers appear.  We attempt to deal
> > > with existing consumers in patch 1.
> > 
> > This is neat and makes sense to me.
> 
> Thanks for taking a look!
> 
> > However the ordering of the patches
> > seems odd. If modules depend on kunit module, then shouldn't that go
> > first? Ie, we want this to be bisectable in proper order.
> > 
> 
> The reasoning here is it seemed a more likely scenario that users mught  
> build kunit built-in (CONFIG_KUNIT=y) along with test suites built as 
> modules (CONFIG_KUNIT_TEST=m). So the intermediate state after patch 2 - 
> tests buildable as modules while kunit is still built-in-only - made more 
> sense to me as something users might do in practice so that's why I 
> ordered things that way.  I'm working on a new revision of the patchset
> though, so if you feel strongly about this shout and I'll try and accommodate
> the alternative ordering.

No, that makes sense. All good.

  Luis
