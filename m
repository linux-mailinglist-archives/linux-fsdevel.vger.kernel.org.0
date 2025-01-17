Return-Path: <linux-fsdevel+bounces-39509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA65A15602
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECBEE188DAF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 17:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA2F1A2541;
	Fri, 17 Jan 2025 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaVCxijq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF831A0BFD;
	Fri, 17 Jan 2025 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136332; cv=none; b=R6zlhnNkc/j373MD+g9yXWBn1nxdyPd3HdogZugYjOyde7iFb9tngC3QW+8EHTQOkkcDBwMW1ZoU3NPB+3RxWLMzcnjAwOuMQpZqZ83Dx7vLoMl8X25DCbOL4OCHODqRpDgPdyGCugQaijLKzBEzVBfYI30jfwtyQiTMz8P3MFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136332; c=relaxed/simple;
	bh=b+/w/8D5zYFnuXvR9Gh2IkdY8i2+fFHwYXb30EwPG5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIgRckFdKPJVSyZYC1bFvY0gwDEH6vHk8b+28W797h9Ro4TWvgez1pdNqz2ZZfJWuNVQ9bTOXOUcX/Fes6FqDTam/dcVuElie5nWkdxVL1rSivdHTUtApv1mEd2lWSsZHeNjMkFQqsOKYbuz1WcwfLhnDQJQ+raRwSvMMnfEteI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaVCxijq; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54026562221so2360883e87.1;
        Fri, 17 Jan 2025 09:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737136326; x=1737741126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AN+/Iwzjynoy/C0FFbjss2vNXyVcfxhDA9DrSZfw00U=;
        b=CaVCxijqQKPccrKCJNDZD+2eURYj2OzJ8kgyt3tZkAraGCYhRWSCh4iKnwPDc9EmOf
         /v+ANxQPgvrvUR2lChzNRAMGr43+Hz8eVkeCLC+KhdIIFnOrBWol/GAvhxIa91ZUOhlE
         K0IfqvH0GskIcod3HMxKI1Bkt6S/5k3eq3RVJUW9UdPn83d9ZTGUVGmRlm/8vo7BTFWF
         zOjbgyCvKp8ZhFrkdWXTeOBaaUVSu9PiOOmS33eZiAD5mk5C2islBhHuXqNwE19cbzAR
         bkzJk1Drmg3VEo94mc/TFOaTFkbSY+sX5j/13fS1srlb6EkvbZ1H6bF+ih1Kbq6V4HpB
         /KqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737136326; x=1737741126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AN+/Iwzjynoy/C0FFbjss2vNXyVcfxhDA9DrSZfw00U=;
        b=ISH13UmOb59alrKgPsOtm4nWzOmWGPu0TcVbZRPCF2s8+asiM8zGkEtZY5MYLLO4Rj
         QDCHN8SYIbN0Spq+w90iNbTQeHcFNUtbg3Bl89zfuDJ0AvWGbduSdA3559nQuxreG+uj
         jVrg+lxqyYgKvJl4KNJHkIT6iH7NpV9vLdUyBs4NjhNLfw5xSr+IrAtPwms6nbdERNor
         JoEfj3Sd+mD/6GJLj+wSQ61NJWkSEiVTMPslruJThpblFT0Dw0EUEG3FYp8UM1KcsCY8
         F7zYs/+AEhZVJ5J9LXpREjVuXbN33B/f5dNlK5gOdyk0UxBxb7GWMpn4IuCEmyfcM7HK
         R9iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHm/gaLKrMMvqmlkNWj1HZxxx3cCVe8DhZCZIKGOETN6x/M2eIHU+LURxkyizU7nLSJ6BBwRrDtrUk86e2@vger.kernel.org, AJvYcCVnqVgUCzpP9cKFldnM8/AQfmKFo7kb840jDAMWd2x9iDuwaL7FvWSbJKWj5Nk4cogfxLroLxRZp5pl@vger.kernel.org, AJvYcCWqLQq9JoW7LhGRmB7Q+9EJ2DzQIYGbomFGkb25+rHcba/k86rS576T7Y5c3ar69vuvBNXz8RQ8G7cWo0PnRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcNCue4h4a3LelmA8ZRumET4H3spHvEUFT4Fl6PC3iPu0rH+5y
	L7ZtUC7uW22le6GriFGcMd6uxxWIpqhh8pGjROE4itE8A9ne5ERRXeWw3wEU2XqVFdvVzxRUcOp
	w0IhtGZ1MJiiBBvZoncAgtNnku8k=
X-Gm-Gg: ASbGncsVa5S6D7p+8kUtYMNGHXCxXIX5zdAvmclYumYcu98JCK+XMkAFBWOsI1MXdWp
	inWxBgkHxWwFq7//g6SzGntwNSk+jh7PUJoA=
X-Google-Smtp-Source: AGHT+IF/VzxDL0/O/VKT0R5WHtJjowfQ9Wya68Bi5r0wf4PknbofIPcPHvjquA48EdvdnP9vqDkYq3RaoCtfVjWoXEU=
X-Received: by 2002:ac2:4c24:0:b0:542:213f:78fa with SMTP id
 2adb3069b0e04-5439c21f24bmr1100681e87.7.1737136325519; Fri, 17 Jan 2025
 09:52:05 -0800 (PST)
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
From: Steve French <smfrench@gmail.com>
Date: Fri, 17 Jan 2025 11:51:54 -0600
X-Gm-Features: AbW1kvbfxu0KbT7GdOkhYWuyydjPLQ8yWKgZaPA41bk_36rYDlujDEKbvx8sYlo
Message-ID: <CAH2r5mvCJ=fPt5BgwFubJ+HWo+a0EHOTNoXxTt0NOhMC=V+GcQ@mail.gmail.com>
Subject: Re: Immutable vs read-only for Windows compatibility
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	ronnie sahlberg <ronniesahlberg@gmail.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 11:39=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Fri, Jan 17, 2025 at 05:53:34PM +0100, Amir Goldstein wrote:
> > On Wed, Jan 15, 2025 at 12:59=E2=80=AFAM Darrick J. Wong <djwong@kernel=
.org> wrote:
<...>
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

We have talked about some of these missing flags in the past, but the
obvious ones that would be helpful i (e.g. is used in other operating
systems when view directories in the equivalent of the "Files" GUI is
checking FILE_ATTRIBUTE_OFFLINE to determine whether to query icons,
and additional metadata for files).  In the past Unix used to have
various ways to determine this, but it is fairly common for files to
be tiered (where the data is in very slow storage offline - so should
only be opened and read by apps that really need to - not things like
GUIs browsing lists of files) so that attribute could be helpful.

The other two obvious ones (missing in Linux but that some other OS
have filesystems which support) discussed before were
FILE_ATTRIBUTE_INTEGRITY_STREAM which could be set for files that need
stronger data integrity guarantees (if a filesystem allows files to be
marked for stronger data integrity guarantees) , and
FILE_ATTRIBUTE_NO_SCRUB_DATA that indicates integrity checks can be
skipped for this particular file.
--=20
Thanks,

Steve

