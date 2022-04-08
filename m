Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003A24F8C33
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 05:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbiDHCsU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 22:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiDHCsT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 22:48:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81289149D3F;
        Thu,  7 Apr 2022 19:46:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A96E3215FE;
        Fri,  8 Apr 2022 02:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649385974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ad4aaC1p/NUZAFCSgIPoIiGM8WB7pjKOKC8e19ZB8pM=;
        b=pQxm8zalF379/qnu1jJC17yhQ7mnQ4AGdfR+/H0D11aChPuaN2D4qKqGbPBwV7369TNJzl
        4+FjIZgXTKJPreXlCvaTmJQbsoklo+TgL4r+rDGb9lgS/fTfnywCFu7+UyMc7aaz+wtrR+
        EUSDUwXezYYO5cb0G+0xrgYbsI9aqPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649385974;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ad4aaC1p/NUZAFCSgIPoIiGM8WB7pjKOKC8e19ZB8pM=;
        b=lZTAfaLXVVUbo/QwKSZzfLobCh9hcuNTACeYhWOc++SdPxszOo5kaleJ3XXs5HmQRERcXq
        DmjqzUJK+fHQEmCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A7D3313314;
        Fri,  8 Apr 2022 02:46:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4El/GPShT2J4QwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 08 Apr 2022 02:46:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: sporadic hangs on generic/186
In-reply-to: <43aace26d3a09f868f732b2ad94ca2dbf90f50bd.camel@hammerspace.com>
References: <20220406195424.GA1242@fieldses.org>,
 <20220407001453.GE1609613@dread.disaster.area>,
 <164929126156.10985.11316778982526844125@noble.neil.brown.name>,
 <164929437439.10985.5253499040284089154@noble.neil.brown.name>,
 <b282c5b98c4518952f62662ea3ba1d4e6ef85f26.camel@hammerspace.com>,
 <164930468885.10985.9905950866720150663@noble.neil.brown.name>,
 <43aace26d3a09f868f732b2ad94ca2dbf90f50bd.camel@hammerspace.com>
Date:   Fri, 08 Apr 2022 12:46:08 +1000
Message-id: <164938596863.10985.998515507989861871@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAwNyBBcHIgMjAyMiwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+IE9uIFRodSwgMjAy
Mi0wNC0wNyBhdCAxNDoxMSArMTAwMCwgTmVpbEJyb3duIHdyb3RlOgo+ID4gT24gVGh1LCAwNyBB
cHIgMjAyMiwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+ID4gPiBPbiBUaHUsIDIwMjItMDQtMDcg
YXQgMTE6MTkgKzEwMDAsIE5laWxCcm93biB3cm90ZToKPiA+ID4gPiBPbiBUaHUsIDA3IEFwciAy
MDIyLCBOZWlsQnJvd24gd3JvdGU6Cj4gPiA+ID4gPiBPbiBUaHUsIDA3IEFwciAyMDIyLCBEYXZl
IENoaW5uZXIgd3JvdGU6Cj4gPiA+ID4gPiA+IE9uIFdlZCwgQXByIDA2LCAyMDIyIGF0IDAzOjU0
OjI0UE0gLTA0MDAsIEouIEJydWNlIEZpZWxkcwo+ID4gPiA+ID4gPiB3cm90ZToKPiA+ID4gPiA+
ID4gPiBJbiB0aGUgbGFzdCBjb3VwbGUgZGF5cyBJJ3ZlIHN0YXJ0ZWQgZ2V0dGluZyBoYW5ncyBv
bgo+ID4gPiA+ID4gPiA+IHhmc3Rlc3RzCj4gPiA+ID4gPiA+ID4gZ2VuZXJpYy8xODYgb24gdXBz
dHJlYW0uwqAgSSBhbHNvIG5vdGljZSB0aGUgdGVzdCBjb21wbGV0ZXMKPiA+ID4gPiA+ID4gPiBh
ZnRlciAxMCsKPiA+ID4gPiA+ID4gPiBob3VycyAodXN1YWxseSBpdCB0YWtlcyBhYm91dCA1IG1p
bnV0ZXMpLsKgIFNvbWV0aW1lcyB0aGlzCj4gPiA+ID4gPiA+ID4gaXMKPiA+ID4gPiA+ID4gPiBh
Y2NvbXBhbmllZAo+ID4gPiA+ID4gPiA+IGJ5ICJuZnM6IFJQQyBjYWxsIHJldHVybmVkIGVycm9y
IDEyIiBvbiB0aGUgY2xpZW50Lgo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gI2RlZmluZSBFTk9N
RU3CoMKgwqDCoMKgwqDCoMKgwqAgMTLCoMKgwqDCoMKgIC8qIE91dCBvZiBtZW1vcnkgKi8KPiA+
ID4gPiA+ID4gCj4gPiA+ID4gPiA+IFNvIGVpdGhlciB0aGUgY2xpZW50IG9yIHRoZSBzZXJ2ZXIg
aXMgcnVubmluZyBvdXQgb2YgbWVtb3J5Cj4gPiA+ID4gPiA+IHNvbWV3aGVyZT8KPiA+ID4gPiA+
IAo+ID4gPiA+ID4gUHJvYmFibHkgdGhlIGNsaWVudC7CoCBUaGVyZSBhcmUgYSBidW5jaCBvZiBj
aGFuZ2VzIHJlY2VudGx5Cj4gPiA+ID4gPiB3aGljaAo+ID4gPiA+ID4gYWRkCj4gPiA+ID4gPiBf
X0dGUF9OT1JFVFJZIHRvIG1lbW9yeSBhbGxvY2F0aW9ucyBmcm9tIFBGX1dRX1dPUktFUnMgYmVj
YXVzZQo+ID4gPiA+ID4gdGhhdAo+ID4gPiA+ID4gY2FuCj4gPiA+ID4gPiByZXN1bHQgaW4gZGVh
ZGxvY2tzIHdoZW4gc3dhcHBpbmcgb3ZlciBORlMuCj4gPiA+ID4gPiBUaGlzIG1lYW5zIHRoYXQg
a21hbGxvYyByZXF1ZXN0IHRoYXQgcHJldmlvdXNseSBuZXZlciBmYWlsZWQKPiA+ID4gPiA+IChi
ZWNhdXNlCj4gPiA+ID4gPiBHRlBfS0VSTkVMIG5ldmVyIGZhaWxzIGZvciBrZXJuZWwgdGhyZWFk
cyBJIHRoaW5rKSBjYW4gbm93Cj4gPiA+ID4gPiBmYWlsLsKgCj4gPiA+ID4gPiBUaGlzCj4gPiA+
ID4gPiBoYXMgdGlja2xlZCBvbmUgYnVnIHRoYXQgSSBrbm93IG9mLsKgIFRoZXJlIGFyZSBsaWtl
bHkgdG8gYmUKPiA+ID4gPiA+IG1vcmUuCj4gPiA+ID4gPiAKPiA+ID4gPiA+IFRoZSBSUEMgY29k
ZSBzaG91bGQgc2ltcGx5IHJldHJ5IHRoZXNlIGFsbG9jYXRpb25zIGFmdGVyIGEKPiA+ID4gPiA+
IHNob3J0Cj4gPiA+ID4gPiBkZWxheS4gCj4gPiA+ID4gPiBIWi80IGlzIHRoZSBudW1iZXIgdGhh
dCBpcyB1c2VkIGluIGEgY291cGxlIG9mIHBsYWNlcy7CoAo+ID4gPiA+ID4gUG9zc2libHkKPiA+
ID4gPiA+IHRoZXJlCj4gPiA+ID4gPiBhcmUgbW9yZSBwbGFjZXMgdGhhdCBuZWVkIHRvIGhhbmRs
ZSAtRU5PTUVNIHdpdGggcnBjX2RlbGF5KCkuCj4gPiA+ID4gCj4gPiA+ID4gSSBoYWQgYSBsb29r
IHRocm91Z2ggdGhlIHZhcmlvdXMgcGxhY2VzIHdoZXJlIGFsbG9jIGNhbiBub3cgZmFpbC4KPiA+
ID4gPiAKPiA+ID4gPiBJIHRoaW5rIHhkcl9hbGxvY19idmVjKCkgaW4geHBydF9zZW50X3BhZ2Vk
YXRhKCkgaXMgdGhlIG1vc3QKPiA+ID4gPiBsaWtlbHkKPiA+ID4gPiBjYXVzZSBvZiBhIHByb2Js
ZW0gaGVyZS7CoCBJIGRvbid0IHRoaW5rIGFuIC1FTk9NRU0gZnJvbSB0aGVyZSBpcwo+ID4gPiA+
IGNhdWdodCwKPiA+ID4gPiBzbyBpdCBjb3VsZCBsaWtlbHkgZmlsdGVyIHVwIHRvIE5GUyBhbmQg
cmVzdWx0IGluIHRoZSBtZXNzYWdlIHlvdQo+ID4gPiA+IGdvdC4KPiA+ID4gPiAKPiA+ID4gPiBJ
IGRvbid0IHRoaW5rIHdlIGNhbiBlYXNpbHkgaGFuZGxlIGZhaWx1cmUgdGhlcmUuwqAgV2UgbmVl
ZCB0bwo+ID4gPiA+IHN0YXkKPiA+ID4gPiB3aXRoCj4gPiA+ID4gR0ZQX0tFUk5FTCByZWx5IG9u
IFBGX01FTUFMTE9DIHRvIG1ha2UgZm9yd2FyZCBwcm9ncmVzcyBmb3IKPiA+ID4gPiBzd2FwLW92
ZXItTkZTLgo+ID4gPiA+IAo+ID4gPiA+IEJydWNlOiBjYW4geW91IGNoYW5nZSB0aGF0IG9uZSBs
aW5lIGJhY2sgdG8gR0ZQX0tFUk5FTCBhbmQgc2VlIGlmCj4gPiA+ID4gdGhlCj4gPiA+ID4gcHJv
YmxlbSBnb2VzIGF3YXk/Cj4gPiA+ID4gCj4gPiA+IAo+ID4gPiBDYW4gd2UgcGxlYXNlIGp1c3Qg
bW92ZSB0aGUgY2FsbCB0byB4ZHJfYWxsb2NfYnZlYygpIG91dCBvZgo+ID4gPiB4cHJ0X3NlbmRf
cGFnZWRhdGEoKT8gTW92ZSB0aGUgY2xpZW50IHNpZGUgYWxsb2NhdGlvbiBpbnRvCj4gPiA+IHhz
X3N0cmVhbV9wcmVwYXJlX3JlcXVlc3QoKSBhbmQgeHNfdWRwX3NlbmRfcmVxdWVzdCgpLCB0aGVu
IG1vdmUKPiA+ID4gdGhlCj4gPiA+IHNlcnZlciBzaWRlIGFsbG9jYXRpb24gaW50byBzdmNfdWRw
X3NlbmR0bygpLgo+ID4gPiAKPiA+ID4gVGhhdCBtYWtlcyBpdCBwb3NzaWJsZSB0byBoYW5kbGUg
ZXJyb3JzLgo+ID4gCj4gPiBMaWtlIHRoZSBiZWxvdyBJIGd1ZXNzLsKgIFNlZW1zIHNlbnNpYmxl
LCBidXQgSSBkb24ndCBrbm93IHRoZSBjb2RlCj4gPiB3ZWxsCj4gPiBlbm91Z2ggdG8gcmVhbGx5
IHJldmlldyBpdC4KPiA+IAo+ID4gPiAKPiA+ID4gPiBUaGUgb3RoZXIgcHJvYmxlbSBJIGZvdW5k
IGlzIHRoYXQgcnBjX2FsbG9jX3Rhc2soKSBjYW4gbm93IGZhaWwsCj4gPiA+ID4gYnV0Cj4gPiA+
ID4gcnBjX25ld190YXNrIGFzc3VtZXMgdGhhdCBpdCBuZXZlciB3aWxsLsKgIElmIGl0IGRvZXMs
IHRoZW4gd2UgZ2V0Cj4gPiA+ID4gYQo+ID4gPiA+IE5VTEwKPiA+ID4gPiBkZXJlZi4KPiA+ID4g
PiAKPiA+ID4gPiBJIGRvbid0IHRoaW5rIHJwY19uZXdfdGFzaygpIGNhbiBldmVyIGJlIGNhbGxl
ZCBmcm9tIHRoZSBycGNpb2QKPiA+ID4gPiB3b3JrCj4gPiA+ID4gcXVldWUsIHNvIGl0IGlzIHNh
ZmUgdG8ganVzdCB1c2UgYSBtZW1wb29sIHdpdGggR0ZQX0tFUk5FTCBsaWtlCj4gPiA+ID4gd2UK
PiA+ID4gPiBkaWQKPiA+ID4gPiBiZWZvcmUuIAo+ID4gPiA+IAo+ID4gPiBOby4gV2Ugc2hvdWxk
bid0IGV2ZXIgdXNlIG1lbXBvb2xzIHdpdGggR0ZQX0tFUk5FTC4KPiA+IAo+ID4gV2h5IG5vdD/C
oCBtZW1wb29scyB3aXRoIEdGUF9LRVJORUwgbWFrZSBwZXJmZWN0IHNlbnNlIG91dHNpZGUgb2Yg
dGhlCj4gPiBycGNpb2QgYW5kIG5mc2lvZCB0aHJlYWRzLgo+IAo+IElmIHlvdSBjYW4gYWZmb3Jk
IHRvIG1ha2UgaXQgYW4gaW5maW5pdGUgd2FpdCwgdGhlcmUgaXMgX19HRlBfTk9GQUlMLAo+IHNv
IHdoeSB3YXN0ZSB0aGUgcmVzb3VyY2VzIG9mIGFuIGVtZXJnZW5jeSBwb29sPyBJbiBteSBvcGlu
aW9uLAo+IGhvd2V2ZXIsIGFuIGluZmluaXRlIHVuaW50ZXJydXB0aWJsZSBzbGVlcCBpcyBiYWQg
cG9saWN5IGZvciBhbG1vc3QgYWxsCj4gY2FzZXMgYmVjYXVzZSBzb21lb25lIHdpbGwgd2FudCB0
byBicmVhayBvdXQgYXQgc29tZSBwb2ludC4KCiJpbmZpbml0ZSIgaXNuJ3QgYSB1c2VmdWwgZGVz
Y3JpcHRpb24uICBUaGUgaW1wb3J0YW50IHF1ZXN0aW9uIGlzICJ3aGF0CndpbGwgYWxsb3cgdGhl
IGFsbG9jYXRpb24gdG8gY29tcGxldGU/Ii4KCkZvciBfX0dGUF9OT0ZBSUwgdGhlcmUgaXMgbm8g
Y2xlYXIgYW5zd2VyIGJleW9uZCAicmVkdWN0aW9uIG9mIG1lbW9yeQpwcmVzc3VyZSIsIGFuZCBz
b21ldGltZXMgdGhhdCBpcyBlbm91Z2guCkZvciBhIG1lbXBvb2wgd2UgaGF2ZSBhIG11Y2ggbW9y
ZSBzcGVjaWZpYyBhbnN3ZXIuICBNZW1vcnkgYmVjb21lcwphdmFpbGFibGUgYXMgcHJldmlvdXMg
cmVxdWVzdHMgY29tcGxldGUuICBycGNfdGFza19tZW1wb29sIGhhcyBhIHNpemUgb2YKOCBzbyB0
aGVyZSBjYW4gYWx3YXlzIGJlIDggcmVxdWVzdHMgaW4gZmxpZ2h0LiAgV2FpdGluZyBvbiB0aGUg
bWVtcG9vbAp3aWxsIHdhaXQgYXQgbW9zdCB1bnRpbCB0aGVyZSBhcmUgc2V2ZW4gcmVxdWVzdHMg
aW4gZmxpZ2h0LCBhbmQgdGhlbgp3aWxsIHJldHVybiBhIHRhc2suICBUaGlzIGlzIGEgbXVjaCBi
ZXR0ZXIgZ3VhcmFudGVlIHRoYW4gZm9yCl9fR0ZQX05PRkFJTC4KSWYgeW91IGV2ZXIgbmVlZCBh
biBycGMgdGFzayB0byByZWxpZXZlIG1lbW9yeSBwcmVzc3VyZSwgdGhlbgpfX0dGUF9OT0ZBSUwg
Y291bGQgZGVhZGxvY2ssIHdoaWxlIHVzaW5nIHRoZSBtZW1wb29sIHdvbid0LgoKSWYgeW91IGFy
ZSBuZXZlciBnb2luZyB0byBibG9jayB3YWl0aW5nIG9uIGEgbWVtcG9vbCBhbmQgd291bGQgcmF0
aGVyCmZhaWwgaW5zdGVhZCwgdGhlbiB0aGVyZSBzZWVtcyBsaXR0bGUgcG9pbnQgaW4gaGF2aW5n
IHRoZSBtZW1wb29sLgoKPiAKPiA+IAo+ID4gPiAKPiA+ID4gTW9zdCwgaWYgbm90IGFsbCBvZiB0
aGUgY2FsbGVycyBvZiBycGNfcnVuX3Rhc2soKSBhcmUgc3RpbGwgY2FwYWJsZQo+ID4gPiBvZgo+
ID4gPiBkZWFsaW5nIHdpdGggZXJyb3JzLCBhbmQgZGl0dG8gZm9yIHRoZSBjYWxsZXJzIG9mCj4g
PiA+IHJwY19ydW5fYmNfdGFzaygpLgo+ID4gCj4gPiBZZXMsIHRoZXkgY2FuIGRlYWwgd2l0aCBl
cnJvcnMuwqAgQnV0IGluIG1hbnkgY2FzZXMgdGhhdCBkbyBzbyBieQo+ID4gcGFzc2luZwo+ID4g
dGhlIGVycm9yIHVwIHRoZSBjYWxsIHN0YWNrIHNvIHdlIGNvdWxkIHN0YXJ0IGdldHRpbmcgRU5P
TUVNIGZvcgo+ID4gc3lzdGVtY2FsbHMgbGlrZSBzdGF0KCkuwqAgSSBkb24ndCB0aGluayB0aGF0
IGlzIGEgZ29vZCBpZGVhLgo+ID4gCj4gCj4gc3RhdCgpIGhhcyBhbHdheXMgYmVlbiBjYXBhYmxl
IG9mIHJldHVybmluZyBFTk9NRU0gaWYsIGZvciBpbnN0YW5jZSwKPiBpbm9kZSBhbGxvY2F0aW9u
IGZhaWxzLiBUaGVyZSBhcmUgYWxtb3N0IG5vIGNhbGxzIGluIE5GUyAob3IgbW9zdCBvdGhlcgo+
IGZpbGVzeXN0ZW1zIGZvciB0aGF0IG1hdHRlcikgdGhhdCBjYW4ndCBmYWlsIHNvbWVob3cgd2hl
biBtZW1vcnkgc3RhcnRzCj4gdG8gZ2V0IHJlYWxseSBzY2FyY2UuCgpGYWlyIGVub3VnaC4gIEl0
IGlzIHdyaXRlcyB0aGF0IGFyZSByZWFsbHkgaW1wb3J0YW50LgoKPiAKPiBUaGUgYm90dG9tIGxp
bmUgaXMgdGhhdCB3ZSB1c2Ugb3JkaW5hcnkgR0ZQX0tFUk5FTCBtZW1vcnkgYWxsb2NhdGlvbnMK
PiB3aGVyZSB3ZSBjYW4uIFRoZSBuZXcgY29kZSBmb2xsb3dzIHRoYXQgcnVsZSwgYnJlYWtpbmcg
aXQgb25seSBpbiBjYXNlcwo+IHdoZXJlIHRoZSBzcGVjaWZpYyBydWxlcyBvZiBycGNpb2QveHBy
dGlvZC9uZnNpb2QgbWFrZSBpdCBpbXBvc3NpYmxlIHRvCj4gd2FpdCBmb3JldmVyIGluIHRoZSBt
ZW1vcnkgbWFuYWdlci4KCkl0IGlzIG5vdCBzYWZlIHRvIHVzZSBHRlBfS0VSTkVMIGZvciBhbiBh
bGxvY2F0aW9uIHRoYXQgaXMgbmVlZGVkIGluCm9yZGVyIHRvIGZyZWUgbWVtb3J5IC0gYW5kIHNv
IGFueSBhbGxvY2F0aW9uIHRoYXQgaXMgbmVlZGVkIHRvIHdyaXRlIG91dApkYXRhIGZyb20gdGhl
IHBhZ2UgY2FjaGUuCgo+IAo+IEkgYW0gcHJlcGFyaW5nIGEgc2V0IG9mIHBhdGNoZXMgdG8gYWRk
cmVzcyB0aGUgaXNzdWVzIHRoYXQgeW91J3ZlCj4gaWRlbnRpZmllZCwgcGx1cyBhIGNhc2UgaW4g
Y2FsbF90cmFuc21pdF9zdGF0dXMvY2FsbF9iY190cmFuc21pdF9zdGF0dXMKPiB3aGVyZSB3ZSdy
ZSBub3QgaGFuZGxpbmcgRU5PTUVNLiBUaGVyZSBhcmUgYWxzbyBwYXRjaGVzIHRvIGZpeCB1cCB0
d28KPiBjYXNlcyBpbiB0aGUgTkZTIGNvZGUgaXRzZWxmIHdoZXJlIHdlJ3JlIG5vdCBjdXJyZW50
bHkgaGFuZGxpbmcgZXJyb3JzCj4gZnJvbSBycGNfcnVuX3Rhc2suCgpJIGxvb2sgZm9yd2FyZCB0
byByZXZpZXdpbmcgdGhlbS4KClRoYW5rcywKTmVpbEJyb3duCg==
