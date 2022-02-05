Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B924AA939
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 14:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380062AbiBEN5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Feb 2022 08:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiBEN5i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Feb 2022 08:57:38 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F80C061346;
        Sat,  5 Feb 2022 05:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1644069456;
        bh=4LhrZA/w4th6MUICBQPQhLfKK3MyHiWT60QkciOvN8k=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=vq87wwp1dqa0IZ1lf4KjNnJ6/pUpr4oKlZqHPLZNP09zofZC4abZTNS8bfDmqmoGk
         vZCQFNNYgXQwUV7CPc7dbsRUJUGJlyhV1NGRFE5yp/HqkvpiZuVA7mKViCSPWxDGWE
         nETthuPrDofCnOZ3AXzDFAeJO1pcZqEp1xhWqXjY=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BFB97128055A;
        Sat,  5 Feb 2022 08:57:36 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Pf4rdTvJbTFl; Sat,  5 Feb 2022 08:57:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1644069456;
        bh=4LhrZA/w4th6MUICBQPQhLfKK3MyHiWT60QkciOvN8k=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=vq87wwp1dqa0IZ1lf4KjNnJ6/pUpr4oKlZqHPLZNP09zofZC4abZTNS8bfDmqmoGk
         vZCQFNNYgXQwUV7CPc7dbsRUJUGJlyhV1NGRFE5yp/HqkvpiZuVA7mKViCSPWxDGWE
         nETthuPrDofCnOZ3AXzDFAeJO1pcZqEp1xhWqXjY=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::527])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9409F12803BB;
        Sat,  5 Feb 2022 08:57:35 -0500 (EST)
Message-ID: <749fcbf2e2094606b31a07ba3d480bd90d7c1890.camel@HansenPartnership.com>
Subject: Re: [PATCH] Add ability to disallow idmapped mounts
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Anton V. Boyarshinov" <boyarsh@altlinux.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        ebiederm@xmission.com, legion@kernel.org, ldv@altlinux.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 05 Feb 2022 08:57:34 -0500
In-Reply-To: <20220205105758.1623e78d@tower>
References: <20220204065338.251469-1-boyarsh@altlinux.org>
         <20220204094515.6vvxhzcyemvrb2yy@wittgenstein>
         <20220204132616.28de9c4a@tower>
         <20220204151032.7q22hgzcil4hqvkl@wittgenstein>
         <20220205105758.1623e78d@tower>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2022-02-05 at 10:57 +0300, Anton V. Boyarshinov wrote:
> В Fri, 4 Feb 2022 16:10:32 +0100
> Christian Brauner <brauner@kernel.org> пишет:
> 
> 
> > > It turns off much more than idmapped mounts only. More fine
> > > grained control seems better for me.  
> > 
> > If you allow user namespaces and not idmapped mounts you haven't
> > reduced your attack surface.
> 
> I have. And many other people have. People who have creating user
> namespaces by unpriviliged user disabled.

Which would defeat the purpose of user namespaces which is to allow the
creation of unprivileged containers by anyone and allow us to reduce
the container attack surface by reducing the actual privilege given to
some real world containers.

You've raised vague, unactionable security concerns about this, but
basically one of the jobs of user namespaces is to take some designated
features guarded by CAP_SYS_ADMIN and give the admin of the namespace
(the unprivileged user) access to them.  There are always going to be
vague security concerns about doing this.  If you had an actual,
actionable concern, we could fix it.  What happens without this is that
containers that need the functionality now have to run with real root
inside, which is a massively bigger security problem.

Adding knobs to disable features for unactionable security concerns
gives a feel good in terms of security theatre, but it causes system
unpredictability in that any given application now has to check if a
feature is usable before it uses it and figure out what to do if it
isn't available.  The more we do it, the bigger the combinatoric
explosion of possible missing features and every distro ends up having
a different default combination.

The bottom line is it's much better to find and fix actual security
bugs than create a runtime configuration nightmare.

>  I find it sad that we have no tool in mainline kernel to limit users
> access to creating user namespaces except complete disabling them.
> But many distros have that tools. Different tools with different
> interfaces and semantics :(

Have you actually proposed something?  A more granular approach to
globally disabling user namespaces might be acceptable provided it
doesn't lead to a feature configuration explosion.

James


