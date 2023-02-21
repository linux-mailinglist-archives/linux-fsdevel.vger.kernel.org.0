Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2639869E98B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 22:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjBUVgn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 16:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBUVgm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:36:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD9D2823D;
        Tue, 21 Feb 2023 13:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BaGXgFyQLBB76avLNaPfA1e27u2MH8f6lBtt4CGYWC8=; b=wbr0xfaL7PNLLFkuCWxuuagZaK
        /gF5L15kL5mE6TF1g0f2ZDNH2XqbTrbbpet4k7kNdIKKu6VQby3azaLIPrnsMfhVsKfSg2krwr9OG
        q28HehKcenevUub/DgYTPsOVwq6jaON24x8cW13mYPEgxthaQC4mJfvzntfj31LkVKkk+hj1IPCrE
        aWrYDTulSlzgvdv614TvvYox7Pw+v9oSpiTp2u3jpLHY9Z/V4qakA10ZDDLmPzdAXpF7XBu5Kgjan
        HHNbeD0JDbT4RSoGUS718iaFuuJqhSpyb8OUrAcBvXrYT+XMUMlpDKTu5pJPP38i1LyoVl7f92nfY
        taqwQLow==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUaJL-009qNI-Tz; Tue, 21 Feb 2023 21:36:31 +0000
Date:   Tue, 21 Feb 2023 13:36:31 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: fix proc_dobool() usability
Message-ID: <Y/U5X5F0iFcpLwRK@bombadil.infradead.org>
References: <20230210145823.756906-1-omosnace@redhat.com>
 <63f500ba.170a0220.c76fc.1642@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63f500ba.170a0220.c76fc.1642@mx.google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 21, 2023 at 09:34:49AM -0800, Kees Cook wrote:
> On Fri, Feb 10, 2023 at 03:58:23PM +0100, Ondrej Mosnacek wrote:
> > Currently proc_dobool expects a (bool *) in table->data, but sizeof(int)
> > in table->maxsize, because it uses do_proc_dointvec() directly.
> > 
> > This is unsafe for at least two reasons:
> > 1. A sysctl table definition may use { .data = &variable, .maxsize =
> >    sizeof(variable) }, not realizing that this makes the sysctl unusable
> >    (see the Fixes: tag) and that they need to use the completely
> >    counterintuitive sizeof(int) instead.
> > 2. proc_dobool() will currently try to parse an array of values if given
> >    .maxsize >= 2*sizeof(int), but will try to write values of type bool
> >    by offsets of sizeof(int), so it will not work correctly with neither
> >    an (int *) nor a (bool *). There is no .maxsize validation to prevent
> >    this.
> > 
> > Fix this by:
> > 1. Constraining proc_dobool() to allow only one value and .maxsize ==
> >    sizeof(bool).
> > 2. Wrapping the original struct ctl_table in a temporary one with .data
> >    pointing to a local int variable and .maxsize set to sizeof(int) and
> >    passing this one to proc_dointvec(), converting the value to/from
> >    bool as needed (using proc_dou8vec_minmax() as an example).
> > 3. Extending sysctl_check_table() to enforce proc_dobool() expectations.
> > 4. Fixing the proc_dobool() docstring (it was just copy-pasted from
> >    proc_douintvec, apparently...).
> > 5. Converting all existing proc_dobool() users to set .maxsize to
> >    sizeof(bool) instead of sizeof(int).
> > 
> > Fixes: 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled")
> > Fixes: a2071573d634 ("sysctl: introduce new proc handler proc_dobool")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> 
> Ah nice, thanks for tracking this down.
> 
> Acked-by: Kees Cook <keescook@chromium.org>

Queued onto sysctl-next, will send to Linus as this is a fix too.

  Luis
