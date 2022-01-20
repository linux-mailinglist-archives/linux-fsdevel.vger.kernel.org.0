Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B47495088
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 15:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356646AbiATOuc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 09:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355000AbiATOu3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:50:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E502C06161C;
        Thu, 20 Jan 2022 06:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sA8kW5IUXvgUaS8EINQ5uOPdCx1tdexwAGGQdvNG+oc=; b=tlBYKVCI/68e3/DbYEZBkxzg0g
        4JJApXwqheJzidUEupziizgK5CCr9CXKESKnL/XTmkC0Y9mUt8Fgi1fiu+AjRyDuEPhzC/s9vOCoT
        D2huYhnLNa+qEvqWB2XLULGY6rrtMfOhhC5jspVnisN1lJQU3b/uWB3RwVd3ysBsPfes3Als5Ll/E
        /phUxbqm/DlrSCbKivT41R/YluR+AUg88M41GmifbTeLr0BEwonCY0e5UDfcuId42gXvd6TM8BaY0
        grjO3dCaKzTtpj5ju8VR2sh20xIItTsvaqjsXMO6mTEy8PoeAROlHz4p8H1VtcB8LHsQ3c047uJSV
        gSO8ApQg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAYlg-00Byti-0o; Thu, 20 Jan 2022 14:50:28 +0000
Date:   Thu, 20 Jan 2022 06:50:27 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] perf_events: sysctl: Avoid unused one_thousand definition
Message-ID: <Yel2sz+D8p1BVHk6@bombadil.infradead.org>
References: <20220119194019.27703-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119194019.27703-1-palmer@rivosinc.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 19, 2022 at 11:40:19AM -0800, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> The variable "one_thousand" is only used under CONFIG_PERF_EVENTS=y, but
> is unconditionally defined.  This can fire a warning.
> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> ---
> 
> I went with an #ifdef instead of a __maybe_unused because that's what
> the other code is using, and I left the one_thousand in order despite
> that requiring another #ifdef.
> ---
>  kernel/sysctl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index ef77be575d87..81a6f2d47f77 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -122,7 +122,9 @@ static unsigned long one_ul = 1;
>  static unsigned long long_max = LONG_MAX;
>  static int one_hundred = 100;
>  static int two_hundred = 200;
> +#ifdef CONFIG_PERF_EVENTS
>  static int one_thousand = 1000;
> +#endif

Please use linux-next, this has changed quite a bit there.
You can git grep for SYSCTL_ONE_THOUSAND.

  Luis
