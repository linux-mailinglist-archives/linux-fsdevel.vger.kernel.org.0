Return-Path: <linux-fsdevel+bounces-11656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6076855BB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 08:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC65BB27792
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 07:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618A5DDDF;
	Thu, 15 Feb 2024 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIxVlj17"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8506DDAB;
	Thu, 15 Feb 2024 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707982344; cv=none; b=MGKG/DnrVtzPSst9enfh/ux3QeBOpXjcIYjtAlzHQHsz7zkmy8X2WcXuMZb2JFHmZVoG+DiAlJE420BqsG+ne69ydWWFCM5MqIfx3WDenCCylb1WjB1Q6jobBzkLXbSACOgWJzv7tOZTbuYgsmgh+UXzjBklxY8w2Ari7QwrHOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707982344; c=relaxed/simple;
	bh=WttKdOsaZAh/lxhRdS9o3+0nRfw5eH3RybY7gJ8TdhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0w48PcsW5R6uH/9KMb5vBYWyyLKp8M51JcqZDL/TFHLlOVgggLKz+dCfU+qJ8AGX9VgynltBgVN0/XtAq1ADSCBNOf8/CEARFhb5XkmuIqHmgvioYL/q1uHmD1PLUjxpFZLNoy02+yoLny2IGwS6VErgbWgQy8cDHDs23KbzPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIxVlj17; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d0a4e1789cso6009461fa.3;
        Wed, 14 Feb 2024 23:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707982340; x=1708587140; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2fVn7qDRYINI8G3u1hxiNPXg60nF8CHMnj5WGlTyWWU=;
        b=VIxVlj17HEY2Dy5ou0OazUu+Hb6Oge26lOS29KrAEUJOI7W9/POPDCIeHTO0CWZxCP
         KGlb3cGjdFu/FDcJpNo9ZuClVsEEekwM6O14+hFh1MHWtR2ANynMqDCX887lzh73i6ou
         H3KTdMVE8cMVFpQZaWWdTsIrNn9qqjRi5UOYK4eglwu5ete/IlJd5PfgRKHE276v9ykI
         8yzcK6coA5tmR710ShbfEnlLFYYFxE9JjnKEi62Hc9FtVoPuFYYEpLN1NTHAqwHQ/3aQ
         raYhDHqAg4PQ/qGf7CqDQfVnSiqAqv4hv/vl4xbYu3O4HMri5fsqswjEpDQWrVhI9jGY
         CyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707982340; x=1708587140;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2fVn7qDRYINI8G3u1hxiNPXg60nF8CHMnj5WGlTyWWU=;
        b=VhxMOfEGEGIkc3ICKxuw02ffk/jkhOT2Bk2xZNRneOLeCEd4+8T239CxrXGb9SZYB0
         nz3sR2GArFbRkI334fQjpiy0W8hAxsYG2ypKnNDMWLZtK5s8vQ5N5nRxJOY8ttz39VY9
         /CrIYghj2Bz9kISaOc2U8m3yz9mfSYQZFYy5PVX0J8oehbAcxt6kPNVADb9QGU7vParo
         42Vukf4aYlw+WcuI9mCFOVN44crvSSwGBBh2ukZYm+FWOBTrYK+kKqJGNelU7c2+j23F
         kgoeOErXct/llX3zwL7nhAqDThb2OtjZsPurFOPF+nPPT/2K9/goHTn/haQBkvurz6LY
         9X8A==
X-Forwarded-Encrypted: i=1; AJvYcCU1wFtAsjIWYi906agnGP+Wk+k3Jt4GscImFEdh7305MqF9rRsGWICtEF9VDu1OFYBMgtph9oaMkefKjdwDyNDjVHv0xJX+DFV1m1cisu9sq/KFJfh9dms7DdCABav5ntjNy5is4cv1POU=
X-Gm-Message-State: AOJu0Yy5qMUfDWFSvTmX3fWcOXmM5KmmK9n1q+l1DAgbpVlmtiTCOOby
	xgGylvYRNi4csKwQv+KU8fo7mHVeJfSauIaAK20RCZveE/jdE97uUfKAYuUfMcuJf0jWjs2h0Th
	Xt9ffZrPQlbTGn99ufhCLrw9zShs=
X-Google-Smtp-Source: AGHT+IGNW6Jz8dyl3/4yBn86u1EzSj7Q+n7XRPbS8cZohW7pTWTlJRB3I9YrETmXNzG28CtUVNzzRHmcrNooQpTXFs0=
X-Received: by 2002:a2e:9b8b:0:b0:2d0:af5f:969c with SMTP id
 z11-20020a2e9b8b000000b002d0af5f969cmr655180lji.36.1707982340198; Wed, 14 Feb
 2024 23:32:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5mswELNv2Mo-aWNoq3fRUC7Rk0TjfY8kwdPc=JSEuZZObw@mail.gmail.com>
 <20240207034117.20714-1-matthew.ruffell@canonical.com> <CAH2r5mu04KHQV3wynaBSrwkptSE_0ARq5YU1aGt7hmZkdsVsng@mail.gmail.com>
 <CAH2r5msJ12ShH+ZUOeEg3OZaJ-OJ53-mCHONftmec7FNm3znWQ@mail.gmail.com>
 <CAH2r5muiod=thF6tnSrgd_LEUCdqy03a2Ln1RU40OMETqt2Z_A@mail.gmail.com>
 <CAH2r5mvzyxP7vHQVcT6ieP4NmXDAz2UqTT7G4yrxcVObkV_3YQ@mail.gmail.com>
 <CAKAwkKuJvFDFG7=bCYmj0jdMMhYTLUnyGDuEAubToctbNqT5CQ@mail.gmail.com>
 <CAH2r5mt9gPhUSka56yk28+nksw7=LPuS4VAMzGQyJEOfcpOc=g@mail.gmail.com>
 <CAKAwkKsm3dvM_zGtYR8VHzHyA_6hzCie3mhA4gFQKYtWx12ZXw@mail.gmail.com> <CAH2r5mvSsmm2WzAakAKWGJMs3C-9+z0EJ-msV0Qjkt5q9ZPBzA@mail.gmail.com>
In-Reply-To: <CAH2r5mvSsmm2WzAakAKWGJMs3C-9+z0EJ-msV0Qjkt5q9ZPBzA@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Thu, 15 Feb 2024 01:32:07 -0600
Message-ID: <CAH2r5mvPz2CUyKDZv_9fYGu=9L=3UiME7xaJGBbu+iF8CH8YEQ@mail.gmail.com>
Subject: Re: SMB 1.0 broken between Kernel versions 6.2 and 6.5
To: Matthew Ruffell <matthew.ruffell@canonical.com>
Cc: dhowells@redhat.com, linux-cifs@vger.kernel.org, rdiez-2006@rd10.de, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: multipart/mixed; boundary="000000000000abaa62061166a0dd"

--000000000000abaa62061166a0dd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Minor update to patch to work around the folios/netfs data corruption.

In addition to printing the warning if "wsize=3D" is specified on mount
with a size that is not a multiple of PAGE_SIZE, it also rounds the
wsize down to the nearest multiple of PAGE_SIZE (as it was already
doing if the server tried to negotiate a wsize that was not a multiple
of PAGE_SIZE).

On Fri, Feb 9, 2024 at 2:25=E2=80=AFPM Steve French <smfrench@gmail.com> wr=
ote:
>
> > > If the user does set their own "wsize", any value that is not a multi=
ple of
> > PAGE_SIZE is dangerous right?
>
> Yes for kernels 6.3 through 6.8-rc such a write size (ie that is not a
> multiple of page size) can
> be dangerous - that is why I added the warning on mount if the user
> specifies the
> potentially problematic wsize, since the wsize specified on mount
> unlike the server
> negotiated maximum write size is under the user's control.  The server
> negotiated
> maximum write size can't be controlled by the user, so for this
> temporary fix we are
> forced to round it down.   The actually bug is due to a folios/netfs
> bug that David or
> one of the mm experts may be able to spot (and fix) so for this
> temporary workaround
> I wanted to do the smaller change here so we don't have to revert it
> later. I got close to
> finding the actual bug (where the offset was getting reset, rounded up
> incorrectly
> inside one of the folios routines mentioned earlier in the thread) but
> wanted to get something
>
> On Fri, Feb 9, 2024 at 2:51=E2=80=AFAM Matthew Ruffell
> <matthew.ruffell@canonical.com> wrote:
> >
> > Hi Steve,
> >
> > Yes, I am specifying "wsize" on the mount in my example, as its a littl=
e easier
> > to reproduce the issue that way.
> >
> > If the user does set their own "wsize", any value that is not a multipl=
e of
> > PAGE_SIZE is dangerous right? Shouldn't we prevent the user from corrup=
ting
> > their data (un)intentionally if they happen to specify a wrong value? E=
specially
> > since we know about it now. I know there haven't been any other reports=
 in the
> > year or so between 6.3 and present day, so there probably isn't any use=
rs out
> > there actually setting their own "wsize", but it still feels bad to all=
ow users
> > to expose themselves to data corruption in this form.
> >
> > Please consider also rounding down "wsize" set on mount command line to=
 a safe
> > multiple of PAGE_SIZE. The code will only be around until David's netfs=
lib cut
> > over is merged anyway.
> >
> > I built a distro kernel and sent it to R. Diez for testing, so hopefull=
y we will
> > have some testing performed against an actual SMB server that sends a d=
angerous
> > wsize during negotiation. I'll let you know how that goes, or R. Diez, =
you can
> > tell us about how it goes here.
> >
> > Thanks,
> > Matthew
> >
> > On Fri, 9 Feb 2024 at 18:38, Steve French <smfrench@gmail.com> wrote:
> > >
> > > Are you specifying "wsize" on the mount in your example?  The intent
> > > of the patch is to warn the user using a non-recommended wsize (since
> > > the user can control and fix that) but to force round_down when the
> > > server sends a dangerous wsize (ie one that is not a multiple of
> > > 4096).
> > >
> > > On Thu, Feb 8, 2024 at 3:31=E2=80=AFAM Matthew Ruffell
> > > <matthew.ruffell@canonical.com> wrote:
> > > >
> > > > Hi Steve,
> > > >
> > > > I built your latest patch ontop of 6.8-rc3, but the problem still p=
ersists.
> > > >
> > > > Looking at dmesg, I see the debug statement from the second hunk, b=
ut not from
> > > > the first hunk, so I don't believe that wsize was ever rounded down=
 to
> > > > PAGE_SIZE.
> > > >
> > > > [  541.918267] Use of the less secure dialect vers=3D1.0 is not
> > > > recommended unless required for access to very old servers
> > > > [  541.920913] CIFS: VFS: Use of the less secure dialect vers=3D1.0=
 is
> > > > not recommended unless required for access to very old servers
> > > > [  541.923533] CIFS: VFS: wsize should be a multiple of 4096 (PAGE_=
SIZE)
> > > > [  541.924755] CIFS: Attempting to mount //192.168.122.172/sambasha=
re
> > > >
> > > > $ sha256sum sambashare/testdata.txt
> > > > 9e573a0aa795f9cd4de4ac684a1c056dbc7d2ba5494d02e71b6225ff5f0fd866
> > > > sambashare/testdata.txt
> > > > $ less sambashare/testdata.txt
> > > > ...
> > > > 8dc8da96f7e5de0f312a2dbcc3c5c6facbfcc2fc206e29283274582ec93daa2a149=
6ca8edd49e3c1
> > > > 6b^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^=
@^@^@^@^@^@^@^
> > > > ...
> > > >
> > > > Would you be able compile and test your patch and see if we enter t=
he logic from
> > > > the first hunk?
> > > >
> > > > I'll be happy to test a V2 tomorrow.
> > > >
> > > > Thanks,
> > > > Matthew
> > > >
> > > > On Thu, 8 Feb 2024 at 03:50, Steve French <smfrench@gmail.com> wrot=
e:
> > > > >
> > > > > I had attached the wrong file - reattaching the correct patch (ie=
 that
> > > > > updates the previous version to use PAGE_SIZE instead of 4096)
> > > > >
> > > > > On Wed, Feb 7, 2024 at 1:12=E2=80=AFAM Steve French <smfrench@gma=
il.com> wrote:
> > > > > >
> > > > > > Updated patch - now use PAGE_SIZE instead of hard coding to 409=
6.
> > > > > >
> > > > > > See attached
> > > > > >
> > > > > > On Tue, Feb 6, 2024 at 11:32=E2=80=AFPM Steve French <smfrench@=
gmail.com> wrote:
> > > > > > >
> > > > > > > Attached updated patch which also adds check to make sure max=
 write
> > > > > > > size is at least 4K
> > > > > > >
> > > > > > > On Tue, Feb 6, 2024 at 10:58=E2=80=AFPM Steve French <smfrenc=
h@gmail.com> wrote:
> > > > > > > >
> > > > > > > > > his netfslib work looks like quite a big refactor. Is the=
re any plans to land this in 6.8? Or will this be 6.9 / later?
> > > > > > > >
> > > > > > > > I don't object to putting them in 6.8 if there was addition=
al review
> > > > > > > > (it is quite large), but I expect there would be pushback, =
and am
> > > > > > > > concerned that David's status update did still show some TO=
DOs for
> > > > > > > > that patch series.  I do plan to upload his most recent set=
 to
> > > > > > > > cifs-2.6.git for-next later in the week and target would be=
 for
> > > > > > > > merging the patch series would be 6.9-rc1 unless major issu=
es were
> > > > > > > > found in review or testing
> > > > > > > >
> > > > > > > > On Tue, Feb 6, 2024 at 9:42=E2=80=AFPM Matthew Ruffell
> > > > > > > > <matthew.ruffell@canonical.com> wrote:
> > > > > > > > >
> > > > > > > > > I have bisected the issue, and found the commit that intr=
oduces the problem:
> > > > > > > > >
> > > > > > > > > commit d08089f649a0cfb2099c8551ac47eef0cc23fdf2
> > > > > > > > > Author: David Howells <dhowells@redhat.com>
> > > > > > > > > Date:   Mon Jan 24 21:13:24 2022 +0000
> > > > > > > > > Subject: cifs: Change the I/O paths to use an iterator ra=
ther than a page list
> > > > > > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/tor=
valds/linux.git/commit/?id=3Dd08089f649a0cfb2099c8551ac47eef0cc23fdf2
> > > > > > > > >
> > > > > > > > > $ git describe --contains d08089f649a0cfb2099c8551ac47eef=
0cc23fdf2
> > > > > > > > > v6.3-rc1~136^2~7
> > > > > > > > >
> > > > > > > > > David, I also tried your cifs-netfs tree available here:
> > > > > > > > >
> > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/=
linux-fs.git/log/?h=3Dcifs-netfs
> > > > > > > > >
> > > > > > > > > This tree solves the issue. Specifically:
> > > > > > > > >
> > > > > > > > > commit 34efb2a814f1882ddb4a518c2e8a54db119fd0d8
> > > > > > > > > Author: David Howells <dhowells@redhat.com>
> > > > > > > > > Date:   Fri Oct 6 18:29:59 2023 +0100
> > > > > > > > > Subject: cifs: Cut over to using netfslib
> > > > > > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/dho=
wells/linux-fs.git/commit/?h=3Dcifs-netfs&id=3D34efb2a814f1882ddb4a518c2e8a=
54db119fd0d8
> > > > > > > > >
> > > > > > > > > This netfslib work looks like quite a big refactor. Is th=
ere any plans to land this in 6.8? Or will this be 6.9 / later?
> > > > > > > > >
> > > > > > > > > Do you have any suggestions on how to fix this with a sma=
ller delta in 6.3 -> 6.8-rc3 that the stable kernels can use?
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > > Matthew
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Thanks,
> > > > > > > >
> > > > > > > > Steve
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Thanks,
> > > > > > >
> > > > > > > Steve
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Thanks,
> > > > > >
> > > > > > Steve
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Thanks,
> > > > >
> > > > > Steve
> > >
> > >
> > >
> > > --
> > > Thanks,
> > >
> > > Steve
>
>
>
> --
> Thanks,
>
> Steve



--=20
Thanks,

Steve

--000000000000abaa62061166a0dd
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb-Fix-regression-in-writes-when-non-standard-maxim.patch"
Content-Disposition: attachment; 
	filename="0001-smb-Fix-regression-in-writes-when-non-standard-maxim.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lsmwjnjq0>
X-Attachment-Id: f_lsmwjnjq0

RnJvbSA5OTk2Yjk4YzZiN2Q2YTQ4ZjI3MTMzNWRlZjZlOTA0NmJhMWEzYWQ2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFR1ZSwgNiBGZWIgMjAyNCAxNjozNDoyMiAtMDYwMApTdWJqZWN0OiBbUEFUQ0hdIHNt
YjogRml4IHJlZ3Jlc3Npb24gaW4gd3JpdGVzIHdoZW4gbm9uLXN0YW5kYXJkIG1heGltdW0gd3Jp
dGUKIHNpemUgbmVnb3RpYXRlZAoKVGhlIGNvbnZlcnNpb24gdG8gbmV0ZnMgaW4gdGhlIDYuMyBr
ZXJuZWwgY2F1c2VkIGEgcmVncmVzc2lvbiB3aGVuCm1heGltdW0gd3JpdGUgc2l6ZSBpcyBzZXQg
YnkgdGhlIHNlcnZlciB0byBhbiB1bmV4cGVjdGVkIHZhbHVlIHdoaWNoIGlzCm5vdCBhIG11bHRp
cGxlIG9mIDQwOTYgKHNpbWlsYXJseSBpZiB0aGUgdXNlciBvdmVycmlkZXMgdGhlIG1heGltdW0K
d3JpdGUgc2l6ZSBieSBzZXR0aW5nIG1vdW50IHBhcm0gIndzaXplIiwgYnV0IHNldHMgaXQgdG8g
YSB2YWx1ZSB0aGF0CmlzIG5vdCBhIG11bHRpcGxlIG9mIDQwOTYpLiAgV2hlbiBuZWdvdGlhdGVk
IHdyaXRlIHNpemUgaXMgbm90IGEKbXVsdGlwbGUgb2YgNDA5NiB0aGUgbmV0ZnMgY29kZSBjYW4g
c2tpcCB0aGUgZW5kIG9mIHRoZSBmaW5hbApwYWdlIHdoZW4gZG9pbmcgbGFyZ2Ugc2VxdWVudGlh
bCB3cml0ZXMsIGNhdXNpbmcgZGF0YSBjb3JydXB0aW9uLgoKVGhpcyBzZWN0aW9uIG9mIGNvZGUg
aXMgYmVpbmcgcmV3cml0dGVuL3JlbW92ZWQgZHVlIHRvIGEgbGFyZ2UKbmV0ZnMgY2hhbmdlLCBi
dXQgdW50aWwgdGhhdCBwb2ludCAoaWUgZm9yIHRoZSA2LjMga2VybmVsIHVudGlsIG5vdykKd2Ug
Y2FuIG5vdCBzdXBwb3J0IG5vbi1zdGFuZGFyZCBtYXhpbXVtIHdyaXRlIHNpemVzLgoKQWRkIGEg
d2FybmluZyBpZiBhIHVzZXIgc3BlY2lmaWVzIGEgd3NpemUgb24gbW91bnQgdGhhdCBpcyBub3QK
YSBtdWx0aXBsZSBvZiA0MDk2IChhbmQgcm91bmQgZG93biksIGFsc28gYWRkIGEgY2hhbmdlIHdo
ZXJlIHdlCnJvdW5kIGRvd24gdGhlIG1heGltdW0gd3JpdGUgc2l6ZSBpZiB0aGUgc2VydmVyIG5l
Z290aWF0ZXMgYSB2YWx1ZQp0aGF0IGlzIG5vdCBhIG11bHRpcGxlIG9mIDQwOTYgKHdlIGFsc28g
aGF2ZSB0byBjaGVjayB0byBtYWtlIHN1cmUgdGhhdAp3ZSBkbyBub3Qgcm91bmQgaXQgZG93biB0
byB6ZXJvKS4KClJlcG9ydGVkLWJ5OiBSLiBEaWV6IiA8cmRpZXotMjAwNkByZDEwLmRlPgpGaXhl
czogZDA4MDg5ZjY0OWEwICgiY2lmczogQ2hhbmdlIHRoZSBJL08gcGF0aHMgdG8gdXNlIGFuIGl0
ZXJhdG9yIHJhdGhlciB0aGFuIGEgcGFnZSBsaXN0IikKU3VnZ2VzdGVkLWJ5OiBSb25uaWUgU2Fo
bGJlcmcgPHJvbm5pZXNhaGxiZXJnQGdtYWlsLmNvbT4KQWNrZWQtYnk6IFJvbm5pZSBTYWhsYmVy
ZyA8cm9ubmllc2FobGJlcmdAZ21haWwuY29tPgpSZXZpZXdlZC1ieTogU2h5YW0gUHJhc2FkIE4g
PHNwcmFzYWRAbWljcm9zb2Z0LmNvbT4KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyB2Ni4z
KwpDYzogRGF2aWQgSG93ZWxscyA8ZGhvd2VsbHNAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTog
U3RldmUgRnJlbmNoIDxzdGZyZW5jaEBtaWNyb3NvZnQuY29tPgotLS0KIGZzL3NtYi9jbGllbnQv
Y29ubmVjdC5jICAgIHwgMTQgKysrKysrKysrKysrLS0KIGZzL3NtYi9jbGllbnQvZnNfY29udGV4
dC5jIHwgMTEgKysrKysrKysrKysKIGZzL3NtYi9jbGllbnQvZnNfY29udGV4dC5oIHwgIDEgLQog
MyBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2ZzL3NtYi9jbGllbnQvY29ubmVjdC5jIGIvZnMvc21iL2NsaWVudC9jb25uZWN0LmMK
aW5kZXggZDAzMjUzZjhmMTQ1Li5hYzk1OTU1MDRmNGIgMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9jbGll
bnQvY29ubmVjdC5jCisrKyBiL2ZzL3NtYi9jbGllbnQvY29ubmVjdC5jCkBAIC0zNDQ0LDggKzM0
NDQsMTggQEAgaW50IGNpZnNfbW91bnRfZ2V0X3Rjb24oc3RydWN0IGNpZnNfbW91bnRfY3R4ICpt
bnRfY3R4KQogCSAqIHRoZSB1c2VyIG9uIG1vdW50CiAJICovCiAJaWYgKChjaWZzX3NiLT5jdHgt
PndzaXplID09IDApIHx8Ci0JICAgIChjaWZzX3NiLT5jdHgtPndzaXplID4gc2VydmVyLT5vcHMt
Pm5lZ290aWF0ZV93c2l6ZSh0Y29uLCBjdHgpKSkKLQkJY2lmc19zYi0+Y3R4LT53c2l6ZSA9IHNl
cnZlci0+b3BzLT5uZWdvdGlhdGVfd3NpemUodGNvbiwgY3R4KTsKKwkgICAgKGNpZnNfc2ItPmN0
eC0+d3NpemUgPiBzZXJ2ZXItPm9wcy0+bmVnb3RpYXRlX3dzaXplKHRjb24sIGN0eCkpKSB7CisJ
CWNpZnNfc2ItPmN0eC0+d3NpemUgPQorCQkJcm91bmRfZG93bihzZXJ2ZXItPm9wcy0+bmVnb3Rp
YXRlX3dzaXplKHRjb24sIGN0eCksIFBBR0VfU0laRSk7CisJCS8qCisJCSAqIGluIHRoZSB2ZXJ5
IHVubGlrZWx5IGV2ZW50IHRoYXQgdGhlIHNlcnZlciBzZW50IGEgbWF4IHdyaXRlIHNpemUgdW5k
ZXIgUEFHRV9TSVpFLAorCQkgKiAod2hpY2ggd291bGQgZ2V0IHJvdW5kZWQgZG93biB0byAwKSB0
aGVuIHJlc2V0IHdzaXplIHRvIGFic29sdXRlIG1pbmltdW0gZWcgNDA5NgorCQkgKi8KKwkJaWYg
KGNpZnNfc2ItPmN0eC0+d3NpemUgPT0gMCkgeworCQkJY2lmc19zYi0+Y3R4LT53c2l6ZSA9IFBB
R0VfU0laRTsKKwkJCWNpZnNfZGJnKFZGUywgIndzaXplIHRvbyBzbWFsbCwgcmVzZXQgdG8gbWlu
aW11bSBpZSBQQUdFX1NJWkUsIHVzdWFsbHkgNDA5NlxuIik7CisJCX0KKwl9CiAJaWYgKChjaWZz
X3NiLT5jdHgtPnJzaXplID09IDApIHx8CiAJICAgIChjaWZzX3NiLT5jdHgtPnJzaXplID4gc2Vy
dmVyLT5vcHMtPm5lZ290aWF0ZV9yc2l6ZSh0Y29uLCBjdHgpKSkKIAkJY2lmc19zYi0+Y3R4LT5y
c2l6ZSA9IHNlcnZlci0+b3BzLT5uZWdvdGlhdGVfcnNpemUodGNvbiwgY3R4KTsKZGlmZiAtLWdp
dCBhL2ZzL3NtYi9jbGllbnQvZnNfY29udGV4dC5jIGIvZnMvc21iL2NsaWVudC9mc19jb250ZXh0
LmMKaW5kZXggYWVjOGRiZDFmOWRiLi4xNDQxOTE1NGNiMzMgMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9j
bGllbnQvZnNfY29udGV4dC5jCisrKyBiL2ZzL3NtYi9jbGllbnQvZnNfY29udGV4dC5jCkBAIC0x
MTExLDYgKzExMTEsMTcgQEAgc3RhdGljIGludCBzbWIzX2ZzX2NvbnRleHRfcGFyc2VfcGFyYW0o
c3RydWN0IGZzX2NvbnRleHQgKmZjLAogCWNhc2UgT3B0X3dzaXplOgogCQljdHgtPndzaXplID0g
cmVzdWx0LnVpbnRfMzI7CiAJCWN0eC0+Z290X3dzaXplID0gdHJ1ZTsKKwkJaWYgKHJvdW5kX2Rv
d24oY3R4LT53c2l6ZSwgUEFHRV9TSVpFKSAhPSBjdHgtPndzaXplKSB7CisJCQljdHgtPndzaXpl
ID0gcm91bmRfZG93bihjdHgtPndzaXplLCBQQUdFX1NJWkUpOworCQkJaWYgKGN0eC0+d3NpemUg
PT0gMCkgeworCQkJCWN0eC0+d3NpemUgPSBQQUdFX1NJWkU7CisJCQkJY2lmc19kYmcoVkZTLCAi
d3NpemUgdG9vIHNtYWxsLCByZXNldCB0byBtaW5pbXVtICVsZFxuIiwgUEFHRV9TSVpFKTsKKwkJ
CX0gZWxzZSB7CisJCQkJY2lmc19kYmcoVkZTLAorCQkJCQkgIndzaXplIHJvdW5kZWQgZG93biB0
byAlZCB0byBtdWx0aXBsZSBvZiBQQUdFX1NJWkUgJWxkXG4iLAorCQkJCQkgY3R4LT53c2l6ZSwg
UEFHRV9TSVpFKTsKKwkJCX0KKwkJfQogCQlicmVhazsKIAljYXNlIE9wdF9hY3JlZ21heDoKIAkJ
Y3R4LT5hY3JlZ21heCA9IEhaICogcmVzdWx0LnVpbnRfMzI7CmRpZmYgLS1naXQgYS9mcy9zbWIv
Y2xpZW50L2ZzX2NvbnRleHQuaCBiL2ZzL3NtYi9jbGllbnQvZnNfY29udGV4dC5oCmluZGV4IDE4
MmNlMTFjYmU5My4uZjgwNjA2OWZjYWUzIDEwMDY0NAotLS0gYS9mcy9zbWIvY2xpZW50L2ZzX2Nv
bnRleHQuaAorKysgYi9mcy9zbWIvY2xpZW50L2ZzX2NvbnRleHQuaApAQCAtMTY2LDcgKzE2Niw2
IEBAIHN0cnVjdCBzbWIzX2ZzX2NvbnRleHQgewogCWJvb2wgZ290X3dzaXplOwogCWJvb2wgZ290
X2JzaXplOwogCXVuc2lnbmVkIHNob3J0IHBvcnQ7Ci0KIAljaGFyICp1c2VybmFtZTsKIAljaGFy
ICpwYXNzd29yZDsKIAljaGFyICpkb21haW5uYW1lOwotLSAKMi40MC4xCgo=
--000000000000abaa62061166a0dd--

