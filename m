Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51645E8EDD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Sep 2022 19:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiIXRVA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Sep 2022 13:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiIXRU7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Sep 2022 13:20:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC4B63A5;
        Sat, 24 Sep 2022 10:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664040039;
        bh=jUU/GHPsMUSoCCNnDWS/BoBB81LG++oXGXwk/mXpgb8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ChfeE5hrcDGqjTwmWHM6nhJdFLbnG9ugrUHktQelxxBUnUw1COGGaVbZYKunLdY3y
         oGlm6fIDuMxG6JyZcBh95HxAULZ4NFjy/jbJQXegVwAU3mjX1bmbN4zgLLfQJfra4o
         NXocIIfgKWoPq+TBUE97savwb5oMAyewW1ZsO3EM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100 ([92.116.155.187]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbRfl-1p8zk60DYP-00bqXE; Sat, 24
 Sep 2022 19:20:39 +0200
Date:   Sat, 24 Sep 2022 19:20:36 +0200
From:   Helge Deller <deller@gmx.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH printk 11/18] printk: Convert console_drivers list to
 hlist
Message-ID: <Yy88ZIIzEXtfb+m6@p100>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-12-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924000454.3319186-12-john.ogness@linutronix.de>
X-Provags-ID: V03:K1:/2YDIKcSg2pNPoQopaGy9wV+dOO91R12jtUK5/VkDrL9Jmo7/zb
 M0YZZoi0XE/S64cT3ywtbPfh5MnVx2wMrO91jJc37zdcIDXpvPaj9KUU/NuA6m3lFap1ceS
 3Dk301T92BT4nLlx+MYqvcCAfML7fIWh+3T3QP46ECiLt3JcjsfqBpeHvTL2voXCJhzZKJQ
 XY0ITXzzbVNJ11buQgvrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+qNRF9TEP/I=:jfMTNh3HWbzFd+JOZZPNVV
 2tgUWqnjhk9IQv533JH4e5Mg7QJcYEOas68JWqtSiMlrL1xrUi6bSkXPFFzW5LnDyxbSLSFHG
 uhw/7dQx6aBBwPAk8UVUKd/d/n0mOBDjp684NA0i1Db5y9Tvya/2YQ9/Wia30laHzWDThsOgT
 4sqqKiZ+T2jD/HjK/TBS3EoeFgEEPYgSJ9OHUWhnbdFMNQjc2ebgjqn5jAS1w1QtA81vHQus3
 lnL7rrDDIVN7/aoDd27gI2IhoMfDNOBafD9VDkCTJl9Ou9nA2i+t4CDRQeLzGVD02zLVut4mx
 LUieQ0+Y/T95yiJ95Mw2VwZjsmqZ4wRIFykIOlykC7SljxajR+0pbMJs+8lMBC6nwkzmC9Alk
 OaJbM6W86wjfUqCUzcbYvVfphb6U3SgyP2O8zdvrsaM/wcE/uj4ex6UPhBeQzMQaKy7PaMqXT
 rlVw+u43Dny3FFkGrM0LcB/B1Y3QfB+coYE7AjFtRPPRuXPBAcUXIFh17FL6fyanlh5re3ZDI
 e0dGtwt3pabBM+cprgPVCSbxXp3uXOeGdHPmLsVuxDvs4+Sq/AKSqa4Vg/yVKafbVA0UG4Z49
 hWvF4z354/a0EW/PrgoLPJ3tI1VlHs02lflyhgQxr4Bc2dZQm78whyls7idqV0mK5ZsWvDicz
 /WMqlKyE+TpvKLg9SV3pl/stGfTi1C+uIFKONu8JMc1AqvUleauVNHU3XIMGkrF1deoNejG8I
 ru4U32CbQa8mOLrvKQ6177bjaUbVVF90QKKx4/q3hnJS8weLLxRYrBVvfqmF+FyVvl+TzNi0O
 r7EcoN5i97xscONNkMQXmHrmJBKAcCGgtqU3Qrh1Vmpp6ghDwCAFiwFprp4EREt/pvcEMJ3Rh
 zBm9QVrDmKO1VKarWFpYev6VnD2DZwzB4sPE6ty9/huUHcNf8aW+sioc0WSL7HYmbF75VqQrd
 gBXqJiaGbqOlacftZo3/NTkD3Ba+aSwJSyTNscJxvQ7h+nbpGgJQl74nMmJWFK7ANAI8l6EBi
 qOt4cmd5iIucP70YPblBl3/xaDxosObfhiKs6kZDX9oVjFqppBV2HhdojH3ozT2bxMKqiH2pL
 hItAJcW4yT9Aae1XBGhMgLyQc7uSJPfEBtr+UycuSW+MM1B5bdqor3fv3vwNWouQHCqY2G7Xs
 53q0To9HliwysgdOqvXbMtHDuQ
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi John,

* John Ogness <john.ogness@linutronix.de>:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Replace the open coded single linked list with a hlist so a conversion t=
o
> SRCU protected list walks can reuse the existing primitives.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  arch/parisc/kernel/pdc_cons.c | 19 +++----
>  fs/proc/consoles.c            |  5 +-
>  include/linux/console.h       | 15 ++++--
>  kernel/printk/printk.c        | 99 +++++++++++++++++++----------------
>  4 files changed, 75 insertions(+), 63 deletions(-)
>
> diff --git a/arch/parisc/kernel/pdc_cons.c b/arch/parisc/kernel/pdc_cons=
.c
> index 9a0c0932d2f9..3f9abf0263ee 100644
> --- a/arch/parisc/kernel/pdc_cons.c
> +++ b/arch/parisc/kernel/pdc_cons.c
> @@ -272,15 +267,17 @@ void pdc_console_restart(bool hpmc)
>  	if (pdc_console_initialized)
>  		return;
>
> -	if (!hpmc && console_drivers)
> +	if (!hpmc && !hlist_empty(&console_list))
>  		return;
>
>  	/* If we've already seen the output, don't bother to print it again */
> -	if (console_drivers !=3D NULL)
> +	if (!hlist_empty(&console_list))
>  		pdc_cons.flags &=3D ~CON_PRINTBUFFER;
>
> -	while ((console =3D console_drivers) !=3D NULL)
> -		unregister_console(console_drivers);
> +	while (!hlist_empty(&console_list)) {
> +		unregister_console(READ_ONCE(hlist_entry(console_list.first,
> +							 struct console, node)));
> +	}
>
>  	/* force registering the pdc console */
>  	pdc_console_init_force();

Thanks for doing this!!

I had to add the hunks below on top of your patch to make it compile
and boot sucessfully on parisc.
Maybe you could fold those into your patch?

Thanks!
Helge


diff --git a/arch/parisc/kernel/pdc_cons.c b/arch/parisc/kernel/pdc_cons.c
index 3f9abf0263ee..f15998aa47a8 100644
=2D-- a/arch/parisc/kernel/pdc_cons.c
+++ b/arch/parisc/kernel/pdc_cons.c
@@ -262,8 +262,6 @@ void __init pdc_console_init(void)
  */
 void pdc_console_restart(bool hpmc)
 {
-	struct console *console;
-
 	if (pdc_console_initialized)
 		return;

@@ -275,8 +273,8 @@ void pdc_console_restart(bool hpmc)
 		pdc_cons.flags &=3D ~CON_PRINTBUFFER;

 	while (!hlist_empty(&console_list)) {
-		unregister_console(READ_ONCE(hlist_entry(console_list.first,
-							 struct console, node)));
+		unregister_console(hlist_entry(console_list.first,
+						 struct console, node));
 	}

 	/* force registering the pdc console */
