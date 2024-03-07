Return-Path: <linux-fsdevel+bounces-13843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8A6874A27
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 09:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6A61C23047
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 08:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D66B82885;
	Thu,  7 Mar 2024 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YI0NlZgH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7F38286B;
	Thu,  7 Mar 2024 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709801681; cv=none; b=jneWf50enohDA+YwcNZ2rLi7QT7+7dLPPMMDGfs3B9/bvx9FAkU3vePDZ/alTFbeJ1owvbA2kMSIfaNQlTw6lSPipYBxtQwLaUX4XJAMkdVhD39AdxH17w8GAtM9kjrtdOyRimP4jbVT7qq59SFZn1ywQ8BUf/6Q3y7sk9TXqvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709801681; c=relaxed/simple;
	bh=warou/4ZoeVQCOXsoBqQxozGmPUsOzd0YrxkN4n/fHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyyA31EbThqpx0H2rLkyPDghT8/b64WzLFWsz5OfHV6b0KBULgNeISIZMpBbiGPcwYclmTmceSMT4Me5zS/cupIYNN08Xjk8txN29x2QYJKN0Q1v2Ays97juQMUWl7W4GS3ZDmJKjfI4EUWwjwksFOZT4UVXfydrPZmVzbtOXZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YI0NlZgH; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6087d1355fcso4605307b3.0;
        Thu, 07 Mar 2024 00:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709801679; x=1710406479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=warou/4ZoeVQCOXsoBqQxozGmPUsOzd0YrxkN4n/fHM=;
        b=YI0NlZgHbW9uB6SmchlLfO744xUUHbvuvpphawHIIV2zdPR7NJcVDye1fILDTxhasR
         SCoC9k2vYWN6sg1fnH96w//jQROwzCDhMUGtrmVG1HeyJsrHW4ITfXKRBhv95kL4giUw
         YnhWUSC5BCUSjggIeDu5UY47jJBB13KCvUiZWdUvils+/IyGALoapiAsxJz0/ySfvsH4
         JGsGx6sSiJpFbGsWo6ESzYHXoiwhUIcrzOESdhl5HlCijdZ8YEIrwvS0jf0xvxypflQB
         +14oqO9RGME4CKixao8pbEiCeS0J7Xox1DpTelwQjNlZxVGZeiWgd48rPx/rF6+2GYBh
         EtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709801679; x=1710406479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=warou/4ZoeVQCOXsoBqQxozGmPUsOzd0YrxkN4n/fHM=;
        b=ghOJ8uEfmdEYhOJYPIonsbuzqt9xzra2BS8Pf1HKRFLobJbTTpbihUxPv3Wibe5I5w
         HIzVyk7YVocq9GXHDFP4bs+CzDCsfKOdKjcyAk/q/cpfO628Xgt+rzvMuC02LlaIlQSa
         h326xcXHHCM2K59ThRfP9e7iz6+ixtKG1oHu8gGk+cWRfQnG/EBdnhBQfgZUdkiBfMsP
         2iwFhpNFExkc3tfi4qzIM1nlUlC+7dCOpJAqoea0KpYwEpUAlPBm6yb7CAIsxwi8O4gc
         DrLSkHWh0pARv0UJqdPbpG0IL3TRyzDlYoHUf0MY4f7mKK/O88ZnNVZQtiI7e5aG+mYd
         YFoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7IW4lsHGf0/nQ3Daod3Zfa8BJXk5/aBojsFDutPGD2VvRPcp3As+X3Bgc/Am83c+WNpNW+XmLVwkcag7IW93yqC6llKIW6uDDpKBNOyjsypHcOL+9n9FcSVsFXBwQgwf0fpGth/8elHY=
X-Gm-Message-State: AOJu0YwKnO2rGL/ValKOfYXwRVjsRkOlILRrupRfAzUBf5U3ku+TFL/8
	/4m3bDhxkaIyvkJyE5hV4K9SQOiY1fNMe0q5+FuP1rwwLiCqLZQf0L4ZttSaD4L5pYWN7/9GtY/
	6jHMxT4B1nYhxZrbdJbonUak7GXI=
X-Google-Smtp-Source: AGHT+IE241cAoDN15OyIXUS5digLbXgrYwMzfGXNtu8QARD6JyLJrI9undleI4uAurSPNG65KUkWowLfKbhiTafIOYk=
X-Received: by 2002:a05:690c:fd6:b0:608:d2fe:14ab with SMTP id
 dg22-20020a05690c0fd600b00608d2fe14abmr20192411ywb.5.1709801679105; Thu, 07
 Mar 2024 00:54:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5mutAn2G3eC7yRByF5YeCMokzo=Br0AdVRrre0AqRRmTEQ@mail.gmail.com>
In-Reply-To: <CAH2r5mutAn2G3eC7yRByF5YeCMokzo=Br0AdVRrre0AqRRmTEQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 7 Mar 2024 10:54:27 +0200
Message-ID: <CAOQ4uxg8YbaYVU1ns5BMtbW8b0Wd8_k=eFWj7o36SkZ5Lokhpg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] statx attributes
To: Steve French <smfrench@gmail.com>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>, CIFS <linux-cifs@vger.kernel.org>, 
	samba-technical <samba-technical@lists.samba.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 7:36=E2=80=AFAM Steve French <smfrench@gmail.com> wr=
ote:
>
> Following up on a discussion a few years ago about missing STATX
> attributes, I noticed a case recently where some tools on other OS
> have an option to skip offline files (e.g. the Windows equivalent of
> grep, "findstr", and some Mac tools also seem to do this).
>

Which API is used in other OS to query the offline bit?
Do they use SMB specific API, as Windows does?

> This reminded me that there are a few additional STATX attribute flags
> that could be helpful beyond the 8 that are currently defined (e.g.
> STATX_ATTR_COMPRESSED, STATX_ATTR_ENCRYPTED, STATX_ATTR_NO_DUMP,
> STATX_ATTR_VERITY) and that it be worthwhile revisiting which
> additional STATX attribute flags would be most useful.

I agree that it would be interesting to talk about new STATX_ attributes,
but it should already be covered by this talk:
https://lore.kernel.org/linux-fsdevel/2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqc=
biavjyiis6prl@yjm725bizncq/

We have a recent example of what I see as a good process of
introducing new STATX_ attributes:
https://lore.kernel.org/linux-fsdevel/20240302220203.623614-1-kent.overstre=
et@linux.dev/
1. Kent needed stx_subvol_id for bcachefs, so he proposed a patch
2. The minimum required bikeshedding on the name ;)
3. Buy in by at least one other filesystem (btrfs)

w.r.t attributes that only serve one filesystem, certainly a requirement fr=
om
general purpose userspace tools will go a long way to help when introducing
new attributes such as STATX_ATTR_OFFLINE, so if you get userspace
projects to request this functionality I think you should be good to go.

>
> "offline" could be helpful for fuse and cifs.ko and probably multiple
> fs to be able to report,

I am not sure why you think that "offline" will be useful to fuse?
Is there any other network fs that already has the concept of "offline"
attribute?

> but there are likely other examples that could help various filesystems.

Maybe interesting for network fs that are integrated with fscache/netfs?
It may be useful for netfs to be able to raise the STATX_ATTR_OFFLINE
attribute for a certain cached file in some scenarios?

As a developer of HSM API [1], where files on any fs could have an
"offline" status,
STATX_ATTR_OFFLINE is interesting to me, but only if local disk fs
will map it to
persistent inode flags.

When I get to it, I may pick a victim local fs and write a patch for it.

Thanks,
Amir.

[1] https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Storage-Ma=
nagement-API

