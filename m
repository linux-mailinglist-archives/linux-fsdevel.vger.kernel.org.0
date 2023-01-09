Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3C366299F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 16:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbjAIPQc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 10:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbjAIPQJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:16:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CEF39F99
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 07:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673277258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mQ8tZs5IQ8tViKAxZPeB3mhvDmuPPKwdwZwivLRuLtc=;
        b=YnwGarwHd16TYTOiXr/8a1+9iEj/P1wtAhnx1H0/mOyqyT7521knY0h/VkYMpWhcF/asFQ
        bKuVj7AFygqiKVSY6/od1oEKrC9e4p3J88scC1kuhqOQtZ9wKERt6Xe1/pt/Dv8B9Cw28N
        g7UoZrcMunUQ+PSJHZwNkR5IH7a6ITE=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-170-hRm-0lENPzWZ-qjnEqOvqg-1; Mon, 09 Jan 2023 10:14:14 -0500
X-MC-Unique: hRm-0lENPzWZ-qjnEqOvqg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-46658ec0cfcso94766467b3.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Jan 2023 07:14:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mQ8tZs5IQ8tViKAxZPeB3mhvDmuPPKwdwZwivLRuLtc=;
        b=vPgClZ7ngGgseywPJfkvh16QJzr1hMYq0sggkQXElb/bQSp7VI+TzkUjopVHX9fj2S
         fHdm65uPIVuGLKTE8g1c0DGJP6lKQE3oh0h/DLTMPx8FrI31dZtZSe9/3jTylFAA9h1t
         6YSTgbo39IjPFHej3n1xkCu+/EN2ElDU2ZbgOpCAixhUjrCJqBPWL3pExDVIDJwqgiK+
         uzW1yZ8YGPJRgegR9tyndixSy8hznZ8QV+ysudIk6soBhAPNyMGR8kzWA/AHQL6AZsNV
         HWg0BWQfTymBc2QMVTgDWoSacS7bZfg8jg/BDpOFQVyLMUkNzWI8oZ85n2jvSoi+D9d8
         16OQ==
X-Gm-Message-State: AFqh2kplPd98ZhujTGqW5G3IEb0gxJF69inftmyqVulf177FcSL7lA1S
        C5KOOOWxWaz3Nu33K2Me2XcROfeQOUwnx0O0KJfjRtnVcTAOGSq07ni1np6VyuJplalYSvowgTu
        a6//EQOrgFsmwYB2WxM3apBt/zg==
X-Received: by 2002:a05:690c:c05:b0:475:b3a:a4c5 with SMTP id cl5-20020a05690c0c0500b004750b3aa4c5mr2912336ywb.45.1673277253899;
        Mon, 09 Jan 2023 07:14:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt9FjiiWVTqShq0QW4xLjo26npQJ+ctx4FFo80NRDY7kXjEQdY4rWHuTqgPXE3e+uOyy0lqsQ==
X-Received: by 2002:a05:690c:c05:b0:475:b3a:a4c5 with SMTP id cl5-20020a05690c0c0500b004750b3aa4c5mr2912319ywb.45.1673277253670;
        Mon, 09 Jan 2023 07:14:13 -0800 (PST)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id t11-20020a05620a034b00b006fa31bf2f3dsm5446848qkm.47.2023.01.09.07.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 07:14:13 -0800 (PST)
Message-ID: <74c40f813d4dc2bf90fbf80a80a5f0ba15365a90.camel@redhat.com>
Subject: Re: [PATCH 08/11] cifs: Remove call to filemap_check_wb_err()
From:   Jeff Layton <jlayton@redhat.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Date:   Mon, 09 Jan 2023 10:14:12 -0500
In-Reply-To: <7d1499fadf42052711e39f0d8c7656f4d3a4bc9d.camel@redhat.com>
References: <20230109051823.480289-1-willy@infradead.org>
         <20230109051823.480289-9-willy@infradead.org>
         <7d1499fadf42052711e39f0d8c7656f4d3a4bc9d.camel@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-01-09 at 09:42 -0500, Jeff Layton wrote:
> On Mon, 2023-01-09 at 05:18 +0000, Matthew Wilcox (Oracle) wrote:
> > filemap_write_and_wait() now calls filemap_check_wb_err(), so we cannot
> > glean any additional information by calling it ourselves.  It may also
> > be misleading as it will pick up on any errors since the beginning of
> > time which may well be since before this program opened the file.
> >=20
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  fs/cifs/file.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> > index 22dfc1f8b4f1..7e7ee26cf77d 100644
> > --- a/fs/cifs/file.c
> > +++ b/fs/cifs/file.c
> > @@ -3042,14 +3042,12 @@ int cifs_flush(struct file *file, fl_owner_t id=
)
> >  	int rc =3D 0;
> > =20
> >  	if (file->f_mode & FMODE_WRITE)
> > -		rc =3D filemap_write_and_wait(inode->i_mapping);
> > +		rc =3D filemap_write_and_wait(file->f_mapping);
>=20
> If we're calling ->flush, then the file is being closed. Should this
> just be?
> 		rc =3D file_write_and_wait(file);
>=20
> It's not like we need to worry about corrupting ->f_wb_err at that
> point.
>=20

OTOH, I suppose it is possible for there to be racing fsync syscall with
a filp_close, and in that case advancing the f_wb_err might be a bad
idea, particularly since a lot of places ignore the return from
filp_close. It's probably best to _not_ advance the f_wb_err on ->flush
calls.

That said...wonder if we ought to consider making filp_close and ->flush
void return functions. There's no POSIX requirement to flush all of the
data on close(), so an application really shouldn't rely on seeing
writeback errors returned there since it's not reliable.

If you care about writeback errors, you have to call fsync -- full stop.

> > =20
> >  	cifs_dbg(FYI, "Flush inode %p file %p rc %d\n", inode, file rc);
> > -	if (rc) {
> > -		/* get more nuanced writeback errors */
> > -		rc =3D filemap_check_wb_err(file->f_mapping, 0);
> > +	if (rc)
> >  		trace_cifs_flush_err(inode->i_ino, rc);
> > -	}
> > +
> >  	return rc;
> >  }
> > =20
>=20

--=20
Jeff Layton <jlayton@redhat.com>

