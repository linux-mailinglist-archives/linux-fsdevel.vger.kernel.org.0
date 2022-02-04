Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF0B4A9BAA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 16:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243115AbiBDPKm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 10:10:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59072 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343868AbiBDPKi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:10:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8A6360FC8;
        Fri,  4 Feb 2022 15:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACE8C004E1;
        Fri,  4 Feb 2022 15:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643987437;
        bh=IoHPIjb2fSbuPpgienLeVPvvwcFaWSnzgKep7XPLsnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ken7aeQ6msksQh20Q4C97KzBOyXJUMa4ehlX3O/QpWCWC6BHgF9TJh5WQ8fdyrw/3
         sPUmwlDb3+mpdoW/Qa3jsqNy81CByFyrjJ8Oy7GWKMEtI9dL2toPVHJ4cy91EUTo3s
         i9o42Z4PFuIv+6NP1f0PpbYh6cb972MZTbFmzPXo9oDErQLYa+z5ankmAaGMSW6kjI
         Kh5hlnIn+yw4AUy2igK5C1deGnWkqu9GStd/IyzLw5r2j1mE3fvRzg860jmoDFRRfW
         okQj8KkUXQ8+wkbqJ56hgIN0H9xeXuaxw7MuLHEuS1Ou0eeGeV/8GQdrcp0vBWRhf6
         fQ1JDsnXrrCcQ==
Date:   Fri, 4 Feb 2022 16:10:32 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     "Anton V. Boyarshinov" <boyarsh@altlinux.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        ebiederm@xmission.com, legion@kernel.org, ldv@altlinux.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Add ability to disallow idmapped mounts
Message-ID: <20220204151032.7q22hgzcil4hqvkl@wittgenstein>
References: <20220204065338.251469-1-boyarsh@altlinux.org>
 <20220204094515.6vvxhzcyemvrb2yy@wittgenstein>
 <20220204132616.28de9c4a@tower>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220204132616.28de9c4a@tower>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 04, 2022 at 01:26:16PM +0300, Anton V. Boyarshinov wrote:
> В Fri, 4 Feb 2022 10:45:15 +0100
> Christian Brauner <brauner@kernel.org> пишет:
> 
> > If you want to turn off idmapped mounts you can already do so today via:
> > echo 0 > /proc/sys/user/max_user_namespaces
> 
> It turns off much more than idmapped mounts only. More fine grained
> control seems better for me.

If you allow user namespaces and not idmapped mounts you haven't reduced
your attack surface. An unprivileged user can reach much more
exploitable code simply via unshare -user --map-root -mount which we
still allow upstream without a second thought even with all the past and
present exploits (see
https://www.openwall.com/lists/oss-security/2022/01/29/1 for a current
one from this January).

> 
> > They can neither
> > be created as an unprivileged user nor can they be created inside user
> > namespaces.
> 
> But actions of fully privileged user can open non-obvious ways to
> privilege escalation.

A fully privileged user potentially being able to cause issues is really
not an argument; especially not for a new sysctl.
You need root to create idmapped mounts and you need root to turn off
the new knob.

It also trivially applies to a whole slew of even basic kernel tunables
basically everything that can be reached by unprivileged users after a
privileged user has turned it on or configured it.

After 2 years we haven't seen any issue with this code and while I'm not
promising that there won't ever be issues - nobody can do that - the
pure suspicion that there could be some is not a justification for
anything.
