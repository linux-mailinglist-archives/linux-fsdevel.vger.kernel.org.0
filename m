Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B076ECBEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 14:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjDXMTl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 08:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDXMTk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 08:19:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8FC26B7;
        Mon, 24 Apr 2023 05:19:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7A0D81FD80;
        Mon, 24 Apr 2023 12:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682338777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tH3QxEeyp8kfWcz1bkYSovs9h7ImBxkgM1DNmDxhaJg=;
        b=U8Ap4Bg2ocGY4N9KLmdiXJ3k3RWwRz6oUO8RZlNHZWwp0un0OpL64bHpI1g3fOxb1woAsH
        ItgJw2Cfz+eEX4qrSxeIJ7TV4vEFeRG35WWd4R2qNqdsQhU9eLdW3kEbVVo4ns/APWjmbp
        zt0Ccr2Eo51bBlJsa3aempb+/gVFX88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682338777;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tH3QxEeyp8kfWcz1bkYSovs9h7ImBxkgM1DNmDxhaJg=;
        b=LaPP5aHf+gTxAxLtBoghtsddhF6BkLYkqb8AtLbjILPSAiTl5h9wfxFQ0tRi14O8X+GOMN
        4joBTRBV5KJviMCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B2B21390E;
        Mon, 24 Apr 2023 12:19:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3kogGtlzRmTzcAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 24 Apr 2023 12:19:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E8A34A0729; Mon, 24 Apr 2023 14:19:36 +0200 (CEST)
Date:   Mon, 24 Apr 2023 14:19:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC PATCH 0/3] permit write-sealed memfd read-only shared
 mappings
Message-ID: <20230424121936.lwgqty6hifs7eecp@quack3>
References: <cover.1680560277.git.lstoakes@gmail.com>
 <20230421090126.tmem27kfqamkdaxo@quack3>
 <b18577f5-86fe-4093-9058-07ba899f7dd6@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b18577f5-86fe-4093-9058-07ba899f7dd6@lucifer.local>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 21-04-23 22:23:12, Lorenzo Stoakes wrote:
> On Fri, Apr 21, 2023 at 11:01:26AM +0200, Jan Kara wrote:
> > Hi!
> >
> > On Mon 03-04-23 23:28:29, Lorenzo Stoakes wrote:
> > > This patch series is in two parts:-
> > >
> > > 1. Currently there are a number of places in the kernel where we assume
> > >    VM_SHARED implies that a mapping is writable. Let's be slightly less
> > >    strict and relax this restriction in the case that VM_MAYWRITE is not
> > >    set.
> > >
> > >    This should have no noticeable impact as the lack of VM_MAYWRITE implies
> > >    that the mapping can not be made writable via mprotect() or any other
> > >    means.
> > >
> > > 2. Align the behaviour of F_SEAL_WRITE and F_SEAL_FUTURE_WRITE on mmap().
> > >    The latter already clears the VM_MAYWRITE flag for a sealed read-only
> > >    mapping, we simply extend this to F_SEAL_WRITE too.
> > >
> > >    For this to have effect, we must also invoke call_mmap() before
> > >    mapping_map_writable().
> > >
> > > As this is quite a fundamental change on the assumptions around VM_SHARED
> > > and since this causes a visible change to userland (in permitting read-only
> > > shared mappings on F_SEAL_WRITE mappings), I am putting forward as an RFC
> > > to see if there is anything terribly wrong with it.
> >
> > So what I miss in this series is what the motivation is. Is it that you need
> > to map F_SEAL_WRITE read-only? Why?
> >
> 
> This originated from the discussion in [1], which refers to the bug
> reported in [2]. Essentially the user is write-sealing a memfd then trying
> to mmap it read-only, but receives an -EPERM error.
> 
> F_SEAL_FUTURE_WRITE _does_ explicitly permit this but F_SEAL_WRITE does not.
> 
> The fcntl() man page states:
> 
>     Furthermore, trying to create new shared, writable memory-mappings via
>     mmap(2) will also fail with EPERM.
> 
> So the kernel does not behave as the documentation states.
> 
> I took the user-supplied repro and slightly modified it, enclosed
> below. After this patch series, this code works correctly.
> 
> I think there's definitely a case for the VM_MAYWRITE part of this patch
> series even if the memfd bits are not considered useful, as we do seem to
> make the implicit assumption that MAP_SHARED == writable even if
> !VM_MAYWRITE which seems odd.

Thanks for the explanation! Could you please include this information in
the cover letter (perhaps in a form of a short note and reference to the
mailing list) for future reference? Thanks!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
