Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F174EFC32
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 23:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352797AbiDAVhH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 17:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiDAVhH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 17:37:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D715DEF2;
        Fri,  1 Apr 2022 14:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yW4grdHD49Z7KPR5NBuetJtNbEOexe8H6wsJfW/kHRw=; b=RUx3NW+0l3qtEYYyEtnhRFhovU
        vLKpaTsQj8vuYQTLUcOQb8pf+kNeWeeg7Z2Dqlou2kV+necde4wmuUkDBNHnFDAEJNveOkP8GU7mF
        8/DFAVR/kuUqvuxWeiBke+eS0tIsrg05tcDhMM3kOna1ziUUHUaXw9wxZoa/cSBBMWNo6lsidFwje
        3oYbOvWDnnDPBQLYC8JfQCzwjuT9n5psY/QMx3p6O8AguVBdoD3dA7nn2A8m06hT0gJp7k4kTaIBB
        uFCgXB96IH5XTHipevqPLIkZkGkbPc3jW/7CE0kbY1y8cdUyN5OaSBGCDjhQMWsyZUT6GNPWQpaik
        aBXQqqmA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1naOv9-007PHF-Uz; Fri, 01 Apr 2022 21:35:03 +0000
Date:   Fri, 1 Apr 2022 14:35:03 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc:     corbet@lwn.net, keescook@chromium.org, yzaikin@google.com,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux@rasmusvillemoes.dk, ebiggers@google.com,
        peterz@infradead.org, ying.huang@intel.com, gpiccoli@igalia.com,
        mchehab+huawei@kernel.org, Jason@zx2c4.com, daniel@iogearbox.net,
        robh@kernel.org, wangqing@vivo.com, prestwoj@gmail.com,
        dsahern@kernel.org, stephen.s.brennan@oracle.com
Subject: Re: [RFC 1/1] kernel/sysctl: Add sysctl entry for
 crash_kexec_post_notifiers
Message-ID: <YkdwB4Yh0hNgEyOa@bombadil.infradead.org>
References: <20220401202300.12660-1-alejandro.j.jimenez@oracle.com>
 <20220401202300.12660-2-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401202300.12660-2-alejandro.j.jimenez@oracle.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 01, 2022 at 04:23:00PM -0400, Alejandro Jimenez wrote:
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 830aaf8ca08e..8e0be72b5fba 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2339,6 +2339,13 @@ static struct ctl_table kern_table[] = {
>  		.extra2		= SYSCTL_INT_MAX,
>  	},
>  #endif
> +	{
> +		.procname	= "crash_kexec_post_notifiers",
> +		.data		= &crash_kexec_post_notifiers,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dobool,
> +	},
>  	{ }

Please don't add any new sysctls to this file anymore. See
sysctl-testing which trims its uses. Plenty of examples for you
to see what to do, hopefully [0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-testing

  Luis
