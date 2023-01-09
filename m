Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DBC6628BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 15:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjAIOnz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 09:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjAIOnb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:43:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D227D1A835
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 06:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673275362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GqO8WP47IGCJ8c3pWUysSVCAJdwUf/hbc3Q+tFowqGk=;
        b=V4kWEXdxDhStOGUnNzZCZSCpzVrKXpSAIZEEu79ApKdJ71CUX8i66FT8szZD4g3fB8IaeT
        1RUu9x6sWnFWmI1UBh5a+kus9fJnU7BIsLxQ0+grymIcc6tSrY0TZw5jJtRq8WGwiwwSz9
        C5jPK9E+uvN5QHIrzBS4ZijH1h62haA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-412-L1nl5NzJPYanu62nxRrXpQ-1; Mon, 09 Jan 2023 09:42:38 -0500
X-MC-Unique: L1nl5NzJPYanu62nxRrXpQ-1
Received: by mail-qk1-f198.google.com with SMTP id bj37-20020a05620a192500b00704dc44b050so6615882qkb.14
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Jan 2023 06:42:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GqO8WP47IGCJ8c3pWUysSVCAJdwUf/hbc3Q+tFowqGk=;
        b=pijNu2ovi0LRu1ANtUUeYnSNLMn/HJ2OobKgRIv8DFayaJP8IvvZdVEiIYr3gbReq4
         gpweuC2JtXQX0TWmfRxC4wvbLEggbXQl3BXzldBj+C9ThdgLqmOOmd5XQkTLAk9m6Xii
         BwMq5I9upnn6WLJug5jRCBwK1YS2cm4SHxplwgKjjiY1AmRBSTL7xIRIA97fOWHGMFlz
         9KIPrqVOyCjqWnmsO3lIi/Dm57DHfQGgYhCioQO4iJMxi01gL4IEymeG8LZl1Hn9ESgK
         lWF5ghumEMkxydTraGvvHaZdQ+qUhYRtD32XPyjpmYQxgNVccMhYuZQBioSv+KcC4ngd
         WT+w==
X-Gm-Message-State: AFqh2kpih3ymXzVXippFxX6bA1ZR1POHV6hZza07O8V8z9AdQNjATxtF
        NyY21VLa0ZCytu99MyJoyHxFrR51Iv/XmHX+XZMw8W30Nic6VY2fv0mv6GxWgHLjEVcodHrXAD3
        wXdWXCGsJIF/elOH+mNhPr3ifaA==
X-Received: by 2002:a05:622a:580c:b0:3a8:2b87:9fd8 with SMTP id fg12-20020a05622a580c00b003a82b879fd8mr98712601qtb.48.1673275357939;
        Mon, 09 Jan 2023 06:42:37 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvDhPBJIZ+E0FoPfewXrYweMlU/l4+RY/bsNUbu8cqmPky9X6H++s5bY2nvviwUmzzUYAd2Tw==
X-Received: by 2002:a05:622a:580c:b0:3a8:2b87:9fd8 with SMTP id fg12-20020a05622a580c00b003a82b879fd8mr98712581qtb.48.1673275357707;
        Mon, 09 Jan 2023 06:42:37 -0800 (PST)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id q8-20020ac87348000000b003a8163c1c96sm4611187qtp.14.2023.01.09.06.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 06:42:37 -0800 (PST)
Message-ID: <7d1499fadf42052711e39f0d8c7656f4d3a4bc9d.camel@redhat.com>
Subject: Re: [PATCH 08/11] cifs: Remove call to filemap_check_wb_err()
From:   Jeff Layton <jlayton@redhat.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Date:   Mon, 09 Jan 2023 09:42:36 -0500
In-Reply-To: <20230109051823.480289-9-willy@infradead.org>
References: <20230109051823.480289-1-willy@infradead.org>
         <20230109051823.480289-9-willy@infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-01-09 at 05:18 +0000, Matthew Wilcox (Oracle) wrote:
> filemap_write_and_wait() now calls filemap_check_wb_err(), so we cannot
> glean any additional information by calling it ourselves.  It may also
> be misleading as it will pick up on any errors since the beginning of
> time which may well be since before this program opened the file.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/cifs/file.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 22dfc1f8b4f1..7e7ee26cf77d 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -3042,14 +3042,12 @@ int cifs_flush(struct file *file, fl_owner_t id)
>  	int rc =3D 0;
> =20
>  	if (file->f_mode & FMODE_WRITE)
> -		rc =3D filemap_write_and_wait(inode->i_mapping);
> +		rc =3D filemap_write_and_wait(file->f_mapping);

If we're calling ->flush, then the file is being closed. Should this
just be?
		rc =3D file_write_and_wait(file);

It's not like we need to worry about corrupting ->f_wb_err at that
point.

> =20
>  	cifs_dbg(FYI, "Flush inode %p file %p rc %d\n", inode, file rc);
> -	if (rc) {
> -		/* get more nuanced writeback errors */
> -		rc =3D filemap_check_wb_err(file->f_mapping, 0);
> +	if (rc)
>  		trace_cifs_flush_err(inode->i_ino, rc);
> -	}
> +
>  	return rc;
>  }
> =20

--=20
Jeff Layton <jlayton@redhat.com>

