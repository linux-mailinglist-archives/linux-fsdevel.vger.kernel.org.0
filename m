Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74FA37AEED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 20:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhEKS6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 14:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEKS6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 14:58:23 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CA5C061574;
        Tue, 11 May 2021 11:57:16 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id ADA844F7D; Tue, 11 May 2021 14:57:15 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org ADA844F7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1620759435;
        bh=tUqknlWsgROfdv3iv4KKpW4cm/9wKvzJqu96VZqELeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aMPIF83OTCZrEEqZ62vTLcYusLCO7dTLhVprJIH3a1ZbEQlqs+nVOcfyCRRMhbF8h
         7pgN68AWdh49HD6zRC5mDonW6Vo5KenX0nCLWivmIAqz4VFiju74IW5aOmB+gN4ZOm
         btWcgXa23PuqLYKuNXRlWObyvtBKmpji4iKi6eoo=
Date:   Tue, 11 May 2021 14:57:15 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 00/15] lib/string_helpers: get rid of ugly
 *_escape_mem_ascii()
Message-ID: <20210511185715.GE5416@fieldses.org>
References: <20210504180819.73127-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504180819.73127-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These look good to me, thanks for doing this!

--b.

On Tue, May 04, 2021 at 09:08:04PM +0300, Andy Shevchenko wrote:
> Get rid of ugly *_escape_mem_ascii() API since it's not flexible and
> has the only single user. Provide better approach based on usage of the
> string_escape_mem() with appropriate flags.
> 
> Test cases has been expanded accordingly to cover new functionality.
> 
> This is assumed to go either thru VFS or Andrew's tree. I don't expect
> too many changes in string_helpers.
> 
> Changelog v3:
> - dropped moving seq_escape() to the header due to a lot of complaints from
>   the (very) old code
> - added seq_escape_str() inliner
> - converted seq_escape() to use seq_escape_str() instead of seq_escape_mem()
> 
> Changelog v2:
> - introduced seq_escape_mem() instead of poking seq_get_buf() (Al)
> - to keep balance of seq_get_buf() usage, convert seq_escape() to use above
> - added missed ESCAPE_APPEND flag in NFSv4 patch
> - moved indentation patch closer to the beginning of the series
> - reshuffled series to be in two groups: generic library extension
>   followed by seq_file updates
> 
> Andy Shevchenko (15):
>   lib/string_helpers: Switch to use BIT() macro
>   lib/string_helpers: Move ESCAPE_NP check inside 'else' branch in a
>     loop
>   lib/string_helpers: Drop indentation level in string_escape_mem()
>   lib/string_helpers: Introduce ESCAPE_NA for escaping non-ASCII
>   lib/string_helpers: Introduce ESCAPE_NAP to escape non-ASCII and
>     non-printable
>   lib/string_helpers: Allow to append additional characters to be
>     escaped
>   lib/test-string_helpers: Print flags in hexadecimal format
>   lib/test-string_helpers: Get rid of trailing comma in terminators
>   lib/test-string_helpers: Add test cases for new features
>   MAINTAINERS: Add myself as designated reviewer for generic string
>     library
>   seq_file: Introduce seq_escape_mem()
>   seq_file: Add seq_escape_str() as replica of string_escape_str()
>   seq_file: Convert seq_escape() to use seq_escape_str()
>   nfsd: Avoid non-flexible API in seq_quote_mem()
>   seq_file: Drop unused *_escape_mem_ascii()
> 
>  MAINTAINERS                    |   8 ++
>  fs/nfsd/nfs4state.c            |   2 +-
>  fs/seq_file.c                  |  43 +++++----
>  include/linux/seq_file.h       |  10 ++-
>  include/linux/string_helpers.h |  31 ++++---
>  lib/string_helpers.c           | 102 ++++++++++++---------
>  lib/test-string_helpers.c      | 157 +++++++++++++++++++++++++++++----
>  7 files changed, 264 insertions(+), 89 deletions(-)
> 
> -- 
> 2.30.2
