Return-Path: <linux-fsdevel+bounces-39543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F20A1578E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3032E188BE05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782391A7264;
	Fri, 17 Jan 2025 18:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WviqMqzP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2498B1F957;
	Fri, 17 Jan 2025 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139607; cv=none; b=fUtU/MnX9Qmx427FhSvvD+G98l6nWcnmnFllGWm7LgJ34h2RvePkCTOogR0NIXW5jUQb99J7YL3EAEaFCBAU1XgZ/ARdbssBuKwoNoi9+NyILwRdDl/1ThtfMfqOpB6wkU3j+buqEwCb71cFH3OF4Jj5Z4cQaxZGvZTYI4LDucQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139607; c=relaxed/simple;
	bh=bGVvfY7FXwct66Wh0g+NF690mRWTxOOnQnz98UQ/JL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H787lUlz9TPh0+SqnPg+fkPJIN7UYurE6FsHZjq5QMrAX5LsKgaBDFwPIoM699KC5qxT3ZSJ1Yq3Rti5YVDDqR3gQACjo+cYFrspGZ+wiFjjX94Uwk8jcVju29HmTXFqXJYYO4rO6GKtaFnPl663y6WYOs2n0cX3Njj1gzQqdcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WviqMqzP; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaeec07b705so460140766b.2;
        Fri, 17 Jan 2025 10:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737139602; x=1737744402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UoC6d4xDuMYdRcrm2a1q4JT+a5qARAHGK3mHA5hh4yg=;
        b=WviqMqzPXceIQQBb7DBxrKVAUMSwrI1iJKG+d/PwNjyE5Zp/jPhpFWOiIyRrinovqY
         5VqM8GUE+NwIejVE0MlweNUt9kMSdPUEug2+xiRGXfHTTxofk4KNtXWdVvNgPjPsBr+B
         hfYN0LFlvXIlAfWGuD/ESIOtwAsmU2Q5d9rwFwdq/DieKgahV81XgIaJel3qeYLUFbNd
         e0oddAn6Pn9VCmkTYCRNJC/cO/tQFqzj+dJqNdW9AsTZpvw/OFegO0GxVX2ObT4+bI/g
         5/STPMz9phVxKQR+3uFmTfFQB8hI8Kl4ODAtHy5xktj2GS2rU6IOavrMHX/Bk++qJTOe
         nUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737139602; x=1737744402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UoC6d4xDuMYdRcrm2a1q4JT+a5qARAHGK3mHA5hh4yg=;
        b=WpPodOnJfJwv1mZwAqctIkyfY9Hi52vvnIvH6JDWSzDzSYbYwFWWT9cdz86/Vy43g8
         /WdaRFXpbhqPsIIG6ysGqqZaH2xY+R9vEAbXU0c5hZsBBUqioYKbLue1hp4PjU0hZ38C
         BoqJyoohGPc0ypMtWhfzMIypzraX1lhMa3HCXVaIYl2nXulSyALHg7VLd63PVfiFT8VD
         Gh+297o+TXHGiMhuNJQrgKNhg5WGxBkEj1Ir9sTKV7LOhnBpm++gaas1bPQqVYtAtD/V
         dv6NqZpXs60BHEHKhSYbcBF8eK40WO7tjnsoobU9GBHouMcLhVgQsZw2z5eXsV5k8GvQ
         Fu6A==
X-Forwarded-Encrypted: i=1; AJvYcCVieONp0qnrQ5H485zC187ud2CHygIuRwpsslcoNNnMHACoTl980u6atvMLhfDTvxpxzdOt1V7itn5CMzFS9Q==@vger.kernel.org, AJvYcCWV/EI58dN3zNHFbJbtLX1RmI9eBaE9G2CQ1tI1jc4QTJRFjbGL1s06kWF6aTClXmgyHIfm+orbY11Taogr@vger.kernel.org, AJvYcCXQ+v+F8oIZldBClQVySuvsPhZd8sBvyn9asxu3GVEcwB5BlUA6ZQ2VdfRV48lCJHmhxtOIPjYH1Ui4@vger.kernel.org
X-Gm-Message-State: AOJu0YwHIBAhE7qmOQncFjMxUyEe/FsqccLRQItCDmtgLifTY/gHhkoE
	DX4NjUwYEXvWrJ+Qiw6CWLIs6pL4ybCWSSdLiCjEaCuCVvpmEV0E6AN8KNTerxswfRXZgoLSpL5
	PFhM58slm56Q8E7YoZB19IXlwIBA=
X-Gm-Gg: ASbGncszaQywOPVfjKgrCTMSZ6zbhVOtFi3CqvlSnRUDzSLWTA15wL6snqbjKPG5aFf
	FHAzJKU74hXglvPEltTxbJl2T5qMiPg26tu6F9A==
X-Google-Smtp-Source: AGHT+IGPq4y8F3kT7I3VPaEau5l/ts6QQEsHIkeSM33bDHX0EHh3nCmW1i2Qz7Xas4ZaNezD//QDuIWmA+5jVeZ88do=
X-Received: by 2002:a17:906:4783:b0:aa6:3f93:fb99 with SMTP id
 a640c23a62f3a-ab38b3841e5mr370215166b.36.1737139602015; Fri, 17 Jan 2025
 10:46:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <28f0aa2e-58d7-4b56-bc19-b1b3aa284d8f@oracle.com>
 <20250104-bonzen-brecheisen-8f7088db32b0@brauner> <cf0b8342-8a4b-4485-a5d1-0da20e6d14e7@oracle.com>
 <20250114211050.iwvxh7fon7as7sty@pali> <0659dfe1-e160-40fd-b95a-5d319ca3504f@oracle.com>
 <20250114215350.gkc2e2kcovj43hk7@pali> <CAN05THSXjmVtvYdFLB67kKOwGN5jsAiihtX57G=HT7fBb62yEw@mail.gmail.com>
 <20250114235547.ncqaqcslerandjwf@pali> <20250114235925.GC3561231@frogsfrogsfrogs>
 <CAOQ4uxjj3XUNh6p3LLp_4YCJQ+cQHu7dj8uM3gCiU61L3CQRpA@mail.gmail.com> <20250117173900.GN3557553@frogsfrogsfrogs>
In-Reply-To: <20250117173900.GN3557553@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 17 Jan 2025 19:46:30 +0100
X-Gm-Features: AbW1kvas-q2qO1TeZk503j1Y96v8GgIglZpZRhUOmjpTDqyRYRUgxCJ2Egu5hZ0
Message-ID: <CAOQ4uxhh1LDz5zXzqFENPhJ9k851AL3E7Xc2d7pSVVYX4Fu9Jw@mail.gmail.com>
Subject: Re: Immutable vs read-only for Windows compatibility
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	ronnie sahlberg <ronniesahlberg@gmail.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

> > Looking at the FILE_ATTRIBUTE_* flags defined in SMB protocol
> >  (fs/smb/common/smb2pdu.h) I wonder how many of them will be
> > needed for applications beyond the obvious ones that were listed.
>
> Well they only asked for seven of them. ;)
>
> I chatted with Ted about this yesterday, and ... some of the attributes
> (like read only) imply that you'd want the linux server to enforce no
> writing to the file; some like archive seem a little superfluous since
> on linux you can compare cmtime from the backup against what's in the
> file now; and still others (like hidden/system) might just be some dorky
> thing that could be hidden in some xattr because a unix filesystem won't
> care.
>
> And then there are other attrs like "integrity stream" where someone
> with more experience with windows would have to tell me if fsverity
> provides sufficient behaviors or not.
>
> But maybe we should start by plumbing one of those bits in?  I guess the
> gross part is that implies an ondisk inode format change or (gross)
> xattr lookups in the open path.
>

I may be wrong, but I think there is a confusion in this thread.
I don't think that Pali was looking for filesystems to implement
storing those attributes. I read his email as a request to standardize
a user API to get/set those attributes for the filesystems that
already support them and possibly for vfs to enforce some of them
(e.g. READONLY) in generic code.

Nevertheless, I understand the confusion because I know there
is also demand for storing those attributes by file servers in a
standard way and for vfs to respect those attributes on the host.

Full disclosure - I have an out of tree xfs patch that implements
ioctls XFS_IOC_[GS]ETDOSATTRAT and stashes these
attributes in the unused di_dmevmask space.

Compared to the smb server alternative of storing those attributes
as xattrs on the server, this saves a *lot* of IO in an SMB file browsing
workload, where most of the inodes have large (ACL) xattrs that do
not fit into the inode, because SMB protocol needs to return
those attributes in a response to READDIR(PLUSPLUS), so
it needs to read all the external xattr blocks.

So yeh, I would love to have proper support in xfs...

Thanks,
Amir.

