Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137B370B99B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 12:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjEVKJD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 06:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjEVKJC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 06:09:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D684B7;
        Mon, 22 May 2023 03:09:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEEDB612D2;
        Mon, 22 May 2023 10:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48ACC433D2;
        Mon, 22 May 2023 10:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684750140;
        bh=f+TjsaX3pc2xNfuoY7ZIrIhtkHD0EV4+3vT4AgxlZoo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Vz/OwO68P0z5L3CcTBKeen8IVLpqKCsL+EO842KBN7gCjHaFesa6sRXd394htdAOI
         su2yqXMixtZrxma9KHqZWvVD26OZ2NfXlRfgmioOr7mq6JHgxeeZvoA4HPlH/pXvJf
         n81Mfy3yxMrTd1nmLHBxHz1RQB2JW9G5/mjdewZYsgLEYn/0Q0Mq9ZW7kjcttSO6UF
         1zA/dUD2Bi9qa/wHnRmHW9IMbfpTIsElnwjHROeunSLM2e2bqJyGqOSTljtq9puP4r
         m9LJtebKI9H7nCfLs43DOVOxPvFnr5zfO3fRtm1V6Jb3vQOLwCpRbbf3SnQxMfOzBU
         bE97FQJ+17UOg==
Message-ID: <cde7bc1874e2d69860ecdb87d4e21c762f355aea.camel@kernel.org>
Subject: Re: [PATCH v4 9/9] btrfs: convert to multigrain timestamps
From:   Jeff Layton <jlayton@kernel.org>
To:     dsterba@suse.cz
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Neil Brown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore T'so <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Date:   Mon, 22 May 2023 06:08:56 -0400
In-Reply-To: <20230522095601.GH32559@twin.jikos.cz>
References: <20230518114742.128950-1-jlayton@kernel.org>
         <20230518114742.128950-10-jlayton@kernel.org>
         <20230522095601.GH32559@twin.jikos.cz>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-05-22 at 11:56 +0200, David Sterba wrote:
> On Thu, May 18, 2023 at 07:47:42AM -0400, Jeff Layton wrote:
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> Acked-by: David Sterba <dsterba@suse.com>
>=20
> Please add a brief description to the changelog too, there's a similar
> text in the patches adding the infrastructure. Something like "Allow to
> optimize lot of metadata updates by encoding the status in the cmtime.
> The fine grained time is needed for NFS."

Sure thing.

Christian, do you want to just alter the changelog with David's
suggestion, or would you rather I resend the series?

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
