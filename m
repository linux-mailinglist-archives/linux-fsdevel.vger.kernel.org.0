Return-Path: <linux-fsdevel+bounces-13921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10678757D6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 21:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1001EB23F0E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 20:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD86137C54;
	Thu,  7 Mar 2024 20:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxkTT/A5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB5312DDB6;
	Thu,  7 Mar 2024 20:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841842; cv=none; b=u7y6bem4TJ7W8BUQVyr0rJh0ScLKDgFYmEx2PJ7Z7w8D406HQZRbHImHpbIDNS/k5njGummi/LCO+p4bo2hyjj1+RvFsNUyL+mqagE+OaRc754h2ifZgCjOoIY0zmsMfPuR8BooOHdoRmYt8kshH9p3gduOPxUs0QdNWAhGWgfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841842; c=relaxed/simple;
	bh=bFGaOL7CsGWWQ3ESPYsyOYEUh8ZB4xpnCbVUp1CivDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKO0/FUf/apsb/9Kzxsa2VXOedjFgipkLN4+C0ZDe1AMmDnZkTmtS4s0cwrkhBNDhlOaRxDvzo55+Mt4qitMkEkuXl2HBYZzzHc2ya9IEbGiNuHS5+L+VoW1JNlsEjVlkdqvyDmhQgxzZOUeHOVPbMs7p0m2V9JlBSKZ4O2IXlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxkTT/A5; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d3b93e992aso845891fa.1;
        Thu, 07 Mar 2024 12:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709841839; x=1710446639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3AdFgaBRFiwWtav38oyxf2w+fmQE2Ye/PD5BoJP0Q0=;
        b=HxkTT/A5IUYiptgODrIPWsQv/FtvZ2kYxG3e7wRjuUYHWHqXGz3AUZrqBZPz6uEvi7
         grz5l2h6GzOKt5NrdSugglh//dADnz9sIVR4mPBRJ+z5GkGCjnGJoFglnGW1Vux3KBYc
         mDhLRwxQqlp2bVNZG1xeQA5HUCpaeisnT9+bc10dRMF51zXOx434+qcvfJ62MzJwTnx+
         PGLMk1cRJtzsaZj+evRTWlFGXQ3B5kYa5hgnqtpNhmvyfobO06BtPumzZ4tI64qPYPTq
         y2T77DouP9suTvrNaoOJ6eB4J5NOEBRAK4PJVMXjod3TjCb9prCqv850kE/8kXy9L+Dt
         jSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709841839; x=1710446639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3AdFgaBRFiwWtav38oyxf2w+fmQE2Ye/PD5BoJP0Q0=;
        b=osrCCpbqoL/GJVOH567kJ9bkZ5RVXYM2ZmHr2mfJfuoxBUCDPNDb6TAK26SRYyt903
         0xMuK22uetxVmL6/8+yeLbYDtmb+7vZvKNEyiRYeYXP+59PEITxjhrGIKJGAtUlE6hlQ
         DGwSgaleJnQoNFN/Q0m46gucYzpgzrmtmyqmgsNnj9TNc8cWiU4LsngCuk4r/gWlDz5m
         U19/f67w5MkGypptagMth2500XxpgDUVoWsZC4O/61VKO9iOGt1BxDIKBc1n/rMGBT+R
         uCUIepPHXD1ifbUl19ZETUsM5vEc/MUiGrhsKNe0cQo9Zuv2ewo0B8mEg0fHRcAGfDjT
         v9HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS67nuWWqXuS7FEJk8+T+V8i6+44Ivzw95LtatLbkn3SyREaEupHVtDRyANYSoF7+m6Sph5jDKo+MMQCFt/G3XRX+GKkGRdvrxgyAdMNKO/O5NOa0sdEIuwLiikqYZ+lqcXSO32/UYQLA=
X-Gm-Message-State: AOJu0YwKDL4nasrouFdTnt6eOf+J1R1LmbeZxA2hSXUlUubUZrnqcrJZ
	HvNhetjlVx6OgACf+YnJp8FEIQdKu4M02g7ZSd+hxl1/4QZjsWChBdsysUn8qoDbi3VNmpNZjkc
	hFV1jm0/whTurN2r3nMYnC0r6syw=
X-Google-Smtp-Source: AGHT+IGfavhueNtP7xow4zNB7u0dZSEHD2R1a0/Gm2T/Fnh7eQfE1Bl5R+agVylZLwcVfqFX/T/DQv5CFvPlI7quFyM=
X-Received: by 2002:a2e:b282:0:b0:2d3:f3fe:48ac with SMTP id
 2-20020a2eb282000000b002d3f3fe48acmr1934371ljx.27.1709841838435; Thu, 07 Mar
 2024 12:03:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5mutAn2G3eC7yRByF5YeCMokzo=Br0AdVRrre0AqRRmTEQ@mail.gmail.com>
 <CAOQ4uxg8YbaYVU1ns5BMtbW8b0Wd8_k=eFWj7o36SkZ5Lokhpg@mail.gmail.com>
 <CAH2r5msvgB19yQsxJtTCeZN+1np3TGkSPnQvgu_C=VyyhT=_6Q@mail.gmail.com> <nbqjigckee7m3b5btquetn3wfj3bzcirm75jwnbmhjyxyqximr@ouyqocmrjmfa>
In-Reply-To: <nbqjigckee7m3b5btquetn3wfj3bzcirm75jwnbmhjyxyqximr@ouyqocmrjmfa>
From: Steve French <smfrench@gmail.com>
Date: Thu, 7 Mar 2024 14:03:46 -0600
Message-ID: <CAH2r5mt_FY=9Dg6_K1+gYMAKuyPAPO0yRZ9hKcLkyypmUjxQZA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] statx attributes
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Amir Goldstein <amir73il@gmail.com>, lsf-pc <lsf-pc@lists.linux-foundation.org>, 
	CIFS <linux-cifs@vger.kernel.org>, 
	samba-technical <samba-technical@lists.samba.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 11:45=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, Mar 07, 2024 at 10:37:13AM -0600, Steve French wrote:
> > > Which API is used in other OS to query the offline bit?
> > > Do they use SMB specific API, as Windows does?
> >
> > No it is not smb specific - a local fs can also report this.  It is
> > included in the attribute bits for files and directories, it also
> > includes a few additional bits that are used by HSM software on local
> > drives (e.g. FILE_ATTRIBUTE_PINNED when the file may not be taken
> > offline by HSM software)
> > ATTRIBUTE_HIDDEN
> > ATTRIBUTE_SYSTEM
> > ATTRIBUTE_DIRECTORY
> > ATTRIGBUTE_ARCHIVE
> > ATTRIBUTE_TEMPORARY
> > ATTRIBUTE_SPARSE_FILE
> > ATTRIBUTE_REPARE_POINT
> > ATTRIBUTE_COMPRESSED
> > ATTRIBUTE_NOT_CONTENT_INDEXED
> > ATTRIBUTE_ENCRYPTED
> > ATTRIBUTE_OFFLINE
>
> we've already got some of these as inode flags available with the
> getflags ioctl (compressed, also perhaps encrypted?) - but statx does
> seem a better place for them.
>
> statx can also report when they're supported, which does make sense for
> these.
>
> ATTRIBUTE_DIRECTORY, though?
>
> we also need to try to define the semantics for these and not just dump
> them in as just a bunch of identifiers if we want them to be used by
> other things - and we do.

They are all pretty clearly defined, but many are already in Linux,
and a few are not relevant (e.g. ATTRIBUTE_DIRECTORY is handled in
mode bits).  I suspect that Macs have equivalents of most of these
too.


--=20
Thanks,

Steve

