Return-Path: <linux-fsdevel+bounces-10018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E958470A3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 13:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F301F27A17
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 12:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3EF187F;
	Fri,  2 Feb 2024 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCuPbP65"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04E8185B;
	Fri,  2 Feb 2024 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878224; cv=none; b=tyvfR5vBDrh59J4EZgO40LkLHYMIVCWgGlii+iBwAIoKmJz39W1BQPqxiM4FG0YmdXHoC/QvQi4BECRuLGRixTNbtef3nkHQcX49EjqvxqrktzviJ7Okss/rgcMXH2ib0wPJdVnBTE/WrrGD283y9zqx8XIZjNJI5AIATLA0Dt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878224; c=relaxed/simple;
	bh=E7jP5C7q25wm+QQnBvsWuHkyDZGxYFlYeQa/UVsQEck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=AGjnjbhboqEL5VrDgtiOrP62ZVSnxwX2GF4e0sQ8ZQ0oZ9YcsLyrGX/XU+LqJqt5w7ER2cbh5orJrkSBdwDuX6l2duS+2Yy8XVHBU9M2pk+0eBhB1JoR9dfCVUfR6PHaXIxrqhXrQAoHHeHdmKR2AUVzKbPEv5JKE1bxETVzwI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCuPbP65; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3510d79ae9so271809966b.0;
        Fri, 02 Feb 2024 04:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706878221; x=1707483021; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M18mwpzLQkasjmZ65hLbdYsJ9wZyXxqBXydJFBrwzI8=;
        b=aCuPbP65Tx+YkHPR2AY/vr0iB7RgTnu1fivJCqCgIux9foplCKCAKxz9bj6wkXvFwP
         RbtLr5oe0rDAhMQ3tl2zrjxnqqFkTk4WzDlZFxlX7ywCYMksqR6j9skPhsxYzfLEpWGD
         2Qud7hrL+jikAGXRUNiIhlj5eK1SDj5XMkRBmuSvgB1YiId0fSxeBhOekLdlGvmo8IxI
         E2B1ggAR5I81yUCUfg0JqWeQzWZuvZccM4Ck8eNXyrrZH3cyHfaadtCviBAFHpNg9awS
         A9FtcKTJPyNcMJKa5sufJhgsPEYGsVET5DuCCoNCNjEhX/ppAqpscLIs1DbX2lEskdsf
         nWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706878221; x=1707483021;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M18mwpzLQkasjmZ65hLbdYsJ9wZyXxqBXydJFBrwzI8=;
        b=D8v7WoZd0or3zK7MwfIgFqzUPDtjWLVcQsEB2FDHFhwpKlzKOuWb0fgiHWC315lTN2
         4qAU//p2ZfhzxSMIjJVAG4pEdiJGm3WpS+hAsLRrcoKK+cXt9Tn595agC6d3Dt53esZv
         8qhfF1bPkwh+uB7z42Sm5voet7oCZjhzB2IuRiUXbQ/wj5IiTVkyWR1rrdwYwhOEnAMW
         wl31Z4P8mT9J4k5ptsVdZ+Gbrr6V9keSLb0hyCUVQnjF+mVbgX4PoKSkuD02+jC3aL7C
         wkM1vVMq8txRGBz0vrR+/OmaIIyXy6Ym9P6cQnu/ZCYlvhRuqJiQvtyhpwKvhlDxla/l
         46xA==
X-Gm-Message-State: AOJu0YwZT+l5J727+q3J2dNtHIyJLuS15gz8RK4JViveLlZQUMWpHRYH
	yYv6rh9pwTxN05Su9pmrTo63HOncgaecdB50jw1XLdRCWcgVPyxbGKnNseruJV0CHhnJnXOJnd2
	cCBL+uMkZxrOSpohPeFaJZERTEcM=
X-Google-Smtp-Source: AGHT+IEJXUf4rgMWBzsmarXWnbVaDk97/4sS348tSOlV8USu7BW6sU20CahUPyperdvpCo6vp3/5gvU9D5sWL4ZGDns=
X-Received: by 2002:a17:906:fc26:b0:a30:db53:5bb5 with SMTP id
 ov38-20020a170906fc2600b00a30db535bb5mr5237167ejb.58.1706878220738; Fri, 02
 Feb 2024 04:50:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229143521.44880-1-meetakshisetiyaoss@gmail.com>
 <20231229143521.44880-2-meetakshisetiyaoss@gmail.com> <7e61ce96ef41bdaf26ac765eda224381@manguebit.com>
 <CAFTVevWC-6S-fbDupfUugEOh_gP-1xrNuZpD15Of9zW5G9BuDQ@mail.gmail.com>
 <c618ab330758fcba46f4a0a6e4158414@manguebit.com> <62eb08fb-b27f-4c95-ab29-ac838f24d70f@talpey.com>
 <CANT5p=qqUbqbedW+ccdSQz2q1N-NNA-kqw4y8xSrfdOdbjAyjg@mail.gmail.com> <242e196c-dc38-49d2-a213-e703c3b4e647@samba.org>
In-Reply-To: <242e196c-dc38-49d2-a213-e703c3b4e647@samba.org>
From: Meetakshi Setiya <meetakshisetiyaoss@gmail.com>
Date: Fri, 2 Feb 2024 18:20:08 +0530
Message-ID: <CAFTVevU1McNQVZqA-AW0t87cfh4+OKR2hXP0msTXxgHqfOTn+g@mail.gmail.com>
Subject: Re: [PATCH 2/2] smb: client: retry compound request without reusing lease
To: Steve French <smfrench@gmail.com>, Shyam Prasad N <nspmangalore@gmail.com>, sfrench@samba.org, 
	Tom Talpey <tom@talpey.com>, Paulo Alcantara <pc@manguebit.com>, sprasad@microsoft.com, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	Meetakshi Setiya <msetiya@microsoft.com>, bharathsm.hsk@gmail.com, 
	linux-fsdevel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

There was a pending fix to reuse lease key in compound operations on
the smb client, essentially proposed to resolve a customer-reported
bug. A scenario similar to what the client faced would be this:
Imagine a file that has a lot of dirty pages to be written to the
server. If rename/unlink/set path size compound operations are
performed on this file, with the current implementation, we do not
send the lease key. Resultantly, this would lead to the server
assuming that the request came from a new client and it would send a
lease break notification to the same client, on the same connection.
This lease break can lead the client to consume several credits while
writing its dirty pages to the server. A deadlock may arise when the
server stops granting more credits to this connection and the deadlock
would be lifted only when the lease timer on the server expires.

The fix initially proposed just copied the lease key from the inode
and passed it along to SMB2_open_init() from unlink, rename and set
path size compound operations. Incidentally, that exposed a
shortcoming in the smb client-side code. As per MS-SMB2, lease keys
are associated with the file name. Linux cifs client maintains lease
keys with the inode. If the file has any hardlinks, it is possible
that the lease for a file be wrongly reused for an operation on the
hardlink or vice versa. In these cases, the mentioned compound
operations fail with STATUS_INVALID_PARAMETER.

A simple, but hacky fix for the above, as per my discussion with Steve
would be to have a two-phased approach and resend the compound op
request again without the lease key if STATUS_INVALID_PARAMETER is
received. This fix could be easily backported to older kernels since
it would be pretty straightforward and does not involve a lot of code
changes. Such a fallback mechanism should not hurt any functionality
but might impact performance especially in cases where the error is
not because of the usage of wrong lease key and we might end up doing
an extra roundtrip. From what I know, use cases where two or more
file+hardlinks are being used together at the same time are kind of
rare, so we might not run into cases where resending requests in this
fashion has to be performed often.

I understand this is not a perfect or correct fix to the problem, but
for the time being, it might help solve the customer reported issue I
mentioned at the start and could also be backported readily. Since
hurting caching for all hardlinked files is not ideal, I am already
working on another fix that stores the dentry pointer with the lease
key in the cinode object.

From my discussion with Steve and Shyam, the fix proposed was this:
Instead of having a list of dentries/key dentry pairs, we can store a
dentry pointer in addition to the lease key in the cinode object. The
dentry (as a proxy for filename/path) would be the one the lease key
is associated with. There would be a reference counter to maintain the
number of open handles for that file(path)/dentry. When a new file is
created, not only its lease key, but its dentry too be set in the
cinode object. Whenever there is a new handle opened to this dentry,
the reference count to the leasekey/dentry in the cinode object would
be increased. While reusing the lease key, check if dentry (from the
request) matches the dentry stored in the cinode. If it does, copy the
lease key, if it does not, do not use that lease key. When all file
handles to a dentry have been closed, clear the dentry and lease key
from the cinode object. This has the potential to fix the hardlink
issue since dentries for different hardlinks would be different and
one would not end up reusing lease from another. Some implementation
details I am unsure about is should the open request for a file with
mismatched dentry (which would not get to reuse the lease key) send no
lease context at all, or create a new lease key and use that, or
something else?

I am writing this mail to seek advice/feedback on the situation. Any
suggestions or better solutions to any of the issues mentioned in this
mail are very much appreciated.

Thanks
Meetakshi




On Fri, Jan 5, 2024 at 3:30=E2=80=AFPM Stefan Metzmacher <metze@samba.org> =
wrote:
>
> Am 05.01.24 um 10:39 schrieb Shyam Prasad N via samba-technical:
> > On Fri, Jan 5, 2024 at 2:39=E2=80=AFAM Tom Talpey <tom@talpey.com> wrot=
e:
> >>
> >> On 1/3/2024 9:37 AM, Paulo Alcantara wrote:
> >>> Meetakshi Setiya <meetakshisetiyaoss@gmail.com> writes:
> >>>
> >>>> As per the discussion with Tom on the previous version of the change=
s, I
> >>>> conferred with Shyam and Steve about possible workarounds and this s=
eemed like a
> >>>> choice which did the job without much perf drawbacks and code change=
s. One
> >>>> highlighted difference between the two could be that in the previous
> >>>> version, lease
> >>>> would not be reused for any file with hardlinks at all, even though =
the inode
> >>>> may hold the correct lease for that particular file. The current cha=
nges
> >>>> would take care of this by sending the lease at least once, irrespec=
tive of the
> >>>> number of hardlinks.
> >>>
> >>> Thanks for the explanation.  However, the code change size is no excu=
se
> >>> for providing workarounds rather than the actual fix.
> >>
> >> I have to agree. And it really isn't much of a workaround either.
> >>
> >
> > The original problem, i.e. compound operations like
> > unlink/rename/setsize not sending a lease key is very prevalent on the
> > field.
> > Unfortunately, fixing that exposed this problem with hard links.
> > So Steve suggested getting this fix to a shape where it's fixing the
> > original problem, even if it means that it does not fix it for the
> > case of where there are open handles to multiple hard links to the
> > same file.
> > Only thing we need to be careful of is that it does not make things
> > worse for other workloads.
> >
> >>> A possible way to handle such case would be keeping a list of
> >>> pathname:lease_key pairs inside the inode, so in smb2_compound_op() y=
ou
> >>> could look up the lease key by using @dentry.  I'm not sure if there'=
s a
> >>> better way to handle it as I haven't looked into it further.
> >>
> >
> > This seems like a reasonable change to make. That will make sure that
> > we stick to what the protocol recommends.
> > I'm not sure that this change will be a simple one. There could be
> > several places where we make an assumption that the lease is
> > associated with an inode, and not a link.
> >
> > And I'm not yet fully convinced that the spec itself is doing the
> > right thing by tying the lease with the link, rather than the file.
> > Shouldn't the lease protect the data of the file, and not the link
> > itself? If opening two links to the same file with two different lease
> > keys end up breaking each other's leases, what's the point?
>
> I guess the reason for making the lease key per path on
> the client is that the client can't know about possible hardlinks
> before opening the file, but that open wants to use a leasekey...
> Or a "stat" open that won't any lease needs to be done first,
> which doubles the roundtrip for every open.
>
> And hard links are not that common...
>
> Maybe choosing und using a new leasekey would be the
> way to start with and when a hardlink is detected
> the open on the hardlink is closed again and retried
> with the former lease key, which would also upgrade it again.
>
> But sharing the handle lease for two pathnames seems wrong,
> as the idea of the handle lease is to cache the patchname on the client.
>
> While sharing the RW lease between two hardlinks would be desired.
>
> metze

