Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89407828FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 14:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbjHUM2F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 08:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjHUM2E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:28:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD92AEC
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 05:28:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 663C2206B4;
        Mon, 21 Aug 2023 12:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692620880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Nv8a4VpZFEdvFkpUhkUUT54Ej731/jz/sTc5cC2qqg=;
        b=ETvZhHm7vuO2xJSh0z/AwMN1G5T0UsgGrMI+DpDne7fqrFOgv3aL83XnvSEYpsen8JEkp2
        JZlL19odXwfJER9V1MrWd7+sPfnyUKkwpHlaNkQ4JtnLmtAKwQUHlPwMI1IXDAv2CQ4yEH
        cCTVn/o8GdOOggZ+J3FXQbPArAYJJvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692620880;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Nv8a4VpZFEdvFkpUhkUUT54Ej731/jz/sTc5cC2qqg=;
        b=0pOufcx//lZ4RnwT0I1ifyNXuJwFMYAhZiP2AFo+AfXdFwATvhjoo6P/Il0gq/ge/N+Foq
        8358fKSe4P2vvkCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5848D1330D;
        Mon, 21 Aug 2023 12:28:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RJONFVBY42TePAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 21 Aug 2023 12:28:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DEFF2A0774; Mon, 21 Aug 2023 14:27:59 +0200 (CEST)
Date:   Mon, 21 Aug 2023 14:27:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] kiocb_{start,end}_write() helpers
Message-ID: <20230821122759.zuhq3hbhhl5k36rn@quack3>
References: <20230817141337.1025891-1-amir73il@gmail.com>
 <20230817-situiert-eisstadion-cdf3b6b69539@brauner>
 <CAOQ4uxhzwON0hAjCPedTXm9E_iHp58Boy9XiXUtsQHY4uEJzKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhzwON0hAjCPedTXm9E_iHp58Boy9XiXUtsQHY4uEJzKQ@mail.gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 21-08-23 14:35:14, Amir Goldstein wrote:
> On Thu, Aug 17, 2023 at 5:56 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Thu, Aug 17, 2023 at 05:13:30PM +0300, Amir Goldstein wrote:
> > > Christian,
> > >
> > > This is an attempt to consolidate the open coded lockdep fooling in
> > > all those async io submitters into a single helper.
> > > The idea to do that consolidation was suggested by Jan.
> > >
> > > This re-factoring is part of a larger vfs cleanup I am doing for
> > > fanotify permission events.  The complete series is not ready for
> > > prime time yet, but this one patch is independent and I would love
> > > to get it reviewed/merged a head of the rest.
> > >
> > > This v3 series addresses the review comments of Jens on v2 [1].
> >
> > I have neither quarrels nor strong opinions on this so if Jens tells me
> > it looks fine to him I can take it.
> 
> That would be great.
> 
> Jens, do you approve of v3?
> 
> Jan, I see that you acked all patches except for 4/7 - I assume this
> was an oversight?

Yes, posted now.
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
