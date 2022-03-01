Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70B74C9146
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 18:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbiCARPk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 12:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbiCARPf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:15:35 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3441D1ADAB
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Mar 2022 09:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1646154892;
        bh=O/D2zKValhbOGYNIq7RDZAmh1ZA2A9hjwndCPc/GT1U=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=mWA0KN+xJXTZCBziVJ8ZcAwRVuH9K7HX72+DEr6KSQ/bPyiduli1CsQ2pdy8XdWZ9
         Ha3VISnFSAXXuZhc/j5Lr0sHlBEiryWaoiT54sWuaOLqECVQ8zuvnSytbb0tG6hdar
         M3jJlaZ45K10Wa5LENhzlD2uJooRECYtFwEH1fW4=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 11BEE1280138;
        Tue,  1 Mar 2022 12:14:52 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jqwo9RBqotGP; Tue,  1 Mar 2022 12:14:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1646154891;
        bh=O/D2zKValhbOGYNIq7RDZAmh1ZA2A9hjwndCPc/GT1U=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=F31IUcWEN9kSefDeM26uVL/pNoDrB4yEdX6LbGlAUYtI1gbsYccqUY+spMs8YW5Yk
         k0AN0XEoRxa7aT/5iMseaeAG3NLnohSJ0Vnd6Y32+LTELE6oG6Sce1uX5J5NnGzFj2
         4vJg8ieMh5pnnLy5CkHJXp55LhJNJR8/guQGazrQ=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c447])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4EAFE1280062;
        Tue,  1 Mar 2022 12:14:51 -0500 (EST)
Message-ID: <9735af01b28f73762a947a0794da63ae35bc06e0.camel@HansenPartnership.com>
Subject: Re: [LSF/MM/BPF TOPIC] configfd as a replacement for both ioctls
 and fsconfig
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Date:   Tue, 01 Mar 2022 12:14:49 -0500
In-Reply-To: <Yh5PdGxnnVru2/go@bombadil.infradead.org>
References: <2ee1eb2b46a3bbdbde4244634586655247f5c676.camel@HansenPartnership.com>
         <1476917.1643724793@warthog.procyon.org.uk>
         <Yh1swsJLXvLLIQ0e@bombadil.infradead.org>
         <3136665a674acd1c1cc18f12802684bf82fc8e36.camel@HansenPartnership.com>
         <Yh5PdGxnnVru2/go@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-03-01 at 08:53 -0800, Luis Chamberlain wrote:
> On Tue, Mar 01, 2022 at 11:47:56AM -0500, James Bottomley wrote:
> > On Mon, 2022-02-28 at 16:45 -0800, Luis Chamberlain wrote:
> > > On Tue, Feb 01, 2022 at 02:13:13PM +0000, David Howells wrote:
> > > > James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> > > > 
> > > > > If the ioctl debate goes against ioctls, I think configfd
> > > > > would
> > > > > present
> > > > > a more palatable alternative to netlink everywhere.
> > > > 
> > > > It'd be nice to be able to set up a 'configuration transaction'
> > > > and
> > > > then do a
> > > > commit to apply it all in one go.
> > > 
> > > Can't io-uring cmd effort help here?
> > 
> > What io-uring cmd effort? 
> 
> The file operations version is the latest posted effort:
> 
> https://lore.kernel.org/linux-nvme/20210317221027.366780-1-axboe@kernel.dk/

Oh, right ... I'm afraid for storage if it hasn't been across linux-
block or linux-scsi, I likely won't have seen it.  However, reading the
thread, it really does look like the added file operation

int (*uring_cmd)(struct io_uring_cmd *, enum io_uring_cmd_flags);

Is pretty similar to an async ioctl as Christoph said.

> > The one to add nvme completions?
> 
> Um, I would not call it that at all, but rather nvme passthrough. But
> yes that is possible. But so are many other things, not just ioctls,
> which is why I've been suggesting I think it does a disservice to the
> efforto just say its useful for ioctl over io-uring. Anything with
> a file_operations can tackle on cmd suport using io-uring as a
> train.

It looks fairly similar given the iouring syscalls are on an fd except
that the structure above hash to be defined and becomes an ABI.  Since
they configfd uses typed key value pairs, i'd argue it's more generic
and introspectable.

James


