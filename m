Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7745388F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 00:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240518AbiE3Wdh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 May 2022 18:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237559AbiE3Wdg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 May 2022 18:33:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75164FD2A;
        Mon, 30 May 2022 15:33:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0B54A1F8AC;
        Mon, 30 May 2022 22:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653950014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LtUFZbsNyrL0zWig6EzpbLMXgFPtxPsoz+GCNlSTOSg=;
        b=G3LPSB0MZohvr0dclthqDwDoe4VO89ZFUxIPx9s5DLYS+A3U1KNPUg/QsE4U2zROCuQE6J
        NsFmaG4A27VWv1VIdlYuxCxoEgjoNpSA6d8mVEi0g4CsU51K22TPXpbpDZ+DC+VFPHXNBx
        UWE31GILABixTBie6+WkAbSd8sbpEwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653950014;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LtUFZbsNyrL0zWig6EzpbLMXgFPtxPsoz+GCNlSTOSg=;
        b=OGj7fXfnm5S56SM3kfx6nvLkw/qpsnpj++QTA4Qm9iOWfzLBxNxqssZ6OBOIs7o8HtIX6O
        iSdWL+k/q0G11/Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F48813AFD;
        Mon, 30 May 2022 22:33:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fzbQMzpGlWIdGwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 30 May 2022 22:33:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Miklos Szeredi" <miklos@szeredi.hu>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "ChenXiaoSong" <chenxiaosong2@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        liuyongqiang13@huawei.com, "zhangyi (F)" <yi.zhang@huawei.com>,
        zhangxiaoxu5@huawei.com, "Steve French" <smfrench@gmail.com>
Subject: Re: [PATCH -next,v2] fuse: return the more nuanced writeback error on close()
In-reply-to: <9915b7b556106d2a525941141755adcca9e50163.camel@kernel.org>
References: <20220523014838.1647498-1-chenxiaosong2@huawei.com>,
 <CAJfpegt-+6oSCxx1-LHet4qm4s7p0jSoP9Vg8PJka3=1dqBXng@mail.gmail.com>,
 <9915b7b556106d2a525941141755adcca9e50163.camel@kernel.org>
Date:   Tue, 31 May 2022 08:33:26 +1000
Message-id: <165395000670.20289.6180005723599338606@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 31 May 2022, Jeff Layton wrote:
> On Mon, 2022-05-30 at 14:13 +0200, Miklos Szeredi wrote:
> > On Mon, 23 May 2022 at 03:35, ChenXiaoSong <chenxiaosong2@huawei.com> wro=
te:
> > >=20
> > > As filemap_check_errors() only report -EIO or -ENOSPC, we return more n=
uanced
> > > writeback error -(file->f_mapping->wb_err & MAX_ERRNO).
> > >=20
> > >   filemap_write_and_wait
> > >     filemap_write_and_wait_range
> > >       filemap_check_errors
> > >         -ENOSPC or -EIO
> > >   filemap_check_wb_err
> > >     errseq_check
> > >       return -(file->f_mapping->wb_err & MAX_ERRNO)
> > >=20
> > > Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
> > > ---
> > >  fs/fuse/file.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > index f18d14d5fea1..9917bc2795e6 100644
> > > --- a/fs/fuse/file.c
> > > +++ b/fs/fuse/file.c
> > > @@ -488,10 +488,10 @@ static int fuse_flush(struct file *file, fl_owner=
_t id)
> > >         inode_unlock(inode);
> > >=20
> > >         err =3D filemap_check_errors(file->f_mapping);
> > > +       /* return more nuanced writeback errors */
> > >         if (err)
> > > -               return err;
> > > +               return filemap_check_wb_err(file->f_mapping, 0);
> >=20
> > I'm wondering if this should be file_check_and_advance_wb_err() instead.
> >=20
>=20
> I think that it probably shouldn't be, actually. Reason below...
>=20
> > Is there a difference between ->flush() and ->fsync()?
> >=20
> > Jeff, can you please help?
> >=20
> >=20
>=20
> The main difference is that ->flush is called from filp_close, so it's
> called when a file descriptor (or equivalent) is being torn down out,
> whereas ->fsync is (obviously) called from the fsync codepath.

->flush is for cache coherence. It is best-effort
->fsync is for data safety. Obviously errors are important.

>=20
> We _must_ report writeback errors on fsync, but reporting them on the
> close() syscall is less clear. The thing about close() is that it's
> going be successful no matter what is returned. The file descriptor will
> no longer work afterward regardless.
>=20
> fsync also must also initiate writeback of all the buffered data, but
> it's not required for filesystems to do that on close() (and in fact,
> there are good reasons not to if you can). A successful close() tells
> you nothing about whether your data made it to the backing store. It
> might just not have been synced out yet.
>=20
> Personally, I think it's probably best to _not_ return writeback errors
> on close at all. The only "legitimate" error on close is -EBADF.
> Arguably, we should make ->flush be void return. Note that most
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^

Excellent idea!

NeilBrown

> filp_close callers ignore the error anyway, so it's not much of a
> stretch.
>=20
> In any case, if you do decide to return errors in fuse_flush, then
> advancing the cursor would also have the effect of masking writeback
> errors on dup()'ed file descriptors, and I don't think you want to do
> that.
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
