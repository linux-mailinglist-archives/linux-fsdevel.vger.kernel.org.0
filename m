Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0363DB31D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 08:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237264AbhG3GBJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 02:01:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34982 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhG3GBJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:01:09 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 867761FDB1;
        Fri, 30 Jul 2021 06:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627624863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1xHOP8ZRZex6z6cQJzGtenvi+uTP2BbtR83yGHCWjxk=;
        b=XWYkUrlCx11IaPtjvIhwa4sC9iIzgCm6D0QPPFd8XWiw93pacsxM9c5opDnYUaxBDU6uFm
        AMErkFZd2aqqfFBcQ5l1vt8nosGRwct3AFJ1iHxjMQZWkg/A0HiuCa8nWAZDUhg2fRinKV
        pDwkYrRQFzU0bsHOdOPAJFOU0CueHzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627624863;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1xHOP8ZRZex6z6cQJzGtenvi+uTP2BbtR83yGHCWjxk=;
        b=ZGJWj+0Y2iDQNAaAVBGvjSNO5ccFMjcmROL4vNWbobPjmB2zXp0IadgO9h/6aZv/7oNnN9
        ROP98cwA2ZPbuwBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 974A113BF9;
        Fri, 30 Jul 2021 06:00:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JKVLFZuVA2GvAQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 30 Jul 2021 06:00:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>
Cc:     "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>,
        "Neal Gompa" <ngompa13@gmail.com>,
        "Wang Yugui" <wangyugui@e16-tech.com>,
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
In-reply-to: <046c96cd-f2a5-be04-e7b5-012e896c5816@gmx.com>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <20210728125819.6E52.409509F4@e16-tech.com>,
 <20210728140431.D704.409509F4@e16-tech.com>,
 <162745567084.21659.16797059962461187633@noble.neil.brown.name>,
 <CAEg-Je8Pqbw0tTw6NWkAcD=+zGStOJR0J-409mXuZ1vmb6dZsA@mail.gmail.com>,
 <162751265073.21659.11050133384025400064@noble.neil.brown.name>,
 <20210729023751.GL10170@hungrycats.org>,
 <162752976632.21659.9573422052804077340@noble.neil.brown.name>,
 <20210729232017.GE10106@hungrycats.org>,
 <162761259105.21659.4838403432058511846@noble.neil.brown.name>,
 <341403c0-a7a7-f6c8-5ef6-2d966b1907a8@gmx.com>,
 <046c96cd-f2a5-be04-e7b5-012e896c5816@gmx.com>
Date:   Fri, 30 Jul 2021 16:00:54 +1000
Message-id: <162762485406.21659.16909119511605460065@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCAzMCBKdWwgMjAyMSwgUXUgV2VucnVvIHdyb3RlOgo+IAo+IE9uIDIwMjEvNy8zMCDk
uIvljYgxOjI1LCBRdSBXZW5ydW8gd3JvdGU6Cj4gPgo+ID4KPiA+IE9uIDIwMjEvNy8zMCDkuIrl
jYgxMDozNiwgTmVpbEJyb3duIHdyb3RlOgo+ID4+Cj4gPj4gSSd2ZSBiZWVuIHBvbmRlcmluZyBh
bGwgdGhlIGV4Y2VsbGVudCBmZWVkYmFjaywgYW5kIHdoYXQgSSBoYXZlIGxlYXJudAo+ID4+IGZy
b20gZXhhbWluaW5nIHRoZSBjb2RlIGluIGJ0cmZzLCBhbmQgSSBoYXZlIGRldmVsb3BlZCBhIGRp
ZmZlcmVudAo+ID4+IHBlcnNwZWN0aXZlLgo+ID4KPiA+IEdyZWF0ISBTb21lIG5ldyBkZXZlbG9w
ZXJzIGludG8gdGhlIGJ0cmZzIHJlYWxtIQo+ID4KPiA+Pgo+ID4+IE1heWJlICJzdWJ2b2wiIGlz
IGEgcG9vciBjaG9pY2Ugb2YgbmFtZSBiZWNhdXNlIGl0IGNvbmp1cmVzIHVwCj4gPj4gY29ubmVj
dGlvbnMgd2l0aCB0aGUgVm9sdW1lcyBpbiBMVk0sIGFuZCBidHJmcyBzdWJ2b2xzIGFyZSB2ZXJ5
IGRpZmZlcmVudAo+ID4+IHRoaW5ncy7CoCBCdHJmcyBzdWJ2b2xzIGFyZSByZWFsbHkganVzdCBz
dWJ0cmVlcyB0aGF0IGNhbiBiZSB0cmVhdGVkIGFzIGEKPiA+PiB1bml0IGZvciBvcGVyYXRpb25z
IGxpa2UgImNsb25lIiBvciAiZGVzdHJveSIuCj4gPj4KPiA+PiBBcyBzdWNoLCB0aGV5IGRvbid0
IHJlYWxseSBkZXNlcnZlIHNlcGFyYXRlIHN0X2RldiBudW1iZXJzLgo+ID4+Cj4gPj4gTWF5YmUg
dGhlIGRpZmZlcmVudCBzdF9kZXYgbnVtYmVycyB3ZXJlIGludHJvZHVjZWQgYXMgYSAiY2hlYXAi
IHdheSB0bwo+ID4+IGV4dGVuZCB0byBzaXplIG9mIHRoZSBpbm9kZS1udW1iZXIgc3BhY2UuwqAg
TGlrZSBtYW55ICJjaGVhcCIgdGhpbmdzLCBpdAo+ID4+IGhhcyBoaWRkZW4gY29zdHMuCj4gCj4g
Rm9yZ290IGFub3RoZXIgcHJvYmxlbSBhbHJlYWR5IGNhdXNlZCBieSB0aGlzIHN0X2RldiBtZXRo
b2QuCj4gCj4gU2luY2UgYnRyZnMgdXNlcyBzdF9kZXYgdG8gZGlzdGluZ3Vpc2ggdGhlbSBpdHMg
aW5vZGUgbmFtZSBzcGFjZSwgYW5kCj4gc3RfZGV2IGlzIGFsbG9jYXRlZCB1c2luZyBhbm9ueW1v
dXMgYmRldiwgYW5kIHRoZSBhbm9ueW1vdXMgYmRldiBwb29yCj4gaGFzIGxpbWl0ZWQgc2l6ZSAo
bXVjaCBzbWFsbGVyIHRoYW4gYnRyZnMgc3Vidm9sdW1lIGlkIG5hbWUgc3BhY2UpLCBpdCdzCj4g
YWxyZWFkeSBjYXVzaW5nIHByb2JsZW1zIGxpa2Ugd2UgY2FuJ3QgYWxsb2NhdGUgZW5vdWdoIGFu
b255bW91cyBiZGV2Cj4gZm9yIGVhY2ggc3Vidm9sdW1lLCBhbmQgZmFpbGVkIHRvIGNyZWF0ZSBz
dWJ2b2x1bWUvc25hcHNob3QuCgpXaGF0IHNvcnQgb2YgbnVtYmVycyBkbyB5b3Ugc2VlIGluIHBy
YWN0aWNlPyBIb3cgbWFueSBzdWJ2b2x1bWVzIGFuZCBob3cKbWFueSBpbm9kZXMgcGVyIHN1YnZv
bHVtZT8KSWYgd2UgYWxsb2NhdGVkIHNvbWUgbnVtYmVyIG9mIGJpdHMgdG8gZWFjaCwgd2l0aCBv
dmVyLWFsbG9jYXRpb24gdG8KYWxsb3cgZm9yIGdyb3d0aCwgY291bGQgd2UgZml0IGJvdGggaW50
byA2NCBiaXRzPwoKTmVpbEJyb3duCgoKPiAKPiBUaHVzIGl0J3MgcmVhbGx5IGEgdGltZSB0byBy
ZS1jb25zaWRlciBob3cgd2Ugc2hvdWxkIGV4cG9ydCB0aGlzIGluZm8gdG8KPiB1c2VyIHNwYWNl
Lgo+IAo+IFRoYW5rcywKPiBRdQo+IAo=
