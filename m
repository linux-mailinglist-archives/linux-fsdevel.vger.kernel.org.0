Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3E51B8EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2019 16:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfEMOo7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 May 2019 10:44:59 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39167 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbfEMOo6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 May 2019 10:44:58 -0400
Received: by mail-ed1-f65.google.com with SMTP id e24so17925922edq.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2019 07:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oa11tgFM6isQYlc2/lSr8+dtL7dz0FGS2ImXszdei94=;
        b=lkK1jfdXRSWG4EOPXpNEsgoMZb8lUzm2FfYavTsrFBTY7w3Z4FVJ9cp/fBcnbUD9bK
         Frxw45KRQigXleUJaVccMl3gMpsrT0DKhj92T3OICo7PFH1ZWYiDKuhrJn4Bo6DXp0gB
         BN+9OOpk6LCzBYskBvabimkY7bAvWM5tFDS84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=oa11tgFM6isQYlc2/lSr8+dtL7dz0FGS2ImXszdei94=;
        b=L9sArnrQlEt1ucOjv6BMHMG7bg0Pvdu4nZTyYjnJ1yUwzlQRc7XtBiQ6ixFxtkIHwu
         dG/+JPedo5AD4ZTCBCRdtuqPqyGWHZttI+jMAUfADv7pl7y7Sq7aEmuzwWrDKaiImz/p
         TOrRGwhbV4NJynQ8mC4FMk/bhXbTWCAM6t7pN5LGxyfFjkIoxszIPXtmbokinovsIh+z
         OV0pi5ufrhl2EwV08033TCN4dDA3sx+d9IrXHc630c+IJaTSrgK1TNtLIeXCDO2gHNUk
         M+zBWOJVd/H98cPP1BP2aYq3fnRis1/k90qUyXGoynZ46NuuGgKsj010u30AA99fuugO
         Orig==
X-Gm-Message-State: APjAAAVUDxLmy0dJowfOTvSYUiDyf65Lg3lkJxLB7zjVxvO3d/JV8ZUK
        w3Psx98WPhIqdtHvZV85NnIwyA==
X-Google-Smtp-Source: APXvYqzazE/ARkr3DfLFYQv2UcXLE6AXccxEO07VmSzGlXapLczjo2jaDfA5V6TtDA06sVwBcw/rGw==
X-Received: by 2002:a17:906:18b1:: with SMTP id c17mr22862891ejf.196.1557758696660;
        Mon, 13 May 2019 07:44:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id ox15sm1844293ejb.52.2019.05.13.07.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 07:44:55 -0700 (PDT)
Date:   Mon, 13 May 2019 16:44:51 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Theodore Ts'o <tytso@mit.edu>,
        Frank Rowand <frowand.list@gmail.com>, Tim.Bird@sony.com,
        knut.omang@oracle.com, gregkh@linuxfoundation.org,
        brendanhiggins@google.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        robh@kernel.org, sboyd@kernel.org, shuah@kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, amir73il@gmail.com,
        dan.carpenter@oracle.com, dan.j.williams@intel.com,
        daniel@ffwll.ch, jdike@addtoit.com, joel@jms.id.au,
        julia.lawall@lip6.fr, khilman@baylibre.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, richard@nod.at,
        rientjes@google.com, rostedt@goodmis.org, wfg@linux.intel.com
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190513144451.GQ17751@phenom.ffwll.local>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Frank Rowand <frowand.list@gmail.com>, Tim.Bird@sony.com,
        knut.omang@oracle.com, gregkh@linuxfoundation.org,
        brendanhiggins@google.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org, robh@kernel.org,
        sboyd@kernel.org, shuah@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, jdike@addtoit.com, joel@jms.id.au,
        julia.lawall@lip6.fr, khilman@baylibre.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, richard@nod.at,
        rientjes@google.com, rostedt@goodmis.org, wfg@linux.intel.com
References: <20190509015856.GB7031@mit.edu>
 <580e092f-fa4e-eedc-9e9a-a57dd085f0a6@gmail.com>
 <20190509032017.GA29703@mit.edu>
 <7fd35df81c06f6eb319223a22e7b93f29926edb9.camel@oracle.com>
 <20190509133551.GD29703@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
 <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
 <20190509214233.GA20877@mit.edu>
 <80c72e64-2665-bd51-f78c-97f50f9a53ba@gmail.com>
 <20190511173344.GA8507@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190511173344.GA8507@mit.edu>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 11, 2019 at 01:33:44PM -0400, Theodore Ts'o wrote:
> On Fri, May 10, 2019 at 02:12:40PM -0700, Frank Rowand wrote:
> > However, the reply is incorrect.  Kselftest in-kernel tests (which
> > is the context here) can be configured as built in instead of as
> > a module, and built in a UML kernel.  The UML kernel can boot,
> > running the in-kernel tests before UML attempts to invoke the
> > init process.
> 
> Um, Citation needed?
> 
> I don't see any evidence for this in the kselftest documentation, nor
> do I see any evidence of this in the kselftest Makefiles.
> 
> There exists test modules in the kernel that run before the init
> scripts run --- but that's not strictly speaking part of kselftests,
> and do not have any kind of infrastructure.  As noted, the
> kselftests_harness header file fundamentally assumes that you are
> running test code in userspace.

Yeah I really like the "no userspace required at all" design of kunit,
while still collecting results in a well-defined way (unless the current
self-test that just run when you load the module, with maybe some
kselftest ad-hoc wrapper around to collect the results).

What I want to do long-term is to run these kernel unit tests as part of
the build-testing, most likely in gitlab (sooner or later, for drm.git
only ofc). So that people get their pull requests (and patch series, we
have some ideas to tie this into patchwork) automatically tested for this
super basic stuff.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
