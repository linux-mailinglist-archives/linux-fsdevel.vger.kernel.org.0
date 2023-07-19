Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDE1758D56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 07:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjGSFxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 01:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjGSFxj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:53:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1101BE4;
        Tue, 18 Jul 2023 22:53:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04BD760DC4;
        Wed, 19 Jul 2023 05:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DC7C433C8;
        Wed, 19 Jul 2023 05:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689746017;
        bh=aywEw/AmSRDj44TqyKHStE06G9Ia/QUCsNAlMJZIVQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zoviut2a5oN8OG+pL0hvBPq7O9nZ6yilQHwGmc/l0QxiQzqvWelREUDCgf4/8YVdJ
         bhC9B+9THF0RSOgfynBKs22ZGTn6L0+4gNQ1kNlmMrdSfdMon2gMt1N94jghVIpuy9
         XOyRk+AZkz7eVOaizEfpoWnQQGT+/mh6niUZ60yvpBvqqgsZapCLOz3xYW1QSwFs+Z
         izBwETlm/KEDVuONHCMZ85W3kit37b0klhXK0TZUzAGp1wuF+PjsHfvKi6GE3ljCyG
         2sFI3g4TGg5I0rw8b1gqYlraooBnF/fFdf0ripFZHtVsKcEFsBXczEOogTRzkbJR6J
         9yyV8SVTL7ilw==
Date:   Wed, 19 Jul 2023 07:53:32 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Bill O'Donnell <billodo@redhat.com>,
        Rob Barnes <robbarnes@google.com>, bleung@chromium.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: export emergency_sync
Message-ID: <20230719-zwinkert-raddampfer-6f11fdc0cf8f@brauner>
References: <20230718214540.1.I763efc30c57dcc0284d81f704ef581cded8960c8@changeid>
 <ZLcOcr6N+Ty59rBD@redhat.com>
 <ad539fad-999b-46cd-9372-a196469b4631@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad539fad-999b-46cd-9372-a196469b4631@roeck-us.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 18, 2023 at 09:08:06PM -0700, Guenter Roeck wrote:
> On Tue, Jul 18, 2023 at 05:13:06PM -0500, Bill O'Donnell wrote:
> > On Tue, Jul 18, 2023 at 09:45:40PM +0000, Rob Barnes wrote:
> > > emergency_sync forces a filesystem sync in emergency situations.
> > > Export this function so it can be used by modules.
> > > 
> > > Signed-off-by: Rob Barnes <robbarnes@google.com>
> > 
> > Example of an emergency situation?
> 
> An example from existing code in
> drivers/firmware/arm_scmi/scmi_power_control.c:
> 
> static inline void
> scmi_request_forceful_transition(struct scmi_syspower_conf *sc)
> {
>         dev_dbg(sc->dev, "Serving forceful request:%d\n",
>                 sc->required_transition);
> 
> #ifndef MODULE
>         emergency_sync();
> #endif
> 
> Arguably emergency_sync() should also be called if the file is built
> as module.
> 
> Either case, I think it would make sense to add an example to the commit
> description.

On vacation until next. Please add a proper rationale why and who this
export is needed by in the commit message. As right now it looks like
someone thought it would be good to have which is not enough for
something to become an export.
