Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDFED5E9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2019 11:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbfJNJU4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 05:20:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45887 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730656AbfJNJU4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:20:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1so8551413pgj.12;
        Mon, 14 Oct 2019 02:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z80QF2P/utfSJTosq14dGOZH3U5rnspzRIHN6J5xfow=;
        b=jorZTQXiOxg4InwNM34RTj+HGp8ns6ZEAQ8lIGJmTY1W7sK/dLdtN+/kHo9AWSzfxA
         q6qkIqC2NaAszGLbX+Gas/r+otb34B3WbcYD8W2Z45EVlQNDcZn5p6RO/+HtoyR7rYnN
         U9AEdq3o8YuHyEoaCXOF7HI8XgfgZdOdVOhSy6YCEykpxl8ayOWKflp61U+VdswHlTBc
         TGg/3FVTotloiF4hPDyFakvWxmjU2+Nq93AAqN43l6xf6LeZlZdLWyy5mCmyKNcyvNqk
         ww4VF5SOAjU89B0eOyG16Jn1A8QnIy/vkNAcNnj0U8ip6xZkKMPcWE9PnGP/6AzRCDr3
         Roiw==
X-Gm-Message-State: APjAAAUwCOybWzIXVT0IY7DHaZnmQgLbgXOlo1ix9ybwKH8+0XSRiRZk
        iNLaP39/gvRnyF+YQwbmkWQ=
X-Google-Smtp-Source: APXvYqzOPBH0WekcHZOXSoperMZAmy+14kCD91/1ZTagF7IA+gkuA3HNJe3CMO2I1E8cjDyeEkd/Uw==
X-Received: by 2002:a17:90a:741:: with SMTP id s1mr35956209pje.113.1571044853994;
        Mon, 14 Oct 2019 02:20:53 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id y2sm19146917pfe.126.2019.10.14.02.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 02:20:52 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C92B94021A; Mon, 14 Oct 2019 09:20:51 +0000 (UTC)
Date:   Mon, 14 Oct 2019 09:20:51 +0000
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
Message-ID: <20191014092051.GZ16384@42.do-not-panic.com>
References: <1570546546-549-1-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570546546-549-1-git-send-email-alan.maguire@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 03:55:43PM +0100, Alan Maguire wrote:
> The current kunit execution model is to provide base kunit functionality
> and tests built-in to the kernel.  The aim of this series is to allow
> building kunit itself and tests as modules.  This in turn allows a
> simple form of selective execution; load the module you wish to test.
> In doing so, kunit itself (if also built as a module) will be loaded as
> an implicit dependency.
> 
> Because this requires a core API modification - if a module delivers
> multiple suites, they must be declared with the kunit_test_suites()
> macro - we're proposing this patch as a candidate to be applied to the
> test tree before too many kunit consumers appear.  We attempt to deal
> with existing consumers in patch 1.

This is neat and makes sense to me. However the ordering of the patches
seems odd. If modules depend on kunit module, then shouldn't that go
first? Ie, we want this to be bisectable in proper order.

  Luis
