Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6527B538E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 15:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbjJBM74 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 08:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237265AbjJBM7y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:59:54 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D30B7
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 05:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uAAKrsPDMveaMjetqB0NfXDzCo6lMwpCuY69Dkw/62Q=; b=MCLsoPmmuQ3Lc6BRSJSheDszbd
        p5TkpIc5hrQkPCkuLw48mGIb1Dzq9snI2fIVW/upx+x7n9tJn/gmk2X89WBfDVjQNXMBW5w4D/AGT
        BeD5kgexD7hD7ifTCLix0/J3xXre3toBZJLKnxDCs75laZozoNdSipOSnd/HpVrsj8wPFYSEr+OH3
        i1S6+gA/orCcJGiNELK+/HZtlIG2RwCgD7lpkkqAjvFTBiNY9soYzNMp1jOJg0TvPbcHZDRO4U2HI
        pjJQuOwUMyVcHqm9eCsErDi+rxwC7wgMUX/QnXWrJ3vNVVvFbbpDZoNwQ/ZCFd2uFym4UGhLCKaiK
        8w3Pq/2Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qnIWY-00ESCO-37;
        Mon, 02 Oct 2023 12:59:47 +0000
Date:   Mon, 2 Oct 2023 13:59:46 +0100
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
Message-ID: <20231002125946.GW800259@ZenIV>
References: <20231002022815.GQ800259@ZenIV>
 <20231002022846.GA3389589@ZenIV>
 <20231002023344.GI3389589@ZenIV>
 <7f422261-92ef-32df-6640-dab9d68e1023@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f422261-92ef-32df-6640-dab9d68e1023@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 02, 2023 at 06:46:03AM -0500, Bob Peterson wrote:
> > diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> > index 0eac04507904..e2432c327599 100644
> > --- a/fs/gfs2/inode.c
> > +++ b/fs/gfs2/inode.c
> > @@ -1868,14 +1868,16 @@ int gfs2_permission(struct mnt_idmap *idmap, struct inode *inode,
> >   {
> >   	struct gfs2_inode *ip;
> >   	struct gfs2_holder i_gh;
> > +	struct gfs2_glock *gl;
> >   	int error;
> >   	gfs2_holder_mark_uninitialized(&i_gh);
> >   	ip = GFS2_I(inode);
> > -	if (gfs2_glock_is_locked_by_me(ip->i_gl) == NULL) {
> > +	gl = rcu_dereference(ip->i_gl);
> > +	if (!gl || gfs2_glock_is_locked_by_me(gl) == NULL) {
> 
> This looks wrong. It should be if (gl && ... otherwise the
> gfs2_glock_nq_init will dereference the null pointer.

We shouldn't observe NULL ->i_gl unless we are in RCU mode,
which means we'll bail out without reaching gfs2_glock_nq_init()...
