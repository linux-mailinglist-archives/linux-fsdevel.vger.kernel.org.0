Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1201E46679F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 17:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359331AbhLBQMg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 11:12:36 -0500
Received: from foss.arm.com ([217.140.110.172]:37170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234859AbhLBQMe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:12:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EEBC142F;
        Thu,  2 Dec 2021 08:09:12 -0800 (PST)
Received: from arm.com (arrakis.cambridge.arm.com [10.1.196.175])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E0F73F73B;
        Thu,  2 Dec 2021 08:09:10 -0800 (PST)
Date:   Thu, 2 Dec 2021 16:09:08 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/4] arm64: Add support for user sub-page fault probing
Message-ID: <YajoDcF3AYJBZ63x@arm.com>
References: <20211201193750.2097885-1-catalin.marinas@arm.com>
 <20211201193750.2097885-4-catalin.marinas@arm.com>
 <YafbEpoiFB4emaPW@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YafbEpoiFB4emaPW@FVFF77S0Q05N>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mark,

On Wed, Dec 01, 2021 at 08:29:06PM +0000, Mark Rutland wrote:
> On Wed, Dec 01, 2021 at 07:37:49PM +0000, Catalin Marinas wrote:
> > +/*
> > + * Return 0 on success, the number of bytes not accessed otherwise.
> > + */
> > +static inline size_t __mte_probe_user_range(const char __user *uaddr,
> > +					    size_t size, bool skip_first)
> > +{
> > +	const char __user *end = uaddr + size;
> > +	int err = 0;
> > +	char val;
> > +
> > +	uaddr = PTR_ALIGN_DOWN(uaddr, MTE_GRANULE_SIZE);
> > +	if (skip_first)
> > +		uaddr += MTE_GRANULE_SIZE;
> 
> Do we need the skipping for a functional reason, or is that an optimization?

An optimisation and very likely not noticeable. Given that we'd do a read
following a put_user() or get_user() earlier, the cacheline was
allocated and another load may be nearly as fast as the uaddr increment.

> From the comments in probe_subpage_writeable() and
> probe_subpage_safe_writeable() I wasn't sure if the skipping was because we
> *don't need to* check the first granule, or because we *must not* check the
> first granule.

The "don't need to" part. But thinking about this, I'll just drop it as
it's confusing.

> > +	while (uaddr < end) {
> > +		/*
> > +		 * A read is sufficient for MTE, the caller should have probed
> > +		 * for the pte write permission if required.
> > +		 */
> > +		__raw_get_user(val, uaddr, err);
> > +		if (err)
> > +			return end - uaddr;
> > +		uaddr += MTE_GRANULE_SIZE;
> > +	}
> 
> I think we may need to account for the residue from PTR_ALIGN_DOWN(), or we can
> report more bytes not copied than was passed in `size` in the first place,
> which I think might confused some callers.
> 
> Consider MTE_GRANULE_SIZE is 16, uaddr is 31, and size is 1 (so end is 32). We
> align uaddr down to 16, and if we fail the first access we return (32 - 16),
> i.e. 16.

Good point. This is fine if we skip the first byte but not otherwise.
Planning to fold in this diff:

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index bcbd24b97917..213b30841beb 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -451,15 +451,17 @@ static inline int __copy_from_user_flushcache(void *dst, const void __user *src,
  * Return 0 on success, the number of bytes not accessed otherwise.
  */
 static inline size_t __mte_probe_user_range(const char __user *uaddr,
-					    size_t size, bool skip_first)
+					    size_t size)
 {
 	const char __user *end = uaddr + size;
 	int err = 0;
 	char val;
 
-	uaddr = PTR_ALIGN_DOWN(uaddr, MTE_GRANULE_SIZE);
-	if (skip_first)
-		uaddr += MTE_GRANULE_SIZE;
+	__raw_get_user(val, uaddr, err);
+	if (err)
+		return size;
+
+	uaddr = PTR_ALIGN(uaddr, MTE_GRANULE_SIZE);
 	while (uaddr < end) {
 		/*
 		 * A read is sufficient for MTE, the caller should have probed
@@ -480,8 +482,7 @@ static inline size_t probe_subpage_writeable(const void __user *uaddr,
 {
 	if (!system_supports_mte())
 		return 0;
-	/* first put_user() done in the caller */
-	return __mte_probe_user_range(uaddr, size, true);
+	return __mte_probe_user_range(uaddr, size);
 }
 
 static inline size_t probe_subpage_safe_writeable(const void __user *uaddr,
@@ -489,8 +490,7 @@ static inline size_t probe_subpage_safe_writeable(const void __user *uaddr,
 {
 	if (!system_supports_mte())
 		return 0;
-	/* the caller used GUP, don't skip the first granule */
-	return __mte_probe_user_range(uaddr, size, false);
+	return __mte_probe_user_range(uaddr, size);
 }
 
 static inline size_t probe_subpage_readable(const void __user *uaddr,
@@ -498,8 +498,7 @@ static inline size_t probe_subpage_readable(const void __user *uaddr,
 {
 	if (!system_supports_mte())
 		return 0;
-	/* first get_user() done in the caller */
-	return __mte_probe_user_range(uaddr, size, true);
+	return __mte_probe_user_range(uaddr, size);
 }
 
 #endif /* CONFIG_ARCH_HAS_SUBPAGE_FAULTS */

-- 
Catalin
