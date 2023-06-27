Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DCE73FDA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 16:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjF0OUR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 10:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjF0OUQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:20:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBAE10E7
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 07:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687875566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kg0oEjdzgulDO0g4qNXV/6g4eD+pg1i9NjIeehDQq64=;
        b=csazr+PIov97a1idG26WmKDtNt50pZQwHKUHKsFETQhBTKhTgUzUghd9czGcQl7FyYpOna
        ZvFKov+/dhZj3uM8auJGOYYv4Th+NZmL2uEpmtENKYR/afrznUvboR3+XfvNDXzYhS9wMF
        YOapIRhOFqv0e7oYf1we7ZSxkXprRZ0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-2PMqLQo4NoGiutoKW_RsxQ-1; Tue, 27 Jun 2023 10:19:21 -0400
X-MC-Unique: 2PMqLQo4NoGiutoKW_RsxQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-40261479174so9348561cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 07:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687875554; x=1690467554;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kg0oEjdzgulDO0g4qNXV/6g4eD+pg1i9NjIeehDQq64=;
        b=Mtj54wrXo5W+vC1IHQf0SD8fWk9iypRxaOHokz4Wnk3q0RWs6KuJayKSLDJHVxyxMp
         RgqHHz7ZoxfGFClcbrE/DsWmyJP4GSdcZKn3NtDrD1nVGF0cumR0JFwMpWzpTkJAWAGT
         GpLn1QXM9iWYd0mPMJlbWhV8WznzB/7eng92wnVmc5o8SOT+L3CShtQMxpfbQCk8hzkZ
         /IzzPdH/bFpVl1B/UyoUvY6+w7C5AYcQnx8CsrxuTEN61CejYMNQD2Gv5N2Yn+NzJXvf
         UQ33B6tlFM/7MWDMGbKBbXBOJQpidJ68oV5SGKL+wDOp+jyS0BCHoeLfetXnZK4wtTUX
         p22Q==
X-Gm-Message-State: AC+VfDxJO5sEz3Ak0gDFjspZgh0SUTjy0lnQzNfzTS4ciLG2FvEI93lF
        Ru79eXCV/iZjxsGG1vC3cXA8wpmr0fsIN1j4U2gjZ5RmYsnrlgrVKCyk/CO3kYCvrnva1AzGusb
        5ZxPNhzMMJUaRSkagCgzRA85oTA==
X-Received: by 2002:ac8:5bc3:0:b0:400:e685:d18e with SMTP id b3-20020ac85bc3000000b00400e685d18emr5925987qtb.18.1687875553779;
        Tue, 27 Jun 2023 07:19:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7lpD5xB80vFy0rAeUma2fEBWQkMNSdbbiNbmQVtpZ2sDyNJSkly2azhNWp7OqYIrjhGfeUQA==
X-Received: by 2002:ac8:5bc3:0:b0:400:e685:d18e with SMTP id b3-20020ac85bc3000000b00400e685d18emr5925964qtb.18.1687875553459;
        Tue, 27 Jun 2023 07:19:13 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id fw15-20020a05622a4a8f00b00400a5ca26fesm2962405qtb.2.2023.06.27.07.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:19:13 -0700 (PDT)
Message-ID: <90095816f5a57869af322b2be630bb21235e21bb.camel@redhat.com>
Subject: Re: [PATCH v4 1/3] libfs: Add directory operations for stable
 offsets
From:   Jeff Layton <jlayton@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chuck Lever <cel@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Date:   Tue, 27 Jun 2023 10:19:12 -0400
In-Reply-To: <61C84AD6-EB8E-49D5-BDB1-F87D3D5558B7@oracle.com>
References: <168780354647.2142.537463116658872680.stgit@manet.1015granger.net>
         <168780368739.2142.1909222585425739373.stgit@manet.1015granger.net>
         <ZJqFP8W1JmWZ0FHy@infradead.org>
         <20230627-drastisch-wiegt-8d2aba4e5a0d@brauner>
         <61C84AD6-EB8E-49D5-BDB1-F87D3D5558B7@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-06-27 at 14:04 +0000, Chuck Lever III wrote:
>=20
> > On Jun 27, 2023, at 4:52 AM, Christian Brauner <brauner@kernel.org> wro=
te:
> >=20
> > On Mon, Jun 26, 2023 at 11:44:15PM -0700, Christoph Hellwig wrote:
> > > > + * @dir: parent directory to be initialized
> > > > + *
> > > > + */
> > > > +void stable_offset_init(struct inode *dir)
> > > > +{
> > > > + xa_init_flags(&dir->i_doff_map, XA_FLAGS_ALLOC1);
> > > > + dir->i_next_offset =3D 0;
> > > > +}
> > > > +EXPORT_SYMBOL(stable_offset_init);
> > >=20
> > > If this is exported I'd much prefer a EXPORT_SYMBOL_GPL.  But the onl=
y
> > > user so far is shmfs, which can't be modular anyway, so I think we ca=
n
> > > drop the exports.
> > >=20
> > > > --- a/include/linux/dcache.h
> > > > +++ b/include/linux/dcache.h
> > > > @@ -96,6 +96,7 @@ struct dentry {
> > > > struct super_block *d_sb; /* The root of the dentry tree */
> > > > unsigned long d_time; /* used by d_revalidate */
> > > > void *d_fsdata; /* fs-specific data */
> > > > + u32 d_offset; /* directory offset in parent */
> > > >=20
> > > > union {
> > > > struct list_head d_lru; /* LRU list */
> > > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > > index 133f0640fb24..3fc2c04ed8ff 100644
> > > > --- a/include/linux/fs.h
> > > > +++ b/include/linux/fs.h
> > > > @@ -719,6 +719,10 @@ struct inode {
> > > > #endif
> > > >=20
> > > > void *i_private; /* fs or device private pointer */
> > > > +
> > > > + /* simplefs stable directory offset tracking */
> > > > + struct xarray i_doff_map;
> > > > + u32 i_next_offset;
> > >=20
> > > We can't just increase the size of the dentry and inode for everyone
> > > for something that doesn't make any sense for normal file systems.
> > > This needs to move out into structures allocated by the file system
> > > and embedded into or used as the private dentry/inode data.
> >=20
> > I agree. I prefer if this could be done on a per filesystem basis as
> > well. Especially since, this is currently only useful for a single
> > filesystem.
> >=20
> > We've tried to be very conservative in increasing inode and dentry size
> > and we should continue with that.
>=20
> I had thought we were going to adopt the stable offset mechanism
> in more than just shmemfs. That's why we're putting it in libfs.c
> after all. So this was not going to be "just for shmemfs" in the
> long run.
>=20
> That said, I can move the stable-offset-related inode fields back
> into the shmemfs private inode struct, as it was in v2 of this
> series.
>=20

I too think that would be best. The libfs helpers will probably need to
take an extra pointer to the relevant fields in the inode and dentry,
but that's not too hard to do.

> For d_offset, I was (ab)using the d_fsdata field by casting the
> offset value as a pointer. That's kind of ugly. Any suggestions?
>=20
>=20

Absolutely nothing wrong with interpreting that as an integer. It's a
void * which means that anything that wants to dereference it better
know what it is ahead of time anyway.
--=20
Jeff Layton <jlayton@redhat.com>

