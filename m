Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E364C9293
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 19:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbiCASJV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 13:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiCASJU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:09:20 -0500
X-Greylist: delayed 3224 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Mar 2022 10:08:36 PST
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB1424590;
        Tue,  1 Mar 2022 10:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1646158116;
        bh=oA7Z0+gp/CQJwN2VOKG8lp6cub+k4O1rugLAobLbTmE=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=BrTEz/qjk5MdsRap1FRrvYd4empsmxGaBpXw/MnKCkscGgKLoxtZv9gDtaMRDHCGF
         gtvtzaB2lDXCL8dnR8CIsrlQAzgy1MRdDnHrsJGLiPR0a/wB2i1aU/ovU4Ck3e0I/X
         ChE10RMdqgbrhuEfUvts7VI7JYs1K9dElGzykS+Y=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 52A25128142D;
        Tue,  1 Mar 2022 13:08:36 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iakt3SzAvkyJ; Tue,  1 Mar 2022 13:08:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1646158116;
        bh=oA7Z0+gp/CQJwN2VOKG8lp6cub+k4O1rugLAobLbTmE=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=BrTEz/qjk5MdsRap1FRrvYd4empsmxGaBpXw/MnKCkscGgKLoxtZv9gDtaMRDHCGF
         gtvtzaB2lDXCL8dnR8CIsrlQAzgy1MRdDnHrsJGLiPR0a/wB2i1aU/ovU4Ck3e0I/X
         ChE10RMdqgbrhuEfUvts7VI7JYs1K9dElGzykS+Y=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c447])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8963E1281424;
        Tue,  1 Mar 2022 13:08:35 -0500 (EST)
Message-ID: <e05606aeeec6b46762596035d1933e8f8fd23406.camel@HansenPartnership.com>
Subject: Re: [LSF/MM/BPF TOPIC] configfd as a replacement for both ioctls
 and fsconfig
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Date:   Tue, 01 Mar 2022 13:08:34 -0500
In-Reply-To: <Yh5afaKFt0bmIs96@bombadil.infradead.org>
References: <2ee1eb2b46a3bbdbde4244634586655247f5c676.camel@HansenPartnership.com>
         <1476917.1643724793@warthog.procyon.org.uk>
         <Yh1swsJLXvLLIQ0e@bombadil.infradead.org>
         <3136665a674acd1c1cc18f12802684bf82fc8e36.camel@HansenPartnership.com>
         <Yh5PdGxnnVru2/go@bombadil.infradead.org>
         <9735af01b28f73762a947a0794da63ae35bc06e0.camel@HansenPartnership.com>
         <Yh5afaKFt0bmIs96@bombadil.infradead.org>
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

On Tue, 2022-03-01 at 09:40 -0800, Luis Chamberlain wrote:
> On Tue, Mar 01, 2022 at 12:14:49PM -0500, James Bottomley wrote:
> > It looks fairly similar given the iouring syscalls are on an fd
> > except
> > that the structure above hash to be defined and becomes an
> > ABI.  Since
> > they configfd uses typed key value pairs, i'd argue it's more
> > generic
> > and introspectable.
> 
> I'm not suggesting using io-uring cmd as a configuration alternative
> to configfd, I'm suggesting it can be an async *vehicle* for a bunch
> of configurations one might need to make in the kernel. If we want
> to reduce system call uses, we may want to allow something like
> configfd to accept a batch of configuration options as well, as a
> batcha, and a final commit to process them.

Well, that's effectively how it does operate.  Configfd like configfs
is a dedicated fd you open exclusively for the purpose of
configuration.  You send it the key/value pairs via the action system
call.  Although the patch sent used "basic" types as values, nothing
prevents them being composite types that are aggregated, which would be
an easy mechanism for batching.

However, I'd like to add a note of caution: just because we *can* do
batching with the interface doesn't mean we should.  One of the
benefits of using simple basic types is easy interpretation by things
like seccomp; the more complex you make the type, the more internal
knowledge the seccomp/ebpf script needs.

So can I ask just how important batching for configuration changes is?
I get that there's some overhead for doing effectively one syscall per
k/v pair, but configuration operations aren't usually that time
critical.  If you're sending passthrough, then I can see you don't want
a load of syscalls per op, but equally a passthrough is just an opaque
packet that's likely not introspectable anyway, so it's a single k/v
pair.

James



