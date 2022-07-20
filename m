Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D06057C0B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 01:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiGTXPy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 19:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiGTXPx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 19:15:53 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E122B66AFF;
        Wed, 20 Jul 2022 16:15:50 -0700 (PDT)
Content-Type: multipart/signed;
        boundary="Apple-Mail=_1A5477F2-D165-412B-B925-92359613B8D1";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: WARNING: CPU: 1 PID: 14735 at fs/dcache.c:365
 dentry_free+0x100/0x128
From:   Sam James <sam@gentoo.org>
In-Reply-To: <Ytg2CDLzLo+FKbTZ@ZenIV>
Date:   Thu, 21 Jul 2022 00:15:43 +0100
Cc:     Hillf Danton <hdanton@sina.com>, Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Message-Id: <9B4CB715-FEA1-4991-ABA1-23B2DF203258@gentoo.org>
References: <20220709090756.2384-1-hdanton@sina.com>
 <20220715133300.1297-1-hdanton@sina.com>
 <cff76e00-3561-4069-f5c7-26d3de4da3c4@gmx.de> <Ytd2g72cj0Aq1MBG@ZenIV>
 <860792bb-1fd6-66c6-ef31-4edd181e2954@gmx.de> <YtepmwLj//zrD3V3@ZenIV>
 <20220720110032.1787-1-hdanton@sina.com> <Ytg2CDLzLo+FKbTZ@ZenIV>
To:     Al Viro <viro@zeniv.linux.org.uk>, Helge Deller <deller@gmx.de>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_1A5477F2-D165-412B-B925-92359613B8D1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii



> On 20 Jul 2022, at 18:06, Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> On Wed, Jul 20, 2022 at 07:00:32PM +0800, Hillf Danton wrote:
> 
>> To help debug it, de-union d_in_lookup_hash with d_alias and add debug
>> info after dentry is killed. If any warning hits, we know where to add
>> something like
>> 
>> 	WARN_ON(dentry->d_flags & DCACHE_DENTRY_KILLED);
>> 
>> before hlist_bl_add or hlist_add.

> [snip]
> I wonder if anyone had seen anything similar outside of parisc...
> I don't know if I have any chance to reproduce it here - the only
> parisc box I've got is a 715/100 (assuming the disk is still alive)
> and it's 32bit, unlike the reported setups and, er, not fast.
> qemu seems to have some parisc support, but it's 32bit-only at the
> moment...

I don't think I've seen this on parisc either, but I don't think
I've used tmpfs that heavily. I'll try it in case it's somehow more
likely to trigger it.

Helge, were there any particular steps to reproduce this? Or just
start doing your normal Debian builds on a tmpfs and it happens
soon enough?


--Apple-Mail=_1A5477F2-D165-412B-B925-92359613B8D1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iNUEARYKAH0WIQQlpruI3Zt2TGtVQcJzhAn1IN+RkAUCYtiMn18UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0MjVB
NkJCODhERDlCNzY0QzZCNTU0MUMyNzM4NDA5RjUyMERGOTE5MAAKCRBzhAn1IN+R
kC/ZAP41H2nChPS5kcT3/RPjAriOl8IqbRAX0xhphni9gDrL0wEA5pTvzToiSULd
MSJA6dtocW+ZwQjPiokSt8vHK6HKCgI=
=tB0a
-----END PGP SIGNATURE-----

--Apple-Mail=_1A5477F2-D165-412B-B925-92359613B8D1--
