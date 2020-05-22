Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB6C1DE92F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 16:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbgEVOoo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 10:44:44 -0400
Received: from foss.arm.com ([217.140.110.172]:36774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729868AbgEVOoo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 10:44:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D0F6D6E;
        Fri, 22 May 2020 07:44:43 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7513E3F68F;
        Fri, 22 May 2020 07:44:42 -0700 (PDT)
Date:   Fri, 22 May 2020 15:44:40 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [vfs:uaccess.net 16/19] net/atm/ioctl.c:180:29: sparse: sparse:
 Using plain integer as NULL pointer
Message-ID: <20200522144439.GC26492@gaia>
References: <202005222158.Heq0Iqum%lkp@intel.com>
 <20200522142321.GP23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522142321.GP23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 22, 2020 at 03:23:21PM +0100, Al Viro wrote:
> On Fri, May 22, 2020 at 09:58:00PM +0800, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.net
> > head:   0edecc020b33f8e31d8baa80735b45e8e8434700
> > commit: a3929484af75ee524419edbbc4e9ce012c3d67c9 [16/19] atm: move copyin from atm_getnames() into the caller
> > config: arm64-randconfig-s002-20200521 (attached as .config)
> > compiler: aarch64-linux-gcc (GCC) 9.3.0
> > reproduce:
> >         # apt-get install sparse
> >         # sparse version: v0.6.1-193-gb8fad4bc-dirty
> >         git checkout a3929484af75ee524419edbbc4e9ce012c3d67c9
> >         # save the attached .config to linux build tree
> >         make W=1 C=1 ARCH=arm64 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > 
> > sparse warnings: (new ones prefixed by >>)
> > 
> > >> net/atm/ioctl.c:180:29: sparse: sparse: Using plain integer as NULL pointer
> 
> Huh?
> 
> >  > 180				if (get_user(buf, &iobuf->buffer))
> 
> _what_ use of plain integer as a NULL pointer?  <looks>
> Misannotated get_user() on arm64 - should be
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 32fc8061aa76..bc5c7b091152 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -304,7 +304,7 @@ do {									\
>  		__p = uaccess_mask_ptr(__p);				\
>  		__raw_get_user((x), __p, (err));			\
>  	} else {							\
> -		(x) = 0; (err) = -EFAULT;				\
> +		(x) = (__force __typeof__(x))0; (err) = -EFAULT;	\
>  	}								\
>  } while (0)
>  
> and that's a _lot_ of noise in sparse logs on arm64, obviously - one for
> each get_user() of a pointer...

Thanks for pointing this out. We seem to do the right thing for
__raw_get_user() but missed one path in __get_user_error().

Since you wrote the patch already, are you ok for me to add some text
and your signed-off-by?

-- 
Catalin
