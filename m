Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C446CCA49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 20:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjC1Swm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 14:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjC1Swk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 14:52:40 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5772135
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 11:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=BSOO71k3mqXO50E+4CfFzLkct+DKBDc3qM3+oxNcLUE=; b=G3bu1FZGh7+vS1fCT+huZjZaee
        6A7skAPCgAbAm2DEfmqKKBOiV9tCbHxJxKko5PTh0B2/NvapKVYPWAy7rfzPP8owP03eDsKPekBbr
        C9hGSlA3rG4ljyr888bP8yqeoRW+KcZ96cNk+WWN14VSQVs8thTY58/l95XFjw8QThUXUoUPNOwkB
        ebDf2ZSAnB+Rdf/PdLj4YXtcAGhfVGzTFmtjfmblqnPkX3YBD/S4mzAYe0GpcV0cAKmYhVBBFT3Ur
        OAFGVrjZAYjmcD58q2mY0BLGxAC5cJc5hE+/OvvrOvzeEe6Cgw5f0Nocq/dX8sWVb9uzF2ze4ETiD
        WM+UdLTA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phEQi-002uzb-2s;
        Tue, 28 Mar 2023 18:52:25 +0000
Date:   Tue, 28 Mar 2023 19:52:24 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 4/8] snd: make snd_map_bufs() deal with ITER_UBUF
Message-ID: <20230328185224.GM3390869@ZenIV>
References: <20230328173613.555192-1-axboe@kernel.dk>
 <20230328173613.555192-5-axboe@kernel.dk>
 <CAHk-=whiy4UmtfcpMSWSWRGvS1XGkqsPhZkLzi+Cph18FPJzbQ@mail.gmail.com>
 <2f94dc05-6803-e65c-196d-6b23cb56bc40@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f94dc05-6803-e65c-196d-6b23cb56bc40@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 11:52:10AM -0600, Jens Axboe wrote:
> On 3/28/23 11:50 AM, Linus Torvalds wrote:
> > On Tue, Mar 28, 2023 at 10:36 AM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> @@ -3516,23 +3516,28 @@ static void __user **snd_map_bufs(struct snd_pcm_runtime *runtime,
> >>                                   struct iov_iter *iter,
> >>                                   snd_pcm_uframes_t *frames, int max_segs)
> >>  {
> >> +       int nr_segs = iovec_nr_user_vecs(iter);
> > 
> > This has a WARN_ON_ONCE() for !user_backed, but then..
> > 
> >>         void __user **bufs;
> >> +       struct iovec iov;
> >>         unsigned long i;
> >>
> >>         if (!iter->user_backed)
> >>                 return ERR_PTR(-EFAULT);
> > 
> > here the code tries to deal with it.
> > 
> > So I think the two should probably be switched around.
> 
> True, it was actually like that before I refactored it to include
> that common helper. I'll swap them around, thanks.

Umm...  That looks really weird - if nothing else, it seems that this
thing quietly ignores the ->iov_len on all but the first iovec.

Might make sense to ask ALSA folks what the hell is going on there;
it's readv()/writev() on pcm device, and it looks like userland ABI
is really perverted here... ;-/
