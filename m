Return-Path: <linux-fsdevel+bounces-4819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CA7804506
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 03:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8B01F21190
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 02:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A456AB6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 02:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pks3Qzni"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5854C10F
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 16:54:27 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-58cecfb4412so3483120eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Dec 2023 16:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701737666; x=1702342466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hgxh5iAkQdyDmjH/EP5y66lB0goZgK4wS9PHcerNRI0=;
        b=Pks3QznimLGKgOlVmoOSK1Hg2E87f//xAmPKOlD3N8faGNH/ZgaZQML5/7/6KiEBrf
         FvQVIemBTDzkWLTCya9boBSPl9ESBlDq7kriwCp8tjPmhvN3MnOHdsfmFJrnoJnboXlm
         6Zwyo5nkezqMEMa50AymaVyv/aEsnuA5shTpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701737666; x=1702342466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgxh5iAkQdyDmjH/EP5y66lB0goZgK4wS9PHcerNRI0=;
        b=WTqfaja9EEMxlo3qcsdwP2BpslsXTboS+vZhHztwXuvWk2ErNtt62Mpp0Eaaox+Pnn
         c/wpmSSqI/MnKOY1MNiSxctOfGlXx1WMhEjznIXNjYj170c7Gpi3pykeN1E45RB5T+91
         E9YuPbzSf5/29S+A1RHZ3hOj0P8d/f3OKgbW6gUa5ySs9H3ivmWa6IesiC5UmSIKhg1v
         ZuML1epDKbdPXuG6NjM+EYEN2q2LCMxM438kVnRi/Kz4kCwS4zAksOJV7OFuaZueEJC3
         H6pqYV3bcryZKwK7CVZPBQyS6bQqdUDowAtMIH/Oqx/SPRphL3pHK7OLuOTekeONEcU7
         epkg==
X-Gm-Message-State: AOJu0YzsVVirK930gzPMqam30x6lX4uelLDLuLskzn0V/7euebovGgV0
	BZPjFAzkrDSdLOdixOKWUDFrFw==
X-Google-Smtp-Source: AGHT+IHk7lmDVGKtnQfm4mq3bULDVD35esNQMJLK9nUyooFioS0fzVXAMAhL7+5oYc0V/vLwpRuwzA==
X-Received: by 2002:a05:6358:7205:b0:16d:f46f:16a9 with SMTP id h5-20020a056358720500b0016df46f16a9mr8361301rwa.17.1701737666267;
        Mon, 04 Dec 2023 16:54:26 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b67-20020a633446000000b005c67ca3c2c2sm3188911pga.21.2023.12.04.16.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 16:54:25 -0800 (PST)
Date: Mon, 4 Dec 2023 16:54:25 -0800
From: Kees Cook <keescook@chromium.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Tony Luck <tony.luck@intel.com>, linux-hardening@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/5] pstore: inode: Use cleanup.h for struct
 pstore_private
Message-ID: <202312041649.C14F139F9@keescook>
References: <20231202211535.work.571-kees@kernel.org>
 <20231202212217.243710-5-keescook@chromium.org>
 <20231202222706.GT38156@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202222706.GT38156@ZenIV>

On Sat, Dec 02, 2023 at 10:27:06PM +0000, Al Viro wrote:
> On Sat, Dec 02, 2023 at 01:22:15PM -0800, Kees Cook wrote:
> 
> >  static void *pstore_ftrace_seq_start(struct seq_file *s, loff_t *pos)
> >  {
> > @@ -338,9 +339,8 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
> >  {
> >  	struct dentry		*dentry;
> >  	struct inode		*inode __free(iput) = NULL;
> > -	int			rc = 0;
> >  	char			name[PSTORE_NAMELEN];
> > -	struct pstore_private	*private, *pos;
> > +	struct pstore_private	*private __free(pstore_private) = NULL, *pos;
> >  	size_t			size = record->size + record->ecc_notice_size;
> >  
> >  	if (WARN_ON(!inode_is_locked(d_inode(root))))
> > @@ -356,7 +356,6 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
> >  			return -EEXIST;
> >  	}
> >  
> > -	rc = -ENOMEM;
> >  	inode = pstore_get_inode(root->d_sb);
> >  	if (!inode)
> >  		return -ENOMEM;
> > @@ -373,7 +372,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
> >  
> >  	dentry = d_alloc_name(root, name);
> >  	if (!dentry)
> > -		goto fail_private;
> > +		return -ENOMEM;
> >  
> >  	private->dentry = dentry;
> >  	private->record = record;
> > @@ -386,13 +385,9 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
> >  
> >  	d_add(dentry, no_free_ptr(inode));
> >  
> > -	list_add(&private->list, &records_list);
> > +	list_add(&(no_free_ptr(private))->list, &records_list);
> 
> That's really brittle.  It critically depends upon having no failure
> exits past the assignment to ->i_private; once you've done that,
> you have transferred the ownership of that thing to the inode
> (look at your ->evict_inode()).

I guess so, but it was already that way, and it isn't assignment to
i_private until everything else is "done", apart from adding to the
dentry and the pstore internal list.

> But you can't say
>         inode->i_private = no_free_ptr(private);
> since you are using private past that point.

True. How about this reordering:

        if (record->time.tv_sec)
                inode_set_mtime_to_ts(inode,
                                      inode_set_ctime_to_ts(inode, record->time));

        list_add(&private->list, &records_list);
        inode->i_private = no_free_ptr(private);

        d_add(dentry, no_free_ptr(inode));


But none of this gets into how you'd like to see the iput handled. If
you'd prefer, I can just define a pstore_iput handler and you don't have
to look at it at all. :)

-Kees

-- 
Kees Cook

