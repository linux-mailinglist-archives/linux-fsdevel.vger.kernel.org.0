Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350116EE811
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 21:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbjDYTMi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 15:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbjDYTMg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 15:12:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2D416F00;
        Tue, 25 Apr 2023 12:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D41463107;
        Tue, 25 Apr 2023 19:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51489C433EF;
        Tue, 25 Apr 2023 19:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682449953;
        bh=lMDAKv+dWFO6VkWUCnMr163Sk2UkfZaflcg85AFNg4o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hNysl+t5lkcBFn5CSWQ8toXWyK/+6AVSyIsFdzKmdx2nrRruksUKDv2q+kkco8ldw
         AatdU65HJvfsAWGaXB3bDdvB8Iyl/lNyjI3HnssP1fPjRZT4BL7xQRpNy+OFjPxyWp
         R3KEfAr8Pokc522ah0tFu5zUA6wFTCaDiJhgU7wP4eJkStWO7sA5DdiJUAyav5OsqP
         5ItJNMp+T+9EZczVDYT+HEAxszUHJgYR9XlJ+m6d7Rl6L8PnRlakPeMx8ArQahyHTt
         rGKx6HvWdwqt86iZ7RQpBFrO5y3wRJgoq6qmLouQnQtwBQWcxEbbW7iBFlKP4rN1yX
         z9gGYrOyUWxXA==
Message-ID: <fa38f7a8e6f60753d5cb7f8949263f435cf613ec.camel@kernel.org>
Subject: Re: [PATCH v2 1/3] fs: add infrastructure for multigrain inode
 i_m/ctime
From:   Jeff Layton <jlayton@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     NeilBrown <neilb@suse.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Date:   Tue, 25 Apr 2023 15:12:30 -0400
In-Reply-To: <ZEgUSw15g4Wbo91Z@casper.infradead.org>
References: <20230424151104.175456-1-jlayton@kernel.org>
         <20230424151104.175456-2-jlayton@kernel.org>
         <168237287734.24821.11016713590413362200@noble.neil.brown.name>
         <404a9a8066b0735c9f355214d4eadf0d975b3188.camel@kernel.org>
         <168237601955.24821.11999779095797667429@noble.neil.brown.name>
         <aa60b0fa23c1d582cfad0da5b771d427d00c4316.camel@kernel.org>
         <ZEgUSw15g4Wbo91Z@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0 (3.48.0-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-04-25 at 18:56 +0100, Matthew Wilcox wrote:
> On Tue, Apr 25, 2023 at 01:45:19PM -0400, Jeff Layton wrote:
> > Erm...it may be an unpopular opinion, but I find that more confusing
> > than just ensuring that the s_time_gran > 1. I keep wondering if we
> > might want to carve out other low-order bits too for some later purpose=
,
> > at which point trying to check this using flags wouldn't work right. I
> > think I might just stick with what I have here, at least for now.
>=20
> But what if I set s_time_gran to 3 or 5?  You'd really want a warning
> about that.

Ugh, I hadn't considered that. I don't see anyone that sets an odd
s_time_gran that isn't 1, but OK, good point. I'll change it.
--=20
Jeff Layton <jlayton@kernel.org>
