Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBF25F4050
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 11:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJDJva (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 05:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiJDJvL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:51:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1597A13E04;
        Tue,  4 Oct 2022 02:49:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E5136124D;
        Tue,  4 Oct 2022 09:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78C6C433D6;
        Tue,  4 Oct 2022 09:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664876970;
        bh=JShKPjukLKc2FkAbPmfz11KnSAwSr4b3iKqEcwutaws=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EUUP/G0DjPJ+g90KkigCmXO+mdCWqk22LJNWzAEFtcAvKzEyOS9o1A7UY1xUAu/8o
         sBvjJ9RaxJA5QV4Us+BjhOZIikjUN1IyZl9b1wnpTLUB5v+Ygcyu9a9lkg3FWkj/JS
         Z0qFUkouJx4GJvmX89hzNwWw3p0iPT8ofsGElKLo+EVHXF7BRAqT/b0LbFasVFOpD0
         icrh4y9yzOcqWJ+LUlsO6S+q7XcMFTRWNAIxmuQFlvIu4qMlzdOaJ1b03PWVYba7/1
         weKspt+33Hj9Xq8hSsNrmt0DHERzsZctNdBntun0IB87rn68lapvqbQdYFV+KEHYI3
         5tltjpDrHsDyA==
Message-ID: <ed6de946a3b9f30d1c96f5214a3d6912ac1c742e.camel@kernel.org>
Subject: Re: [PATCH v2 08/23] ceph: Convert ceph_writepages_start() to use
 filemap_get_folios_tag()
From:   Jeff Layton <jlayton@kernel.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Date:   Tue, 04 Oct 2022 05:49:28 -0400
In-Reply-To: <Yzv37tg5wECSgQ/1@suse.de>
References: <20220912182224.514561-1-vishal.moola@gmail.com>
         <20220912182224.514561-9-vishal.moola@gmail.com>
         <35d965bbc3d27e43d6743fc3a5cb042503a1b7bf.camel@kernel.org>
         <Yzv37tg5wECSgQ/1@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-10-04 at 10:07 +0100, Lu=EDs Henriques wrote:
> Hi Jeff,
>=20
> (Trimming down the CC list)
>=20
> On Fri, Sep 30, 2022 at 12:25:15PM -0400, Jeff Layton wrote:
> >=20
> > We have some work in progress to add write helpers to netfslib. Once we
> > get those in place, we plan to convert ceph to use them. At that point
> > ceph_writepages just goes away.
>=20
> Sorry for hijacking this thread, but I was wondering if there was
> something I could help here.  I haven't seen any netfs patches for this
> lately, but I may have been looking at the wrong places.  I guess these
> are still the bits that are holding the ceph fscrypt from progressing, so=
,
> again, I'd be happy to at least help with the testing.
>=20

Work is somewhat stalled at the moment. David was on holiday for a while
and I've had other priorities. I would like to see this wrapped up soon
too however.
--=20
Jeff Layton <jlayton@kernel.org>
