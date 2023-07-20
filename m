Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC9175B1C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 16:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjGTOyX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 10:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjGTOyW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:54:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A391D26A5;
        Thu, 20 Jul 2023 07:54:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA45D61B3B;
        Thu, 20 Jul 2023 14:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7964DC433C7;
        Thu, 20 Jul 2023 14:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689864858;
        bh=11YbwPwdOeBGa2/GdDUF/tahF2JXkraunLOEmLuGVCk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GcrwD89xwB6XY94RCqx51TG0nCV5c143s4Wl90LC96IFjZiunJD6wTSxU1fqF2ND3
         eupNZtyGOTw4g+Oiczp46tj5jAufMO+Lc/A/+KGMiYm6gCiQNuHB6qZLDAcOmNJD82
         u79vKnZP5ts0Zew+nJubqaE408f+6yz2+gSumOVe8YEpZeA1JIUMMhCdvK6ANOcNYG
         2P+XHXJiPC6nnYOxxE7Ubaf8BUXroI1yaEJUqbJNXbpZoc1YcYuF83A84Aw/xYToNA
         XrT3LQAFmNrFq6QGMQeIvpSRWhd4TTUM/0iNGbCkV6BOIHazzf2l9OqR8HJ+iyxG+v
         D5I6lo0wWjtaQ==
Message-ID: <f541027cca189c42550136aab27b89889cd2fdd3.camel@kernel.org>
Subject: Re: [PATCH v2] ext4: fix the time handling macros when ext4 is
 using small inodes
From:   Jeff Layton <jlayton@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Hugh Dickins <hughd@google.com>
Date:   Thu, 20 Jul 2023 10:54:16 -0400
In-Reply-To: <20230720144807.GC5764@mit.edu>
References: <20230719-ctime-v2-1-869825696d6d@kernel.org>
         <20230720144807.GC5764@mit.edu>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-07-20 at 10:48 -0400, Theodore Ts'o wrote:
> On Wed, Jul 19, 2023 at 06:32:19AM -0400, Jeff Layton wrote:
> > If ext4 is using small on-disk inodes, then it may not be able to store
> > fine grained timestamps. It also can't store the i_crtime at all in tha=
t
> > case since that fully lives in the extended part of the inode.
> >=20
> > 979492850abd got the EXT4_EINODE_{GET,SET}_XTIME macros wrong, and woul=
d
> > still store the tv_sec field of the i_crtime into the raw_inode, even
> > when they were small, corrupting adjacent memory.
> >=20
> > This fixes those macros to skip setting anything in the raw_inode if th=
e
> > tv_sec field doesn't fit, and to properly return a {0,0} timestamp when
> > the raw_inode doesn't support it.
> >=20
> > Also, fix a bug in ctime handling during rename. It was updating the
> > renamed inode's ctime twice rather than the old directory.
> >=20
> > Cc: Jan Kara <jack@suse.cz>
> > Fixes: 979492850abd ("ext4: convert to ctime accessor functions")
> > Reported-by: Hugh Dickins <hughd@google.com>
> > Tested-by: Hugh Dickins <hughd@google.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> Acked-by: Theodore Ts'o <tytso@mit.edu>
>=20
> I assume this is will be applied to the vfs.ctime branch, yes?
>=20
>   	      	      	 	    	- Ted

Yes. Ideally it'll be folded into the ext4 patch there.
--=20
Jeff Layton <jlayton@kernel.org>
