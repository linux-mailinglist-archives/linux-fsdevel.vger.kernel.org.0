Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F3472B964
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 09:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjFLH6u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 03:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237007AbjFLHzi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:55:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800C52681;
        Mon, 12 Jun 2023 00:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=H1HxyiqAlmaT/pjGlflpXqH7A85wjdG77fGIXa2INEQ=; b=rrNWN6G4fDwMPYb1CdtY5PiXG6
        9GZvJhparX7QtmLlo4u/mHIKuTNcfXUi6WErhmstRR4sSqwE3PA/9icsBoAXnuvU+3EOUFKRM3pKs
        hLEjDtI0tQCcT40nh/5MvIOMj+FV0mH5FVTAM3VQRnPAVaSUXMBk30EEpzpVxJPpVYmmF/cqMJ3PM
        TZnqPgITNcxq/hi8+wSIdyfJMP2H8Dsdd/dk++XtWPYS4tm3G8vXK+8MgiIDfSTGNE6hzL10PmOaU
        FqHX8MQcT0O+zTf/xxqgv/i0/J/oc88m2EOFiU1wHeFuAaEHXFLCgkCRPgQ8YNTwqg0O0n/scdaPH
        1JNxcjiQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8b9s-002mmj-02;
        Mon, 12 Jun 2023 06:36:08 +0000
Date:   Sun, 11 Jun 2023 23:36:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 2/3] fs: introduce f_real_path() helper
Message-ID: <ZIa81+M0HeOzVQQb@infradead.org>
References: <20230611132732.1502040-1-amir73il@gmail.com>
 <20230611132732.1502040-3-amir73il@gmail.com>
 <ZIagx5ObeBDeXmni@infradead.org>
 <CAOQ4uxjm4nXc4cHFCnk69RC2yshBmFBxMTuVxH3QQRm_6LRcSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjm4nXc4cHFCnk69RC2yshBmFBxMTuVxH3QQRm_6LRcSw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 09:28:40AM +0300, Amir Goldstein wrote:
> On Mon, Jun 12, 2023 at 7:36 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Sun, Jun 11, 2023 at 04:27:31PM +0300, Amir Goldstein wrote:
> > > Overlayfs knows the real path of underlying dentries.  Add an optional
> > > struct vfsmount out argument to ->d_real(), so callers could compose the
> > > real path.
> > >
> > > Add a helper f_real_path() that uses this new interface to return the
> > > real path of f_inode, for overlayfs internal files whose f_path if a
> > > "fake" overlayfs path and f_inode is the underlying real inode.
> >
> > I really don't like this ->d_real nagic.  Most callers of it
> > really can't ever be on overlayfs.
> 
> Which callers are you referring to?

Most users of file_dentry are inside file systems and will never
see the overlayfs path.

> > So I'd suggest we do an audit
> > of the callers of file_dentry and drop all the pointless ones
> > first, and improve the documentation on when to use it.
> 
> Well, v3 is trying to reduce ->d_real() magic and the step
> after introducing the alternative path container is to convert
> file_dentry() to use the stored real_path instead of ->d_real().

Yeah, that makes this comment kinda irrelevant.

