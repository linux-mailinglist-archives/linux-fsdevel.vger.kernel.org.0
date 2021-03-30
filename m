Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2D234DDEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 04:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhC3CBq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 22:01:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230446AbhC3CBp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:01:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99A996157F;
        Tue, 30 Mar 2021 02:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617069705;
        bh=9R+QyMjKEwKKtQwvA/oXHySXD4bXuroEwo7uAjahgbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uGm3qzUSpGBgpDBne8SUTLqeo9w/L39zbcZq1cIzhnpyIuWGMVPFoLhzNOv8l8zKV
         F97kqRVueRXH+y8qvDFMtCPyFRvUnRzkSl1naP+m33TZTsUlnQJa+fTAurk1nwMnYk
         H7VlZL0KP8RQE1Par6p+q2oCq7I/jEpATcYF14YyqWFYbB3WCHRpGmVTGfp1qNbodv
         hr/dXO6B2pQoGAdMeMp7AH0Wk1PUXL/WnN+HQmi/8KEAK3p3p3ZJ5u7zzDPFVlwJGB
         /A/SVdMFh8yfzD5WzkrfHZHnErrTZV2Pgg2V9LbnGHVUwLlDOHGrKw5fm5lPzIO9tf
         ag9ypsLxYXTOg==
Date:   Mon, 29 Mar 2021 19:01:43 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, krisman@collabora.com, drosen@google.com,
        yuchao0@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
Subject: Re: [PATCH v5 4/4] fs: unicode: Add utf8 module and a unicode layer
Message-ID: <YGKGhxaozX3ND6iB@gmail.com>
References: <20210329204240.359184-1-shreeya.patel@collabora.com>
 <20210329204240.359184-5-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329204240.359184-5-shreeya.patel@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 30, 2021 at 02:12:40AM +0530, Shreeya Patel wrote:
> diff --git a/fs/unicode/Kconfig b/fs/unicode/Kconfig
> index 2c27b9a5cd6c..ad4b837f2eb2 100644
> --- a/fs/unicode/Kconfig
> +++ b/fs/unicode/Kconfig
> @@ -2,13 +2,26 @@
>  #
>  # UTF-8 normalization
>  #
> +# CONFIG_UNICODE will be automatically enabled if CONFIG_UNICODE_UTF8
> +# is enabled. This config option adds the unicode subsystem layer which loads
> +# the UTF-8 module whenever any filesystem needs it.
>  config UNICODE
> -	bool "UTF-8 normalization and casefolding support"
> +	bool
> +
> +# utf8data.h_shipped has a large database table which is an auto-generated
> +# decodification trie for the unicode normalization functions and it is not
> +# necessary to carry this large table in the kernel.
> +# Enabling UNICODE_UTF8 option will allow UTF-8 encoding to be built as a
> +# module and this module will be loaded by the unicode subsystem layer only
> +# when any filesystem needs it.
> +config UNICODE_UTF8
> +	tristate "UTF-8 module"
>  	help
>  	  Say Y here to enable UTF-8 NFD normalization and NFD+CF casefolding
>  	  support.
> +	select UNICODE

This seems problematic; it allows users to set CONFIG_EXT4_FS=y (or
CONFIG_F2FS_FS=y) but then CONFIG_UNICODE_UTF8=m.  Then the filesystem won't
work if the modules are located on the filesystem itself.

I think it should work analogously to CONFIG_FS_ENCRYPTION and
CONFIG_FS_ENCRYPTION_ALGS.  That is, CONFIG_UNICODE should be a user-selectable
bool, and then the tristate symbols CONFIG_EXT4_FS and CONFIG_F2FS_FS should
select the tristate symbol CONFIG_UNICODE_UTF8 if CONFIG_UNICODE.

- Eric
