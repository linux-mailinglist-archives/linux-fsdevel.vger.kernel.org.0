Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B32C58CAC6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Aug 2022 16:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242796AbiHHOvj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 10:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbiHHOvh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:51:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EA1627C;
        Mon,  8 Aug 2022 07:51:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A117B80EE8;
        Mon,  8 Aug 2022 14:51:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B98C433D6;
        Mon,  8 Aug 2022 14:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659970291;
        bh=zYRnrfeP8ogVaktIwQGSynPL2OROqygzFRr2pMdrg6o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Y+2dHbFA6NZ6XTuU30AuLcH3/K1GnydqX3Xm837AxSdIKo3JGwx/NmwHT+fugMZAO
         CinpdBDGYzZW2zkjFCarnqfINvIA6Tl2TABH+cXpr8agO2C8n+quWpxpAh5J2fOrAs
         pTx6hJpMGUcIgzTG04F8sN+rCN1N9S/rpmoWtM0syuXlEXGzx8mCKN+mqMpLqzh3CU
         Y1D5g4HDCsZ5k0/uKRKw7bElRkYj1phtbtnwPAH+rPVtxepwwP31So1Y7Eq7OgdV+K
         FC4Btm1ZsxkmCeDcCyplyqI91kAL0hpF4T28o5zD86aLKTIcbqzdiEeBtgGFmEZgXm
         iv6jPfuGcXDfA==
Message-ID: <c4e26f69d38c4294038430487bf10e88fa980e0b.camel@kernel.org>
Subject: Re: [PATCH] cifs: Remove {cifs,nfs}_fscache_release_page()
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, willy@infradead.org
Cc:     Steve French <smfrench@gmail.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 08 Aug 2022 10:51:29 -0400
In-Reply-To: <165996923111.209242.10532553567023183407.stgit@warthog.procyon.org.uk>
References: <165996923111.209242.10532553567023183407.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-08-08 at 15:33 +0100, David Howells wrote:
> Remove {cifs,nfs}_fscache_release_page() from fs/cifs/fscache.h.  This
> functionality got built directly into cifs_release_folio() and will
> hopefully be replaced with netfs_release_folio() at some point.
>=20
> The "nfs_" version is a copy and paste error and should've been altered t=
o
> read "cifs_".  That can also be removed.
>=20
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@redhat.com>
> cc: Steve French <smfrench@gmail.com>
> cc: linux-cifs@vger.kernel.org
> cc: samba-technical@lists.samba.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>=20
>  fs/cifs/fscache.h |   16 ----------------
>  1 file changed, 16 deletions(-)
>=20
> diff --git a/fs/cifs/fscache.h b/fs/cifs/fscache.h
> index aa3b941a5555..67b601041f0a 100644
> --- a/fs/cifs/fscache.h
> +++ b/fs/cifs/fscache.h
> @@ -108,17 +108,6 @@ static inline void cifs_readpage_to_fscache(struct i=
node *inode,
>  		__cifs_readpage_to_fscache(inode, page);
>  }
> =20
> -static inline int cifs_fscache_release_page(struct page *page, gfp_t gfp=
)
> -{
> -	if (PageFsCache(page)) {
> -		if (current_is_kswapd() || !(gfp & __GFP_FS))
> -			return false;
> -		wait_on_page_fscache(page);
> -		fscache_note_page_release(cifs_inode_cookie(page->mapping->host));
> -	}
> -	return true;
> -}
> -
>  #else /* CONFIG_CIFS_FSCACHE */
>  static inline
>  void cifs_fscache_fill_coherency(struct inode *inode,
> @@ -154,11 +143,6 @@ cifs_readpage_from_fscache(struct inode *inode, stru=
ct page *page)
>  static inline
>  void cifs_readpage_to_fscache(struct inode *inode, struct page *page) {}
> =20
> -static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
> -{
> -	return true; /* May release page */
> -}
> -
>  #endif /* CONFIG_CIFS_FSCACHE */
> =20
>  #endif /* _CIFS_FSCACHE_H */
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
