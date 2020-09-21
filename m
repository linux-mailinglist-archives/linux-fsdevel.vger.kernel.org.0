Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09BE272559
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 15:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgIUN0f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 09:26:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbgIUN0e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:26:34 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B9712076E;
        Mon, 21 Sep 2020 13:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600694794;
        bh=vvbV0d1b9m6RLAHTC+GfWYs2Cg+CuDl9iFfAyv4zfok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xnPuiqQb5g5HgvW0Dczozc7y5dnQeN1FlC4k6x6a6cZV9e0uYv+s4HfgakYyYbYwt
         IkFWxbywc90mezKfMUieUzFjIeeclzxDNoBCgF5nw17Dhfpx8EPzltzW1eL8Ci1UHs
         FcQ+0/ijfWQyjAbbsPXdqdUiFFzh2JtsSfrqrlwA=
Received: by pali.im (Postfix)
        id F257A7BF; Mon, 21 Sep 2020 15:26:31 +0200 (CEST)
Date:   Mon, 21 Sep 2020 15:26:31 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, dsterba@suse.cz, aaptel@suse.com,
        willy@infradead.org, rdunlap@infradead.org, joe@perches.com,
        mark@harmstone.com, nborisov@suse.com
Subject: Re: [PATCH v5 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
Message-ID: <20200921132631.q6jfmbhqf6j6ay5t@pali>
References: <20200911141018.2457639-1-almaz.alexandrovich@paragon-software.com>
 <20200911141018.2457639-9-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911141018.2457639-9-almaz.alexandrovich@paragon-software.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday 11 September 2020 17:10:16 Konstantin Komarov wrote:
> +Mount Options
> +=============
> +
> +The list below describes mount options supported by NTFS3 driver in addition to
> +generic ones.
> +
> +===============================================================================
> +
> +nls=name		This option informs the driver how to interpret path
> +			strings and translate them to Unicode and back. If
> +			this option is not set, the default codepage will be
> +			used (CONFIG_NLS_DEFAULT).
> +			Examples:
> +				'nls=utf8'
> +
> +nls_alt=name		This option extends "nls". It will be used to translate
> +			path string to Unicode if primary nls failed.
> +			Examples:
> +				'nls_alt=cp1251'

Hello! I'm looking at other filesystem drivers and no other with UNICODE
semantic (vfat, udf, isofs) has something like nls_alt option.

So do we really need it? And if yes, it should be added to all other
UNICODE filesystem drivers for consistency.

But I'm very sceptical if such thing is really needed. nls= option just
said how to convert UNICODE code points for userpace. This option is
passed by userspace (when mounting disk), so userspace already know what
it wanted. And it should really use this encoding for filenames (e.g.
utf8 or cp1251) which already told to kernel.
