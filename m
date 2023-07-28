Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8173576792D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jul 2023 01:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbjG1XzK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 19:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjG1XzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 19:55:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A691A4231;
        Fri, 28 Jul 2023 16:55:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 582231F896;
        Fri, 28 Jul 2023 23:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690588505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vpkws96VxtaEEsabDbCElfZ/CAGrK02wRH+80AynJeI=;
        b=Zg53RflBzXPb/WjOhq9z7GxPVaVruduuA94kKZsJzMtKSgnxgDI5subY4BsPKxKUj9bawz
        R8IYSw0j2TterfOw53YuY58c+Hd4LizvlARaUXX+5LbD5+ptMqSBHyBgjlVKJI92alnzLb
        RtXNi0nCF9IwrnONB9jSWfS5SJgSWbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690588505;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vpkws96VxtaEEsabDbCElfZ/CAGrK02wRH+80AynJeI=;
        b=8Q55lJUXFBHf57Cv+CiVQiUiSOH7V5hOKA6feYU+GV3JRVICNdSfLqIBR1+peepyi30Au+
        Ahu9gx8p4TVr9XAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC26D13276;
        Fri, 28 Jul 2023 23:55:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EVBRJ1VVxGTpfgAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 28 Jul 2023 23:55:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <cel@kernel.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>,
        "David Howells" <dhowells@redhat.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Hugh Dickins" <hughd@google.com>, "Jens Axboe" <axboe@kernel.dk>,
        "Matthew Wilcox" <willy@infradead.org>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] nfsd: Fix reading via splice
In-reply-to: <169054754615.3783.11682801287165281930.stgit@klimt.1015granger.net>
References: <169054754615.3783.11682801287165281930.stgit@klimt.1015granger.net>
Date:   Sat, 29 Jul 2023 09:54:58 +1000
Message-id: <169058849828.32308.14965537137761913794@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 28 Jul 2023, Chuck Lever wrote:
> From: David Howells <dhowells@redhat.com>
>=20
> nfsd_splice_actor() has a clause in its loop that chops up a compound page
> into individual pages such that if the same page is seen twice in a row, it
> is discarded the second time.  This is a problem with the advent of
> shmem_splice_read() as that inserts zero_pages into the pipe in lieu of
> pages that aren't present in the pagecache.
>=20
> Fix this by assuming that the last page is being extended only if the
> currently stored length + starting offset is not currently on a page
> boundary.
>=20
> This can be tested by NFS-exporting a tmpfs filesystem on the test machine
> and truncating it to more than a page in size (eg. truncate -s 8192) and
> then reading it by NFS.  The first page will be all zeros, but thereafter
> garbage will be read.
>=20
> Note: I wonder if we can ever get a situation now where we get a splice
> that gives us contiguous parts of a page in separate actor calls.  As NFSD
> can only be splicing from a file (I think), there are only three sources of
> the page: copy_splice_read(), shmem_splice_read() and file_splice_read().
> The first allocates pages for the data it reads, so the problem cannot
> occur; the second should never see a partial page; and the third waits for
> each page to become available before we're allowed to read from it.
>=20
> Fixes: bd194b187115 ("shmem: Implement splice-read")
> Reported-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> cc: Hugh Dickins <hughd@google.com>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: linux-nfs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 59b7d60ae33e..ee3bbaa79478 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -956,10 +956,13 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, struc=
t pipe_buffer *buf,
>  	last_page =3D page + (offset + sd->len - 1) / PAGE_SIZE;
>  	for (page +=3D offset / PAGE_SIZE; page <=3D last_page; page++) {
>  		/*
> -		 * Skip page replacement when extending the contents
> -		 * of the current page.
> +		 * Skip page replacement when extending the contents of the
> +		 * current page.  But note that we may get two zero_pages in a
> +		 * row from shmem.
>  		 */
> -		if (page =3D=3D *(rqstp->rq_next_page - 1))
> +		if (page =3D=3D *(rqstp->rq_next_page - 1) &&
> +		    offset_in_page(rqstp->rq_res.page_base +
> +				   rqstp->rq_res.page_len))

This seems fragile in that it makes assumptions about the pages being
sent and their alignment.
Given that it was broken by the splice-read change, that confirms it is
fragile.  Maybe we could make the code a bit more explicit about what is
expected.

Also, I don't think this test can ever be relevant after the first time
through the loop.  So I think it would be clearest to have the
interesting case outside the loop.

 page +=3D offset / PAGE_SIZE;
 if (rqstp->rq_res.pages_len > 0) {
      /* appending to page list - check alignment */
      if (offset % PAGE_SIZE !=3D (rqstp->rq_res.page_base +
                                 rqstp-.rq_res.page_len) % PAGE_SIZE)
	  return -EIO;
      if (offset % PAGE_SIZE !=3D 0) {
           /* continuing previous page */
           if (page !=3D rqstp->rq_next_page[-1])
               return -EIO;
	   page +=3D 1;
      }
 } else
      /* Starting new page list */
      rqstp->rq_res.page_base =3D offset % PAGE_SIZE;

 for ( ; page <=3D last_page ; page++)
       if (unlikely(!svc_rqst_replace_page(rqstp, page)))
           return -EIO;

 rqstp->rq_res.page_len +=3D sd->len;
 return sd->len;


Also, the name "svc_rqst_replace_page" doesn't give any hint that the
next_page pointer is advanced.  Maybe svc_rqst_add_page() ???  Not great
I admit.

NeilBrown

  =20

>  			continue;
>  		if (unlikely(!svc_rqst_replace_page(rqstp, page)))
>  			return -EIO;
>=20
>=20
>=20

