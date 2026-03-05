Return-Path: <linux-fsdevel+bounces-79460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKw+Ec47qWld3QAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 09:16:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E86C20D513
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 09:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFE7030D638B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 08:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D35366DA8;
	Thu,  5 Mar 2026 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VXTLpQmJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2AE36681F;
	Thu,  5 Mar 2026 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772698305; cv=none; b=QnA0cBiGTHWl0F/qp/qAd/Qu0U6WiT1ijtdRid/UzhunHC9u+d13M8iGyeOAMjDQVKN1WwV8ViwsgY45J+MxxbK+N1GglX1nGFrIL11KlaBYGuSmmQYUaUwS+S7FeUxx/1izCF2yq1pdknCkT8E/ta+Vhqui/Nk9NmdBki60CjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772698305; c=relaxed/simple;
	bh=C5zLzfyENBPlFTeplVQUbZ2qMCLm6d9LophjVLEMU3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dM6CsIgZBv/1xxFNkzm8lwDwXANusS6E51KCr8hnuNsq2S0yzeF9SAKoRL2YsPiefUjkmij/1Z2wV1jnrnmhEhWN54BGDJ23cRGlNLkbjwshw2WM3Tidp2nN8y6IhxvPARKMP61V6sMVBiDxJLZp3B+eAdBEs5odAnXTOqY0DDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VXTLpQmJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772698303; x=1804234303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C5zLzfyENBPlFTeplVQUbZ2qMCLm6d9LophjVLEMU3A=;
  b=VXTLpQmJHG92vBtVMYGPnI5qAzTPeyk7AXDtVuzClivkeIYohIPbNIQc
   2v+HQHBSGAxuMF59z4qkUANjLJRYZKUWhG4VbAB2S54PZbJM36FivJHfQ
   lupu2h+Xwr5bt1Blgt6D249STAdlfWuI19v8rHep9g+dNqiL9TN+Upo8R
   /M2LJ0ERyAMPyNVUcyYgdiYq9TKTqz33XoVh5eLGRwXwWSB+AznGKfqym
   myF7qiQIsVm+qnflXdUbWePCA1+zbY0GcAOiOFRFFdHOHWaEgyqW/352F
   e4R9T22cwhzDAESYUA+BtW2xsiOM48d9Zdob0jx8Vaotv81JEAeyKAo/b
   Q==;
X-CSE-ConnectionGUID: Dx7ljyijT4iehcQRIwIYzA==
X-CSE-MsgGUID: wx7ODEFJRD6ct+pTeUlNXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="77621895"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="77621895"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 00:11:42 -0800
X-CSE-ConnectionGUID: Iw4uhjOiRf+rxsmGmxlWiA==
X-CSE-MsgGUID: 1kllHXJpTTC5o4nRplKxbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="216418398"
Received: from lkp-server01.sh.intel.com (HELO cadc4577a874) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 05 Mar 2026 00:11:36 -0800
Received: from kbuild by cadc4577a874 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vy3nv-000000000Gs-3xwF;
	Thu, 05 Mar 2026 08:11:31 +0000
Date: Thu, 5 Mar 2026 16:10:36 +0800
From: kernel test robot <lkp@intel.com>
To: david.laight.linux@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>,
	Andre Almeida <andrealmeid@igalia.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Heiko Carstens <hca@linux.ibm.com>, Jan Kara <jack@suse.cz>,
	Julia Lawall <julia.lawall@inria.fr>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] uaccess: Disable -Wshadow in
 __scoped_user_access()
Message-ID: <202603051642.i46zzlJ8-lkp@intel.com>
References: <20260302132755.1475451-5-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302132755.1475451-5-david.laight.linux@gmail.com>
X-Rspamd-Queue-Id: 9E86C20D513
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79460-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,zeniv.linux.org.uk,igalia.com,citrix.com,linux.ibm.com,kernel.org,csgroup.eu,infradead.org,stgolabs.net,suse.cz,inria.fr,linux-foundation.org,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,efficios.com,ellerman.id.au,imag.fr,dabbelt.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,01.org:url]
X-Rspamd-Action: no action

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on v7.0-rc2]
[cannot apply to linus/master next-20260303]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/david-laight-linux-gmail-com/uaccess-Fix-scoped_user_read_access-for-pointer-to-const/20260302-213317
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20260302132755.1475451-5-david.laight.linux%40gmail.com
patch subject: [PATCH v2 4/5] uaccess: Disable -Wshadow in __scoped_user_access()
config: nios2-allnoconfig (https://download.01.org/0day-ci/archive/20260305/202603051642.i46zzlJ8-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260305/202603051642.i46zzlJ8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603051642.i46zzlJ8-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/asm-generic/div64.h:27,
                    from ./arch/nios2/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/time.h:6,
                    from include/linux/compat.h:10,
                    from kernel/futex/core.c:34:
   kernel/futex/futex.h: In function 'futex_get_value_locked':
>> include/linux/uaccess.h:740:20: warning: unused variable '_tmpptr' [-Wunused-variable]
     740 |         with (auto _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl))        \
         |                    ^~~~~~~
   include/linux/compiler.h:396:14: note: in definition of macro 'and_with'
     396 |         for (declaration; !_with_done; _with_done = true)
         |              ^~~~~~~~~~~
   include/linux/uaccess.h:740:9: note: in expansion of macro 'with'
     740 |         with (auto _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl))        \
         |         ^~~~
   include/linux/uaccess.h:755:9: note: in expansion of macro '__scoped_user_access'
     755 |         __scoped_user_access(read, usrc, size, elbl)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:767:9: note: in expansion of macro 'scoped_user_read_access_size'
     767 |         scoped_user_read_access_size(usrc, sizeof(*(usrc)), elbl)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:831:9: note: in expansion of macro 'scoped_user_read_access'
     831 |         scoped_user_read_access(_tmpsrc, efault)                \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/futex/futex.h:288:16: note: in expansion of macro 'get_user_inline'
     288 |         return get_user_inline(*dest, from);
         |                ^~~~~~~~~~~~~~~
>> include/linux/compiler.h:396:9: warning: this 'for' clause does not guard... [-Wmisleading-indentation]
     396 |         for (declaration; !_with_done; _with_done = true)
         |         ^~~
   include/linux/compiler.h:394:17: note: in expansion of macro 'and_with'
     394 |                 and_with (declaration)
         |                 ^~~~~~~~
   include/linux/uaccess.h:740:9: note: in expansion of macro 'with'
     740 |         with (auto _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl))        \
         |         ^~~~
   include/linux/uaccess.h:755:9: note: in expansion of macro '__scoped_user_access'
     755 |         __scoped_user_access(read, usrc, size, elbl)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:767:9: note: in expansion of macro 'scoped_user_read_access_size'
     767 |         scoped_user_read_access_size(usrc, sizeof(*(usrc)), elbl)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:831:9: note: in expansion of macro 'scoped_user_read_access'
     831 |         scoped_user_read_access(_tmpsrc, efault)                \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/futex/futex.h:288:16: note: in expansion of macro 'get_user_inline'
     288 |         return get_user_inline(*dest, from);
         |                ^~~~~~~~~~~~~~~
   In file included from include/linux/compiler_types.h:173,
                    from <command-line>:
   include/linux/compiler-gcc.h:118:33: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'for'
     118 | #define __diag(s)               _Pragma(__diag_str(GCC diagnostic s))
         |                                 ^~~~~~~
   include/linux/compiler-gcc.h:129:9: note: in expansion of macro '__diag'
     129 |         __diag(__diag_GCC_ignore option)
         |         ^~~~~~
   include/linux/uaccess.h:742:31: note: in expansion of macro '__diag_ignore_all'
     742 |                 __diag_push() __diag_ignore_all("-Wshadow", "uptr is readonly copy")    \
         |                               ^~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:755:9: note: in expansion of macro '__scoped_user_access'
     755 |         __scoped_user_access(read, usrc, size, elbl)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:767:9: note: in expansion of macro 'scoped_user_read_access_size'
     767 |         scoped_user_read_access_size(usrc, sizeof(*(usrc)), elbl)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:831:9: note: in expansion of macro 'scoped_user_read_access'
     831 |         scoped_user_read_access(_tmpsrc, efault)                \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/futex/futex.h:288:16: note: in expansion of macro 'get_user_inline'
     288 |         return get_user_inline(*dest, from);
         |                ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/div64.h:27,
                    from ./arch/nios2/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/time.h:6,
                    from include/linux/compat.h:10,
                    from kernel/futex/core.c:34:
>> include/linux/uaccess.h:743:90: error: '_tmpptr' undeclared (first use in this function)
     743 |                 and_with (const auto uptr __cleanup(__scoped_user_##mode##_access_end) = _tmpptr) \
         |                                                                                          ^~~~~~~
   include/linux/compiler.h:396:14: note: in definition of macro 'and_with'
     396 |         for (declaration; !_with_done; _with_done = true)
         |              ^~~~~~~~~~~
   include/linux/uaccess.h:755:9: note: in expansion of macro '__scoped_user_access'
     755 |         __scoped_user_access(read, usrc, size, elbl)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:767:9: note: in expansion of macro 'scoped_user_read_access_size'
     767 |         scoped_user_read_access_size(usrc, sizeof(*(usrc)), elbl)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:831:9: note: in expansion of macro 'scoped_user_read_access'
     831 |         scoped_user_read_access(_tmpsrc, efault)                \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/futex/futex.h:288:16: note: in expansion of macro 'get_user_inline'
     288 |         return get_user_inline(*dest, from);
         |                ^~~~~~~~~~~~~~~
   include/linux/uaccess.h:743:90: note: each undeclared identifier is reported only once for each function it appears in
     743 |                 and_with (const auto uptr __cleanup(__scoped_user_##mode##_access_end) = _tmpptr) \
         |                                                                                          ^~~~~~~
   include/linux/compiler.h:396:14: note: in definition of macro 'and_with'
     396 |         for (declaration; !_with_done; _with_done = true)
         |              ^~~~~~~~~~~
   include/linux/uaccess.h:755:9: note: in expansion of macro '__scoped_user_access'
     755 |         __scoped_user_access(read, usrc, size, elbl)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:767:9: note: in expansion of macro 'scoped_user_read_access_size'
     767 |         scoped_user_read_access_size(usrc, sizeof(*(usrc)), elbl)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:831:9: note: in expansion of macro 'scoped_user_read_access'
     831 |         scoped_user_read_access(_tmpsrc, efault)                \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/futex/futex.h:288:16: note: in expansion of macro 'get_user_inline'
     288 |         return get_user_inline(*dest, from);
         |                ^~~~~~~~~~~~~~~
>> include/linux/compiler.h:396:28: error: '_with_done' undeclared (first use in this function)
     396 |         for (declaration; !_with_done; _with_done = true)
         |                            ^~~~~~~~~~
   include/linux/uaccess.h:743:17: note: in expansion of macro 'and_with'
     743 |                 and_with (const auto uptr __cleanup(__scoped_user_##mode##_access_end) = _tmpptr) \
         |                 ^~~~~~~~
   include/linux/uaccess.h:755:9: note: in expansion of macro '__scoped_user_access'
     755 |         __scoped_user_access(read, usrc, size, elbl)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:767:9: note: in expansion of macro 'scoped_user_read_access_size'
     767 |         scoped_user_read_access_size(usrc, sizeof(*(usrc)), elbl)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:831:9: note: in expansion of macro 'scoped_user_read_access'
     831 |         scoped_user_read_access(_tmpsrc, efault)                \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/futex/futex.h:288:16: note: in expansion of macro 'get_user_inline'
     288 |         return get_user_inline(*dest, from);
         |                ^~~~~~~~~~~~~~~
   kernel/futex/core.c: In function 'get_futex_key':
>> include/linux/uaccess.h:740:20: warning: unused variable '_tmpptr' [-Wunused-variable]
     740 |         with (auto _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl))        \
         |                    ^~~~~~~
   include/linux/compiler.h:396:14: note: in definition of macro 'and_with'
     396 |         for (declaration; !_with_done; _with_done = true)
         |              ^~~~~~~~~~~
   include/linux/uaccess.h:740:9: note: in expansion of macro 'with'
     740 |         with (auto _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl))        \
         |         ^~~~
   include/linux/uaccess.h:755:9: note: in expansion of macro '__scoped_user_access'
     755 |         __scoped_user_access(read, usrc, size, elbl)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:767:9: note: in expansion of macro 'scoped_user_read_access_size'
     767 |         scoped_user_read_access_size(usrc, sizeof(*(usrc)), elbl)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:831:9: note: in expansion of macro 'scoped_user_read_access'
     831 |         scoped_user_read_access(_tmpsrc, efault)                \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/futex/core.c:584:21: note: in expansion of macro 'get_user_inline'
     584 |                 if (get_user_inline(node, naddr))
         |                     ^~~~~~~~~~~~~~~
>> include/linux/compiler.h:396:9: warning: this 'for' clause does not guard... [-Wmisleading-indentation]
     396 |         for (declaration; !_with_done; _with_done = true)
         |         ^~~
   include/linux/compiler.h:394:17: note: in expansion of macro 'and_with'
     394 |                 and_with (declaration)
         |                 ^~~~~~~~
   include/linux/uaccess.h:740:9: note: in expansion of macro 'with'
     740 |         with (auto _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl))        \
         |         ^~~~
   include/linux/uaccess.h:755:9: note: in expansion of macro '__scoped_user_access'
     755 |         __scoped_user_access(read, usrc, size, elbl)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:767:9: note: in expansion of macro 'scoped_user_read_access_size'
     767 |         scoped_user_read_access_size(usrc, sizeof(*(usrc)), elbl)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:831:9: note: in expansion of macro 'scoped_user_read_access'
     831 |         scoped_user_read_access(_tmpsrc, efault)                \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/futex/core.c:584:21: note: in expansion of macro 'get_user_inline'
     584 |                 if (get_user_inline(node, naddr))
         |                     ^~~~~~~~~~~~~~~
   In file included from include/linux/compiler_types.h:173,
                    from <command-line>:
   include/linux/compiler-gcc.h:118:33: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'for'
     118 | #define __diag(s)               _Pragma(__diag_str(GCC diagnostic s))
         |                                 ^~~~~~~
   include/linux/compiler-gcc.h:129:9: note: in expansion of macro '__diag'
     129 |         __diag(__diag_GCC_ignore option)
         |         ^~~~~~
   include/linux/uaccess.h:742:31: note: in expansion of macro '__diag_ignore_all'
     742 |                 __diag_push() __diag_ignore_all("-Wshadow", "uptr is readonly copy")    \
         |                               ^~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:755:9: note: in expansion of macro '__scoped_user_access'
     755 |         __scoped_user_access(read, usrc, size, elbl)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:767:9: note: in expansion of macro 'scoped_user_read_access_size'
     767 |         scoped_user_read_access_size(usrc, sizeof(*(usrc)), elbl)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:831:9: note: in expansion of macro 'scoped_user_read_access'
     831 |         scoped_user_read_access(_tmpsrc, efault)                \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/futex/core.c:584:21: note: in expansion of macro 'get_user_inline'
     584 |                 if (get_user_inline(node, naddr))
         |                     ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/div64.h:27,
                    from ./arch/nios2/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/time.h:6,
                    from include/linux/compat.h:10,
                    from kernel/futex/core.c:34:
>> include/linux/uaccess.h:743:90: error: '_tmpptr' undeclared (first use in this function)
     743 |                 and_with (const auto uptr __cleanup(__scoped_user_##mode##_access_end) = _tmpptr) \
         |                                                                                          ^~~~~~~
   include/linux/compiler.h:396:14: note: in definition of macro 'and_with'
     396 |         for (declaration; !_with_done; _with_done = true)
         |              ^~~~~~~~~~~
   include/linux/uaccess.h:755:9: note: in expansion of macro '__scoped_user_access'
     755 |         __scoped_user_access(read, usrc, size, elbl)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:767:9: note: in expansion of macro 'scoped_user_read_access_size'
     767 |         scoped_user_read_access_size(usrc, sizeof(*(usrc)), elbl)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:831:9: note: in expansion of macro 'scoped_user_read_access'
     831 |         scoped_user_read_access(_tmpsrc, efault)                \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/futex/core.c:584:21: note: in expansion of macro 'get_user_inline'
     584 |                 if (get_user_inline(node, naddr))
         |                     ^~~~~~~~~~~~~~~
>> include/linux/compiler.h:396:28: error: '_with_done' undeclared (first use in this function)
     396 |         for (declaration; !_with_done; _with_done = true)
         |                            ^~~~~~~~~~
   include/linux/uaccess.h:743:17: note: in expansion of macro 'and_with'
     743 |                 and_with (const auto uptr __cleanup(__scoped_user_##mode##_access_end) = _tmpptr) \
         |                 ^~~~~~~~
   include/linux/uaccess.h:755:9: note: in expansion of macro '__scoped_user_access'
     755 |         __scoped_user_access(read, usrc, size, elbl)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:767:9: note: in expansion of macro 'scoped_user_read_access_size'
     767 |         scoped_user_read_access_size(usrc, sizeof(*(usrc)), elbl)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:831:9: note: in expansion of macro 'scoped_user_read_access'
     831 |         scoped_user_read_access(_tmpsrc, efault)                \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/futex/core.c:584:21: note: in expansion of macro 'get_user_inline'
     584 |                 if (get_user_inline(node, naddr))
         |                     ^~~~~~~~~~~~~~~
>> include/linux/uaccess.h:740:20: warning: unused variable '_tmpptr' [-Wunused-variable]
     740 |         with (auto _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl))        \
         |                    ^~~~~~~
   include/linux/compiler.h:396:14: note: in definition of macro 'and_with'
     396 |         for (declaration; !_with_done; _with_done = true)
         |              ^~~~~~~~~~~
   include/linux/uaccess.h:740:9: note: in expansion of macro 'with'
     740 |         with (auto _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl))        \
         |         ^~~~
   include/linux/uaccess.h:778:9: note: in expansion of macro '__scoped_user_access'
     778 |         __scoped_user_access(write, udst, size, elbl)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:790:9: note: in expansion of macro 'scoped_user_write_access_size'
     790 |         scoped_user_write_access_size(udst, sizeof(*(udst)), elbl)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:856:9: note: in expansion of macro 'scoped_user_write_access'
     856 |         scoped_user_write_access(_tmpdst, efault)               \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/futex/core.c:604:37: note: in expansion of macro 'put_user_inline'
     604 |                 if (node_updated && put_user_inline(node, naddr))
         |                                     ^~~~~~~~~~~~~~~
>> include/linux/compiler.h:396:9: warning: this 'for' clause does not guard... [-Wmisleading-indentation]
     396 |         for (declaration; !_with_done; _with_done = true)
         |         ^~~
   include/linux/compiler.h:394:17: note: in expansion of macro 'and_with'
     394 |                 and_with (declaration)
         |                 ^~~~~~~~
   include/linux/uaccess.h:740:9: note: in expansion of macro 'with'
     740 |         with (auto _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl))        \
         |         ^~~~
   include/linux/uaccess.h:778:9: note: in expansion of macro '__scoped_user_access'
     778 |         __scoped_user_access(write, udst, size, elbl)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:790:9: note: in expansion of macro 'scoped_user_write_access_size'
     790 |         scoped_user_write_access_size(udst, sizeof(*(udst)), elbl)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:856:9: note: in expansion of macro 'scoped_user_write_access'
     856 |         scoped_user_write_access(_tmpdst, efault)               \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/futex/core.c:604:37: note: in expansion of macro 'put_user_inline'
     604 |                 if (node_updated && put_user_inline(node, naddr))
         |                                     ^~~~~~~~~~~~~~~
   In file included from include/linux/compiler_types.h:173,
                    from <command-line>:
   include/linux/compiler-gcc.h:118:33: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'for'
     118 | #define __diag(s)               _Pragma(__diag_str(GCC diagnostic s))
         |                                 ^~~~~~~
   include/linux/compiler-gcc.h:129:9: note: in expansion of macro '__diag'
     129 |         __diag(__diag_GCC_ignore option)
         |         ^~~~~~
   include/linux/uaccess.h:742:31: note: in expansion of macro '__diag_ignore_all'
     742 |                 __diag_push() __diag_ignore_all("-Wshadow", "uptr is readonly copy")    \
         |                               ^~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:778:9: note: in expansion of macro '__scoped_user_access'
     778 |         __scoped_user_access(write, udst, size, elbl)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:790:9: note: in expansion of macro 'scoped_user_write_access_size'
     790 |         scoped_user_write_access_size(udst, sizeof(*(udst)), elbl)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:856:9: note: in expansion of macro 'scoped_user_write_access'
     856 |         scoped_user_write_access(_tmpdst, efault)               \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/futex/core.c:604:37: note: in expansion of macro 'put_user_inline'
     604 |                 if (node_updated && put_user_inline(node, naddr))
         |                                     ^~~~~~~~~~~~~~~
..


vim +/_tmpptr +743 include/linux/uaccess.h

   689	
   690	/**
   691	 * __scoped_user_access - Open a scope for user access
   692	 * @mode:	The mode of the access class (read, write, rw)
   693	 * @uptr:	The pointer to access user space memory
   694	 * @size:	Size of the access
   695	 * @elbl:	Error label to goto when the access region is rejected. It
   696	 *		must be placed outside the scope
   697	 *
   698	 * If the user access function inside the scope requires a fault label, it
   699	 * can use @elbl or a different label outside the scope, which requires
   700	 * that user access which is implemented with ASM GOTO has been properly
   701	 * wrapped. See unsafe_get_user() for reference.
   702	 *
   703	 *	scoped_user_rw_access(ptr, efault) {
   704	 *		unsafe_get_user(rval, &ptr->rval, efault);
   705	 *		unsafe_put_user(wval, &ptr->wval, efault);
   706	 *	}
   707	 *	return 0;
   708	 *  efault:
   709	 *	return -EFAULT;
   710	 *
   711	 * The scope is internally implemented as a autoterminating nested for()
   712	 * loop, which can be left with 'return', 'break' and 'goto' at any
   713	 * point.
   714	 *
   715	 * When the scope is left user_##@_mode##_access_end() is automatically
   716	 * invoked.
   717	 *
   718	 * When the architecture supports masked user access and the access region
   719	 * which is determined by @uptr and @size is not a valid user space
   720	 * address, i.e. < TASK_SIZE, the scope sets the pointer to a faulting user
   721	 * space address and does not terminate early. This optimizes for the good
   722	 * case and lets the performance uncritical bad case go through the fault.
   723	 *
   724	 * The eventual modification of the pointer is limited to the scope.
   725	 * Outside of the scope the original pointer value is unmodified, so that
   726	 * the original pointer value is available for diagnostic purposes in an
   727	 * out of scope fault path.
   728	 *
   729	 * Nesting scoped user access into a user access scope is invalid and fails
   730	 * the build. Nesting into other guards, e.g. pagefault is safe.
   731	 *
   732	 * The masked variant does not check the size of the access and relies on a
   733	 * mapping hole (e.g. guard page) to catch an out of range pointer, the
   734	 * first access to user memory inside the scope has to be within
   735	 * @uptr ... @uptr + PAGE_SIZE - 1
   736	 *
   737	 * Don't use directly. Use scoped_masked_user_$MODE_access() instead.
   738	 */
   739	#define __scoped_user_access(mode, uptr, size, elbl)					\
 > 740		with (auto _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl))	\
   741			/* Force modified pointer usage within the scope */			\
   742			__diag_push() __diag_ignore_all("-Wshadow", "uptr is readonly copy")	\
 > 743			and_with (const auto uptr __cleanup(__scoped_user_##mode##_access_end) = _tmpptr) \
   744			__diag_pop()
   745	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

