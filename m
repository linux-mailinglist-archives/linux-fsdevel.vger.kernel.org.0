Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A004D0765
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 20:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244954AbiCGTQZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 14:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238787AbiCGTQX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:16:23 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F3B7CDEB
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Mar 2022 11:15:28 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 3so9388841lfr.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Mar 2022 11:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TwTcsRMn5VZVrmgXZDV1J6sFeJgAdw8S2EoV6iZ5xnc=;
        b=dlpUNu5q4CyzmXtBLA/gOu0GC/00SF7ttDAollAbHZtk5bw2xAtIqb7CwTopnt8lf3
         AbfnSVPq9xulj/tw8AvoPmKfCZDzXeZNEVEEDbHlLhh/I5bp+zk8upvRu1BNSASuquhE
         pUQrRqiHujQApoBOt9qnNksqqhPlFfAR59MXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TwTcsRMn5VZVrmgXZDV1J6sFeJgAdw8S2EoV6iZ5xnc=;
        b=eoLrwKQ/yKRDBLOyQ5DsU07QiChall7anfyYCXfbo6WkF/SKA7smYtxlnHUPbRRmwZ
         RD+Q5U/+t9gPTDQcK7B1qMJNHVSACn8FesHybzdGDV9/6qj+rHqDxZFi9S2BQPuojVHI
         +FbxtgpXcVh18NFx4AjjOOT666rouAUtvrxluansRNpAvxDfUprAqGEihh43D/kGbblF
         RAbznZB1MC52UtvkwuupcHXoALQKUYKoSe3RC1qS/9C9uJVOzGPNUVexWkcldmnmp/x2
         8lNloSY9jc5omZpkPqAmjOPkAtgtLO+8OBudqak6cLypRrAa0lK+m0+V8PDJtEiukTUm
         9z3A==
X-Gm-Message-State: AOAM531QsNHkcAP3tq76MRta4LS3aOFjuaEe31UY/l40K/bIdggokxKD
        +474myqNCeJyIYA7O7jBFxrB4aiFvTAQ7Uo3ios=
X-Google-Smtp-Source: ABdhPJx2Za7jGWvXDKYH4fPD8W/akpkJwM9CqCwZ4p6Tkn+Y5SyjylJqeYLmmna+v0P9qZpw4Y7DTA==
X-Received: by 2002:ac2:4290:0:b0:448:1fb8:837a with SMTP id m16-20020ac24290000000b004481fb8837amr8719852lfh.206.1646680525248;
        Mon, 07 Mar 2022 11:15:25 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id f10-20020a056512092a00b004482fed26a0sm842594lft.234.2022.03.07.11.15.24
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 11:15:25 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id u7so21883711ljk.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Mar 2022 11:15:24 -0800 (PST)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr5310350lja.443.1646680524503; Mon, 07
 Mar 2022 11:15:24 -0800 (PST)
MIME-Version: 1.0
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220307150037.GD3293@kadam> <f7ffd78aa68340e1ade6af15fa2f06d8@AcuMS.aculab.com>
In-Reply-To: <f7ffd78aa68340e1ade6af15fa2f06d8@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Mar 2022 11:15:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjnsmmGdh-SZzaPD=e1rKhoBkQAF3JeVhGvpa=Gax--7g@mail.gmail.com>
Message-ID: <CAHk-=wjnsmmGdh-SZzaPD=e1rKhoBkQAF3JeVhGvpa=Gax--7g@mail.gmail.com>
Subject: Re: [PATCH 0/6] Remove usage of list iterator past the loop body
To:     David Laight <David.Laight@aculab.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergman <arnd@arndb.de>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 7, 2022 at 7:26 AM David Laight <David.Laight@aculab.com> wrote:
>
> I'd write the following new defines (but I might be using
> the old names here):

See my email at

  https://lore.kernel.org/all/CAHk-=wiacQM76xec=Hr7cLchVZ8Mo9VDHmXRJzJ_EX4sOsApEA@mail.gmail.com/

for what I think is the way forward if we want to do new defines and
clean up the situation.

It's really just an example (and converts two list cases and one
single file that uses them), so it's not in any way complete.

I also has that "-std=gnu11" in the patch so that you can use the
loop-declared variables - but without the other small fixups for some
of the things that exposed.

I'll merge the proper version of the "update C standard version" from
Arnd early in the 5.18 merge window, but for testing that one file
example change I sent out the patch like that.

          Linus
