Return-Path: <linux-fsdevel+bounces-67276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC24C3A34E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 11:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D459E50084D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 10:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920A3308F32;
	Thu,  6 Nov 2025 10:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OO2+nFoI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD30268688
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 10:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423997; cv=none; b=lLomPM/KFo1v4CN+cJtqXouM9SKdDjV/iInZfdpDeowRH7k3BsyJBDdMLv4VgVDeZPhD0tmUuBhRpdXw0XFORwAMwGHN9FTZKTYbO0IXBD0sjlvGByeW9rLxi3FSobqlKEgyLSiHFGyINNWbkeGxLozuL5bsecZ5GSOGerdKGBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423997; c=relaxed/simple;
	bh=LG1/dDRiDspuQlTpXOTjP9HBUKoLk+AXiTki+BDhG1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjzTwmZ2XfQpVHYCGN4RzlqK4yDWdBmlgsoMUDWTXBk1Pa0JVgn7+pFPZosXEeTLOyTwJWVr0Nd9rANQw/b9K5KG0lstWumu9e9OYXUx/DHrlBCLyPLJ2D2gerjmchoxVGbvRTKGOlL5Q9mBNZtVpSpuOtvILl0IIglfMHqjqlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OO2+nFoI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640b9c7eab9so1194931a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 02:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762423993; x=1763028793; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xHkGfgLJYPiemUMWkmzkvZBiGGmWmEwIYfUAgqXsnVw=;
        b=OO2+nFoIxjRUkmMyjyXqkn3nInW8iGWI0v5fm3T9KmqNVrppDcjeGC9SIonQnsqfL1
         4a4tkNFmXq0wZKLOL5rK/6R4/TQoh+KZwb6sOpkBvBh5y2qGYdtcTzorsaWGmKgmD/KX
         hpswuEA8xUql4FYnUGITYu0JZFcLJ2LAQ6Rne++4VS+7Zru0S7yqo0DYNNmPKME+89H3
         yRE0bj48zeAIfRtG8ZLRJlrnRk41ZQa0yKZJ+kUPjpHX9Dgff5g/ZKxE3gDYPDZsqsnG
         qjoG+nk9CJVRitWZn60f9PWDefZtyGoew9sVviCSKjTOmzA4hNwHvKLJwf1sKA8WfRW/
         7o/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762423993; x=1763028793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xHkGfgLJYPiemUMWkmzkvZBiGGmWmEwIYfUAgqXsnVw=;
        b=GknEU95xXcf+H94GkLCHReS2uA9uImWPzOAGsPVTzFjAe2JK4frhT4kYdAbtR9s29c
         O95bWXxnQv+O1I9DboUoJDHznQKa7dGaJ4nk5QBVzgkF3KhzipQ6vHGdZ+l5jzDuZOD6
         fzCas8wpIzcydX8wSjX+krX6GQF5nfmoXDQFLKgp8g4h30g1ywFlN4NTRFakuu+WFsPq
         UEukvFEiW8Nqzy/h/i9SsI9h3l98kk5YkVFrdhNqGuXu9Z+atVWVS4uyalYu4E+Xrmts
         +dsvTls01llZn9uJnhmXmDS8zOZXw/QHERIGPv8blkuHMOmZFP7YAhHUwUqBxU7HNzbr
         copA==
X-Forwarded-Encrypted: i=1; AJvYcCWQX1TqMlLifdyqqqloDsnrBCGAmRBbBOa9fAXHdWLw58gn9okmuMO+I6UvLcml3+ESXs30p1bDQgvl7DSr@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi4ANm1y7+aG01pJgsoSHhRmbwzM7byAi1tOxcLkzkpwFzHQOn
	oWzLs3VatAPJLDdGqHPZ8feQTjhBQMWRT1xeYkYykYSSF3B9PAhspBjiqAG9LMXA6DPbnVL0gfv
	PtjZbCnuJhNPQ5myhD9qmqEmw+SRcTb4=
X-Gm-Gg: ASbGncvdYNqsaqF4Osys02Du15Y19LR54sAcGRr38slergvF3RY7Cj1jjpXjOBOV0ZB
	C14Z66ogMzrjB59JDUH5+u12Shmiy+F1c7+7bvjYX1ou5AGzTXDPxmfsHRq6ps6g0DMqpMZm/od
	4mUGNplp4sl40cAqcfHeJnfJaXRGCLBeUfr0DLC5MPOOJGKssZi68YL8n8z/vABoOA7A0+kt+jE
	e6ZlMxUNTrw/MXY1LHhNBgheFF/LbDcaEfAZJD2IDMq3A94af2kUeWv7E8v1gl8N5qs1XePezAY
	m8TaDl/WR6+zv5pQ4zfcFPkeacM5ZQ==
X-Google-Smtp-Source: AGHT+IGxG6Eng0XCoyEc7r+NIAnWyMG+ACFLFRqfHYFdumQsKIbRDB3rmHw6y5qT4UqztWnkbaLenTCaIZsfhWzN49I=
X-Received: by 2002:a05:6402:270b:b0:641:27d8:ec3f with SMTP id
 4fb4d7f45d1cf-64127d8edecmr816761a12.29.1762423993365; Thu, 06 Nov 2025
 02:13:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2e57be4f-e61b-4a37-832d-14bdea315126@bsbernd.com>
 <20250912145857.GQ8117@frogsfrogsfrogs> <CAOQ4uxhm3=P-kJn3Liu67bhhMODZOM7AUSLFJRiy_neuz6g80g@mail.gmail.com>
 <2e1db15f-b2b1-487f-9f42-44dc7480b2e2@bsbernd.com> <CAOQ4uxg8sFdFRxKUcAFoCPMXaNY18m4e1PfBXo+GdGxGcKDaFg@mail.gmail.com>
 <20250916025341.GO1587915@frogsfrogsfrogs> <CAOQ4uxhLM11Zq9P=E1VyN7puvBs80v0HrPU6HqY0LLM6HVc_ZQ@mail.gmail.com>
 <87ldkm6n5o.fsf@wotan.olymp> <CAOQ4uxg7b0mupCVaouPXPGNN=Ji2XceeceUf8L6pW8+vq3uOMQ@mail.gmail.com>
 <7ee1e308-c58c-45a0-8ded-6694feae097f@ddn.com> <20251105224245.GP196362@frogsfrogsfrogs>
 <d57bcfc5-fc3d-4635-ab46-0b9038fb7039@ddn.com>
In-Reply-To: <d57bcfc5-fc3d-4635-ab46-0b9038fb7039@ddn.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 6 Nov 2025 11:13:01 +0100
X-Gm-Features: AWmQ_bnAT8lXoPDlicl8Hs4raqZeJeZe1parGNJjkEmyQx2-92I9FrkZn-wh8cI
Message-ID: <CAOQ4uxgKZ3Hc+fMg_azN=DWLTj4fq0hsoU4n0M8GA+DsMgJW4g@mail.gmail.com>
Subject: Re: [RFC] Another take at restarting FUSE servers
To: Bernd Schubert <bschubert@ddn.com>, "Darrick J. Wong" <djwong@kernel.org>
Cc: Luis Henriques <luis@igalia.com>, Bernd Schubert <bernd@bsbernd.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kevin Chen <kchen@ddn.com>
Content-Type: text/plain; charset="UTF-8"

[...]

> >>> fuse_entry_out was extended once and fuse_reply_entry()
> >>> sends the size of the struct.
> >>
> >> Sorry, I'm confused. Where does fuse_reply_entry() send the size?

Sorry, I meant to say that the reply size is variable.
The size is obviously determined at init time.

> >>
> >>> However fuse_reply_create() sends it with fuse_open_out
> >>> appended and fuse_add_direntry_plus() does not seem to write
> >>> record size at all, so server and client will need to agree on the
> >>> size of fuse_entry_out and this would need to be backward compat.
> >>> If both server and client declare support for FUSE_LOOKUP_HANDLE
> >>> it should be fine (?).
> >>
> >> If max_handle size becomes a value in fuse_init_out, server and
> >> client would use it? I think appended fuse_open_out could just
> >> follow the dynamic actual size of the handle - code that
> >> serializes/deserializes the response has to look up the actual
> >> handle size then. For example I wouldn't know what to put in
> >> for any of the example/passthrough* file systems as handle size -
> >> would need to be 128B, but the actual size will be typically
> >> much smaller.
> >
> > name_to_handle_at ?
> >
> > I guess the problem here is that technically speaking filesystems could
> > have variable sized handles depending on the file.  Sometimes you encode
> > just the ino/gen of the child file, but other times you might know the
> > parent and put that in the handle too.
>
> Yeah, I don't think it would be reliable for *all* file systems to use
> name_to_handle_at on startup on some example file/directory. At least
> not without knowing all the details of the underlying passthrough file
> system.
>

Maybe it's not a world-wide general solution, but it is a practical one.

My fuse_passthrough library knows how to detect xfs and ext4 and
knows about the size of their file handles.
https://github.com/amir73il/libfuse/blob/fuse_passthrough/passthrough/fuse_passthrough.cpp#L645

A server could optimize for max_handle_size if it knows it or use
MAX_HANDLE_SZ if it doesn't.

Keep in mind that for the sake of restarting fuse servers (title of this thread)
file handles do not need to be the actual filesystem file handles.
Server can use its own pid as generation and then all inodes get
auto invalidated on server restart.

Not invalidating file handles on server restart, because the file handles
are persistent file handles is an optimization.

LOOKUP_HANDLE still needs to provide the inode+gen of the parent
which LOOKUP currently does not.

I did not understand why Darrick's suggestion of a flag that ino+gen
suffice is any different then max_handle_size = 12 and using the
standard FILEID_INO64_GEN in that case?

Thanks,
Amir.

