Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C59E340F8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 22:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhCRVFw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 17:05:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231191AbhCRVFT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 17:05:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBD6864EF6;
        Thu, 18 Mar 2021 21:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616101519;
        bh=J/pP+TNYkCj3j3agwBOuhp42vUj1x20IlrBK1oqgpqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vix0VNC8pSOjUpK9igSfSJKfDWjH1Gxkj0/WWtbFqwGV/Sj/90k3E5Tqmmh8seCjf
         blXnfvB0ByCbMxRvojcodpLBLpDUDf3q5zcl9oIyiOkIQS9YIDimrIfKuqvh+zNVV0
         +Uuj3dHp0xF6t+qmd9fgbUmumktM/Y665/efPN6HiVZ/0y2FpW1VxMqN165C+4D6EE
         dZDgw0Vorx/bI2Ova22nPpndzQrXbQgkrlW6QCS2uh2p76YbAv9CuAj45FwsPEonex
         7yPZ8/SIrv2KfU0nVMiPadBkWT2EYUdMUi3cUx9N9Pg3kjtIedyrIKNgNrfVNXQMw4
         xS6Ed2tViW0TA==
Date:   Thu, 18 Mar 2021 14:05:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     krisman@collabora.com, jaegeuk@kernel.org, yuchao0@huawei.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, drosen@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com, andre.almeida@collabora.com
Subject: Re: [PATCH v2 4/4] fs: unicode: Add utf8 module and a unicode layer
Message-ID: <YFPAjYDOCXqpqgV8@gmail.com>
References: <20210318133305.316564-1-shreeya.patel@collabora.com>
 <20210318133305.316564-5-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318133305.316564-5-shreeya.patel@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 18, 2021 at 07:03:05PM +0530, Shreeya Patel wrote:
> +struct unicode_ops {
> +	struct module *owner;
> +	int (*validate)(const struct unicode_map *um, const struct qstr *str);
> +	int (*strncmp)(const struct unicode_map *um, const struct qstr *s1,
> +		       const struct qstr *s2);
> +	int (*strncasecmp)(const struct unicode_map *um, const struct qstr *s1,
> +			   const struct qstr *s2);
> +	int (*strncasecmp_folded)(const struct unicode_map *um, const struct qstr *cf,
> +				  const struct qstr *s1);
> +	int (*normalize)(const struct unicode_map *um, const struct qstr *str,
> +			 unsigned char *dest, size_t dlen);
> +	int (*casefold)(const struct unicode_map *um, const struct qstr *str,
> +			unsigned char *dest, size_t dlen);
> +	int (*casefold_hash)(const struct unicode_map *um, const void *salt,
> +			     struct qstr *str);
> +	struct unicode_map* (*load)(const char *version);
> +};

Indirect calls are expensive these days, especially due to the Spectre
mitigations.  Would it make sense to use static calls
(include/linux/static_call.h) instead for this?

- Eric
