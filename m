Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB193D9909
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 00:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhG1WvA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 18:51:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41274 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhG1WvA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 18:51:00 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 181FF222F0;
        Wed, 28 Jul 2021 22:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627512657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tUEOsvvUIOuI1HIMa4PjI1BF+bZxtkgy+G2Q3z4Ys6g=;
        b=OWBvF8PVwFJQ1nlDkLsGwLbqNQxTZz74jyxvzI+FxjLM3jNT1mAH2bz/QI6C2XROOBQ/m1
        /zJkUHBJ9yAI8QM+QAjJPdhu2wDaidg6TpYEkewz2Mah6rBz1kMc7YKBvzWzcGd+vyVTf7
        5xIkcwpnZuIeKALI/Tg+9RPighwQEF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627512657;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tUEOsvvUIOuI1HIMa4PjI1BF+bZxtkgy+G2Q3z4Ys6g=;
        b=r8erBIibIGxkeHylhY3WZz8ZIQA//m/H7RaPG6YnwJMiwFooQ46AASK9PbXKB5bFpbevuo
        0xzYoNn8/zY0RdDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EF4013481;
        Wed, 28 Jul 2021 22:50:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id og/gEk3fAWF3YwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 28 Jul 2021 22:50:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Neal Gompa" <ngompa13@gmail.com>
Cc:     "Wang Yugui" <wangyugui@e16-tech.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        linux-nfs@vger.kernel.org,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
In-reply-to: <CAEg-Je8Pqbw0tTw6NWkAcD=+zGStOJR0J-409mXuZ1vmb6dZsA@mail.gmail.com>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <20210728125819.6E52.409509F4@e16-tech.com>,
 <20210728140431.D704.409509F4@e16-tech.com>,
 <162745567084.21659.16797059962461187633@noble.neil.brown.name>,
 <CAEg-Je8Pqbw0tTw6NWkAcD=+zGStOJR0J-409mXuZ1vmb6dZsA@mail.gmail.com>
Date:   Thu, 29 Jul 2021 08:50:50 +1000
Message-id: <162751265073.21659.11050133384025400064@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gV2VkLCAyOCBKdWwgMjAyMSwgTmVhbCBHb21wYSB3cm90ZToKPiBPbiBXZWQsIEp1bCAyOCwg
MjAyMSBhdCAzOjAyIEFNIE5laWxCcm93biA8bmVpbGJAc3VzZS5kZT4gd3JvdGU6Cj4gPgo+ID4g
T24gV2VkLCAyOCBKdWwgMjAyMSwgV2FuZyBZdWd1aSB3cm90ZToKPiA+ID4gSGksCj4gPiA+Cj4g
PiA+IFRoaXMgcGF0Y2hzZXQgd29ya3Mgd2VsbCBpbiA1LjE0LXJjMy4KPiA+Cj4gPiBUaGFua3Mg
Zm9yIHRlc3RpbmcuCj4gPgo+ID4gPgo+ID4gPiAxLCBmaXhlZCBkdW1teSBpbm9kZSgyNTUsIEJU
UkZTX0ZJUlNUX0ZSRUVfT0JKRUNUSUQgLSAxICkgIGlzIGNoYW5nZWQgdG8KPiA+ID4gZHluYW1p
YyBkdW1teSBpbm9kZSgxODQ0Njc0NDA3MzcwOTU1MTM1OCwgb3IgMTg0NDY3NDQwNzM3MDk1NTEz
NTksIC4uLikKPiA+Cj4gPiBUaGUgQlRSRlNfRklSU1RfRlJFRV9PQkpFQ1RJRC0xIHdhcyBhIGp1
c3QgYSBoYWNrLCBJIG5ldmVyIHdhbnRlZCBpdCB0bwo+ID4gYmUgcGVybWFuZW50Lgo+ID4gVGhl
IG5ldyBudW1iZXIgaXMgVUxPTkdfTUFYIC0gc3Vidm9sX2lkICh3aGVyZSBzdWJ2b2xfaWQgc3Rh
cnRzIGF0IDI1NyBJCj4gPiB0aGluaykuCj4gPiBUaGlzIGlzIGEgYml0IGxlc3Mgb2YgYSBoYWNr
LiAgSXQgaXMgYW4gZWFzaWx5IGF2YWlsYWJsZSBudW1iZXIgdGhhdCBpcwo+ID4gZmFpcmx5IHVu
aXF1ZS4KPiA+Cj4gPiA+Cj4gPiA+IDIsIGJ0cmZzIHN1YnZvbCBtb3VudCBpbmZvIGlzIHNob3du
IGluIC9wcm9jL21vdW50cywgZXZlbiBpZiBuZnNkL25mcyBpcwo+ID4gPiBub3QgdXNlZC4KPiA+
ID4gL2Rldi9zZGMgICAgICAgICAgICAgICAgYnRyZnMgICA5NEcgIDMuNU0gICA5M0cgICAxJSAv
bW50L3Rlc3QKPiA+ID4gL2Rldi9zZGMgICAgICAgICAgICAgICAgYnRyZnMgICA5NEcgIDMuNU0g
ICA5M0cgICAxJSAvbW50L3Rlc3Qvc3ViMQo+ID4gPiAvZGV2L3NkYyAgICAgICAgICAgICAgICBi
dHJmcyAgIDk0RyAgMy41TSAgIDkzRyAgIDElIC9tbnQvdGVzdC9zdWIyCj4gPiA+Cj4gPiA+IFRo
aXMgaXMgYSB2aXNpdWFsIGZlYXR1cmUgY2hhbmdlIGZvciBidHJmcyB1c2VyLgo+ID4KPiA+IEhv
cGVmdWxseSBpdCBpcyBhbiBpbXByb3ZlbWVudC4gIEJ1dCBpdCBpcyBjZXJ0YWlubHkgYSBjaGFu
Z2UgdGhhdCBuZWVkcwo+ID4gdG8gYmUgY2FyZWZ1bGx5IGNvbnNpZGVyZWQuCj4gCj4gSSB0aGlu
ayB0aGlzIGlzIGJlaGF2aW9yIHBlb3BsZSBnZW5lcmFsbHkgZXhwZWN0LCBidXQgSSB3b25kZXIg
d2hhdAo+IHRoZSBjb25zZXF1ZW5jZXMgb2YgdGhpcyB3b3VsZCBiZSB3aXRoIGh1Z2UgbnVtYmVy
cyBvZiBzdWJ2b2x1bWVzLiBJZgo+IHRoZXJlIGFyZSBodW5kcmVkcyBvciB0aG91c2FuZHMgb2Yg
dGhlbSAod2hpY2ggaXMgcXVpdGUgcG9zc2libGUgb24KPiBTVVNFIHN5c3RlbXMsIGZvciBleGFt
cGxlLCB3aXRoIGl0cyBhdXRvLXNuYXBzaG90dGluZyByZWdpbWUpLCB0aGlzCj4gd291bGQgYmUg
YSBtZXNzLCB3b3VsZG4ndCBpdD8KCldvdWxkIHRoZXJlIGJlIGh1bmRyZWRzIG9yIHRob3VzYW5k
cyBvZiBzdWJ2b2xzIGNvbmN1cnJlbnRseSBiZWluZwphY2Nlc3NlZD8gVGhlIGF1dG8tbW91bnRl
ZCBzdWJ2b2xzIG9ubHkgYXBwZWFyIGluIHRoZSBtb3VudCB0YWJsZSB3aGlsZQp0aGF0IGFyZSBi
ZWluZyBhY2Nlc3NlZCwgYW5kIGZvciBhYm91dCAxNSBtaW51dGVzIGFmdGVyIHRoZSBsYXN0IGFj
Y2Vzcy4KSSBzdXNwZWN0IHRoYXQgbW9zdCBzdWJ2b2xzIGFyZSAiYmFja3VwIiBzbmFwc2hvdHMg
d2hpY2ggYXJlIG5vdCBiZWluZwphY2Nlc3NlZCBhbmQgc28gd291bGQgbm90IGFwcGVhci4KCj4g
Cj4gT3IgY2FuIHdlIGFkZCBhIHdheSB0byBtYXJrIHRoZXNlIHRoaW5ncyB0byBub3Qgc2hvdyB1
cCB0aGVyZSBvciBpcwo+IHRoZXJlIHNvbWUga2luZCBvZiBiZWhhdmlvcmFsIGNoYW5nZSB3ZSBj
YW4gbWFrZSB0byBzbmFwcGVyIG9yIG90aGVyCj4gdG9vbHMgdG8gbWFrZSB0aGVtIG5vdCBzaG93
IHVwIGhlcmU/CgpDZXJ0YWlubHkgaXQgbWlnaHQgbWFrZSBzZW5zZSB0byBmbGFnIHRoZXNlIGlu
IHNvbWUgd2F5IHNvIHRoYXQgdG9vbHMKY2FuIGNob29zZSB0aGUgaWdub3JlIHRoZW0gb3IgaGFu
ZGxlIHRoZW0gc3BlY2lhbGx5LCBqdXN0IGFzIG5mc2QgbmVlZHMKdG8gaGFuZGxlIHRoZW0gc3Bl
Y2lhbGx5LiAgSSB3YXMgY29uc2lkZXJpbmcgYSAibG9jYWwiIG1vdW50IGZsYWcuCgpOZWlsQnJv
d24KCj4gCj4gCj4gCj4gLS0gCj4g55yf5a6f44Gv44GE44Gk44KC5LiA44Gk77yBLyBBbHdheXMs
IHRoZXJlJ3Mgb25seSBvbmUgdHJ1dGghCj4gCj4gCg==
