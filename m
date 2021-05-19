Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475403888F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 10:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbhESIIc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 May 2021 04:08:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:28069 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235683AbhESIIb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 May 2021 04:08:31 -0400
IronPort-SDR: COl2Nu6Dd9AE5Ne0QP0ESgfVUGHUOc3b2+3RPAqqw7Uk6rNIvfy0+lVz59tG4PeK5xcFkcocqi
 zK915tXQNlTw==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="221984080"
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="221984080"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 01:07:12 -0700
IronPort-SDR: +m6QThSTl14NxX0mj/VRdu4CnV61XHCXHOpwQDCABkD55XFK7ns2/d36Ij8WIWZh2o4cI7wOQs
 2TGdrPwoRnXg==
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="627525656"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 01:07:08 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ljHEO-00DAfC-Ef; Wed, 19 May 2021 11:07:04 +0300
Date:   Wed, 19 May 2021 11:07:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jia He <justin.he@arm.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 12/14] d_path: prepend_path(): lift the inner loop into a
 new helper
Message-ID: <YKTHKNsX/cvYwbWj@smile.fi.intel.com>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
 <20210519004901.3829541-12-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519004901.3829541-12-viro@zeniv.linux.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 19, 2021 at 12:48:59AM +0000, Al Viro wrote:
> ... and leave the rename_lock/mount_lock handling in prepend_path()
> itself

...

> +			if (!IS_ERR_OR_NULL(mnt_ns) && !is_anon_ns(mnt_ns))
> +				return 1;	// absolute root
> +			else
> +				return 2;	// detached or not attached yet

Would it be slightly better to read

			if (IS_ERR_OR_NULL(mnt_ns) || is_anon_ns(mnt_ns))
				return 2;	// detached or not attached yet
			else
				return 1;	// absolute root

?

Oh, I have noticed that it's in the original piece of code (perhaps separate
change if we ever need it?).


-- 
With Best Regards,
Andy Shevchenko


