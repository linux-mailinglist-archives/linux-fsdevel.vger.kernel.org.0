Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B2A5BA2B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 00:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIOWYM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 18:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiIOWYK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:24:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83F1785B4;
        Thu, 15 Sep 2022 15:24:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6069F1FA28;
        Thu, 15 Sep 2022 22:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663280647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QU+oz3L+PtbnK316ferx1BBZl41+13VR1a80cnxzeDI=;
        b=vBYiME2VOWvmpvuqcniM4ggXT8TDgHZ5bT99wKMlJS2gErh4YttICzg3N2OytqI1cUkqYc
        dPu0gDD84fzmSOjjCbuBlJMiA9na8dTdbzX9lH+fZXIJg0W02LoquDv/grxo2XQdbJuf8s
        3zflv37DMjFHeckl0U6lsuEGD7ufEME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663280647;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QU+oz3L+PtbnK316ferx1BBZl41+13VR1a80cnxzeDI=;
        b=nTCspLMdKiefKEn6Z3rHO/g43UZpxhRNadvEZWnjnOG/T0sRZ/cdk2/AHPHG2Vx3quoovG
        rNdd5bVnnMSnCVBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5573F13A49;
        Thu, 15 Sep 2022 22:23:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bzp6Av+lI2NGEQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 15 Sep 2022 22:23:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Trond Myklebust" <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
In-reply-to: <e8922bc821a40f5a3f0a1301583288ed19b6891b.camel@kernel.org>
References: <20220908083326.3xsanzk7hy3ff4qs@quack3>,
 <YxoIjV50xXKiLdL9@mit.edu>,
 <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>,
 <20220908155605.GD8951@fieldses.org>,
 <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>,
 <20220908182252.GA18939@fieldses.org>,
 <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>,
 <166284799157.30452.4308111193560234334@noble.neil.brown.name>,
 <20220912134208.GB9304@fieldses.org>,
 <166302447257.30452.6751169887085269140@noble.neil.brown.name>,
 <20220915140644.GA15754@fieldses.org>,
 <577b6d8a7243aeee37eaa4bbb00c90799586bc48.camel@hammerspace.com>,
 <1a968b8e87f054e360877c9ab8cdfc4cfdfc8740.camel@kernel.org>,
 <0646410b6d2a5d19d3315f339b2928dfa9f2d922.camel@hammerspace.com>,
 <34e91540c92ad6980256f6b44115cf993695d5e1.camel@kernel.org>,
 <871f9c5153ddfe760854ca31ee36b84655959b83.camel@hammerspace.com>,
 <e8922bc821a40f5a3f0a1301583288ed19b6891b.camel@kernel.org>
Date:   Fri, 16 Sep 2022 08:23:55 +1000
Message-id: <166328063547.15759.12797959071252871549@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCAxNiBTZXAgMjAyMiwgSmVmZiBMYXl0b24gd3JvdGU6Cj4gT24gVGh1LCAyMDIyLTA5
LTE1IGF0IDE5OjAzICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6Cj4gPiBPbiBUaHUsIDIw
MjItMDktMTUgYXQgMTQ6MTEgLTA0MDAsIEplZmYgTGF5dG9uIHdyb3RlOgo+ID4gPiBPbiBUaHUs
IDIwMjItMDktMTUgYXQgMTc6NDkgKzAwMDAsIFRyb25kIE15a2xlYnVzdCB3cm90ZToKPiA+ID4g
PiBPbiBUaHUsIDIwMjItMDktMTUgYXQgMTI6NDUgLTA0MDAsIEplZmYgTGF5dG9uIHdyb3RlOgo+
ID4gPiA+ID4gT24gVGh1LCAyMDIyLTA5LTE1IGF0IDE1OjA4ICswMDAwLCBUcm9uZCBNeWtsZWJ1
c3Qgd3JvdGU6Cj4gPiA+ID4gPiA+IE9uIFRodSwgMjAyMi0wOS0xNSBhdCAxMDowNiAtMDQwMCwg
Si4gQnJ1Y2UgRmllbGRzIHdyb3RlOgo+ID4gPiA+ID4gPiA+IE9uIFR1ZSwgU2VwIDEzLCAyMDIy
IGF0IDA5OjE0OjMyQU0gKzEwMDAsIE5laWxCcm93biB3cm90ZToKPiA+ID4gPiA+ID4gPiA+IE9u
IE1vbiwgMTIgU2VwIDIwMjIsIEouIEJydWNlIEZpZWxkcyB3cm90ZToKPiA+ID4gPiA+ID4gPiA+
ID4gT24gU3VuLCBTZXAgMTEsIDIwMjIgYXQgMDg6MTM6MTFBTSArMTAwMCwgTmVpbEJyb3duCj4g
PiA+ID4gPiA+ID4gPiA+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIEZyaSwgMDkgU2Vw
IDIwMjIsIEplZmYgTGF5dG9uIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiBUaGUgbWFjaGluZSBjcmFzaGVzIGFuZCBjb21lcyBiYWNrIHVwLCBhbmQg
d2UgZ2V0IGEKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHF1ZXJ5Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiBmb3IKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGlfdmVyc2lvbgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gYW5kIGl0IGNvbWVzIGJhY2sgYXMgWC4gRmluZSwgaXQncyBhbiBvbGQgdmVyc2lvbi4KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IE5vdwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdGhlcmUKPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IGlzIGEgd3JpdGUuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBXaGF0IGRv
IHdlIGRvIHRvIGVuc3VyZSB0aGF0IHRoZSBuZXcgdmFsdWUgZG9lc24ndAo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gY29sbGlkZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gd2l0aCBYKzE/IAo+ID4gPiA+
ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+IChJIG1pc3NlZCB0aGlzIGJpdCBpbiBt
eSBlYXJsaWVyIHJlcGx5Li4pCj4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+
ID4gSG93IGlzIGl0ICJGaW5lIiB0byBzZWUgYW4gb2xkIHZlcnNpb24/Cj4gPiA+ID4gPiA+ID4g
PiA+ID4gVGhlIGZpbGUgY291bGQgaGF2ZSBjaGFuZ2VkIHdpdGhvdXQgdGhlIHZlcnNpb24KPiA+
ID4gPiA+ID4gPiA+ID4gPiBjaGFuZ2luZy4KPiA+ID4gPiA+ID4gPiA+ID4gPiBBbmQgSSB0aG91
Z2h0IG9uZSBvZiB0aGUgZ29hbHMgb2YgdGhlIGNyYXNoLWNvdW50IHdhcwo+ID4gPiA+ID4gPiA+
ID4gPiA+IHRvIGJlCj4gPiA+ID4gPiA+ID4gPiA+ID4gYWJsZSB0bwo+ID4gPiA+ID4gPiA+ID4g
PiA+IHByb3ZpZGUgYSBtb25vdG9uaWMgY2hhbmdlIGlkLgo+ID4gPiA+ID4gPiA+ID4gPiAKPiA+
ID4gPiA+ID4gPiA+ID4gSSB3YXMgc3RpbGwgbWFpbmx5IHRoaW5raW5nIGFib3V0IGhvdyB0byBw
cm92aWRlIHJlbGlhYmxlCj4gPiA+ID4gPiA+ID4gPiA+IGNsb3NlLQo+ID4gPiA+ID4gPiA+ID4g
PiB0by1vcGVuCj4gPiA+ID4gPiA+ID4gPiA+IHNlbWFudGljcyBiZXR3ZWVuIE5GUyBjbGllbnRz
LsKgIEluIHRoZSBjYXNlIHRoZSB3cml0ZXIKPiA+ID4gPiA+ID4gPiA+ID4gd2FzIGFuCj4gPiA+
ID4gPiA+ID4gPiA+IE5GUwo+ID4gPiA+ID4gPiA+ID4gPiBjbGllbnQsIGl0IHdhc24ndCBkb25l
IHdyaXRpbmcgKG9yIGl0IHdvdWxkIGhhdmUKPiA+ID4gPiA+ID4gPiA+ID4gQ09NTUlUdGVkKSwK
PiA+ID4gPiA+ID4gPiA+ID4gc28KPiA+ID4gPiA+ID4gPiA+ID4gdGhvc2UKPiA+ID4gPiA+ID4g
PiA+ID4gd3JpdGVzIHdpbGwgY29tZSBpbiBhbmQgYnVtcCB0aGUgY2hhbmdlIGF0dHJpYnV0ZSBz
b29uLAo+ID4gPiA+ID4gPiA+ID4gPiBhbmQKPiA+ID4gPiA+ID4gPiA+ID4gYXMKPiA+ID4gPiA+
ID4gPiA+ID4gbG9uZyBhcwo+ID4gPiA+ID4gPiA+ID4gPiB3ZSBhdm9pZCB0aGUgc21hbGwgY2hh
bmNlIG9mIHJldXNpbmcgYW4gb2xkIGNoYW5nZQo+ID4gPiA+ID4gPiA+ID4gPiBhdHRyaWJ1dGUs
Cj4gPiA+ID4gPiA+ID4gPiA+IHdlJ3JlIE9LLAo+ID4gPiA+ID4gPiA+ID4gPiBhbmQgSSB0aGlu
ayBpdCdkIGV2ZW4gc3RpbGwgYmUgT0sgdG8gYWR2ZXJ0aXNlCj4gPiA+ID4gPiA+ID4gPiA+IENI
QU5HRV9UWVBFX0lTX01PTk9UT05JQ19JTkNSLgo+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+
ID4gPiBZb3Ugc2VlbSB0byBiZSBhc3N1bWluZyB0aGF0IHRoZSBjbGllbnQgZG9lc24ndCBjcmFz
aCBhdAo+ID4gPiA+ID4gPiA+ID4gdGhlCj4gPiA+ID4gPiA+ID4gPiBzYW1lCj4gPiA+ID4gPiA+
ID4gPiB0aW1lCj4gPiA+ID4gPiA+ID4gPiBhcyB0aGUgc2VydmVyIChtYXliZSB0aGV5IGFyZSBi
b3RoIFZNcyBvbiBhIGhvc3QgdGhhdCBsb3N0Cj4gPiA+ID4gPiA+ID4gPiBwb3dlci4uLikKPiA+
ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gSWYgY2xpZW50IEEgcmVhZHMgYW5kIGNhY2hl
cywgY2xpZW50IEIgd3JpdGVzLCB0aGUgc2VydmVyCj4gPiA+ID4gPiA+ID4gPiBjcmFzaGVzCj4g
PiA+ID4gPiA+ID4gPiBhZnRlcgo+ID4gPiA+ID4gPiA+ID4gd3JpdGluZyBzb21lIGRhdGEgKHRv
IGFscmVhZHkgYWxsb2NhdGVkIHNwYWNlIHNvIG5vIGlub2RlCj4gPiA+ID4gPiA+ID4gPiB1cGRh
dGUKPiA+ID4gPiA+ID4gPiA+IG5lZWRlZCkKPiA+ID4gPiA+ID4gPiA+IGJ1dCBiZWZvcmUgd3Jp
dGluZyB0aGUgbmV3IGlfdmVyc2lvbiwgdGhlbiBjbGllbnQgQgo+ID4gPiA+ID4gPiA+ID4gY3Jh
c2hlcy4KPiA+ID4gPiA+ID4gPiA+IFdoZW4gc2VydmVyIGNvbWVzIGJhY2sgdGhlIGlfdmVyc2lv
biB3aWxsIGJlIHVuY2hhbmdlZCBidXQKPiA+ID4gPiA+ID4gPiA+IHRoZQo+ID4gPiA+ID4gPiA+
ID4gZGF0YQo+ID4gPiA+ID4gPiA+ID4gaGFzCj4gPiA+ID4gPiA+ID4gPiBjaGFuZ2VkLsKgIENs
aWVudCBBIHdpbGwgY2FjaGUgb2xkIGRhdGEgaW5kZWZpbml0ZWx5Li4uCj4gPiA+ID4gPiA+ID4g
Cj4gPiA+ID4gPiA+ID4gSSBndWVzcyBJIGFzc3VtZSB0aGF0IGlmIGFsbCB3ZSdyZSBwcm9taXNp
bmcgaXMgY2xvc2UtdG8tCj4gPiA+ID4gPiA+ID4gb3BlbiwKPiA+ID4gPiA+ID4gPiB0aGVuIGEK
PiA+ID4gPiA+ID4gPiBjbGllbnQgaXNuJ3QgYWxsb3dlZCB0byB0cnVzdCBpdHMgY2FjaGUgaW4g
dGhhdCBzaXR1YXRpb24uwqAKPiA+ID4gPiA+ID4gPiBNYXliZQo+ID4gPiA+ID4gPiA+IHRoYXQn
cwo+ID4gPiA+ID4gPiA+IGFuIG92ZXJseSBkcmFjb25pYW4gaW50ZXJwcmV0YXRpb24gb2YgY2xv
c2UtdG8tb3Blbi4KPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiBBbHNvLCBJJ20gdHJ5aW5n
IHRvIHRoaW5rIGFib3V0IGhvdyB0byBpbXByb3ZlIHRoaW5ncwo+ID4gPiA+ID4gPiA+IGluY3Jl
bWVudGFsbHkuCj4gPiA+ID4gPiA+ID4gSW5jb3Jwb3JhdGluZyBzb21ldGhpbmcgbGlrZSBhIGNy
YXNoIGNvdW50IGludG8gdGhlIG9uLWRpc2sKPiA+ID4gPiA+ID4gPiBpX3ZlcnNpb24KPiA+ID4g
PiA+ID4gPiBmaXhlcyBzb21lIGNhc2VzIHdpdGhvdXQgaW50cm9kdWNpbmcgYW55IG5ldyBvbmVz
IG9yCj4gPiA+ID4gPiA+ID4gcmVncmVzc2luZwo+ID4gPiA+ID4gPiA+IHBlcmZvcm1hbmNlIGFm
dGVyIGEgY3Jhc2guCj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gSWYgd2Ugc3Vic2VxdWVu
dGx5IHdhbnRlZCB0byBjbG9zZSB0aG9zZSByZW1haW5pbmcgaG9sZXMsIEkKPiA+ID4gPiA+ID4g
PiB0aGluawo+ID4gPiA+ID4gPiA+IHdlJ2QKPiA+ID4gPiA+ID4gPiBuZWVkIHRoZSBjaGFuZ2Ug
YXR0cmlidXRlIGluY3JlbWVudCB0byBiZSBzZWVuIGFzIGF0b21pYyB3aXRoCj4gPiA+ID4gPiA+
ID4gcmVzcGVjdAo+ID4gPiA+ID4gPiA+IHRvCj4gPiA+ID4gPiA+ID4gaXRzIGFzc29jaWF0ZWQg
Y2hhbmdlLCBib3RoIHRvIGNsaWVudHMgYW5kIChzZXBhcmF0ZWx5KSBvbgo+ID4gPiA+ID4gPiA+
IGRpc2suwqAKPiA+ID4gPiA+ID4gPiAoVGhhdAo+ID4gPiA+ID4gPiA+IHdvdWxkIHN0aWxsIGFs
bG93IHRoZSBjaGFuZ2UgYXR0cmlidXRlIHRvIGdvIGJhY2t3YXJkcyBhZnRlcgo+ID4gPiA+ID4g
PiA+IGEKPiA+ID4gPiA+ID4gPiBjcmFzaCwKPiA+ID4gPiA+ID4gPiB0bwo+ID4gPiA+ID4gPiA+
IHRoZSB2YWx1ZSBpdCBoZWxkIGFzIG9mIHRoZSBvbi1kaXNrIHN0YXRlIG9mIHRoZSBmaWxlLsKg
IEkKPiA+ID4gPiA+ID4gPiB0aGluawo+ID4gPiA+ID4gPiA+IGNsaWVudHMKPiA+ID4gPiA+ID4g
PiBzaG91bGQgYmUgYWJsZSB0byBkZWFsIHdpdGggdGhhdCBjYXNlLikKPiA+ID4gPiA+ID4gPiAK
PiA+ID4gPiA+ID4gPiBCdXQsIEkgZG9uJ3Qga25vdywgbWF5YmUgYSBiaWdnZXIgaGFtbWVyIHdv
dWxkIGJlIE9LOgo+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gSWYgeW91
J3JlIG5vdCBnb2luZyB0byBtZWV0IHRoZSBtaW5pbXVtIGJhciBvZiBkYXRhIGludGVncml0eSwK
PiA+ID4gPiA+ID4gdGhlbgo+ID4gPiA+ID4gPiB0aGlzIHdob2xlIGV4ZXJjaXNlIGlzIGp1c3Qg
YSBtYXNzaXZlIHdhc3RlIG9mIGV2ZXJ5b25lJ3MgdGltZS4KPiA+ID4gPiA+ID4gVGhlCj4gPiA+
ID4gPiA+IGFuc3dlciB0aGVuIGdvaW5nIGZvcndhcmQgaXMganVzdCB0byByZWNvbW1lbmQgbmV2
ZXIgdXNpbmcKPiA+ID4gPiA+ID4gTGludXggYXMKPiA+ID4gPiA+ID4gYW4KPiA+ID4gPiA+ID4g
TkZTIHNlcnZlci4gTWFrZXMgbXkgbGlmZSBtdWNoIGVhc2llciwgYmVjYXVzZSBJIG5vIGxvbmdl
ciBoYXZlCj4gPiA+ID4gPiA+IHRvCj4gPiA+ID4gPiA+IGRlYnVnIGFueSBvZiB0aGUgaXNzdWVz
Lgo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiAKPiA+ID4gPiA+IFRvIGJlIGNs
ZWFyLCB5b3UgYmVsaWV2ZSBhbnkgc2NoZW1lIHRoYXQgd291bGQgYWxsb3cgdGhlIGNsaWVudAo+
ID4gPiA+ID4gdG8KPiA+ID4gPiA+IHNlZQo+ID4gPiA+ID4gYW4gb2xkIGNoYW5nZSBhdHRyIGFm
dGVyIGEgY3Jhc2ggaXMgaW5zdWZmaWNpZW50Pwo+ID4gPiA+ID4gCj4gPiA+ID4gCj4gPiA+ID4g
Q29ycmVjdC4gSWYgYSBORlN2NCBjbGllbnQgb3IgdXNlcnNwYWNlIGFwcGxpY2F0aW9uIGNhbm5v
dCB0cnVzdAo+ID4gPiA+IHRoYXQKPiA+ID4gPiBpdCB3aWxsIGFsd2F5cyBzZWUgYSBjaGFuZ2Ug
dG8gdGhlIGNoYW5nZSBhdHRyaWJ1dGUgdmFsdWUgd2hlbiB0aGUKPiA+ID4gPiBmaWxlCj4gPiA+
ID4gZGF0YSBjaGFuZ2VzLCB0aGVuIHlvdSB3aWxsIGV2ZW50dWFsbHkgc2VlIGRhdGEgY29ycnVw
dGlvbiBkdWUgdG8KPiA+ID4gPiB0aGUKPiA+ID4gPiBjYWNoZWQgZGF0YSBubyBsb25nZXIgbWF0
Y2hpbmcgdGhlIHN0b3JlZCBkYXRhLgo+ID4gPiA+IAo+ID4gPiA+IEEgZmFsc2UgcG9zaXRpdmUg
dXBkYXRlIG9mIHRoZSBjaGFuZ2UgYXR0cmlidXRlIChpLmUuIGEgY2FzZSB3aGVyZQo+ID4gPiA+
IHRoZQo+ID4gPiA+IGNoYW5nZSBhdHRyaWJ1dGUgY2hhbmdlcyBkZXNwaXRlIHRoZSBkYXRhL21l
dGFkYXRhIHN0YXlpbmcgdGhlCj4gPiA+ID4gc2FtZSkgaXMKPiA+ID4gPiBub3QgZGVzaXJhYmxl
IGJlY2F1c2UgaXQgY2F1c2VzIHBlcmZvcm1hbmNlIGlzc3VlcywgYnV0IGZhbHNlCj4gPiA+ID4g
bmVnYXRpdmVzCj4gPiA+ID4gYXJlIGZhciB3b3JzZSBiZWNhdXNlIHRoZXkgbWVhbiB5b3VyIGRh
dGEgYmFja3VwLCBjYWNoZSwgZXRjLi4uIGFyZQo+ID4gPiA+IG5vdAo+ID4gPiA+IGNvbnNpc3Rl
bnQuIEFwcGxpY2F0aW9ucyB0aGF0IGhhdmUgc3Ryb25nIGNvbnNpc3RlbmN5IHJlcXVpcmVtZW50
cwo+ID4gPiA+IHdpbGwKPiA+ID4gPiBoYXZlIG5vIG9wdGlvbiBidXQgdG8gcmV2YWxpZGF0ZSBi
eSBhbHdheXMgcmVhZGluZyB0aGUgZW50aXJlIGZpbGUKPiA+ID4gPiBkYXRhCj4gPiA+ID4gKyBt
ZXRhZGF0YS4KPiA+ID4gPiAKPiA+ID4gPiA+IFRoZSBvbmx5IHdheSBJIGNhbiBzZWUgdG8gZml4
IHRoYXQgKGF0IGxlYXN0IHdpdGggb25seSBhIGNyYXNoCj4gPiA+ID4gPiBjb3VudGVyKQo+ID4g
PiA+ID4gd291bGQgYmUgdG8gZmFjdG9yIGl0IGluIGF0IHByZXNlbnRhdGlvbiB0aW1lIGxpa2Ug
TmVpbAo+ID4gPiA+ID4gc3VnZ2VzdGVkLgo+ID4gPiA+ID4gQmFzaWNhbGx5IHdlJ2QganVzdCBt
YXNrIG9mZiB0aGUgdG9wIDE2IGJpdHMgYW5kIHBsb3AgdGhlIGNyYXNoCj4gPiA+ID4gPiBjb3Vu
dGVyCj4gPiA+ID4gPiBpbiB0aGVyZSBiZWZvcmUgcHJlc2VudGluZyBpdC4KPiA+ID4gPiA+IAo+
ID4gPiA+ID4gSW4gcHJpbmNpcGxlLCBJIHN1cHBvc2Ugd2UgY291bGQgZG8gdGhhdCBhdCB0aGUg
bmZzZCBsZXZlbCBhcwo+ID4gPiA+ID4gd2VsbAo+ID4gPiA+ID4gKGFuZAo+ID4gPiA+ID4gdGhh
dCBtaWdodCBiZSB0aGUgc2ltcGxlc3Qgd2F5IHRvIGZpeCB0aGlzKS4gV2UgcHJvYmFibHkgd291
bGRuJ3QKPiA+ID4gPiA+IGJlCj4gPiA+ID4gPiBhYmxlIHRvIGFkdmVydGlzZSBhIGNoYW5nZSBh
dHRyIHR5cGUgb2YgTU9OT1RPTklDIHdpdGggdGhpcwo+ID4gPiA+ID4gc2NoZW1lCj4gPiA+ID4g
PiB0aG91Z2guCj4gPiA+ID4gCj4gPiA+ID4gV2h5IHdvdWxkIHlvdSB3YW50IHRvIGxpbWl0IHRo
ZSBjcmFzaCBjb3VudGVyIHRvIDE2IGJpdHM/Cj4gPiA+ID4gCj4gPiA+IAo+ID4gPiBUbyBsZWF2
ZSBtb3JlIHJvb20gZm9yIHRoZSAicmVhbCIgY291bnRlci4gT3RoZXJ3aXNlLCBhbiBpbm9kZSB0
aGF0Cj4gPiA+IGdldHMKPiA+ID4gZnJlcXVlbnQgd3JpdGVzIGFmdGVyIGEgbG9uZyBwZXJpb2Qg
b2Ygbm8gY3Jhc2hlcyBjb3VsZCBleHBlcmllbmNlCj4gPiA+IHRoZQo+ID4gPiBjb3VudGVyIHdy
YXAuCj4gPiA+IAo+ID4gPiBJT1csIHdlIGhhdmUgNjMgYml0cyB0byBwbGF5IHdpdGguIFdoYXRl
dmVyIHBhcnQgd2UgZGVkaWNhdGUgdG8gdGhlCj4gPiA+IGNyYXNoIGNvdW50ZXIgd2lsbCBub3Qg
YmUgYXZhaWxhYmxlIGZvciB0aGUgYWN0dWFsIHZlcnNpb24gY291bnRlci4KPiA+ID4gCj4gPiA+
IEknbSBwcm9wb3NpbmcgYSAxNis0NysxIHNwbGl0LCBidXQgSSdtIGhhcHB5IHRvIGhlYXIgYXJn
dW1lbnRzIGZvciBhCj4gPiA+IGRpZmZlcmVudCBvbmUuCj4gPiAKPiA+IAo+ID4gV2hhdCBpcyB0
aGUgZXhwZWN0YXRpb24gd2hlbiB5b3UgaGF2ZSBhbiB1bmNsZWFuIHNodXRkb3duIG9yIGNyYXNo
PyBEbwo+ID4gYWxsIGNoYW5nZSBhdHRyaWJ1dGUgdmFsdWVzIGdldCB1cGRhdGVkIHRvIHJlZmxl
Y3QgdGhlIG5ldyBjcmFzaAo+ID4gY291bnRlciB2YWx1ZSwgb3Igb25seSBzb21lPwo+ID4gCj4g
PiBJZiB0aGUgYW5zd2VyIGlzIHRoYXQgJ2FsbCB2YWx1ZXMgY2hhbmdlJywgdGhlbiB3aHkgc3Rv
cmUgdGhlIGNyYXNoCj4gPiBjb3VudGVyIGluIHRoZSBpbm9kZSBhdCBhbGw/IFdoeSBub3QganVz
dCBhZGQgaXQgYXMgYW4gb2Zmc2V0IHdoZW4KPiA+IHlvdSdyZSBnZW5lcmF0aW5nIHRoZSB1c2Vy
LXZpc2libGUgY2hhbmdlIGF0dHJpYnV0ZT8KPiA+IAo+ID4gaS5lLiBzdGF0eC5jaGFuZ2VfYXR0
ciA9IGlub2RlLT5pX3ZlcnNpb24gKyAoY3Jhc2ggY291bnRlciAqIG9mZnNldCkKPiA+IAo+ID4g
KHdoZXJlIG9mZnNldCBpcyBjaG9zZW4gdG8gYmUgbGFyZ2VyIHRoYW4gdGhlIG1heCBudW1iZXIg
b2YgaW5vZGUtCj4gPiA+IGlfdmVyc2lvbiB1cGRhdGVzIHRoYXQgY291bGQgZ2V0IGxvc3QgYnkg
YW4gaW5vZGUgaW4gYSBjcmFzaCkuCj4gPiAKPiA+IFByZXN1bWFibHkgdGhhdCBvZmZzZXQgY291
bGQgYmUgc2lnbmlmaWNhbnRseSBzbWFsbGVyIHRoYW4gMl42My4uLgo+ID4gCj4gCj4gCj4gWWVz
LCBpZiB3ZSBwbGFuIHRvIGVuc3VyZSB0aGF0IGFsbCB0aGUgY2hhbmdlIGF0dHJzIGNoYW5nZSBh
ZnRlciBhCj4gY3Jhc2gsIHdlIGNhbiBkbyB0aGF0Lgo+IAo+IFNvIHdoYXQgd291bGQgbWFrZSBz
ZW5zZSBmb3IgYW4gb2Zmc2V0PyBNYXliZSAyKioxMj8gT25lIHdvdWxkIGhvcGUgdGhhdAo+IHRo
ZXJlIHdvdWxkbid0IGJlIG1vcmUgdGhhbiA0ayBpbmNyZW1lbnRzIGJlZm9yZSBvbmUgb2YgdGhl
bSBtYWRlIGl0IHRvCj4gZGlzay4gT1RPSCwgbWF5YmUgdGhhdCBjYW4gaGFwcGVuIHdpdGggdGVl
bnktdGlueSB3cml0ZXMuCgpMZWF2ZSBpdCB1cCB0aGUgdG8gZmlsZXN5c3RlbSB0byBkZWNpZGUu
ICBUaGUgVkZTIGFuZC9vciBORlNEIHNob3VsZApoYXZlIG5vdCBoYXZlIHBhcnQgaW4gY2FsY3Vs
YXRpbmcgdGhlIGlfdmVyc2lvbi4gIEl0IHNob3VsZCBiZSBlbnRpcmVseQppbiB0aGUgZmlsZXN5
c3RlbSAtIHRob3VnaCBzdXBwb3J0IGNvZGUgY291bGQgYmUgcHJvdmlkZWQgaWYgY29tbW9uCnBh
dHRlcm5zIGV4aXN0IGFjcm9zcyBmaWxlc3lzdGVtcy4KCkEgZmlsZXN5c3RlbSAqY291bGQqIGRl
Y2lkZSB0byBlbnN1cmUgdGhlIG9uLWRpc2sgaV92ZXJzaW9uIGlzIHVwZGF0ZWQKd2hlbiB0aGUg
ZGlmZmVyZW5jZSBiZXR3ZWVuIGluLW1lbW9yeSBhbmQgb24tZGlzayByZWFjaGVzIFgvMiwgYW5k
IGFkZCBYCmFmdGVyIGFuIHVuY2xlYW4gcmVzdGFydC4gIE9yIGl0IGNvdWxkIGp1c3QgY2hvb3Nl
IGEgbGFyZ2UgWCBhbmQgaG9wZS4KT3IgaXQgY291bGQgZG8gc29tZXRoaW5nIGVsc2UgdGhhdCBu
ZWl0aGVyIG9mIHVzIGhhcyB0aG91Z2h0IG9mLiAgQnV0ClBMRUFTRSBsZWF2ZSB0aGUgZmlsZXN5
c3RlbSBpbiBjb250cm9sLCBkbyBub3QgbWFrZSBpdCBmaXQgd2l0aCBvdXIKcHJlLWNvbmNlaXZl
ZCBpZGVhcyBvZiB3aGF0IHdvdWxkIGJlIGVhc3kgZm9yIGl0LgoKPiAKPiBJZiB3ZSB3YW50IHRv
IGxlYXZlIHRoaXMgdXAgdG8gdGhlIGZpbGVzeXN0ZW0sIEkgZ3Vlc3Mgd2UgY291bGQganVzdCBh
ZGQKPiBhIG5ldyBzdHJ1Y3Qgc3VwZXJfYmxvY2suc192ZXJzaW9uX29mZnNldCBmaWVsZCBhbmQg
bGV0IHRoZSBmaWxlc3lzdGVtCj4gcHJlY29tcHV0ZSB0aGF0IHZhbHVlIGFuZCBzZXQgaXQgYXQg
bW91bnQgdGltZS4gVGhlbiB3ZSBjYW4ganVzdCBhZGQKPiB0aGF0IGluIGFmdGVyIHF1ZXJ5aW5n
IGlfdmVyc2lvbi4KCklmIHdlIGFyZSBsZWF2aW5nICJ0aGlzIHVwIHRvIHRoZSBmaWxlc3lzdGVt
IiwgdGhlIHdlIGRvbid0IGFkZCBhbnl0aGluZwp0byBzdHJ1Y3Qgc3VwZXJfYmxvY2sgYW5kIHdl
IGRvbid0IGFkZCBhbnl0aGluZyAiaW4gYWZ0ZXIgcXVlcnlpbmcKaV92ZXJzaW9uIi4gIFJhdGhl
ciwgd2UgImxlYXZlIHRoaXMgdXAgdG8gdGhlIGZpbGVzeXN0ZW0iIGFuZCB1c2UKZXhhY3RseSB0
aGUgaV92ZXJzaW9uIHRoYXQgdGhlIGZpbGVzeXN0ZW0gcHJvdmlkZXMuICBXZSBvbmx5IHByb3Zp
ZGUKYWR2aWNlIGFzIHRvIG1pbmltdW0gcmVxdWlyZW1lbnRzLCBwcmVmZXJyZWQgYmVoYXZpb3Vy
cywgYW5kIHBvc3NpYmxlCmltcGxlbWVudGF0aW9uIHN1Z2dlc3Rpb25zLgoKTmVpbEJyb3duCgoK
PiAtLSAKPiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPgo+IAo=
