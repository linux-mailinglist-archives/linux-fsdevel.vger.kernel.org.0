Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE613692E94
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Feb 2023 07:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBKGSZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Feb 2023 01:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBKGSY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Feb 2023 01:18:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5C17102B
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 22:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676096256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+CTwGPJ6Nc46AzE4LIyhb9Ckm0HjZ8PmHDXQrmNlV6c=;
        b=UXRtm2fTH6aH16LmJyM6JsJGuzW1Nf0Z6QRyEB4nMquu1PoPMGkiTTezbsiAgxKP/N5/74
        10BAzTlQ+8YSRPEfXWyYPI8axl1bu2uw0MuD5lkRuGev1WiDg55f90FEHP1S9YEqIwIabw
        GrM5AR/Wv/SEwx1TKSsP7z3UyfOeVH8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-mXpfP7K7MgOq65-LwG78LQ-1; Sat, 11 Feb 2023 01:17:31 -0500
X-MC-Unique: mXpfP7K7MgOq65-LwG78LQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B5FE29AA3B7;
        Sat, 11 Feb 2023 06:17:30 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F3DD492C3F;
        Sat, 11 Feb 2023 06:17:22 +0000 (UTC)
Date:   Sat, 11 Feb 2023 14:17:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Andy Lutomirski <luto@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API Mailing List <linux-api@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Samba Technical <samba-technical@lists.samba.org>,
        ming.lei@redhat.com
Subject: Re: copy on write for splice() from file to pipe?
Message-ID: <Y+cy7tmxWM2HVnck@T590>
References: <1dd85095-c18c-ed3e-38b7-02f4d13d9bd6@kernel.dk>
 <CAHk-=wiszt6btMPeT5UFcS=0=EVr=0injTR75KsvN8WetwQwkA@mail.gmail.com>
 <fe8252bd-17bd-850d-dcd0-d799443681e9@kernel.dk>
 <CAHk-=wiJ0QKKiORkVr8n345sPp=aHbrLTLu6CQ-S0XqWJ-kJ1A@mail.gmail.com>
 <7a2e5b7f-c213-09ff-ef35-d6c2967b31a7@kernel.dk>
 <CALCETrVx4cj7KrhaevtFN19rf=A6kauFTr7UPzQVage0MsBLrg@mail.gmail.com>
 <b44783e6-3da2-85dd-a482-5d9aeb018e9c@kernel.dk>
 <2bb12591-9d24-6b26-178f-05e939bf3251@kernel.dk>
 <CAHk-=wjzqrD5wrfeaU390bXEEBY2JF-oKmFN4fREzgyXsbQRTQ@mail.gmail.com>
 <Y+cJDnnMuirSjO3E@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+cJDnnMuirSjO3E@T590>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 11, 2023 at 11:18:38AM +0800, Ming Lei wrote:
> On Fri, Feb 10, 2023 at 02:08:35PM -0800, Linus Torvalds wrote:
> > On Fri, Feb 10, 2023 at 1:51 PM Jens Axboe <axboe@kernel.dk> wrote:
> > >
> > > Speaking of splice/io_uring, Ming posted this today:
> > >
> > > https://lore.kernel.org/io-uring/20230210153212.733006-1-ming.lei@redhat.com/
> > 
> > Ugh. Some of that is really ugly. Both 'ignore_sig' and
> > 'ack_page_consuming' just look wrong. Pure random special cases.
> > 
> > And that 'ignore_sig' is particularly ugly, since the only thing that
> > sets it also sets SPLICE_F_NONBLOCK.
> > 
> > And the *only* thing that actually then checks that field is
> > 'splice_from_pipe_next()', where there are exactly two
> > signal_pending() checks that it adds to, and
> > 
> >  (a) the first one is to protect from endless loops
> > 
> >  (b) the second one is irrelevant when  SPLICE_F_NONBLOCK is set
> > 
> > So honestly, just NAK on that series.
> > 
> > I think that instead of 'ignore_sig' (which shouldn't exist), that
> > first 'signal_pending()' check in splice_from_pipe_next() should just
> > be changed into a 'fatal_signal_pending()'.
> 
> Good point, here the signal is often from task_work_add() called by
> io_uring.
> 
> > 
> > But that 'ack_page_consuming' thing looks even more disgusting, and
> > since I'm not sure why it even exists, I don't know what it's doing
> > wrong.
> 
> The motivation is for confirming that if the produced buffer can be used
> for READ or WRITE. Another way could be to add PIPE_BUF_FLAG_MAY_READ[WRITE].

BTW, I meant the added flags are source/sink private flags, which are
not used by generic pipe/splice code, just used by the actual source and
sink subsystem.

thanks,
Ming

