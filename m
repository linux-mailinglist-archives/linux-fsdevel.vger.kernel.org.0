Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E152F55CEA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345002AbiF1MU6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 08:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344426AbiF1MU5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:20:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370982ED5E
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 05:20:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C72D861369
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 12:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B04C3411D;
        Tue, 28 Jun 2022 12:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656418856;
        bh=RzBfVy028WaljwYPBi0cXZ9CpNyOKxLVU4vztcx9AWk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nZhuj3iQaImZ07TXA8eDn0Fcy7JyYpw35DHdmPNMLmamOo7+rpGRj2hHQqxUz0Xyh
         VEeIik+4fMU/5rK2bJniEMvy6MLDnnLHAz7m11uJ3UJbFpII66sJEtYBinc2+zjphb
         j8sT+RhiLr+HFd61zaXR0g0CkR8tVbXXk05pmkX3t//Xz6q1YXtQJq0aacemGBiNsd
         cxsBjFBQeiE8+G4Ic6nMWbHOz3rat4sd6pVhptuUfXVRCCnZaW5sGQBwsJ3y+Xnloz
         VZsVLs2ZpIiF5y5fIDKVzBYALd4A/Jj46NyImYUYAHXdjO4vK3713qR43jFxR/76S9
         LzInxCMlFH6kg==
Message-ID: <e1f2e397cd698c89e7ebc536316c8ada970076bb.camel@kernel.org>
Subject: Re: [PATCH 41/44] ceph: switch the last caller of
 iov_iter_get_pages_alloc()
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Jun 2022 08:20:54 -0400
In-Reply-To: <20220622041552.737754-41-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-41-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-06-22 at 05:15 +0100, Al Viro wrote:
> here nothing even looks at the iov_iter after the call, so we couldn't
> care less whether it advances or not.
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/ceph/addr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 6dee88815491..3c8a7cf19e5d 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -329,7 +329,7 @@ static void ceph_netfs_issue_read(struct netfs_io_sub=
request *subreq)
> =20
>  	dout("%s: pos=3D%llu orig_len=3D%zu len=3D%llu\n", __func__, subreq->st=
art, subreq->len, len);
>  	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages, subreq->start, le=
n);
> -	err =3D iov_iter_get_pages_alloc(&iter, &pages, len, &page_off);
> +	err =3D iov_iter_get_pages_alloc2(&iter, &pages, len, &page_off);
>  	if (err < 0) {
>  		dout("%s: iov_ter_get_pages_alloc returned %d\n", __func__, err);
>  		goto out;

There are some coming changes to make this code use an iter passed in as
part of the subreq, at which point we will need to advance this anyway.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
