Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE381DE8B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 16:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbgEVOX3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 10:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbgEVOX3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 10:23:29 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44504C061A0E
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 07:23:29 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jc8a1-00DXPx-Di; Fri, 22 May 2020 14:23:21 +0000
Date:   Fri, 22 May 2020 15:23:21 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [vfs:uaccess.net 16/19] net/atm/ioctl.c:180:29: sparse: sparse:
 Using plain integer as NULL pointer
Message-ID: <20200522142321.GP23230@ZenIV.linux.org.uk>
References: <202005222158.Heq0Iqum%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005222158.Heq0Iqum%lkp@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 22, 2020 at 09:58:00PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.net
> head:   0edecc020b33f8e31d8baa80735b45e8e8434700
> commit: a3929484af75ee524419edbbc4e9ce012c3d67c9 [16/19] atm: move copyin from atm_getnames() into the caller
> config: arm64-randconfig-s002-20200521 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-193-gb8fad4bc-dirty
>         git checkout a3929484af75ee524419edbbc4e9ce012c3d67c9
>         # save the attached .config to linux build tree
>         make W=1 C=1 ARCH=arm64 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
> >> net/atm/ioctl.c:180:29: sparse: sparse: Using plain integer as NULL pointer

Huh?

>  > 180				if (get_user(buf, &iobuf->buffer))

_what_ use of plain integer as a NULL pointer?  <looks>
Misannotated get_user() on arm64 - should be
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 32fc8061aa76..bc5c7b091152 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -304,7 +304,7 @@ do {									\
 		__p = uaccess_mask_ptr(__p);				\
 		__raw_get_user((x), __p, (err));			\
 	} else {							\
-		(x) = 0; (err) = -EFAULT;				\
+		(x) = (__force __typeof__(x))0; (err) = -EFAULT;	\
 	}								\
 } while (0)
 
and that's a _lot_ of noise in sparse logs on arm64, obviously - one for
each get_user() of a pointer...
