Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C336F09EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 18:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244205AbjD0Qeh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 12:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243284AbjD0Qeg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:34:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F88146BE;
        Thu, 27 Apr 2023 09:34:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A4D3821C0C;
        Thu, 27 Apr 2023 16:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682613272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wmth4alCSERvbUxN8itO1bBdqjrbePJcRRiASYpuefg=;
        b=N+H7rNV5TR1kkSt+Pt2fFhVCX5g3/KGe34ja7R5U5iZSXsi/t+V4vNzMunQJp9Jiy0KtKU
        h5RWrdUPLix8+f0jcFBkbGiO5FRDWBZSENTWfEegyGiUIqLDHFAf1ozSIwLnQc86CdWIgw
        +CtWEyqkxZTxNKHaL4R4I03cpr1VwV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682613272;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wmth4alCSERvbUxN8itO1bBdqjrbePJcRRiASYpuefg=;
        b=c97+0kpHj1vO46+6chAlHjo2vadkqmUhok9b1kF4ptixPiwvttSpSE+9rry89dlXtv2l91
        jZulZ1xAsP8EPyCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D6E613910;
        Thu, 27 Apr 2023 16:34:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sll1IhikSmQMXQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 27 Apr 2023 16:34:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E1A57A0729; Thu, 27 Apr 2023 18:34:31 +0200 (CEST)
Date:   Thu, 27 Apr 2023 18:34:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Chuck Lever <cel@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [RFC][PATCH 4/4] fanotify: support reporting non-decodeable file
 handles
Message-ID: <20230427163431.ndw3r5spjs2nbber@quack3>
References: <20230425130105.2606684-1-amir73il@gmail.com>
 <20230425130105.2606684-5-amir73il@gmail.com>
 <20230427114849.cv3kzxk7rvxpohjc@quack3>
 <CAOQ4uxhBaZ4_c5Ko6jZ6UzqtB-4spE_xiRC=TNMO8+bwnYMSnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhBaZ4_c5Ko6jZ6UzqtB-4spE_xiRC=TNMO8+bwnYMSnA@mail.gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 27-04-23 15:28:23, Amir Goldstein wrote:
> s_export_op
> 
> On Thu, Apr 27, 2023 at 2:48 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 25-04-23 16:01:05, Amir Goldstein wrote:
> > > fanotify users do not always need to decode the file handles reported
> > > with FAN_REPORT_FID.
> > >
> > > Relax the restriction that filesystem needs to support NFS export and
> > > allow reporting file handles from filesystems that only support ecoding
> > > unique file handles.
> > >
> > > For such filesystems, users will have to use the AT_HANDLE_FID of
> > > name_to_handle_at(2) if they want to compare the object in path to the
> > > object fid reported in an event.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ...
> > > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > > index 8f430bfad487..a5af84cbb30d 100644
> > > --- a/fs/notify/fanotify/fanotify_user.c
> > > +++ b/fs/notify/fanotify/fanotify_user.c
> > > @@ -1586,11 +1586,9 @@ static int fanotify_test_fid(struct dentry *dentry)
> > >        * We need to make sure that the file system supports at least
> > >        * encoding a file handle so user can use name_to_handle_at() to
> > >        * compare fid returned with event to the file handle of watched
> > > -      * objects. However, name_to_handle_at() requires that the
> > > -      * filesystem also supports decoding file handles.
> > > +      * objects, but it does not need to support decoding file handles.
> > >        */
> > > -     if (!dentry->d_sb->s_export_op ||
> > > -         !dentry->d_sb->s_export_op->fh_to_dentry)
> > > +     if (!dentry->d_sb->s_export_op)
> > >               return -EOPNOTSUPP;
> >
> > So AFAICS the only thing you require is that s_export_op is set to
> > *something* as exportfs_encode_inode_fh() can deal with NULL ->encode_fh
> > just fine without any filesystem cooperation. What is the reasoning behind
> > the dentry->d_sb->s_export_op check? Is there an implicit expectation that
> > if s_export_op is set to something, the filesystem has sensible
> > i_generation? Or is it just a caution that you don't want the functionality
> > to be enabled for unexpected filesystems?
> 
> A little bit of both.
> Essentially, I do not want to use the generic encoding unless the filesystem
> opted-in to say "This is how objects should be identified".
> 
> The current fs that have s_export_op && !s_export_op->encode_fh
> practically make that statement because they support NFS export
> (i.e. they implement fh_to_dentry()).

Makes sense.

> I don't like the implicit fallback to generic encoding, especially when
> introducing this new functionality of encode_fid().
> 
> Before posting this patch set I had two earlier revisions.
> One that changed the encode_fh() to mandatory and converted
> all the INO32_GEN fs to explicitly set
> s_export_op.encode_fh = generic_encode_ino32_fh,
> And one that marked all the INO32_GEN fs with
> s_export_op.flags = EXPORT_OP_ENCODE_INO32_GEN
> in both cases there was no blind fallback to INO32_GEN.
> 
> But in the end, these added noise without actual value so
> I dropped them, because the d_sb->s_export_op check is anyway
> a pretty strong indication for opt-in to export fids.
> 
> CC exportfs maintainers in case they have an opinion one
> way or the other.

Yeah, I agree with your judgement. I just wanted to make sure I understand
everything properly.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
