Return-Path: <linux-fsdevel+bounces-55750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59519B0E545
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 23:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E088547985
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 21:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645F3285CB9;
	Tue, 22 Jul 2025 21:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eSno36Qa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2602B285C90
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 21:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753218810; cv=none; b=KZ9L73sb5uSUf5HwoeWB4cAe6QMtME3vTMYPHqj6vIYUrGTqekwFuSTrJsSx7JTg5PiyiRlD5jJ9+rDPS1juRdiqNwcfggRSkUnhNFDDb4Lv7nc0EV7yhc0RdeIadytLZnJ83LWMbbWdf/mJSCQsIvf9Wa3xi+AU4vz84Fj55uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753218810; c=relaxed/simple;
	bh=wwtrBXB8ibdKB9j/9CK69Unzz1v754W/g/0KbLp9gUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qa3sHN/pFkHCDo1VprFPX3YQZ4x0eiZMQob8JAfRng0RJ8Krm0VjFAcMjXCe8ENhr3NgsiDo4/UioJTWpm4I5q7bc6aZ+jsMt/MYfSbR/I8MmqKIyWJzwW2GuZmKLgc6N4Q/6X5sIfxRJSh5ZVKCsHcIXY0o46rC1FCkL7Sqmbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eSno36Qa; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so9786393a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 14:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753218807; x=1753823607; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wwtrBXB8ibdKB9j/9CK69Unzz1v754W/g/0KbLp9gUk=;
        b=eSno36Qa3GuMRyAjvBEE+pT2o38yjJwqrGafq08aeeShpRUyDuHxPboVohLYzjSd2H
         J/AaOZxWBkw9t4SY3dkdQcXi08dgU7LQ/fsx4TSgxINBXXZG4m00pCUlg2Mcmktmi1O7
         kA22wx/brOGRbJBILH2TDTaJUobfM4qYX3xqTkUE/nE5XBlJC11hraqi+nLzDX4jc6Lb
         fhHrNBL2uVXrcG8hIaNW/QNxoePz+tyw9udu7yw5Rb1OAjJKSWbjrAfGElVos9oAkEyY
         Sg54fIZvv1dUU9mOl/pAlZMFqHOrz3RYHnIY+9qc/snhjj5QH3BZGCQz+fHZdsudcH/v
         e/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753218807; x=1753823607;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwtrBXB8ibdKB9j/9CK69Unzz1v754W/g/0KbLp9gUk=;
        b=mf2ShXymjKEB1eKM/SRLp1lvhwyim2V4AmKmjsGayDEm8PeoIrcjHkgAKy0NMZfVJS
         biXrQ9RRpjySuEEm3teNrGNNUX/aW4vhPEjSmWR6eIa2BY3kW/VX5Dkts98GIfUa4WBE
         mSQ0xWH/rmQtOxIbefarOQOVihw9gj0Ic3LCAB9te7rFpR1R9u6NwAD+Ro9XVOBoZKhp
         iVg2iw0O2xdM0m/UOqRdSk//Ml2dTxz+wRgb316pK4kVTJ0O6j7EBw5ojvaiXShiwRjQ
         BSuc5k2+ciusMa4lK1Edwey6XHxprBE6CMY8KOu2iCRRPKbdh4UtOBdepINHvmnaAn6R
         0o3g==
X-Forwarded-Encrypted: i=1; AJvYcCWXwgyW2HRUiouAxeqcODssEvly6iH+2H8UJJbQRQlw7DBEI9Uue7UwOL0l5QsBn6afvBkhllu19DkWyL3z@vger.kernel.org
X-Gm-Message-State: AOJu0YwbrmoAiq2wDhMvML/SsLogD32oV9RAQSouY2Ggxp+ujlQ1fuIM
	gnA2736fTBYZqvt4vIgefqooerL9TVRTgdbuqqNKzthEZs+C7HdLWX9vFuPgMQVhn/3mtCtw+Tg
	qYrE7ZN6RmOuVj30ghSlZdCADU1gXf9UuzW6W+1T8
X-Gm-Gg: ASbGncvlZW4GG+5cstGplbPjyJaSSjzz56vxusuUQM7ra4xpPjKKpeDj+Brcn6XNvwF
	ushcOcFMcHbWAruOswHEQR92K3rhSk6NpN1+d6efP5cwhIAzcdQTC35P+uDXXZKR1s2xnutfwvW
	sLH2Mikw64OfwWKlYgHHByiwi53S7UD1UNBvJMngck7TxHZDN8XK/L3M8b8py4kPJk68Hk6Wvgc
	WGBVcBazS/RefkFoUOks84oqsNhh4zc7WiA2Q==
X-Google-Smtp-Source: AGHT+IF5iBrnA8CeAarmrMD8sUm+LoqhPEoPIWqIjWp4bVEDDdpvi4LGDveeODjmd4nDrr5KgGyrFJwaPFEhL7HILko=
X-Received: by 2002:a17:907:f495:b0:ae0:a351:61ff with SMTP id
 a640c23a62f3a-af2f8958839mr32587966b.32.1753218807216; Tue, 22 Jul 2025
 14:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617221456.888231-1-paullawrence@google.com>
 <CAOQ4uxgaxkJexvUFOFDEAbm+vW4A1qkmvqZJEYkZGR5Mp=gtrg@mail.gmail.com>
 <CAL=UVf707OokQUuhzbvrweFziLVmiDD3TFs_WG2hRY0-snw7Wg@mail.gmail.com>
 <CAOQ4uxhUK6EeCUZ36+LhT7hVt7pH9BKYLpxF4bhU4MM0kT=mKg@mail.gmail.com> <CAOQ4uxjX1Cs-UYEKZfNtCz_31JiH74KaC_EdU07oxX-nCcirFQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjX1Cs-UYEKZfNtCz_31JiH74KaC_EdU07oxX-nCcirFQ@mail.gmail.com>
From: Paul Lawrence <paullawrence@google.com>
Date: Tue, 22 Jul 2025 14:13:12 -0700
X-Gm-Features: Ac12FXwWHePEdBXlsbRDL14Rr96ybs6aO4nXPAOMeK8mNkU7e_cKPTHWYDa_QOk
Message-ID: <CAL=UVf5W9eJF4FL6aRG4e1VoFWg8jj4X4af=j-OGdU=QxmPuwA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] RFC: Extend fuse-passthrough to directories
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"

I spent a little time with these patches. I wrote my own to set the
backing file at lookup time by adding an optional second out struct.
Is there a reason we should not do this? It seems the most natural
solution.

After a while, I began to wonder if what I was planning was actually
the same as your vision. I decided to jot down my thoughts to see if
you agree with them. Also I was confused as to why you were adding the
ability to set backing files to GETATTR. So here are my notes.

Design of fuse passthrough for all operations

Goal:

When a fuse filesystem implements a stacking filesystem over an
underlying file system, and a significant fraction of the calls will
simply be passed to the underlying file system, provide a mechanism to
pass those calls through without going to user space. This is
primarily to enhance performance, though it might simplify the daemon
somewhat too.

Current state:

Currently passthrough allows a backing file to be set at file open
time. If a backing file is set, all read/write operations will be
forwarded to the backing file.

Design:

Add ability to set backing file on the found inode in response to a
positive lookup. This file might be opened with O_PATH for performance
reasons. The lookup api would be modified to have an optional second
out struct that contains the backing file id. Note that we will use
the backing file ioctl to create this id to remove any security
concerns.

The ioctl will also take a 64-bit integer to define which operations
will be passed through, the operations mask. This will have one bit
for each of the existing FUSE_OPERATIONS, at least the ones that act
on inodes/files.

Then when fuse fs is considering calling out to the daemon with an
opcode, fuse fs will check if the inode has a backing file and mask.
If it does, and the specific opcode bit is set, fuse fs will instead
call out to a kernel function in backing.c that can perform that
operation on the backing file correctly.

Details:

Question: Will it be possible to change the mask/backing file after
the initial setting? My feeling is that it might well be useful to be
able to set the mask, the file not so much. Situations would be (for
example) a caching file system that turns off read forwarding once the
whole file is downloaded.

FUSE_OPEN will, if the backing file has been set, reopen it as a file
(not a path) if needed. This is whether or not FUSE_OPEN is passed
through.

If FUSE_OPEN is passed through, user space will not get the chance to
assign a file handle ID to the opened file. It will still be possible
to pass FUSE_READ etc to the daemon - the daemon will still have the
node id and be able to read data based on that.

FUSE_LOOKUP can return a 0 node id, but only if *all* operations on
that node as marked as passthrough.

Suggestion: During FUSE_LOOKUP, if FUSE_GETATTR is set in the mask,
ignore the passed in attributes and read them from the backing file.

Random, non-exhastive list of considerations:

FUSE_FORGET can only be marked passthrough if the node id is 0.

FUSE_CREATE returns a new node id and file handle. It would need the
ability to set backing files.

If FUSE_LOOKUP is marked for passthrough, then looked up inodes will
be prepopulated with a backing O_PATH file and a mask will all bits
set.

FUSE_RENAME takes two nodes and names, and moves one to the other. If
one is passthrough and one is not, there is no obvious way of
performing a rename. Either fall back to copy/delete or return EXDEV

