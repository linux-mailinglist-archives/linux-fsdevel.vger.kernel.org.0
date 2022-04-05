Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFBA4F22AF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Apr 2022 07:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiDEFuY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 01:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiDEFuX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 01:50:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36C491;
        Mon,  4 Apr 2022 22:48:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 59FF91F38C;
        Tue,  5 Apr 2022 05:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649137704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1r2orMrVQp/4ILk838S1tDzUbcjwXJeLpgvBNYW22Ck=;
        b=HC72URascQxUqzcuXkfB+sEZA54o97vGoK5spXM0ibpz+w23NT1NuCASZtgNDsN+6T6N03
        9U3bPZKROCgLzp6OKRhIx1UlawtZRAafvcyaSqpXw+9GFLtimOiMLHbegz3+DD6fbHVB79
        GsHVeMWiOkRmbt0uvvTXSXTZ7FwNd+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649137704;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1r2orMrVQp/4ILk838S1tDzUbcjwXJeLpgvBNYW22Ck=;
        b=5wcdIsL9plpl8ZiUGcInouKSsFfnwSu1Ty4HkDbJZLsVBGtcSmEWnrpY/GfvfwnzcHRXiv
        yy19/2oPrV+i7zBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C070913216;
        Tue,  5 Apr 2022 05:48:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gqqVHybYS2KaSAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 05 Apr 2022 05:48:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Matthew Wilcox" <willy@infradead.org>
Cc:     linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, "Miaohe Lin" <linmiaohe@huawei.com>
Subject: Re: [RFC] Documentation for folio_lock() and friends
In-reply-to: <YkspW4HDL54xEg69@casper.infradead.org>
References: <YkspW4HDL54xEg69@casper.infradead.org>
Date:   Tue, 05 Apr 2022 15:48:19 +1000
Message-id: <164913769939.10985.13675614818955421206@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 05 Apr 2022, Matthew Wilcox wrote:
> It's a shame to not have these functions documented.  I'm sure I've
> missed a few things that would be useful to document here.
>=20
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index ab47579af434..47b7851f1b64 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -888,6 +888,18 @@ bool __folio_lock_or_retry(struct folio *folio, struct=
 mm_struct *mm,
>  void unlock_page(struct page *page);
>  void folio_unlock(struct folio *folio);
> =20
> +/**
> + * folio_trylock() - Attempt to lock a folio.
> + * @folio: The folio to attempt to lock.
> + *
> + * Sometimes it is undesirable to wait for a folio to be unlocked (eg
> + * when the locks are being taken in the wrong order, or if making
> + * progress through a batch of folios is more important than processing
> + * them in order).  Usually folio_lock() is the correct function to call.

Usually?
I think a "see also" type reference to folio_lock() is useful, but I
don't think "usually" is helpful.

> + *
> + * Context: Any context.
> + * Return: Whether the lock was successfully acquired.
> + */
>  static inline bool folio_trylock(struct folio *folio)
>  {
>  	return likely(!test_and_set_bit_lock(PG_locked, folio_flags(folio, 0)));
> @@ -901,6 +913,26 @@ static inline int trylock_page(struct page *page)
>  	return folio_trylock(page_folio(page));
>  }
> =20
> +/**
> + * folio_lock() - Lock this folio.
> + * @folio: The folio to lock.
> + *
> + * The folio lock protects against many things, probably more than it
> + * should.  It is primarily held while a folio is being read from storage,
> + * either from its backing file or from swap.  It is also held while a
> + * folio is being truncated from its address_space.
> + *
> + * Holding the lock usually prevents the contents of the folio from being
> + * modified by other kernel users, although it does not prevent userspace
> + * from modifying data if it's mapped.  The lock is not consistently held
> + * while a folio is being modified by DMA.

I don't think this paragraph is helpful...  maybe if it listed which
change *are* prevented by the lock, rather than a few which aren't?

I think it is significant that the lock prevents removal from the page
cache, and so ->mapping is only stable while the lock is held.  It might
be worth adding something about that.

> + *
> + * Context: May sleep.  If you need to acquire the locks of two or
> + * more folios, they must be in order of ascending index, if they are
> + * in the same address_space.  If they are in different address_spaces,
> + * acquire the lock of the folio which belongs to the address_space which
> + * has the lowest address in memory first.
> + */
>  static inline void folio_lock(struct folio *folio)
>  {
>  	might_sleep();
> @@ -908,6 +940,17 @@ static inline void folio_lock(struct folio *folio)
>  		__folio_lock(folio);
>  }
> =20
> +/**
> + * lock_page() - Lock the folio containing this page.
> + * @page: The page to lock.
> + *
> + * See folio_lock() for a description of what the lock protects.
> + * This is a legacy function and new code should probably use folio_lock()
> + * instead.
> + *
> + * Context: May sleep.  Pages in the same folio share a lock, so do not
> + * attempt to lock two pages which share a folio.
> + */
>  static inline void lock_page(struct page *page)
>  {
>  	struct folio *folio;
> @@ -918,6 +961,16 @@ static inline void lock_page(struct page *page)
>  		__folio_lock(folio);
>  }
> =20
> +/**
> + * folio_lock_killable() - Lock this folio, interruptible by a fatal signa=
l.
> + * @folio: The folio to lock.
> + *
> + * Attempts to lock the folio, like folio_lock(), except that the sleep
> + * to acquire the lock is interruptible by a fatal signal.
> + *
> + * Context: May sleep; see folio_lock().
> + * Return: 0 if the lock was acquired; -EINTR if a fatal signal was receiv=
ed.
> + */
>  static inline int folio_lock_killable(struct folio *folio)
>  {
>  	might_sleep();
> @@ -964,8 +1017,8 @@ int folio_wait_bit_killable(struct folio *folio, int b=
it_nr);
>   * Wait for a folio to be unlocked.
>   *
>   * This must be called with the caller "holding" the folio,
> - * ie with increased "page->count" so that the folio won't
> - * go away during the wait..
> + * ie with increased folio reference count so that the folio won't
> + * go away during the wait.
>   */
>  static inline void folio_wait_locked(struct folio *folio)
>  {
>=20
>=20

Thanks,
NeilBrown
