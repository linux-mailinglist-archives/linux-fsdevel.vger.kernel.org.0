Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B58704447
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 06:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjEPERu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 00:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjEPERs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 00:17:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F8D130;
        Mon, 15 May 2023 21:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3DSHTvG6LZ+LJt0UnspuIDStzV7P484sput9G2HdNVo=; b=5EE1DNslykt4/vm7WD4hqeMZYj
        UxlQgFkYuNDh2/lrRmMM2MlSA96btYQ8b7oNvcU7J4rp9DixY+1T/jbqflhJoWIud5ITLm6yOsaRU
        02AcP/Ix0I8iacgY7ZOgpa4nd24yp0YFDjEFwEuvoPLAo4SBrXTxqXxfn4iJNuZHv2KE3gO4f1Qib
        2MjjxiSCOb6mZhQzTOfrlnQrCO/1WUJPhnSTEo+5nb32L9I5V5gQOXJvJLya281StsIiGw/nOtTt2
        RalXRMdKNgYqn+lo6Ed18YdJWrDPjqEZGHtLaImiV/pKvO1D9p+rV6vVaXSH0CtiDZUUpQ+MNly0U
        LKKmVKfA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pym83-004JPH-17;
        Tue, 16 May 2023 04:17:39 +0000
Date:   Mon, 15 May 2023 21:17:39 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Joel Granados <j.granados@samsung.com>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/6] parport: Remove register_sysctl_table from
 parport_proc_register
Message-ID: <ZGMD4xMRKS8dZJpU@bombadil.infradead.org>
References: <20230515071446.2277292-1-j.granados@samsung.com>
 <CGME20230515071450eucas1p1625a8639e2b0edf47e41126801d4cbb8@eucas1p1.samsung.com>
 <20230515071446.2277292-3-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515071446.2277292-3-j.granados@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Awesome!

On Mon, May 15, 2023 at 09:14:42AM +0200, Joel Granados wrote:
> +
> +	port_name_len = strnlen(port->name, PARPORT_NAME_MAX_LEN);
> +	/*
> +	 * Allocate a buffer for two paths: dev/parport/PORT and dev/parport/PORT/devices.
> +	 * We calculate for the second as that will give us enough for the first.
> +	 */
> +	tmp_path_len = PARPORT_BASE_DEVICES_PATH_SIZE + port_name_len;
> +	tmp_dir_path = kmalloc(tmp_path_len, GFP_KERNEL);

Any reason why not kzalloc()?

> +	if (!tmp_dir_path) {
> +		err = -ENOMEM;
> +		goto exit_free_t;
> +	}
>  
> -	t->port_dir[0].procname = port->name;
> +	if (tmp_path_len
> +	    <= snprintf(tmp_dir_path, tmp_path_len, "dev/parport/%s/devices", port->name)) {

Since we are clearing up obfuscation code, it would be nicer to
make this easier to read and split the snprintf() into one line, capture
the error there. And then in a new line do the check. Even if we have to
add a new int value here.

Other than this I'd just ask to extend the commit log to use
the before and after of vmlinux (when this module is compiled in with all
the bells and whistles) with ./scripts/bloat-o-meter.

Ie build before the patch and cp vmlinux to vmlinux.old and then compare
with:

./scripts/bloat-o-meter vmlinux.old vmlinux

Can you also describe any testing if any.

With the above changes, feel free to add to all these patches:

Reviewed-by: Luis Chamberlain

> +	if (register_sysctl(tmp_dir_path, t->device_dir) == NULL)

BTW, we should be able to remove now replace register_sysctl_base() with a simple
register_sysctl("kernel", foo), and then one for "fs", and one of "vm"
on kernel/sysctl.c and just remove:

  * DECLARE_SYSCTL_BASE() & register_sysctl_base() & __register_sysctl_base()
  * and then after all this register_sysctl_table() completely

Let me know if you'd like a stab at it, or if you prefer me to do that.

  Luis


