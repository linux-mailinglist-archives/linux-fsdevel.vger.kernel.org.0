Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25495117E1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 13:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfEBLDv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 07:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfEBLDu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 07:03:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4209320656;
        Thu,  2 May 2019 11:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556795029;
        bh=O3tfI3pqzOj0bEmXd9MUeZFrQfwB6jIaKEbV4O7x7Bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cpMMab1CbtEf7/ukbOdl3ygxOXLRXxfMRGPprF4sj5SCCaW5OE96hyghMd3SOS2/O
         704jRirIDOFY4nx9V3U5D+VWDZoHX2Dr8aOg1DMDp0dkWxjxEJNwlIk5qgnR1l74hy
         2ADDJONY2mvp2Xafc2iurhiMmE86VmsCoHu18VkU=
Date:   Thu, 2 May 2019 13:03:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     frowand.list@gmail.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        robh@kernel.org, sboyd@kernel.org, shuah@kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com,
        Iurii Zaikin <yzaikin@google.com>
Subject: Re: [PATCH v2 16/17] kernel/sysctl-test: Add null pointer test for
 sysctl.c:proc_dointvec()
Message-ID: <20190502110347.GE12416@kroah.com>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-17-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501230126.229218-17-brendanhiggins@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 01, 2019 at 04:01:25PM -0700, Brendan Higgins wrote:
> From: Iurii Zaikin <yzaikin@google.com>
> 
> KUnit tests for initialized data behavior of proc_dointvec that is
> explicitly checked in the code. Includes basic parsing tests including
> int min/max overflow.
> 
> Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  kernel/Makefile      |   2 +
>  kernel/sysctl-test.c | 292 +++++++++++++++++++++++++++++++++++++++++++
>  lib/Kconfig.debug    |   6 +
>  3 files changed, 300 insertions(+)
>  create mode 100644 kernel/sysctl-test.c
> 
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 6c57e78817dad..c81a8976b6a4b 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -112,6 +112,8 @@ obj-$(CONFIG_HAS_IOMEM) += iomem.o
>  obj-$(CONFIG_ZONE_DEVICE) += memremap.o
>  obj-$(CONFIG_RSEQ) += rseq.o
>  
> +obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o

You are going to have to have a "standard" naming scheme for test
modules, are you going to recommend "foo-test" over "test-foo"?  If so,
that's fine, we should just be consistant and document it somewhere.

Personally, I'd prefer "test-foo", but that's just me, naming is hard...

thanks,

greg k-h
