Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7777B54EC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 16:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237627AbjJBOQR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 10:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237538AbjJBOQP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:16:15 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5491AB8
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 07:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LzgASRLTwFS2nb/ET9v4liE2KFk7yYdADZAVC3TmjfE=; b=Ch+rRO38RsVExe4ZATRton0zTb
        ulFYmICmlz0DOC+L/F2jq/sAF4oyHVDELAWk6kJ8YNOOEFpmfd55W6HbkMAnMW0IPJnKCElHxhnoU
        MvLNgbKuOKw9/TKfXHHdShNJB9TIVvC1leqVOLryxuwON51rg7y7nngblZ8pzNwzn502IJTBLul30
        8pNS1KJyCan/EDgrL7cTKRTdb84jfeYwBoCryK4eZWayJDIsvU9SY2ldmT3Eir3pcEnwLEyec9xIa
        a7CqSPhEKvZhJbXmdarlfUgseBJztOpDRdXZJkwRu9nn2Rz8YFuNrTfkGdnTDcqHHp1rQQU2VwIFQ
        HvDGyXmg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qnJiU-00EUMl-1l;
        Mon, 02 Oct 2023 14:16:10 +0000
Date:   Mon, 2 Oct 2023 15:16:10 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Bob Peterson <rpeterso@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Steve French <sfrench@samba.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 08/15] gfs2: fix an oops in gfs2_permission()
Message-ID: <20231002141610.GX800259@ZenIV>
References: <20231002022815.GQ800259@ZenIV>
 <20231002022846.GA3389589@ZenIV>
 <20231002023344.GI3389589@ZenIV>
 <7f422261-92ef-32df-6640-dab9d68e1023@redhat.com>
 <20231002125946.GW800259@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002125946.GW800259@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 02, 2023 at 01:59:46PM +0100, Al Viro wrote:
> On Mon, Oct 02, 2023 at 06:46:03AM -0500, Bob Peterson wrote:
> > > diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> > > index 0eac04507904..e2432c327599 100644
> > > --- a/fs/gfs2/inode.c
> > > +++ b/fs/gfs2/inode.c
> > > @@ -1868,14 +1868,16 @@ int gfs2_permission(struct mnt_idmap *idmap, struct inode *inode,
> > >   {
> > >   	struct gfs2_inode *ip;
> > >   	struct gfs2_holder i_gh;
> > > +	struct gfs2_glock *gl;
> > >   	int error;
> > >   	gfs2_holder_mark_uninitialized(&i_gh);
> > >   	ip = GFS2_I(inode);
> > > -	if (gfs2_glock_is_locked_by_me(ip->i_gl) == NULL) {
> > > +	gl = rcu_dereference(ip->i_gl);
> > > +	if (!gl || gfs2_glock_is_locked_by_me(gl) == NULL) {
> > 
> > This looks wrong. It should be if (gl && ... otherwise the
> > gfs2_glock_nq_init will dereference the null pointer.
> 
> We shouldn't observe NULL ->i_gl unless we are in RCU mode,
> which means we'll bail out without reaching gfs2_glock_nq_init()...

Something like
	if (unlikely(!gl)) {
		/* inode is getting torn down, must be RCU mode */
		WARN_ON_ONCE(!(mask & MAY_NOT_BLOCK));
		return -ECHILD;
	}
might be less confusing way to express that...
