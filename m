Return-Path: <linux-fsdevel+bounces-67269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C72ADC39CB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 10:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4BD89350151
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 09:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC5330BF6E;
	Thu,  6 Nov 2025 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHCf6eJc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9C830B519
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762421001; cv=none; b=ftK9iAbPNMMOc+zoeLFuO4AtYt+DtynVjwKKmh80t4YtACMw7PFu54HZAj+v8glp5JTiMHeeaBh0ZFhZ0wvT87SCWLNI0jx0oTq+7zlTrN57COWx5jSrdAywKO4HR9kjS29+boh6Ra42Z7+A9j1W+C0tWqGdtYoBb2pUfUc8W2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762421001; c=relaxed/simple;
	bh=Xx2goxP07Ev6XJrC+lInY39ZwnU/1SAfj6bly3//d04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/tzsE4y/kQRm4uPPer7vyrBBE9E+/RQn0s8xiumgADRDAUpIWFe+X9uOhrt32ZR2uMsqu51/df+Uby6VxSpdYQoQT506snM0UlblLOzAOXi1OcmBFtYxCRkjd3dbCDWJlBPIZRcAs5mTMW9KTOysGFgetbjIG3jqaNeSoYpQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHCf6eJc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640f0f82da9so1244016a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 01:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762420998; x=1763025798; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gyHf382iB6Vu/4cvvmbK0M9rXdxTzal+EE70kvjPdpA=;
        b=NHCf6eJcr0L/UzpieW7xrbvDzfc2WifzM7CZe02EX1vG83rlmZx7AixNUdlZjEnYha
         /DbMSjXDKY+BwN3/MHuDAmV5y/mNqb//dlBYJZN2/HJjaoefP9+9uCxKqe7vvvWGHOTJ
         zQs5saX1KqbYXDIFi+Q6J6cG8SWV4ta1lv/A8OHZ8L9DKr9qTKz+4V6tRNJ4BHzEJSM0
         DB98/Fr4E0lFDKsPdJrYPsjyzXCqU+l7QDYEPK6ofdNUEuBA4H58CkbB81ZvZoraaU7z
         3XTdyvfPaQGg3A1IfEOLYq5aOg4kqjOE5qBuG2oHZ1BthcE9vzm+OXK3gbEGRPn8uqQw
         Z3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762420998; x=1763025798;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gyHf382iB6Vu/4cvvmbK0M9rXdxTzal+EE70kvjPdpA=;
        b=jfG6Jg2SmZsT1Z1Yt0gecYx78IKLBukMS7/MGwWpXVS/+8GUr2dWehUJzV+oQ33M6b
         iS+Kg+7HYteiHPZVCsDg/2+N1qYWRi+cIeQvTXV7XW0x0zDEBFAEtYWAZ94BX3rqCLZd
         gxGx7RxRtjVqtoPo8AaIuw1XD4io7n29nuxAB1uHaopuspt55FMzxrqt++qW/K1+TQKA
         DhjVlqBP90a0yUPFzLWUz3za0ThtD7jN1ojnm/R7KIG9ussmNQlGRFykWoVFIGH7Fk4E
         nVYtWs2dhbQMGZwkDArgnlmRdRvV24lQAS2qV80Z8+tXsBK2UxOrn3PRKS0N65WDPNOJ
         WT0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWX1tkEEc0SreJ84tjFV+q2f5Hfl6C1lMJcl10//gp0SHbxSE4NH32F5zuyszVjm6VEQRNfRAEgAJtKkkH1@vger.kernel.org
X-Gm-Message-State: AOJu0YwayMr+VJRrDTlFBoqOzhj5C9zijp8CjSb/go3Yh4UtTJv9xub8
	w5W90iLTxm3mSTWfgUl707wXTYTH3KQP2mExGWf9HnFNG/b422rQpIBwD7djebI9IMNdmJNdBAc
	+kEkB0PcO0WeIHybX+l5s8pugIVU7T8PwOmMrxbI=
X-Gm-Gg: ASbGncvZhdQIAVlR1Fzf0aUDoJKXkzc91XsKRBeqPDW3AMYRavlWeVdriUhY16yO6hq
	9ZkqqqeV8DWhbJMAWwGztLBYLEzeBwXItqIxbR0YhmXFaXDN8rKA8UdWuOAVxHG6Rc8c7UlQM8J
	kHS6xlAnibSFxEWrst4f93Zx0mOErZZQGo/sqM7nCHkWG0qHEcadSen3wqiYGmwUFTM4AD3AiEq
	NpMBbcbzfaXJ6Zoyj6jiumKq7EZKTTIXMG8VTJJRzNyCJWm+TaHdYQmZG/BLI15ruLA/j2LWYhR
	LeINnz6AocMBQg6Cxks=
X-Google-Smtp-Source: AGHT+IGoqlY0H9bN6kflnCnpfZ1SeA3J+m46Gr7/ZpMgeH+MMnt78aDZtzIjWuufnNUX4YlGm/ee2052ryyV7rBBdgY=
X-Received: by 2002:a05:6402:5107:b0:640:a7bc:30d3 with SMTP id
 4fb4d7f45d1cf-64105a579fbmr5534462a12.27.1762420997390; Thu, 06 Nov 2025
 01:23:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
 <176169820388.1433624.12333256574549591904.stgit@frogsfrogsfrogs>
 <aQNNZ6lxeMntTifa@amir-ThinkPad-T480> <20251105231228.GG196358@frogsfrogsfrogs>
In-Reply-To: <20251105231228.GG196358@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 6 Nov 2025 10:23:04 +0100
X-Gm-Features: AWmQ_bkFfr2QWpjytnKZXPYVdXPuOOKUsZ7eWSiLQV4mMAXXwLamXIlq03E7Svw
Message-ID: <CAOQ4uxhQt6LNo7QaN3rWy3eCeAS9r0xNcMW4ZvdrY5YgMbq66g@mail.gmail.com>
Subject: Re: [PATCH 22/33] generic/631: don't run test if we can't mount overlayfs
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	joannelkoong@gmail.com, bernd@bsbernd.com
Content-Type: multipart/mixed; boundary="0000000000007ebfec0642e99dee"

--0000000000007ebfec0642e99dee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 12:12=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Thu, Oct 30, 2025 at 12:35:03PM +0100, Amir Goldstein wrote:
> > On Tue, Oct 28, 2025 at 06:26:09PM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > This test fails on fuse2fs with the following:
> > >
> > > +mount: /opt/merged0: wrong fs type, bad option, bad superblock on ov=
erlay, missing codepage or helper program, or other error.
> > > +       dmesg(1) may have more information after failed mount system =
call.
> > >
> > > dmesg logs the following:
> > >
> > > [  764.775172] overlayfs: upper fs does not support tmpfile.
> > > [  764.777707] overlayfs: upper fs does not support RENAME_WHITEOUT.
> > >
> > > From this, it's pretty clear why the test fails -- overlayfs checks t=
hat
> > > the upper filesystem (fuse2fs) supports RENAME_WHITEOUT and O_TMPFILE=
.
> > > fuse2fs doesn't support either of these, so the mount fails and then =
the
> > > test goes wild.
> > >
> > > Instead of doing that, let's do an initial test mount with the same
> > > options as the workers, and _notrun if that first mount doesn't succe=
ed.
> > >
> > > Fixes: 210089cfa00315 ("generic: test a deadlock in xfs_rename when w=
hiteing out files")
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  tests/generic/631 |   22 ++++++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> > >
> > >
> > > diff --git a/tests/generic/631 b/tests/generic/631
> > > index 72bf85e30bdd4b..64e2f911fdd10e 100755
> > > --- a/tests/generic/631
> > > +++ b/tests/generic/631
> > > @@ -64,6 +64,26 @@ stop_workers() {
> > >     done
> > >  }
> > >
> > > +require_overlayfs() {
> > > +   local tag=3D"check"
> > > +   local mergedir=3D"$SCRATCH_MNT/merged$tag"
> > > +   local l=3D"lowerdir=3D$SCRATCH_MNT/lowerdir:$SCRATCH_MNT/lowerdir=
1"
> > > +   local u=3D"upperdir=3D$SCRATCH_MNT/upperdir$tag"
> > > +   local w=3D"workdir=3D$SCRATCH_MNT/workdir$tag"
> > > +   local i=3D"index=3Doff"
> > > +
> > > +   rm -rf $SCRATCH_MNT/merged$tag
> > > +   rm -rf $SCRATCH_MNT/upperdir$tag
> > > +   rm -rf $SCRATCH_MNT/workdir$tag
> > > +   mkdir $SCRATCH_MNT/merged$tag
> > > +   mkdir $SCRATCH_MNT/workdir$tag
> > > +   mkdir $SCRATCH_MNT/upperdir$tag
> > > +
> > > +   _mount -t overlay overlay -o "$l,$u,$w,$i" $mergedir || \
> > > +           _notrun "cannot mount overlayfs"
> > > +   umount $mergedir
> > > +}
> > > +
> > >  worker() {
> > >     local tag=3D"$1"
> > >     local mergedir=3D"$SCRATCH_MNT/merged$tag"
> > > @@ -91,6 +111,8 @@ worker() {
> > >     rm -f $SCRATCH_MNT/workers/$tag
> > >  }
> > >
> > > +require_overlayfs
> > > +
> > >  for i in $(seq 0 $((4 + LOAD_FACTOR)) ); do
> > >     worker $i &
> > >  done
> > >
> >
> > I agree in general, but please consider this (untested) cleaner patch
>
> Yes, this works too.  Since this is your code, could you send it to the
> list with a proper commit message (or even just copy mine) and then I
> can ack it?
>

Attached.
Now it's even tested.

I put you down as Suggested-by.
Feel free to choose your own roles...

Thanks,
Amir.

--0000000000007ebfec0642e99dee
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-generic-631-don-t-run-test-if-we-can-t-mount-overlay.patch"
Content-Disposition: attachment; 
	filename="0001-generic-631-don-t-run-test-if-we-can-t-mount-overlay.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mhn7wkkk0>
X-Attachment-Id: f_mhn7wkkk0

RnJvbSBkYzMxMzUyZDZjOTI2ZTBmNmRhNjIzOGVjY2JjYWE5NmIxZmI4OWMyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBUaHUsIDMwIE9jdCAyMDI1IDEyOjI0OjIxICswMTAwClN1YmplY3Q6IFtQQVRDSF0gZ2Vu
ZXJpYy82MzE6IGRvbid0IHJ1biB0ZXN0IGlmIHdlIGNhbid0IG1vdW50IG92ZXJsYXlmcwoKVGhp
cyB0ZXN0IGZhaWxzIG9uIGZ1c2UyZnMgd2l0aCB0aGUgZm9sbG93aW5nOgoKbW91bnQ6IC9vcHQv
bWVyZ2VkMDogd3JvbmcgZnMgdHlwZSwgYmFkIG9wdGlvbiwgYmFkIHN1cGVyYmxvY2sgb24gb3Zl
cmxheSwKICAgICAgIG1pc3NpbmcgY29kZXBhZ2Ugb3IgaGVscGVyIHByb2dyYW0sIG9yIG90aGVy
IGVycm9yLgogICAgICAgZG1lc2coMSkgbWF5IGhhdmUgbW9yZSBpbmZvcm1hdGlvbiBhZnRlciBm
YWlsZWQgbW91bnQgc3lzdGVtIGNhbGwuCgpkbWVzZyBsb2dzIHRoZSBmb2xsb3dpbmc6CgpbICA3
NjQuNzc1MTcyXSBvdmVybGF5ZnM6IHVwcGVyIGZzIGRvZXMgbm90IHN1cHBvcnQgdG1wZmlsZS4K
WyAgNzY0Ljc3NzcwN10gb3ZlcmxheWZzOiB1cHBlciBmcyBkb2VzIG5vdCBzdXBwb3J0IFJFTkFN
RV9XSElURU9VVC4KCkZyb20gdGhpcywgaXQncyBwcmV0dHkgY2xlYXIgd2h5IHRoZSB0ZXN0IGZh
aWxzIC0tIG92ZXJsYXlmcyBjaGVja3MgdGhhdAp0aGUgdXBwZXIgZmlsZXN5c3RlbSAoZnVzZTJm
cykgc3VwcG9ydHMgUkVOQU1FX1dISVRFT1VUIGFuZCBPX1RNUEZJTEUuCmZ1c2UyZnMgZG9lc24n
dCBzdXBwb3J0IGVpdGhlciBvZiB0aGVzZSwgc28gdGhlIG1vdW50IGZhaWxzIGFuZCB0aGVuIHRo
ZQp0ZXN0IGdvZXMgd2lsZC4KCkluc3RlYWQgb2YgZG9pbmcgdGhhdCwgbGV0J3MgZG8gYW4gaW5p
dGlhbCB0ZXN0IG1vdW50IHdpdGggdGhlIHNhbWUKb3B0aW9ucyBhcyB0aGUgd29ya2VycywgYW5k
IF9ub3RydW4gaWYgdGhhdCBmaXJzdCBtb3VudCBkb2Vzbid0IHN1Y2NlZWQuCgpGaXhlczogMjEw
MDg5Y2ZhMDAzMTUgKCJnZW5lcmljOiB0ZXN0IGEgZGVhZGxvY2sgaW4geGZzX3JlbmFtZSB3aGVu
IHdoaXRlaW5nIG91dCBmaWxlcyIpClN1Z2dlc3RlZC1ieTogIkRhcnJpY2sgSi4gV29uZyIgPGRq
d29uZ0BrZXJuZWwub3JnPgpTaWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxA
Z21haWwuY29tPgotLS0KIHRlc3RzL2dlbmVyaWMvNjMxIHwgMzkgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwg
MTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMvZ2VuZXJpYy82MzEgYi90ZXN0cy9n
ZW5lcmljLzYzMQppbmRleCBjMzhhYjc3MS4uN2RjMzM1YWEgMTAwNzU1Ci0tLSBhL3Rlc3RzL2dl
bmVyaWMvNjMxCisrKyBiL3Rlc3RzL2dlbmVyaWMvNjMxCkBAIC00Niw3ICs0Niw2IEBAIF9yZXF1
aXJlX2V4dHJhX2ZzIG92ZXJsYXkKIAogX3NjcmF0Y2hfbWtmcyA+PiAkc2VxcmVzLmZ1bGwKIF9z
Y3JhdGNoX21vdW50Ci1fc3VwcG9ydHNfZmlsZXR5cGUgJFNDUkFUQ0hfTU5UIHx8IF9ub3RydW4g
Im92ZXJsYXlmcyB0ZXN0IHJlcXVpcmVzIGRfdHlwZSIKIAogbWtkaXIgJFNDUkFUQ0hfTU5UL2xv
d2VyZGlyCiBta2RpciAkU0NSQVRDSF9NTlQvbG93ZXJkaXIxCkBAIC02NCw3ICs2Myw3IEBAIHN0
b3Bfd29ya2VycygpIHsKIAlkb25lCiB9CiAKLXdvcmtlcigpIHsKK21vdW50X292ZXJsYXkoKSB7
CiAJbG9jYWwgdGFnPSIkMSIKIAlsb2NhbCBtZXJnZWRpcj0iJFNDUkFUQ0hfTU5UL21lcmdlZCR0
YWciCiAJbG9jYWwgbD0ibG93ZXJkaXI9JFNDUkFUQ0hfTU5UL2xvd2VyZGlyOiRTQ1JBVENIX01O
VC9sb3dlcmRpcjEiCkBAIC03MiwyNSArNzEsNDMgQEAgd29ya2VyKCkgewogCWxvY2FsIHc9Indv
cmtkaXI9JFNDUkFUQ0hfTU5UL3dvcmtkaXIkdGFnIgogCWxvY2FsIGk9ImluZGV4PW9mZiIKIAor
CXJtIC1yZiAkU0NSQVRDSF9NTlQvbWVyZ2VkJHRhZworCXJtIC1yZiAkU0NSQVRDSF9NTlQvdXBw
ZXJkaXIkdGFnCisJcm0gLXJmICRTQ1JBVENIX01OVC93b3JrZGlyJHRhZworCW1rZGlyICRTQ1JB
VENIX01OVC9tZXJnZWQkdGFnCisJbWtkaXIgJFNDUkFUQ0hfTU5UL3dvcmtkaXIkdGFnCisJbWtk
aXIgJFNDUkFUQ0hfTU5UL3VwcGVyZGlyJHRhZworCisJbW91bnQgLXQgb3ZlcmxheSBvdmVybGF5
IC1vICIkbCwkdSwkdywkaSIgIiRtZXJnZWRpciIKK30KKwordW5tb3VudF9vdmVybGF5KCkgewor
CWxvY2FsIHRhZz0iJDEiCisJbG9jYWwgbWVyZ2VkaXI9IiRTQ1JBVENIX01OVC9tZXJnZWQkdGFn
IgorCisJX3VubW91bnQgJG1lcmdlZGlyCit9CisKK3dvcmtlcigpIHsKKwlsb2NhbCB0YWc9IiQx
IgorCWxvY2FsIG1lcmdlZGlyPSIkU0NSQVRDSF9NTlQvbWVyZ2VkJHRhZyIKKwogCXRvdWNoICRT
Q1JBVENIX01OVC93b3JrZXJzLyR0YWcKIAl3aGlsZSB0ZXN0IC1lICRTQ1JBVENIX01OVC9ydW5u
aW5nOyBkbwotCQlybSAtcmYgJFNDUkFUQ0hfTU5UL21lcmdlZCR0YWcKLQkJcm0gLXJmICRTQ1JB
VENIX01OVC91cHBlcmRpciR0YWcKLQkJcm0gLXJmICRTQ1JBVENIX01OVC93b3JrZGlyJHRhZwot
CQlta2RpciAkU0NSQVRDSF9NTlQvbWVyZ2VkJHRhZwotCQlta2RpciAkU0NSQVRDSF9NTlQvd29y
a2RpciR0YWcKLQkJbWtkaXIgJFNDUkFUQ0hfTU5UL3VwcGVyZGlyJHRhZwotCi0JCW1vdW50IC10
IG92ZXJsYXkgb3ZlcmxheSAtbyAiJGwsJHUsJHcsJGkiICRtZXJnZWRpcgorCQltb3VudF9vdmVy
bGF5ICR0YWcKIAkJbXYgJG1lcmdlZGlyL2V0Yy9hY2Nlc3MuY29uZiAkbWVyZ2VkaXIvZXRjL2Fj
Y2Vzcy5jb25mLmJhawogCQl0b3VjaCAkbWVyZ2VkaXIvZXRjL2FjY2Vzcy5jb25mCiAJCW12ICRt
ZXJnZWRpci9ldGMvYWNjZXNzLmNvbmYgJG1lcmdlZGlyL2V0Yy9hY2Nlc3MuY29uZi5iYWsKIAkJ
dG91Y2ggJG1lcmdlZGlyL2V0Yy9hY2Nlc3MuY29uZgotCQlfdW5tb3VudCAkbWVyZ2VkaXIKKwkJ
dW5tb3VudF9vdmVybGF5ICR0YWcKIAlkb25lCiAJcm0gLWYgJFNDUkFUQ0hfTU5UL3dvcmtlcnMv
JHRhZwogfQogCittb3VudF9vdmVybGF5IGNoZWNrIHx8IFwKKwlfbm90cnVuICJjYW5ub3QgbW91
bnQgb3ZlcmxheWZzIHdpdGggdW5kZXJseWluZyBmaWxlc3lzdGVtICRGU1RZUCIKK3VubW91bnRf
b3ZlcmxheSBjaGVjaworCiBmb3IgaSBpbiAkKHNlcSAwICQoKDQgKyBMT0FEX0ZBQ1RPUikpICk7
IGRvCiAJd29ya2VyICRpICYKIGRvbmUKLS0gCjIuNTEuMQoK
--0000000000007ebfec0642e99dee--

