Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788E151D378
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 10:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390214AbiEFIjQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 04:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390195AbiEFIjN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 04:39:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7489AF21;
        Fri,  6 May 2022 01:35:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B066A21A32;
        Fri,  6 May 2022 08:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651826125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oLTw3J5HqlJGXaem/7/GBVpCJVJMfm3k1q3z73ZMkPw=;
        b=1Yy/gjrYQLm4DghIDFhD/IrLawONoyxXP5fOdpWyFVG4MSJevaI5r46X34PjzhRQ8GDjJ0
        eIo/wkkeVpmBxFTPWOi5XkpXYNGx+tQQBEF6QIRloZ2cfaf/2ELMa8SyrummqomKCkpYaJ
        aiakOCQQYpN+Slsuwruruoq1Uc8N6Rk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651826125;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oLTw3J5HqlJGXaem/7/GBVpCJVJMfm3k1q3z73ZMkPw=;
        b=l0VFkJAOc+cqSSLs18nzyG9/resunTOXRHoe0KSkn9/d64u9N6r2B5secCGatv/Bk+14Fm
        M3NdS/OdqZ7Bc+CA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2B9D12C142;
        Fri,  6 May 2022 08:35:25 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D0378A0629; Fri,  6 May 2022 10:35:23 +0200 (CEST)
Date:   Fri, 6 May 2022 10:35:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Richard Guy Briggs <rgb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>
Subject: Re: [PATCH v2 2/3] fanotify: define struct members to hold response
 decision context
Message-ID: <20220506083523.drdj2ahjw6abimus@quack3.lan>
References: <cover.1651174324.git.rgb@redhat.com>
 <17660b3f2817e5c0a19d1e9e5d40b53ff4561845.1651174324.git.rgb@redhat.com>
 <CAHC9VhQ3Qtpwhj6TeMR7rmdbUe_6VRHU9OymmDoDdsazeGuNKA@mail.gmail.com>
 <YnHX74E+COTp7AgY@madcap2.tricolour.ca>
 <20220505144456.nw6slyqw4pjizl5p@quack3.lan>
 <CAOQ4uxjkJ37Nzke4YN_se4ztr-yZgm6SK_LhmBQ-ckWutOwWrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjkJ37Nzke4YN_se4ztr-yZgm6SK_LhmBQ-ckWutOwWrQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 05-05-22 20:34:06, Amir Goldstein wrote:
> > One open question I have is what should the kernel do with 'info_type' in
> > response it does not understand (in the future when there are possibly more
> > different info types). It could just skip it because this should be just
> > additional info for introspection (the only mandatory part is in
> > fanotify_response, however it could surprise userspace that passed info is
> > just getting ignored. To solve this we would have to somewhere report
> > supported info types (maybe in fanotify fdinfo in proc). I guess we'll
> > cross that bridge when we get to it.
> >
> > Amir, what do you think?
> 
> Regardless if and how we provide a way to enumerate supported info types,
> I would prefer to reject (EINVAL) unknown info types.

OK, agreed. I will be also calmer when we do that because then we can be
certain userspace does not pass bogus data for unknown info types.

> We can provide a command FAN_RESPONSE_TEST to write a test response with
> FAN_NOFD and some extra info so the program can test if certain info
> types are supported.

Hum, that would be an option as well. We don't even need the
FAN_RESPONSE_TEST command, do we? The write to fanotify fd for FAN_NOFD fd
would just perform validation of the response and either accept it (do
nothing) or return EINVAL.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
