Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3916358F5DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 04:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbiHKC1O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 22:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiHKC1N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:27:13 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45576DF93;
        Wed, 10 Aug 2022 19:27:12 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id 125so17039401vsd.5;
        Wed, 10 Aug 2022 19:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=VJM36uWLDxfeJQlAFkEV/QezYqkubDOj56Ng+gg+/7E=;
        b=Ej9pFI8Q7kvV+CFv37XGsy/NEn86Qcpx0Xv7otEUvny412pfSUyQLt6QwEemb6ohKT
         gEhShEl6cVmN0KBYH5L9xLPajyTkKF74oFnEGOigX3kA/etAbo9mBUUiEp1hVRD8lZfj
         0LaSFMbj3PZXhK4VwCIEPhqpO2OxATZQ8/2DeqJKRLVjzk/Sdrny8+YJ3EghO6hjAioA
         NaMGbRwvxcl0Losi2omS9ClpLT8qkEG396YP3d4LXWibELjNgYVU7rBjcwBMvEipJxdo
         UQOj/BlYI6m2ueYLgQ5c8TGzKoBLlN3jWoYwqZsSHVOLH8PbMl5ySuPXVlB7MUHxvBwL
         /nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VJM36uWLDxfeJQlAFkEV/QezYqkubDOj56Ng+gg+/7E=;
        b=pg1mGsdgknODg5tKoFt7oYKYVBHtzeO6R+0GgE+HBirZa0kydDWHxsqJGvD44iG+57
         OjIneC3oVjOc5DosymAa0cNhUVSsPp1Yd9isaS0hm3yRSmaqEhkheTVhN994k3emSFp6
         ABkTuQ/dLvoCli0JLW9SfSf5xNht4vZagJxLsxALNrf6Q22o+UU3bsObVCz+xNK3Fr3K
         zIA/h4qaxmbQjUdEeOTqnTFIUOfBzQYj/zk0VsbuaKBfeX8MSFxM6tn2kJjhiNmtqaJP
         G9Enwxc1zPWJDHXtjRdM/lKqupE/rhg6E2P0lXpF6MDSNN7xJIvxNG4NtXvcutEuHVBL
         nR6Q==
X-Gm-Message-State: ACgBeo1XMzSy6T9IMA3bjKlnUGkgmtScn2bAqFWvFecM4nT/VrI94HhA
        yBqNo9nlqXPk9c62bq4tWiYuVMvxmdZHj7bk1Pg=
X-Google-Smtp-Source: AA6agR6ydFsGzmNajdFj2oPokfsZ87P0NQSCiy1h2s6ZTRZ6d5WPYinPuMD4H76wcmQfpSvGcKNJwFsM3Pw1+r24Y4s=
X-Received: by 2002:a67:b24b:0:b0:357:31a6:1767 with SMTP id
 s11-20020a67b24b000000b0035731a61767mr12620416vsh.29.1660184831703; Wed, 10
 Aug 2022 19:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <165996923111.209242.10532553567023183407.stgit@warthog.procyon.org.uk>
 <c4e26f69d38c4294038430487bf10e88fa980e0b.camel@kernel.org>
In-Reply-To: <c4e26f69d38c4294038430487bf10e88fa980e0b.camel@kernel.org>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 10 Aug 2022 21:27:00 -0500
Message-ID: <CAH2r5mubvk83SkDmiw0YUW2W6g0o7-Q3hr1KKtOC1DRRP6yOcQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: Remove {cifs,nfs}_fscache_release_page()
To:     Jeff Layton <jlayton@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

merged into cifs-2.6.git for-next

On Mon, Aug 8, 2022 at 9:51 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Mon, 2022-08-08 at 15:33 +0100, David Howells wrote:
> > Remove {cifs,nfs}_fscache_release_page() from fs/cifs/fscache.h.  This
> > functionality got built directly into cifs_release_folio() and will
> > hopefully be replaced with netfs_release_folio() at some point.
> >
> > The "nfs_" version is a copy and paste error and should've been altered to
> > read "cifs_".  That can also be removed.
> >
> > Reported-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Jeff Layton <jlayton@redhat.com>
> > cc: Steve French <smfrench@gmail.com>
> > cc: linux-cifs@vger.kernel.org
> > cc: samba-technical@lists.samba.org
> > cc: linux-fsdevel@vger.kernel.org
> > ---
> >
> >  fs/cifs/fscache.h |   16 ----------------
> >  1 file changed, 16 deletions(-)
> >
> > diff --git a/fs/cifs/fscache.h b/fs/cifs/fscache.h
> > index aa3b941a5555..67b601041f0a 100644
> > --- a/fs/cifs/fscache.h
> > +++ b/fs/cifs/fscache.h
> > @@ -108,17 +108,6 @@ static inline void cifs_readpage_to_fscache(struct inode *inode,
> >               __cifs_readpage_to_fscache(inode, page);
> >  }
> >
> > -static inline int cifs_fscache_release_page(struct page *page, gfp_t gfp)
> > -{
> > -     if (PageFsCache(page)) {
> > -             if (current_is_kswapd() || !(gfp & __GFP_FS))
> > -                     return false;
> > -             wait_on_page_fscache(page);
> > -             fscache_note_page_release(cifs_inode_cookie(page->mapping->host));
> > -     }
> > -     return true;
> > -}
> > -
> >  #else /* CONFIG_CIFS_FSCACHE */
> >  static inline
> >  void cifs_fscache_fill_coherency(struct inode *inode,
> > @@ -154,11 +143,6 @@ cifs_readpage_from_fscache(struct inode *inode, struct page *page)
> >  static inline
> >  void cifs_readpage_to_fscache(struct inode *inode, struct page *page) {}
> >
> > -static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
> > -{
> > -     return true; /* May release page */
> > -}
> > -
> >  #endif /* CONFIG_CIFS_FSCACHE */
> >
> >  #endif /* _CIFS_FSCACHE_H */
> >
> >
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>



-- 
Thanks,

Steve
