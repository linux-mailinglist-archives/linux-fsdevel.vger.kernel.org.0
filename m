Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F417A64E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 15:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjISN20 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 09:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjISN2Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:28:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E19F1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 06:28:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E39D22949;
        Tue, 19 Sep 2023 13:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695130099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zn4x4Gh5bt52mVXJj8k43f9QiWV5xZgrPbGR8Dw7Ff8=;
        b=Xz+BiXZFWIj6JdwQRulEzDSXBlmliVa8M3gi92kepkVfiF5vP65ICya02RybNsWZLo9eVB
        asH4zz87SB8HOsAcQMEuzRK9vKbTGtcTfmeuOOAoQKMVH/T5iSmzwmG9EmfjtcRg6dc529
        NEt7sePw80DY26+0eqxf8OpSmzQtdZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695130099;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zn4x4Gh5bt52mVXJj8k43f9QiWV5xZgrPbGR8Dw7Ff8=;
        b=PTS39jakVa8gPlU3GXLp5hsYflil07eWgYYWiCmc0WFzEe7e4HYs4zz8SkSKZa6gpAEqCr
        0GNu4zo/8Oa5fPBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F1E7A134F3;
        Tue, 19 Sep 2023 13:28:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DO4BO/KhCWXDNAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 19 Sep 2023 13:28:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8CC09A0759; Tue, 19 Sep 2023 15:28:18 +0200 (CEST)
Date:   Tue, 19 Sep 2023 15:28:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Ivan Babrou <ivan@cloudflare.com>,
        Matthew Bobrowski <repnop@google.com>
Subject: Re: inotify maintenance status
Message-ID: <20230919132818.4s3n5bsqmokof6n2@quack3>
References: <CAKPOu+-Nx_cvBZNox63R1ah76wQp6eH4RLah0O5mDaLo9h60ww@mail.gmail.com>
 <20230918142319.kvzc3lcpn5n2ty6g@quack3>
 <CAOQ4uxic7C5skHv4d+Gek_uokRL8sgUegTusiGkwAY4dSSADYQ@mail.gmail.com>
 <CAOQ4uxjzf6NeoCaTrx_X0yZ0nMEWcQC_gq3M-j3jS+CuUTskSA@mail.gmail.com>
 <CAOQ4uxjkL+QEM+rkSOLahLebwXV66TwyxQhRj9xksnim5F-HFw@mail.gmail.com>
 <CAKPOu+_s8O=kfS1xq-cYGDcOD48oqukbsSA3tJT60FxC2eNWDw@mail.gmail.com>
 <20230919100112.nlb2t4nm46wmugc2@quack3>
 <CAKPOu+-apWRekyqRyYfsFkdx13uocCPKMzYJqmTsVEc6a=9uuA@mail.gmail.com>
 <CAOQ4uxgG6ync6dSBJiGW98docJGnajALiV+9tuwGiRt8NE8F+w@mail.gmail.com>
 <CAKPOu+9ds-dbq2-idehU5XR2s3Xz2NL-=fB+skKoN_zCym_OtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+9ds-dbq2-idehU5XR2s3Xz2NL-=fB+skKoN_zCym_OtA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 19-09-23 13:21:56, Max Kellermann wrote:
> On Tue, Sep 19, 2023 at 12:59 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > Getting an already-opened file descriptor, or just the file_handle, is
> > > certainly an interesting fanotify feature. But that could have easily
> > > been added to inotify with a new "mask" flag for the
> > > inotify_add_watch() function.
> > >
> >
> > "could have easily been added" is not a statement that I am willing
> > to accept.
> 
> Are you willing to take a bet? I come up with a patch for implementing
> this for inotify, let's say within a week, and you agree to merge it?

I guess no point in you wasting time for this. But if you'd try, I'll
really find out it isn't so easy. Inotify event is fixed length so
fsid+fhandle is completely out of the realm of "easy extension". If you
wanted to return fd instead of wd, that would be doable with some kind of a
flag in the mark mask, although it would be a bit inconsistent with the
rest of the inotify API.

> > The things that you are complaining about in the API are the exact
> > things that were needed to make the advanced features work.
> 
> Not exactly - I complain that fanotify makes the complexity mandatory,
> the complexity is the baseline of the API. It would have been possible
> to design an API that is simple for 99% of all users, as simple as
> inotify; and only those who need the advanced features get the
> complexity as an option.

Well yes, fanotify could have been designed to make basic usage easier. But
the design (some 15 years ago) was focusing more on filling in the
functional gaps inotify had for usecases such as anti-virus monitors etc.
and kind of left thinking about simple usecases for sometime later.
So we have what we have.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
