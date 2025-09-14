Return-Path: <linux-fsdevel+bounces-61258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712A3B56B76
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 21:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B00177048
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 19:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4491627A127;
	Sun, 14 Sep 2025 19:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hwOS7uX/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E318F1B532F
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Sep 2025 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757876515; cv=none; b=NpHzj5OZWgOaU0GcoQlRmsWikzCTzhkgnYZDczXUD6ObyouRa5HSvEBpEUHKXEBy7/6NTxkwkeW6iVPPtu7JW8+vuvfYK2305ljpwdEdYd9JnJivj4McIE4+I4tDn0QpMZeMAtQXvdKE/clxDBrhJ9ZiTHIuJST1K/DxhEWBRoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757876515; c=relaxed/simple;
	bh=tWRnOkoSNnC3rSkVzZ0thbOPFNYW0R1k/vOjAHOmUeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbLB63HVpU9SghwnSFrFunwNviEHkClLaCXYF63ES3vwSemwwSe6E/V2Unzq44qq3pP3uNP4WBV1cAr8g/fuz3LVVcZskNrHS58Umkt+/i9li/xbQ7xlz+enqiLubKmUgAV6Sk+mg56pXSTitE+2jhtDi8N21WVr0PxyInFzYVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=hwOS7uX/; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b38d4de6d9so20000741cf.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Sep 2025 12:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1757876511; x=1758481311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IjuNc4f7tcCIhJ8D8pAnKvzhWN91WU71wJNI6xS/dUc=;
        b=hwOS7uX/XtB8KO2Ip51D7SGLCBC89AyCDVYkzrNZujRXEaIwNu7mRXwljjlHY0wBdq
         3F11jLW5iUSdqDENTgI9Ckd9KuF60D8lST9MB2lYYJohKWhF08YAZIQWf84xMsajBhzp
         n0MnAdbied27CvA+Wuj9EXjFOkme27XfS+2ZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757876511; x=1758481311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IjuNc4f7tcCIhJ8D8pAnKvzhWN91WU71wJNI6xS/dUc=;
        b=VSpDGOqYlAsXl+Rd+Fg1yHadBZIlAu/uEHMjMsab59DAS+YAPDsIlgoPhTbECx5EWH
         J2oWbLMXHgW9K8lKWZXU43tGDQnOrLvUzWLfB8yStnVdqb/Ah/NId6It7kUj2E3h2dA0
         cbwVm8HVRqvZThjzqg94SnaCnRQ+ghyzvGEB5s1eWaQvaZI86Dm3kGLq8NVQqq3SFHJX
         C+4i5lQoDfwWhMa03sZkF6eOyRubPhu3K8Vjla+mEuoZR5d2LU5LxZikvGk1Td5yAxDZ
         Vl9NIuG3RG/2UXLUPfSSfljBdl6IsNB1tqV3y74B17lVIInrSCmEY0x6dtgGxpB7SL9b
         mCHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqMjT8xOkmAl7RW571jzRTCtxM2yPndSQLb3Coe/px2FqZ/LGyEYZ2mUCEFiwWMnzLur3/6OIC8AmOzJMY@vger.kernel.org
X-Gm-Message-State: AOJu0YyjESuIxk9mDEHzGKl0FwEaS5AHaD6VjG5fR+Nv44zj0vfEyCVe
	o4H3BdMEXto2CsCbqMvoyPuw69j13ieEkaPiC9c2N+LaYKZfIyb6jUH8V6y26CC0/prtTfCpyNb
	LTU8ELoSux3b8qQHCVd3eKGlI38nQAVGLQXSmEhKkEw==
X-Gm-Gg: ASbGncs9CjaZ6GbxJhVd+4kmSrxtWWTjg/cxbVE3bv/OjvjKLpEHH+XISlEDmY9SR1/
	3yVa2RCgA56d4XC7RDXqy8qKT5xG4GtC96oxprsRKQW04UDLKc3aPGEva7ktgkFjz7zg9fboFML
	60FO3BmRboQuDVRG0HFdtjp5yBAxnO9FA5+Y19AgjjWNypMrauP94gvUNWdm9C/dzaV5fh+K/B8
	NYzK9EYSh6OhcuCrv/dlc0ml56xsJolFzq/nWnbluLlbkHMBTjA
X-Google-Smtp-Source: AGHT+IFnCW6CHy8Ae8CsHeC5xyfNy5w5pX/YjG6Uw0orUfLPs3lFVUe3JZOoYAYFKQfIHfIcPqCc6BduRyyeU2Vpr9g=
X-Received: by 2002:a05:622a:514a:b0:4b4:c44f:1a7b with SMTP id
 d75a77b69052e-4b77d0bd2f7mr137866141cf.62.1757876511529; Sun, 14 Sep 2025
 12:01:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908090557.GJ31600@ZenIV> <175747234137.2850467.15661817300242450115@noble.neil.brown.name>
 <20250910072423.GR31600@ZenIV> <20250912054907.GA2537338@ZenIV>
 <CAJfpeguqygkT0UsoSLrsSMod61goDoU6b3Bj2AGT6eYBcW8-ZQ@mail.gmail.com>
 <20250912182936.GY39973@ZenIV> <175773460967.1696783.15803928091939003441@noble.neil.brown.name>
 <20250913050719.GD39973@ZenIV>
In-Reply-To: <20250913050719.GD39973@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 14 Sep 2025 21:01:40 +0200
X-Gm-Features: Ac12FXxQT4YvBylD79SYKhmnPcBB3tPDdPaGckz4F0YtJI3f6jn4BiuSEIHSPuk
Message-ID: <CAJfpegvXtXY=Pbxv+dMGFR8mvWN0DUwhSo6NwaVexk6Y6sao+w@mail.gmail.com>
Subject: Re: ->atomic_open() fun (was Re: [RFC] a possible way of reducing the
 PITA of ->d_name audits)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: NeilBrown <neil@brown.name>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Sept 2025 at 07:07, Al Viro <viro@zeniv.linux.org.uk> wrote:

> How would that combined revalidate+open work for fuse, anyway?  The former
> is basically a lookup - you send nodeid of parent + name, get nodeid +
> attributes of child.  The latter goes strictly by nodeid of child and
> gets a 64bit number that apparently tells one opened file from another
> (not to be confused with fhandle).  Combined request of some sort?

There are already two combined ones: FUSE_CREATE and FUSE_TMPFILE both
get nodeid of parent + name and return attributes of child plus opened
file.  FUSE_CREATE gets invoked in the uncached or cached negative
case from ->atomic_open() with inode lock for held exclusive.

That leaves 2 cases:

- uncached plain open: FUSE_OPEN_ATOMIC with same semantics as
FUSE_CREATE, inode lock held shared

- cached positive (plain or O_CREAT): FUSE_OPEN_REVAL getting nodeid
of parent + name + nodeid of child and return opened file or -ESTALE,
no locking required

Thanks,
Miklos

