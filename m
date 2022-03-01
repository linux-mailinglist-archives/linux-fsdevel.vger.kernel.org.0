Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A764C90E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 17:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbiCAQtF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 11:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236515AbiCAQtB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:49:01 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F395713D74;
        Tue,  1 Mar 2022 08:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1646153279;
        bh=OP37Wf/UiJdCXNORPettkGkPpLmMDNxDVbx2wN4BIcg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=s3R373VjgFxWS9odloS5Kj0ZrMtHdpb/+wn5Dt5FGlgPOnokqBBWj3/zpn1XiAXWx
         O3jQB6TmLo9t8PJ+UmpnZ5KiC6efwlTpKzlhQO/OA1IeoKCRFYn8YGioQ5n8aTnyXX
         bhldOhcB+Xvb3PpzIDDkaVVmI+ANXO5E+gkiQ8lI=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 104151281388;
        Tue,  1 Mar 2022 11:47:59 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lKZjA89BR6DT; Tue,  1 Mar 2022 11:47:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1646153278;
        bh=OP37Wf/UiJdCXNORPettkGkPpLmMDNxDVbx2wN4BIcg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=YCsFr020DElEN0agdm3lsZxqKyVpoqfykILrqyUfyH9ToTc+fgBoV+U8A3Y4m5G5R
         NlARpm9gPJ/Aw2VvOVP2BGv9J90AtRMq2sDamMoFFiFFvh8AAM1+yF+LU1PW/0cqpM
         tKaaCfzMxlAgn5DUKvGjiXf2d4KKo2ZUGRlglYMM=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c447])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 472E21281387;
        Tue,  1 Mar 2022 11:47:58 -0500 (EST)
Message-ID: <3136665a674acd1c1cc18f12802684bf82fc8e36.camel@HansenPartnership.com>
Subject: Re: [LSF/MM/BPF TOPIC] configfd as a replacement for both ioctls
 and fsconfig
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Date:   Tue, 01 Mar 2022 11:47:56 -0500
In-Reply-To: <Yh1swsJLXvLLIQ0e@bombadil.infradead.org>
References: <2ee1eb2b46a3bbdbde4244634586655247f5c676.camel@HansenPartnership.com>
         <1476917.1643724793@warthog.procyon.org.uk>
         <Yh1swsJLXvLLIQ0e@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-02-28 at 16:45 -0800, Luis Chamberlain wrote:
> On Tue, Feb 01, 2022 at 02:13:13PM +0000, David Howells wrote:
> > James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> > 
> > > If the ioctl debate goes against ioctls, I think configfd would
> > > present
> > > a more palatable alternative to netlink everywhere.
> > 
> > It'd be nice to be able to set up a 'configuration transaction' and
> > then do a
> > commit to apply it all in one go.
> 
> Can't io-uring cmd effort help here?

What io-uring cmd effort?  The one to add nvme completions?  If it's
the completions one, then the configfs interface currently doesn't have
an event notifier, which is what the completions patch set seems to
require.  On the other hand configfd is key/value for get/set with an
atomic activate using an fd, so it stands to reason epoll support could
be added for events on the fd ... we'd just have to define a retrieval
key for an indicator to say which events are ready.

James


