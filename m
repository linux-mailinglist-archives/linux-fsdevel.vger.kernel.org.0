Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35971352126
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 22:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbhDAUyK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 16:54:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233885AbhDAUx3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 16:53:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 272BB6100C;
        Thu,  1 Apr 2021 20:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617310409;
        bh=IeGFO7wQN74UxS4HFnyBTT77n4Wa4GfPsbfpJB6Qlnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NyAgAAhaziRAU8zj1EByvNvVzNYpGkxmEryvVDgLck0vq0MCStLK31Om2yrVXTvgE
         u+Rcydyi7/3x/AKzZ7mYa+xV9A3ipvVDPxOwAEVYM4nFw71uT7Wsk7W12WBJ5Op7G7
         P5lEhp/MR5vN89OsR9PdNpLZIoqVakzUvmxtUSuAcqNmWzwIfwoCsx2p8tk80NJ5Ed
         5HdFHQlHtnlax50ii+08WTeWmhnA7fu9YvM9xVYwv/l7+rhdWvybOsQ9i4iIhYRfC7
         Z6h7cwPG4yfggyxw6mrQpjkIXnERttU2dM6TiBLRx5bdrZsY0bPjFGAz6ZUA2g5Ebr
         GMHxNfjLkpAXA==
Date:   Thu, 1 Apr 2021 13:53:27 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, krisman@collabora.com, drosen@google.com,
        yuchao0@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
Subject: Re: [PATCH v6 4/4] fs: unicode: Add utf8 module and a unicode layer
Message-ID: <YGYyxzLu2gmO5CCk@gmail.com>
References: <20210331210751.281645-1-shreeya.patel@collabora.com>
 <20210331210751.281645-5-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331210751.281645-5-shreeya.patel@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 02:37:51AM +0530, Shreeya Patel wrote:
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

Please update this help text to properly describe this option, especially the
consequences of setting it to 'm'.

> +	select UNICODE

'select' should go before 'help'.

>  struct unicode_map *unicode_load(const char *version)
>  {
> +	try_then_request_module(utf8mod, "utf8");
> +	if (!utf8mod) {
> +		pr_err("Failed to load UTF-8 module\n");
> +		return ERR_PTR(-ENODEV);
>  	}
>  
> +	spin_lock(&utf8mod_lock);
> +	if (!utf8mod || !try_module_get(utf8mod)) {
> +		spin_unlock(&utf8mod_lock);
> +		return ERR_PTR(-ENODEV);
> +	}
> +	spin_unlock(&utf8mod_lock);
> +	return static_call(unicode_load_static_call)(version);
>  }
>  EXPORT_SYMBOL(unicode_load);
>  
>  void unicode_unload(struct unicode_map *um)
>  {
>  	kfree(um);
> +
> +	spin_lock(&utf8mod_lock);
> +	if (utf8mod)
> +		module_put(utf8mod);
> +	spin_unlock(&utf8mod_lock);
> +
>  }
>  EXPORT_SYMBOL(unicode_unload);
>  
> +void unicode_register(struct module *owner)
> +{
> +	utf8mod = owner;
> +}
> +EXPORT_SYMBOL(unicode_register);
> +
> +void unicode_unregister(void)
> +{
> +	spin_lock(&utf8mod_lock);
> +	utf8mod = NULL;
> +	spin_unlock(&utf8mod_lock);
> +}
> +EXPORT_SYMBOL(unicode_unregister);


This all looks very broken.  First, when !CONFIG_MODULES, utf8mod will always be
NULL so unicode_load() will always fail.

Also, if the unicode_load_static_call() fails, a reference to the utf8mod will
be leaked.

Also, unicode_unload() can put a reference to the utf8mod that was never
acquired.

Also there is a data race on utf8mod because the accesses to it aren't properly
synchronized.

Please consider something like the following, which I think would address all
these bugs:

static bool utf8mod_get(void)
{
	bool ret;

	spin_lock(&utf8mod_lock);
	ret = utf8mod_loaded && try_module_get(utf8mod);
	spin_unlock(&utf8mod_lock);
	return ret;
}

struct unicode_map *unicode_load(const char *version)
{
	struct unicode_map *um;

	if (!try_then_request_module(utf8mod_get(), "utf8")) {
		pr_err("Failed to load UTF-8 module\n");
		return ERR_PTR(-ENODEV);
	}
	um = static_call(unicode_load_static_call)(version);
	if (IS_ERR(um))
		module_put(utf8mod);
	return um;
}
EXPORT_SYMBOL(unicode_load);

void unicode_unload(struct unicode_map *um)
{
	if (um) {
		kfree(um);
		module_put(utf8mod);
	}
}
EXPORT_SYMBOL(unicode_unload);

void unicode_register(struct module *owner)
{
	spin_lock(&utf8mod_lock);
	utf8mod = owner; /* note: will be NULL if !CONFIG_MODULES */
	utf8mod_loaded = true;
	spin_unlock(&utf8mod_lock);
}
EXPORT_SYMBOL(unicode_register);

void unicode_unregister(void)
{
	spin_lock(&utf8mod_lock);
	utf8mod = NULL;
	utf8mod_loaded = false;
	spin_unlock(&utf8mod_lock);
}
EXPORT_SYMBOL(unicode_unregister);
