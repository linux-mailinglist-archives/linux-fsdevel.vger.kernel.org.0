Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E735B52664A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 17:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382112AbiEMPip (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 11:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353368AbiEMPin (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 11:38:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB70DF14;
        Fri, 13 May 2022 08:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v/c3xgIDZSG7sLprEPQVRNnfFwlIrO9OdkflwaOK6ZM=; b=Uo77FcJ3BqYtJHwKgb7MfJHKRw
        q5PxNMuRmpm6cBr3cTCMrBobW2ruAQNsG5xYUPYG7p3X4uah4VsZpCC19XgmlmHRmSSbDIEAhA+ou
        UOTWvKzDAFlvxs0GxI77lKb9nWuZXxzCzvY95Rt69hGLehSOBu5dIck0vXM+opIrH+WR5Xn7o3omu
        IszcPED66iVdZBM9ac0uCtZoS/jO88gl4KE6FrNkrcoBxIUntZd8y27bp9F39X++gF6gWk2RtClzy
        98Dvgy7dPQdoITkB9aqQaJ6jx6d8tx6hEt8ycMMEL5sCT9kymzVYn1+RsIRr69BpM2jn2f9KAZtiH
        Ks0AD77w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npXN9-00GjNh-MG; Fri, 13 May 2022 15:38:31 +0000
Date:   Fri, 13 May 2022 08:38:31 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v3 3/3] selftest: Taint kernel when test module loaded
Message-ID: <Yn57d1e6k8uv2uQj@bombadil.infradead.org>
References: <20220429043913.626647-1-davidgow@google.com>
 <20220513083212.3537869-3-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513083212.3537869-3-davidgow@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 13, 2022 at 04:32:13PM +0800, David Gow wrote:
> Make any kselftest test module (using the kselftest_module framework)
> taint the kernel with TAINT_TEST on module load.
> 
> Note that several selftests use kernel modules which are not based on
> the kselftest_module framework, and so will not automatically taint the
> kernel. These modules will have to be manually modified if they should
> taint the kernel this way.
> 
> Similarly, selftests which do not load modules into the kernel generally
> should not taint the kernel (or possibly should only do so on failure),
> as it's assumed that testing from user-space should be safe. Regardless,
> they can write to /proc/sys/kernel/tainted if required.
> 
> Signed-off-by: David Gow <davidgow@google.com>

Not all selftest modules use KSTM_MODULE_LOADERS() so I'd like to see a
modpost target as well, otherwise this just covers a sliver of
selftests.

  Luis
