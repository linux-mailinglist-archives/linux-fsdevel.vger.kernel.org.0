Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1B16F16EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 13:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345383AbjD1LkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 07:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjD1LkF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:40:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE5D5265;
        Fri, 28 Apr 2023 04:40:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BD2ED21F43;
        Fri, 28 Apr 2023 11:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682682002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7R9Sf3tgCYLQjm0iMHThCcLtOUS8QtmQNS+R373kWIE=;
        b=poH+EC3DBrXyp5MVCjaDDoFVBFM73VsbzJXVP+GyzyX8nb1A56CaSpza5gwFfwYugleLMJ
        6Q+PvpDK5t76yJq8bhIiKpRyxaOVUpVAankeSyfIjoX9xyLeAc8qfxQNPw8mJEEpCxS4I/
        x8Q0cLximHQvzDb0zGg4lwh6vW3TxXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682682002;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7R9Sf3tgCYLQjm0iMHThCcLtOUS8QtmQNS+R373kWIE=;
        b=LwEPG+0oEJv3yCtktSpcN3KlN9Q42NM3WgYNSCGzCg7fnjDkqZpMw3xreaLQNxWm+OKx4N
        dFIeAYDaZIhE3TBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0261138FA;
        Fri, 28 Apr 2023 11:40:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MLj4KpKwS2TaXwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 28 Apr 2023 11:40:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 24104A0729; Fri, 28 Apr 2023 13:40:02 +0200 (CEST)
Date:   Fri, 28 Apr 2023 13:40:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC][PATCH 0/4] Prepare for supporting more filesystems with
 fanotify
Message-ID: <20230428114002.3vqve7g76xonjs5f@quack3>
References: <20230425130105.2606684-1-amir73il@gmail.com>
 <dafbff6baa201b8af862ee3faf7fe948d2a026ab.camel@kernel.org>
 <CAOQ4uxjR0cdjW1Pr1DWAn+dkTd3SbV7CUqeGRh2FeDVBGAdtRw@mail.gmail.com>
 <df31058f662fe9ec9ad1cc59838f288b8aff10f0.camel@kernel.org>
 <CAOQ4uxhWzV7YJ_kPGg_4wHhWAd79_Xgo2uoDY+1K9sEtJcH_cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhWzV7YJ_kPGg_4wHhWAd79_Xgo2uoDY+1K9sEtJcH_cA@mail.gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 27-04-23 22:11:46, Amir Goldstein wrote:
> On Thu, Apr 27, 2023 at 7:36 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > There is also a way to extend the existing API with:
> > >
> > > Perhstruct file_handle {
> > >         unsigned int handle_bytes:8;
> > >         unsigned int handle_flags:24;
> > >         int handle_type;
> > >         unsigned char f_handle[];
> > > };
> > >
> > > AFAICT, this is guaranteed to be backward compat
> > > with old kernels and old applications.
> > >
> >
> > That could work. It would probably look cleaner as a union though.
> > Something like this maybe?
> >
> > union {
> >         unsigned int legacy_handle_bytes;
> >         struct {
> >                 u8      handle_bytes;
> >                 u8      __reserved;
> >                 u16     handle_flags;
> >         };
> > }
> 
> I have no problem with the union, but does this struct
> guarantee that the lowest byte of legacy_handle_bytes
> is in handle_bytes for all architectures?
> 
> That's the reason I went with
> 
> struct {
>          unsigned int handle_bytes:8;
>          unsigned int handle_flags:24;
> }
> 
> Is there a problem with this approach?

As I'm thinking about it there are problems with both approaches in the
uAPI. The thing is: A lot of bitfield details (even whether they are packed
to a single int or not) are implementation defined (depends on the
architecture as well as the compiler) so they are not really usable in the
APIs.

With the union, things are well-defined but they would not work for
big-endian architectures. We could make the structure layout depend on the
endianity but that's quite ugly...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
