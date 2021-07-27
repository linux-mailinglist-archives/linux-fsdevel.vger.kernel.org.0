Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51643D752E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 14:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhG0Mjk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 08:39:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:11024 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231840AbhG0Mjk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 08:39:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="210544269"
X-IronPort-AV: E=Sophos;i="5.84,273,1620716400"; 
   d="scan'208";a="210544269"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 05:39:40 -0700
X-IronPort-AV: E=Sophos;i="5.84,273,1620716400"; 
   d="scan'208";a="437300505"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 05:39:38 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m8MMt-0017nz-Mm; Tue, 27 Jul 2021 15:39:31 +0300
Date:   Tue, 27 Jul 2021 15:39:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jordy Zomer <jordy@pwning.systems>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2] fs: make d_path-like functions all have unsigned size
Message-ID: <YP/+g/L6+tLWjx/l@smile.fi.intel.com>
References: <20210727120754.1091861-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727120754.1091861-1-gregkh@linuxfoundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 02:07:54PM +0200, Greg Kroah-Hartman wrote:
> When running static analysis tools to find where signed values could
> potentially wrap the family of d_path() functions turn out to trigger a
> lot of mess.  In evaluating the code, all of these usages seem safe, but
> pointer math is involved so if a negative number is ever somehow passed
> into these functions, memory can be traversed backwards in ways not
> intended.
> 
> Resolve all of the abuguity by just making "size" an unsigned value,
> which takes the guesswork out of everything involved.

Are you sure it's correct change?

Look into extract_string() implementation.

	if (likely(p->len >= 0))
		return p->buf;
	return ERR_PTR(-ENAMETOOLONG);

Your change makes it equal to

	return p->buf;

if I'm not mistaken.

-- 
With Best Regards,
Andy Shevchenko


