Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C69718E6A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 00:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjEaW0k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 18:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjEaW0j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 18:26:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B1E121;
        Wed, 31 May 2023 15:26:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89027638CF;
        Wed, 31 May 2023 22:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C3FC433EF;
        Wed, 31 May 2023 22:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1685571996;
        bh=GLdTZT4HM6RZRsPHV8a0vMFjHc8lEpx8uCyJo3MeHgU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TZMfM5rswADqWCsRolufOd8giHly7EDvFZjm1j2z6+ao1px7qYu7rmis+fh7q7wGx
         rgHvIqscK/GbFqLhz4wF4JJ7Ti8LQijh8/3GQ27JAo6Vg53xEFp4FaPH6GtmKGcBb1
         PP3FRUr1LW7tUfBJ7nySU1daueFlDWgKO3TZH7MY=
Date:   Wed, 31 May 2023 15:26:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Benjamin Segall <bsegall@google.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH RESEND] epoll: ep_autoremove_wake_function should use
 list_del_init_careful
Message-Id: <20230531152635.e8bb796bee235977c141138c@linux-foundation.org>
In-Reply-To: <xm26ilc8uoz6.fsf@google.com>
References: <xm26pm6hvfer.fsf@google.com>
        <20230531015748.GB1648@quark.localdomain>
        <20230531-zupacken-laute-22564cd952f7@brauner>
        <xm26ilc8uoz6.fsf@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 31 May 2023 15:15:41 -0700 Benjamin Segall <bsegall@google.com> wrote:

> >> Can you please provide a more detailed explanation about why
> >> list_del_init_careful() is needed here?
> >
> > Yeah, this needs more explanation... Next time someone looks at this
> > code and there's a *_careful() added they'll want to know why.
> 
> So the general reason is the same as with autoremove_wake_function, it
> pairs with the list_entry_careful in ep_poll (which is epoll's modified
> copy of finish_wait).
> 
> I think the original actual _problem_ was a -stable issue that was fixed
> instead by doing additional backports, so this may just avoid potential
> extra loops and avoid potential compiler shenanigans from the data race.

The point is that the foo_careful() callsites should be commented, please.
